const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.json());

const userRoutes = require('./routes/users');
app.use('/api/users', userRoutes);

app.get('/', (req, res) => {
  res.send('Server running');
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});