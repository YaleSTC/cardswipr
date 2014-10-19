angular
    .module('myApp', [
        'ngAnimate',
        'ui.router',
        'templates',
        'restangular'
    ])
    .config(function ($stateProvider, $urlRouterProvider, $locationProvider) {

    /**
     * Routes and States
     */
    $stateProvider
        .state('home', {
            url: '/',
            templateUrl: 'home.html',
            controller: 'HomeCtrl'
        });

    // default fall back route
    $urlRouterProvider.otherwise('/');

    // enable HTML5 Mode for SEO
    $locationProvider.html5Mode(false);
    })
    .config(function(RestangularProvider) {
        RestangularProvider.setBaseUrl('/api');
        RestangularProvider.setRequestSuffix('.json');
    });