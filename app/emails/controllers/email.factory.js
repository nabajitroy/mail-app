app.factory("emailsFactory", function($http,$q, $window  ){
 
    var factory = {};
 
    // read all products
    factory.readEmails = function($scope){
        return $http({
            method: 'GET',
            url: 'http://localhost/mail-app/api/emails/read.php?email='+$scope.session.userEmail
        });
    };
	
	// read all spam
    factory.readSpamEmails = function($scope){
        return $http({
            method: 'GET',
            url: 'http://localhost/mail-app/api/emails/spam.php?email='+$scope.session.userEmail
        });
    };
    // read all products
    factory.sentEmails = function($scope){
        return $http({
            method: 'GET',
            url: 'http://localhost/mail-app/api/emails/sent.php?email='+$scope.session.userEmail
        });
    }; 
    
	factory.trashEmails = function($scope){
        return $http({
            method: 'GET',
            url: 'http://localhost/mail-app/api/emails/trash.php?email='+$scope.session.userEmail
        });
    }; 
	
	factory.deleteEmails = function($id){
        return $http({
        method: 'POST',
        data: {
            'id' : $id,
			'action': 'delete'
         },
           url: 'http://localhost/mail-app/api/emails/action.php'
       });
    };
	
	factory.spamEmails = function($id){
        return $http({
        method: 'POST',
        data: {
            'id' : $id,
			'action': 'spam'
         },
           url: 'http://localhost/mail-app/api/emails/action.php'
       });
    };
	// create email
factory.createEmail = function($scope){
 
    return $http({
        method: 'POST',
        data: {
            'to' : $scope.to,
            'from' : $scope.session.userEmail,
            'subject' : $scope.subject,
            'body' : $scope.body,
            'read' : 0,
            'parent_id' : 'NULL'
        },
        url: 'http://localhost/mail-app/api/emails/create.php'
    });
};



factory.replayEmail = function($scope,$stateParams ){
 console.log(JSON.stringify($scope.body));
    return $http({
        method: 'POST',
        data: {
            'to' : $scope.to,
            'from' : $scope.session.userEmail,
            'subject' : $scope.subject,
            'body' : $scope.body,
            'parent_id' : $scope.parent_id,
            'read' : 0
        },
        url: 'http://localhost/mail-app/api/emails/create.php'
    });
};


 
// readOneProduct will be here

factory.readOneEmail = function($stateParams){
	//console.log("here for factory" + JSON.stringify($stateParams.id));
        return $http({
            method: 'GET',
            url: 'http://localhost/mail-app/api/emails/readone.php?id='+$stateParams.id +'&parent_id='+$stateParams.parentid
        });
    };


factory.logout = function() {
		  console.log("Logging you out boss");
		  var deferred = $q.defer();
         $window.sessionStorage["userInfo"] = null;
		 userInfo = null;
		 deferred.resolve(userInfo);
		 
		  console.log(JSON.stringify(userInfo));
		 /* $http({
			method: "POST",
			url: logoutUrl,
			headers: {
			  "access_token": userInfo.accessToken
			}
		  }).then(function(result) {
			$window.sessionStorage["userInfo"] = null;
			userInfo = null;
			deferred.resolve(result);
		  }, function(error) {
			deferred.reject(error);
		  });*/

		  return deferred.promise;
		};




     
    return factory;
});