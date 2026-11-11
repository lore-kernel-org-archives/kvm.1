Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369418;
	b=bR99gtRg+3X486PRL2zARXiEbSNjx2VSwRh5EHYAeNtU4QVU8MeQSuV1S525TPDAKg0P
	 DQOssZiT9g93h1CYIkISm9Jv3raF9BaqsmDLGQwEMJFynZ0vLoUQAw5E2u6gktQaRYijs
	 tZR/4P5e/4XzKyqwW8ijo4CFpMU423cbKRr66CK1ITv6p6lqM+vo1cVc/s5GHyLTsrdh/
	 8LPVEJNLGD+6Cmv8eeyYmrjgQgmUBtgIh518v9mhQgF33udQjqvYBrAy8wU+gfthqafsu
	 2UCi2WCXLciSn0fKdMqs9HK6pq1Z74s4i16fKD4rZ8DvNqMY9QlOf3PVkPeQN4yz2Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369418;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zZDSaA2m1LuQ85T5Lp7wmP+f7M3OPYpfTRV4JXx1l9s=;
	b=LWL3R6VdFofjgDW9zuAAZEEjR6xL78Lm2og8b/PNjbLjq0ifVyBa5AcvGkJshZHJrwji
	 AK1BpKuhX7DArrm1aSVJGjynbv9FzeugEEXu5CRdFGjq9+B9xh2Ouc2o/Kv++m9ixyubr
	 hKVJ9jJOqhISSy9IFuqOUSoOIKKd0Q+xuveZ8UZfCdxsvePlmx7T2KjRPHSoiuLxhT+fg
	 zesZfj9sgNKTbypcQye71Np1xV+1GYexjFZRAFziE3Obx6OpJABp7+tKi82AJA45mFIXI
	 drDSaZKEtFrBajxdJ103MUnpmt+gAY6jIS88Hmv/b2K/q8p9Me46Bi8UXqcmu5WL8hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q8biu2XQ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A44606A320;
	Wed, 11 Nov 2026 03:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A44606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q8biu2XQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369418; x=1825905418;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=ev94+/CgdQfZh0Ci5qm8+0rb62bXposxq3SwiVYhvY4=;
  b=Q8biu2XQwCSA+A1PWn6eHfTrO4FFRGSiAwLREoYo3R++FU0UwqAGu5a1
   TdvQxEgl3cqR/TrZQ7EXHVNR8kCcKAFOclBJh4oUTe5B5hAg5VP+OfXrd
   TrHHpazDq2sM9oGHcKq7JHm7ibZehKK1b8Q1PF/qARDXUiwv4Pak0gDbn
   0LYHGEW6MgcUeI2IlmQl1D625qbOmFPpOcgZUr9FPe2ayT9EbbyF/JB85
   ziXLDNC2YS7faeLJqUmqQVXeNZJ8z24Zflh0manEZFEm/Bj92giGvGoXZ
   p9TztnqapoH5k7ndoAuFeV/xMrrslQJHIM/7lGVwQbsxV9ABRT2SP7WAr
   A==;
X-CSE-ConnectionGUID: 7ao2M/kAT/6brxahaYfnQQ==
X-CSE-MsgGUID: bwtrSGWJQVKBv+VnGbd7Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220271"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220271"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:56:57 -0800
X-CSE-ConnectionGUID: 4qZ/tp/pRaGtcwq4wegYUQ==
X-CSE-MsgGUID: APQreALKSDK7RWdwfYPE9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199168"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:56:53 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v5 0/6] Enable TDX module extensions
Date: Wed, 11 Nov 2026 11:48:41 +0800
Message-Id: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnl82oC/2XPy2rEMAwF0F8JXlfB7ziz6n+ULhxb7hjyaB0nZ
 Bjy73XSLgayEhehw9WTzJgizuRWPUnCNc5xGktQbxVxdzt+IURfMuGUa9oyDdlvMEx+6RFwy+A
 tawUNQjgqSTn6ThjidoIfnyWHNA2Q7wntK6NYmcrUDRO0aYHBI/bLWG/Lex/HZavjmLGv3TT8k
 wl/llIt/7mkszNC2Q4x3yqtucHGS6c7rpzxzAQmpEJhOfWcGd5aiw1KctS5xzlP6XG+u4oTOyo
 xSi+frQIo+E5x11HVtcxcuh3gKl8QJi6IPBBUIVinlWzoFdn3/ReYF/97hgEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=ev94+/CgdQfZh0Ci5qm8+0rb62bXposxq3SwiVYhvY4=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frrs98cPhW+eBfxnrP/+4tlXYXfuzr8xC39W6yffK
 43PD+t62tHJwiDGwWAopsiywGOW05T2WUxbP+28BjOHlQlkiLBMZWZOaZ5eRalDZl5Jao5ecn4u
 AxenAExV/iVGhhY+wb+unxV3TJk7jfXlhMiqXad7vk1s9dieoMD7aJa1P1DFS/trgs1HzU7xlMm
 8T5x3Wbg4Y11JFeuPD7suvtdetGklMwA=
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

Hi,

In v4, Dave raised concerns about the first patch. I refactored it and
dropped its RBs, so it needs more review from TDX developers/reviewers.

Based on some offline discussion, I refactored changelog for patch 3/4/5.
I also simplified the changelog for the rest of the patches. But the RBs
for Patch 2-6 are kept, please speak out if you object.

If these patches (especially Patch 1) get good reviews and no major
concern, Dave, please help take a look. Otherwise, feel free to ignore.

== Changes ==

Dave pointed out that the Patch 1 contained too much information, so
that it was hard to find out why a wrapper is immediately needed. He
also pointed out that introducing the new structure, tdmr_info_pa_array,
is orthogonal. Drop the new structure part. Further simplify the
changelog to make explicit the reason for the wrapper.

Dave pointed out that the changelog of Patch 4 doesn't catch the point
of why DPAMT support is needed. He also pointed out that the
bisectability concern between Patch 3 & 4 is not well explained.
Refactor the changelog of Patch 3 & 4.

We had an internal discussion about simplifying the Quoting extension
initialization flow. The conclusion is to integrate the TDH.QUOTE.INIT
operations (and potentially similar operations for other extensions)
into TDH.EXT.INIT. This raised a question about how to handle errors for
TDH.EXT.INIT if one extension fails while other extensions are good. The
solution in this series is to fail the whole TDX initialization on any
error, though we planned a solution when a nice-to-have extension
appears in the future. Describe the error handling in the changelog of
Patch 5, no code change.

v4: https://lore.kernel.org/r/20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com

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

This is based on v7.4-rc1. You can find the full branch stack at [2].
The DICE part is in the full branch as an example for extensions. But it
does not include the other DICE feedbacks.

The full branch contains:

  This series: Patch 1~7: This series, including this cover-letter.
  Use case:    Patch 8~N: The old DICE part as an example.

[2] https://github.com/intel-staging/tdx/tree/tdx-module-ext

== Test ==

We made agreement with TDX module team about some ABI changes, it
involves TDH.EXT.INIT, TDH.SYS.UPDATE.

This series is written against these unreleased changes. So we did 2
kinds of tests.

 1. Add some workaround patches in kernel then test on existing TDX
    module & real HW. See the full branch listed in "Branch stack"
    section.

 2. Customize the TDX module, mock the ABI change, run with the module
    in a virtual machine environment with virtual SEAM support, no real
    security in this environment.

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
 arch/x86/virt/vmx/tdx/tdx.c                 | 234 ++++++++++++++++++++++++++--
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  14 ++
 5 files changed, 244 insertions(+), 11 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260916-tdx-module-ext-da1930f33c04

Best regards,
-- 
Xu Yilun <yilun.xu@linux.intel.com>

