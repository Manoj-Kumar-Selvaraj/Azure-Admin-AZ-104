import React, { useState } from 'react';
import './App.css';
import ProjectList from './components/ProjectList';
import PPTUpload from './components/PPTUpload';

const initialProjects = [
  {
    title: 'Cloud Automation Platform',
    description: 'Automated multi-cloud deployments using Terraform, Bicep, and CI/CD pipelines.',
    image: '/vite.svg',
  },
  {
    title: 'DevOps Dashboard',
    description: 'Real-time monitoring and analytics for cloud resources and deployments.',
    image: '/vite.svg',
  },
  // Add more initial projects here
];

function App() {
  const [projects, setProjects] = useState(initialProjects);
  const [loading, setLoading] = useState(false);

  // Infinite scroll simulation: add more projects when scrolled to bottom
  React.useEffect(() => {
    const handleScroll = () => {
      if (
        window.innerHeight + document.documentElement.scrollTop >=
        document.documentElement.offsetHeight - 100
      ) {
        if (!loading) {
          setLoading(true);
          setTimeout(() => {
            setProjects((prev) => [
              ...prev,
              {
                title: `Innovation #${prev.length + 1}`,
                description: 'Add your next cloud or DevOps achievement here with a great explanation and animation!',
                image: '/vite.svg',
              },
            ]);
            setLoading(false);
          }, 1000);
        }
      }
    };
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, [loading]);

  return (
    <div className="portfolio-app">
      <header className="portfolio-header">
        <h1>My Cloud & DevOps Innovations</h1>
        <p>Showcase your best work and attract recruiters with eye-catching explanations and smooth animations.</p>
      </header>
      <main className="portfolio-main">
        <PPTUpload />
        <ProjectList />
        {projects.map((project, idx) => (
          <div className="project-card animate-fade-in" key={idx}>
            <img src={project.image} alt={project.title} className="project-image" />
            <div className="project-info">
              <h2>{project.title}</h2>
              <p>{project.description}</p>
            </div>
          </div>
        ))}
        {loading && <div className="loading">Loading more innovations...</div>}
      </main>
      <footer className="portfolio-footer">
        <p>© {new Date().getFullYear()} Your Name | Cloud & DevOps Portfolio</p>
      </footer>
    </div>
  );
}

export default App;
