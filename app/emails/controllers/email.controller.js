
(function() {
app.controller('emailsController', function($scope, $mdDialog,$window, $mdToast, emailsFactory,$stateParams,LoginService,$location   ){
   $scope.showActionButtons = false;
    // read emails
	$scope.session = LoginService.init();
	
	
  if($window.sessionStorage["userInfo"]){
	$scope.session =  JSON.parse($window.sessionStorage["userInfo"]);
	
  }
	
	
	
    $scope.readEmails = function(){
      
		  
        emailsFactory.readEmails($scope).then(function successCallback(response){
			LoginService.init();
			//$scope.session =  JSON.parse($window.sessionStorage["userInfo"]);
            $scope.emails = response.data.records;
			//$location.path('/home');
        }, function errorCallback(response){
            $scope.showToast("Unable to read record.");
        });
   
    }
	
	
	$scope.readSpamEmails = function(){
      
		  
        emailsFactory.readSpamEmails($scope).then(function successCallback(response){
			//LoginService.init();
			//$scope.session =  JSON.parse($window.sessionStorage["userInfo"]);
            $scope.emails = response.data.records;
			//$location.path('/home');
        }, function errorCallback(response){
            $scope.showToast("Unable to read record.");
        });
   
    }
	$scope.deleteEmails = function($id){
        // use emails factory
           emailsFactory.deleteEmails($id).then(function successCallback(response){
			$scope.readEmails();
			$scope.showToast("Email moved to trash.");
        }, function errorCallback(response){
            $scope.showToast("Unable to trash email.");
        });
    }
	
	
	  $scope.spamEmails = function($id){
        // use emails factory
        emailsFactory.spamEmails($id).then(function successCallback(response){
			$scope.readEmails();
			$scope.showToast("Email moved to trash.");
        }, function errorCallback(response){
            $scope.showToast("Unable to trash email.");
        });
    }
     
   // show 'create email form' in dialog box
$scope.showCreateEmailForm = function(event){
  
   $mdDialog.show({
        controller: DialogController,
        templateUrl: 'app/emails/views/create_email.template.html',
        parent: angular.element(document.body),
        clickOutsideToClose: true, 
        scope: $scope,
        preserveScope: true,
        fullscreen: true // Only for -xs, -sm breakpoints.
    }); 
}
 
// createProduct will be here
	
	// create new email
$scope.createEmail = function(){
     
	 //console.log(JSON.stringify($scope.session));
    emailsFactory.createEmail($scope).then(function successCallback(response){
 
        // tell the user new product was created
        $scope.showToast(response.data.message);
 
        // refresh the list
        $scope.readEmails();
 
        // close dialog
        $scope.cancel();
 
        // remove form values
        $scope.clearEmailForm();
        $scope.showToast("Mail sent.");
    }, function errorCallback(response){
        $scope.showToast("Unable to sent mail.");
    });
}
 
 
 	// create new product
$scope.replayEmail = function(){
     
	 //console.log(JSON.stringify($scope.session));
    emailsFactory.replayEmail($scope,$stateParams  ).then(function successCallback(response){
 
        // tell the user new product was created
        $scope.showToast(response.data.message);
 
        // refresh the list
        $scope.readEmails();
 
        // close dialog
      //  $scope.cancel();
 
        // remove form values
        $scope.clearEmailForm();
 
    }, function errorCallback(response){
        $scope.showToast("Unable to create record.");
    });
}
 
 // clear variable / form values
$scope.clearEmailForm = function(){
    $scope.to = "";
    $scope.subject = "";
    $scope.body = "";
    
}
 
 // show toast message
 $scope.showToast = function(message){
    $mdToast.show(
        $mdToast.simple()
            .textContent(message)
            .hideDelay(3000)
            .position("top right")
    );
}
 
 
     
    // methods for dialog box
	function DialogController($scope, $mdDialog) {
		$scope.cancel = function() {
			$mdDialog.cancel();
		};
	}
	
	
// retrieve record to fill out the form
$scope.readOneEmail = function( ){
 
    //console.log("readOneEmail" + $stateParams.parentid); // this is {}
        // use emails factory
        emailsFactory.readOneEmail($stateParams).then(function successCallback(response){
			$data =  response.data.main_record   ;
            $scope.oneEmail = response.data.replay_record;
            $scope.to = $data[0].from;
            $scope.from = $data[0].from;
            $scope.subject = $data[0].subject;
            $scope.parent_id = ($stateParams.parentid == null) ? $stateParams.id :  $stateParams.parentid;
           console.log("readOneEmail1" + $scope.parent_id); 
		// console.log($stateParams.parentid);
        }, function errorCallback(response){
            $scope.showToast("Unable to read record.");
        });
 
}
 
 $scope.logOut = function () {
     
     emailsFactory.logout();  
	 $scope.session=null;
	 $window.location.href = '/mail-app/#!/login';
  };
	
$scope.sentEmails = function(){	
	  // use emails factory
        emailsFactory.sentEmails($scope).then(function successCallback(response){
			//console.log(JSON.stringify(response)); 
			LoginService.init();
            $scope.emails = response.data.records;
        }, function errorCallback(response){
            $scope.showToast("Unable to read record.");
        });
};


$scope.trashEmails = function(){	
	  // use emails factory
        emailsFactory.trashEmails($scope).then(function successCallback(response){
			//console.log(JSON.stringify(response)); 
			LoginService.init();
            $scope.emails = response.data.records;
        }, function errorCallback(response){
            $scope.showToast("Unable to read record.");
        });
};












})
})();