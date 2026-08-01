const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
    res.writeHead(200, {
        "Content-Type": "text/html"
    });

    res.end(`
        <h1>Welcome to Jenkins CI/CD Demo</h1>
        <h2>Hello from Node.js Application!</h2>
    `);
});

server.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});