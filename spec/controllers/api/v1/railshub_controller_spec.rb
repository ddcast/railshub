require 'spec_helper'
require 'pry-byebug'

describe Api::V1::RailshubController do
  describe '#issues' do
    let(:default_params) do
      { format: :json }
    end

    let(:params) { default_params }

    subject do
      get :issues, params: { by_component: nil, by_comment_count: nil }
      response
    end

    context 'when user requests issues without params' do
      let(:issue) { create(:issue) }

      let!(:issues_response) { stub_list_issues(1) }

      it { is_expected.to match_response_schema('issues') }

      its(:status) { is_expected.to eq(200) }

      its(:body) { is_expected.to include_json(data: []) }
    end

    context 'when user requests issues with params' do
      let(:issue) { create(:issue) }

      let!(:issues_response) { stub_list_issues(1) }

      let(:params) {
        default_params.merge({
          by_component: ['activerecord'],
          by_comment_count: true
        })
      }

      it { is_expected.to match_response_schema('issues') }

      its(:status) { is_expected.to eq(200) }

      its(:body) { is_expected.to include_json(data: []) }
    end
  end
end
