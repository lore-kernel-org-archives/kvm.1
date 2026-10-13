Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F95581EA;
	Tue, 13 Oct 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905633; cv=none; b=AHzqP0AAB40a57xdBeG6UFR/mX3x+h3XsZmh/49DhlLiQnhaN4dIboDgfr7Hmaw93WaLoBPLr3RigAIxM/zwaFPiIRm3iROfrIlGP/7GeS5xmGodd3iCziKah5v5hDYaLUXjDR5WyHTiiNREQNaFIUvg4PKcLxDglW9N1BcMM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905633; c=relaxed/simple;
	bh=eNQIR+fK2colru5urKLXyYaEalPzJW0tckMjm0yjbLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FLzg3QSYAN5kXBiqHVz09jq40bASVzzKAKoGymAfPlqrS1Uw6yD6zzri5KET+Jekisi7memNgGU34+YeolBRRklBe5QNePX3iWOriI6Td3Z2saD1oL8RZF/JMsIzXML5K1qh++21N5BUYT5Y4URDsW/M7lXX9R7P/xBo/0T0mhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmStFkha; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmStFkha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791905632; x=1823441632;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eNQIR+fK2colru5urKLXyYaEalPzJW0tckMjm0yjbLI=;
  b=CmStFkhaetOJsvfwGw3cpvziUBl5poiKf7Wf5yAeP1dCOZG3MMOI1cWe
   vxSoFOs2pFUxzP/51D7hom41m9XOhpJtJHFzqbGl+wr0EOaQUY1gKSfcQ
   bjHI9M28mdma3X6LH59Nvkm6eBIT17CGlr3z0s4uqDZ6WM3G9kCK3WY79
   01eDUTuQ24Fxu/IBoTf48hQO/5vjKaD2rhk3ZEsAhcyjcd6pL33X88j2c
   Z5MmlXV6qWE60dbkIIEwKWIaGGkylHDDocFogpBAGN4qIzdxumtl4wmqY
   L/x+iNEvomneX+uDS3l2F7RSJFH683SKQruRaqRHlrvR0WOHcCGpJXibh
   A==;
X-CSE-ConnectionGUID: k+CjOfwQTlmdZG54AeHTiA==
X-CSE-MsgGUID: BhL7Sj+oS2qb3HAmuS77Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="643430"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="643430"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:33:52 -0700
X-CSE-ConnectionGUID: TXkBcEpBRNyID9s0KI4vYg==
X-CSE-MsgGUID: O01yxRbhQhaiUdhckZy1KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1388246"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 13 Oct 2026 08:33:48 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 13 Oct 2026 23:28:55 +0800
Subject: [PATCH v4 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-tdx-module-ext-v4-5-de5ffac65470@linux.intel.com>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
In-Reply-To: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2686;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=eNQIR+fK2colru5urKLXyYaEalPzJW0tckMjm0yjbLI=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWSd84tQsXPd+9FymtrzmWd8z3Eabp+Y4h2z89+C9WfOm
 zcrx7vP6ehkYRDjYDAUU2RZ4DHLaUr7LKatn3Zeg5nDygQyRFimMjOnNE+votQhM68kNUcvOT+X
 gYtTAKaq5hzDP4sLE3/XHH1+NbH8Hc8NwRSd78pZc8pfrRa98W5VrPcDMR6Gf7Yf+2o9P/4/2Xw
 icTpjVLfUyo6/fjpHAl6lFAkbT7dqZwEA
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

TDX module extensions use kernel-gifted memory for their execution
environment to serve SEAMCALL leafs. Several add-on features depend on
the extensions to execute their SEAMCALL leafs.

After providing all required memory to the TDX module, initialize TDX
module extensions via TDH.EXT.INIT. This process takes on the order of
100's of milliseconds, during which the TDX module loads its internal
extension image into this memory and builds the execution environment.
Once initialized, those add-on features can use their SEAMCALL leafs
normally.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - Specify what TDH.EXT.INIT is doing in the changelog (Rick)
 - Collect Reviewed-by tags

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
index 4908add631fa..f1cc0422d129 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1353,12 +1353,35 @@ static __init int tdx_ext_mem_setup(void)
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

