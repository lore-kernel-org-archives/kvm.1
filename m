Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F136165F;
	Thu, 28 May 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958419; cv=none; b=doxESRT6yAAo8Vj4Sm0ngPjn8Nz2cRQkJe/EYGd3UkhzK663tNO0z1EgMLiR8Ckj/W63tKPueVz/lxDDjWmHSGKgxmB8PEeCZVP7D5Pri4ziK8DLQcOpXxFNDVK7n6sLg30MfZXUIgdFaCfU3qfNNa8CDEZS4Rl9LGrBAAuGMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958419; c=relaxed/simple;
	bh=ilIafkVoYtD48zIY75e2dw5j3dVTs5JwMYk0RHoobvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc5te7E0l9DcGvITdZTEGtLNEVQYfPUBLNNgOubo+EFRV0bwNja7b7dESdEQviI/qIb2K1al/ZCcL4b7W7oUBfzsqGkzzCMNBUUzDj/8UpTsw/IWTeukUNeCxaF6LBLiOehVXvK99jIiAJPxl0jIdsF+cqL+RpWTSOu9wFg/Y9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8Vh0mPU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8Vh0mPU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958418; x=1811494418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ilIafkVoYtD48zIY75e2dw5j3dVTs5JwMYk0RHoobvo=;
  b=N8Vh0mPUj4GQBCOGVAnhVGMD3GJ6I8/svax+fjHpecsIHnp1jfmB+hkW
   ZVALSgVJ91BJvp/L84l1Fn++IS9mg+G/WbeXTSUWOfgU1XUm7lFeme1v0
   h1cxumox4Wjaix0A2CFT8MatsIMcpn3b7MrOIJtr3j0f5euoDZnUHSfAY
   qNwu2agV7d+yhZsCPlhTEvJHJBdp659vzTCywSbTq4MDwuNLyAKwXLlwZ
   PwZE05QFObujwcS7sJtFqfoyLxjgXauyAmVGn4g0IEWGm6+PjPhpPuvyK
   6Kj7gMSKZlK41kCdzZ3yvXqrpnkIVkk4lPlFi0d+ZNx4S7GLxGwS9vSaJ
   g==;
X-CSE-ConnectionGUID: 1ASCDbfHRwOb0WB1d+omlQ==
X-CSE-MsgGUID: fl1MdsLzRimy/yqAT0MLSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103469743"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="103469743"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:38 -0700
X-CSE-ConnectionGUID: twjzVqUsQfWhHmPNItis5g==
X-CSE-MsgGUID: FK1Li4oCRwuvhYcujm9r4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="238312178"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:34 -0700
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
Subject: [PATCH v3 15/15] KVM: TDX: Move external page table freeing to TDX code
Date: Thu, 28 May 2026 16:13:30 +0800
Message-ID: <20260528081330.10444-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260528080856.10141-1-yan.y.zhao@intel.com>
References: <20260528080856.10141-1-yan.y.zhao@intel.com>
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

Link: https://lore.kernel.org/kvm/aYpjNrtGmogNzqwT@google.com
Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Based on a diff by Sean, added log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

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
index 74531e4bbee6..5b3041138301 100644
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
@@ -1268,7 +1274,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * failed, e.g. because a different task modified the SPTE.
 		 */
 		if (r) {
-			tdp_mmu_free_sp(sp);
+			tdp_mmu_free_unused_sp(sp);
 			goto retry;
 		}
 
@@ -1579,7 +1585,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 	 * installs its own sp in place of the last sp we tried to split.
 	 */
 	if (sp)
-		tdp_mmu_free_sp(sp);
+		tdp_mmu_free_unused_sp(sp);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index aa0d16b71e00..8a64e8d9566a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1875,7 +1875,16 @@ static void tdx_sept_free_private_spt(struct kvm *kvm, struct kvm_mmu_page *sp)
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

