const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.json({
    status: 'success',
    message: 'DevOps Final Project is running successfully!',
    student: 'Софія Дудкіна'
  });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
