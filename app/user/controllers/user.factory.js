app.factory('LoginService', function($http, $q, $window){
var userInfo;
var deferred = $q.defer();
return{
    setUser : function(data){
       userInfo = {
        
        userName: data.full_name,
        userEmail: data.email,
        userId: data.id,
		isLogedin:true
      };
      $window.sessionStorage["userInfo"] = JSON.stringify(userInfo);
	 // $scope.session.isLogedin=true;
	//  console.log( JSON.stringify(userInfo))
	  
      deferred.resolve(userInfo);
	 // $window.location.href = '/mail-app';
	 //  return deferred.promise;
    },
    isLoggedIn : function(){
		//console.log("Hello isLoggedIn");
		  
	 
		
	 //  return(user)? user : false;
    },
	
	getUserInfo : function () {
         return userInfo;
     },
	
	init : function () {
		// $scope.session.isLogedin=true;
        if ($window.sessionStorage["userInfo"]) {
			//console.log("Hello again" );
		 	console.log("Hello from LoginService.init"  );
          userInfo = JSON.parse($window.sessionStorage["userInfo"]);
		  return userInfo;
        }
     },
	 
	 
	  

	
	
	
  }
 
})
 
   
 
  
  
 