const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.json({ 
        message: 'Hello from Azure WebApp!',
        source: 'Deployed from GitHub repository' });
});

module.exports = app;

if (require.main === module) {
    app.listen(port, () => {
        console.log('Server running on port ${port}');
    });
}