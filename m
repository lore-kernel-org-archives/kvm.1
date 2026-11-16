Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827397;
	b=4h79SUOGcYf7pjeC7XzB1g5bVR8jYR4CGQUkdQj0dvr0sAOzkyBCqkqTrDGlllc6cyEs
	 gozuScq4p9R407/1oFMjMU7Aer3ZCG2BGMCLZT++bzmwDyNTK5KLq1IWiXKPGeFNqG9pN
	 eg+b8aD2JM2agP+xuoLDOAIFnZuqpQXZYPxWonP1D7Oepv39q3dGPrNrhKBUA5vJmixso
	 i4KwuKyM7QgRLKzKUPqHUTpdvGfsdaRaBG8n/cqJD2MMiSCvQr07nR+trUhltzzzTxvU4
	 Y7UqDxBg86INa3he+Bl3L56znUqXZlFEnk796fAEnieBe8Xb3B/Wv6XC3S8VgOBWN+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827397;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uQiaosrZq/6cfVUoy8hqdiQwradIgh/yOR1oHMgTR+I=;
	b=idFEczwDn+T4BlOSs7TJweADMwH6rNnhRb8I27EJuBH1Qw0L2XtihE/FSlGNm8whyoXl
	 c0Eci/rV7uHDgNEVb4djsn/l7rokNi9C92PKIuErALWHWV8PWKdnNNBmxo3vAxgKxTMq1
	 DJciXop4Itut54drxsQjtu4v9Iy8OZAV58Y+0OkYWO9ENz05gcc0aVT3iQRsFZ+UogMZ4
	 12vK3uvQUnJ8LwgZwr+jTlVrzlAgVeKXYuZxI450Ju6hlMN7eGKD6vFFdJXtIjoj5WPu6
	 lVWc8h7p9K0h4V6rOlQCi0dJzGRk0YTmug/pmgSLEWvp4BUMNlVtI+te96tDK6BjKcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3fthGMX;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73477606FD88;
	Mon, 16 Nov 2026 11:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73477606FD88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a3fthGMX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794827398; x=1826363398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WhpSgKz06/UoA0SUzG7bcB2Js0yT2iQrvfmwQ8dZ9ws=;
  b=a3fthGMXBAqMBRKWAAu1xrCgIt3OUQUMagQQbGHdoZCMRUTtuz3DCBId
   WrKan/asDNOumU6mCqgJyzisZAtg67BIHeVSgj09qrgyf7z6t+VqJbZkK
   YZajq9F813QKmC+CQnSIWeuVecXyMNgIYoBcxkKl0B85geaRNdPo9SBNR
   jj7iokmODp6yh8nytlDkAYKbS5eOrxNV2wNn9OKdSo9DeFQKzB0JlrqWP
   hBaVw7aCVufYxb/Fw6vna12+pCnHZ34xyAM90ktKovYJh7Kis2l1YK99l
   Fx4XMxr8QCOpxhSShFbHtxUabZsYZ7zizuORykNENQ4n4MMvrhgDlTSlm
   A==;
X-CSE-ConnectionGUID: AHrnMMwiS3OeNFn1iUvklA==
X-CSE-MsgGUID: NVbwIDhiTbC+SPYDcuxUrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3429632"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3429632"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:57 -0800
X-CSE-ConnectionGUID: Mb1/qUX8TCimH2SqS0E8xw==
X-CSE-MsgGUID: wKuz7SU7S6aEXHOAGtX76g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9848138"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 03:09:57 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kevin.tian@intel.com,
	yilun.xu@intel.com,
	chao.p.peng@intel.com,
	baolu.lu@linux.intel.com,
	chao.gao@intel.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [RFC PATCH 7/7] x86/virt/tdx: Enable PCIe link encryption
Date: Mon, 16 Nov 2026 03:10:25 -0800
Message-ID: <20261116111037.3478844-8-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261116111037.3478844-1-chao.gao@intel.com>
References: <20261116111037.3478844-1-chao.gao@intel.com>
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

The basic SPDM session and IDE functionalities are all implemented,
configure the TDX Module to enable the TDISP feature and in turn enable
PCIe link encryption.

Based on work by Yilun.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/include/asm/tdx.h  | 2 +-
 arch/x86/virt/vmx/tdx/tdx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index add83e7b9c36..c051f2ae82e6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -147,7 +147,7 @@ static inline bool tdx_supports_tdisp(const struct tdx_sys_info *sysinfo)
 	if (!(sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
 		return false;
 
-	return false; /* To be enabled when kernel is ready */
+	return true;
 }
 
 int tdx_guest_keyid_alloc(void);
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index d661de8230cf..9e87484283b8 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1043,7 +1043,7 @@ struct tdmr_info_pa_array {
 };
 
 /* List all kernel-supported add-on features0 bits here */
-#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
+#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(TDX_FEATURES0_TDXCONNECT)
 
 static __init u64 get_tdx_usable_addon_features0(void)
 {
-- 
2.52.0

