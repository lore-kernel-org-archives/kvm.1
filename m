Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFC485945;
	Mon, 28 Sep 2026 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586717; cv=none; b=iwkdtnCSdY0Kdvkr70G4vMilOyygbtSpwzJUfVULQvRX1MKknPmioXIMqJsdAciBJ0D3LJAITynPh8lFA/WKhkYbrcuf9EGUK0X2/hfFpyP3KcBJBWLHyzGRfVq4LGlC8q+7ySeV9KdzVbFefV2JsrNmvgWSPqP7O0uO8ugezw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586717; c=relaxed/simple;
	bh=yEAzrAWxh2eJOhD7DTsVJFDtUUgr1LRPm3GRg0UU1DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3t7fq8EMPDvyD415KsZw89BNY0vN/hbmPm8zCjy1O9aSmDlQdhOwFAJ0TBlHnBLtbiwdfCbrf5SxjmQt1QozzmvY0S0/2swN9+QnXrs6rOPPCwJh6baPFe9k+73qUySTLMD3RhSRK4azGOjAXQJERPUh1jUANsq3jDGNCLrVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBTYY66r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBTYY66r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586716; x=1822122716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yEAzrAWxh2eJOhD7DTsVJFDtUUgr1LRPm3GRg0UU1DY=;
  b=EBTYY66rKuyslK8FQetGMM6xQSK0rmpEMmS3I4sLt7zXYqwaZiuonQOH
   dDK9qB2p0iW2Y8C+JnWhtTDqyoxbNLXSdJ2++dGwbZmAVNAe2YYVKct44
   eSsV4/hqUnGdo8hhKDx3DH25qsW0sdlMUnoZ1GkZ9Pg5uXU+GNo+3IugS
   19GzgpqSH5mkMMhAIEkDlZMmqUAeKCI9I2EYXKLguHrqEVqaH0FRXqRfW
   N30Ilw8wf/2u5J6JsFo5OWbQzv0WdMbXWK9HQrlRp50p8eqhJ3MrkucwW
   PlD9lm1vZfOYdBVa1TXICaxtCUAyy85KD1e3CNUf3uxwTipPjU8p+9Ebm
   A==;
X-CSE-ConnectionGUID: pVJJWMnlRbGx4VJBHD3lmw==
X-CSE-MsgGUID: umO8JoCRQKyLRRRpEcY6nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90148266"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90148266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:56 -0700
X-CSE-ConnectionGUID: s763RDibTtu9W+m96ZgrmA==
X-CSE-MsgGUID: U2isXoaLQUq2jOalYo+cOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275120819"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:49 -0700
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
Subject: [PATCH v4 11/17] KVM: TDX: Honor the guest's accept level contained in an EPT violation
Date: Mon, 28 Sep 2026 17:11:16 +0800
Message-ID: <20260928091116.15647-1-yan.y.zhao@intel.com>
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

TDX requires guests to accept S-EPT mappings created by the host KVM. Due
to the current implementation of the TDX module, if a guest accepts a GFN
at a lower level after KVM maps it at a higher level, the TDX module will
synthesize an EPT Violation VM-Exit to KVM instead of returning a size
mismatch error to the guest. If KVM fails to perform page splitting in the
EPT Violation handler, the guest's ACCEPT operation will be triggered
again upon re-entering the guest, causing a repeated EPT Violation VM-Exit.

To ensure forward progress, honor the guest's accept level if an EPT
Violation VM-Exit contains the guest accept level (the TDX module provides
the level when synthesizing a VM-Exit in response to a failed guest ACCEPT,
e.g., due to accept level < host mapping level or due to intermediate
paging structure missing or inaccessible).

(1) Set the guest inhibit bit in the lpage info to prevent KVM's MMU
    from mapping at a higher level than the guest's accept level.

(2) Split any existing mapping higher than the guest's accept level.

For now, take mmu_lock for write across the entire operation to keep things
simple.  This can/will be revisited when the TDX module adds support for
NON-BLOCKING-RESIZE, at which point KVM can split the huge page without
needing to handle UNBLOCK failure if the DEMOTE fails.

To avoid unnecessarily contending mmu_lock, check if the inhibit flag is
already set before acquiring mmu_lock, e.g. so that vCPUs doing ACCEPT
on a region of memory aren't completely serialized.  Note, this relies on
(a) setting the inhibit after performing the split, and (b) never clearing
the flag, e.g., to avoid false positives and potentially triggering the
zero-step mitigation.

Note: EPT Violation VM-Exits without the guest's accept level are *never*
caused by the guest's ACCEPT operation, but instead occur if the guest
accesses memory before said memory is accepted.  Since KVM can't obtain
the guest accept level info from such EPT Violations (the ACCEPT operation
hasn't occurred yet), KVM may still map at a higher level than the guest's
later ACCEPT level.

So, the typical guest/KVM interaction flow is:
- If guest accesses private memory without first accepting it,
  (like non-Linux guests):
  1. Guest accesses a private memory.
  2. KVM finds it can map the GFN at 2MB. So, AUG at 2MB.
  3. Guest accepts the GFN at 4KB.
  4. KVM receives an EPT violation with eeq_type of ACCEPT + 4KB level.
  5. KVM splits the 2MB mapping.
  6. Guest accepts successfully and accesses the page.

- If guest first accepts private memory before accessing it,
  (like Linux guests):
  1. Guest accepts a private memory at 4KB.
  2. KVM receives an EPT violation with eeq_type of ACCEPT + 4KB level.
  3. KVM AUG at 4KB.
  4. Guest accepts successfully and accesses the page.

Link: https://lore.kernel.org/all/a6ffe23fb97e64109f512fa43e9f6405236ed40a.camel@intel.com
Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- In [1], Sean renamed tdx_honor_guest_accept_level() to
  tdx_handle_mismatched_accept(). In v4, Yan further renamed it to
  tdx_handle_guest_accept_ept_violation(), because EPT violations caused by
  a guest's ACCEPT operation are not necessarily due to the guest's ACCEPT
  level mismatching KVM's mapping level. In the case where a guest accepts
  memory before ever accessing it, EPT violations caused by the guest's
  ACCEPT operation occur when there are no present KVM mappings.

- Introduced helper tdx_is_mismatched_accepted() (Yan renamed it to
  tdx_is_guest_accept_ept_violation()). (Sean)

- Introduced helper tdx_get_ept_violation_level(). (Sean)

- Invoked kvm_tdp_mmu_mirrors_split_huge_pages() instead of
  kvm_split_cross_boundary_leafs(). (Sean)

[1] https://lore.kernel.org/all/20260129011517.3545883-42-seanjc@google.com
---
 arch/x86/kvm/vmx/tdx.c      | 75 +++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/tdx_arch.h |  3 ++
 2 files changed, 78 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 397a308b834c..f97b76bd8fe9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -14,6 +14,7 @@
 #include "tdx.h"
 #include "vmx.h"
 #include "mmu/spte.h"
+#include "mmu/tdp_mmu.h"
 #include "common.h"
 #include "posted_intr.h"
 #include "irq.h"
@@ -2049,6 +2050,76 @@ static inline bool tdx_is_sept_violation_unexpected_pending(struct kvm_vcpu *vcp
 	return !(eq & EPT_VIOLATION_PROT_MASK);
 }
 
+static bool tdx_is_guest_accept_ept_violation(struct kvm_vcpu *vcpu)
+{
+	return (to_tdx(vcpu)->ext_exit_qualification & TDX_EXT_EXIT_QUAL_TYPE_MASK) ==
+	       TDX_EXT_EXIT_QUAL_TYPE_ACCEPT;
+}
+
+static int tdx_get_ept_violation_level(struct kvm_vcpu *vcpu)
+{
+	u64 ext_exit_qual = to_tdx(vcpu)->ext_exit_qualification;
+
+	return (((ext_exit_qual & TDX_EXT_EXIT_QUAL_INFO_MASK) >>
+		 TDX_EXT_EXIT_QUAL_INFO_SHIFT) & GENMASK(2, 0)) + 1;
+}
+
+/*
+ * An EPT violation can be either due to the guest's ACCEPT operation or
+ * due to the guest's access of memory before the guest accepts the
+ * memory.
+ *
+ * Type TDX_EXT_EXIT_QUAL_TYPE_ACCEPT in the extended exit qualification
+ * identifies EPT violations caused by the guest's ACCEPT operation, which must
+ * contain a valid guest accept level. For such EPT violations, honor guest's
+ * accept level by setting guest inhibit bit on levels above the guest accept
+ * level and split the existing mapping for the faulting GFN if it's with a
+ * higher level than the guest accept level.
+ *
+ * Do nothing if the EPT violation is not caused by the guest's ACCEPT
+ * operation. KVM will map the GFN without considering the guest's accept level
+ * (unless the guest inhibit bit is already set).
+ */
+static int tdx_handle_guest_accept_ept_violation(struct kvm_vcpu *vcpu, gfn_t gfn)
+{
+	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
+	struct kvm *kvm = vcpu->kvm;
+	gfn_t start, end;
+	int level, r;
+
+	if (!slot || !tdx_is_guest_accept_ept_violation(vcpu))
+		return 0;
+
+	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->mirror_root_hpa)))
+		return 0;
+
+	level = tdx_get_ept_violation_level(vcpu);
+	if (level > PG_LEVEL_2M)
+		return 0;
+
+	if (hugepage_test_guest_inhibit(slot, gfn, level + 1))
+		return 0;
+
+	guard(write_lock)(&kvm->mmu_lock);
+
+	start = gfn_round_for_level(gfn, level);
+	end = start + KVM_PAGES_PER_HPAGE(level);
+
+	r = kvm_tdp_mmu_mirrors_split_huge_pages(kvm, start, end, level);
+	if (r)
+		return r;
+
+	/*
+	 * No TLB flush is required, as the "BLOCK + TRACK + kick off vCPUs"
+	 * sequence required by the TDX-Module includes a TLB flush.
+	 */
+	hugepage_set_guest_inhibit(slot, gfn, level + 1);
+	if (level == PG_LEVEL_4K)
+		hugepage_set_guest_inhibit(slot, gfn, level + 2);
+
+	return 0;
+}
+
 static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qual;
@@ -2074,6 +2145,10 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 		 */
 		exit_qual = EPT_VIOLATION_ACC_WRITE;
 
+		ret = tdx_handle_guest_accept_ept_violation(vcpu, gpa_to_gfn(gpa));
+		if (ret)
+			return ret;
+
 		/* Only private GPA triggers zero-step mitigation */
 		local_retry = true;
 	} else {
diff --git a/arch/x86/kvm/vmx/tdx_arch.h b/arch/x86/kvm/vmx/tdx_arch.h
index 350143b9b145..6b8b18b0689a 100644
--- a/arch/x86/kvm/vmx/tdx_arch.h
+++ b/arch/x86/kvm/vmx/tdx_arch.h
@@ -76,7 +76,10 @@ struct tdx_cpuid_value {
 } __packed;
 
 #define TDX_EXT_EXIT_QUAL_TYPE_MASK	GENMASK(3, 0)
+#define TDX_EXT_EXIT_QUAL_TYPE_ACCEPT	1
 #define TDX_EXT_EXIT_QUAL_TYPE_PENDING_EPT_VIOLATION  6
+#define TDX_EXT_EXIT_QUAL_INFO_MASK	GENMASK(63, 32)
+#define TDX_EXT_EXIT_QUAL_INFO_SHIFT	32
 /*
  * TD_PARAMS is provided as an input to TDH_MNG_INIT, the size of which is 1024B.
  */
-- 
2.43.2

