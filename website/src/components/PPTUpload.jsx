import React, { useRef, useState } from 'react';

// Simple PPT upload and preview placeholder
export default function PPTUpload() {
  const [pptName, setPptName] = useState(null);
  const fileInput = useRef();

  const handleUpload = (e) => {
    const file = e.target.files[0];
    if (file && file.name.endsWith('.ppt') || file.name.endsWith('.pptx')) {
      setPptName(file.name);
      // In a real app, upload to server or show preview
    } else {
      alert('Please upload a PPT or PPTX file.');
    }
  };

  return (
    <div className="ppt-upload">
      <h2>Upload Your PPT</h2>
      <input type="file" ref={fileInput} accept=".ppt,.pptx" onChange={handleUpload} />
      {pptName && (
        <div className="ppt-preview">
          <p>Uploaded: {pptName}</p>
          {/* Placeholder: Show preview or link to download */}
        </div>
      )}
    </div>
  );
}
