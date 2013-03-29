Feature: API authentication
	In order to use the service from another app
	As a developer
	I want to be able to use the secure API by providing an OAuth token
	
	Scenario: Attempt access with invalid token
		Given that ThingSafe is up
		When I GET "http://localhost:8080/hello-world" with an invalid token
		Then the response code should be 401

	Scenario: Attempt access with valid token
		Given that ThingSafe is up
		When I GET "http://localhost:8080/hello-world" with a valid token
		Then the response code should be 200
	
