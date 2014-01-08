# Overview

## 0.1.0

### Major Changes

* support 微信公众平台 '基础支持'

* IdentityMap removed. (Arthur Neves)

* Eager load rework. Eager load now doesnt need the identity map to load
  related documents. A set of preloaders can eager load the associations
  passed to .includes method. (Arthur Neves)
