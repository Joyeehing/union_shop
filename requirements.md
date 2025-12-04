# Requirements Document — Union Shop features 

This document lists clear descriptions, user stories, and acceptance criteria for each feature from the provided prompt. Each feature is a separate subtask.

---

## Subtask 1 — Static Homepage
Description
- Mobile-first landing screen with hero, featured collections/products and promotional sections. Data may be hardcoded for initial implementation.

User stories
- As a shopper, I want to see featured products and collections on the homepage so I can quickly find items.
- As a shopper, I want the hero and promo sections to be visually prominent so I notice offers.
- As a user, I want tapping the logo to return me to the homepage.

Acceptance criteria
- [x] Homepage displays a hero area, at least three featured product cards, at least two featured collection tiles, and one promotional banner.
- [x] Tapping a featured product opens the product page route.
- [x] Tapping a collection tile opens the collection page route.
- [x] Tapping the navbar logo navigates to the homepage.
- [x] Page scrolls normally and layout is optimized for small widths (mobile).

---

## Subtask 2 — Static Navbar
Description
- Top navigation bar with brand/logo, menu icon, and primary links. Links may be stubs initially.

User stories
- As a user, I want to open a menu from the navbar so I can navigate to other pages.
- As a user, I want tapping a navbar link to navigate to the indicated page or a stub.

Acceptance criteria
- [x] Navbar shows logo, menu icon and at least three link targets (Home, Collections, Cart or Account).
- [x] Tapping the menu icon opens a side-drawer or dropdown containing the same links.
- [x] Tapping a navbar link navigates to a matching route (real or stub).
- [x] Navbar remains visible and usable on mobile view.

---

## Subtask 3 — About Us Page
Description
- Static informational page with organisation description, contact pointers and optional image.

User stories
- As a visitor, I want to read about the shop so I can understand the organisation.
- As a user, I want to navigate back after viewing the page.

Acceptance criteria
- [x] About page accessible via navbar or footer link.
- [x] Page contains heading, at least two paragraphs of text.
- [x] Back navigation returns to the previous route as click any button at the Navbar or footer.

---

## Subtask 4 — Footer
Description
- Footer component containing dummy links (contact, social, legal) visible on at least one page.

User stories
- As a user, I want quick access to contact and legal links from the footer.
- As a user, I expect external links to open in a browser tab.

Acceptance criteria
- [x] Footer included on the homepage (minimum).
- [x] Footer displays at least three links: Contact, Privacy/Terms, Social.
- [x] Internal links navigate to their routes; external links open a new browser tab/window.

---

## Subtask 5 — Dummy Collections Page
Description
- Grid/list of collection cards showing image, title and item count. Hardcoded data allowed.

User stories
- As a shopper, I want to browse collections to find groups of related products.
- As a shopper, I want to open a collection to see its products.

Acceptance criteria
- [x] Collections page lists at least 6 collections with image, title and item count.
- [x] Tapping a collection card navigates to the corresponding collection page route.
- [x] Optional sort/filter controls may be visible (may be non-functional for basic implementation).

---

## Subtask 6 — Dummy Collection Page
Description
- Product listing for a specific collection, with product cards, optional dropdowns and filter controls.

User stories
- As a shopper, I want to view products inside a collection.
- As a shopper, I want to tap a product to view details.

Acceptance criteria
- [x] Collection page displays a grid/list of at least 8 product cards (hardcoded ok).
- [x] Product card includes thumbnail image, title and price.
- [x] Tapping a product card opens its product page route.
- [ ] Filter/sort UI may be present and must reflect selected state even if not changing results.

---

## Subtask 7 — Dummy Product Page
Description
- Product detail view showing images, title, description, price, variant dropdowns (size/color) and add-to-cart button (hardcoded acceptable).

User stories
- As a shopper, I want to view product details and choose variants and quantity.
- As a shopper, I want confirmation when I add an item to the cart.

Acceptance criteria
- [x] Product page shows image carousel or single image, title, description and visible price.
- [ ] Variant selectors (at least size or color) are present and update selected state when changed.
- [ ] Quantity selector updates displayed quantity.
- [ ] Tapping "Add to Cart" shows an acknowledgement (snack/toast/dialog). Persistence optional for basic.

---

## Subtask 8 — Sale Collection
Description
- Collection page that highlights discounted products with both original (struck-through) and sale prices, plus promotional messaging.

User stories
- As a shopper, I want to identify sale items quickly.
- As a shopper, I want to view product details for sale items.

Acceptance criteria
- [x] Sale collection page displays promotional banner and list of sale items.
- [x] Each sale product shows original price struck-through and sale price.
- [x] Tapping a product navigates to product page.
- [x] Tapping the promotional banner either filters to sale items or opens the sale collection.

---

## Subtask 9 — Authentication UI (Basic)
Description
- Login and signup screens with form fields and client-side validation (no backend required for basic implementation).

User stories
- As a user, I want to enter credentials to sign in or sign up.
- As a user, I want to see validation messages for invalid input.

Acceptance criteria
- [x] Login and Signup screens accessible via navbar links.
- [x] Forms validate required fields and email format before submission.
- [x] Submitting valid inputs shows a success state or navigates to a stub account page.
- [x] Invalid inputs show inline validation errors.

---

## Subtask 10 — Navigation (Intermediate)
Description
- Full navigation across pages using navbar, buttons and URL routes; supports browser back/forward.

User stories
- As a web user, I want to use the browser URL to land on specific pages.
- As a user, I want the back button to return to the previous page.

Acceptance criteria
- [x] All main pages have addressable routes (e.g., /, /collections, /product/:id).
- [x] Navigating via in-app links updates the browser URL.
- [ ] Reloading a route loads the expected page (web).
- [ ] Browser/device back and forward work correctly.

---

## Subtask 11 — Dynamic Collections Page
Description
- Collections populated from a data model or mock service with working sort, filter and pagination or infinite scroll.

User stories
- As a shopper, I want collections populated from data rather than hardcoded.
- As a shopper, I want to change sort and filter to refine results.

Acceptance criteria
- [ ] Collections loaded from a service layer (local mock or in-memory); no hardcoded UI-only lists.
- [ ] Changing sort/filter triggers a visible update to the displayed collections.
- [ ] Pagination or infinite scroll loads additional data when reaching end of list.

---

## Subtask 12 — Dynamic Collection Page
Description
- Collection product lists driven by models/services supporting filters and pagination; query params reflect state.

User stories
- As a shopper, I want collection product lists to be dynamically generated.
- As a shopper, I want filters to update the URL so I can share filtered views.

Acceptance criteria
- [ ] Collection page requests product list from the service layer and renders results.
- [ ] Applying filters updates page results and the browser URL query parameters.
- [ ] Tapping a product navigates to its dynamic product route.

---

## Subtask 13 — Functional Product Pages
Description
- Product pages populated from models/services with variant selection, quantity control and add-to-cart that updates cart model (cart persistence optional at this stage).

User stories
- As a shopper, I want variant selection to update availability/price on the product page.
- As a shopper, I want adding a product to update the cart count.

Acceptance criteria
- [ ] Product page obtains product data from the model/service.
- [ ] Selecting a variant updates displayed attributes (price/availability) in the UI.
- [ ] Add-to-cart updates an in-memory cart model and the cart icon badge count.

---

## Subtask 14 — Shopping Cart
Description
- Cart page showing items, quantities, line totals, subtotal, and simulated checkout flow.

User stories
- As a shopper, I want to review items in my cart and update quantities.
- As a shopper, I want to remove items and see totals recalc immediately.

Acceptance criteria
- [ ] Cart page lists added items with image, title, unit price, quantity control and line total.
- [ ] Changing quantity updates the line total and cart subtotal immediately.
- [ ] Removing an item deletes it from the cart and updates totals.
- [ ] Checkout button triggers a simulated confirmation page or dialog and clears the cart for simulation.

---

## Subtask 15 — Print Shack (Text Personalisation)
Description
- Product personalization page with live preview that updates as the user edits text, font, color, and placement options.

User stories
- As a customer, I want a live preview of personalized text so I can confirm design before ordering.
- As a customer, I want personalization options to show/hide based on chosen features.

Acceptance criteria
- [ ] Personalization form includes at least: text input, font selector, color selector, and position controls.
- [ ] Changing any option updates a live preview instantly.
- [ ] Toggling options shows/hides dependent fields.
- [ ] Submitting personalization attaches the chosen options to the product selection/state.

---

## Subtask 16 — Responsiveness
Description
- Adaptive layout that works on mobile and desktop; UI components reflow and adjust paddings and grid columns.

User stories
- As a desktop user, I want grid layouts to expand for wider screens.
- As a mobile user, I want touch-friendly controls and single-column layout.

Acceptance criteria
- [x] Layout adapts at common breakpoints (e.g., mobile < 600px, tablet 600–1024px, desktop > 1024px).
- [x] Product grids change number of columns according to width.
- [x] Navbar switches between mobile hamburger and full horizontal menu appropriately.
- [x] All interactive elements remain accessible and usable at each breakpoint.

---

## Subtask 17 — Authentication System (Advanced)
Description
- Full authentication with sign-up, sign-in, password reset and account dashboard using a persistent auth provider (e.g., Firebase).

User stories
- As a registered user, I want to sign in and have my session persist across reloads.
- As an authenticated user, I want protected routes (account, order history) accessible only when signed in.
- As a user, I want to reset my password via an email flow.

Acceptance criteria
- [ ] Integration with a persistent auth service (documented and configured).
- [ ] Successful sign-up creates a persistent user account and automatically signs the user in.
- [ ] Session persists across page reloads and browser restarts (per provider guarantees).
- [ ] Protected routes redirect unauthenticated users to the sign-in page.
- [ ] Password reset flow triggers a provider email action and shows appropriate UI feedback.

---

## Subtask 18 — Cart Management (Advanced)
Description
- Full cart lifecycle with persistent storage, accurate calculations (tax/shipping/discounts) and order creation.

User stories
- As a shopper, I want my cart to persist between sessions.
- As a shopper, I want to see tax and shipping calculations and apply discount codes.
- As a shopper, I want an order record after completing checkout.

Acceptance criteria
- [ ] Cart persisted using local storage or backend; restores on app start.
- [ ] Totals calculation includes configurable tax and shipping logic and supports discounts.
- [ ] Checkout creates an order record in persistent storage (mock DB or real service) and clears the cart.
- [ ] Suitable error handling and user feedback for failures.

---

## Subtask 19 — Search System (Advanced)
Description
- Search bar (navbar and footer) with live suggestions, autocomplete and a results page supporting filters and pagination.

User stories
- As a shopper, I want instant search suggestions while typing.
- As a shopper, I want to submit a search and see paged results I can filter and sort.

Acceptance criteria
- [ ] Typing in the search input shows live suggestions (client-side or via service).
- [ ] Submitting search navigates to a results route showing matching products/collections.
- [ ] Results page supports sorting, filtering, and pagination; tapping a result navigates to the item page.
- [ ] Search state is reflected in the URL for sharing/bookmarking.

---

Notes on implementation priorities
- Basic subtasks (Static Homepage, Navbar, About, Footer, Dummy pages, Product page, Sale, Auth UI) are minimum for early marks.
- Intermediate subtasks require a data/service layer for dynamic data and routing.
- Advanced subtasks require external services or persistent local storage and additional integration work.

Use these acceptance criteria as deterministic, testable checks for unit and widget tests.