Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1028B7DA;
	Sat, 25 Jul 2026 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938992; cv=none; b=mALRQ2Fcxm6mfB3ugc1jpSGVsd+w6c6dtbOd+aK1jGjO/ZZibZiBIRWgmkN6+RZhoNJMVW3ZuVsRKSr0B8jjMe3v9u04zeUYTcEmG0IsZxZg60jKVRah4QIfeAFDKlzmf9dCAjRhbcR3jjsA/q+R7L15KMFUwr8LSDhBi/cBCpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938992; c=relaxed/simple;
	bh=KebVQc1kHCNgBCiwpFq4GE7ubD0oEgnLXQrsq31gBcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhZ+O3PHVeZH+vIJQSecd9xniMHpE0CLGSIek7RGhfG3KDIqkihqwyo3/jm95LUVxQasdJhRcmwFalOtwvFWKleot6FHtrcEU7hkH6BSeK9Pmt3gsfEYvZq93TNnBPvsLo6MhcHbg6NQ1VppYVnUfbfZxw6zJUSQgpG4hpnieS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGDoUAyH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGDoUAyH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784938991; x=1816474991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KebVQc1kHCNgBCiwpFq4GE7ubD0oEgnLXQrsq31gBcY=;
  b=jGDoUAyHosnPB/GdaeFBSRqeGzDr1ytZ3D4oDaPbaUrinTVJ/C3bZt7L
   J1rHrTQuohwxGP58RmS6DR8e9vB22/LdsJxOo8q/PDTgRLS3wUw5iJZPd
   +eIKZOrllz6zhwojdaZRqK5DQkdccJ6DI3fBssj7IXGum6PjIVqdMQbNw
   hi+6CQ0ffuwWxoe3J32GGbPft4Xjk068TLrcKetgp+bv0x+aT7QMnTCmF
   LA6WJ22l824MrGK1b3saPloODD20HbF8r/kXHUtTp6ErzSPpergofW62q
   JoYAwyrZDpyPdNiqWwx2J+SOcedB+6VUzPPktQlP7VvOYnVmDOYvu0WM+
   w==;
X-CSE-ConnectionGUID: JcKD9HHGRVmKy3a8depkng==
X-CSE-MsgGUID: lYC6go3rRhihl/gwPLvQsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726101"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726101"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 -0700
X-CSE-ConnectionGUID: CtgpQm26QBytUl2C4vjv+g==
X-CSE-MsgGUID: s2l1Ujj6Qf+adefjoo2RZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359247"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 -0700
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
Subject: [PATCH v8 00/11] Dynamic PAMT
Date: Fri, 24 Jul 2026 17:22:50 -0700
Message-ID: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This another revision of Dynamic PAMT TDX series. Like v7, it is also 
hopefully the last. Last time it got a few nits, acks and RBs. It also got 
the acks needed from Sean. (thanks) So this is all set to be taken through 
tip.

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
Last time I mentioned some considerations for whether to include the 
get/put optimization patch. In v6 Dave had asked whether the 
"x86/virt/tdx: Optimize tdx_pamt_get/put()" was really needed. Later we 
discussed offline to keep the patch for the sake of maintaining 
performance and being kind to KVM's efforts to fault under a shared lock. 
However, now that the feature requires an opt-in, it could be for limited 
use and not disturb any kernel upgraders. Then the optimization patch 
actually does become more optional. So it was moved to the end in v7 and
here.

On v7 that patch picked up a RB from Nikolay. I think it is still optional,
but I'd lean towards recommending it. But I'm ok either way, if we want to 
discuss it more without holding up the basic support.

Base
====
This is based on v7.2-rc4. A branch can be found here: [2].

Testing
=======
This series was tested in the usual suite, and also with the optimization 
patch removed. The validation person who has worked on this series added 
his Tested-by offlist.


[0] https://lore.kernel.org/lkml/20260526023515.288829-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20250918232224.2202592-1-rick.p.edgecombe@intel.com/
[2] https://github.com/intel-staging/tdx/tree/dpamt_v8


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

