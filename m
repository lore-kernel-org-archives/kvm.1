Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544639EF07;
	Fri, 27 Mar 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642475; cv=none; b=I9UupB6+vh+jW2aE+mFb8kA3s+/DcH5q3jl2Y9T6kmQGU9u99E5vejPWkXskSO7pY8NC4T7jVxssdhmld4nD9hxesrUlNC3wzDP3OnSeiACmI937PV/nNPbn4SnJkcEVw2m3qUqL6GpaJGIXH5R3X0EaoAwYCqznqj0W1B587L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642475; c=relaxed/simple;
	bh=GKUvVoOuQqfZL+XhpxIs2FU6agVmOLJYI6aybNd00tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABjETGYqbqD76cEtE2drJMpLIY7SfLnqunN12+W0DOZtedG6lzmeVTLgB08PFdGTpfbk9cgmiiCOoVpwG3C10X/rN3oIMOuRkmgLHk1if2K2CrEMsXaw/E9z+FZ/+UgfYCrtXQ3eEVcmtCwqmU7jtBwiSTyxnRkQOr2eXg2zvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xj3oIbMM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xj3oIbMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642474; x=1806178474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKUvVoOuQqfZL+XhpxIs2FU6agVmOLJYI6aybNd00tE=;
  b=Xj3oIbMMEnW5DLuqbR018fsgPiKcAEarsv86aUvQ9Y8z/2SAf29v2NS0
   BlkZtD8iU6sbPQPNZAJTRXe+x1O6K9npVvd8tmXpFyv5Rk8fYxbpivuSE
   PNH2MnzP9PT7sUykStHtTfbyaO/vytAT9Nb72vf/DWwylJ7Xq2YEys5Ex
   fqJH/NW6CJKBTA+9jd/uOT3/8SANg1GFRz6TqlAS+m1yV4gbVvlICWcnX
   5eOioaF9jl46WZOndw9gegu+Zp1sQjCnjkOYbfFxevWhVX4TRhUQCGto/
   6hcg/2lgxDdMMFdzwMO4nABulwTm4H3BdhdbEUIurTkBElj+d4paGUOJt
   A==;
X-CSE-ConnectionGUID: RT24oYIvTQKv5paHsE5gkQ==
X-CSE-MsgGUID: 0t3HK5/fS3+c07ltThjxrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182751"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182751"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: SnRL7m/DQjWbb/TmIz7IDg==
X-CSE-MsgGUID: jgYyI5yqSdahF74SyqC7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922919"
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
Subject: [PATCH 11/17] KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
Date: Fri, 27 Mar 2026 13:14:15 -0700
Message-ID: <20260327201421.2824383-12-rick.p.edgecombe@intel.com>
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

From: Sean Christopherson <seanjc@google.com>

Fold set_external_spte_present() into __tdp_mmu_set_spte_atomic() as all
the other functionality besides calling the op. It now is a single line
helper that is called once.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6763537098ee..85c92aec868f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -494,13 +494,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
-static int __must_check set_external_spte_present(struct kvm *kvm,
-						  gfn_t gfn, u64 old_spte,
-						  u64 new_spte, int level)
-{
-	return kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
-}
-
 /**
  * __handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
@@ -600,7 +593,7 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
 	} else if (is_mirror_sp(sp) && is_present) {
-		r = set_external_spte_present(kvm, gfn, old_spte, new_spte, level);
+		r = kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
 		if (r)
 			return r;
 	}
-- 
2.53.0

