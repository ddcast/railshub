import $ from 'jquery';
import homeModule from './base';

homeModule.controller('HomeCtrl', HomeCtrl);

function HomeCtrl(RailshubService) {
  const ctrl = this;

  ctrl.issues = [];
  ctrl.byComponent = {};
  ctrl.byCommentCount = false;
  ctrl.username = 'friend';

  ctrl.updateView = updateView;

  updateView();

  function updateView() {
    var params = getParams();

    // Load issues
    RailshubService.issues(params).then(function(response) {
      ctrl.issues = response.data;
      ctrl.issues = ctrl.issues.map(function(issue) {
        issue.components = issue.components.map(function(component) {
          return component.name;
        }).join(', ');

        return issue;
      });
    });
  }

  // Load components
  RailshubService.components().then(function(response) {
    ctrl.components = response.data;
    
    response.data.forEach(function(component) {
      ctrl.byComponent[component] = false;
    });
  });

  function getParams() {
    return {
      byComponent: getComponentFilter().join(','),
      byCommentCount: ctrl.byCommentCount
    };
  }

  function getComponentFilter() {
    var result = [];

    for (var component in ctrl.byComponent) {
      if (ctrl.byComponent[component]) {
        result.push(component);
      }
    }

    return result;
  }
}
