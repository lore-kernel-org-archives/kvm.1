Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C338CFF8;
	Sat,  9 May 2026 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315856; cv=none; b=JqWA/V5T9/fqL2GlUAhwGGtF3r/MAtIae7+o6sOeOWjTgBKSAMqXCBhK+LSb6SPdSZLasofcj0Rox9xmyIotbxmPbHcHbBQZRpzatncUes338n59ydYG0tL/5EUm3Z4NiwqQHkVrq4m51heyBE32Cv8aVDZ2bBSRa9ED8T8nq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315856; c=relaxed/simple;
	bh=VNGptNcnug1Kynfoow7xYKFTwBXMjzkYDEZiM53td6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmrApDEH/cqJDBAIiliClMx7GL+EbxfdgUy3yCWNSLBreXCVxO6LpL5Pl8RhgBO5uHXBYF6oWP+R+dMENE0Hz0f3PRat0ekcd+fffRCw2t7OwH/EnoRp54JaDdv31h25XZVJiLXySnaGKw5CzcO/tRfoSF4LMNyW2SKXjdypx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0LXPy6l; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0LXPy6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315855; x=1809851855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNGptNcnug1Kynfoow7xYKFTwBXMjzkYDEZiM53td6Q=;
  b=Q0LXPy6l1buAUbrvkVZY7uDdAJIXjCxuNOK2gKy9qCk1IhU2vOwRJJ8W
   jsrW7xjCDC6w7lLBoA6CktvWPZFQYXxZ0F2iPBHuKjjTurSlkGQoOyBxI
   jSoFXuaTuzLDAjhLqBbK4D+j3e3d92dm3MrXKqZqj+qNhwN1pLEW/Tqjk
   ITOH9TwPe007S0ii/0FxIoykVBOUSJE+uRpq6+aCvk0Yvpaoy1JrPJW43
   79yDXdJd3F8GaVOQ5WWUabemhhF5M/udEFi2scAXH0idbmoLtMP3fCNOq
   7UPxmFEMp680ds3FhEB2bOHqYyYXrw0C2Tq4ggGM/Tbv6vBVtoILi5+js
   w==;
X-CSE-ConnectionGUID: HQq9KIx+TKyehk/saQKEgw==
X-CSE-MsgGUID: scw4E+Q0QgatQ3vkELchIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79005364"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79005364"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:37:35 -0700
X-CSE-ConnectionGUID: Ffebmn3jRpWQjYQpVqfEXQ==
X-CSE-MsgGUID: Gn750mfYQ5CnXlfBjmQRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="238784850"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:37:32 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v2 15/15] KVM: TDX: Move external page table freeing to TDX code
Date: Sat,  9 May 2026 15:57:40 +0800
Message-ID: <20260509075740.4371-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260509075201.4077-1-yan.y.zhao@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Move the freeing of external page tables into the reclaim operation that
lives in TDX code.

The TDP MMU supports traversing the TDP without holding locks. Page tables
need to be freed via RCU to prevent walking one that gets freed.

While none of these lockless walk operations actually happen for the mirror
page table, the TDP MMU nonetheless frees the mirror page table in the same
way, and (because it's a handy place to plug it in) the external page table
as well.

However, the external page table definitely can't be walked once the page
table pages are reclaimed from the TDX module. The TDX module releases the
page for the host VMM to use, so this RCU-time free is unnecessary for the
external page table.

So move the free_page() call to TDX code. Create an
tdp_mmu_free_unused_sp() to allow for freeing external page tables that
have never left the TDP MMU code (i.e. don't need freed in a special way).

Link: https://lore.kernel.org/kvm/aYpjNrtGmogNzqwT@google.com/
Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Based on a diff by Sean, added log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Fixed typos in the patch log. (Yan, Kai)
- Still kept "Not-yet-Signed-off-by" tag. Sean, please change it to SoB if
  the patch looks good to you.
- Updated the code comment in tdx_sept_free_private_spt(): invoking
  free_page() to free S-EPT page in tdx_sept_free_private_spt() is only
  because RCU-time free is unnecessary, not because it can't be performed
  from RCU callbacks. (Yan)
---
 arch/x86/kvm/mmu/tdp_mmu.c | 16 +++++++++++-----
 arch/x86/kvm/vmx/tdx.c     | 11 ++++++++++-
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index a847a8f09bc6..bb18e9e61542 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -53,13 +53,18 @@ void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
 	rcu_barrier();
 }
 
-static void tdp_mmu_free_sp(struct kvm_mmu_page *sp)
+static void __tdp_mmu_free_sp(struct kvm_mmu_page *sp)
 {
-	free_page((unsigned long)sp->external_spt);
 	free_page((unsigned long)sp->spt);
 	kmem_cache_free(mmu_page_header_cache, sp);
 }
 
+static void tdp_mmu_free_unused_sp(struct kvm_mmu_page *sp)
+{
+	free_page((unsigned long)sp->external_spt);
+	__tdp_mmu_free_sp(sp);
+}
+
 /*
  * This is called through call_rcu in order to free TDP page table memory
  * safely with respect to other kernel threads that may be operating on
@@ -73,7 +78,8 @@ static void tdp_mmu_free_sp_rcu_callback(struct rcu_head *head)
 	struct kvm_mmu_page *sp = container_of(head, struct kvm_mmu_page,
 					       rcu_head);
 
-	tdp_mmu_free_sp(sp);
+	WARN_ON_ONCE(sp->external_spt);
+	__tdp_mmu_free_sp(sp);
 }
 
 void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
@@ -1266,7 +1272,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * failed, e.g. because a different task modified the SPTE.
 		 */
 		if (r) {
-			tdp_mmu_free_sp(sp);
+			tdp_mmu_free_unused_sp(sp);
 			goto retry;
 		}
 
@@ -1577,7 +1583,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 	 * installs its own sp in place of the last sp we tried to split.
 	 */
 	if (sp)
-		tdp_mmu_free_sp(sp);
+		tdp_mmu_free_unused_sp(sp);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 9431bc443d50..2539107e0ad3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1869,7 +1869,16 @@ static void tdx_sept_free_private_spt(struct kvm *kvm, struct kvm_mmu_page *sp)
 	 */
 	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
 	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
-		sp->external_spt = NULL;
+		goto out;
+
+	/*
+	 * Immediately free the S-EPT page because RCU-time free is unnecessary
+	 * after TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding
+	 * readers.
+	 */
+	free_page((unsigned long)sp->external_spt);
+out:
+	sp->external_spt = NULL;
 }
 
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
-- 
2.43.2

