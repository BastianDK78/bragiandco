import fs from 'fs/promises';
import path from 'path';

export async function readContentFile(filename: string): Promise<string> {
  const filePath = path.join(process.cwd(), 'content', filename);
  return fs.readFile(filePath, 'utf-8');
}
