Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD62E382F01;
	Thu, 28 May 2026 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958320; cv=none; b=S3gURNaK52hYwmYWOejiUpoXdq2escTelUr+n2JNGUQXQv3dRuMqULVn2DLwROXd2P/v+FGq4K2M/ffGo5DdQN2hmJLwsHdSAhoaced1q+sKwJeivzlVxlhAqvmBIU7PvTtTy9SEtpg3HzwqIarPYqR6VTYxa70C34wkc4VJR5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958320; c=relaxed/simple;
	bh=DNyqlt01HmGjeWRhvKJSBQpk0mSCRc9/JsFqqZyNOsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr+b0zJqGUPapAs3RaiakUj8cMyfNAqjEH9OORFKulC86Y/f/LrIXegYrzsxorZxRJ8QRp//Vg2bM+ILKKOx6IZXK3VkQsuBnnONG1oCkco9mkENcOIgODRtR2dJNIA9bXnFqSkyd8Zyj5MFM9vWlnLNUIyO9wAyV/FEcP5U18M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTSA97jY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTSA97jY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958319; x=1811494319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNyqlt01HmGjeWRhvKJSBQpk0mSCRc9/JsFqqZyNOsA=;
  b=nTSA97jYTObdTwT+xeWmgKxi0OWcgWy11W7Jzgj/hOEr9dHxzDWGsFBO
   Gpao+sT2cQieaA/lBvikoIVNWbdhA3dcZGMy+RnDHQlZEfqHnjUfoYXy6
   mWUwKW3qequ0eVTwdDxUo2SAyrUNHGgkZ312rMhX3W0KPX1pHujtgzOzL
   y5QDzAzIIszhtJM8He6jNtkxBYYbbAsYBzBGBtdkKJraeS/4LatG/A0/t
   vDRvy3Qx2IyY/zIWPeCH66bZZoN+xo0y0o0wbn8mHi4Q5jDDcbYtho9Ch
   2JLZlrY6+9h59j6+z2jUwZuHD+eg7GbKLqXJ/mM8CZI9UzIpkF9a7y0iP
   w==;
X-CSE-ConnectionGUID: 1zpWMlA5Simv2SkJCWyTjQ==
X-CSE-MsgGUID: 0VvKmfzWToeKsLsK0xiPQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80765346"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80765346"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:58 -0700
X-CSE-ConnectionGUID: mshhUnOvRBaVv3oSpQoYiw==
X-CSE-MsgGUID: hRPyJwSST6WDf02BAJYxkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="280605243"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:55 -0700
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
Subject: [PATCH v3 06/15] KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX code
Date: Thu, 28 May 2026 16:11:51 +0800
Message-ID: <20260528081151.10300-1-yan.y.zhao@intel.com>
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
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 --
 arch/x86/kvm/vmx/tdx.c     | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ed806a4768c2..dc455e6e7dc7 100644
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
index e8eab25f3159..4ff5ae31eb66 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1727,6 +1727,8 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
+	lockdep_assert_held(&kvm->mmu_lock);
+
 	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
 		return -EIO;
 
-- 
2.43.2

