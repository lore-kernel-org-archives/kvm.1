Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E34486BB5;
	Mon, 28 Sep 2026 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586661; cv=none; b=lLEr5uJDlqAv47qMeG1T9Cl9N5yJp+4YTfJPQuLfVcrLdB5fvkT4ytzxhUxIVAQlaBBEYTb5R1TxB2PPCwCJIBPhz6Gr2Qw8hj6G/OHlUTQM8H96XnrH/X0a9SN3T0fMrIMp8rr5cmdwW6fWncM3vm+LcZQ4SmJz7sEOwAtXDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586661; c=relaxed/simple;
	bh=EjUwQPBcm/8DsFgJTAU8vYfS3LezumsR9YjyVsfyW+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTG773tOO3X46geVUigHx9HWX7MAoyERxvMv9KfFqS5d/ecoojpHnydqd7gA63uoi8UwIskzRXljQKZnJv99LMzyCYYv9AOJdlzMDnCQTwLbE2uUQymh6x2PPOshSIzc3Z+2L76kgZz65avT5ZWL8S743hc/W/9c5M/b56NzFzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ot/effqI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ot/effqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586660; x=1822122660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EjUwQPBcm/8DsFgJTAU8vYfS3LezumsR9YjyVsfyW+s=;
  b=Ot/effqImS9YMUT4uyxpYBJycnRG3c5oscRjgRS1SG9OdMP8AY2JA2He
   MYJVuGv18liXoPp/x0Jad7RGPciHmdpcqWLep5JQ8l4+5jAEkqQNWA4iu
   yd98e5nLojGrsLH1hIRgb9jHZ2+16xCWposET/dT+epOTE/iRy5lr01ol
   bBMHtYbvR/roZ/jftfifzK6rhGFDSUB3ZGymZL8ytlePHvt8fmeDbD9KA
   tJIvoZdJvvGUvxBC/w1UUOOsxBpEYOaKz5wLkc/BUFCu3g6vrEaIgWWea
   6oTU4UY4BoET2Hvc1Hbem2psIUG1WA5UFiPT0Rp5K/OvIXfdCKru4IYDf
   A==;
X-CSE-ConnectionGUID: BwELttCYTp6EHx1BKVJzAA==
X-CSE-MsgGUID: JYxWs7QiRniV1if9ieI5mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323348"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323348"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:59 -0700
X-CSE-ConnectionGUID: PkBLQAyrSdKyacy2MQdjFQ==
X-CSE-MsgGUID: vpy4a3bhT0+TJmvYWA2txg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="304487108"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:54 -0700
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
Subject: [PATCH v4 07/17] KVM: TDX: Add core support for splitting/demoting 2MB S-EPT mappings to 4KB
Date: Mon, 28 Sep 2026 17:10:21 +0800
Message-ID: <20260928091021.15583-1-yan.y.zhao@intel.com>
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

Add support for splitting, a.k.a. demoting, a 2MB S-EPT leaf mapping to 512
smaller 4KB leaf mappings.  As per the TDX module rules, first invoke
MEM.RANGE.BLOCK to put the huge S-EPT leaf entry into a splittable state,
then do MEM.TRACK and kick all vCPUs outside of guest mode to flush TLBs,
and finally do MEM.PAGE.DEMOTE to demote/split the huge S-EPT leaf mapping.

Assert the mmu_lock is held for write, as the BLOCK => TRACK => DEMOTE
sequence needs to be "atomic" to guarantee success (and because mmu_lock
must be held for write to use tdh_do_no_vcpus()).

Note, even with kvm->mmu_lock held for write, tdh_mem_page_demote() may
contend with tdh_vp_enter() and potentially with the guest's S-EPT entry
operations.  Therefore, wrap the call with tdh_do_no_vcpus() to kick other
vCPUs out of the guest and prevent tdh_vp_enter() to ensure success.

Invoke tdx_pamt_get() before invoking tdh_mem_page_demote() so that DPAMT
pages for the new S-EPT page table page are installed before the DEMOTE
SEAMCALL when DPAMT is enabled. DPAMT pages for the guest memory must be
installed inside the DEMOTE SEAMCALL, since it is impossible to do so
before a successful demotion.

Instead of allocating and freeing DPAMT pages for guest pages on the KVM
side, pass pamt_cache to tdh_mem_page_demote() and let it draw DPAMT pages
from pamt_cache before the DEMOTE SEAMCALL. This prevents KVM from having
to manage DPAMT pages directly via alloc_pamt_array() and
free_pamt_array(), or having knowledge of DPAMT-specific details such as
TDX_DPAMT_ENTRY_PAGE_CNT.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[sean: wire up via op set_external_spte(), merge in DPAMT-related code,
 massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- Hooked tdx_sept_split_leaf_spte() in x86 op set_external_spte() instead
  of in x86 op split_external_spte() which was no longer introduced in v4.
  (Sean).
- Renamed tdx_sept_split_private_spte() --> tdx_sept_split_leaf_spte().
- Merged in DPAMT-related code (i.e., passing to_tdx(vcpu)->pamt_cache to
  tdh_mem_page_demote(). (Sean).
- Assert new_spte is non-leaf. (Yan)

v3:
- Rebased on top of Sean's cleanup series.
- Call out UNBLOCK is not required after DEMOTE. (Kai)
- tdx_sept_split_private_spt() --> tdx_sept_split_private_spte().

RFC v2:
- Split out the code to handle the error TDX_INTERRUPTED_RESTARTABLE.
- Rebased to 6.16.0-rc6 (the way of defining TDX hook changes).

RFC v1:
- Split patch for exclusive mmu_lock only,
- Invoke tdx_sept_zap_private_spte() and tdx_track() for splitting.
- Handled busy error of tdh_mem_page_demote() by kicking off vCPUs.
---
 arch/x86/kvm/vmx/tdx.c | 69 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3dcddf1b48c5..3186c4808cae 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1873,11 +1873,74 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
+/*
+ * Split a huge mapping into smaller mappings at a lower level.  Currently only
+ * supports splitting 2MB mappings (KVM doesn't yet support 1GB mappings for TDX
+ * guests).
+ *
+ * Invoke "BLOCK + TRACK + kick off vCPUs (inside tdx_track())" since the TDX
+ * module does not yet support the NON-BLOCKING-RESIZE feature for DEMOTE.
+ *
+ * No UNBLOCK is needed after a successful DEMOTE.
+ *
+ * Under write mmu_lock, kick off all vCPUs and disallow vCPUs from entering to
+ * ensure DEMOTE will succeed on the second invocation if the first invocation
+ * returns BUSY.
+ */
+static int tdx_sept_split_leaf_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				    u64 new_spte, enum pg_level level)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	gpa_t gpa = gfn_to_gpa(gfn);
+	u64 err, entry, level_state;
+	struct page *sept_pt;
+	int r;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	if (KVM_BUG_ON(!is_last_spte(old_spte, level) || is_last_spte(new_spte, level), kvm))
+		return -EIO;
+
+	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
+	if (!sept_pt)
+		return -EIO;
+
+	if (KVM_BUG_ON(!vcpu || vcpu->kvm != kvm, kvm))
+		return -EIO;
+
+	r = tdx_pamt_get(page_to_pfn(sept_pt), PG_LEVEL_4K, &to_tdx(vcpu)->pamt_cache);
+	if (KVM_BUG_ON(r, kvm))
+		return r;
+
+	err = tdh_do_no_vcpus(tdh_mem_range_block, kvm, &kvm_tdx->td, gpa,
+			      level, &entry, &level_state);
+	if (TDX_BUG_ON_2(err, TDH_MEM_RANGE_BLOCK, entry, level_state, kvm)) {
+		r = -EIO;
+		goto err;
+	}
+
+	tdx_track(kvm);
+	err = tdh_do_no_vcpus(tdh_mem_page_demote, kvm, &kvm_tdx->td, gpa,
+			      level, spte_to_pfn(old_spte), sept_pt,
+			      &to_tdx(vcpu)->pamt_cache, &entry, &level_state);
+	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_DEMOTE, entry, level_state, kvm)) {
+		r = -EIO;
+		goto err;
+	}
+
+	return 0;
+err:
+	tdx_pamt_put(page_to_pfn(sept_pt), PG_LEVEL_4K);
+	return r;
+}
+
 /*
  * Handle changes for
  * (1) leaf SPTEs from non-present to present
  * (2) non-leaf SPTEs from non-present to present
  * (3) leaf SPTEs from present to non-present
+ * (4) present leaf SPTEs to present non-leaf SPTEs (splitting)
  *
  * - (1) and (2) must be under shared mmu_lock. If (1) and (2) are under
  *   exclusive mmu_lock (currently impossible), contention errors may lead to
@@ -1888,13 +1951,17 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
  *   (currently impossible), warnings will be generated due to
  *   lockdep_assert_held_write() or TDX_BUG_ON() caused by concurrent BLOCK,
  *   TRACK, REMOVE.
- * - Promotion/demotion is not yet supported.
+ * - (4) must be under write mmu_lock currently.
+ * - Promotion is not yet supported.
  */
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 
+	if (is_shadow_present_pte(old_spte) && is_shadow_present_pte(new_spte))
+		return tdx_sept_split_leaf_spte(kvm, gfn, old_spte, new_spte, level);
+
 	if (is_shadow_present_pte(old_spte))
 		return tdx_sept_remove_leaf_spte(kvm, gfn, level, old_spte);
 
-- 
2.43.2

