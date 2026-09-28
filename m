Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA7348BD54;
	Mon, 28 Sep 2026 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586613; cv=none; b=bfTpPg1OIexcI8VEzTy8ibBKT14xbB+6wyZr/0+A24wmiRwwQD4TfWty3asSQSjbK/WmZzp/L1QM+pY0GzhsrB4xMd98Jtea6woB1CTDpm9hb/3htrp0C4VfUQs8qfTE32ksbQO7u0b4ScYEeK0TswoWGEQvo3SMfm83m/rsdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586613; c=relaxed/simple;
	bh=h82l3mPMyI9n94gF5q8z/uGfUpU1EUnaz5a861LkT4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANjDP627tbNy5eR5/05IrOa2gfPqmznsEhu03Wx4mmIi5ybusaEyHdwWU5D4wB5w0WyqCcCg8QJ9sZt0ja+dE7XAL5CToKDgiUFlbQ0XqfdQUHiNWlhnlH+UMs18FujOV+DSraERrEkvTZgeVjqodGhA9zzdrZOs3LCYdknys78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff/fk6QV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff/fk6QV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586611; x=1822122611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h82l3mPMyI9n94gF5q8z/uGfUpU1EUnaz5a861LkT4M=;
  b=ff/fk6QVpO7aWSwY+JzukFA6zfdb8r+AmVSpSPP0cMdtkGKfX3RXTRqk
   DtE0l4rkixPGAb5jN9O3g6DYoAVD1ElApP/Q8td6HQZ9kiW747muy0gcn
   tRGCETpzXWp3O84aCvgs8ZEZrGonf5fsC/TcZ7I6k/qdzqsTGpwNwD2el
   xVAM+vg8ZNrVqJyQiohID1ILo3uZ47JuTD9dYCmG4/ZX18WoJR/P/s6zW
   04My9Bw5k5V9gqHM5/vVcxHrrV0ouqSwjCEYQFaVQhiONfSls24lTl1ez
   RPKeaUGdVM+lDjBsn3YfWzRCM2/7QqaCnxFhMAYGwsuF30HNwinA331LC
   A==;
X-CSE-ConnectionGUID: GJVmtcMVTm2SFvKNMl4sIw==
X-CSE-MsgGUID: m/6L3RBmSmqAOt7rYODlmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="101938482"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="101938482"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:10 -0700
X-CSE-ConnectionGUID: AyDoN14dRPiAOih4BjTy5g==
X-CSE-MsgGUID: 3AWBhKvIThK4g/aL4Su3bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275120455"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:05 -0700
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
Subject: [PATCH v4 04/17] KVM: x86/mmu: Prevent huge page promotion for mirror roots in fault path
Date: Mon, 28 Sep 2026 17:09:31 +0800
Message-ID: <20260928090932.15535-1-yan.y.zhao@intel.com>
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

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Disallow huge page promotion in the TDP MMU for mirror roots as KVM doesn't
currently support promoting S-EPT entries due to the complexity incurred
by the TDX module's rules for huge page promotion.

 - The current TDX module requires all 4KB leafs to be either all PENDING
   or all ACCEPTED before a successful promotion to 2MB. This requirement
   prevents successful page merging after partially converting a 2MB
   range from private to shared and then back to private, which is the
   primary scenario necessitating page promotion.

 - The TDX module effectively requires a break-before-make sequence (to
   satisfy its TLB flushing rules), i.e., creates a window of time where a
   different vCPU can encounter faults on a SPTE that KVM is trying to
   promote to a huge page.  To avoid unexpected BUSY errors, KVM would need
   to FREEZE the non-leaf SPTE before replacing it with a huge SPTE.

Disable huge page promotion for all map() operations, as supporting page
promotion when building the initial image is still non-trivial, and the
vast majority of images are ~4MB or less, i.e., the benefit of creating
huge pages during TD build time is minimal.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
[sean: check root, add comment, rewrite changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/mmu/mmu.c     |  3 ++-
 arch/x86/kvm/mmu/tdp_mmu.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 266109d18536..a9a7c015256b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3533,7 +3533,8 @@ void disallowed_hugepage_adjust(struct kvm_page_fault *fault, u64 spte, int cur_
 	    cur_level == fault->goal_level &&
 	    is_shadow_present_pte(spte) &&
 	    !is_large_pte(spte) &&
-	    spte_to_child_sp(spte)->nx_huge_page_disallowed) {
+	    ((spte_to_child_sp(spte)->nx_huge_page_disallowed) ||
+	     is_mirror_sp(spte_to_child_sp(spte)))) {
 		/*
 		 * A small SPTE exists for this pfn, but FNAME(fetch),
 		 * direct_map(), or kvm_tdp_mmu_map() would like to create a
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad1..001449142d32 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1233,7 +1233,17 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	for_each_tdp_pte(iter, kvm, root, fault->gfn, fault->gfn + 1) {
 		int r;
 
-		if (fault->nx_huge_page_workaround_enabled)
+		/*
+		 * Don't replace a page table (non-leaf) SPTE with a huge SPTE
+		 * (a.k.a. hugepage promotion) if the NX hugepage workaround is
+		 * enabled, as doing so will cause significant thrashing if one
+		 * or more leaf SPTEs need to be executable.
+		 *
+		 * Disallow hugepage promotion for mirror roots as KVM doesn't
+		 * (yet) support promoting S-EPT entries while holding mmu_lock
+		 * for read (due to complexity induced by the TDX-Module APIs).
+		 */
+		if (fault->nx_huge_page_workaround_enabled || is_mirror_sp(root))
 			disallowed_hugepage_adjust(fault, iter.old_spte, iter.level);
 
 		/*
-- 
2.43.2

