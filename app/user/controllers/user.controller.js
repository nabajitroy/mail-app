
 app.controller('LoginController', [ '$scope', 'LoginService','$q','$location','$http','$window', function ($scope, LoginService,$q,$location,$http ,$window) {
  //submit
  // LoginService.init();
  $scope.formSubmit = function () {
 
  
  
  
		var encodedString = 'username=' +
			encodeURIComponent($scope.username) +
			'&password=' +
			encodeURIComponent($scope.password);

		$http({
			method: 'POST',
			url: 'http://localhost/mail-app/api/user/userauth.php',
			data: encodedString,
			headers: {'Content-Type': 'application/x-www-form-urlencoded'}
		  }).then(function(result) {
			//   console.log( "outside corrent" + console.log( JSON.stringify(result.data)))
               if ( result.data.status  === 'correct') {
					// console.log( "inside corrent")
					 LoginService.setUser(result.data ); //Update the state of the user in the app
	                  window.location.href = '/mail-app/#!/home';
	                
					  $window.location.reload();
				 	  //  $location.url('/home');
				  } else {
					$scope.errorMsg = "Username and password do not match.";
				}
           }, function(error) {
                $scope.errorMsg = "Unknown error occoured.";
        });
		
		
		 			
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    
  };
  
  
 
  
  
  
  
  
  
}])