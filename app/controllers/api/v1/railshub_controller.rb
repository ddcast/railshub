class Api::V1::RailshubController < Api::V1::ApiController

  def index
    render json: {
      message: 'Carry on, nothing to see here.'
    }
  end

  def issues
    if params[:by_component].present?
      components = params[:by_component].split(',')
      components.map {|component|
        component if Railshub::IssueUpdater::COMPONENT_LABELS.include?(component)
      }.reject(&:empty?)
    else
      components = Railshub::IssueUpdater::COMPONENT_LABELS
    end

    data = Issue.includes(:components).where(components: { name: components })
    data = data.order('comments DESC') if params[:by_comment_count] == 'true'

    data = data.to_a.map do |item|
      item.as_json(include: [:components])
    end

    render json: {
      data: data
    }
  end

  def components
    components = Railshub::IssueUpdater::COMPONENT_LABELS

    render json: {
      data: components
    }
  end
end
