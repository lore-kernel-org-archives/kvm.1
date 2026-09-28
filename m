Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AFB48D869;
	Mon, 28 Sep 2026 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586731; cv=none; b=fvcYsRK0fvU6uoSiCP798G0A8o4Nn66Z4tv6v8/K1mFXiA00gvCK4HIgUWg3NgBTaWPZeewGHsDhGhEuR8wjvVhpgCePn4FCnaCHK3Mmcd8geNf//+FR0bq+LnxbiArNTDKay8SRDX7w8wIwnq60hS4v/cRne6qA25eEOjw68t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586731; c=relaxed/simple;
	bh=cPX0hace411qzSa9XC4RNcmgvqqwyGEvdB1AMgVIm5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISflRHYQUXEUuugFN1/eY2E3gZCWjGbynQuyhfLnOAjF0p8//rX//XIrzrfOhlfIDYNPsjAd5BxaC6gJSNWm2nzTSssFfEHG4BaWSfst+8+b0Ek3Xjt26Jy51cNyPs+/L6Eafk5IOSBIUGu1W8L0/42n1r8/TyqQ81r1SoH8y/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vzua9rkD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vzua9rkD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586730; x=1822122730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPX0hace411qzSa9XC4RNcmgvqqwyGEvdB1AMgVIm5U=;
  b=Vzua9rkDzNC6jGo9aiI7IOpevBKkU2V2E8fz7MtL6LtwmQCnc7f5t18Z
   AWgAXHGZj6FiEliYwp5wNjIUYMg7oIsXo6mhPevbTVyd9xXr4WpPo2Sei
   pnjX2oya6Rx0H7pNBwbanB1caGcnul+3yEzLiMRaaOP8lAtce53iy1sMo
   cmgcTUUKQ6vPJJ+bGHUKFF4g6vstRtfV7KOQL5xWvtLj5FTKo2FkHpQMt
   225FZJR0bJC++qV8Cqak3/gdypbE6BR2MtQ4fesBJuhvnFp6GM1ROOSKW
   mekiPb9aavg6QQTRcHOjoj8GOTB0fyVRUegZWsSM3w5uf6HZ55YLsc8fn
   w==;
X-CSE-ConnectionGUID: t74gmTKpTiO8YeJUb1nlTw==
X-CSE-MsgGUID: Q9Ta9cVcTuWmQIsL40ykqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90148293"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90148293"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:10 -0700
X-CSE-ConnectionGUID: KzMhaYdKQxKyxSBIoQpmNA==
X-CSE-MsgGUID: q0XBWiD4TR+Zkk7n5llj6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275120871"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:12:03 -0700
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
Subject: [PATCH v4 12/17] KVM: x86/mmu: Add support for splitting S-EPT entry under non-vCPU context
Date: Mon, 28 Sep 2026 17:11:31 +0800
Message-ID: <20260928091131.15663-1-yan.y.zhao@intel.com>
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

Add support for splitting S-EPT entries under a non-vCPU context. This
prepares for zapping a subset of a huge mapping in S-EPT caused by
private-to-shared conversions or guest_memfd reclaiming of physical memory.

KVM must precisely zap/remove S-EPT entries to avoid clobbering guest
memory (the lifetime of guest private memory is tied to the S-EPT). So, KVM
needs to first split a huge mapping so that small mappings can be zapped
precisely.

Since there's no vCPU context, introduce a per-VM PAMT cache of
pre-allocated pages used to populate the Dynamic PAMT. Add a helper
tdx_get_pamt_cache() to select the per-VM PAMT cache when there's no vCPU
context.  Add the "kvm" arg to .topup_external_cache() and its caller
tdp_mmu_alloc_sp_for_split() for the purpose of passing the "kvm" arg to
tdx_get_pamt_cache().

Use a mutex to guard the entire cycle from the per-VM PAMT cache topup to
drawing pages from the cache. Using a mutex (e.g., versus a spinlock) is
important as it allows KVM to only drop and re-aquire the mmu_lock (a
spinlock) while continuing holding the mutex for memory allocation.

Introduce a local static function tdx_sept_split_huge_pages(), which
acquires the mutex before triggering the S-EPT entries splitting under a
non-vCPU context. This function is intended to be invoked by guest_memfd
via an arch hook in a later patch. Though functions related to dirty page
tracking can also trigger splitting under a non-vCPU context, they do not
yet involve mirror roots. So, how those functions should acquire the mutex
is deferred to a later consideration.

tdx_sept_split_huge_pages() internally invokes API
kvm_tdp_mmu_mirrors_split_huge_pages() to split mirror roots. To avoid
unnecessary work, explicitly detect unaligned head and tail pages relative
to the max page size supported by KVM (currently 2MB for private memory),
and split only those pages, as only unaligned head/tail pages will undergo
partial zapping.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Yan: Tweak patch log/function names, split out .gmem_prezap() hook]
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- New patch.
- Split out the registration of the .gmem_prezap hook into a later patch to
  isolate gmem-related changes. (Yan)
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  7 +--
 arch/x86/kvm/vmx/tdx.c          | 94 +++++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/tdx.h          |  5 ++
 5 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 373559a7cca5..5dd1db64562f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1650,7 +1650,7 @@ struct kvm_x86_ops {
 	/* Update external page tables for page table about to be freed. */
 	void (*free_external_spt)(struct kvm *kvm, struct kvm_mmu_page *sp);
 
-	int (*topup_external_cache)(struct kvm_vcpu *vcpu, int min_nr_spts);
+	int (*topup_external_cache)(struct kvm *kvm, struct kvm_vcpu *vcpu, int min_nr_spts);
 
 	bool (*has_wbinvd_exit)(void);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0725b92b7008..d92170a34728 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -618,7 +618,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 		if (r)
 			return r;
 
-		r = kvm_x86_call(topup_external_cache)(vcpu, PT64_ROOT_MAX_LEVEL);
+		r = kvm_x86_call(topup_external_cache)(vcpu->kvm, vcpu, PT64_ROOT_MAX_LEVEL);
 		if (r)
 			return r;
 	}
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9c783accb9ed..4829ddcd3b55 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1466,7 +1466,8 @@ bool kvm_tdp_mmu_wrprot_slot(struct kvm *kvm,
 	return spte_set;
 }
 
-static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(bool is_mirror_sp)
+static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(struct kvm *kvm,
+						       bool is_mirror_sp)
 {
 	struct kvm_mmu_page *sp;
 
@@ -1483,7 +1484,7 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(bool is_mirror_sp)
 		if (!sp->external_spt)
 			goto err_external_spt;
 
-		if (kvm_x86_call(topup_external_cache)(kvm_get_running_vcpu(), 1))
+		if (kvm_x86_call(topup_external_cache)(kvm, kvm_get_running_vcpu(), 1))
 			goto err_external_split;
 	}
 
@@ -1575,7 +1576,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 			else
 				write_unlock(&kvm->mmu_lock);
 
-			sp = tdp_mmu_alloc_sp_for_split(is_mirror_root);
+			sp = tdp_mmu_alloc_sp_for_split(kvm, is_mirror_root);
 
 			if (shared)
 				read_lock(&kvm->mmu_lock);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index f97b76bd8fe9..5c5919b76bdd 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -585,6 +585,8 @@ void tdx_vm_destroy(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 
+	tdx_free_pamt_cache(&kvm_tdx->pamt_cache);
+
 	tdx_reclaim_td_control_pages(kvm);
 
 	kvm_tdx->state = TD_STATE_UNINITIALIZED;
@@ -650,6 +652,9 @@ int tdx_vm_init(struct kvm *kvm)
 
 	kvm_tdx->state = TD_STATE_UNINITIALIZED;
 
+	tdx_init_pamt_cache(&kvm_tdx->pamt_cache);
+	mutex_init(&kvm_tdx->pamt_cache_lock);
+
 	return 0;
 }
 
@@ -1629,15 +1634,31 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
 }
 
-static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
+static struct tdx_pamt_cache *tdx_get_pamt_cache(struct kvm *kvm,
+						 struct kvm_vcpu *vcpu)
 {
+	if (KVM_BUG_ON(vcpu && vcpu->kvm != kvm, kvm))
+		return NULL;
+
+	if (vcpu)
+		return &to_tdx(vcpu)->pamt_cache;
+
+	lockdep_assert_held(&to_kvm_tdx(kvm)->pamt_cache_lock);
+	return &to_kvm_tdx(kvm)->pamt_cache;
+}
+
+static int tdx_topup_external_pamt_cache(struct kvm *kvm, struct kvm_vcpu *vcpu,
+					 int min_nr_spts)
+{
+	struct tdx_pamt_cache *pamt_cache;
 	int dpamt_pairs;
 
-	if (WARN_ON_ONCE(!vcpu))
+	pamt_cache = tdx_get_pamt_cache(kvm, vcpu);
+	if (!pamt_cache)
 		return -EIO;
 
 	/* Exclude the root SPT, as its DPAMT page pair is already installed */
-	if (min_nr_spts == vcpu->kvm->arch.mirror_root_level)
+	if (min_nr_spts == kvm->arch.mirror_root_level)
 		min_nr_spts -= 1;
 
 	/*
@@ -1658,7 +1679,7 @@ static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
 	 */
 	dpamt_pairs += 1;
 
-	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, dpamt_pairs);
+	return tdx_topup_pamt_cache(pamt_cache, dpamt_pairs);
 }
 
 static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
@@ -1909,8 +1930,8 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 static int tdx_sept_split_leaf_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				    u64 new_spte, enum pg_level level)
 {
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	struct tdx_pamt_cache *pamt_cache;
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 	struct page *sept_pt;
@@ -1925,10 +1946,11 @@ static int tdx_sept_split_leaf_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 	if (!sept_pt)
 		return -EIO;
 
-	if (KVM_BUG_ON(!vcpu || vcpu->kvm != kvm, kvm))
+	pamt_cache = tdx_get_pamt_cache(kvm, kvm_get_running_vcpu());
+	if (!pamt_cache)
 		return -EIO;
 
-	r = tdx_pamt_get(page_to_pfn(sept_pt), PG_LEVEL_4K, &to_tdx(vcpu)->pamt_cache);
+	r = tdx_pamt_get(page_to_pfn(sept_pt), PG_LEVEL_4K, pamt_cache);
 	if (KVM_BUG_ON(r, kvm))
 		return r;
 
@@ -1941,8 +1963,8 @@ static int tdx_sept_split_leaf_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 
 	tdx_track(kvm);
 	err = tdh_do_no_vcpus(tdh_mem_page_demote, kvm, &kvm_tdx->td, gpa,
-			      level, spte_to_pfn(old_spte), sept_pt,
-			      &to_tdx(vcpu)->pamt_cache, &entry, &level_state);
+			      level, spte_to_pfn(old_spte), sept_pt, pamt_cache,
+			      &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_DEMOTE, entry, level_state, kvm)) {
 		r = -EIO;
 		goto err;
@@ -2027,6 +2049,60 @@ static void tdx_sept_free_private_spt(struct kvm *kvm, struct kvm_mmu_page *sp)
 	sp->external_spt = NULL;
 }
 
+static int tdx_sept_split_huge_page_at(struct kvm *kvm, gfn_t gfn, int target_level)
+{
+	gfn_t end = gfn + KVM_PAGES_PER_HPAGE(target_level + 1);
+
+	return kvm_tdp_mmu_mirrors_split_huge_pages(kvm, gfn, end, target_level);
+}
+
+static int tdx_sept_split_straddling_huge_pages_to_level(struct kvm *kvm, gfn_t start,
+							 gfn_t end, int target_level)
+{
+	gfn_t head = gfn_round_for_level(start, target_level + 1);
+	gfn_t tail = gfn_round_for_level(end, target_level + 1);
+	int r;
+
+	if (head != start) {
+		r = tdx_sept_split_huge_page_at(kvm, head, target_level);
+		if (r)
+			return r;
+	}
+
+	if (tail != end && (head != tail || head == start)) {
+		r = tdx_sept_split_huge_page_at(kvm, tail, target_level);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+/*
+ * Split S-EPT huge mappings that straddle [start, end) under non-vCPU context.
+ *
+ * Split potential huge mappings at the head and tail of the to-be-zapped range
+ * so that KVM doesn't overzap due to dropping a hugepage that doesn't fall
+ * wholly inside the range.
+ *
+ * Acquire the external cache lock, a.k.a. the Dynamic PAMT lock, to protect the
+ * per-VM cache of pre-allocated pages used to populate the Dynamic PAMT when
+ * splitting S-EPT huge pages.
+ */
+static int __maybe_unused tdx_sept_split_huge_pages(struct kvm *kvm, gfn_t start,
+						    gfn_t end)
+{
+	guard(mutex)(&to_kvm_tdx(kvm)->pamt_cache_lock);
+
+	guard(write_lock)(&kvm->mmu_lock);
+
+	/*
+	 * TODO: Also split from PG_LEVEL_1G => PG_LEVEL_2M when KVM supports
+	 *       1GB S-EPT pages.
+	 */
+	return tdx_sept_split_straddling_huge_pages_to_level(kvm, start, end, PG_LEVEL_4K);
+}
+
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector)
 {
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index fd368e3ee060..602d1c289c2d 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -47,6 +47,11 @@ struct kvm_tdx {
 	 * Set/unset is protected with kvm->mmu_lock.
 	 */
 	bool wait_for_sept_zap;
+
+	/* The per-VM cache for DPAMT pages for S-EPT pages and guest pages */
+	struct tdx_pamt_cache pamt_cache;
+	/* Protect the per-VM cache for DPAMT pages */
+	struct mutex pamt_cache_lock;
 };
 
 /* TDX module vCPU states */
-- 
2.43.2

