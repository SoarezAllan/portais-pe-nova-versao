/** @type {import('next').NextConfig} */
const nextConfig = {
  // Desabilita o SWC e força o uso do Babel
  experimental: {
    forceSwcTransforms: false,
  },
};

module.exports = nextConfig;