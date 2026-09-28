Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9264648D88E;
	Mon, 28 Sep 2026 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586645; cv=none; b=ru2S1dnIf8aaXcXsTvrjULZl9l8gibFMea8lDfXntOfpugO56xXkSwOZqOTWc159r3W2+PO6yEpsWH39XIMIF/0SnFdJMenM9KDpgOqrwMcYEqe2U9leb4kllm8vVrGlsQoH2A5CD16Kg+rzQpQGMLTyV4DvhdkJV73ozaaZbEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586645; c=relaxed/simple;
	bh=AAq1RVzqG6l3botCdG86t4B7fwf5FhCkgjkcqcyPKaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMyxefWtPYZY5jqZ0g8D3AWupJrPPwxbSZg4sYZNlC3vSxTn0vUGDFZVwcf/Sn8Kb3T25j8IykdWOviFySMAFenqYNlZgIOoYCk72VTQp5DRxxX9JQKhYGaE0T2RA+WG4byALga4Bv41BKEbvEbcjBbmcF5K9TAsour3b0gX87o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIagDtC2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIagDtC2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586645; x=1822122645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAq1RVzqG6l3botCdG86t4B7fwf5FhCkgjkcqcyPKaU=;
  b=UIagDtC2wHThzwbYN3i04B2y+WoeKFZDKlsavrH+/nXAbyAD8HWm4vVN
   LSzpELoEyL+Fi1UiWIoghjb4D5eaaNTOoqNPLEXnQgIno1YCKMhRRuA3a
   FxJjWnK8QXPsbHhXqdHqlLr8B3Bs8sd6iGOtCu3Wo/qODkK/jTuZD7qaA
   d93uJ46Vtsj0P4ujZVVgEpZFdlBgcbsOgfAUuOThTCcazTc5llWP/tXjh
   O0OiHaiuuAT+kOMRlJ7LdH0wySv0aIYYC6R7yepmnUIsuiI/BAbl7sQqY
   oam1nQMrbqPtSVugIqQfqitStcznT4W1lDWH4ZlAaB1SmFBu6ZHaIrP/j
   A==;
X-CSE-ConnectionGUID: Ea96QoRSSvKfwgpiRgjOCA==
X-CSE-MsgGUID: S5cNzOy3SQGRJuOD5jK48A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323330"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323330"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:44 -0700
X-CSE-ConnectionGUID: c+eYX7ftQrSgnHCBi9PpeA==
X-CSE-MsgGUID: YYOiF+lESBGyYtVRhuQ5Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="304487080"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:39 -0700
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
Subject: [PATCH v4 06/17] KVM: x86/mmu: Allocate DPAMT pages for vCPU-induced page split
Date: Mon, 28 Sep 2026 17:10:05 +0800
Message-ID: <20260928091005.15567-1-yan.y.zhao@intel.com>
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

From: Sean Christopherson <seanjc@google.com>

Extend the TDP MMU to allocate Dynamic PAMT backing pages (DPAMT pages) for
vCPU-induced huge page splits in mirror roots when DPAMT is enabled.

Leverage the .topup_external_cache() interface to topup the DPAMT cache
when allocating a new child page table for splitting. The DPAMT cache is
currently a per-vCPU thread-local list. When a vCPU-induced page split
occurs, DPAMT pages can be drawn locklessly from the list.

Pass min_nr_spts as 1 to .topup_external_cache(), indicating there's one
new S-EPT page table page. So, tdx_topup_external_pamt_cache() will
allocate DPAMT page pairs for both the newly added S-EPT page table page
and the demoted guest private page.

tdp_mmu_alloc_sp_for_split() is currently not reachable from a non-vCPU
context for mirror roots, since dirty page tracking is not yet allowed on
mirror roots. So, simply add a WARN if tdx_topup_external_pamt_cache() is
invoked under a non-vCPU context.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4: new patch.
---
 arch/x86/kvm/mmu/tdp_mmu.c | 24 +++++++++++++++---------
 arch/x86/kvm/vmx/tdx.c     |  3 +++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f3311317a63a..472419963a19 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1475,21 +1475,27 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(bool is_mirror_sp)
 		return NULL;
 
 	sp->spt = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
-	if (!sp->spt) {
-		kmem_cache_free(mmu_page_header_cache, sp);
-		return NULL;
-	}
+	if (!sp->spt)
+		goto err_spt;
 
 	if (is_mirror_sp) {
 		sp->external_spt = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
-		if (!sp->external_spt) {
-			free_page((unsigned long)sp->spt);
-			kmem_cache_free(mmu_page_header_cache, sp);
-			return NULL;
-		}
+		if (!sp->external_spt)
+			goto err_external_spt;
+
+		if (kvm_x86_call(topup_external_cache)(kvm_get_running_vcpu(), 1))
+			goto err_external_split;
 	}
 
 	return sp;
+
+err_external_split:
+	free_page((unsigned long)sp->external_spt);
+err_external_spt:
+	free_page((unsigned long)sp->spt);
+err_spt:
+	kmem_cache_free(mmu_page_header_cache, sp);
+	return NULL;
 }
 
 /* Note, the caller is responsible for initializing @sp. */
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 11792a490330..3dcddf1b48c5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1630,6 +1630,9 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 
 static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
 {
+	if (WARN_ON_ONCE(!vcpu))
+		return -EIO;
+
 	/*
 	 * Minus one page to exclude the root SPT, but plus one page for a
 	 * possible 4KB private mapping.
-- 
2.43.2

