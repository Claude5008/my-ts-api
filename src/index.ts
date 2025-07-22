// src/index.ts
import express, { Request, Response } from 'express';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to parse JSON request bodies
app.use(express.json());

// Basic route for the root URL
app.get('/', (req: Request, res: Response) => {
  res.send('Hello from the Node.js + TypeScript API!');
});

// Example API endpoint: Get all users
app.get('/api/users', (req: Request, res: Response) => {
  const users = [
    { id: 1, name: 'Alice' },
    { id: 2, name: 'Bob' },
  ];
  res.json(users);
});

// Example API endpoint: Create a new user
app.post('/api/users', (req: Request, res: Response) => {
  const newUser = req.body;
  console.log('Received new user:', newUser);
  // In a real app, you'd save this to a database
  res.status(201).json({ message: 'User created successfully', user: newUser });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});