const users = [
  { id: 1, name: "Chidera" },
  { id: 2, name: "Pamela" }
];

const getUsers = (req, res) => {
  res.json(users);
};

module.exports = { getUsers };