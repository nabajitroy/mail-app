 var app = angular.module('emailApp', ['ngMaterial','ui.router','ngCookies' ]);
 

app.run(["$rootScope", "$location", function($rootScope, $location) {
  $rootScope.$on("$routeChangeSuccess", function(userInfo) {
   // console.log('loged in');
   // console.log(userInfo);
  });

  $rootScope.$on("$routeChangeError", function(event, current, previous, eventObj) {
    if (eventObj.authenticated === false) {
      $location.path("/login");
    }
  });
}]);




app.config(function ($stateProvider, $urlRouterProvider ) {
 
     //$urlRouterProvider.when("", "/home");

     $stateProvider
	   .state("home", {
            url:"/home",
            templateUrl: "app/emails/views/read_email.template.html",
			 resolve: {
					auth: ["$q", "LoginService", function($q, LoginService) {
					  var userInfo = LoginService.getUserInfo();
 
					  if (userInfo) {
						  console.log("Ok I have userinfo");
						  	console.log(JSON.stringify(userInfo));
						return $q.when(userInfo);
					  } else {
						   console.log("Ok I got rejected");
						   console.log(JSON.stringify(userInfo));
						return $q.reject({ authenticated: false });
					  }
					}]
				}
        })
	 
	    
        .state("details", {
            url: "/details/:id/:parentid",
			controller: "emailsController",
            templateUrl: "app/emails/views/read_one_email.template.html",
			params: {
                 parentid: null,
                },
			resolve: {
					auth: ["$q", "LoginService", function($q, LoginService) {
					  var userInfo = LoginService.getUserInfo();
 
					  if (userInfo) {
						 return $q.when(userInfo);
					  } else {
						return $q.reject({ authenticated: false });
					  }
					}]
				}	
        })
		
		
		.state("sent", {
            url: "/sent",
			controller: "emailsController",
            templateUrl: "app/emails/views/sent_mail.template.html",
			params: {
                 parentid: null,
                },
			resolve: {
					auth: ["$q", "LoginService", function($q, LoginService) {
					  var userInfo = LoginService.getUserInfo();
					  if (userInfo) {
						return $q.when(userInfo);
					  } else {
						return $q.reject({ authenticated: false });
					  }
					}]
				}	
        })
		
		.state("trash", {
            url: "/trash",
			controller: "emailsController",
            templateUrl: "app/emails/views/trash_mail.template.html",
			params: {
                 parentid: null,
                },
			resolve: {
					auth: ["$q", "LoginService", function($q, LoginService) {
					  var userInfo = LoginService.getUserInfo();
 
					  if (userInfo) {
						return $q.when(userInfo);
					  } else {
						return $q.reject({ authenticated: false });
					  }
					}]
				}	
        })
		.state("spam", {
            url: "/spam",
			controller: "emailsController",
            templateUrl: "app/emails/views/spam_mail.template.html",
			params: {
                 parentid: null,
                },
			resolve: {
					auth: ["$q", "LoginService", function($q, LoginService) {
					  var userInfo = LoginService.getUserInfo();
 
					  if (userInfo) {
						return $q.when(userInfo);
					  } else {
						return $q.reject({ authenticated: false });
					  }
					}]
				}	
        })
		
		.state("login", {
			url : "/login",
			templateUrl : "app/user/views/login-template.html",
			controller : "LoginController"
        })
        
         
	 
		$urlRouterProvider.otherwise('/login');
		
		

		
		
		
		
});


 
 
 





 






