### LLM Prompt: Feature descriptions & expected user interactions

For each feature below, implement UI + behaviour. Description explains purpose; "When user..." lists specific expected outcomes.

### Basic

## Static Homepage  
  - Description: Mobile-focused landing screen with hero, featured collections/products and promotional sections (static/hardcoded acceptable).  
  - When user taps a featured product → open product page. When taps a collection tile → open that collection page. When taps navbar logo → return home. Scroll behaves normally.

## Static Navbar  
  - Description: Top navigation bar with brand, menu icon and primary links (links may be placeholders initially).  
  - When user taps menu icon → open side or dropdown menu showing links. When tapping a navbar link → navigate to the corresponding page or route (can be stub route).

## About Us Page  
  - Description: Static page with organisation info, contact pointers and basic image/text content.  
  - When user navigates to About → content is displayed. No network calls required. Back navigation returns to previous page.

## Footer  
  - Description: Page footer with dummy links (contact, social, legal) visible on at least one page.  
  - When user taps a footer link → navigate to the appropriate internal page or open external link (external links open in new tab / browser).

## Dummy Collections Page  
  - Description: Grid/list of collection cards (hardcoded data acceptable) showing collection image, title and item count.  
  - When user taps a collection card → open the related collection page. Sorting/filter UI can be present but may be non-functional for basic marks.

## Dummy Collection Page  
  - Description: Product listing for a single collection with product cards, dropdowns and filter controls (widgets may be non-functional for basic marks).  
  - When user taps a product card → open product page. When user uses a filter/sort control (if implemented) → UI reflects selection; for basic variant, filter may be visual-only.

## Dummy Product Page  
  - Description: Product detail view showing images, title, description, price, variant dropdowns (size/color) and add-to-cart button (hardcoded acceptable).  
  - When user selects a variant → selected variant updates UI (label/selected state). When user increases quantity → quantity UI updates. Tapping Add to Cart may show toast/dialog confirming addition (actual cart persistence optional for basic).

## Sale Collection  
  - Description: Collection page highlighting discounted products with original and sale prices and promotional messaging.  
  - When user views product with discount → both original (struck-through) and sale price shown. Tapping product → open product page; tapping promotional banner → filter to sale items or open sale collection.

## Authentication UI  
  - Description: Login/signup screens with forms and validation UI (no backend required for basic).  
  - When user enters invalid data → show inline validation errors. When user submits valid form → show success state or navigate to stub account page.

---

### Intermediate

## Navigation
  - Description: Full navigation across pages via navbar, buttons and deep links/URLs.  
  - When user uses in-app links or browser URL → app navigates to matching route. Back button (device/browser) returns to previous route. Routes should be addressable (web).

## Dynamic Collections Page  
  - Description: Collections populated from data models/services (local or mock service) with working sort/filter/pagination UI.  
  - When user changes sort/filter → listing updates based on model logic. When user reaches end of list → next page loads (pagination) or infinite scroll fetches more items.

## Dynamic Collection Page  
  - Description: Collection-specific product listing driven by data models/services with functioning filters and pagination.  
  - When user applies filters (category/price/etc.) → list updates and URL/query params update. Tapping a product navigates to dynamic product route.

## Functional Product Pages  
  - Description: Product pages populated from models/services with functioning variant selection and quantity control (add-to-cart button need not complete checkout).  
  - When user selects variant → price/availability updates accordingly. When user taps Add to Cart → item is added to cart model and visible in cart icon/badge.

## Shopping Cart  
  - Description: Cart page showing items, quantities, subtotal, taxes and checkout button (checkout may be simulated).  
  - When user adds item → cart count increments and item appears in cart. In cart, editing quantity updates line total and overall totals; removing item deletes it. Checkout button triggers an order confirmation flow (simulated).

## Print Shack (Text personalisation)  
  - Description: Product personalization page with form fields that dynamically update a live preview (e.g., text, font, color, placement).  
  - When user edits text/options → preview updates instantly. When user toggles personalization options → form fields show/hide accordingly. When user submits personalization → selected options are attached to the product/checkout line.

## Responsiveness  
  - Description: Adaptive layouts that work on mobile and wider (desktop) screens; mobile-first but adjust columns/paddings on larger widths.  
  - When viewport width changes → UI adapts: grids expand, navbar may change to full horizontal menu, product cards reflow. Functional features remain accessible on all sizes.

---

### Advanced

## Authentication System 
  - Description: Full auth with sign-up, sign-in, password reset and account dashboard, backed by persistent auth service (e.g., Firebase).  
  - When user signs up → account created and persisted; user is logged in and redirected to dashboard. When user signs in → session persists across reloads. When user signs out → session cleared and redirected to public pages. Protected routes require auth and redirect unauthenticated users to sign-in.

## Cart Management 
  - Description: Full cart lifecycle: add/edit/remove, persistent storage (local or backend), price calculations (tax, shipping, discounts) and order creation.  
  - When user changes quantity → totals recalc immediately. Cart persists between sessions. When user completes checkout → order record created and cart cleared; user receives confirmation.

## Search System 
  - Description: Search input in navbar and footer that queries product/collection data and returns paged results with filters and suggestions.  
  - When user types → show live suggestions/autocomplete. When user submits search → show results page with matching products/collections and allow sorting/filtering. Tapping a result navigates to the item page.

---

Use these descriptions as precise acceptance criteria to implement components, routes and model/service behavior. Keep UI feedback and navigation deterministic and testable (unit/widget tests for each user action).