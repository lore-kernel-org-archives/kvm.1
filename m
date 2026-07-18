Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442F92080C1;
	Sat, 18 Jul 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339110; cv=none; b=lCiH2IjxW4FrWRZ48PP4hUCnQIz4f28WCCQZkmQeyu6PM/bz8yivnoioTEEy8LtfUlccV7KXhVO17MdPTbvIMs7G1Alxut6CLOYC+Clv4n15rsJ3AkT/i3H0hs5uUQpHg1VRFFRXYC97kwnMn2o/j8GieJYXhXKiJMdVXwarFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339110; c=relaxed/simple;
	bh=KNbDEPG9tsgQrcj/LKaGpIifhR63eKrrnqQjkVLc7+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmMdFt3/Sd2IuidOn2XvgYVYiOZUhNC+JXG8rPFDnYsyVUD2omekNB2n7A58l4WIbos6gb+6pDx4iuIISk13VSpHPKpcx4PniuBUJDwKEFEbxQABGrslAgXoIa3UW6B/Eo2Z3oVjaZjm/p6XhhkuxrGCzNPmV1FER52YuKywFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmzXQ8Lv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmzXQ8Lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784339107; x=1815875107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KNbDEPG9tsgQrcj/LKaGpIifhR63eKrrnqQjkVLc7+A=;
  b=cmzXQ8Lvrkpu2YqX8WzzFePGJHpWKih1Fr0NVbQK8NQcQeVbv6Amsp3W
   29iKExOOLfhq2yl7l4PTJvCBN5yhogXij2iGD0dORh7dA0eUaTMaAV+3a
   7xYOSZf9i23fftjsnpo/ExjuheMtb5XeduJqmSJN9UZSbja++wYAUxcsQ
   5Q24C4ECrypv+8QFFuKTOKlug2c9c/iaJswOPuB3lnyaGK+E5FvjMHLiF
   8P2wgvYeJe7CU66iktJIuhj8lkYzBjOcq3UFKnYhHwWZvfF03Fwapfb+z
   YBFU1EizIGjhcOSAMJ20M1WYho4ku3Ohu4oAnBA9jfhuXJBsnxN1cUH9q
   g==;
X-CSE-ConnectionGUID: nfpS9nilSnaorNh2/IGFjw==
X-CSE-MsgGUID: UFoPnjC+R0udaJq1m+8E2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96377089"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="96377089"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:06 -0700
X-CSE-ConnectionGUID: FjUMPCwESKqiF9AjUQgWIQ==
X-CSE-MsgGUID: anBjIfbbSjehT3y2+lL7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="254296247"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:06 -0700
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
	binbin.wu@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v7 00/11] Dynamic PAMT
Date: Fri, 17 Jul 2026 18:44:49 -0700
Message-ID: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is hopefully the last revision of Dynamic PAMT TDX series. Thank you 
to all the reviewers that helped polish off the last rough spots in v6[0]. 
Sean please consider acking the two KVM patches. Dave, please consider 
taking through tip.

Kiryl and Vishal, I left your RBs because the other changes were trivial.
Please shout if you prefer to drop them.

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

Changes
=======
Besides the polishing type comments, there were two substantial ones. These
ended up getting addressed with the same small change.

Chao asked why the TDX module doesn't do the keyid range checks itself 
that it requires, and then only expose the Dynamic PAMT feature0 bit when 
it actually can support Dynamic PAMT. It seems the TDX module is open to 
this change, but in any case, no modules exist today that have it. Since 
Dynamic PAMT enablement failure will cause TDX enablement to fail, Dynamic 
PAMT is made an opt-in for now by adding a kernel parameter for it. Then 
the kernel side keyid checks are dropped.

The other significant comment was Dave asking whether the "x86/virt/tdx: 
Optimize tdx_pamt_get/put()" was really needed. Later we discussed offline 
to keep the patch for the sake of maintaining performance and being kind 
to KVM's efforts to fault under a shared lock. However, now that the 
feature requires an opt-in, it could be for limited use and not disturb any
kernel upgraders. Then the optimization patch actually does become more 
optional. So here it is moved to the end. I think the patch is in good 
shape, but if there are any doubts we can drop it out of the initial
support.

Base
====
This is based on v7.2-rc3. A full branch can be found here: [2].

Testing
=======
This series was tested in the usual suite, and also with the optimization
patch removed.


[0] https://lore.kernel.org/lkml/20260526023515.288829-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20250918232224.2202592-1-rick.p.edgecombe@intel.com/
[2] https://github.com/intel-staging/tdx/tree/dpamt_v7

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
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/include/asm/tdx.h                    |  26 +
 arch/x86/include/asm/tdx_global_metadata.h    |   3 +
 arch/x86/kvm/mmu/mmu.c                        |   4 +
 arch/x86/kvm/vmx/tdx.c                        |  98 ++--
 arch/x86/kvm/vmx/tdx.h                        |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                   | 452 +++++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                   |   2 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  23 +-
 12 files changed, 559 insertions(+), 92 deletions(-)

-- 
2.54.0

