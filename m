Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0665C3D75A0;
	Mon, 27 Apr 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303814; cv=none; b=jX7io/rAXHpJPq6Sq6Ug8jk9MMzRWMNfiATFoQHqCJbHPpwyGTEbVFQaBl47TGWciOyJoUfYnrjL5wRMGs8trVSDxP6x/Mgxsd7kow63zw0/TTuCNcfSeDonicG0inK4aExxS81vMC7Vw9uykF5Jh5aO208GkYN8vG5mQat2Ai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303814; c=relaxed/simple;
	bh=CYZ3pVMD1FyyrfSWlinI15zccYoCaqZnOP/ktuCQfHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVriwva05ayquUlSfd/XLueLaSpDVzPHC2IaVfzUzG8g/DJqDAsPOBopThuKWYhMBkx5v/FREQfP8Xbg4VIv8r9AoY/SaEyKJ0AfU3+W2wyDoHOIWOE26t89bznuNYwBBZAQwseiSfMO+WVgz0mhtefJZ9xIWBbGXUjf6UMkeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZiVHbd9; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZiVHbd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303812; x=1808839812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYZ3pVMD1FyyrfSWlinI15zccYoCaqZnOP/ktuCQfHU=;
  b=AZiVHbd9lNYdXT/TBKR8x5tcrwtmdXx9DHMZ8CTODB31aDvuMCCRgrsi
   L0Y7d2WliNHr09A6qU/4UnnFuE+yFE6fkLbEPQTfoDCeVRmpmebnFNqXI
   pV4/QdijzYoXssE3SLE0rpHJAF2tZt9pzfX1LvCurmpgARhG5BfILWl63
   Gjila5oLPiEn8XXAmGJyi5yS+shlS+e6N4zZBfveHE8P+U2z2636Bnm5k
   /b/ExwT0tVXBioBJgZF9sDXFKNEZwT8yabn2xCGiIcc2wBj/ziWd+Yd7L
   G2rGS5cPHOE6TcZQnT4vakFzO4KqLRBx6NmFSDdZa9Kbf4nGe2nmIHmCC
   w==;
X-CSE-ConnectionGUID: 1omkIT6QT8idPXct/o3fsA==
X-CSE-MsgGUID: NKw5gib5Qb6qnIqBM+80hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900817"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900817"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:06 -0700
X-CSE-ConnectionGUID: EApM4YtPQKyxNYeMY0mnUA==
X-CSE-MsgGUID: nWBvNDkHRoeK3uhlobYtPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673357"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:06 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v8 19/21] x86/virt/tdx: Enable TDX module runtime updates
Date: Mon, 27 Apr 2026 08:28:13 -0700
Message-ID: <20260427152854.101171-20-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427152854.101171-1-chao.gao@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All pieces of TDX module runtime updates are in place. Enable it if it
is supported.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b063aabe2554..b9eb1da4f36c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 #define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
@@ -117,8 +118,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 int tdx_guest_keyid_alloc(void);
-- 
2.47.1

