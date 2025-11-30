.PHONY: help up down build restart logs clean dev-backend dev-frontend test stats

help:
	@echo "Derry Missing Persons Database - Available Commands"
	@echo "=================================================="
	@echo "make up          - Start all services"
	@echo "make down        - Stop all services"
	@echo "make build       - Build all containers"
	@echo "make restart     - Restart all services"
	@echo "make logs        - View logs (all services)"
	@echo "make clean       - Remove all containers and volumes"
	@echo "make dev-backend - Run backend in development mode"
	@echo "make dev-frontend- Run frontend in development mode"
	@echo "make test        - Test API health"
	@echo "make stats       - Show database statistics"

up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose up --build -d

restart:
	docker-compose restart

logs:
	docker-compose logs -f

clean:
	docker-compose down -v
	docker system prune -f

dev-backend:
	cd backend && uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

dev-frontend:
	cd frontend && npm run dev

test:
	@echo "Testing API health..."
	@curl -s http://localhost:8000/health | python3 -m json.tool

stats:
	@echo "Database Statistics:"
	@curl -s http://localhost:8000/api/stats | python3 -m json.tool
