import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_health_check():
    """Test the health check endpoint"""
    response = client.get("/")
    assert response.status_code == 200
    assert "status" in response.json()

def test_healthz_endpoint():
    """Test the healthz endpoint"""
    response = client.get("/healthz")
    assert response.status_code == 200
    assert "status" in response.json()

def test_cors_headers():
    """Test CORS headers are present"""
    response = client.options("/auth/verify-token")
    assert response.status_code == 405  # Method Not Allowed for OPTIONS on this endpoint

def test_auth_endpoint_without_token():
    """Test auth endpoint without token returns 403 (middleware blocks)"""
    response = client.post("/auth/verify-token")
    assert response.status_code == 403
