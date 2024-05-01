const express = require('express');
const router = express.Router();
const Post = require('../models/post');


router.get('/', async (req, res) => {
  try {
    const posts = await Post.getAllPosts();
    res.json(posts);
  } catch (err) {
    console.error('Error fetching posts:', err);
    res.status(500).json({ error: 'Error fetching posts' });
  }
});


router.get('/:id', async (req, res) => {
  const postId = req.params.id;
  try {
    const post = await Post.getPostById(postId);
    if (!post) {
      res.status(404).json({ error: 'Post not found' });
    } else {
      res.json(post);
    }
  } catch (err) {
    console.error('Error fetching post:', err);
    res.status(500).json({ error: 'Error fetching post' });
  }
});


module.exports = router;
