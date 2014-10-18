angular.module('myApp')
    .controller('HomeCtrl', function ($scope) {
      $scope.people = [
            {
                id: 0,
                name: 'Addison',
                present: false
            },
            {
                id: 1,
                name: 'Shane',
                present: false
            },
            {
                id: 2,
                name: 'Sei',
                present: false
            }
        ];
        $scope.newPerson = null;
        $scope.addNew = function(){
            if ($scope.newPerson != null && $scope.newPerson != "") {
                $scope.people.push({
                    id: $scope.people.length,
                    name: $scope.newPerson,
                    live: true,
                    music: []
                });
            }
        };
        $scope.markPresent = function(person){
            person.present = true;
        };
        $scope.markAbsent = function(person){
            person.present = false;
        };
    });