
image:
	docker build -t trabalho-ia .

run:
	docker-compose run app ruby run.rb 

check:
	docker-compose run app rspec
