const request = require('supertest');
const app = require('./app');

test('GET / returns hello message', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toBe(200);
    expect(response.body.message).toBe('Hello from Azure WebApp!');
});