Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD94C81;
	Thu, 30 Apr 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516206; cv=none; b=I2psPXDlJaX3+7MkdaHAZ5vl/TK79siN4olvub4lOt7USQrTCFvWA3zdWmsmLVo5CpPuICEwZql0zsbARqd8UOjV9Gf1iGbRtaLKyfzazbCGbgqJ/6R1pecaOXKeS9Ypr2HRa8gg1sDaQqr8LV8Bi9d9ddxIfRovtZyL1RtM+yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516206; c=relaxed/simple;
	bh=W20h4mNal54IzmOL9brZpbD6vtPfbqbc4RdwPgZVbfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBv0PDvzAKynBfbzd+68bEg5ymiXoiTC8YfEO23b6XPQFaFKaJU0iWb9V1NWsR/RF8cZEuJPK2hIDPYgTc71Ip+cBzU4nfx9HjCXkB4EHjfNUCPKuNAXmZ6idsrwVSEY289zJTFdXCrooC8O6jUWA8ky6u02Y2wn01gHpfwsHwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKbW/oPl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKbW/oPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777516206; x=1809052206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W20h4mNal54IzmOL9brZpbD6vtPfbqbc4RdwPgZVbfk=;
  b=AKbW/oPlYKFVygLCa/K3+5BiGgo8eJipLa2hI33CeMxzh/H0ayK5cp4c
   8b/Jno236MgvLwLoNyJx+bXUNR4Mb6PsULjG/EhuP1Yqk3GS+zmjpQoId
   9fWAJrRnbpsJ6zcQzwprBIOe4H/uOKiTMHKphsti6EU9zTu+mx1Kzd2md
   Vw5sf9PzM2NHP8FVRcBZ0wWH5d7Bst3tifvmZ/WkG/OWyCE4vg+JkmDd/
   xUKWOKJsav4pDXtdnhxYhiV8t3NnOLWKVZCrGy9Xh6mTGLZa8T5xVYdcI
   /Xh8n3r1JyGzFiMSDQVTjXfJd2K7voIs/j0oVnUPi4Pf3KY4muhGqsJKM
   g==;
X-CSE-ConnectionGUID: ud6wTsjhTvC0b8iVvKWF6A==
X-CSE-MsgGUID: wJxHykNbQXOWY47cNMBf2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88770257"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="88770257"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:30:05 -0700
X-CSE-ConnectionGUID: IBazfshSTimLpLL98SinGA==
X-CSE-MsgGUID: CSCjpH1jQfKzJQHPM1deGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="230090240"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:30:01 -0700
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
Subject: [PATCH v2 4/4] x86/virt/tdx: Move mk_keyed_paddr() to tdx.c due to no external users
Date: Thu, 30 Apr 2026 09:50:14 +0800
Message-ID: <20260430015014.24261-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260430014852.24183-1-yan.y.zhao@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mk_keyed_paddr() from tdx.h to tdx.c to avoid unnecessary header
inclusion and improve encapsulation since there are no users outside of
tdx.c.

No functional change intended.
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/include/asm/tdx.h  | 6 ------
 arch/x86/virt/vmx/tdx/tdx.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9c63deaa0e8f..503f9a3f46d6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -177,12 +177,6 @@ struct tdx_vp {
 	struct page **tdcx_pages;
 };
 
-static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
-{
-	/* KeyID bits are just above the physical address bits. */
-	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
-}
-
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
 u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source,
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index deb67e68f85f..967482ae3c80 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1911,6 +1911,12 @@ u64 tdh_phymem_cache_wb(bool resume)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_cache_wb);
 
+static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
+{
+	/* KeyID bits are just above the physical address bits. */
+	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
+}
+
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
 {
 	struct tdx_module_args args = {};
-- 
2.43.2

