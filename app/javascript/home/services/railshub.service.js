import servicesModule from './base';

servicesModule.service('RailshubService', RailshubService);

function RailshubService($resource) {
  const basePath = '/api/v1/railshub';

  const issuesResource = $resource(basePath + '/issues', {}, {
    query: {
      method: 'GET'
    }
  });

  const componentsResource = $resource(basePath + '/components', {}, {
    query: {
      method: 'GET'
    }
  });

  const service = {
    issues: (filter) => {
      filter = filter || {};

      return issuesResource.query({
        by_component: filter.byComponent,
        by_comment_count: filter.byCommentCount
      }).$promise;
    },
    components: () => {
      return componentsResource.query({}).$promise;
    }
  };

  return service;
}
