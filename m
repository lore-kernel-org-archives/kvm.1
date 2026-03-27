Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78C395254;
	Fri, 27 Mar 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642473; cv=none; b=uoUkSoKkU1t5awxQZxIICBWo2ZNYDv9Gg+8rJ0iXwOd4qNB9JZWbF+lqLKGT8eOPQn2hKUHAiXPAI+Tt3LA/5myi9/lfgTy/BA/kl9xPyuep7+PVIo5KzieDf2aExujfxa/tbMgy8Fi877Xzi3F4gpcoAPzp8dtYZueyfEmhLhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642473; c=relaxed/simple;
	bh=abr0DVRaJrQUjS4UvUyOz7NWkr4UifXMcKoeUVR+ems=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxXp5510CEe9zoM8zctPmBw9l6iMlWca9+k688OwWJAwK7PCQ/Y5VJutX2ftPaTe6NCFDIzwXYqAdQCmyhxbFeJXzy16JKHnWg/mbB0a1lSnuEj86rWQgZfBk+c8RTsB3Vt/LxqM9j/yS335Z2ivgFnSlIO224ob8+VtmKx0upE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2ZdCbGj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2ZdCbGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642472; x=1806178472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=abr0DVRaJrQUjS4UvUyOz7NWkr4UifXMcKoeUVR+ems=;
  b=c2ZdCbGja7lccrrmSphwxvp/mPGWvUMixg54nPFlbn60u6i6B9CHnPja
   JxkXSDzHB6ZdZzVFKQXS179noWvXWSltqckFnd3fw492iE9svkAdx9kBc
   Q9mngPadRyNMFNlGcPVym2KeasTjhv9rBx23G5Rj02WtYHzRIRu0gNi9T
   5N/SB8xWo0SKYdXIgPXxWxRA/w0HN3UiNr41qraF14CbU6gJIxNdxB10p
   Rl4WdKEdrv4cNEtnCb1Guf637XTUyjQwKL1o1s9O/Vnms/XnhFL/nOlD6
   4ErY37UTXLeGab2ZEBPSsKkGQJ6iMSxB7YH3SG2E6pzyPtZ9m2KpSvy8u
   A==;
X-CSE-ConnectionGUID: iQFhSQu2QpO+eox8OGBC/w==
X-CSE-MsgGUID: 69/M40x+ST2Q9Vb6r30wPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182735"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182735"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: CxBgY5HBRHyMHg+b56uYxw==
X-CSE-MsgGUID: 4tSjUdxVQs+c/5HkNhf0Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922904"
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
Subject: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte() check into a KVM_MMU_WARN_ON()
Date: Fri, 27 Mar 2026 13:14:10 -0700
Message-ID: <20260327201421.2824383-7-rick.p.edgecombe@intel.com>
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

Remove the conditional logic for handling the setting of mirror EPTs to
frozen in __tdp_mmu_set_spte_atomic() and add it as a warning instead.

Mirror TDP needs propagate PTE changes to the to the external TDP. This
presents a problem for atomic updates which can't update both at once. So
a special value, FROZEN_SPTE, is used as a temporary state during these
updates to prevent concurrent operations to the PTE. If the TDP MMU tried
to install this as a long term value, it would confuse these updates.
Despite this __tdp_mmu_set_spte_atomic() includes a check to handle it
being set. Remove this check and turn it into a warning.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 0809fe8e8737..338957bc5109 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -656,7 +656,13 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 */
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
-	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
+	/*
+	 * FROZEN_SPTE is a temporary state and should never be set via higher
+	 * level helpers.
+	 */
+	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
+
+	if (is_mirror_sptep(iter->sptep)) {
 		int ret;
 
 		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
-- 
2.53.0

