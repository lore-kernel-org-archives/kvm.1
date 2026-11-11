Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369441;
	b=h3/GjxshZ9qyrIty83Yr+OiCWFsdO4FShrDYUI0akgvfDNh/AOdllky+ehQdJMB5+cAa
	 7nlOH9X0vwL1hDtYEammB+FJyVCjXOPfj8T2tXjw1MF6KmX7IVSA9gazJkCywS7OlVsdi
	 /yAgF2ifEL7IQossvFrIaXAY98VXFrkhmJxYEO+Jq5H7TdIw6b/755ymVJJpFpw/KWgZ/
	 5aCQA4aStczvjnuPFlg4C8Lo81w3vCzqYQ5neqmcDyF6V1yOO3shGSVPyMpkfH/zoEOOr
	 XxXFJpjZqLmTPnenO4Gr5JHdpW7KLKF6PALlEBSKugv0ryNrTH4AeyC0HWAT2JRHF1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369441;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qHGcB/wg70pf/o9mS2nFcjCG5IjmNdDesirjpJdsl/8=;
	b=o5fxzgPca9A/YX4ju7WeoaTFDBL+jttU3UMycdYVc8+XWHC2EIrR+h5vQpbwh4SEQCsv
	 URQOgKrpdeJp97uDkihkrxzJ4qoagl8dL/v+dqLky0O0hHw4eNZYzSJgGi7LhzoIr0cd0
	 htvVJ5PUHxqGy9kRk0K/3uvPOeJ/aKz7EmjSrVsI6O88tAlO4rebU7JlhOJwbMIumU16s
	 WSgMTQvaA6mE+GBWXJpqDDrwQSXGk6cQEMIByZAGxx3jKjNCqqjFE39siJ07UPtMbY/DF
	 Hr5ZqJpQWQH5ukymgGymsYu+Hb9h5zdgsKNdUA9zpTht5eMbpaNt7CbzpAvdUWfkzlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H7lOFn7V;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F6606A338;
	Wed, 11 Nov 2026 03:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B95F6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H7lOFn7V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369441; x=1825905441;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=M9BSDMPmaStgMOH5fMNgacueotl2cNCf7GRgf8Ke8mU=;
  b=H7lOFn7Vrb1diMqOFQkdX18QeHTFOT5jawCjpbWCH8xvH/SBYL74vOqH
   ZFy8bWokZjvmJYw7VPt2Xt3g6vLQu5fS7Q+u6csBNv9rERdBOukp2MOF+
   lp/gs5UrQ0J1DXLaW1qgcaczaVERsnEOVih7xP1bDFqqWow8pYARGzsk0
   cPXs//N3IkRpq3YwPp+JBB7s4Q9UZ2upuYAvVny+TsTdnk0UY/fgIvTnw
   RJUJ2Y4KOW9C9OFv6IMWKtangOf5y5Iyoqv7unwVieKolLO23lQv5msBn
   nn2684iyQH8vpnfeP0xvVP7/HX2nl68UHSc0qWUX+brnoAiigum0/q9gi
   g==;
X-CSE-ConnectionGUID: DKevb6zYQkmKcCgPuLofTA==
X-CSE-MsgGUID: 9lsmSYdBQz66BPuApZLNhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220300"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220300"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:57:21 -0800
X-CSE-ConnectionGUID: qh8eH8S6QSmqPCdHgDW9WA==
X-CSE-MsgGUID: F2W5DaSeRoyt6cNgsYqI0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199260"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:57:17 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Wed, 11 Nov 2026 11:48:46 +0800
Subject: [PATCH v5 5/6] x86/virt/tdx: Make TDX module initialize the
 extensions
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-tdx-module-ext-v5-5-c74f764abc3d@linux.intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=M9BSDMPmaStgMOH5fMNgacueotl2cNCf7GRgf8Ke8mU=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frpi2VRnhRwuSb/wqB2sPRFsT7nLnvyyNZkaZtzcc
 fmqQuPDjk4WBjEOBkMxRZYFHrOcprTPYtr6aec1mDmsTCBDhGUqM3NK8/QqSh0y80pSc/SS83MZ
 uDgFYKqYNjD897a0Eqjafrhrm7BGZwB/Y8Rnb4cMy32eocpB4ibqu972MPxP/DP7mtGt3Rpn9tx
 z36A4ef2ZpcqT+/YVOSb3sno2bfrOBwA=
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

Continue fleshing out the extension initialization process. At this
point the kernel has provided all memory and the TDX module is ready to
initialize the extensions on the memory.

Initialize TDX module extensions via TDH.EXT.INIT. This process takes on
the order of 100's of milliseconds, during which the TDX module loads
its internal extension image into this memory and builds the execution
environment. Once initialized, those add-on features can use their
SEAMCALL leafs normally.

Note that TDH.EXT.INIT builds all configured extensions. The SEAMCALL
leaf fails if any extension fails to initialize. The kernel does simple
error handling - just fails the whole TDX initialization on any error.
This is OK cause all extensions are considered necessary for security.
If a nice-to-have extension appears in the future, this can be
revisited. A potential solution is to have a new metadata field
indicating which extensions get enabled/failed, then the kernel decides
whether to continue or abort.

The original changelog was written by hand. AI was used to help correct
grammatical errors and polish individual sentences for better
readability.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v5:
 - A new paragraph to describe the error handling.
 - Refactor the existing changelog.
 - Better clarify the AI usage.

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
index 3440f1878978..3a1ba4e73cfe 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1343,12 +1343,35 @@ static __init int tdx_ext_mem_setup(void)
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

