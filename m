Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29C227B94;
	Thu, 30 Apr 2026 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516128; cv=none; b=fHA6wPsQ8X3YOxWe34HjD/IErTDT6gXUFxUYO8iLIcN8gTbogbO9eud14UwEKNVtKkWdPvXlQHDx7B+WfSlynn59CydMeGvetcvaKYhwEnhUk/INliS8AsbcjFMMvaDw+nmAYVjVU6ZQU3PuXfkXTAOdNRAB4RK7osE0gern9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516128; c=relaxed/simple;
	bh=nPNoW2pYPDravTZkT2VTal7aTO1BdgdClA3Kh7Skva4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKy4ykc/FzteoBUjJj9nhtsSeZ8q9/2VEaCAxC5y39iW7JPPFwkY2pvcbPVZYQT0wx5clxQvD43RQFdAg/9D51cZjtE6hy5CeHJMYys5g6OuMJzIZcW/UjrtKYLpFIq3BWBrQ4Rx2wshZiJMuLKxtwWzjABDLjqeotCYhakJEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EjoBrZgv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EjoBrZgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777516127; x=1809052127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nPNoW2pYPDravTZkT2VTal7aTO1BdgdClA3Kh7Skva4=;
  b=EjoBrZgvs2fE42tXbvrSOn9dHrrDckDdugw5Mg4XEpHbLJuo3BidNGCm
   c5ONf7ZbKqBR/MW0k2msqqwXYXX+B00kV2/MV8Cn1T56MJRgjco7Z37RX
   JcUYlXrPI/Jm+3f8HBH7svQ8CgC1yGHhRXIMzDFXRZEY7KPkjkfJ9Yd8X
   6KXgasQ4kA5UlrDcwK9gwahEcFvrIMHC9BPR9Y+sGEfeXv05Y/zrb1+4i
   9OihdWc6EtU/6eUZqwdG2c++SwnIePpwb6KczTx1ODWu42OUM3msU4YS5
   xzm59dN5VJoLXEH+1FtNm8/dpKIN9NMQj7Fw3+8tf7T3pnlSwMg8flTVP
   w==;
X-CSE-ConnectionGUID: Ts7wTPnmRL23sCRUy5PBUA==
X-CSE-MsgGUID: 9sqnNJD+SKmpevNXyY7NIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78562687"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78562687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:28:46 -0700
X-CSE-ConnectionGUID: vArqlbUQSuukWfm7+dKNdA==
X-CSE-MsgGUID: VwOBPzZdRqmi2IBQ8ArlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="272563436"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:28:42 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: dave.hansen@linux.intel.com,
	pbonzini@redhat.com,
	seanjc@google.com
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
Subject: [PATCH v2 0/4] struct page to PFN conversion for TDX guest private memory
Date: Thu, 30 Apr 2026 09:48:52 +0800
Message-ID: <20260430014852.24183-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi

This is v2 of the struct page to PFN conversion series, which converts TDX
guest private memory mapping/unmapping APIs from taking struct page to
taking PFN as input.

v2 is based on v7.1.0-rc1 + Sean's 4 cleanup patches (see details in
section "Base" below). The purpose is to get Dave's Ack, so Sean can take
it from the KVM x86 tree. The full stack of v2 is available at [14].

Compared to v1, v2:
- Rewrote commit messages of patches 1/2 (the conversion patches for
  mapping and unmapping) by specifically explaining the downside of
  assuming guest private memory must be backed by struct page, and
  incorporating Dave's rewording that also works for Sean.

- Updated patch 2 (which is for unmapping) to use tdx_quirk_reset_paddr()
  directly for unmapping guest private memory, and added patch 3 to drop
  the exported function tdx_quirk_reset_page() by having KVM invoke
  tdx_quirk_reset_paddr() in all scenarios, as suggested by Paolo and
  Xiaoyao.

- Split patch 4 (moving mk_keyed_paddr() to .c) out of patch 2, so patch 2
  can focus on the struct page to PFN conversion for unmapping.

Note: as agreed in v1, Kirill's concern about AUG "level" will be addressed
in a separate patch later.


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
how KVM and guest_memfd manage memory [7]. So, Sean suggested converting
from using struct page to PFN for SEAMCALL wrappers operating on guest
private memory [8].

This series therefore converts struct page to PFN for guest private memory
while keeping struct page for TDX control pages, and uses kvm_pfn_t for
type safety.


Sanity check
------------
Reasonable PFN sanity checks in the guest private memory mapping/unmapping
APIs are still agreed upon [9][10], such as checking TDX convertibility to
avoid SEAMCALL failure.

However, we decided not to provide any in-kernel sanity checks to avoid
introducing unnecessary overhead, both because those failures are supposed
to only occur when there are kernel bugs, and due to the lack of
satisfactory tiny checks to ensure convertibility. When unexpected
non-TDX-convertible PFNs are passed in, just let SEAMCALLs fail or have
#MCs or #PFs generated, which are obvious enough in themselves.


Base:
----
This v2 is rebased on top of v7.1.0-rc1 (kvm/next, commit 39f1c201b93f) +
the first 4 patches from Sean's v5 "TDX: Dynamic PAMT + S-EPT Hugepage"
series [11].

Note: due to the instability of v7.1.0-rc1, I also applied series [12] and
[13] to pass CI.


Changelogs:
-----------
v1 [1] --> v2:
    1. Updated patch logs of patches 1/2. (Dave).
    2. Added patch 3 to drop tdx_quirk_reset_page() and export
       tdx_quirk_reset_paddr() only. (Paolo, Xiaoyao)
    3. Split out patch 4 to move mk_keyed_paddr() from .h to .c.
    4. Rebased to v7.1.0-rc1 + Sean's 4 cleanup patches.

Sean's original patch [0] --> v1:
    1. Rebased to kvm-x86-next-2026.03.13.
    2. Split to 2 patches for easy review.  (Rick)
    3. Replaced "u64 pfn" with "kvm_pfn_t pfn"  (Rick)
    4. Dropped using PFN as input to tdx_reclaim_page(). (Rick)
    5. Move mk_keyed_paddr() from tdx.h to tdx.c. 

Thanks
Yan

[0] https://lore.kernel.org/kvm/20260129011517.3545883-26-seanjc@google.com
[1] https://lore.kernel.org/all/20260319005605.8965-1-yan.y.zhao@intel.com
[2] https://lore.kernel.org/all/30d0cef5-82d5-4325-b149-0e99833b8785@intel.com
[3] https://lore.kernel.org/kvm/f4240495-120b-4124-b91a-b365e45bf50a@intel.com
[4] https://lore.kernel.org/kvm/435b8d81-b4de-4933-b0ae-357dea311488@intel.com
[5] https://lore.kernel.org/kvm/1b236a64-d511-49a2-9962-55f4b1eb08e3@intel.com
[6] https://lore.kernel.org/all/20241010182427.1434605-1-seanjc@google.com
[7] https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com
[8] https://lore.kernel.org/all/aWe1tKpFw-As6VKg@google.com
[9] https://lore.kernel.org/all/aWkVLViKBgiVGgaI@google.com
[10] https://lore.kernel.org/all/d119c824-4770-41d2-a926-4ab5268ea3a6@intel.com
[11] https://lore.kernel.org/all/20260129011517.3545883-1-seanjc@google.com
[12] https://lore.kernel.org/all/20260423155611.216805954@infradead.org
[13] https://lore.kernel.org/all/20260428024746.1040531-1-binbin.wu@linux.intel.com
[14] https://github.com/intel-staging/tdx/tree/struct_page_to_pfn_v2


Sean Christopherson (2):
  x86/tdx: Use PFN directly for mapping guest private memory
  x86/tdx: Use PFN directly for unmapping guest private memory

Yan Zhao (2):
  x86/tdx: Drop exported function tdx_quirk_reset_page()
  x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due to no external users

 arch/x86/include/asm/tdx.h  | 21 ++++++-------------
 arch/x86/kvm/vmx/tdx.c      | 17 ++++++++--------
 arch/x86/virt/vmx/tdx/tdx.c | 40 +++++++++++++++++++++----------------
 3 files changed, 37 insertions(+), 41 deletions(-)

-- 
2.43.2

