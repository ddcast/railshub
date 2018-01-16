require 'httparty'

module Railshub
  class IssueUpdater
    # TODO: Persist as environment variables
    CACHE_EXPIRES  = 1.hour
    BASE_REMOTE_URL = 'https://api.github.com/repos/rails/rails'
    PER_PAGE = 100
    # TODO: Implement a way to specify api version in request
    # ACCEPT_HEADER = 'application/vnd.github.v3+json'

    # Constants based on potential user-supplied filters
    SORT_BY = 'comments'
    COMPONENT_LABELS = [
      'actioncable',
      'actionmailer',
      'actionpack',
      'actionview',
      'activejob',
      'activemodel',
      'activerecord',
      'activestorage',
      'activesupport',
      'assetpipeline'
    ]

    @import_count = 0

    # TODO: Create rake task to periodically poll github api endpoints.
    def self.update_from_remote(params = {}, url_override = nil)
      url = url_override ? url_override : api_path('/issues')

      reqParams = {
        filter: 'unassignee',
        state: 'open',
        per_page: PER_PAGE
      }

      reqParams[:sort] = SORT_BY if params['by_comment_count'] == true
      reqParams[:labels] = COMPONENT_LABELS.join(',') if params['by_component'] == true

      response = get(url, reqParams)
      link = response.headers['Link'] ? parse_link_header(response.headers['Link']) : {}

      data = response.parsed_response.map do |item|
        if item.is_a?(Hash)
          issue = Issue.new({
            github_id: item['id'],   
            title: item['title'],  
            comments: item['comments'], 
            created_at: item['created_at']
          })

          begin
            issue.save!
            data_import_counter(data)
            print '.'
          rescue ActiveRecord::RecordNotUnique
            print error_record_not_unique(item['id'])
          rescue => error
            print error
          end

          if issue.id && item['labels'].is_a?(Array)
            item['labels'].each do |label|
              component = Component.new({
                issue_id: issue.id,
                name: label['name']
              })

              begin
                component.save!
              rescue ActiveRecord::RecordNotUnique
                print error_record_not_unique(label['id'])
              rescue => error
                print error
              end
            end
          end

          issue.github_id.to_s
        else
          # TODO: Handle as error
          print "Unhandled error\n"

          '' # Return empty value
        end
      end

      if link[:next]
        # TODO: Delay task?
        update_from_remote({}, link[:next])
      else
        print "Finished importing #{@import_count} GitHub issues\n"
      end
    end

    private

    def self.error_record_not_unique(github_id)
      "ActiveRecord::RecordNotUnique: github_id=#{github_id}: continue\n"
    end

    def self.api_path(path)
      "#{BASE_REMOTE_URL}#{path}"
    end

    def self.get(url, params = {})
      HTTParty.get(url, query: params)
    end

    def self.parse_link_header(link_header)
      parts = link_header.split(',')
      links = {}

      parts.each do |part, index|
        sub_part     = part.split(';')
        url          = sub_part[0][/<(.*)>/, 1]
        value        = sub_part[1][/rel="(.*)"/, 1].to_sym
        links[value] = url
      end

      links
    end

    def self.data_import_counter(data)
      @import_count += data.reject(&:empty?).count
    end
  end
end
