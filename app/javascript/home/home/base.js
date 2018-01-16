import homeTpl from './home.html';

const dependencies = [
  'ui.router',
  'ngSanitize'
];

export default angular.module('home.home', dependencies)
  .config(config)
  .run(run);

function config($stateProvider) {

  $stateProvider
    .state('base.home', {
      url: '/',
      views: {
        'main@': {
          controller: 'HomeCtrl as ctrl',
          template: homeTpl,
        }
      }
    })

}

function run($rootScope, $state) {
  console.log('home.home module loaded!');
}
