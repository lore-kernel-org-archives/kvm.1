Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF993B42F9;
	Thu, 18 Jun 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771946; cv=none; b=XkRWXt7HOEVWt8xDcBij9tNLWNH0W4z4Nzd77mnOhs2/sXbKof1pTcvKB8ZtJaXEdsHth23WeDcu5sr2wXJyAC8gUQWk/UZX4QoO8Gdwg42hmnn0/BZWD57jxXUbwX+jZgOBR93AYGx72YU1+IYPX39Lzdy4PpRVmJFzLXJLYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771946; c=relaxed/simple;
	bh=ib/IL7cI4zzZaJ9bWl43DVpPb2t9FBbja12kFRQ8oi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s/bBCrk0T8HUAHIlWiqK/Hc2jKBu0iLMEYfXg7K4LzXtjf5Uian9y7dwKTJJDjb6zD3yYgMl90KFVVE8KiQB97PeH4R/Xlwk34QPeppHnwCltwhmqcuYM2vMzAOb9bUM3KObUijZcyOV592ggiVam9m/3UZwLTg2U978i9YyDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDnPm0us; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDnPm0us"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771945; x=1813307945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ib/IL7cI4zzZaJ9bWl43DVpPb2t9FBbja12kFRQ8oi4=;
  b=HDnPm0usMaRiITZRTb9CKyOjkt0ElJl4x5uIaEQz+550aaw7hBYZsZ0/
   et58KfH7Gd0L3oxpClU86IZe6G8camx5e6qJz9clCMM6hHoTq4hensxiz
   V4lNu5nD3JDbsU6Msgs7un59DZO9hkxtkk5DIdoRMejc4LFWxxCge4IG4
   yqxLm+ZjDZ9r9PO/aufY5se/gvSEDWJ0wnnxA5efuf6S+rZiHpaaCbUQW
   2K/5aR4Sx1BLMUHzt65dtbW+OsnUekyLL4Iux2EfY3s3DqHCyXdhUL3J4
   p9VXYIq41KLUrIC+BghaprzWlWHfire8BYg779VYE1fV/k3iNAbwG8/lu
   w==;
X-CSE-ConnectionGUID: Tv9OmnM2Qfav3/pktJ1gVg==
X-CSE-MsgGUID: ici90snzTKWsahhSyr5UKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584609"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584609"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:05 -0700
X-CSE-ConnectionGUID: mqTvnTB8TY2NrK0KChSnig==
X-CSE-MsgGUID: 5w9f4cx6TdeWzU+0J1ebWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392132"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:00 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 01/17] x86/virt/tdx: Embed version info in SEAMCALL leaf function definitions
Date: Thu, 18 Jun 2026 16:13:39 +0800
Message-Id: <20260618081355.3253581-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
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
ideally the kernel doesn't need to keep version history and only uses
the latest version SEAMCALLs.

And in confidential computing world, system security requires us to stop
using an older TDX module when there is a newer one. So don't burden the
kernel with long-term supporting an older TDX module that doesn't
understand newer version SEAMCALLs.

The only concern is there may be transitional periods when a new TDX
module is not widely available, meaning the kernel may temporarily need
to support multiple SEAMCALL versions. As time goes by, the old TDX
modules deprecate and old version SEAMCALL definitions should disappear.

The old TDX modules that only support TDH.VP.INIT v0 are all deprecated,
so only provide the latest (v1) definition.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h | 23 ++++++++++++++---------
 arch/x86/virt/vmx/tdx/tdx.c |  3 +--
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index bdfd0e1e337a..fbb520704662 100644
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
@@ -50,14 +63,6 @@
 #define TDH_SYS_UPDATE			53
 #define TDH_SYS_DISABLE			69
 
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
index b15269b5941d..2a03152796e6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1903,8 +1903,7 @@ u64 tdh_vp_init(struct tdx_vp *vp, u64 initial_rcx, u32 x2apicid)
 		.r8 = x2apicid,
 	};
 
-	/* apicid requires version == 1. */
-	return seamcall(TDH_VP_INIT | (1ULL << TDX_VERSION_SHIFT), &args);
+	return seamcall(TDH_VP_INIT, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_init);
 
-- 
2.25.1

