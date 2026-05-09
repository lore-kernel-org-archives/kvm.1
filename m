Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164F345CAB;
	Sat,  9 May 2026 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315766; cv=none; b=ktZUbrjTz081pOEwhDkfDYMLXmbtN0WR9HwAyZzcZWvt5PJfJhBokpXc8FOA0QpRGnSHN1Aew/O7u1G/uALbZq0CiW6/DnG15rPsrCEoLMN0YmYeTgoXHsFWOrZojUwWtrC82EKVvgUGUziJoE5Jn8w88lW3hiV21RZlxtM72ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315766; c=relaxed/simple;
	bh=D1Iad4MZlURrN+EJfCKymz0sx8uZtENNlCbI6OF/EJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPJjChSD+1dwzEyA8n2rVITUnoNMLqmyGsxH4ES91guIo1NIGyytBXVp1PTAW6wOVOMPveZfuBYh+Rsej7f/0yCikbc8yGeJgCyW4HVsMkFXtNZB0SHdhOIPGrerhTghyJwj8QFJyvq1aFTO8skUeKrcHyDt6obuiJnuCB4Sfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ktIYdt05; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ktIYdt05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315766; x=1809851766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1Iad4MZlURrN+EJfCKymz0sx8uZtENNlCbI6OF/EJ4=;
  b=ktIYdt05a8RnfEYs9P+D0Ffo+4JN/M5lxK8JkvDCu7VR7tgPmyvP6DND
   ml7Nhmq4QDRvcndFjSUYGLqFMXOFGLTxyZ/5ZrLKDE3YKhlQFyh0YjmQG
   iJL8yncqerBbvMcUeU6h0Kc/0n4In84oG0eczVclvUtgQf6jwbs45STXQ
   U2G1XfqTEy29xhS94woqVlYX3UIUXMuwwJP6Ys73nQfCYdifu/QLNuksN
   NbBYa233Tjr85sButHYpzF0VA2pDqC+EKlHt2554eTXPPTUga6NDUNZ+l
   5N/HIyUGGHlMib5JWgbFhgCElAluF47dC8lCFhqa5q+W4qZ4irUAX3I5G
   Q==;
X-CSE-ConnectionGUID: NCJJ4z5pSuC0Fil/3VZ+vw==
X-CSE-MsgGUID: iUuL/zqnRN2+wXFKXuJeRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90388059"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90388059"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:05 -0700
X-CSE-ConnectionGUID: RmJm6zgqTQ2hNZC4RbHbLw==
X-CSE-MsgGUID: EbPXwMNuRg+cBCMsPufxmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="236152980"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:02 -0700
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
Subject: [PATCH v2 07/15] KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a KVM_MMU_WARN_ON()
Date: Sat,  9 May 2026 15:56:09 +0800
Message-ID: <20260509075609.4242-1-yan.y.zhao@intel.com>
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

Remove the conditional logic for handling the setting of mirror page table
to frozen in __tdp_mmu_set_spte_atomic() and add it as a warning for both
mirror and direct cases.

The mirror page table needs to propagate PTE changes to the external page
table. This presents a problem for atomic updates which can't update both
page tables at once. So a special value, FROZEN_SPTE, is used as a
temporary state during these updates to prevent concurrent operations on
the PTE. If the TDP MMU tried to install FROZEN_SPTE as a long-term value,
it would confuse these updates.

On the other hand, it would also confuse other threads if FROZEN_SPTE is
installed as a long-term value for direct page tables (e.g., causing
another thread working on atomic zap to wait for a !FROZEN_SPTE value
endlessly).

Therefore, add the warning for installing FROZEN_SPTE as a long-term value
in __tdp_mmu_set_spte_atomic() without differentiating whether it's a
mirror or direct page table.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Updated the comment for "KVM_MMU_WARN_ON(is_frozen_spte(new_spte))".
  (Yan)
- Explained why the warning also applies to direct page tables. (Yan)
---
 arch/x86/kvm/mmu/tdp_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 401bb49a91ee..345fdb0a89fb 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -609,7 +609,10 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 */
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
-	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
+	/* Should not set FROZEN_SPTE as a long-term value. */
+	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
+
+	if (is_mirror_sptep(iter->sptep)) {
 		int ret;
 
 		/*
-- 
2.43.2

