Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2348489D;
	Tue, 13 Oct 2026 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905612; cv=none; b=W8fqfa6Y7qJkihR/9Lt3LFy3Fz938m47QNudIqC5s8cf7EA+eKdz2wGByOZRnvGD55FrYw1SB53pCehPcF7rC7fHr5zDSUbnOGk7weS9q/5BbA+BPrfGFy7AGXd4+lbLlM3DAPagn4wNvnFCdOm/7yl9kILn/vr5H+kQujgNkpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905612; c=relaxed/simple;
	bh=M/Z6BSJlgL/L9aE/tWq/2GIxmVEo2nKwJ+b1XudSKMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hDQ+S3xSyyCuPvZUkow32MS/TOf6mVDzmUjo2vWLTUvd4HzS2w6uTcxuAMRrDQYF3dFiMUHvggbMlvoxZEylbAe1xs6W35tnH4iNRD7WtrrYHNXlQTDqLWmMrxeSDVnPxMfA9J4PaUou/svGal28MBpcEVZsYvx7l7Awoj6TL80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGVGFAu8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGVGFAu8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791905610; x=1823441610;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=M/Z6BSJlgL/L9aE/tWq/2GIxmVEo2nKwJ+b1XudSKMs=;
  b=HGVGFAu8siSMUG24bc5HgUnA4DpdHHlu6ev3Tfeg8QUD4rTS1qijTA2l
   yrT2Tpdr2/YBu9gYFwZUlW8zkBVK1rWxHd2F5zmU6dRJMznZaRa+xKAhr
   UUvU389kyr7uNOXrxGj9k0aBZLQV9iTCk0wbNDtA2tbrvg2giRyCjXoMe
   DzaAAaaW9AMuxghTwxzs/jzLIX3qQYsbkCypVXydQSLvVutaFZZTPG2ez
   5wO6BXyM/osmNbpAJfpkxHH/3Q6BtGeBqVam+aXC2jVbaEA5+XbOO2KDq
   0RUyCtM5RQ4gWXi0TAEJXzaaeWEqsl+tGgVzljdasrYc7lUREjq2uEx73
   Q==;
X-CSE-ConnectionGUID: CLelcdDjQMKzi08vmboJMw==
X-CSE-MsgGUID: ph2u2+1sQ42KmlMVlfzekA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="643361"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="643361"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:33:28 -0700
X-CSE-ConnectionGUID: Eg9g7xNbSS+kqrZRuC1dBg==
X-CSE-MsgGUID: eI4y4nYoTESqWQ0lu6H3RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1388077"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 13 Oct 2026 08:33:24 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v4 0/6] Enable TDX module extensions
Date: Tue, 13 Oct 2026 23:28:50 +0800
Message-Id: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJOzmoC/2WPQW6DMBBFr4K87qCxjQFn1XtUWdh4KJYAt8Ygo
 oi7xyFdVMpq9DX6T+/f2ULR08IuxZ1F2vziw5xD9VGwbjDzN4F3OTOBokbNa0huhym4dSSgPYE
 zXEvspeywYrn0E6n3+wn8uubcxzBBGiKZ/xjF81Vt2XCJjQYONz+uc7mvn6Of1730c6Kx7ML0h
 4z0u2a19OIyaxaC/J18uhTKtoILVymntW2arq1IGidRGaEVaaqVU9QLZE+dwS8pxNs5d5Mn7Kn
 EEd+WbRIQnFWis6is5u2b2/U4jge1CmnkQQEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4414;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=M/Z6BSJlgL/L9aE/tWq/2GIxmVEo2nKwJ+b1XudSKMs=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWSd8wvbPY03SPrRtykCVwN3zInese/A5UvBv77y/ZB//
 WPaiwl1tzo6WRjEOBgMxRRZFnjMcprSPotp66ed12DmsDKBDBGWqczMKc3Tqyh1yMwrSc3RS87P
 ZeDiFICpKixiZDhfrPTjo8CzJ8IqhyfHRW2dml9//3Gwur/0/55fLd+LnjcwMvTrXWOd4fxL3/3
 Fbf1i69A5n7/IMK+89bxN2d5oU+yPpYwA
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

Hi,

There is no open issue remain from v3. Most of the changes are small
nits and minor tweaks to the changelog. Most patches have collected 2+
Reviewed-by tags, but patch 4 (the last patch in v3) only has 1 RB so
still need more review from TDX developers/reviewers.

== Changes ==

Tony pointed out that the DPAMT support should be merged into patch 3
which adds memory for the extensions. Yilun answered patch 3 is already
quite heavy for review, so better move the DPAMT support to patch 4.
Tony then suggested adding a note to the changelog that patch 3 can't
work with DPAMT without patch 4. We've agreed on that.

Rick pointed out that copying the sysinfo_ext.memory_pool_required_pages
to a dedicated local var is redundant, except that the long name is hard
to fit in 80 columns. Rename the field to ext.required_pages and delete
the local var.

Other changes:
  - Patch 1: Cut the redundant opening words in the 1st paragraph (Rick)
  - Patch 2: Add explanation why kernel enables add-on features solely on
	     available support in the changelog. (Rick)
  - Patch 5: Specify what TDH.EXT.INIT is doing in the changelog (Rick)

v3: https://lore.kernel.org/r/20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com

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
      x86/virt/tdx: Support DPAMT when adding memory for the extensions
      x86/virt/tdx: Make TDX module initialize the extensions
      x86/virt/tdx: Re-initialize the extensions on runtime TDX module update

 arch/x86/include/asm/tdx.h                  |   1 +
 arch/x86/include/asm/tdx_global_metadata.h  |   4 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 250 ++++++++++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  14 ++
 5 files changed, 257 insertions(+), 14 deletions(-)
---
base-commit: 5b8212d45d99b77c84e3ad305a295e9e65d5ef20
change-id: 20260916-tdx-module-ext-da1930f33c04

Best regards,
-- 
Xu Yilun <yilun.xu@linux.intel.com>

