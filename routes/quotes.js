const express = require('express');
const router = express.Router();
const Quotes = require('../models/quote'); // Adjust the path as necessary to your quotes model

// GET all quotes
router.get('/', async (req, res, next) => {
  try {
    let quotes = await Quotes.all();
    res.render('quotes/index', { title: 'All Quotes', quotes });
  } catch (error) {
    next(error);
  }
});

// GET the form for adding/editing a quote
router.get('/form', async (req, res, next) => {
  let templateVars = { title: 'Add/Edit Quote' }
  if (req.query.id) {
    try {
      let quote = await Quotes.get(req.query.id);
      if (quote) { templateVars.quote = quote; }
      res.render('quotes/form', templateVars);
    } catch (error) {
      next(error);
    }
  } else {
    res.render('quotes/form', templateVars);
  }
});

// POST/PUT quotes via upsert
router.post('/upsert', async (req, res, next) => {
  try {
    if (req.body.id) {
      await Quotes.update(req.body);
    } else {
      await Quotes.add(req.body);
    }
    req.session.flash = {
      type: 'success',
      intro: 'Quote Saved!',
      message: 'Your quote has been successfully saved.',
    };
    res.redirect('/quotes');
  } catch (error) {
    next(error);
  }
});

// GET a specific quote by ID
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

router.get('/edit', async (req, res, next) => {
  try {
    let quoteId = req.query.id; 
    if (!quoteId) {
      return res.redirect('/quotes'); 
    }

    let quote = await Quote.get(quoteId); 
    if (!quote) {
      return res.status(404).send('Quote not found'); 
    }

    res.render('quotes/form', {
      title: 'Edit Quote',
      quote: quote, 
    });
  } catch (error) {
    next(error); 
  }
});

module.exports = router;