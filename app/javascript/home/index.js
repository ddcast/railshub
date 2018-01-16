import 'angular';
import 'angular-ui-router';
import 'angular-sanitize';
import 'angular-resource';

import servicesModule from './services';

import homeModule from './home';
import headerTpl from './shared/header.html';

const dependencies = [
  homeModule.name,
  servicesModule.name,
  'ui.router'
];

angular.module('home', dependencies)
  .config(config)
  .run(run);

function config($stateProvider, $httpProvider, $urlRouterProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] =
    document.querySelector('meta[name=csrf-token]').getAttribute('content');

  $urlRouterProvider.otherwise('/');

  $stateProvider
    .state('base', {
      abstract: true,
      views: {
        'header': {
          template: headerTpl
        }
      }
    });
}

function run() {
  //
}
