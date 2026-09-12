const fs = require('fs');
const path = require('path');

const inputPath = process.argv[2];
if (!inputPath) {
  console.error('Usage: node extract-schema.js path/to/export.sql');
  process.exit(1);
}

const sql = fs.readFileSync(inputPath, 'utf8');

const statements = sql.split(/;\s*\n/);
const schemaStatements = statements.filter((stmt) =>
  /^\s*CREATE TABLE/i.test(stmt.trim())
);

const parsed = path.parse(inputPath);
const outputPath = path.join(parsed.dir, `${parsed.name}-schema-only.sql`);
fs.writeFileSync(outputPath, schemaStatements.join(';\n\n') + ';\n');

console.log(`Extracted ${schemaStatements.length} table definitions to ${outputPath}`);