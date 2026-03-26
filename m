Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A03C3C13;
	Thu, 26 Mar 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514748; cv=none; b=Ice4NHCelSVYxsZ65BGjBVABDZ6asUm5gv9igoeITuLF8W2jZaHe0GoDVZocJjvXA/V2P1SXK1DHYpYIsSKST4x8IaavtAwt2abk/LLUjpb1amxNXVd6PsazPjihjgWCWy6fyMlIZkiDoPfJVNInbLdOF5bskFRNgJcxOG8XSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514748; c=relaxed/simple;
	bh=wSuclVzaG8U5tqTyknKFE+UTAejiTusjLF02BzyUPjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ms/5mK0jDjtEV7Kg0zxgo36VrS5jV5hqlp1FfNXs1NVc/r4eItRfuI/3hCNPyC9tXW8H1nheojL2S9Q9wSFtr42iaUbzrICAz4+u3FVMhTSaKDdixN+Y05wEa8O2gmE3IOQMtt9uNoEIFywuR6FYDywfeetGj7sdNSUS2xr6eoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2IGxJL3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2IGxJL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514746; x=1806050746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wSuclVzaG8U5tqTyknKFE+UTAejiTusjLF02BzyUPjo=;
  b=G2IGxJL3iROPQZ1UzFS/v62eQH5m2revnFYEIAKAnnakrgH/D5XUaJr9
   xkyQMW0gQLEkDUdIoz6OJPPdqwsQCh6QlPa4P3w4W/FZPZOf4QY+fiQa9
   yIC4n/F1wmGW+Oj7lg94Z3bfcDURAKIOYNitxS6impHN+KEegEdwVuke1
   ZHT/ZKOXjM+r+IB1S8QvfSL6Jpp94VlL3I12jWxLEEVuIESHnlknEI7e3
   NMVWuYzsPfYiuMjrdVaUai3QohyZnheg5FhUYFoxV/P/5FY/zcDdKuvGA
   AGvNqsSESFFclslQC3fsYKIwoWlcipdHhdrXGQFkF+2krHCripRtl208p
   w==;
X-CSE-ConnectionGUID: qeMRb7/bQ9SIZgwBMo703A==
X-CSE-MsgGUID: d8avhNrqTt6W7Hc0a7P6Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644763"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644763"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:27 -0700
X-CSE-ConnectionGUID: 9K2cGc/YQxe1gTfs5oOiJw==
X-CSE-MsgGUID: LQU11keUT9mPXcKN6otwjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967250"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:26 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
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
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 19/22] x86/virt/tdx: Enable TDX module runtime updates
Date: Thu, 26 Mar 2026 01:44:10 -0700
Message-ID: <20260326084448.29947-20-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
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
---
 arch/x86/include/asm/tdx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8bf99e76d32f..6351d2c21513 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 #define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
 
 /* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
@@ -112,8 +113,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void);
 
 static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
 {
-	/* To be enabled when kernel is ready. */
-	return false;
+	return sysinfo->features.tdx_features0 & TDX_FEATURES0_TD_PRESERVING;
 }
 
 int tdx_guest_keyid_alloc(void);
-- 
2.47.3

