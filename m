Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C83A1A28;
	Fri, 27 Mar 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642477; cv=none; b=Xo5pVfurusPHsi+vSZaWbApUcsYFgUNLZT7VTnBUhPorBJcpKzqAKHAAYiswCZl5nzJKrsTJ4GCB21jcl1TIl4ZTMUIZWSE5Wc4HksMs/dIKjq2rFjRpKWj9wDKezn9pHxwJFPwgm5R6lhMT0OcoUqnq9MR4S/STO74jTGah4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642477; c=relaxed/simple;
	bh=dkV8/VaHw1LjR8ZDe+MBkWOtj9V/JPG3RtWWXnYPP3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO5l7KBhly21ICo8shGKZABc+fZQqz1Hu6Slsev3AYvyyu4oXCoXLtSffGsMhzrzEBAxzrXAWkCUjoTZBhQFEcD08CWkb9QAn6fO/uzDuwKZPJaAl+XkRiWX3nPHbm2iNJXKoh0+PksdcmG1TjuUwicsmdGAbdeZkj3OzAdCdCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHiCMCzg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHiCMCzg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642475; x=1806178475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dkV8/VaHw1LjR8ZDe+MBkWOtj9V/JPG3RtWWXnYPP3w=;
  b=oHiCMCzgdLhCeOYnO/vvvUHExtaIPjgybcaZsCDo5sppMxtPsoPFsy27
   7UqJ0YLQvbUSK703cCmn5O9QYqdIz5Y1FyEEFqSSyweCZj4vNnRxczBz5
   LpDzHbispdHc6kiF/+UVPwrSBPYVo03r+OuUgPmVzaJyKqnDUPYV8CM5c
   l37JUyZuKj1VnMICDSI0H1EJwyn2eS+lOBURXy7rZzXViQgybn8jUvLlQ
   m10ZhewMvUi33Bm9LdR0FTR0x4eSCgaD8ncqqoLyoKEoaxdyz9vaVK6r0
   VdwkviYE4wkj0NqlZTR68MzureWJuuFBIKCboMjq4FXPgVkLvd/C0h/d6
   Q==;
X-CSE-ConnectionGUID: 0QUwuGVJQWux9AJE3m6iDA==
X-CSE-MsgGUID: Aei7RA5CRBeUPUkXDBepyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182746"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182746"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: umOxig8bQD2qK5cM7loEjg==
X-CSE-MsgGUID: BRfDipE9TS2t+AyBi335Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922916"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 10/17] KVM: TDX: Move set_external_spte_present() assert into TDX code
Date: Fri, 27 Mar 2026 13:14:14 -0700
Message-ID: <20260327201421.2824383-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the MMU lockdep assert in set_external_spte_present() into the TDX
specific op because the assert is TDX specific in intention.

The TDP MMU has many lockdep asserts for various scenarios, and in fact
the callchains that are used for TDX already have a lockdep assert which
cover the case in set_external_spte_present(). However, these asserts are
for management of the TDP root owned by KVM. In the
set_external_spte_present() assert case, it is helping with a scheme to
avoid contention in the TDX module during zap operations. That is very
TDX specific.

One option would be to just remove the assert in
set_external_spte_present() and rely on the other ones in the TDP MMU. But
that assert is for an a different intention, and too far away from the
SEAMCALL that needs it. So move just move it to TDX code.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 --
 arch/x86/kvm/vmx/tdx.c     | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6dc08fe22841..6763537098ee 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -498,8 +498,6 @@ static int __must_check set_external_spte_present(struct kvm *kvm,
 						  gfn_t gfn, u64 old_spte,
 						  u64 new_spte, int level)
 {
-	lockdep_assert_held(&kvm->mmu_lock);
-
 	return kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
 }
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 361a75b42ae7..b44a9c96c89e 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1722,10 +1722,11 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, u64 mirror_spte)
 {
-
 	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
 		return -EIO;
 
+	lockdep_assert_held(&kvm->mmu_lock);
+
 	if (!is_last_spte(mirror_spte, level))
 		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
 
-- 
2.53.0

