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
		 | repo      | OK     |

	Scenario: Store a thing
		Given that ThingSafe is up
		When I PUT a thing with a title of "MyThing"
		Then the response code should be 200

	Scenario: Retrieve a thing
		Given that I store a thing just now
		When I GET my things
		Then I the API should return a thing with a title of "MyThing"	
