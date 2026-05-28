Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13931221540;
	Thu, 28 May 2026 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958151; cv=none; b=L7XjOveu27C8S52k+4MhPaM0UHIyuKf9VGdcgg1F4VkycGHRCg0mTioaTrCgp9ydUJFNgq2stQzbfdnPG8wFB5dY+BF3+P/efoGwqxLj4i3/sUudMQsCPf420bUxXbvlgb1LoDjrvZkHit61ksmO20mEb3klbdr1OCGHjs7YqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958151; c=relaxed/simple;
	bh=I5HHXqYxL8g0RMNE7nIvpFG6ZgWBI9yw3Un6ylZQxaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ljJ15gVOlMc3Y68e/Cm0D2Wry8wpFNa8X3cW3GfyvcwfbT/Qaei0s1KLBr6zMqydVYeR0kybQzu9gL8D1z2rm+D1JKLGZ9heh0Lwm/8ui4bc3zXXh2fykAoac8kp2a8G87v5LOwlpqPtImBJoZRjaHntFanFqdMXoR6HdAovFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iws0zAhU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iws0zAhU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958149; x=1811494149;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I5HHXqYxL8g0RMNE7nIvpFG6ZgWBI9yw3Un6ylZQxaI=;
  b=iws0zAhU0hGQBjgKgOup49vEIg0QEKMM3nP5uXvMPBHgaxAwRtVDihEi
   ocK75Jrp7dWZEdss+Z/9kUzzGukvH/prgPC11Xl6NOfSOdf7eNAeOtxF+
   WEOeBr7T9GlyniP+KksBHrCpZFrjDD6VSgcfryIaOpGf0G+tR6ytYLboL
   xU8YhMaZD3IRMy/lfQmTZEIwE97NUBhL2DouNR6nW6IDhQxSJVH3eIHuu
   lH0Zgy/K1fA//aXc8l2CTv6WurqBvYGghRZTTYX71zKBT+Y2aZViV/hmz
   v+gsf1OEw36xUJCEkSOTln83jp2torMi2rPUg1KHBZY5EoETrkq73uTY0
   g==;
X-CSE-ConnectionGUID: a3nBR8LESoa3PF6BGEHu6w==
X-CSE-MsgGUID: 05gN+lm2TM+sKM5GEutgKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80824857"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80824857"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:49:08 -0700
X-CSE-ConnectionGUID: mPa3xFwsRPuGu6RESKOD2g==
X-CSE-MsgGUID: DSh5Mtv8RGKp7mjrO6l9Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="242650428"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:49:05 -0700
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
Subject: [PATCH v3 00/15] TDX MMU refactors
Date: Thu, 28 May 2026 16:08:55 +0800
Message-ID: <20260528080856.10141-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v3 of the TDX MMU refactor series, a simple rebase of v2 [2] to
kvm-x86-next-2026.05.26 plus addressing a trace issue reported by Sashiko
[7].

The code is also available at [3]. (Note: due to the instability of
v7.1.0-rc2, I also applied series [4] and [5] in [3] to pass CI.)

As in v2, patches 9 and 15 still have the "Not-yet-Signed-off-by" tag.

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

Changelogs
----------
v2 [2] --> v3:
- Rebased to kvm-x86-next-2026.05.26.
- Fixed a missing trace issue reported by Sashiko [7]. 

v1 [1] --> v2:
- Dropped 4 cleanup patches that will be pulled separately into the base.
- Rebased onto v7.1.0-rc2 and the v2 struct page to PFN conversion series.
- Fixed typos, code comments, updated commit messages, and removed unused
  parameters.
- Patch reordering and added back patch 8.
- Renamed TDX functions to indicate map/remove leaf/non-leaf status.
- Addressed the sashiko comment [6] of how atomic zaps are handled before
  all changes (except for reclaiming non-leaf pages) are propagated via the
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
[2] https://lore.kernel.org/kvm/20260509075201.4077-1-yan.y.zhao@intel.com
[3] https://github.com/intel-staging/tdx/tree/tdx_mmu_refactors_v3 
[4] https://lore.kernel.org/all/20260423155611.216805954@infradead.org
[5] https://lore.kernel.org/all/20260428024746.1040531-1-binbin.wu@linux.intel.com
[6] https://lore.kernel.org/lkml/aczYjEVkva3zOpwz@yzhao56-desk.sh.intel.com
[7] https://lore.kernel.org/kvm/agu+UsizlbUYsjp6@yzhao56-desk.sh.intel.com

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
 arch/x86/kvm/mmu/tdp_mmu.c         | 275 ++++++++++++-----------------
 arch/x86/kvm/vmx/tdx.c             | 172 ++++++++++++------
 4 files changed, 235 insertions(+), 229 deletions(-)

-- 
2.43.2

