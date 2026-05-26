Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BC72777F3;
	Tue, 26 May 2026 02:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762927; cv=none; b=TMVgqM51LjKNSZD3cG1aeLALUaM65XdTbU4VD9UwMRttOvzB7wYgQcy9RPSA6I2mHm26SNpCHErd6TBwoLGZdzNz7uDYOa7ZQgfL7RBzNx2F01sZuESrf5Yzu+TuqRjY3ObQX4CfclfsmWdnLbB4tzOV1WFU2mQAyiImHYE5gPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762927; c=relaxed/simple;
	bh=Xi8mAzRy94bI6Tgn5TdOX9YiIxqbeae3tHK3dWDmR44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwL5HSV4g6+3ZhXJ71gMqeV0yqlU9nL6kpags3PKvLpX5TlWFsvE/YeNJybCci5zxF50GoatpyO1VHoVsu8CEpWn5di/t+T7/5PXcu9JD35kK9+GHq1rfUc5phYswav1Eb4ncmeDIRAME6oLaU+1+Qww2HlQy9HkoqqDcVAgGbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a05FSTQr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a05FSTQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762926; x=1811298926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xi8mAzRy94bI6Tgn5TdOX9YiIxqbeae3tHK3dWDmR44=;
  b=a05FSTQroRCPIOWyZ76q/YE7KbNH/ChpIWAF4HhJmT981QlIoNiNjohO
   ib8Ga5Z8JTj+haOYaSYnPjTYGRTbq/HiHz9lpKCpCXQh76MV1u7oveVOl
   YxgbsKZcFSzVsyIA6Q94WwpfT5mE9+HjnWRcBdzimzxQRpF1rTva1UiGG
   FGP0g0Hl0Ct4+MK+DjwCP64eDGCLAU2bKTcJ/CBqDlDFJQ+/PTlHrZuQL
   NYO4kHPa8T0lhGyMG9CuaSMY2cBVxfGW4TEnDOoy1ZzSItWDxi0Tqt+bX
   7w4C9wk+EN+VIs+CC2DXep+LKBLc70j2TyjBtuqieJH6sVbABEdxW2pRA
   w==;
X-CSE-ConnectionGUID: t0+e5Q2jRVWHSJBhV+f4hg==
X-CSE-MsgGUID: qgn05lt6TDih2J21fU8AVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677762"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677762"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:23 -0700
X-CSE-ConnectionGUID: CspIYf3/RUq2L+bBDs16lA==
X-CSE-MsgGUID: UfFK7FWhSzmtiOtlH4js+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878282"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
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
	kai.huang@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v6 00/11] Dynamic PAMT
Date: Mon, 25 May 2026 19:35:04 -0700
Message-ID: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This is next revision of Dynamic PAMT TDX series, which I’m calling v6 in 
order to differentiate it from Sean’s giant MMU refactor/DPAMT/Huge-page 
series which he called v5 [0]. But things are not quite linear, because 
that v5 didn’t include the feedback from v4 [1].

So this version is the conflict resolution of:
 1. Comments on Dynamic PAMT v4
 2. Sean changes in Dynamic PAMT v4 -> Sean Mega v5
 3. Feedback to Sean’s v5

For Dynamic PAMT background, please refer to [2].

This series is pretty mature at this point, however with 2 pre-req series 
still on the list (more on that below under "Base"), I can't ask for it to 
be merged at this point. So I'm hoping to collect some Acks and RB's in 
the meantime and then it can have a smooth path once those other series 
land. Please especially consider any reviewabiliy concerns on the tip side 
that can be ironed out in the meantime.

Changes
=======

Sean’s mega v5
--------------
This had a bunch of MMU refactor work, which did:
 a. TDX MMU refactor that generally pushed more TDX knowledge into TDX.c
    out of the core MMU. This covered the needs of both DPAMT and huge
    pages.
 b. Redid the solution for installing DPAMT backing for the pages the MMU
    uses for the S-EPT operations.
 c. Some huge page changes that I’ll skip here.

(a) has been split into another series [3]. After long discussions on v5, 
the changes for (b) were rolled back to the original solution in v4. 
Sean’s v5 included him trying to do Kai’s idea and running into trouble, 
then a second new idea which also was found to have issues on review of 
v5. By my count we have had at least 4 or 5 ideas by smart people that led 
us back to the same solution of keeping a cache of pages and adjusting the 
DPAMT right before give the page to the TDX module. I, again, think that 
we should either accept the current solution or get started on going back 
to change the arch in order to make it more workable for this problem.

Dropping Non-Required Changes
-----------------------------
In the interest of finally clearing these patches, I dropped everything I 
could out of the series.

The most significant thing dropped was the optimization around the 
refcount allocation. It is a good thing to drop because it is not required 
to make Dynamic PAMT useful as a memory optimization. And there is room 
for debate on how far to optimize the last little bit of memory usage. 

To recap, the kernel implementation keeps a kernel side refcount for each 
2MB of the physical memory. The non-optimized version just uses a single 
vmalloc to cover the range from 0 to max_pfn. In the worst case this is 
8GB of memory. The optimization tried to not allocate refcounts for the 
sparse ranges that didn't have any RAM.

For a simple small server with mostly physical contiguous RAM and no CXL
complications, the basic implementation should be close to optimal anyway.
And for big servers, an 8GB allocation is going to have less impact. In
the end Dynamic PAMT *is* an optimization that we will force on as a
good default option. Even with all the optimizations we could throw at it,
if the system is 100% TDs, Dynamic PAMT could come out slightly behind. So
judgment on good defaults is needed regardless.

Consider a couple simple examples of TDX enabled, but no TDs, and the 
non-optimized refcount solution:
Machine                    PAMT (GB)   DPAMT (GB)   Savings/(Loss)
256GB (max_pfn at 256GB)   1.02        0.01         100x
256GB (max_pfn at maxpa)   1.02        8.01         (8x)
2TB   (max_pfn at 2TB)     8.19        0.08         99x
2TB   (max_pfn at maxpa)   8.19        8.08         1x

The weird server loses a little bit, but not nearly as much as the normal 
ones gain. Still enough benefit in general to make Dynamic PAMT a 
worthwhile default setting. So let's start with the simplest solution, 
which is an improvement in most cases. And then separate out the refcount 
optimization discussion for later.

Besides that, I dropped the error cleanups. As I was implementing the last 
discussion, I found it a bit awkward in some places. Also I noticed that 
Dave did not fully agree to that proposal either. So it's a continual 
source of style controversy and we can separate it out from the Dynamic 
PAMT work.

I did not drop the optimization that uses the refcounts to avoid taking 
the global lock in tdx_pamt_get/put() because I considered it critical for 
making Dynamic PAMT default on. It is more about avoid regressing KVM EPT 
violation contention, and not about squeezing out more memory savings from 
Dynamic PAMT.

Regarding whether we could strip more out of the series if we made this a
boot time kernel parameter. I think it's possible to drop "x86/virt/tdx:
Allocate reference counters for PAMT memory" and "x86/virt/tdx: Allocate
reference counters for PAMT memory" and still have something that is
functional. I didn't go that route for this revision because making the
feature optional seemed like too much of a divergence from past discussion.
But it is an option if this series seems like too much to digest at once.

AI use in this revision
=======================
While AI enhanced development is still relatively new to the kernel world,
I wanted to share a bit about how this series was generated. For both
consideration in reviewing, and also maybe people might find it
interesting. This was my first time using AI for serious kernel work, so
it was kind of a micromanaged evaluation type use. I used an opus model
with a dump of the many mail threads and a description of how they were
related. Since the previous discussion was pretty disordered, I had it try
to catch any feedback that was missed or conflicted for each patch. And it
caught a few that I had missed. I also used it to turn some of the
feedback into code changes, and to heavily scrutinize the concurrency
logic in tdx_pamt_get/put(). I used it to suggest some log changes too,
but had to edit most of those pretty heavily. Lastly, I used the Chris
Meson and Sashiko review prompts to review the series, which generated a
few changes. All this experimentation generated quite a few Assisted-by
tags, which now feels kinda excessive...

Base
====
This is based on v2 of the MMU refactor series Yan posted a few weeks ago 
[3], which is itself based on the struct page to pfn conversion series[4]. 
A full stack branch can be found here: [5].

Testing
=======
This series was tested in the usual suite, but also with the optimization
patch removed.

[0] https://lore.kernel.org/kvm/20260129011517.3545883-1-seanjc@google.com/
[1] https://lore.kernel.org/kvm/20251121005125.417831-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/kvm/20250918232224.2202592-1-rick.p.edgecombe@intel.com/
[3] https://lore.kernel.org/kvm/20260509075201.4077-1-yan.y.zhao@intel.com/
[4] https://lore.kernel.org/kvm/20260430014852.24183-1-yan.y.zhao@intel.com/
[5] https://github.com/intel-staging/tdx/tree/dpamt_v6

Kiryl Shutsemau (9):
  x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
  x86/virt/tdx: Add tdx_alloc/free_control_page() helpers
  x86/virt/tdx: Allocate ref counts for Dynamic PAMT memory
  x86/virt/tdx: Handle concurrent callers in tdx_pamt_get/put()
  x86/virt/tdx: Optimize tdx_pamt_get/put()
  KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
  KVM: TDX: Get/put PAMT pages when (un)mapping private memory
  x86/virt/tdx: Enable Dynamic PAMT
  Documentation/x86: Add documentation for TDX's Dynamic PAMT

Rick Edgecombe (2):
  x86/virt/tdx: Simplify tdmr_get_pamt_sz()
  x86/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path

 Documentation/arch/x86/tdx.rst              |  22 +
 arch/x86/include/asm/kvm-x86-ops.h          |   1 +
 arch/x86/include/asm/kvm_host.h             |   2 +
 arch/x86/include/asm/tdx.h                  |  38 ++
 arch/x86/include/asm/tdx_global_metadata.h  |   3 +
 arch/x86/kvm/mmu/mmu.c                      |   4 +
 arch/x86/kvm/vmx/tdx.c                      | 100 +++--
 arch/x86/kvm/vmx/tdx.h                      |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 445 +++++++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                 |   5 +-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  21 +-
 11 files changed, 544 insertions(+), 99 deletions(-)

-- 
2.54.0

