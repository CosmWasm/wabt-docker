# Polkasource WebAssembly Binary Toolkit
Polkasource Dockerfile for WebAssembly Binary Toolkit

## Building tools
Clone repository
```bash
git clone https://github.com/polkasource/webassembly-wabt.git
```

Change directory
```bash
cd webassembly-wabt
```

Check available releases
```bash
git tag
```

Checkout a particular release (v1.0.11)
```bash
git checkout v1.0.11
```

Build tools (v1.0.11)
```bash
docker build -t 'polkasource/webassembly-wabt:v1.0.11' .
```
