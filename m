Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F24CDDCA;
	Mon,  5 Oct 2026 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222346; cv=none; b=DEgrAxu3RoIJ64XVIwt9NYL2SddQOlolTZ48tj/o29RbiPQSqxi8nq1rv3QF8feKqCNeHhQJIoL1Ejwnf/K3Pd1kliegLw6w5AhoJN1GiTI/bOkvQ2nlBr/HYOKHaxQqlP3G7IHiouZ1XnAXZ92x5z+TOLl+7HLNgAewzwRFPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222346; c=relaxed/simple;
	bh=axAQbSMRh19w8K6FFfPQk/Jrv7bFWll8doi5cLGWUjg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ld6ywZBhrbl+tLN4TfbVK+bAlliRQNSZ+EfV5kq9jIHYmTurEFq5Ed245Lf76yYO9bmdbpTckWbJDt6oIWPHumGs5Z6Fae0p4OPGgNyB0rhI0kys+fnkLQfZptRDhtb5KLmTvf83c7DI8vyy5xR0gB2DGYquVlKPVyyZ4XSgP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nH0+UdlS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nH0+UdlS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222345; x=1822758345;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=axAQbSMRh19w8K6FFfPQk/Jrv7bFWll8doi5cLGWUjg=;
  b=nH0+UdlSDKxl92cCkjt/pXwHm3D1TVxPzdQZ0bXBJCr7+U/a7N9D2m49
   huDKOHZ/4daHrP1UuyXukRqxGGSuantozmQLPDSUiBpvkYiEc07rrKX9R
   EyZF1OIDvWNqPxLpWHttU0A6F2bp/OIoFKyVaE0raECGuwcTHsSsqjygx
   ruzX+DB/bj5dFpipOh59zofQVqha52XVU7VEXy1C1u/uH54pAHLyzC8VE
   bV4EjcsoPOhI0NHgjE0w3CeV69Zqek65FVicbqqi03uO1gCqv4XMC1LyM
   QWjM/JyPSH3UuhciLjRIMccBNiIDRh1w03qx+V17YzYn0zmXGU1JH8W7f
   A==;
X-CSE-ConnectionGUID: Rp+2cGR5R3+BYqQGCSO4Hw==
X-CSE-MsgGUID: veaJASFVSySdcRXHiORPyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102419761"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102419761"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:45:44 -0700
X-CSE-ConnectionGUID: CcCNvYJBRC+feANmU66S2A==
X-CSE-MsgGUID: NQczKWVdRMCsInsZ+/ei4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276002263"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 10:45:40 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 0/6] Enable TDX module extensions
Date: Tue, 06 Oct 2026 01:41:44 +0800
Message-Id: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFnhw2oC/02Oyw6CMBREf4V07SV9UKCu/A/jotCL3gSKltbUG
 P/dRl24mpxM5mSebMNAuLF99WQB77TR6guoXcXGi/VnBHKFmeSy5Ua0EF2GZXVpRsAcwVlhFJ+
 UGnnDyugacKL8ER5PhaewLhAvAe2/RouSuq87oXhnQMCD5uTrnA4z+ZRr8hHnelyXnzLgLZVr8
 etlg90QSrtQ3Fd66KWQrtHOmKHrxr5BZZ3i2kqj0WCrncZJcnZ6vd4XwLg37wAAAA==
X-Change-ID: 20260916-tdx-module-ext-da1930f33c04
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6499;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=axAQbSMRh19w8K6FFfPQk/Jrv7bFWll8doi5cLGWUjg=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWQdfjhz08Rf/65NceNTMf0sm/j84Df17JeXG8v0VSu0T
 Exva+493dHJwiDGwWAopsiywGOW05T2WUxbP+28BjOHlQlkiLBMZWZOaZ5eRalDZl5Jao5ecn4u
 AxenAExV91eG/5kaDl/7tx8y8yz5KH5q2f/2Q+q98ruYXDZImmds2D6nWIiR4blD6UXO9nWPAlZ
 8Lp3Adix7jtbV2yc2i+pen/duxg2Ht4wA
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

Hi,

This is another respin of the TDX module extensions series. Thank you
all for the design discussion and architectural review. During the last
version, some architecture discussions lead to changes. And the need to
support DPAMT creates more touch points. But the all the design issues
are settled, we don't have any major opens.

So Kiryl, Rick and TDX developers, please help review. If there is no
major change, I hope to get your RBs and then ask Dave to look at this
version.

== Changes ==

One change is that the extensions re-initialization patch is picked back
into this series. In v2, the extensions re-initialization operation
(TDH.EXT.INIT) was expected to be integrated in TDH.SYS.UPDATE. Host
didn't have to explicitly invoke it on update anymore. But later an
off-list discussion concludes that the separation of TDH.SYS.UPDATE &
TDH.EXT.INIT brings more flexibility for needs from different types of
VMMs, such as reducing the black-out time of update, allowing for new
feature enabling... So now the host needs to call TDH.EXT.INIT right
after TDH.SYS.UPDATE to restore the extensions functionalities.

However the add-on feature re-configuration is orthogonal to the
update flow change. We should still start with the basic update
functionality that restores the previous settings. Re-configuring new
feature is a separate functionality and the use case is unclear now.
So I still expect that a TDH.SYS.UPDATE v0 would restore add-on features
that was configured during boot.

Rick pointed out that if TDH.EXT.INIT could always return a reasonable
return code, we don't have to query ext_required metadata. A fix for the
ABI is: TDH.EXT.INIT should return success if no extensions are
required. We reached agreement with TDX module team and removed
ext_required. After ext_required removal, the v2:Patch 3 became too
trivial so merge it into v2:Patch 4.

Rick raised a question that a single 4K allocation per iteration on
boot may not cause much fragmentation. Kiryl answered
CONFIG_SHUFFLE_PAGE_ALLOCATOR may affect the actual behavior but we'd
better verify this in practice. The test result shows the allocation is
affected by several aspects, e.g. MPOL_INTERLEAVED, per-CPU page cache.
The allocated pages were scattered across many more page blocks than
expected.

The DPAMT is now queued in tip x86/tdx and will be default on in next
rc1. Adding memory to the extensions without first installing DPAMT will
trigger SEAMCALL failure and in turn fail the whole TDX module
initialization. Add a new patch to support DPAMT.

Other changes:
  - Patch 1: sizeof(tdmr_pa_array->phys[0]) instead of sizeof(u64)
    (Rick)

  - Patch 1: Re-phrase the code comments for struct tdmr_info_pa_array
    (Tony)

  - Patch 2: Update the stale changlog for bitmap arg of the wrapper
    (Chao)

  - Patch 2: s/get_tdx_addon_features0()/get_tdx_usable_addon_features0()
    (Tony)

  - Patch 3: Don't save the metadata in tdx_sysinfo (Rick)

  - Patch 3: Tweak the code comment for memory_pool_required_pages == 0
    (Chao)

  - Patch 3: Re-phrase the code comment for struct tdx_hpa_list (Tony)

  - Patch 5: Rename the reinit function as reinit_tdx_module_extensions()
    (Tony)

  - Patch 5: Move the extensions re-init under TDH.SYS.UPDATE (Rick)

v2: https://lore.kernel.org/all/20260915102658.713079-1-yilun.xu@linux.intel.com/

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

This is based on tip x86/tdx. You can find the full branch stack at [2].
The DICE part is in the full branch as an example for extensions. But it
does not include the other DICE feedbacks.

The full branch contains:

  This series: Patch 1~7: This series, including this cover-letter.
  Use case:    Patch 8~N: The old DICE part as an example.

[2] https://github.com/intel-staging/tdx/tree/tdx-module-ext

---
Xu Yilun (6):
      x86/virt/tdx: Move TDH.SYS.CONFIG operations into a wrapper
      x86/virt/tdx: Configure add-on features on TDX module init
      x86/virt/tdx: Add extra memory to TDX module for the extensions
      x86/virt/tdx: Make TDX module initialize the extensions
      x86/virt/tdx: Re-initialize the extensions on runtime TDX module update
      x86/virt/tdx: Support DPAMT when adding memory for the extensions

 arch/x86/include/asm/tdx.h                  |   1 +
 arch/x86/include/asm/tdx_global_metadata.h  |   4 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 252 ++++++++++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  14 ++
 5 files changed, 259 insertions(+), 14 deletions(-)
---
base-commit: 5b8212d45d99b77c84e3ad305a295e9e65d5ef20
change-id: 20260916-tdx-module-ext-da1930f33c04

Best regards,
-- 
Xu Yilun <yilun.xu@linux.intel.com>

