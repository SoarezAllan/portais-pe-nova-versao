// gerenciamento_keystone/index.js

// Importa o arquivo de configuração do Keystone (keystone.ts)
const { config } = require('./keystone'); 
const { createSystem } = require('@keystone-6/core/system');
const { createExpressServer } = require('@keystone-6/core/server');

// Cria o sistema Keystone
const { keystone, graphQLSchema } = createSystem(config);

// Cria o servidor Express
const expressServer = createExpressServer(keystone, graphQLSchema);

// Exporta o servidor Express para o Vercel
module.exports = expressServer;
