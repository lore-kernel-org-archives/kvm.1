Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F54DAF94;
	Mon,  5 Oct 2026 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222364; cv=none; b=r7YOUETirHDmEg0715mKACO3AwZoL0C5GGYnlM6fvgA8v2HP0bBhiTP1SQ+4AR/S1QfSbI7VVXRXvYQqfh5wp601C7b/rti+YUc85AGWR+mUqzTP6Eni7M1Qw1bUH/OKw48ZgQA6U4FIbeiftmiOUAukohIM+IT/pEynMT7+g/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222364; c=relaxed/simple;
	bh=N7QAbKDybImHiEjyZkCeUZrZEE9jCOMgDrLfXrdz/lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKMqt8dvcVdpkWl/BFtgTKgYgPVMopd4l2X7SZSqvKBMoiSZTT1boATtyl6nlY70niTqnmK4+G2NDbhQ7KAer3MJRZLT1mqSpyWTecsdbUWZScPvu8QsNL1Yp068kAAqgjG0wM3C0/rHUihjtGMYOunmPLKYcOIiHRVfAWYXXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bi5FFrfE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bi5FFrfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222362; x=1822758362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=N7QAbKDybImHiEjyZkCeUZrZEE9jCOMgDrLfXrdz/lY=;
  b=Bi5FFrfE7ACzk5e4F+dVeKmpTnU2oHwi5BPljBJm7LilcuRud1PpwOTI
   iw33dNaM35P9LI1O9htraO4kcmOSqnZVEczF2yPCF+nGYlrtzjjJfUUuF
   adQxTH5v7KuTrCCrL3hQVuy4hNlTUi2H4eM6VGbqAXRxYyEYSbtGWqZOO
   QLdQAfAajhTkDDjZiRv+ds5or8d+SsXD19xLydC9qDvQluY5rDzGaeSAz
   lcWfdBSXOt9sew3lLH4cItgZrlzkO5mayTa7ve01/0infGD0LpdmwFqrX
   CoSrg2+ybaLgXiOQS4T0ONOppNgA/Uk/twVakZMHdC6Gq5ANBS2+X8/rM
   g==;
X-CSE-ConnectionGUID: fxLj7FKjQ7qJo4MnufW0Lg==
X-CSE-MsgGUID: SN47XRouSLef9jxdf3rkFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102419820"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102419820"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:46:02 -0700
X-CSE-ConnectionGUID: XPLyqMXgS/iaWulmYRpeLg==
X-CSE-MsgGUID: KIJnz9x5QsSfwJndVkO5YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276002434"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 10:45:58 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 06 Oct 2026 01:41:48 +0800
Subject: [PATCH v3 4/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-tdx-module-ext-v3-4-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=N7QAbKDybImHiEjyZkCeUZrZEE9jCOMgDrLfXrdz/lY=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWQdfjhbdVq8Cec718Uer2S8HWQL2hy9/kpeFrrnfGLze
 kk7jRrujk4WBjEOBkMxRZYFHrOcprTPYtr6aec1mDmsTCBDhGUqM3NK8/QqSh0y80pSc/SS83MZ
 uDgFYKr+xjIyHHYrjWQ9VGm/SHFNXvZdC+uCQnmtWN0jhgUCZixqKi0fGf6K5r1d3+bX8fH+znZ
 3Y03JOylZ6VoHTSKu6DHOZ7Hs12MDAA==
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

TDX module extensions need memory for their execution environment
to serve SEAMCALL leafs. Several add-on features depend on the
extensions to execute their SEAMCALL leafs.

After providing all required memory to the TDX module, initialize TDX
module extensions via TDH.EXT.INIT, then those add-on features can use
their SEAMCALL leafs normally.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
v1:
 - Fix return value for SEAMCALL wrappers (Chao)
 - Print SEAMCALL error code for SEAMCALL wrappers (Xiaoyao)
 - Changelog & code comments
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 2adc5d31d258..cac0a5abbff1 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -50,6 +50,7 @@
 #define TDH_SYS_UPDATE			53
 #define TDH_PHYMEM_PAMT_ADD		58
 #define TDH_PHYMEM_PAMT_REMOVE		59
+#define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c44535933551..d8df3b2b1d17 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1348,12 +1348,35 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
+static __init int tdx_ext_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 ret;
+
+	do {
+		ret = seamcall(TDH_EXT_INIT, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE);
+
+	if (ret != TDX_SUCCESS) {
+		pr_err("TDH.EXT.INIT failed: 0x%016llx\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static __init int init_tdx_module_extensions(void)
 {
+	int ret;
+
 	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
 		return 0;
 
-	return tdx_ext_mem_setup();
+	ret = tdx_ext_mem_setup();
+	if (ret)
+		return ret;
+
+	return tdx_ext_init();
 }
 
 static __init int init_tdx_module(void)

-- 
2.25.1

