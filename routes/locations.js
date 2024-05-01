const express = require('express');
const router = express.Router();
const Location = require('../models/location'); // Assuming the model is stored under models/location
const Post = require('../models/post');

// GET all locations
router.get('/', async (req, res, next) => {
  try {
    let locations = await Location.all();
    res.render('locations/index', { title: 'New Yorkers || Locations', locations: locations });
  } catch (error) {
    next(error);
  }
});

// GET the form for adding/editing a location
router.get('/form', async (req, res, next) => {
  let templateVars = { title: 'New Yorkers || Locations' }
  if (req.query.id) {
    try {
      let location = await Location.get(req.query.id);
      if (location) {
        templateVars['location'] = location;
      }
    } catch (error) {
      next(error);
    }
  }
  res.render('locations/form', templateVars);
});

// POST or PUT a location via upsert
router.post('/upsert', async (req, res, next) => {
  try {
    console.log('body: ' + JSON.stringify(req.body)); // Logging the request body to the console
    let newLocation = await Location.upsert(req.body);
    req.session.flash = {
      type: 'success',
      intro: 'Success!',
      message: 'The location has been updated or added!',
    };
    res.redirect(303, '/locations');
  } catch (error) {
    next(error);
  }
});

router.get('/edit', async (req, res, next) => {
  try {
    let locationId = req.query.id;  
    if (!locationId) {
      return res.redirect('/locations');  
    }

    let location = await Location.get(locationId);  

    if (!location) {
      return res.status(404).send('Location not found'); 
    }
    res.render('locations/form', {
      title: 'Edit Location',
      location: location,
    });
  } catch (error) {
    next(error);  
  }
});

router.get('/show/:id', async (req, res, next) => {
  try {
      const locationId = req.params.id;
      const details = await Location.getWithDetails(locationId);
      const posts = await Post.findByLocationId(locationId); // Fetch posts related to the location

      let templateVars = {
          title: 'New Yorkers || Locations',
          location: details.location,
          chapters: details.chapters,
          posts: posts // Add posts to the template variables
      };
      
      res.render('locations/show', templateVars);
  } catch (error) {
      next(error);
  }
});

module.exports = router;

module.exports = router;