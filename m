Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36072486BB2;
	Mon, 28 Sep 2026 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586552; cv=none; b=Ep7F8FfHGoD3DdQ19mJZsz9M5qIZDl8Ly781BK3TtXCfrS6yTy9unGGexZpxVGCr3GjOHZtkuJU92HcR8SnytsJd0fZe+Lb51Klz3eg42SHp3VSNDaxmArinTR2IvzkICA4tEn9S4QkBOSuk+KzSJSL4bx+6VZTyLtlYGmJicqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586552; c=relaxed/simple;
	bh=fbbFaLAGZ0PeURTndSijWPmwAkkNFjHHI8C7u0agJqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYi0DAcepmtbLuxd8TUTZ0ZreRkD8dCyJw7EPe9dyEHCor9SfgKBSHoDhdY4z+Z+/VxZNHzwxqEe5beE05Pv20bbAw6UvMOJfeRavBfjM2K8xsuaB+vpQjFKd6HV9QIfXSeNQPsOJzY1z78BPjjIaFncIQ3hMhyh/QDVtqLeTrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8TX4UBj; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8TX4UBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586551; x=1822122551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fbbFaLAGZ0PeURTndSijWPmwAkkNFjHHI8C7u0agJqU=;
  b=e8TX4UBjBGY08ul/6PCVGXOlh2fKf75Ox/pjXedYQ1fQykFmoA+W7Oqs
   s1tpEPOXRk6rrPgUXJDnUbcw4GdE8e+Gk68K4zLu0VibQvIf/jjXRxawI
   ImRxq+YoJpYiu2vGD+/3dYGkUvn+NrpkjW12EglrliF1Z5GiuVh1C+UcY
   MWJDPrBdJfR918nmkGLogHjf/A2N6/o8BtGVJpYGgy7o3XgxAzvzsNcMw
   hmyeAk5h2O2FX4EkVn6l9MGK1xSNKtOJ86Huj/82JDY8HBPASGeXpP/yP
   Krdg1DNkw4Z0KBq89Bdw1TycGh5xHporMQI2ZeKRel90qNOV2sEBvY2j1
   Q==;
X-CSE-ConnectionGUID: al8xegjEQJSzE8h7clny8Q==
X-CSE-MsgGUID: KgUGzNyWQyWmrgIagVOQCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90047069"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90047069"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:09:10 -0700
X-CSE-ConnectionGUID: 0tXfmiOxRc6XQBQ9C9wX7w==
X-CSE-MsgGUID: BK9P23SWTMCdT5OSMKu2ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="271488185"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:09:03 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@intel.com
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org,
	tabba@google.com,
	ackerleytng@google.com,
	michael.roth@amd.com,
	david@kernel.org,
	vannapurve@google.com,
	sagis@google.com,
	vbabka@suse.cz,
	thomas.lendacky@amd.com,
	nik.borisov@suse.com,
	pgonda@google.com,
	fan.du@intel.com,
	jun.miao@intel.com,
	francescolavra.fl@gmail.com,
	jgross@suse.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	chao.p.peng@intel.com,
	chao.gao@intel.com,
	farrah.chen@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v4 02/17] x86/virt/tdx: Add a SEAMCALL wrapper to demote a 2MB huge page
Date: Mon, 28 Sep 2026 17:08:31 +0800
Message-ID: <20260928090831.15502-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260928090729.15468-1-yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl;dr: Introduce a SEAMCALL wrapper to invoke the TDH_MEM_PAGE_DEMOTE
SEAMCALL for splitting a 2MB page mapped in S-EPT, and export it as an API.

The following assumptions are made by this wrapper:
1. The huge page is mapped at 2MB level in the S-EPT before invoking this
   wrapper.
2. DPAMT is enabled.
3. The TDX module supports uninterruptible demote.

The only expected error returned from this wrapper is TDX_OPERAND_BUSY.
Callers may need to kick vCPUs out of guest mode to avoid this error.
Callers must provide a pamt_cache for drawing DPAMT pages for guest memory
and ensure that pages can be drawn from the pamt_cache locklessly in this
wrapper.
Callers must ensure no concurrent invocations of this wrapper on the same
GPA.

Long version:

Huge pages offer improved TLB efficiency, faster page walks, better memory
contiguity, and reduced page fault and memory overhead (fewer intermediate
page table structures, and no 4KB DPAMT pages). However, splitting/demoting
a huge page is required in the following cases:
- when the guest accepts the private memory at a lower level,
- when part of the huge page is converted from private to shared, or
- when VMM wants to reclaim part of the huge page.

The TDH_MEM_PAGE_DEMOTE SEAMCALL demotes a guest private huge page by
locating the corresponding leaf huge S-EPT entry and replacing it with a
non-leaf S-EPT entry pointing to a new page table page, which holds the
split leaf S-EPT entries. When DPAMT is enabled, upon successfully demoting
a 2MB page to 4KB pages, the SEAMCALL performs DPAMT pages installation for
the 2MB physical memory range, similar to the DPAMT pages installation
performed by the TDH_PHYMEM_PAMT_ADD SEAMCALL.

The wrapper args "gpa", "level" specify the original huge leaf S-EPT entry;
"new_sept_pt" specifies the newly added page table page; "pamt_cache"
provides a pair of pages to gift to the TDX module as DPAMT pages; "pfn" is
used to locate the dpamt_refcount; and the output args "ext_err1" and
"ext_err2" allow the caller to retrieve SEAMCALL failure information.

Three assumptions are made by this wrapper (as in "tl;dr").
Assumption 1 holds because the VMM can only create mappings up to 2MB level
in the S-EPT via the TDH_MEM_PAGE_AUG SEAMCALL. 1GB mappings in the S-EPT
are only possible via the TDH_MEM_PAGE_PROMOTE SEAMCALL, which is not yet
supported.

Assumptions 1 and 2 together simplify the wrapper implementation by
eliminating the need to check whether DPAMT-related handling is required.

Assumption 3 is a tradeoff reached after research and discussion: a TDX
module that does not support uninterruptible demote returns the error
TDX_INTERRUPTED_RESTARTABLE if any pending host interrupts are detected
during the TDH_MEM_PAGE_DEMOTE SEAMCALL. Since the TDX module cannot
guarantee a maximum retry count to ensure forward progress of the demotion,
interrupt storms could result in a DoS if the host retries endlessly.
Disabling interrupts before invoking the TDH_MEM_PAGE_DEMOTE SEAMCALL also
does not work, as the TDX module also checks for pending NMIs. Therefore,
the tradeoff is to disable huge pages when the TDX module does not support
uninterruptible demote. This is acceptable for basic TDX huge page
enabling, since the SEAMCALL execution time under uninterruptible demote
mode remains reasonable [1][2].

Later patches in KVM will enforce theses assumptions by setting the maximum
mapping level to 2MB, disallowing page merging, and disabling TDX huge
pages if assumption 2 or 3 is not met. This wrapper warns and returns
TDX_SW_ERROR if any assumption is violated [6].

Due to assumptions 1 and 2, the wrapper always performs DPAMT-related
handling before and after invoking the core helper __tdh_mem_page_demote():
- Draw a pair of pages from pamt_cache and gift them to the TDX module for
  DPAMT pages installation. The pamt_cache is a list of pre-allocated pages
  provided by the caller. The caller ensures that drawing pages from the
  list is contention-free, either by using a per-vCPU thread-local list or
  by holding a per-VM lock. If the SEAMCALL fails, the pair of pages is
  freed directly rather than being re-inserted into the list, for
  simplicity.

- Use the global spinlock dpamt_lock to avoid potential contention between
  the TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs [3].
  The contention here can be cross-VM, similar to that between
  TDH_PHYMEM_PAMT_ADD and TDH_PHYMEM_PAMT_{ADD/REMOVE} [4]. dpamt_lock is
  acquired directly without any pre-testing, since a 2MB huge page mapped
  at the 2MB level in the S-EPT must have no existing dpamt_refcount before
  demotion unless there is a bug. For defensive programming, warn and
  return an error if dpamt_refcount is non-zero after acquiring dpamt_lock.

- Set dpamt_refcount to 512 upon successful demotion so that future
  invocations of tdx_pamt_put() when removing the split 4KB pages work
  correctly.

Note: The new_sept_pt page, which will be added as the S-EPT page table
      page upon successful demotion, also requires DPAMT pages installation
      before invoking the TDH_MEM_PAGE_DEMOTE SEAMCALL. This wrapper relies
      on the caller to invoke tdx_pamt_get() separately for the new_sept_pt
      page prior to calling this wrapper.

Additionally, caller must ensure no concurrent invocations of this wrapper
on the same GPA (for example, by holding KVM's write mmu_lock). Otherwise,
a second invocation on the same GPA may encounter an incorrect
dpamt_refcount or a SEAMCALL error caused by attempting to have the TDX
module demote a 4KB page. This not only simplifies the wrapper
implementation, but also prevents potential issues in the caller (for
example, avoiding a level mismatch between the KVM mirror EPT entry and the
corresponding S-EPT entry).

The only expected error returned from this wrapper is TDX_OPERAND_BUSY,
caused by potential contention between the TDH_MEM_PAGE_DEMOTE SEAMCALL and
TDH_VP_ENTER SEAMALL or guest TDCALLs operating on the S-EPT entry being
split, due to lack of lock protection. This error is returned directly to
the caller without retrying; the caller may handle it by kicking vCPUs and
preventing them from re-entering guest mode to resolve the contention.

For defensive programming, the wrapper still takes arg "level" (though it's
now always expected to be 2MB); a warning is issued before returning any
unexpected errors, regardless of whether the caller would issue a similar
warning [5][6].

Link: https://lore.kernel.org/kvm/99f5585d759328db973403be0713f68e492b492a.camel@intel.com [1]
Link: https://lore.kernel.org/all/fbf04b09f13bc2ce004ac97ee9c1f2c965f44fdf.camel@intel.com [2]
Link: https://lore.kernel.org/kvm/aip1eO7wvJDxKtBX@yzhao56-desk.sh.intel.com [3]
Link: https://lore.kernel.org/kvm/aNX6V6OSIwly1hu4@yzhao56-desk.sh.intel.com [4]
Link: https://lore.kernel.org/all/aYoS45AZNY0rUJQD@google.com [5]
Link: https://lore.kernel.org/all/aXzPIO2qZwuwaeLi@google.com [6]

This patch is based on earlier work from Xiaoyao Li, Isaku Yamahata, and
Kiryl Shutsemau.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- Rebased to DPAMT v11.
- Merged in DPAMT-related handling. (Sean).
- Only allow demotion when DPAMT is enabled. (Rick)
- Protect DEMOTE and pamt_refcount with dpamt_lock. (Yan)
- ENHANCE to ENHANCED in TDX_FEATURES0_ENHANCED_DEMOTE_INTERRUPTIBILITY.
  (Kai)
- tdx_supports_demote_nointerrupt() -->
  tdx_huge_page_demote_uninterruptible().  (Kai)
- Updated the patch log/SoB to match tip's preference.

v3:
- Use a var name that clearly tell that the page is used as a page table
  page. (Binbin).
- Check if TDX module supports feature ENHANCE_DEMOTE_INTERRUPTIBILITY.
  (Kai).

RFC v2:
- Refine the patch log (Rick).
- Do not handle TDX_INTERRUPTED_RESTARTABLE as the new TDX modules in
  planning do not check interrupts for basic TDX.

RFC v1:
- Rebased and split patch. Updated patch log.
---
 arch/x86/include/asm/tdx.h  |  9 ++++
 arch/x86/virt/vmx/tdx/tdx.c | 82 +++++++++++++++++++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 3 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e2790ac2c521..56549cc50651 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -37,6 +37,7 @@
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_DYNAMIC_PAMT	BIT_ULL(36)
+#define TDX_FEATURES0_ENHANCED_DEMOTE_INTERRUPTIBILITY	BIT_ULL(51)
 
 #ifndef __ASSEMBLER__
 
@@ -119,6 +120,11 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
 	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
+static inline bool tdx_huge_page_demote_uninterruptible(const struct tdx_sys_info *sysinfo)
+{
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_ENHANCED_DEMOTE_INTERRUPTIBILITY;
+}
+
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo);
 
 /* Simple structure for pre-allocating DPAMT pages outside of spinlocks. */
@@ -184,6 +190,9 @@ u64 tdh_mng_key_config(struct tdx_td *td);
 u64 tdh_mng_create(struct tdx_td *td, u16 hkid);
 u64 tdh_vp_create(struct tdx_td *td, struct tdx_vp *vp);
 u64 tdh_mng_rd(struct tdx_td *td, u64 field, u64 *data);
+u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, kvm_pfn_t pfn,
+			struct page *new_sept_pt, struct tdx_pamt_cache *pamt_cache,
+			u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mr_extend(struct tdx_td *td, u64 gpa, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mr_finalize(struct tdx_td *td);
 u64 tdh_vp_flush(struct tdx_vp *vp);
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 43f813afc5b1..1f121c24b9d9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -75,6 +75,9 @@ static struct tdmr_info_list tdx_tdmr_list;
  */
 static atomic_t *dpamt_refcounts;
 
+/* Serializes adding/removing DPAMT memory */
+static DEFINE_SPINLOCK(dpamt_lock);
+
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
@@ -82,6 +85,9 @@ static struct tdx_sys_info tdx_sysinfo;
 
 static DEFINE_RAW_SPINLOCK(sysinit_lock);
 
+static int alloc_pamt_array(struct page **pamt_pages, struct tdx_pamt_cache *cache);
+static void free_pamt_array(struct page **pamt_pages);
+
 /*
  * Do the module global initialization once and return its result.
  * It can be done on any cpu, and from task or IRQ context.
@@ -1827,6 +1833,79 @@ u64 tdh_mng_rd(struct tdx_td *td, u64 field, u64 *data)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mng_rd);
 
+static u64 __tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level,
+				 struct page *new_sept_pt, struct page **dpamt_pages,
+				 u64 *ext_err1, u64 *ext_err2)
+{
+	struct tdx_module_args args = {
+		.rcx = gpa | pg_level_to_tdx_sept_level(level),
+		.rdx = tdx_tdr_pa(td),
+		.r8 = page_to_phys(new_sept_pt),
+		.r12 = page_to_phys(dpamt_pages[0]),
+		.r13 = page_to_phys(dpamt_pages[1]),
+	};
+	u64 ret;
+
+	ret = seamcall_saved_ret(TDH_MEM_PAGE_DEMOTE, &args);
+
+	*ext_err1 = args.rcx;
+	*ext_err2 = args.rdx;
+	return ret;
+}
+
+u64 tdh_mem_page_demote(struct tdx_td *td, u64 gpa, enum pg_level level, kvm_pfn_t pfn,
+			struct page *new_sept_pt, struct tdx_pamt_cache *pamt_cache,
+			u64 *ext_err1, u64 *ext_err2)
+{
+	atomic_t *dpamt_refcount = tdx_find_dpamt_refcount(pfn);
+	struct page *dpamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
+	u64 ret;
+
+	*ext_err1 = 0;
+	*ext_err2 = 0;
+
+	if (WARN_ON_ONCE(!tdx_huge_page_demote_uninterruptible(&tdx_sysinfo) ||
+			 !tdx_supports_dynamic_pamt(&tdx_sysinfo) ||
+			 level != PG_LEVEL_2M))
+		return TDX_SW_ERROR;
+
+	if (WARN_ON_ONCE(alloc_pamt_array(dpamt_pages, pamt_cache)))
+		return TDX_SW_ERROR;
+
+	/*
+	 * The dpamt_lock is used to avoid contention between the
+	 * TDH_MEM_PAGE_DEMOTE and TDH_PHYMEM_PAMT_{ADD/REMOVE} SEAMCALLs.
+	 */
+	spin_lock(&dpamt_lock);
+
+	/*
+	 * The caller ensures that DEMOTE is only invoked on a 2MB mapping, so
+	 * dpamt_refcount must be 0.
+	 */
+	if (WARN_ON_ONCE(atomic_read(dpamt_refcount))) {
+		ret = TDX_SW_ERROR;
+		goto out_free;
+	}
+
+	ret = __tdh_mem_page_demote(td, gpa, level, new_sept_pt, dpamt_pages,
+				    ext_err1, ext_err2);
+	if (ret != TDX_SUCCESS) {
+		WARN_ON_ONCE((ret & TDX_SEAMCALL_STATUS_MASK) != TDX_OPERAND_BUSY);
+		goto out_free;
+	}
+
+	atomic_set(dpamt_refcount, PMD_SIZE / PAGE_SIZE);
+	spin_unlock(&dpamt_lock);
+
+	return TDX_SUCCESS;
+
+out_free:
+	spin_unlock(&dpamt_lock);
+	free_pamt_array(dpamt_pages);
+	return ret;
+}
+EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_demote);
+
 u64 tdh_mr_extend(struct tdx_td *td, u64 gpa, u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
@@ -2108,9 +2187,6 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 	return 0;
 }
 
-/* Serializes adding/removing DPAMT memory */
-static DEFINE_SPINLOCK(dpamt_lock);
-
 /* Bump DPAMT refcount for the given pfn and allocate DPAMT backing if needed. */
 int tdx_pamt_get(kvm_pfn_t pfn, enum pg_level level, struct tdx_pamt_cache *cache)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 94b2333e5f7e..8157f7b954d3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -24,6 +24,7 @@
 #define TDH_MNG_KEY_CONFIG		8
 #define TDH_MNG_CREATE			9
 #define TDH_MNG_RD			11
+#define TDH_MEM_PAGE_DEMOTE		15
 #define TDH_MR_EXTEND			16
 #define TDH_MR_FINALIZE			17
 #define TDH_VP_FLUSH			18
-- 
2.43.2

