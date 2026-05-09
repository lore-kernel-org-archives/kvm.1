Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6338B7D8;
	Sat,  9 May 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315754; cv=none; b=Oa45wRX3EUOWa+6Sgbr1znYLA+ynsvWwp+msQQFyYjqihZKFsYmeGu7gITyZlxyLAm8u7cNYAyjk61NerfOPi4TFBndrbStsusR48u0rt63JmkWWdySoSfPdLGQMpFQaBdCOmmE0IVXlxZQVXNLhkq3PO9QNz3ukx68X9h5lIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315754; c=relaxed/simple;
	bh=Ceydaom24DfcEFjSJM4tuodGfAHyBHsKt8PnRO0XXh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbAf1khZPfNgiDIDoTxufT3MJYXcijIoAnKzl8vVy0+vdtw9kU9YsO0RevtXRrJf8KMvfJWOZljzhfmhyNGtnxsQLUp9lntILVZA9FgjSCDhHBa/Dg5OxMExT6KdKPifYCJVuO+sdDHrOzPSMueGl0sRiEWkjEa98lnKmJwQGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkF64O9O; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkF64O9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315753; x=1809851753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ceydaom24DfcEFjSJM4tuodGfAHyBHsKt8PnRO0XXh0=;
  b=ZkF64O9O4obI+jFowcwZ4scmEimuln9XiVy/vSMU0pcHeFKFLwC+ROTH
   QOP5v1Yn1Habk3szuS5CRfgLelwaqHS2fHS9cC7QoI+Fly2t1lNOLChH2
   k0c2ncp8ks1v8OgvPWM7aytXnU/0OM0HHiI4+mnyP/QOg7tiEApVEugj0
   +MHy1m+s+E/Jc0o4GkJ1HSGMFkWn9KWDi1VpgQVbkKWztdiGqjN0k+4+L
   evuvhaJ5rR8FQQYDsDCQP4NzQr5ghSkuTFgEycIXjDCIkRSCCd67Uwmcl
   fb8ZGVb40K08yxmEVg5YjSJROsiq/qiKoKmlySgcmfRFWhMb6g/L8zUIJ
   Q==;
X-CSE-ConnectionGUID: ahdRaL+8QBuwcSIeRv2LNg==
X-CSE-MsgGUID: 3QuVGUU/SFKBqS4XIdAmnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748339"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748339"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:35:53 -0700
X-CSE-ConnectionGUID: cdaHKLqsQHGHbMClpWbOpg==
X-CSE-MsgGUID: IxykrO9YRG21at9gyUNm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237086908"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:35:49 -0700
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
Subject: [PATCH v2 06/15] KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX code
Date: Sat,  9 May 2026 15:55:57 +0800
Message-ID: <20260509075557.4226-1-yan.y.zhao@intel.com>
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

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Move the MMU lockdep assert in __tdp_mmu_set_spte_atomic() into the TDX
specific op because the assert is TDX specific in intention.

The TDP MMU has many lockdep asserts for various scenarios, and in fact
the callchains that are used for TDX already have a lockdep assert which
covers the case in __tdp_mmu_set_spte_atomic(). However, these asserts are
for management of the TDP root owned by KVM. In the
__tdp_mmu_set_spte_atomic() assert case, it is helping with a scheme to
avoid contention in the TDX module during zap operations. That is very
TDX specific.

One option would be to just remove the assert in
__tdp_mmu_set_spte_atomic() and rely on the other ones in the TDP MMU. But
that assert is for a different intention, and too far away from the
SEAMCALL that needs it. So just move it to TDX code.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 --
 arch/x86/kvm/vmx/tdx.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f55967f8d74a..401bb49a91ee 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -612,8 +612,6 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
 		int ret;
 
-		lockdep_assert_held(&kvm->mmu_lock);
-
 		/*
 		 * We need to lock out other updates to the SPTE until the external
 		 * page table has been modified. Use FROZEN_SPTE similar to
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 0ded336fbf70..48aa7936a7f7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1721,6 +1721,8 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
+	lockdep_assert_held(&kvm->mmu_lock);
+
 	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
 		return -EIO;
 
-- 
2.43.2

