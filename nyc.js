const express = require('express')
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const expressSession = require('express-session')
const csrf = require('csurf')

const { credentials } = require('./config')

const indexRouter = require('./routes/index');
const chaptersRouter = require('./routes/chapters');
const locationsRouter = require('./routes/locations');
const postsRouter = require('./routes/posts');
const quotesRouter = require('./routes/quotes');

const app = express()
const port = 3000


app.use(bodyParser.urlencoded({ extended: true }))
app.use(cookieParser(credentials.cookieSecret));
app.use(expressSession({
  secret: credentials.cookieSecret,
  resave: false,
  saveUninitialized: false,
  cookie: { maxAge: 30 * 24 * 60 * 60 * 1000 } 
}));


app.use(csrf({ cookie: true }))
app.use((req, res, next) => {
  res.locals._csrfToken = req.csrfToken()
  next()
})

var handlebars = require('express-handlebars').create({
  helpers: {
    eq: (v1, v2) => v1 == v2,
    ne: (v1, v2) => v1 != v2,
    lt: (v1, v2) => v1 < v2,
    gt: (v1, v2) => v1 > v2,
    lte: (v1, v2) => v1 <= v2,
    gte: (v1, v2) => v1 >= v2,
    and() {
        return Array.prototype.every.call(arguments, Boolean);
    },
    or() {
        return Array.prototype.slice.call(arguments, 0, -1).some(Boolean);
    },
    someId: (arr, id) => arr && arr.some(obj => obj.id == id),
    in: (arr, obj) => arr && arr.some(val => val == obj),
    dateStr: (v) => v && v.toLocaleDateString("en-US")
  }
});
app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');


app.use((req, res, next) => {
  res.locals.flash = req.session.flash
  delete req.session.flash
  next()
})

app.use((req, res, next) => {
  res.locals.currentUser = req.session.currentUser
  next()
})


app.use('/', indexRouter);
app.use('/chapters', chaptersRouter);
app.use('/locations', locationsRouter);
app.use('/posts', postsRouter);
app.use('/quotes', quotesRouter);



app.use((req, res) => {
  res.status(404)
  res.send('<h1>404 - Not Found</h1>')
})


app.use((err, req, res, next) => {
  console.error(err.message)
  res.type('text/plain')
  res.status(500)
  res.send('500 - Server Error')
})

app.listen(port, () => console.log(
`Express started on http://localhost:${port}; ` +
`press Ctrl-C to terminate.`))