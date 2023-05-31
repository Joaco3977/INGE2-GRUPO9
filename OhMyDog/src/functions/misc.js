
export const normalizeString = (str) => {
    return str
      .toLowerCase() // Convert string to lowercase
      .normalize("NFD") // Normalize to decomposed form
      .replace(/[\u0300-\u036f]/g, ""); // Remove accents
  }