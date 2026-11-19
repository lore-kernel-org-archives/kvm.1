Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074489;
	b=t4zZFRZE50c/BDoSzAXprSfCfCb/BiVwkBIpV/5OBIFXkiyDUUCXsaSPFviEhGt4um64
	 VdrN2XnobDSuTTJRrbhKYpEkyoeXLEymJxeekXSS//cLBGd0vX7p9vNzA9UxmITHugkUO
	 Li+QPS2tyKJOdTtBN2z0IhzUfY3Cx/zy1A5HAkBkcojj/cUOcBGKh7A7WbnH9/MOKxPag
	 M+jioaoFco2YpgP1zZxiBww+6D/heTE/cSWwtMnzO0oIt7suSD0axVGS+ljV2jggwhRmO
	 ndw2A+9k+jQvI5tcT3PXbEXF0+iMerGkA8ki61a2nI+YuQCe/oRrx7O1azPSRIhmljg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074489;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jNLo4L7xsjJ6BaPKCERE0sOyuC8NZ5ENucaGBkqUkXI=;
	b=ML/nS8pHrl8XR9EeLJe5MpIz9343d75sDOThMogJa0env3gt4be/8KmL305U3FZUbOKh
	 jYt0++MjFXWHeh/NwmKW5sGHHoa84BlbDh3cVwZb9UiL2hH+hrl2jQg4elteSPogMME/B
	 cpGJ88JuBj7rpsrL4RFaTlSzZaSgoHKFO0enR3Ik6wpy+kUAAKeX0iNhZkPJYefytj8h2
	 jdb3VPCq0QGhv0d2EKgwUGEv1RRgyXdEzqrjyAT4mvrFqKKI/W8lSxCmu5gbmhW0r7bkp
	 oxjAxR2ix+R8HfbZX9g000IQeUWLwuVxyjxTKtg4td61n5+wCjFMMtG9UwsohL7r4Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=chsLigjU;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524B60A2610;
	Thu, 19 Nov 2026 07:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3524B60A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=chsLigjU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795074488; x=1826610488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5mzlYW7kCVt5GKMszZ38TxYa88CDIkHfueswCEeBz4k=;
  b=chsLigjUCOFDl6u+ZEKgAgs7qM3sWf9wnZE6DXabII+VhhMpis6c5Q8G
   hdBu8hItVI8BJvc4uqyQ+ni7HrN1Xdjae3jCbjaOnmQAxLL8Yinued2HB
   u18iM0aF73pIoui0+2fci02FEiJ4wbvWw94HYFi2/UTud5Z2Xi2kw1HOX
   UizzYqhpSPUQXjOYeBrraAO1fRufaukSMjU/ZU0tX4ppyuKQo60FFNPec
   EnqWouiWL6fQ1yLe48gzCTQbxt1lzKV5i2RhlHeMahSh+pVYRo6unRCJ7
   BxZ04/OUAkkKIxURAHG2HHjFq2Xr7VKJ7lRzJ5Z6SWhO+0I8Y9a3zqleH
   g==;
X-CSE-ConnectionGUID: JnIrEug8SFSQ3PIYa7xmtA==
X-CSE-MsgGUID: QAW0MNHIR6qYYUobAx5bhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3941737"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3941737"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:48:07 -0800
X-CSE-ConnectionGUID: n676emqiR2ybYnwZzM5Img==
X-CSE-MsgGUID: Js67GAVuRQqcRFLs4HeVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10725806"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:48:07 -0800
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yilun.xu@intel.com,
	arjan.van.de.ven@intel.com,
	binbin.wu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 0/2] TDX: P-SEAMLDR: Support large TDX modules and sigstructs 
Date: Wed, 18 Nov 2026 23:49:20 -0800
Message-ID: <20261119074925.3933804-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series lets TDX module updates handle large TDX modules and
sigstructs. I dropped the RFC tag because there are no open design
questions.

Dave, feel free to ignore this series for now. TDX developers, please
take a look. I would like to collect Reviewed-by tags on this version.

== Changes ==
Changes since RFC v2:

There is no functional change. Apart from comments, the code differs
from v2 only in how the maximum module page count is derived.

- Compute the size of module_pages_pa_list[] from the size of 'struct
  seamldr_params' and explain the math. [Rick/Yilun]
- Call out that a 496-page module now requires chaining support. [Binbin]
- Drop the exact entry counts (496/495) from the ABI description. [Yilun]
- Note in a comment that sigstruct_pages_pa_list[] is never chained. [Yilun]
- Comment the PAGE_ALIGNED() check in populate_pa_list(). [Rick]
- Explain why the sigstruct list is already filled in a loop. [Rick]
- Drop the AI usage note from changelogs. [Dave]
- Rework changelogs to be easier to follow.

v2: https://lore.kernel.org/all/20261106132159.1551365-1-chao.gao@intel.com/
v1: https://lore.kernel.org/kvm/20261030085304.3886520-1-chao.gao@intel.com/

===

This series is a follow-up to the TDX module update series. As thanks
for merging that series, we agreed to take on the TDX metadata cleanup [1].
With the cleanup converging, we are starting on this work and expect it
to be merged after the cleanup.

Today a TDX module binary can be at most 496 pages and its sigstruct at
most one page. Both limits come from the P-SEAMLDR ABI.

TDX modules are outgrowing them. A post-quantum signature algorithm
pushes the sigstruct past 4KB, and new module features push the binary
past 496 pages. The P-SEAMLDR ABI was extended for both.

The kernel rejects any image over these limits. TDX modules for Diamond
Rapids exceed them, so without this series, TDX module updates fail on
Diamond Rapids. This series is all that is needed to make them work.

The image format that userspace uploads ('struct tdx_image') is generic
enough and needs no change.

== AI Usage ==

AI was used under supervision to review code and refine commit messages.

== Testing ==

Tested on a Diamond Rapids system. Updates with a module larger than 2MB
and an 8KB sigstruct work, which exercises both the chained page list
and version 1 of 'struct seamldr_params'. TDs keep running across
updates.

== P-SEAMLDR ABI changes ==

The public P-SEAMLDR specification will be updated to document these
ABI extensions. Until then, here are the changes to
'struct seamldr_params' that this series relies on:

- VERSION (offset 0) may now be 1. Version 1 support is enumerated by
bit 8 of SEAMLDR_FEATURES0.

- SIGSTRUCT_PA_1..3 (offsets 16, 24 and 32) are new. In version 1, they
hold the addresses of the second to fourth sigstruct pages, or 0 if
the sigstruct does not reach that page. In version 0, they must be 0.

- RESERVED shrinks from 104 to 80 bytes and now starts at offset 40.

- MOD_PAGES_PA_LIST (offset 128) can be chained. For a module over 495
pages, its last entry points to a 4KB page holding up to 511 more
addresses. Each such page uses its last entry to point to the next
page, until all module pages are listed. Chaining support is enumerated
by bit 11 of SEAMLDR_FEATURES0.

Chao Gao (2):
  x86/virt/seamldr: Support large TDX module binaries
  x86/virt/seamldr: Support multiple sigstruct pages

 arch/x86/virt/vmx/tdx/seamldr.c | 48 +++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)


base-commit: 5b8212d45d99b77c84e3ad305a295e9e65d5ef20
-- 
2.52.0

