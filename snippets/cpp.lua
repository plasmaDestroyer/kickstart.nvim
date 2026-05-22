-- ~/.config/nvim/snippets/cpp.lua
-- Algorithm Library Snippets for Competitive Programming
-- Trigger words expand via LuaSnip in cpp filetype

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {

  -- ─── 1. NUMBER THEORY ────────────────────────────────────────────────────

  -- trigger: mint
  s(
    'mint',
    {
      t {
        'template<long long MOD = 1000000007>',
        'struct ModInt {',
        '    long long v;',
        '    ModInt(long long x = 0) : v(((x % MOD) + MOD) % MOD) {}',
        '    ModInt operator+(ModInt o) const { return v + o.v >= MOD ? v + o.v - MOD : v + o.v; }',
        '    ModInt operator-(ModInt o) const { return v - o.v < 0 ? v - o.v + MOD : v - o.v; }',
        '    ModInt operator*(ModInt o) const { return v * o.v % MOD; }',
        '    ModInt operator/(ModInt o) const { return *this * o.inv(); }',
        '    ModInt& operator+=(ModInt o) { return *this = *this + o; }',
        '    ModInt& operator-=(ModInt o) { return *this = *this - o; }',
        '    ModInt& operator*=(ModInt o) { return *this = *this * o; }',
        '    ModInt& operator/=(ModInt o) { return *this = *this / o; }',
        '    bool operator==(ModInt o) const { return v == o.v; }',
        '    ModInt pow(long long e) const {',
        '        ModInt base = *this, res = 1;',
        '        for (; e > 0; e >>= 1) { if (e & 1) res *= base; base *= base; }',
        '        return res;',
        '    }',
        '    ModInt inv() const { return pow(MOD - 2); }',
        '    friend ostream& operator<<(ostream& os, ModInt m) { return os << m.v; }',
        '};',
        'using mint = ModInt<>; // default MOD = 1e9+7',
      },
    }
  ),

  -- trigger: ncr
  s(
    'ncr',
    {
      t {
        'struct Combinatorics {',
        '    int n; vector<mint> fact, inv_fact;',
        '    Combinatorics(int n) : n(n), fact(n+1), inv_fact(n+1) {',
        '        fact[0] = 1;',
        '        for (int i = 1; i <= n; i++) fact[i] = fact[i-1] * i;',
        '        inv_fact[n] = fact[n].inv();',
        '        for (int i = n-1; i >= 0; i--) inv_fact[i] = inv_fact[i+1] * (i+1);',
        '    }',
        '    mint C(int n, int k) {',
        '        if (k < 0 || k > n) return 0;',
        '        return fact[n] * inv_fact[k] * inv_fact[n-k];',
        '    }',
        '    mint P(int n, int k) { return k < 0 || k > n ? mint(0) : fact[n] * inv_fact[n-k]; }',
        '};',
        '// usage: Combinatorics C(2e6); C.C(n,k);',
      },
    }
  ),

  -- trigger: sieve
  s(
    'sieve',
    {
      t {
        'struct Sieve {',
        '    int n; vector<int> spf; vector<bool> is_prime;',
        '    Sieve(int n) : n(n), spf(n+1), is_prime(n+1, true) {',
        '        iota(spf.begin(), spf.end(), 0);',
        '        is_prime[0] = is_prime[1] = false;',
        '        for (int i = 2; i <= n; i++) {',
        '            if (is_prime[i]) {',
        '                for (int j = 2*i; j <= n; j += i) {',
        '                    is_prime[j] = false;',
        '                    if (spf[j] == j) spf[j] = i;',
        '                }',
        '            }',
        '        }',
        '    }',
        '    // O(log n) factorization',
        '    vector<pair<int,int>> factorize(int x) {',
        '        vector<pair<int,int>> res;',
        '        while (x > 1) {',
        '            int p = spf[x], cnt = 0;',
        '            while (x % p == 0) { x /= p; cnt++; }',
        '            res.push_back({p, cnt});',
        '        }',
        '        return res;',
        '    }',
        '};',
        '// usage: Sieve sv(1e7); sv.is_prime[x]; sv.factorize(x);',
      },
    }
  ),

  -- trigger: matexp
  s(
    'matexp',
    {
      t {
        'struct Matrix {',
        '    int n; vector<vector<mint>> a;',
        '    Matrix(int n) : n(n), a(n, vector<mint>(n, 0)) {}',
        '    Matrix operator*(const Matrix& o) const {',
        '        Matrix res(n);',
        '        for (int i = 0; i < n; i++)',
        '            for (int k = 0; k < n; k++) if (a[i][k].v)',
        '                for (int j = 0; j < n; j++)',
        '                    res.a[i][j] += a[i][k] * o.a[k][j];',
        '        return res;',
        '    }',
        '    static Matrix identity(int n) {',
        '        Matrix I(n);',
        '        for (int i = 0; i < n; i++) I.a[i][i] = 1;',
        '        return I;',
        '    }',
        '};',
        'Matrix matpow(Matrix m, long long e) {',
        '    Matrix res = Matrix::identity(m.n);',
        '    for (; e > 0; e >>= 1) { if (e & 1) res = res * m; m = m * m; }',
        '    return res;',
        '}',
      },
    }
  ),

  -- trigger: ntt
  s(
    'ntt',
    {
      t {
        '// NTT — MOD must be NTT-friendly (998244353 = 119*2^23+1)',
        'const int NTT_MOD = 998244353, g = 3;',
        'long long pw(long long a, long long b, long long mod) {',
        '    long long res = 1; a %= mod;',
        '    for (; b > 0; b >>= 1) { if (b & 1) res = res*a%mod; a = a*a%mod; }',
        '    return res;',
        '}',
        'void ntt(vector<long long>& a, bool inv) {',
        '    int n = a.size();',
        '    for (int i=1,j=0; i<n; i++) {',
        '        int bit = n>>1;',
        '        for (; j&bit; bit>>=1) j ^= bit;',
        '        j ^= bit; if (i<j) swap(a[i],a[j]);',
        '    }',
        '    for (int len=2; len<=n; len<<=1) {',
        '        long long w = inv ? pw(g, NTT_MOD-1-(NTT_MOD-1)/len, NTT_MOD)',
        '                         : pw(g, (NTT_MOD-1)/len, NTT_MOD);',
        '        for (int i=0; i<n; i+=len) {',
        '            long long wn = 1;',
        '            for (int j=0; j<len/2; j++, wn=wn*w%NTT_MOD) {',
        '                long long u=a[i+j], v=a[i+j+len/2]*wn%NTT_MOD;',
        '                a[i+j]=(u+v)%NTT_MOD; a[i+j+len/2]=(u-v+NTT_MOD)%NTT_MOD;',
        '            }',
        '        }',
        '    }',
        '    if (inv) { long long n_inv=pw(n,NTT_MOD-2,NTT_MOD); for (auto& x:a) x=x*n_inv%NTT_MOD; }',
        '}',
        'vector<long long> multiply(vector<long long> a, vector<long long> b) {',
        '    int result_size = a.size()+b.size()-1, n=1;',
        '    while (n < result_size) n <<= 1;',
        '    a.resize(n); b.resize(n);',
        '    ntt(a,false); ntt(b,false);',
        '    for (int i=0;i<n;i++) a[i]=a[i]*b[i]%NTT_MOD;',
        '    ntt(a,true); a.resize(result_size);',
        '    return a;',
        '}',
      },
    }
  ),

  -- ─── 2. DATA STRUCTURES ──────────────────────────────────────────────────

  -- trigger: dsu
  s(
    'dsu',
    {
      t {
        'struct DSU {',
        '    vector<int> p, sz;',
        '    int components;',
        '    DSU(int n) : p(n), sz(n, 1), components(n) { iota(p.begin(), p.end(), 0); }',
        '    int find(int x) { return p[x] == x ? x : p[x] = find(p[x]); }',
        '    bool unite(int a, int b) {',
        '        a = find(a); b = find(b);',
        '        if (a == b) return false;',
        '        if (sz[a] < sz[b]) swap(a, b);',
        '        p[b] = a; sz[a] += sz[b]; components--;',
        '        return true;',
        '    }',
        '    bool same(int a, int b) { return find(a) == find(b); }',
        '    int size(int a) { return sz[find(a)]; }',
        '};',
      },
    }
  ),

  -- trigger: seg
  s(
    'seg',
    {
      t {
        'struct SegTree {',
        '    int n; vector<long long> t;',
        '    SegTree(int n) : n(n), t(2*n, 0) {}',
        '    void update(int i, long long v) {',
        '        for (t[i+=n]=v; i>1; i>>=1) t[i>>1]=t[i]+t[i^1];',
        '    }',
        '    long long query(int l, int r) { // [l, r)',
        '        long long res = 0;',
        '        for (l+=n,r+=n; l<r; l>>=1,r>>=1) {',
        '            if (l&1) res += t[l++];',
        '            if (r&1) res += t[--r];',
        '        }',
        '        return res;',
        '    }',
        '};',
        '// For min/max: change 0 to LLONG_MAX/LLONG_MIN and + to min()/max()',
      },
    }
  ),

  -- trigger: lazyseg
  s(
    'lazyseg',
    {
      t {
        'struct LazySegTree {',
        '    int n; vector<long long> t, lazy;',
        '    LazySegTree(int n) : n(n), t(4*n, 0), lazy(4*n, 0) {}',
        '    void push(int v, int tl, int tr) {',
        '        if (lazy[v]) {',
        '            int tm = (tl+tr)/2;',
        '            apply(2*v, tl, tm, lazy[v]);',
        '            apply(2*v+1, tm+1, tr, lazy[v]);',
        '            lazy[v] = 0;',
        '        }',
        '    }',
        '    void apply(int v, int tl, int tr, long long val) {',
        '        t[v] += val * (tr-tl+1);',
        '        lazy[v] += val;',
        '    }',
        '    void update(int v, int tl, int tr, int l, int r, long long val) {',
        '        if (l > r) return;',
        '        if (l == tl && r == tr) { apply(v, tl, tr, val); return; }',
        '        push(v, tl, tr);',
        '        int tm = (tl+tr)/2;',
        '        update(2*v, tl, tm, l, min(r,tm), val);',
        '        update(2*v+1, tm+1, tr, max(l,tm+1), r, val);',
        '        t[v] = t[2*v] + t[2*v+1];',
        '    }',
        '    long long query(int v, int tl, int tr, int l, int r) {',
        '        if (l > r) return 0;',
        '        if (l == tl && r == tr) return t[v];',
        '        push(v, tl, tr);',
        '        int tm = (tl+tr)/2;',
        '        return query(2*v, tl, tm, l, min(r,tm))',
        '             + query(2*v+1, tm+1, tr, max(l,tm+1), r);',
        '    }',
        '    // wrappers: update(l,r,val), query(l,r) — 0-indexed',
        '    void update(int l, int r, long long val) { update(1,0,n-1,l,r,val); }',
        '    long long query(int l, int r) { return query(1,0,n-1,l,r); }',
        '};',
      },
    }
  ),

  -- trigger: fenwick
  s(
    'fenwick',
    {
      t {
        'struct Fenwick {',
        '    int n; vector<long long> t;',
        '    Fenwick(int n) : n(n), t(n+1, 0) {}',
        '    void update(int i, long long v) { for (i++; i<=n; i+=i&-i) t[i]+=v; }',
        '    long long query(int i) { long long s=0; for (i++; i>0; i-=i&-i) s+=t[i]; return s; }',
        '    long long query(int l, int r) { return query(r)-(l?query(l-1):0); } // [l,r]',
        '};',
      },
    }
  ),

  -- trigger: sparse
  s(
    'sparse',
    {
      t {
        'struct SparseTable {',
        '    int n, LOG; vector<vector<int>> t;',
        '    vector<int> lg;',
        '    SparseTable(vector<int>& a) : n(a.size()), LOG(__lg(a.size())+1),',
        '        t(LOG, vector<int>(a.size())), lg(a.size()+1) {',
        '        t[0] = a;',
        '        for (int j=1; j<LOG; j++)',
        '            for (int i=0; i+(1<<j)<=n; i++)',
        '                t[j][i] = min(t[j-1][i], t[j-1][i+(1<<(j-1))]);',
        '        lg[1] = 0;',
        '        for (int i=2; i<=n; i++) lg[i] = lg[i/2]+1;',
        '    }',
        '    int query(int l, int r) { // O(1) RMQ, [l,r] inclusive',
        '        int k = lg[r-l+1];',
        '        return min(t[k][l], t[k][r-(1<<k)+1]);',
        '    }',
        '};',
      },
    }
  ),

  -- trigger: pbds
  s(
    'pbds',
    {
      t {
        '#include <ext/pb_ds/assoc_container.hpp>',
        '#include <ext/pb_ds/tree_policy.hpp>',
        'using namespace __gnu_pbds;',
        'using ordered_set = tree<int, null_type, less<int>,',
        '    rb_tree_tag, tree_order_statistics_node_update>;',
        '// ordered_set s;',
        '// s.insert(x);  s.erase(x);',
        '// s.find_by_order(k)  -> iterator to k-th element (0-indexed)',
        '// s.order_of_key(x)   -> # elements strictly less than x',
      },
    }
  ),

  -- ─── 3. GRAPHS & TREES ───────────────────────────────────────────────────

  -- trigger: lca
  s(
    'lca',
    {
      t {
        'struct LCA {',
        '    int n, LOG; vector<vector<int>> up; vector<int> depth;',
        '    vector<vector<int>>& adj;',
        '    LCA(int n, vector<vector<int>>& adj, int root=0)',
        '        : n(n), LOG(__lg(n)+1), up(LOG, vector<int>(n,-1)),',
        '          depth(n,0), adj(adj) {',
        '        dfs(root, -1);',
        '    }',
        '    void dfs(int u, int p) {',
        '        up[0][u] = (p == -1 ? u : p);',
        '        for (int j=1; j<LOG; j++) up[j][u] = up[j-1][up[j-1][u]];',
        '        for (int v : adj[u]) if (v!=p) { depth[v]=depth[u]+1; dfs(v,u); }',
        '    }',
        '    int query(int u, int v) {',
        '        if (depth[u] < depth[v]) swap(u,v);',
        '        int diff = depth[u]-depth[v];',
        '        for (int j=0; j<LOG; j++) if ((diff>>j)&1) u=up[j][u];',
        '        if (u==v) return u;',
        '        for (int j=LOG-1; j>=0; j--) if (up[j][u]!=up[j][v]) { u=up[j][u]; v=up[j][v]; }',
        '        return up[0][u];',
        '    }',
        '    int dist(int u, int v) { return depth[u]+depth[v]-2*depth[query(u,v)]; }',
        '};',
      },
    }
  ),

  -- trigger: tarjan
  s(
    'tarjan',
    {
      t {
        'struct Tarjan {',
        '    int n, timer=0, scc_cnt=0;',
        '    vector<vector<int>>& adj;',
        '    vector<int> id, low, comp;',
        '    vector<bool> on_stack;',
        '    stack<int> st;',
        '    Tarjan(int n, vector<vector<int>>& adj)',
        '        : n(n), adj(adj), id(n,-1), low(n), comp(n,-1), on_stack(n,false) {',
        '        for (int i=0; i<n; i++) if (id[i]==-1) dfs(i);',
        '    }',
        '    void dfs(int u) {',
        '        low[u] = id[u] = timer++;',
        '        st.push(u); on_stack[u] = true;',
        '        for (int v : adj[u]) {',
        '            if (id[v]==-1) { dfs(v); low[u]=min(low[u],low[v]); }',
        '            else if (on_stack[v]) low[u]=min(low[u],id[v]);',
        '        }',
        '        if (low[u]==id[u]) {',
        '            while (true) {',
        '                int v=st.top(); st.pop(); on_stack[v]=false;',
        '                comp[v]=scc_cnt;',
        '                if (v==u) break;',
        '            }',
        '            scc_cnt++;',
        '        }',
        '    }',
        '    // comp[v] = SCC id of node v; scc_cnt = total SCCs',
        '};',
      },
    }
  ),

  -- trigger: dijkstra
  s(
    'dijkstra',
    {
      t {
        'vector<long long> dijkstra(int src, vector<vector<pair<int,int>>>& adj) {',
        '    int n = adj.size();',
        '    vector<long long> dist(n, LLONG_MAX);',
        '    priority_queue<pair<long long,int>, vector<pair<long long,int>>, greater<>> pq;',
        '    dist[src] = 0; pq.push({0, src});',
        '    while (!pq.empty()) {',
        '        auto [d, u] = pq.top(); pq.pop();',
        '        if (d > dist[u]) continue;',
        '        for (auto [v, w] : adj[u]) {',
        '            if (dist[u]+w < dist[v]) {',
        '                dist[v] = dist[u]+w;',
        '                pq.push({dist[v], v});',
        '            }',
        '        }',
        '    }',
        '    return dist;',
        '}',
        '// adj[u] = {{v, weight}, ...}; build with adj.resize(n);',
      },
    }
  ),

  -- trigger: hld
  s(
    'hld',
    {
      t {
        'struct HLD {',
        '    int n, timer=0; vector<int> parent,depth,heavy,head,pos;',
        '    vector<vector<int>>& adj;',
        '    SegTree seg; // plug in your SegTree',
        '    HLD(int n, vector<vector<int>>& adj)',
        '        : n(n), adj(adj), parent(n,-1), depth(n,0),',
        '          heavy(n,-1), head(n), pos(n), seg(n) {',
        '        dfs_sz(0); dfs_hld(0,0);',
        '    }',
        '    int dfs_sz(int u) {',
        '        int sz=1, max_sz=0;',
        '        for (int v:adj[u]) if(v!=parent[u]) {',
        '            parent[v]=u; depth[v]=depth[u]+1;',
        '            int s=dfs_sz(v); sz+=s;',
        '            if(s>max_sz) { max_sz=s; heavy[u]=v; }',
        '        }',
        '        return sz;',
        '    }',
        '    void dfs_hld(int u, int h) {',
        '        head[u]=h; pos[u]=timer++;',
        '        if(heavy[u]!=-1) dfs_hld(heavy[u],h);',
        '        for(int v:adj[u]) if(v!=parent[u]&&v!=heavy[u]) dfs_hld(v,v);',
        '    }',
        '    long long query(int u, int v) {',
        '        long long res=0;',
        '        for(;head[u]!=head[v];) {',
        '            if(depth[head[u]]<depth[head[v]]) swap(u,v);',
        '            res+=seg.query(pos[head[u]],pos[u]+1);',
        '            u=parent[head[u]];',
        '        }',
        '        if(depth[u]>depth[v]) swap(u,v);',
        '        res+=seg.query(pos[u],pos[v]+1);',
        '        return res;',
        '    }',
        '    void update(int u, long long val) { seg.update(pos[u],val); }',
        '};',
      },
    }
  ),

  -- ─── 4. STRINGS ──────────────────────────────────────────────────────────

  -- trigger: zhash  (double rolling hash)
  s(
    'zhash',
    {
      t {
        'struct PolyHash {',
        '    static const long long M1=1e9+7, M2=1e9+9, B1=131, B2=137;',
        '    int n; vector<long long> h1,h2,p1,p2;',
        '    PolyHash(const string& s) : n(s.size()), h1(n+1),h2(n+1),p1(n+1),p2(n+1) {',
        '        p1[0]=p2[0]=1;',
        '        for(int i=0;i<n;i++) {',
        '            h1[i+1]=(h1[i]*B1+s[i])%M1;',
        '            h2[i+1]=(h2[i]*B2+s[i])%M2;',
        '            p1[i+1]=p1[i]*B1%M1;',
        '            p2[i+1]=p2[i]*B2%M2;',
        '        }',
        '    }',
        '    pair<long long,long long> get(int l, int r) { // [l,r] inclusive',
        '        return {',
        '            (h1[r+1]-h1[l]*p1[r-l+1]%M1+M1*2)%M1,',
        '            (h2[r+1]-h2[l]*p2[r-l+1]%M2+M2*2)%M2',
        '        };',
        '    }',
        '};',
      },
    }
  ),

  -- trigger: kmp
  s(
    'kmp',
    {
      t {
        'vector<int> kmp_fail(const string& p) {',
        '    int n=p.size(); vector<int> f(n,0);',
        '    for(int i=1;i<n;i++) {',
        '        int j=f[i-1];',
        '        while(j&&p[i]!=p[j]) j=f[j-1];',
        '        f[i]=j+(p[i]==p[j]);',
        '    }',
        '    return f;',
        '}',
        '// all occurrences of pattern p in text t:',
        'vector<int> kmp_search(const string& t, const string& p) {',
        '    auto f = kmp_fail(p);',
        '    vector<int> res; int j=0;',
        '    for(int i=0;i<(int)t.size();i++) {',
        '        while(j&&t[i]!=p[j]) j=f[j-1];',
        '        if(t[i]==p[j]) j++;',
        '        if(j==(int)p.size()) { res.push_back(i-j+1); j=f[j-1]; }',
        '    }',
        '    return res;',
        '}',
        '// Z-array:',
        'vector<int> z_func(const string& s) {',
        '    int n=s.size(); vector<int> z(n,0); z[0]=n;',
        '    for(int i=1,l=0,r=0;i<n;i++) {',
        '        if(i<r) z[i]=min(r-i,z[i-l]);',
        '        while(i+z[i]<n&&s[z[i]]==s[i+z[i]]) z[i]++;',
        '        if(i+z[i]>r) { l=i; r=i+z[i]; }',
        '    }',
        '    return z;',
        '}',
      },
    }
  ),

  -- trigger: manacher
  s(
    'manacher',
    {
      t {
        '// returns radius array: d[i] = radius of longest palindrome centered at i',
        '// d_odd[i]: odd-length palindromes; d_even[i]: even-length',
        'pair<vector<int>,vector<int>> manacher(const string& s) {',
        '    int n=s.size();',
        '    vector<int> d1(n), d2(n);',
        '    for(int i=0,l=0,r=-1;i<n;i++) {',
        '        int k=(i>r)?1:min(d1[l+r-i],r-i+1);',
        '        while(i-k>=0&&i+k<n&&s[i-k]==s[i+k]) k++;',
        '        d1[i]=k--; if(i+k>r){l=i-k;r=i+k;}',
        '    }',
        '    for(int i=0,l=0,r=-1;i<n;i++) {',
        '        int k=(i>r)?0:min(d2[l+r-i+1],r-i+1);',
        '        while(i-k-1>=0&&i+k<n&&s[i-k-1]==s[i+k]) k++;',
        '        d2[i]=k--; if(k>=0&&i+k>r){l=i-k-1;r=i+k;}',
        '    }',
        '    return {d1, d2};',
        '}',
      },
    }
  ),

  -- trigger: suffix
  s(
    'suffix',
    {
      t {
        '// Suffix Array — O(n log n), SA-IS style simplified',
        'vector<int> suffix_array(const string& s) {',
        '    int n=s.size(); vector<int> sa(n),rank_(n),tmp(n);',
        '    iota(sa.begin(),sa.end(),0);',
        '    for(int i=0;i<n;i++) rank_[i]=s[i];',
        '    for(int gap=1;;gap*=2) {',
        '        auto cmp=[&](int a,int b){',
        '            if(rank_[a]!=rank_[b]) return rank_[a]<rank_[b];',
        '            int ra=a+gap<n?rank_[a+gap]:-1;',
        '            int rb=b+gap<n?rank_[b+gap]:-1;',
        '            return ra<rb;',
        '        };',
        '        sort(sa.begin(),sa.end(),cmp);',
        '        tmp[sa[0]]=0;',
        '        for(int i=1;i<n;i++) tmp[sa[i]]=tmp[sa[i-1]]+(cmp(sa[i-1],sa[i])?1:0);',
        '        rank_=tmp;',
        '        if(rank_[sa[n-1]]==n-1) break;',
        '    }',
        '    return sa;',
        '}',
        "// For LCP array, use Kasai's algorithm on top of this SA",
      },
    }
  ),

  -- ─── 5. GEOMETRY ─────────────────────────────────────────────────────────

  -- trigger: geo
  s(
    'geo',
    {
      t {
        'using T = long long; // use double for non-integer coords',
        'struct P {',
        '    T x, y;',
        '    P(T x=0,T y=0):x(x),y(y){}',
        '    P operator+(P o)const{return{x+o.x,y+o.y};}',
        '    P operator-(P o)const{return{x-o.x,y-o.y};}',
        '    P operator*(T t)const{return{x*t,y*t};}',
        '    T dot(P o)const{return x*o.x+y*o.y;}',
        '    T cross(P o)const{return x*o.y-y*o.x;}',
        '    T norm()const{return x*x+y*y;}',
        '    bool operator<(P o)const{return x<o.x||(x==o.x&&y<o.y);}',
        '};',
        '// Convex Hull (Monotone Chain) — O(n log n)',
        'vector<P> convex_hull(vector<P> pts) {',
        '    int n=pts.size(), k=0;',
        '    if(n<3) return pts;',
        '    sort(pts.begin(),pts.end());',
        '    vector<P> H(2*n);',
        '    for(int i=0;i<n;i++){',
        '        while(k>=2&&(H[k-1]-H[k-2]).cross(pts[i]-H[k-2])<=0) k--;',
        '        H[k++]=pts[i];',
        '    }',
        '    for(int i=n-2,t=k+1;i>=0;i--){',
        '        while(k>=t&&(H[k-1]-H[k-2]).cross(pts[i]-H[k-2])<=0) k--;',
        '        H[k++]=pts[i];',
        '    }',
        '    H.resize(k-1); return H;',
        '}',
        '// Signed polygon area * 2 (integer exact)',
        'T poly_area2(vector<P>& poly) {',
        '    T res=0; int n=poly.size();',
        '    for(int i=0;i<n;i++) res+=poly[i].cross(poly[(i+1)%n]);',
        '    return abs(res); // divide by 2.0 for actual area',
        '}',
        '// Point in polygon (ray casting) — O(n)',
        'bool point_in_poly(P p, vector<P>& poly) {',
        '    int n=poly.size(), cnt=0;',
        '    for(int i=0;i<n;i++) {',
        '        P a=poly[i]-p, b=poly[(i+1)%n]-p;',
        '        if(a.cross(b)==0&&a.dot(b)<=0) return true; // on edge',
        '        if(a.y<=0&&b.y>0&&a.cross(b)>0) cnt++;',
        '        if(a.y>0&&b.y<=0&&a.cross(b)<0) cnt++;',
        '    }',
        '    return cnt&1;',
        '}',
      },
    }
  ),
}
