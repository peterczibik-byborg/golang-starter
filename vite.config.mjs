import { defineConfig } from 'vite';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  plugins: [
    tailwindcss(),
  ],
  build: {
    outDir: 'static',
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: 'src/index.css',
        index: 'src/index.js',
      },
      output: {
        assetFileNames: '[name].[ext]',
        entryFileNames: '[name].js',
      },
    },
  },
});
