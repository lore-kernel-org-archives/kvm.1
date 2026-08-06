Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECA3AC0ED;
	Thu,  6 Aug 2026 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982143; cv=none; b=WGLA+Um+mmIczouwvtBaBh2lKmO93iLw6jUXOWwxo2sQ4uwwJ7bAQlStJbz4Vyy2K5q8LtycM1riKjavVKkA1Wo/WE7hUhMIUYIDpNPW18tJ4tqu3OElD0CVrKuixTmUxMUq1qUhw/99yquBvVbXy3CenDWtg3ICeUybJ24+VUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982143; c=relaxed/simple;
	bh=R40l2AV+agPIzV7ZpAddOKlHF0RjlJ4wSlb311zR6+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QzOLT42EgbGUJ+smSTu6kdnTCq7Mu+NdKE9v2y+Yv1SnbA/acERHo8Cb3QrPxj839qt7UA8qF9d7P3zrrZrx4bHE0kVxm/HE1vYaNAUAxjn1HCEKFNhD8onjyWagAxWng70iU3hdGFi01LkNuWaNLz5kPYVQmsFHkFTq1eszYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0TR/x8W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0TR/x8W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982141; x=1817518141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R40l2AV+agPIzV7ZpAddOKlHF0RjlJ4wSlb311zR6+M=;
  b=i0TR/x8Wgs19tAbLYfTM2KKUDznEOvspCT+pDVyj1RR+PrZc3UCmSQsD
   6EhNd0t7yIS1jdU12KuoYGUEJXDESm6eb9YRLGdTnGGmfCbKGDsfoeeg2
   Cr2sDBBRGGGEqxsuJJTzgbH4RYQFTCExJSx304cnCu7iQU3c1ygr/Dp4F
   g1OcuYNxO/AAkcDSm95NJEi3rNxTHnEAOwGwL5TbUgVjU/m/qheqMEkeA
   is4OrRjtb8tSSYRat4LTx8xUM9DQ0wVFM0zq7kGOfTD8oBocq87FY8zYS
   wN69wD82sXQCe0HqrhS5j3oeM9GROpMnC+LmEMMssgHNCYFe7JmC6mp9f
   Q==;
X-CSE-ConnectionGUID: pN9JnFN9TUqoDpLZuHrQ0g==
X-CSE-MsgGUID: VmSxaPNDT5OLnchtc9A4rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86422828"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86422828"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:00 -0700
X-CSE-ConnectionGUID: 0oHYLuptRX2RCO2ObbwTvQ==
X-CSE-MsgGUID: w/nA/piFRIy1YSRaMfNnzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="258639851"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:00 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v9 00/11] Dynamic PAMT
Date: Wed,  5 Aug 2026 19:08:39 -0700
Message-ID: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This another revision of Dynamic PAMT TDX series. Like v7 and v8, it is 
hopefully the last. Last time it got two non-functional nits from Sashiko 
and two false positives. After some offlist discussion with Dave, I've
applied the nits and rebased on v7.2-rc6. There were no conflicts.
Everything else is the same.

Background
==========
Dynamic PAMT is a TDX feature that allows saving memory by allocating some 
of its page tracking metadata dynamically, instead of statically at boot. 
These static allocations take roughly 0.4% of system memory. The savings 
are variable depending on system and TDX usage, but could be up to 100x. 
For more Dynamic PAMT background, please refer to [1]. For more analysis 
of the savings in different scenarios, see the v6 coverleter[0].

It occurred to me that since the Dynamic PAMT effort began, RAM has become
much more expensive. Consequently, this feature is even more valuable now.
It would be good to enable it for TDX users.

Optimization patch
==================
The past two revision I mentioned some considerations for whether to 
include the get/put optimization patch. In v6 Dave had asked whether the 
"x86/virt/tdx: Optimize tdx_pamt_get/put()" was really needed. Later we 
discussed offline to keep the patch for the sake of maintaining 
performance and being kind to KVM's efforts to fault under a shared lock. 
However, now that the feature requires an opt-in, it could be for limited 
use and not disturb any kernel upgraders. Then the optimization patch 
actually does become more optional. So it was moved to the end.

On v7 that patch picked up a RB from Nikolay. I think it is still optional,
but I'd lean towards recommending it. But I'm ok either way, if we want to 
discuss it more without holding up the basic support.

Base
====
This is based on v7.2-rc6. A branch can be found here: [2].

Testing
=======
This last version was tested in the usual suite, and also with the 
optimization patch removed. The validation person who has worked on this 
series added his Tested-by offlist. He has a special dynamic PAMT specific 
test suite. Since there were not any changes which would be expected to 
have functional impact I just did some regression testing with our standard 
automated testing for this one. I left his Tested-by tags per his 
preference.


[0] https://lore.kernel.org/lkml/20260526023515.288829-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20250918232224.2202592-1-rick.p.edgecombe@intel.com/
[2] https://github.com/intel-staging/tdx/tree/dpamt_v9


Kiryl Shutsemau (9):
  x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
  x86/virt/tdx: Add tdx_alloc/free_control_page() helpers
  x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
  x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
  KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
  KVM: TDX: Get/put PAMT pages when (un)mapping private memory
  x86/virt/tdx: Enable Dynamic PAMT
  Documentation/x86: Add documentation for TDX's Dynamic PAMT
  x86/virt/tdx: Optimize tdx_pamt_get/put()

Rick Edgecombe (2):
  x86/virt/tdx: Simplify PAMT layout calculation
  x86/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path

 .../admin-guide/kernel-parameters.txt         |  10 +
 Documentation/arch/x86/tdx.rst                |  28 ++
 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/include/asm/tdx.h                    |  26 +
 arch/x86/include/asm/tdx_global_metadata.h    |   3 +
 arch/x86/kvm/mmu/mmu.c                        |   4 +
 arch/x86/kvm/vmx/tdx.c                        |  99 ++--
 arch/x86/kvm/vmx/tdx.h                        |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 452 +++++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                   |   2 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  23 +-
 12 files changed, 559 insertions(+), 92 deletions(-)

-- 
2.54.0

