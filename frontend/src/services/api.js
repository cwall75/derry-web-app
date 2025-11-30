import axios from 'axios';

const API_BASE_URL = import.meta.env.VITE_API_URL || '/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

export const victimApi = {
  getRandom: () => api.get('/victim/random'),
  getById: (id) => api.get(`/victim/${id}`),
  getAll: (params) => api.get('/victims', { params }),
  search: (query, params) => api.get('/search', { params: { q: query, ...params } }),
  filter: (filters) => api.get('/filter', { params: filters }),
  getStats: () => api.get('/stats'),
};

export default api;
