Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2428003D;
	Tue, 15 Sep 2026 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468027; cv=none; b=LwivbnkyMGQKLRttD3OaM4vFlFdGXQwMa4STh3Q8CVymBxdYODuCDgO+06CI3XG1uKIQJ+JsV5CQ522F+8RBKc2Z2rF4IdBXf35B7IZCAAGjNzuwBeQOU4vde/mUVUPkyLbLDj2P/dbZg+4JLUSktYtay6QiABxSriry50yxd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468027; c=relaxed/simple;
	bh=85nfFsSBljG0oh86uMjrB9I0taE1bu77ao7lLepRyFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dg/4Tu9UtEPSReMpJJ+Fo6phH2pGH2yzE3fTKsLOnnAod0jPkQXEETyuwqa6oCfntYYvmgfNrdm2XptBpEdC2nz8Hj7HSYoUV2yMoCUWvAuUVuFwx3Oq8ste6UBR8Q1bzc8GNebQVuHZppKTphFKtw7LdtUidOydAWEOI+iTU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1QaWPgj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1QaWPgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789468025; x=1821004025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=85nfFsSBljG0oh86uMjrB9I0taE1bu77ao7lLepRyFk=;
  b=M1QaWPgjOmGfGg9poM77cLVF0ZkLRcY+kF8Eikulm8KZ0H/F6poQcGPY
   O3eDv9wEJX5oWCrge9GuYIYypqV1XoaHdolMcZjN+fOlfmtw3qILKFrsC
   RFfFIzifwG4Gkk4+BdZ3MHGngwCOkPmP9+f0vaNysRGDQEFZkmpPjxkzH
   +XtfO/LvXfHJ7PUT1qlxzgiuK0Izmep7Unl3WB29/0oyl/7DNn67z7uCJ
   GInqy0lYUIlREIQvJECdlxGnxMxqyBb59bWsyiYjx1rsYYgRZCHxOYyIu
   OLwZF5y1/75uhecOClJWbvXy08QjkyECVFmixFjs24NeFRybKrF3Mu9YK
   A==;
X-CSE-ConnectionGUID: fWnNAOCGSiC4l8m+mP3BMQ==
X-CSE-MsgGUID: +g/YfRyVSTS8/d7CwEBtXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115362189"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115362189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:27:04 -0700
X-CSE-ConnectionGUID: yD+GlRH2QDur2hwc39s+Ww==
X-CSE-MsgGUID: 9ZmAiwIRSuyeY5MkoTF+pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277083735"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2026 03:26:59 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 0/5] Enable TDX module extensions
Date: Tue, 15 Sep 2026 18:26:53 +0800
Message-Id: <20260915102658.713079-1-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the first respin of the TDX module extensions series. Thank you
all for the design discussion and architectural review. Hope the design
could be settled and some more RBs got in this version.

Dave please feel free to ignore. Kiryl, Rick and TDX developers, please
help take a look.

== Changes ==

A major change is that the add-on feature re-configuration and
extensions re-initialization operations during runtime update have been
dropped. IOW, the update flow is left untouched. This stems from the
architectural discussion that the basic update flow should start with a
simple functional requirement - just restore everything (for example,
the add-on features re-enabling, TDH.EXT.INIT) that was configured
during boot, no extra input from the host is needed. Do improvement
later if any new requirement arise.

The extensions consume tens of megabytes memory that will never be
returned to the host. How to consume this amount of memory forever is an
open question though v1 uses alloc_contig_pages() for memory
de-fragmentation. Kiryl implied fragmentation is an important concern.
He answered that de-fragmentation is to prevent 2M pageblocks from being
partially occupied. alloc_contig_pages() can be more than needed but
should be good enough when we do it once during the boot time. In
patch 4, keep the alloc_contig_pages() but add a code comment for
clarification.

Dave asked why pass the addon_features0 around as a function parameter,
it can always be return from the global, static
get_tdx_addon_features0() helper. Yilun admitted this is redundant. In
patch 2, change to call the helper a second time where the value is
needed.

Rick pointed out that in patch 1, the changelog said we introduced a
kernel data type for TDMR info PA array argument but the code is still
setting TDX ABI data type (u64) for PAs. He suggested justifying that
this is to avoid duplicating allocations and copies in SEAMCALL
wrappers. Yilun noted this is a general in-memory ABI pattern which
exists in several places in TDX. Add the statement of in-memory ABI
handling in the changelog.

Other changes:
  - Patch 2: Drop the changelog section explaining why add-on feature
    enabling is needed in this series, as it is a generally understood
    pattern (Rick)

  - Patch 2: Add a note in the changelog that Dynamic PAMT is not
    enabled via the new bitmap argument of TDH.SYS.CONFIG (Rick)

  - Patch 4: Add code comments for hpa_list container page allocation
    (Kiryl)

  - Patch 4: s/PFN array/HPA array in changelog (Kiryl)

  - Patch 4: State the alternative memory adding solution and why we
    don't use it in changelog (Rick)

v1: https://lore.kernel.org/all/20260821032920.256225-1-yilun.xu@linux.intel.com/

Quoting v2: https://lore.kernel.org/lkml/20260618081355.3253581-1-yilun.xu@linux.intel.com/

Quoting v1: https://lore.kernel.org/all/20260522034128.3144354-1-yilun.xu@linux.intel.com/

== Overview ==

To date, SEAMCALL execution must either complete quickly to avoid
stalling the host, or yield quickly at pre-defined interrupt
checkpoints. This is acceptable for the existing SEAMCALL leafs,
which perform simple, bounded operations.

However, some new features such as attestation and TD migration require
higher level security protocols inside the TDX module, which cannot fit
within that constraint. TDX solves this by making those operations
inherently preemptible and resumable like OS tasks. TDX provides a
separate SEAMCALL execution environment - the TDX module extensions -
for those operations.

This capability allows for higher-level SEAMCALL ABI design - like
"create a DICE-based attestation quote". Several new features, such as
DICE-based attestation, TDISP and TD migration, use SEAMCALL leafs
backed by the TDX module extensions.

The TDX module extensions need memory for their execution environment
to serve these SEAMCALL leafs, so they need extra setup steps during TDX
module initialization. The bulk of this series implements these setup
steps.

At runtime, the host invokes these SEAMCALL leafs just as normal ones -
if interrupted, simply re-invoke the leaf to resume.

For more information on TDX module extensions, please refer to [1].

[1] https://lore.kernel.org/lkml/20260618081355.3253581-1-yilun.xu@linux.intel.com/

== Branch stack ==

This is based on v7.3-rc1. You can find the full branch stack at [2].
The DICE part is in the full branch as an example for extensions. But it
does not include the other DICE feedbacks.

The full branch contains:

  Dependency:  Patch 1:   SEAMCALL version patch [3] which is WIP on
			  community review.
  This series: Patch 2~7: This series, including this cover-letter.
  Use case:    Patch 8~N: The old DICE part as an example.

[2] https://github.com/intel-staging/tdx/tree/tdx-module-ext
[3] https://lore.kernel.org/all/20260910104347.625378-1-yilun.xu@linux.intel.com/


Xu Yilun (5):
  x86/virt/tdx: Move TDH.SYS.CONFIG operations into a wrapper
  x86/virt/tdx: Configure add-on features on TDX module init
  x86/virt/tdx: Detect if the extensions initialization is required
  x86/virt/tdx: Add extra memory to TDX module for the extensions
  x86/virt/tdx: Make TDX module initialize the extensions

 arch/x86/include/asm/tdx.h                  |   1 +
 arch/x86/include/asm/tdx_global_metadata.h  |   6 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 230 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  20 ++
 5 files changed, 252 insertions(+), 7 deletions(-)


base-commit: 3bfade11ab7be0a90eecc8a549b181863960b14e
-- 
2.25.1

