/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'derry-dark': '#0a0a0a',
        'derry-charcoal': '#1a1a1a',
        'derry-blood': '#8b0000',
        'derry-red': '#dc143c',
        'derry-paper': '#f4f1e8',
        'derry-aged': '#e8dcc4',
      },
      fontFamily: {
        'typewriter': ['Courier New', 'monospace'],
        'vintage': ['Georgia', 'serif'],
      },
      backgroundImage: {
        'paper-texture': "url('data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22300%22%3E%3Cfilter id=%22noise%22%3E%3CfeTurbulence type=%22fractalNoise%22 baseFrequency=%220.9%22 numOctaves=%224%22 /%3E%3CfeColorMatrix type=%22saturate%22 values=%220%22/%3E%3C/filter%3E%3Crect width=%22100%25%22 height=%22100%25%22 filter=%22url(%23noise)%22 opacity=%220.05%22/%3E%3C/svg%3E')",
      },
    },
  },
  plugins: [],
}
