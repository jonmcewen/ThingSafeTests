Feature: API
	In order to use the service from another app
	As a developer
	I want to be able to use an API
	
	Background:
		Given I have a valid OAth token 
	
	Scenario: Check system health
		Given that ThingSafe is up
		When I GET "http://localhost:8081/healthcheck"
		Then the response code should be 200
		And I should see the following results
                 | check     | result |
		 | deadlocks | OK     |
		 | template  | OK     |
	
