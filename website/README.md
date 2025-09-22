# Portfolio Website - Cloud & DevOps Innovations

This is a modern React-based portfolio website, built with Vite, showcasing your innovations in cloud and DevOps. The site is ready for deployment to an S3 bucket as a static site.

## Features

- Eye-catching, fast, and responsive design
- Sections for projects, skills, achievements, and contact
- Easy to customize and extend

## How to Deploy to S3

1. Build the site:

   ```bash
   npm run build
   ```

2. Upload the contents of the `dist/` folder to your S3 bucket.
3. Set your S3 bucket for static website hosting.

## Local Development

```bash
npm install
npm run dev
```

## Customization

- Edit `src/App.jsx` and add your own content, images, and links.
- Add new components in `src/components/` as needed.

---

This project was scaffolded using Vite and React. For more details, see [Vite documentation](https://vitejs.dev/).
