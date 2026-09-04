// utils/cleanDocument.ts

const cleanText = (text: string): string => {
  if (!text) return '';
  return text
    .replace(/<!--[\s\S]*?-->/g, '')
    .replace(/^\s*(Version|StartHTML|EndHTML|StartFragment|EndFragment):\s*\d+\s*$/gim, '')
    .replace(/\b(Start|End)Fragment\b/gi, '')
    .replace(/^\s*StartFragment\s*$/gim, '')
    .replace(/^\s*EndFragment\s*$/gim, '')
    .replace(/\r\n/g, '\n')
    .replace(/\n{3,}/g, '\n\n')
    .replace(/[ \t]+$/gm, '')
    .replace(/^[ \t]+/gm, '')
    .trim()
    .replace(/(Start|End)Fragment/gi, '');
};

const cleanNode = (node: any): any => {
  if (!node) return node;
  if (node.text !== undefined) {
    return { ...node, text: cleanText(node.text) };
  }
  if (node.children && Array.isArray(node.children)) {
    return { ...node, children: node.children.map(cleanNode) };
  }
  if (typeof node === 'object') {
    const cleaned: any = {};
    for (const key of Object.keys(node)) {
      cleaned[key] = cleanNode(node[key]);
    }
    return cleaned;
  }
  return node;
};

export const cleanDocument = (value: any): any => {
  if (!value) return value;
  if (value.document && value.document.children) {
    return {
      ...value,
      document: {
        ...value.document,
        children: value.document.children.map(cleanNode),
      },
    };
  }
  if (Array.isArray(value)) {
    return value.map(cleanNode);
  }
  return cleanNode(value);
};