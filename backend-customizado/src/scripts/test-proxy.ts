async function testProxy() {
  const ports = [5173, 5174, 5175, 5176];
  for (const port of ports) {
    try {
      const res = await fetch(`http://localhost:${port}/images/HcpWHPDC4k95yA_euGilLg.jpg`);
      const text = await res.text();
      console.log(`Port ${port} /images/HcpWHPDC4k95yA_euGilLg.jpg -> Status ${res.status} | Length ${text.length} | Is SVG? ${text.startsWith('<svg')}`);
    } catch (e: any) {
      console.log(`Port ${port} Error: ${e.message}`);
    }
  }
}

testProxy();

