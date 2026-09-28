Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FB494828;
	Mon, 28 Sep 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586803; cv=none; b=PW7QH7ZzD8s5FtJZqWbCUlKiOdvFm8VM+Px5Q1cgidN6g2Oc1owIYlVjqUEwQS06Sv/FQK37iDNAtA3UwIOi63mjE8H0Q5hLUSWtkQwfK4sM4uPDXFzt9eX+4iWNEnJuDWs3NntkHy4x37NG0arocQD/saVW1lyTFBcn5soGaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586803; c=relaxed/simple;
	bh=Zs0PcY+OPMU1xbhjHjIQt7XuYp7Tqca/1NiQs7YUttA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOEzCpduiGW2I4qErzQwcOlyU/gOvJFKSRW3LfadMlmE76P/KDLBESaHnd5JsuV8sxrC3rXvdxUOop0vK5yTkwl5VOmq1cJQSe394SMbtWXW+E/9+OK9x5w1nfClTQUP0VnvdfRRP2qY/CG9hZT0KKLNP66tgFPTcDHExdnGwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNDOKAvW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNDOKAvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586801; x=1822122801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zs0PcY+OPMU1xbhjHjIQt7XuYp7Tqca/1NiQs7YUttA=;
  b=HNDOKAvWL2G7TbuzN1w/X84rcdUOflfiDG+7LiD/6ivZuZwNaP8kjEo/
   Ps43nzx1anJVs9HZpXXj1LH1tCjSUqlxcWhZpNI07qtZYSZJhrKzZCwah
   mKmmbBLbfyf5pTppHolzyTGrPquKj+rU4ZlGt64oKEbkqWPVi9DJoOVux
   NX+9vqhvwPWhDcyydhTZVpiSAlQhgvexpmVSMSaQBj+rzHDDtLOrqyAQd
   +Vhrek96vvxnVO7tlRLjw/gIeS1Jftf15Q+4040C6IY6rY6dDtfaxrW63
   o4Ypil1XJQNJ+TJ6SS403YHBwYb+HOf/SQh7xmRvsUI4aTdoVKvoU92id
   g==;
X-CSE-ConnectionGUID: 6QS9lqqwS+ysp1GiN9SRkg==
X-CSE-MsgGUID: H9NwmAGeQFa31cNK7o+QJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90333858"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90333858"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:13:21 -0700
X-CSE-ConnectionGUID: uLqjoijSTBWmCnZPbK01DA==
X-CSE-MsgGUID: yhw2ag5NQk27IUacmpnjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="279725146"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:13:14 -0700
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
Subject: [PATCH v4 17/17] KVM: TDX: Turn on PG_LEVEL_2M
Date: Mon, 28 Sep 2026 17:12:42 +0800
Message-ID: <20260928091242.15743-1-yan.y.zhao@intel.com>
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

Introduce a module parameter named "tdx_huge_page" for kvm-intel.ko and
enable TDX huge pages if the module parameter is true and if:
(1) KVM supports gmem in-place conversions,
(2) the TDX module supports uninterruptible demote, and
(3) the TDX module supports DPAMT.

Condition (1) forces TDX huge pages to be the first user of gmem in-place
conversion. Condition (2) is required because the current splitting
implementation depends on the TDX module's non-interruptible demote
feature. Condition (3) simplifies the DEMOTE SEAMCALL's implementation.

When TDX huge page support is enabled, report to KVM MMU that the maximum
allowed mapping level for private memory is 2MB when the TD is RUNNABLE,
while forcing it to 4KB during TD build time. This is because KVM can only
create mappings up to 2MB level in the S-EPT via the TDH_MEM_PAGE_AUG
SEAMCALL, while TDH_MEM_PAGE_ADD mandates the mapping level must be 4KB.
1GB mappings in the S-EPT are only possible via promotion, which is not yet
supported due to the complexity incurred by the TDX module's rules for huge
page promotion.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- Disallowed huge page if gmem_in_place_conversion is false. (Sean)
- Updated map part due to MMU refactor. (Sean)
- Disallowed huge page if DPAMT is not enabled. (Rick)

v3:
- Introduce the module param enable_tdx_huge_page and disable to toggle TDX
  huge page support.
- Disable TDX huge page if TDX module does not support
  TDX_FEATURES0_ENHANCE_DEMOTE_INTERRUPTIBILITY. (Kai).
- Explain why not allow 2M before TD is RUNNABLE in patch log.(Kai)
- Add comment to explain the relationship between returning PG_LEVEL_2M
  and guest accept level. (Kai)
- Dropped some KVM_BUG_ON()s due to rebasing. Updated KVM_BUG_ON()s on
  mapping levels to take into account of enable_tdx_huge_page.

RFC v2:
- Merged RFC v1's patch 4 (forcing PG_LEVEL_4K before TD runnable) with
  patch 9 (allowing PG_LEVEL_2M after TD runnable).
---
 arch/x86/kvm/vmx/tdx.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 0ecfc17e6235..ee17e50bf439 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -57,6 +57,9 @@
 bool enable_tdx __ro_after_init;
 module_param_named(tdx, enable_tdx, bool, 0444);
 
+static bool __read_mostly enable_tdx_huge_page = true;
+module_param_named(tdx_huge_page, enable_tdx_huge_page, bool, 0444);
+
 static const struct tdx_sys_info *tdx_sysinfo;
 
 void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err)
@@ -1786,8 +1789,9 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 	if (KVM_BUG_ON(!vcpu, kvm))
 		return -EIO;
 
-	/* TODO: handle large pages. */
-	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
+	/* TODO: Support hugepages when building the initial TD image. */
+	if (KVM_BUG_ON(level != PG_LEVEL_4K &&
+		       to_kvm_tdx(kvm)->state != TD_STATE_RUNNABLE, kvm))
 		return -EIO;
 
 	WARN_ON_ONCE((new_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
@@ -1883,10 +1887,6 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 	if (KVM_BUG_ON(!is_hkid_assigned(to_kvm_tdx(kvm)), kvm))
 		return -EIO;
 
-	/* TODO: handle large pages. */
-	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
-		return -EIO;
-
 	err = tdh_do_no_vcpus(tdh_mem_range_block, kvm, &kvm_tdx->td, gpa,
 			      level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_RANGE_BLOCK, entry, level_state, kvm))
@@ -3665,12 +3665,34 @@ int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp)
 	return ret;
 }
 
+/*
+ * For private pages:
+ *
+ * Force KVM to map at 4KB level when !enable_tdx_huge_page (e.g., due to
+ * incompatible TDX module) or before TD state is RUNNABLE.
+ *
+ * Always allow KVM to map at 2MB level in other cases, though KVM may still map
+ * the page at 4KB (i.e., passing in PG_LEVEL_4K to AUG) due to
+ * (1) the backend folio is 4KB,
+ * (2) disallow_lpage restrictions:
+ *     - mixed private/shared pages in the 2MB range
+ *     - level misalignment due to slot base_gfn, slot size, and ugfn
+ *     - guest_inhibit bit set due to guest's 4KB accept level
+ * (3) page merging is disallowed (e.g., when part of a 2MB range has been
+ *     mapped at 4KB level during TD build time).
+ */
 int tdx_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
 {
 	if (!is_private)
 		return 0;
 
-	return PG_LEVEL_4K;
+	if (!enable_tdx_huge_page)
+		return PG_LEVEL_4K;
+
+	if (unlikely(to_kvm_tdx(kvm)->state != TD_STATE_RUNNABLE))
+		return PG_LEVEL_4K;
+
+	return PG_LEVEL_2M;
 }
 
 void tdx_hardware_unsetup(void)
@@ -3749,6 +3771,11 @@ static int __init __tdx_hardware_setup(void)
 	if (misc_cg_set_capacity(MISC_CG_RES_TDX, tdx_get_nr_guest_keyids()))
 		return -EINVAL;
 
+	if (enable_tdx_huge_page && (!gmem_in_place_conversion ||
+				     !tdx_huge_page_demote_uninterruptible(tdx_sysinfo) ||
+				     !tdx_supports_dynamic_pamt(tdx_sysinfo)))
+		enable_tdx_huge_page = false;
+
 	return 0;
 }
 
-- 
2.43.2

