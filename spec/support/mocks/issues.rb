module IssuesMock

  def stub_list_issues(id)
    result = generate_issues_response(id)

    stub_request(:get, /\/issues/)
      .to_return({body: result.to_json, headers: default_headers})

    result
  end

  private

  def generate_issues_response(id, meta = true)
    data = generate_issue_object(id)

    result = {}
    result['data'] = [data]

    result.with_indifferent_access
  end

  def generate_issue_object(id, attributes = {})
    {
      'id': id,
      'title': 'My Issue',
      'created_at': 1
    }.merge(attributes)
  end

  def default_headers
    { 'Content-Type': 'application/json' }
  end
end

RSpec.configure do |config|

  config.include IssuesMock

end
