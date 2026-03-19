Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE8329361;
	Thu, 19 Mar 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884153; cv=none; b=p7lPrgIptMIs3JftWMGQjBlMuTo8EOZ+MvrhhgMxhUA++wyHLi9NKkEWUrgOPDwMyeLKna1BHn9ENUwZ9JYFfEGmELvSA/AhPbdY+8R3FNxMPAIUvyah75NCYgKU+G5kynMbqkLGicE2CD7kNaUReLkxNoSCx5IYGs+Gu9zYibk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884153; c=relaxed/simple;
	bh=yKqrcSiF0T/o2eNSZnD8zrr1iTgy55Kam7OJIgVL6yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISdbafRLOc4Cfp0CyKPOkyfvbpZRa9GugfYFIJWm6YEXR/TEuM+cOmUXta9VCnZ8yXn8iwSPwxSUsi58tx59/PY8FPu0c/Erxu/3L0MIIPf1dl9AjKoNtmkxeQYMF313naE3CZ/2bLYV7GOLREOY6Zw4b23cZ0muc3gubi90218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaOH3VJP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaOH3VJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773884145; x=1805420145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yKqrcSiF0T/o2eNSZnD8zrr1iTgy55Kam7OJIgVL6yM=;
  b=SaOH3VJPlrHa36UMsB7L6g5TETfJI95SUAD2DP8PZf6+gc9ValU5cro7
   ZcP0+htRgdVhdPxx/yLKfm8PNQz1ORjFB1Jf5q/D0fCWMqLsc4RvZCXoO
   j10u2Flrq5CkHuVdwAm+bJzoxbLDxSECQD9HcuwzPsxXzQ6Onh96pwSot
   lCGe/iXdlvhlznv4P5HACOHAStxwZjN832RN0lkcOVkD2w5okIR9zEF0M
   Gbgt/h36fGPg3asIxDBIRLZUTs5Lg6/JR6FlV4c4N6fSaD7ONLpahmDV+
   7HNZbRz9NGKqUQOmNREcvtih+VfpCcwi/Dktbm7tXmiDuZV52KBQa60m4
   Q==;
X-CSE-ConnectionGUID: srCnhQJwRgqWuaN/+J/2Vw==
X-CSE-MsgGUID: sJZ5L41/S+eu/zC74gEMgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="92524971"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="92524971"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:35:44 -0700
X-CSE-ConnectionGUID: 1GB3h4GnR7q/SXkcR5mseg==
X-CSE-MsgGUID: RL6VbZfhQraHjGwfwMsTJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="222855512"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:35:38 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	kas@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kai.huang@intel.com,
	rick.p.edgecombe@intel.com,
	yan.y.zhao@intel.com,
	yilun.xu@linux.intel.com,
	vannapurve@google.com,
	ackerleytng@google.com,
	sagis@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	isaku.yamahata@intel.com
Subject: [PATCH 0/2] struct page to PFN conversion for TDX guest private memory
Date: Thu, 19 Mar 2026 08:56:05 +0800
Message-ID: <20260319005605.8965-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts TDX SEAMCALL APIs for mapping/unmapping guest private
memory from taking struct page to PFN as input.

Background
----------
TDX SEAMCALL wrappers take struct page as input, which provides:
1. Type safety
2. Make it harder to misuse and make it obvious that physical pages in RAM
   are expected from just looking at the API declaration [2][3][4][5].

This is appropriate for SEAMCALL wrappers for TDX control pages (e.g., TDR
page, TDCS pages, TDX SEPT pages), since KVM manages and allocates those
pages explicitly from core MM.

However, unlike TDX control pages, KVM guest memory is not necessarily
backed by refcounted struct page or even struct page (e.g., VM_PFNMAP
memory [6]). Taking struct page as input for SEAMCALL wrappers for
mapping/unmapping guest private memory imposes unnecessary assumptions on
how KVM and guest_memfd manage memory, even though today all TD private
memory is allocated from guest_memfd, which only allocates memory backed by
struct page.

To avoid baking in assumptions throughout KVM about guest memory being
backed by page (or further folio for future TDX private huge pages [7]),
Sean suggested converting from using struct page to PFN for SEAMCALL
wrappers operating on guest private memory [8].

This series therefore converts struct page to PFN for guest private memory
while keeping struct page for TDX control pages, and uses kvm_pfn_t for
type safety.

Sanity check
------------
Reasonable PFN sanity checks in SEAMCALL wrapper APIs (such as checking TDX
convertibility to avoid SEAMCALL failure) are still agreed upon [9][10].

However, as those failures are supposed to only occur when there're kernel
bugs, we decided not to provide any in-kernel sanity checks to keep the
code simple. i.e., when non-TDX-convertible PFNs are passed in, we let
SEAMCALLs fail. Though non-TDX-convertible PFNs may also produce MCEs or
page fault exceptions, this is a separate issue than struct page to PFN
conversion, and such exceptions are obvious enough in themselves.


Changes from Sean's original patch [1]:
---------------------------------------
1. Rebased to latest kvm-x86 next
2. Split to 2 patches for easy review.  (Rick)
3. Replaced "u64 pfn" with "kvm_pfn_t pfn"  (Rick)
4. Dropped using PFN as input to tdx_reclaim_page(). (Rick)
5. Move mk_keyed_paddr() from tdx.h to tdx.c. 

Thanks
Yan

[1] https://lore.kernel.org/kvm/20260129011517.3545883-26-seanjc@google.com
[2] https://lore.kernel.org/all/30d0cef5-82d5-4325-b149-0e99833b8785@intel.com
[3] https://lore.kernel.org/kvm/f4240495-120b-4124-b91a-b365e45bf50a@intel.com
[4] https://lore.kernel.org/kvm/435b8d81-b4de-4933-b0ae-357dea311488@intel.com
[5] https://lore.kernel.org/kvm/1b236a64-d511-49a2-9962-55f4b1eb08e3@intel.com
[6] https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com
[7] https://lore.kernel.org/all/aW3G6yZuvclYABzP@yzhao56-desk.sh.intel.com/
[8] https://lore.kernel.org/all/aWe1tKpFw-As6VKg@google.com
[9] https://lore.kernel.org/all/aWkVLViKBgiVGgaI@google.com
[10] https://lore.kernel.org/all/d119c824-4770-41d2-a926-4ab5268ea3a6@intel.com/


Sean Christopherson (2):
  x86/virt/tdx: Use PFN directly for mapping guest private memory
  x86/virt/tdx: Use PFN directly for unmapping guest private memory

 arch/x86/include/asm/tdx.h  | 20 +++++---------------
 arch/x86/kvm/vmx/tdx.c      | 17 ++++++++---------
 arch/x86/virt/vmx/tdx/tdx.c | 36 ++++++++++++++++++++++++------------
 3 files changed, 37 insertions(+), 36 deletions(-)


base-commit: 3d6cdcc8883b5726513d245eef0e91cabfc397f7
-- 
2.43.2

