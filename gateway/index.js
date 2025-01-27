const { getMesh } = require("@graphql-mesh/runtime");
const { parseConfig } = require("@graphql-mesh/config");
const { createServer } = require("@graphql-mesh/http-server");

async function main() {
  // Get mesh config
  const meshConfig = await parseConfig();

  // Create mesh instance
  const { execute, subscribe, schema } = await getMesh(meshConfig);

  // Create server
  const server = await createServer({
    schema,
    execute,
    subscribe,
    context: (req) => ({ req }),
  });

  // Start server
  server.listen(4001, () => {
    console.log("🚀 Gateway running at http://localhost:4001/graphql");
  });
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
