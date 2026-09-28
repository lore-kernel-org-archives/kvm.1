Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C347989A;
	Mon, 28 Sep 2026 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586498; cv=none; b=NNaR4fWi0p7GPKn3I/5ORCvyaFWl8Bqqf5tdX/pfih4BlzC+errAIitBaElNs5x8iN9SA+Z0gWeDe+y/TjRTI4jLq2oZbPoYtWl3HgJUGv5Eu8EBg8l59UsC4bSExq/XMjdhRlPBOoLBvUu2eQARndiD9MYb0HDAEvlxY/d5jsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586498; c=relaxed/simple;
	bh=8S0Q2HQPQGeLqPyPmq/9VqMCMG0qWI1wUFUeXe9kKCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDyL6R62dSNPCJPugfKXeVoiALRVZbavEsRN3L0GzXgfbhFhukFNbj0JjKsUdlCYO2N+K6S8DE2alEl7ljvmX0bL9e4BlzkHbB9LXHEJm5F6EjIMFmOefSocfQ8ZImnlvVTbXm0+SdBJVnwK8YgaN1CedZPcKmKuX+24sKeS7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8pj0GFX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8pj0GFX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586496; x=1822122496;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8S0Q2HQPQGeLqPyPmq/9VqMCMG0qWI1wUFUeXe9kKCI=;
  b=O8pj0GFXYkOHtg+SPiHHYt9pEXnBMXdY9DLclysFpT6Ji3/wjGp1XlG0
   B6G6iR99B/uy8+3zRtcRyu0GOQgrBXUS8c+tLpTURr/Ii8CvWl4OIBuEu
   xTdNQYD2VWms8YlQPJ1sCowJMb/hkxyUluxICoq3ULWfk89cekVPYkS38
   L16UmoZheI3mUEI7adDA3SSRrF/ieHaUjV14lXyftu39jBjonEbFxOJ6l
   r2hDbBKQ7Hh3hRAdbTewQaXdpctRtzxdOL/5WlvEvsirRAPz+wlruHI5L
   kG6o9pYzazbD/XCySzMO40ndiJz6zmLEWcNjl9qKnp/SFLiIPuLWYw1SJ
   w==;
X-CSE-ConnectionGUID: TCMde/+XQ6q0Pf8uHliqGA==
X-CSE-MsgGUID: dPrjpD4wQai+th4dENAaPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90184385"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90184385"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:08:15 -0700
X-CSE-ConnectionGUID: 3/rcNHkPTg+CkISf2lrRMg==
X-CSE-MsgGUID: dI6ChMroS3Wp3/wjMmurEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="301279808"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:08:08 -0700
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
Subject: [PATCH v4 00/17] KVM: TDX huge page support for private memory
Date: Mon, 28 Sep 2026 17:07:29 +0800
Message-ID: <20260928090729.15468-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the TDX huge page series. This revision incorporates changes
from Sean's combined DPAMT + Huge Pages series [1], addresses review
feedback from v3 [0], fixes bugs, refines commit logs and code comments,
isolates gmem-dependent glue code, and aligns SoB tags with tip tree
preference.

As with prior versions, TDX huge page support requires the TDX module to
report the ENHANCED_DEMOTE_INTERRUPTIBILITY feature. Additionally, this
revision enables TDX huge pages only when both DPAMT and guest_memfd
in-place conversion are enabled. (See the 'Base' section below for the
dependency stack. A working branch is at [2]).

TDX huge page support relies on guest_memfd (gmem) as the backing huge page
allocator. Pending the availability of upstream HugeTLB-based gmem, an
out-of-tree allocator allocating 2MB folios from the buddy is used for
testing. However, the core of this TDX huge page series is gmem-agnostic,
independent of the specific gmem allocator.

In previous upstream planning discussions [3], Sean noted openness to
landing this series (e.g., via a topic branch) ahead of in-tree huge page
support in guest_memfd. To facilitate this, the gmem-dependent glue code is
isolated into 4 patches tagged "GMEM-DEPENDENT" at the tail of this series.

The primary goals of this revision are to:
- Collect Reviewed-by tags (especially for tip-tree patches 1-2).
- Seek feedback and alignment from Sean on the following KVM/gmem changes:
  * Adjusting the topup count of page pairs in PAMT cache for splitting
    S-EPT entries (patch 8).
  * Splitting guest_memfd invalidation into stages: invalidate_start,
    prezap, zap, and invalidate_end (patches 14-15).
  * Renaming the hook .gmem_convert() to .gmem_prezap() (referencing prior
    discussions at [4]) (patch 15).


Earlier settled items
---------------------
1. TDX huge pages series depends on DPAMT series, and patches the TDX huge
   page series should not be divided based on whether they are
   DPAMT-related.

2. Only enable TDX huge pages when gmem in-place conversion is enabled.

3. Only enable TDX huge pages when the TDX module supports the
   ENHANCED_DEMOTE_INTERRUPTIBILITY feature.

4. Do not support page merging for the initial huge page support.

5. Hook splitting S-EPT entries to .set_external_spte(), and use PFN
   instead of folio/page to manage guest pages.

6. Handle the installation and uninstallation of external_spt's DPAMT pages
   when mapping, splitting, and unmapping S-EPT entries, rather than
   during page allocation and freeing.

7. Reuse the .topup_external_cache() hook to allocate PAMT pages for
   splitting, and use a mutex instead of a spinlock to protect the per-VM
   PAMT cache.

8. Add and export an API kvm_tdp_mmu_mirrors_split_huge_pages() to split
   mirror page tables for a given range.

9. Honor the guest's accept level by splitting any existing mapping higher
   than the guest's accept level, setting the guest inhibit bit after
   performing the split, and never clearing the flag. Take mmu_lock for
   write during the process to keep things simple.

10. Have gmem invoke arch code, which further invokes a gmem hook to
    trigger S-EPT entry splitting under a non-vCPU context. (Note: the gmem
    hook name and invocation sequence under a specific gmem implementation
    are not yet finalized.)


Main changes from v3
--------------------
1.  Reorganized patches so that they are no longer divided by whether they
    are DPAMT-related.
2.  Hooked to .set_external_spte() for splitting.
3.  Added a dedicated API kvm_tdp_mmu_mirrors_split_huge_pages() for
    splitting mirror roots.
4.  Reused the .topup_external_cache() hook to top up DPAMT pages used
    during S-EPT entry splitting. Extended the hook to work under both vCPU
    and non-vCPU contexts. Used a mutex instead of a spinlock to protect
    the per-VM PAMT cache under a non-vCPU context.
5.  Had gmem trigger S-EPT splitting via the .gmem_prezap() hook.
6.  Moved considerations of not supporting promotion from the cover letter
    to the patch log.
7.  Dropped patches for working with per-VM memory attributes. Only enabled
    huge pages when gmem in-place conversions are enabled.
8.  Based TDX huge pages on DPAMT. Simplified the DEMOTE SEAMCALL
    implementation by only enabling TDX huge pages when DPAMT is enabled.
9.  Split out gmem glue code into patches tagged with "GMEM-DEPENDENT".
10. Fixed bugs:
    - adjusted the topup PAMT page pair count for splitting.
    - used a global spinlock to avoid contention between DEMOTE and
    PAMT.{ADD/REMOVE} SEAMCALLs.
11. Dropped cache-flush-related handling.


Patches Layout
--------------
Patches 1-2:   Enhance/Introduce SEAMCALL wrappers/helpers to support huge
               pages. (tip tree patches)

Patches 3-4:   Enhance private pages reset and disallow page merging in the
               mirror page table (KVM patches).

Patches 5-11:  Support for splitting under vCPU context. (KVM patches)

Patches 12-16: Support for splitting under non-vCPU context. (KVM patches)
               Patch 12: Core support to split S-EPT under non-vCPU context.
               Patches 13-14: Gmem refactors.
               Patches 15-16: Have gmem trigger splitting under a non-vCPU
                              context.

Patch 17:      Turns on TDX huge page. (KVM patch)


Base
----
This revision is based on kvm-x86-next-2026.09.22 (containing gmem stop
returning struct page in pfn lookup series [7] and gmem in-place conversion
series [8]), plus the following series in the stack (refer to branch [2]):

- DPAMT v11 [5].
- Drop unneeded cache flushing [6]
- gmem 2MB buddy [9] + an alignment fix and an out-of-place conversion
  workaround. *

*: For testing purposes, this revision uses the out-of-tree gmem 2MB buddy
   solution as the huge page allocator.

   The gmem 2MB buddy allocator allocates 2MB folios from the buddy for
   private memory, while the shared memory is allocated from a different
   backend (specified by HVA). To avoid fragmentation, private-to-shared
   conversions only split private mappings without splitting or reclaiming
   the backing 2MB folios. The 2MB folios are always retained in the gmem
   inode filemap cache without splitting even though part of them are not
   mapped as private memory.

   Since the shared memory is not allocated from gmem (ensured by having
   gmem 2MB buddy allocator mode intentionally incompatible with the MMAP
   flag), commit 640d75f52828 ("KVM: guest_memfd: Always fault from
   guest_memfd if in-place conversion is enabled") is reverted in the
   testing branch [2] as a workaround to allow out-of-place conversions.

   The gmem 2MB buddy solution and the workaround to allow out-of-place
   conversions do not affect the code of the TDX private huge page series.
   Both of them can be dropped once the final HugeTLB-based gmem is
   available (with some rebasing effort for GMEM-DEPENDENT patches).


Testing
-------
A TDX module enumerating the ENHANCED_DEMOTE_INTERRUPTIBILITY feature is
required (AFAIK, TDX module 1.5.28 is the earliest version that reports
this feature; For testing on versions prior to 1.5.28, a workaround patch
to force enable TDX huge page can be applied [10]).

To test TDX huge pages, set the following module parameters at boot/load:
    kvm.gmem_in_place_conversion=on
    kvm.gmem_2MB_private_mem_from_buddy_for_testing=on
    kvm_intel.tdx=on
    kvm_intel.tdx_huge_page=on

The count of active 2MB mappings can be verified via:
    /sys/kernel/debug/kvm/pages_2m

QEMU and TDX KVM selftests enhanced with in-place conversion uABI support
are required.

Farrah Chen tested this stack on EMR platform with TDX module version
1.5.41.00.1153:
- 2MB huge pages were allocated and mapped as expected.
- Stress testing running 5 concurrent TDs alongside 5 standard VMs
  completed successfully with no issues observed.
- Stress testing running 63 concurrent TDs completed successfully with no
  issues observed.


Thanks
Yan

[0] v3: https://lore.kernel.org/all/20260106101646.24809-1-yan.y.zhao@intel.com
[1] DPAMT + Hugepage: https://lore.kernel.org/all/20260129011517.3545883-1-seanjc@google.com
[2] A working branch: https://github.com/intel-staging/tdx/tree/huge_page_v4
[3] Upstream planning: https://lore.kernel.org/all/aYS85EsXu_xuQXSI@google.com
[4] gmem_convert() discussion: https://lore.kernel.org/all/anLrGmbZwgWnNUkp@yzhao56-desk.sh.intel.com
[5] DPAMT: https://lore.kernel.org/all/20260904215841.303070-1-rick.p.edgecombe@intel.com/
[6] drop cache flush: https://lore.kernel.org/all/20260922205215.870563-1-rick.p.edgecombe@intel.com
[7] gmem pfn lookup: https://lore.kernel.org/all/20260826-gmem-no-return-page-v4-0-3bb9c1ddb4e3@google.com
[8] gmem in-place conversion: https://lore.kernel.org/all/20260910-gmem-inplace-conversion-v13-0-dd6fbf94f4e1@google.com
[9] gmem 2MB buddy: https://github.com/intel-staging/tdx/commit/5ba004e1b4af4d928acb7fde006195bbe84035a3
[10] workaround on old TDX module: https://github.com/intel-staging/tdx/commit/f1fe677b82e11fc97679a04e078b2fd05da55b34


Isaku Yamahata (1):
  KVM: x86/tdp_mmu: Alloc external_spt page for mirror page table
    splitting

Rick Edgecombe (1):
  KVM: x86/mmu: Prevent huge page promotion for mirror roots in fault
    path

Sean Christopherson (4):
  KVM: x86/mmu: Allocate DPAMT pages for vCPU-induced page split
  KVM: x86/mmu: Add a TDP MMU API to split huge pages for mirror roots
  [GMEM-DEPENDENT] KVM: guest_memfd: Add helpers to get start/end gfns
    give gmem+slot+pgoff
  [GMEM-DEPENDENT] KVM: guest_memfd: Add a pre-zap hook .gmem_prezap()

Yan Zhao (11):
  x86/virt/tdx: Enhance tdx_pamt_get/put() to support huge pages
  x86/virt/tdx: Add a SEAMCALL wrapper to demote a 2MB huge page
  KVM: TDX: Reset private huge pages after S-EPT page removal
  KVM: TDX: Add core support for splitting/demoting 2MB S-EPT mappings
    to 4KB
  KVM: TDX: Adjust the topup count of DPAMT page pairs for splitting
    S-EPT
  KVM: x86/mmu: Introduce hugepage_set_guest_inhibit()
  KVM: TDX: Honor the guest's accept level contained in an EPT violation
  KVM: x86/mmu: Add support for splitting S-EPT entry under non-vCPU
    context
  [GMEM-DEPENDENT] KVM: guest_memfd: Split kvm_gmem_invalidate_start()
    to start() and zap()
  [GMEM-DEPENDENT] KVM: TDX: Implement .gmem_prezap() hook to split
    S-EPT
  KVM: TDX: Turn on PG_LEVEL_2M

 arch/x86/include/asm/kvm-x86-ops.h |   3 +
 arch/x86/include/asm/kvm_host.h    |  18 +-
 arch/x86/include/asm/tdx.h         |  13 +-
 arch/x86/kvm/Kconfig               |   1 +
 arch/x86/kvm/mmu.h                 |   4 +
 arch/x86/kvm/mmu/mmu.c             |  28 ++-
 arch/x86/kvm/mmu/tdp_mmu.c         |  79 +++++--
 arch/x86/kvm/mmu/tdp_mmu.h         |   2 +
 arch/x86/kvm/vmx/tdx.c             | 322 +++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/tdx.h             |   5 +
 arch/x86/kvm/vmx/tdx_arch.h        |   3 +
 arch/x86/kvm/x86.c                 |   8 +
 arch/x86/virt/vmx/tdx/tdx.c        |  94 ++++++++-
 arch/x86/virt/vmx/tdx/tdx.h        |   1 +
 include/linux/kvm_host.h           |   5 +
 include/linux/kvm_types.h          |   1 +
 virt/kvm/Kconfig                   |   4 +
 virt/kvm/guest_memfd.c             | 135 +++++++++++-
 18 files changed, 662 insertions(+), 64 deletions(-)

-- 
2.43.2

