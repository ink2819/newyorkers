const express = require('express');
const router = express.Router();
const Chapter = require('../models/chapter'); 

router.get('/', async (req, res, next) => {
  try {
    let chapters = await Chapter.all();
    res.render('chapters/index', { title: 'New Yorkers || Chapters', chapters: chapters });
  } catch (error) {
    next(error);
  }
});

router.get('/form', async (req, res, next) => {
  let templateVars = { title: 'New Yorkers || Chapters' }
  if (req.query.id) {
    try {
      let chapter = await Chapter.get(req.query.id);
      if (chapter) { templateVars['chapter'] = chapter; }
    } catch (error) {
      next(error);
    }
  }
  res.render('chapters/form', templateVars);
});

router.get('/edit', async (req, res, next) => {
  try {
    let chapterId = req.query.id;  
    if (!chapterId) {
      return res.redirect('/chapters');  
    }

    let chapter = await Chapter.get(chapterId);  

    if (!chapter) {
      return res.status(404).send('Chapter not found'); 
    }
    res.render('chapters/form', {
      title: 'Edit Chapter',
      chapter: chapter,
    });
  } catch (error) {
    next(error);  
  }
});

router.post('/upsert', async (req, res, next) => {
  try {
    console.log('body: ' + JSON.stringify(req.body)); 
    let chapter = await Chapter.upsert(req.body);
    req.session.flash = {
      type: 'success',
      intro: 'Success!',
      message: 'The chapter has been successfully updated or added.',
    };
    res.redirect(303, '/chapters');
  } catch (error) {
    next(error);
  }
});




router.get('/show/:id', async (req, res, next) => {
  try {
    const chapter = await Chapter.get(req.params.id);
    const locationsWithQuotes = await Chapter.getLocationsWithQuotes(req.params.id);
    
    let templateVars = {
      title: 'New Yorkers || Chapters',
      chapter: chapter,
      locations: locationsWithQuotes,
    };
    
    res.render('chapters/show', templateVars);
  } catch (error) {
    next(error);
  }
});

module.exports = router;