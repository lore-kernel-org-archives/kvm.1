Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF6D38AC99;
	Sat,  9 May 2026 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315567; cv=none; b=EJNql9T2FVvATCJL/R13LCdCQ2XTRm8YQuVI72qNlBNawSSC3hcFFe8djam0/rx3+y3hwjVLfdZ+n0aUnrQfkjAKbpGgB5TCfgDQrU4iA2JcLa5dp72GI1cebKCEsRMhmK8snZrUjdSR+Cu5qjJ01Vya5YGEtzpD8UVHboRMk1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315567; c=relaxed/simple;
	bh=jdSUnW8+bEZaogw3HaXgi01PCmfsZvX+sHNg8WVbHVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeFszsR6KjxOYLFqKMcLW0jxuPjzNDLz4LeGWXItVSDgtVynXk8c5+NsFbeY6Fg3nqgl+cBXZY036Y0SDunOpV4v48glFYH4u1C/HyAeUJA8TbM8D+Dphq2pD9JnpJhh0DpX0S0/Fysgp6pqxCY2/SSjBWtd6aA4jRtMog5Hj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJ4mYndp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJ4mYndp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315565; x=1809851565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jdSUnW8+bEZaogw3HaXgi01PCmfsZvX+sHNg8WVbHVQ=;
  b=oJ4mYndpZ9aCeYIGCjA6t5rtG5DyS3bp9ql0jucKytYsbwqGWY70owqu
   RMZuGH2PHDr6goKSsqgxjkoiG2JoKG5ZALCN01m5r58sx6FDZQiLQS4MJ
   8MFQdmlewbfe8BIMjFAAUXnN4h+EJwUf65O5ge77ENOOKMS/0QOgsK8Oo
   leRHHFgHIEyMg9i4smTOa64j8gP5OPwSEenkkKK25OWcXgPRta75TtDuE
   Gqle7KIOiVu5Tb+F6Q49aNYlPUjfFzzgXO6yrtRxx4r7oWX33B8f5jkUy
   HeatXwOebF2J/N/2+CSfrcb9BNHOlCQC0kZDhdxsSZZrRJjcZbY2Jz621
   A==;
X-CSE-ConnectionGUID: EyOQjd95QmicWhFzkxgjOQ==
X-CSE-MsgGUID: 0DnvFxEWQlS3oG70kCbQrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79464231"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79464231"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:32:44 -0700
X-CSE-ConnectionGUID: ZmD2ftF6T7iQauGzPBBppw==
X-CSE-MsgGUID: XCTRg/W0Tyy4Sx1zBELiBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="233913319"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:32:41 -0700
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
Subject: [PATCH v2 00/15] TDX MMU refactors
Date: Sat,  9 May 2026 15:52:01 +0800
Message-ID: <20260509075201.4077-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of the TDX MMU refactor series, based on Rick's v1 [1], which
was extracted from the discussion on Sean's DPAMT/Huge page combined series
[0].

v2 is rebased onto v7.1.0-rc2 and the v2 struct page to PFN conversion
series. v1's first 4 cleanup patches are dropped from v2 and kept in the
base (see "Base" section for details). The full stack is available at [6].

I feel v2 is in good shape at this point, so I'm posting it now, hoping it
can get merged after Dave acks the struct page to PFN conversion series.


v2 addressed all comments from v1, with below key changes:

- Addressed the comment of how atomic zaps are handled before all changes
  (except for reclaiming non-leaf pages) are propagated via the
  set_external_spte() op (Issue #2 in [5]):

  Move patches 1-4 to the beginning of the series, so after patch 5, TDP
  MMU also allows propagation of changes for atomic zaps to TDX (via the
  set_external_spte() op), while having TDX code warn on the atomic zapping
  scenario.

  In patch 9, __handle_changed_spte() centralizes propagation of both
  atomic zap changes and to-present changes via the set_external_spte() op
  before patch 12 centralizes propagation of all changes (except for
  reclaiming non-leaf pages).

- Explained why kvm_tdp_mmu_age_spte() does not warn about installing
  FROZEN_SPTE as a long-term value (in patch 9's log) after patch 7 adds
  the warning for this scenario, and explained why kvm_tdp_mmu_age_spte()
  warns on mirror roots in the code comment.
  
- Extracted patch 8 from patch 9 to plumb "sp" pointer to
  handle_changed_spte(). (patch 8 was originally in [0], and was somehow
  merged into patch 9 in v1). 

- Renamed tdx_sept_link_private_spt() to tdx_sept_map_nonleaf_spte(), and
  tdx_sept_remove_private_spte() to tdx_sept_remove_leaf_spte() for
  symmetry with tdx_sept_map_leaf_spte().

- Added expected lock and valid scenarios in function comments of
  tdx_sept_set_private_spte() and tdx_sept_free_private_spt().

Note: Patches 9 and 15 still have the "Not-yet-Signed-off-by" tag.


Patches layout
--------------
Part 1: Patches 1-9 (for to-present and atomic-zap-leaf-SPTE changes).

        Patches 1-4 are preparation for patch 5. So when patch 5 drops
        KVM_BUG_ON()s on zappings in __tdp_mmu_set_spte_atomic(), both
        to-present changes and atomic-zap-leaf-SPTE changes are propagated
	via the set_external_spte() op and TDX code can trigger
	KVM_BUG_ON()s on the atomic zap scenario.

        Patches 5-6 move asserts and KVM_BUG_ON()s from TDP MMU to TDX
        code.

        Patches 7-9: centralize external PTE propagation triggered by
        tdp_mmu_set_spte_atomic() (for to-present and atomic-zap-leaf-SPTE
	changes) to __handle_changed_spte().

Part 2: Patches 10-13 (for zapping of leaf SPTEs).
        Drop remove_external_spte() op and have __handle_changed_spte()
        centralize propagation of leaf SPTE zapping in all scenarios.

Part 3: Patches 14-15 (for zapping of non-leaf SPTEs).
        Cleanup of the free_external_spt() op.


Base
----
v2 is based on v7.1.0-rc2 (kvm/next, commit 6d35786de281) +
the first 4 patches from Sean's DPAMT/Huge page combined series [0] +
v2 of the struct page to PFN conversion series [2].

Note: due to the instability of v7.1.0-rc2, I also applied series [3] and
[4] to pass CI.


Changelogs
----------
v1 [1] --> v2:
- Dropped 4 cleanup patches that will be pulled separately into the base.
- Fixed typos, code comments, updated commit messages, and removed unused
  parameters.
- Patch reordering and added back patch 8.
- Renamed TDX functions to indicate map/remove leaf/non-leaf status.
- Addressed the comment on how atomic zaps are handled before all changes
  (except for reclaiming non-leaf pages) are propagated via the
  set_external_spte() op in __handle_changed_spte().
- Added expected lock and valid scenarios in function comments of
  tdx_sept_set_private_spte() and tdx_sept_free_private_spt(). 
- Explained why kvm_tdp_mmu_age_spte() does not warn about installing
  FROZEN_SPTE as a long-term value and explained why it warns on mirror
  roots.

Sean's DPAMT/Huge page combined series [0] --> v1:
- Went back to free_external_spt() name. Since free_external_sp() was
  dropped from the changes, there was no similarly named function to
  confuse.
- Suggestions around dropping or moving KVM_BUG_ON/WARNs were turned into
  patches.


Thanks
Yan

[0] https://lore.kernel.org/kvm/20260129011517.3545883-1-seanjc@google.com
[1] https://lore.kernel.org/all/20260327201421.2824383-1-rick.p.edgecombe@intel.com
[2] https://lore.kernel.org/all/20260430014852.24183-1-yan.y.zhao@intel.com
[3] https://lore.kernel.org/all/20260423155611.216805954@infradead.org
[4] https://lore.kernel.org/all/20260428024746.1040531-1-binbin.wu@linux.intel.com
[5] https://lore.kernel.org/lkml/aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com
[6] https://github.com/intel-staging/tdx/tree/tdx_mmu_refactors_v2



Rick Edgecombe (4):
  KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX
    code
  KVM: TDX: Move lockdep assert in __tdp_mmu_set_spte_atomic() to TDX
    code
  KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a
    KVM_MMU_WARN_ON()
  KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child external
    PTEs

Sean Christopherson (10):
  KVM: TDX: Drop kvm_x86_ops.link_external_spt()
  KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into helpers
  KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
  KVM: x86/mmu: Plumb param "old_spte" into
    kvm_x86_ops.set_external_spte()
  KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's
    handle_changed_spte()
  KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to
    external PTEs
  KVM: TDX: Hoist tdx_sept_remove_private_spte() above
    set_private_spte()
  KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
  KVM: x86: Move error handling inside free_external_spt()
  KVM: TDX: Move external page table freeing to TDX code

Yan Zhao (1):
  KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for leaf
    SPTEs

 arch/x86/include/asm/kvm-x86-ops.h |   4 +-
 arch/x86/include/asm/kvm_host.h    |  13 +-
 arch/x86/kvm/mmu/tdp_mmu.c         | 273 ++++++++++++-----------------
 arch/x86/kvm/vmx/tdx.c             | 172 ++++++++++++------
 4 files changed, 233 insertions(+), 229 deletions(-)

-- 
2.43.2

