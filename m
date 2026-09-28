Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0438848BD3B;
	Mon, 28 Sep 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586642; cv=none; b=qUbvw18CaC+D1h+f8+Dxjr/zTAdLqE6iPNkxJn5acnhmNYhwEpPI0bAI6TxlRv+jDIDXIr+B0X9O5wPzxjYknqrnB3+OUxnZm7ST7VA4SWmmaJ/lz9U4I7n0KQPaCqNk12Ef39F/+DAKNCG4M1roaG60eZJp4fR7SmLbqrNh11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586642; c=relaxed/simple;
	bh=EY1bespzjGnuC5RVtlkNh5SkE+tN047x8njGv4VhDBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5Ot6IKNdRtPG/i2am/c+LMK1A1jAy0Ro+h8wI1Nt4BoYjG4xqg1tD6qJ5GEEfeiEcMXYfJcWP58Dc3qb0F1Rh9qTyQNa3Chwi2KlOQ3d1l2RQWWPJaCMyupqOIX8u6ohFonw1KXKQhb0GikvwK2sbHGVfmGxJ9MZSDmIWNGsvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eza85sMq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eza85sMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586641; x=1822122641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EY1bespzjGnuC5RVtlkNh5SkE+tN047x8njGv4VhDBQ=;
  b=Eza85sMq6VFvU3jwZL/K5fxBHrpf2Cls0V0DnQU8lyfvRVyOU0dN7bTA
   ImhmryGaDDuCbxxbx72ImNx/K6I63uS2YjVkza6Jpi7+nfjXr8+1KQZZz
   YGWzD5DikyHXLj6GRVypS1SjDC0Qp7XbVKw/6zUXUzDiVl+rg5+DBxqZ1
   AoUmQ6RcnHkGZkKyFnpS2udipAVQBZQji8xDOHmeTcl7EQcF5iA4nUY0t
   934rU3C2HvLL1aCcul4eR+nqtxQ5WL6Mm7vxiDJ2B2cAzn52niGXtizbg
   iKhRTkTIMwXjxwFfiMsb6u2uObBqRmWjyl73cwc/5YlV/W6wvJM1XJt6K
   A==;
X-CSE-ConnectionGUID: Hqbu/e2pQr2QdZ2x0lmxKg==
X-CSE-MsgGUID: HMzmo3mqQFmFHoR9kjqZ6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90148023"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90148023"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:25 -0700
X-CSE-ConnectionGUID: zntLRV4VTky22gpV/uf6vg==
X-CSE-MsgGUID: wGjfPyP4RIeweNo63hw4Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275120479"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:10:19 -0700
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
Subject: [PATCH v4 05/17] KVM: x86/tdp_mmu: Alloc external_spt page for mirror page table splitting
Date: Mon, 28 Sep 2026 17:09:46 +0800
Message-ID: <20260928090946.15551-1-yan.y.zhao@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Enhance tdp_mmu_alloc_sp_for_split() to allocate a page table page for the
external page table in preparation for splitting the mirror page table.

When the mirror page table is split in tdp_mmu_split_huge_page(), the
corresponding external page table also needs to be split. Therefore,
allocate external_spt in tdp_mmu_alloc_sp_for_split() to prepare for the
splitting.

The external_spt will be gifted to the TDX module and mapped as a page
table page in the S-EPT during splitting. Since the TDX module will
initialize the page content in the DEMOTE SEAMCALL, there is no need to
zero external_spt.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
[sean: use __get_free_page(), let is_mirror_root be const and called once]
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- "bool mirror" --> "bool is_mirror_sp". (Sean)
- Use __get_free_page() instead of get_zeroed_page(). (Sean)
- let is_mirror_root be const and called once. (Sean)

v3:
- Removed unnecessary declaration of tdp_mmu_alloc_sp_for_split(). (Kai)
- Fixed a typo in the patch log. (Kai)

RFC v2:
- NO change.

RFC v1:
- Rebased and simplified the code.
---
 arch/x86/kvm/mmu/tdp_mmu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 001449142d32..f3311317a63a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1466,7 +1466,7 @@ bool kvm_tdp_mmu_wrprot_slot(struct kvm *kvm,
 	return spte_set;
 }
 
-static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(void)
+static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(bool is_mirror_sp)
 {
 	struct kvm_mmu_page *sp;
 
@@ -1480,6 +1480,15 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(void)
 		return NULL;
 	}
 
+	if (is_mirror_sp) {
+		sp->external_spt = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+		if (!sp->external_spt) {
+			free_page((unsigned long)sp->spt);
+			kmem_cache_free(mmu_page_header_cache, sp);
+			return NULL;
+		}
+	}
+
 	return sp;
 }
 
@@ -1527,6 +1536,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 					 gfn_t start, gfn_t end,
 					 int target_level, bool shared)
 {
+	const bool is_mirror_root = is_mirror_sp(root);
 	struct kvm_mmu_page *sp = NULL;
 	struct tdp_iter iter;
 
@@ -1559,7 +1569,7 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 			else
 				write_unlock(&kvm->mmu_lock);
 
-			sp = tdp_mmu_alloc_sp_for_split();
+			sp = tdp_mmu_alloc_sp_for_split(is_mirror_root);
 
 			if (shared)
 				read_lock(&kvm->mmu_lock);
-- 
2.43.2

