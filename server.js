const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;

const MIME_TYPES = {
    '.html': 'text/html',
    '.css': 'text/css',
    '.js': 'text/javascript',
    '.json': 'application/json',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.gif': 'image/gif',
    '.svg': 'image/svg+xml',
    '.ico': 'image/x-icon'
};

const server = http.createServer((req, res) => {
    let filePath = path.join(__dirname, req.url === '/' ? 'index.html' : req.url);
    let extname = String(path.extname(filePath)).toLowerCase();
    let contentType = MIME_TYPES[extname] || 'application/octet-stream';

    fs.readFile(filePath, (err, content) => {
        if (err) {
            if (err.code === 'ENOENT') {
                fs.readFile(path.join(__dirname, 'index.html'), (err404, content404) => {
                    res.writeHead(404, { 'Content-Type': 'text/html; charset=utf-8' });
                    res.end(content404 || '<h1>404 Không tìm thấy trang</h1>', 'utf-8');
                });
            } else {
                res.writeHead(500);
                res.end(`Lỗi Server: ${err.code}`);
            }
        } else {
            res.writeHead(200, { 'Content-Type': `${contentType}; charset=utf-8` });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(PORT, () => {
    console.log(`========================================`);
    console.log(`🚀 Web server đang chạy thành công!`);
    console.log(`👉 Truy cập đường dẫn: http://localhost:${PORT}`);
    console.log(`========================================`);
});
