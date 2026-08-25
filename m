Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A6306B08;
	Tue, 25 Aug 2026 02:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626559; cv=none; b=pW+sJHUHSAiTZipxxlkHCdjGBQnI0tgYr+zmOJpWA33vQ52TVHbdFHDvLrkLo7yAQcOyhigVpAIBgybSgrqXrhUsw+hapK9l9XXM1xdM3skmotax6TxMUZM32FUfgN3518bLd/PXI+XZLSiESlmDEHmzpLJgyWpxzQym6QdfSIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626559; c=relaxed/simple;
	bh=PQw6Zis9OqjZytWuzgs/pIEmlrlgQth66BgDqg9m6oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IZwpCK1e5LvCmt8a+4DSqgLUBtbLtsM2UHvvOyvaTGHkIhXgoSmdZzppDLoLW9T5Eykj45UJ8biVH87CIrGrCHpQcDVVwOP9wWhBG6hBp7xqK2xxryRtKBQSUgLqB2Fqo9K0Wy1ytxz5bl2q5xJGf+m8LR505JQYtSbfBWvZKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fIbMun8S; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fIbMun8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787626557; x=1819162557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PQw6Zis9OqjZytWuzgs/pIEmlrlgQth66BgDqg9m6oA=;
  b=fIbMun8SPYFhjn2rB0b9fHTBzTu1QmPYFU+rSbZ7WRAAWvCRM7pe59nt
   4WEGnfVtamcl8UJfgddTx2AxLSGZMZXfyRlsBBu7iOEYxwghUXrAJ7q+Z
   /efDFQ+owPPm5Yh4omhaW+56YRnN5gnhbPUDLY9zfnEBaCOM1+be/0zf2
   cWYD5zYRyS9X+ahtNt50xrTnBPK8WII6MBNcZ81phUsVTv+g1llM8zA+e
   pFSbaGa4XSNmviHaMb+LsvYTDiHFFJ6hhvYg/XclsP3/l+ZJ3y/VyFz+m
   PS/Zms15DJaTOrPOWe/nOgGO4Fmjqz0seau+REMEDDTMOrQDmRGkjLzfI
   Q==;
X-CSE-ConnectionGUID: Ms1IuMm5SXytwgMcOHXLlg==
X-CSE-MsgGUID: nZQirKdtT4u4K5siq2zXtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91903799"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91903799"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:55:57 -0700
X-CSE-ConnectionGUID: xAnIDxS7SeO0s1q9IIpRcw==
X-CSE-MsgGUID: /P2OWF9ISbK0KVrkaihM0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="267222926"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:55:52 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: kas@kernel.org,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	rick.p.edgecombe@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	kai.huang@intel.com,
	yilun.xu@linux.intel.com,
	vannapurve@google.com,
	ackerleytng@google.com,
	sagis@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
Date: Tue, 25 Aug 2026 10:55:33 +0800
Message-ID: <20260825025533.25663-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a warning on a !4K level to loudly flag the unexpected condition when
callers pass in a level > 4K before tdh_mem_page_aug() supports huge pages.

The warning makes the unexpected condition more obvious since the SEAMCALL
TDH_MEM_PAGE_AUG does not necessarily fail when the level is above 4K,
while tdh_mem_page_aug() only flushes the cache for a 4K page before huge
page support is added.

Do not drop the "level" parameter instead, as it will be needed once huge
page support is added.

Do not use a stronger BUG_ON() because the cache flush is only needed when
the TDX module exposes a CLFLUSH_BEFORE_ALLOC bit, which has not yet been
observed in any TDX modules.

Reported-by: Kiryl Shutsemau <kas@kernel.org>
Closes: https://lore.kernel.org/all/abvxiuJfK2eM_1UX@thinkstation
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 42df8ea464c4..5c0e91b4aa4f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1722,6 +1722,8 @@ u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level,
 	};
 	u64 ret;
 
+	/* TODO: handle large pages. */
+	WARN_ON_ONCE(level != PG_LEVEL_4K);
 	tdx_clflush_pfn(pfn);
 	ret = seamcall_ret(TDH_MEM_PAGE_AUG, &args);
 

base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.43.2

