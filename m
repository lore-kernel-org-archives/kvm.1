Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0730836F906;
	Fri, 22 May 2026 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422764; cv=none; b=mQVfNnSsDnKJjnQoDcz8ZA+3imfPGUQ9JgtLPSyazwNe7IEcZG8toNp6jaUKNsJhi4pMxKdiAPTTZYPFEzPatQw53Hedd7BIU8knPd2efxP8cX0HcHWwJ02S6Ir1hDrPonqtIJ4gzs61adq/C64NGoB2d1V3U7Md3VE5saLcAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422764; c=relaxed/simple;
	bh=aDZKpalIG8poSUU5P/VEw+KG1TVNT7uoOGEiPHoS6Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iGN/f3Q9XBycYUaQR1mHoalk2X9W7LUhX3QzSAarJ+tyQ07Zrv0rIZ7/cy6qBjRhHj5aWlYI9xprFSrOKBCn29x1bfADjYsIR45qejHJ6lA5p86o3DyffGjUVTStY8eg2y37metP+rs4R1AAqNzgb0soaqYOkdhGRVl2bSvRsvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CgaZq1lv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CgaZq1lv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422764; x=1810958764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDZKpalIG8poSUU5P/VEw+KG1TVNT7uoOGEiPHoS6Gs=;
  b=CgaZq1lvDfxAKlRdwnuaEMnYq+msF+bfFTc2DnmI8kgTs87ggYUCysd+
   dXXifO5cFSaLPdeXLtE+aQ/PMMmiGf8f9xLMzLM6pW+CkLCY/kCACyG5R
   aTWuCzQQ2REt1RCi/wWXdFh4MnKdVigxTiUFCn2dRsMzVYKbM1FLA878k
   X6ieo83HhYe3Mwye7/i+L8p9Xrnh0wl0+yFpV1gqx1CzWoQCad7SyTE5I
   FMJBOJOg+svwH/LlcpGDmyWffZul4GJQAiNTv+0z4JQUd6leWWPUBtx2J
   WQ+srsUwizR+GnBLTH2UR4H1OaVpi9as6ayZGpns6/8WPh+xilIPDrzvn
   w==;
X-CSE-ConnectionGUID: SaK3grsOSjKXpNwY0r+5DA==
X-CSE-MsgGUID: 1/Sz5Sc8SPCVdZ3b51Ji2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528931"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528931"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:06:03 -0700
X-CSE-ConnectionGUID: Up3E0bjvTX2f1ygYn0sX3w==
X-CSE-MsgGUID: 77W7QGREREC2Lx+oMDptPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757953"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:59 -0700
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
Subject: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions
Date: Fri, 22 May 2026 11:41:27 +0800
Message-Id: <20260522034128.3144354-15-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embed version information in SEAMCALL leaf function definitions rather
than let the caller open code them. For now, only TDH.VP.INIT is
involved.

Don't bother the caller to choose the SEAMCALL version if unnecessary.
New version SEAMCALLs are guaranteed to be backward compatible, so
ideally kernel doesn't need to keep version history and only uses the
latest version SEAMCALLs.

The concern is some old TDX Modules don't recognize new version
SEAMCALLs. Multiple SEAMCALL versions co-exist when kernel should
support these old Modules. As time goes by, the old Modules deprecate
and old version SEAMCALL definitions should disappear.

The old TDX Modules that only support TDH.VP.INIT v0 are all deprecated,
so only provide the latest (v1) definition.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h | 23 ++++++++++++++---------
 arch/x86/virt/vmx/tdx/tdx.c |  4 ++--
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 01a7d7d8ada9..10aff23cd01f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,6 +2,7 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 
 /*
@@ -11,6 +12,18 @@
  * architectural definitions come first.
  */
 
+/*
+ * SEAMCALL leaf:
+ *
+ * Bit 15:0	Leaf number
+ * Bit 23:16	Version number
+ */
+#define SEAMCALL_LEAF			GENMASK(15, 0)
+#define SEAMCALL_VER			GENMASK(23, 16)
+
+#define SEAMCALL_LEAF_VER(l, v)		(FIELD_PREP(SEAMCALL_LEAF, l) | \
+					 FIELD_PREP(SEAMCALL_VER, v))
+
 /*
  * TDX module SEAMCALL leaf functions
  */
@@ -31,7 +44,7 @@
 #define TDH_VP_CREATE			10
 #define TDH_MNG_KEY_FREEID		20
 #define TDH_MNG_INIT			21
-#define TDH_VP_INIT			22
+#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
 #define TDH_PHYMEM_PAGE_RDMD		24
 #define TDH_VP_RD			26
 #define TDH_PHYMEM_PAGE_RECLAIM		28
@@ -52,14 +65,6 @@
 #define TDH_QUOTE_GET			98
 #define TDH_QUOTE_INIT			100
 
-/*
- * SEAMCALL leaf:
- *
- * Bit 15:0	Leaf number
- * Bit 23:16	Version number
- */
-#define TDX_VERSION_SHIFT		16
-
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 821f677e9a86..f7600f930c6e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2217,8 +2217,8 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
 		.r8 = x2apicid,
 	};
 
-	/* apicid requires version == 1. */
-	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
+	/* apicid requires version == 1. See TDH_VP_INIT definition.*/
+	return seamcall(TDH_VP_INIT, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_init);
 
-- 
2.25.1

