Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3439280C;
	Fri, 27 Mar 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642471; cv=none; b=aH+X9ycZTPOkNSwkCra2xL5EzPvx6vmhxX/wgj4k5CnKzVXKL184Wv+gAJh1XihHpofl3w8Go2WsxCYQioAgCywgDh6PPiqUHuQC8ZnkIHAqwAs6RlVpfkCXL8XrIE4cqEn/rL/xYnG3DLPRAIFOzbhiFed6BNO20aJ7GN6DvvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642471; c=relaxed/simple;
	bh=oCWebE5dfUT3EHbwMQ1dAxf5XfEn+nRJlGBxh/ODp1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0Fp9Y+wX6N9SJJ8MC6FXwGwgjYkVZlmon1LWjWxhmGSMv9rmQITT8aulrG9DoExQXsZSTTk11NDf+rfqK+w47OOSEyaILiUalg7piVQtnHALoFBtnH3jDEM2YzCPPcvK2gKkBNjWPS0sb9D/NQ3vj9I8pjG2Lri7epxFvvy+Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpBUwRuf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpBUwRuf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642470; x=1806178470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCWebE5dfUT3EHbwMQ1dAxf5XfEn+nRJlGBxh/ODp1s=;
  b=BpBUwRufVdY6Z7A53uz05gqx7W8OvZ0BNPtkD9Ofu45HvR2UpLoME4dV
   GoD/y3vPZDFGpMuyyWSmQVoMvqZWTPXkLLaQ72j8Jz+nk9qjsM7Q+Masb
   JqcByyhQq/ytEZTe6nQZ1kemg06fuxe0If23MlOilf6q1zVc7oJYMWQBq
   sOhWFPYrggTS9qTShbWa2T0BDRXObpAKJepoWvL5o+AoxAKLv5TieOH5I
   tvz9r3PbeVMCgwSiOnSE5aGdR/R2JDY4X8JA/zqvTIPYysfhQsNR6VGdS
   douhAN3lUODH1hQLnui+MtY4bYo+JWsuIXePcLzQqsP10e2XHcuAXbchX
   A==;
X-CSE-ConnectionGUID: zN9tAsY4Rc2A6ntAWUuM6Q==
X-CSE-MsgGUID: b+gz9oixQRCoAaW0cf71fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182726"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182726"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:27 -0700
X-CSE-ConnectionGUID: +BuDfg5XRpa/sIutqk2jLQ==
X-CSE-MsgGUID: NuTIf+gQRQSIL6oNlJilvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922901"
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
Subject: [PATCH 05/17] KVM: x86/tdp_mmu: Drop zapping KVM_BUG_ON() set_external_spte_present()
Date: Fri, 27 Mar 2026 13:14:09 -0700
Message-ID: <20260327201421.2824383-6-rick.p.edgecombe@intel.com>
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

Drop some KVM_BUG_ON() that are guarding against TDP MMU attempting to
propagate unsupported operations to the external set_external_spte() ops.

Despite the generic naming, external TDP ops are designed completely
around TDX. They hook the bare minimum of what is needed, and exclude the
operations that are not supported by TDX. To help wrangle which operations
are handleable by various operations, warnings and KVM_BUG_ONs exist in
the code. These warnings and KVM_BUG_ON()s put the burden of understanding
which operations should be forwarded to TDX code on the TDP MMU
developers, who often read the code without TDX context.

Future changes will transition the encapsulation of this domain knowledge
to TDX code by funneling the external EPT updates through a central update
mechanism. In this paradigm, central update mechanism can encapsulate the
special knowledge, but will not have as much knowledge about what
operation is in progress. So remove the set external SPTE based
KVM_BUG_ON()s in preparation for this future change.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index dbaeb80f2b64..0809fe8e8737 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -512,13 +512,10 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
 						 gfn_t gfn, u64 *old_spte,
 						 u64 new_spte, int level)
 {
-	bool was_present = is_shadow_present_pte(*old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	int ret = 0;
 
-	KVM_BUG_ON(was_present, kvm);
-
 	lockdep_assert_held(&kvm->mmu_lock);
 	/*
 	 * We need to lock out other updates to the SPTE until the external
@@ -662,13 +659,6 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
 		int ret;
 
-		/*
-		 * Users of atomic zapping don't operate on mirror roots,
-		 * so don't handle it and bug the VM if it's seen.
-		 */
-		if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
-			return -EBUSY;
-
 		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
 						&iter->old_spte, new_spte, iter->level);
 		if (ret)
-- 
2.53.0

