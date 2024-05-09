const express = require('express');
const router = express.Router();
const Quotes = require('../models/quote'); 


router.get('/', async (req, res, next) => {
  try {
    let quotes = await Quotes.all();
    res.render('quotes/index', { title: 'All Quotes', quotes });
  } catch (error) {
    next(error);
  }
});

router.get('/:id', async (req, res, next) => {
  try {
    let quote = await Quotes.get(req.params.id);
    if (quote) {
      res.render('quotes/form', { title: 'Quote Form', quote });
    } else {
      res.status(404).send('Quote not found');
    }
  } catch (error) {
    next(error);
  }
});

module.exports = router;