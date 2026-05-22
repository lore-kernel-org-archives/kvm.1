Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966D5CDF1;
	Fri, 22 May 2026 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422719; cv=none; b=nyJTwVMhQH5R/qyVSf9Ddd5qPkf8ejo46dSAuWjTWwTpOBKfxVUgJ68IWK2omNp5zcKStmvuML+pM+DBWwsgWd85HlADiuC3iC6feF3pBY127WSyTySnvJk4zQELLx2PEbC/h68FnXb4ZeKo0V9KPRnjlq1sxRg6A52sTqLsjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422719; c=relaxed/simple;
	bh=n4IG7a2PpHm/2z4I5gYgFbB13fkxsdCnKrUXthB/zzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQWWTmdkFZNla5YrjgrKrAfIamBX5L4mCYs37O98v+Zh5tRSPjg8OPLSjFap53LWxVaQ97Gr7bwuHvNzo8bdjlc6WeGgRx8G2z/Gtf0gWDfrEKk+oQgt+k2TN6+esQoAgsbaf2Rjp/Xo4aRv1iwNeIrCXHa9w36BzN+v/NSkS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT3sPpDN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT3sPpDN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422719; x=1810958719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n4IG7a2PpHm/2z4I5gYgFbB13fkxsdCnKrUXthB/zzw=;
  b=UT3sPpDN5VzbUqPTxyrVw84rFAMFYMJzC7vfn7HOmVXZItY0rj0V9AWd
   0KEOBntZhG2v3aDYLgiA80yBQ525jwqcLjFWG3jPFTWuP8bY9wjZMl2zD
   ViNjt2rWuo1wb730ODuLzQinX1X/I7WzfwAVxcM/DR0oYasApk/dolgS9
   DgnD2bieIYv6EQCp77HLsyWB3RSX8fLnf1YcxjKUzuEt177/SV0JBFsRC
   D866CeWh0L9UqoFQk1tdcPE44e/wgh6LxaXubefBhRkR2vCFkhDOYgzcF
   8CAJlNBkU2E9YS+TlzgziX0c1y7CbDwaoQ52+NPiJpNK37I+HgGDzdaZy
   g==;
X-CSE-ConnectionGUID: 7fsY8lNzRNudjE/KuX3kow==
X-CSE-MsgGUID: ofMTk8EFRkmx2ZSiBpvzIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528840"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:13 -0700
X-CSE-ConnectionGUID: yHpRE9wzRZi5AuzyQsL90A==
X-CSE-MsgGUID: b7rWVim0RSq8pKmOjI3SmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757760"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:08 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kas@kernel.org,
	djbw@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	peter.fang@intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 00/15] Enable TDX Module Extensions and DICE-based TDX Quoting
Date: Fri, 22 May 2026 11:41:13 +0800
Message-Id: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This posting is just to collect initial review.

Sean, Paolo, Dave please feel free to ignore for now. Sean, especially
the x86 KVM stuff is only here as an example for the init code, and not
ready for review.

Kiryl and Dan, we are trying to get acks for the first 4 patches of the
series so they can be serve as a settled base for all the other work
that uses Extensions. Please review the first 4 patches and treat the
later ones as an example for the Extensions initialization.

== Why it's being posted ==

The TDX Module is introducing a new concept called "TDX Module
Extensions", and several upcoming features depend on them. The
Extensions need some extra setup at TDX module init time, and the code
to do this is expected to be somewhat generic.

We want to get the basics of this TDX module extensions piece sorted so
that all of the extension-based work can build on it. This series
includes those basics, and an example usage called DICE-based TDX
Quoting. Only the first 4 patches are about initializing the TDX module
Extensions. I'd like some review on them. The later DICE patches are
just included to serve as a usage example for the TDX module extension
code.

The first 4 patches will eventually need an ack by an x86 maintainer, so
please review with that in mind.

== Overview ==

TDX Module introduces the "TDX Module Extensions" to support long
running / hard-irq preemptible flows inside. This makes TDX Module
capable of handling complex tasks through "Extension SEAMCALLs".

TDX Module allows some add-on features to use the Extension. The first
feature to use Extensions is DICE-based TDX Quoting [1]. DICE is an
industry-standard, certificate-backed attestation framework that layers
evidence through a chain of certificates.

This series adds infrastructure to enable the Extensions and then
implement DICE-based TDX Quoting.

The Extensions consumes relatively large amount of memory (~50MB). So it
is designed to be off by default. It must be enabled after basic TDX
Module initialization and when add-on features require it. To enable
the Extensions, host first adds extra memory to TDX Module via a
SEAMCALL (TDH.EXT.MEM.ADD), then uses another SEAMCALL (TDH.EXT.INIT) to
initialize Extensions, and then some add-on features, e.g. DICE, could
use Extension SEAMCALLs for work. Note that host can never get the added
memory back.

Theoretically, the Extensions doesn't need to be enabled right after
basic TDX initialization. It could be enabled right before the first
Extension SEAMCALL is issued. That would save or postpone memory usage.
But it isn't worth the complexity, the needs for the Extensions are vast
but the savings are little for a typical TDX capable system (about
0.001% of memory). So the Linux decision is to just enable it along with
the basic TDX.

This series has 2 distinct parts:

  Patches  1-4:  TDX Module Extensions enabling
  Patches  5-15: DICE-based TDX Quoting, primarily Peter's work.

== Some history ==

The TDX Module Extensions part was first posted along with TDX
Connect [2]. Now this part is remarkably smaller because we've removed
the generic tdx_page_array abstraction for HPA_LIST_INFO. TDX Module
Extensions is the first user of HPA_LIST_INFO, and doesn't use it in a
typical way (HPA_LIST_INFO can only hold at most 2MB memory). There
isn't enough justification to make the abstraction in this series. A
possible plan is to rebuild tdx_page_array iteratively when more use
cases arise.

== Misc ==

This series is based on tip/x86/tdx [3], because we need a small
being-merged patch [4] before our work.


Link: https://cdrdv2.intel.com/v1/dl/getContent/874303 # [1]
Link: https://lore.kernel.org/all/20260327160132.2946114-1-yilun.xu@linux.intel.com/ # [2]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=x86/tdx # [3]
Link: https://patch.msgid.link/20260402-fuller_tdx_kexec_support-v3-1-34438d7094bf@intel.com # [4]


Peter Fang (10):
  x86/virt/tdx: Move tdx_tdr_pa() up in the file
  x86/virt/tdx: Initialize Quoting extension during bringup
  x86/virt/tdx: Prepare Quote buffer during extension bringup
  x86/virt/tdx: Add interface to check Quoting availability
  x86/virt/tdx: Add interface to generate a Quote
  x86/tdx: Move and rename Quote request structure
  KVM: TDX: Factor out userspace return path from tdx_get_quote()
  KVM: TDX: Add in-kernel Quote generation
  KVM: TDX: Support event-notify interrupts only with userspace quoting
  x86/virt/tdx: Enable TDX Quoting extension

Xu Yilun (5):
  x86/virt/tdx: Read global metadata for TDX Module Extensions
  x86/virt/tdx: Add extra memory to TDX Module for Extensions
  x86/virt/tdx: Make TDX Module initialize Extensions
  x86/virt/tdx: Enable the Extensions right after basic TDX Module init
  x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions

 Documentation/virt/kvm/api.rst              |   8 +-
 arch/x86/include/asm/tdx.h                  |  34 ++
 arch/x86/include/asm/tdx_global_metadata.h  |  11 +
 arch/x86/kvm/vmx/tdx.h                      |   6 +
 arch/x86/virt/vmx/tdx/tdx.h                 |  32 +-
 arch/x86/kvm/vmx/tdx.c                      | 176 ++++++++-
 arch/x86/virt/vmx/tdx/tdx.c                 | 387 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  27 ++
 drivers/virt/coco/tdx-guest/tdx-guest.c     |  25 +-
 virt/kvm/kvm_main.c                         |   1 +
 10 files changed, 655 insertions(+), 52 deletions(-)


base-commit: 5209e5bfe5cab593476c3e7754e42c5e47ce36de
-- 
2.25.1

