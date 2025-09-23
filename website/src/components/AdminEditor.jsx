import React, { useState } from 'react';
import { LexicalComposer } from '@lexical/react/LexicalComposer';
import { RichTextPlugin } from '@lexical/react/LexicalRichTextPlugin';
import { ContentEditable } from '@lexical/react/LexicalContentEditable';
import { HistoryPlugin } from '@lexical/react/LexicalHistoryPlugin';
import { OnChangePlugin } from '@lexical/react/LexicalOnChangePlugin';
import { AutoFocusPlugin } from '@lexical/react/LexicalAutoFocusPlugin';
import './AdminEditor.css';

const theme = {
  // Add custom theme styles here if needed
};

function EditorToolbar() {
  return (
    <div className="editor-toolbar">
      {/* Add toolbar buttons for formatting, images, etc. */}
      <span>Toolbar (formatting, images, etc. coming soon)</span>
    </div>
  );
}

// Simple admin editor for rich content
export default function AdminEditor({ onSave }) {
  const [editorState, setEditorState] = useState(null);

  const initialConfig = {
    namespace: 'PortfolioEditor',
    theme,
    onError(error) {
      console.error(error);
    },
  };

  return (
    <div className="admin-editor">
      <h2>Edit Portfolio Content</h2>
      <LexicalComposer initialConfig={initialConfig}>
        <EditorToolbar />
        <RichTextPlugin
          contentEditable={<ContentEditable className="editor-content" />}
          placeholder={<div className="editor-placeholder">Start writing, add images, links, etc...</div>}
        />
        <HistoryPlugin />
        <AutoFocusPlugin />
        <OnChangePlugin onChange={setEditorState} />
      </LexicalComposer>
      <button onClick={() => onSave && onSave(editorState)} className="save-btn">Save Content</button>
    </div>
  );
}
