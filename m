Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CE37B016;
	Fri, 21 Aug 2026 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282985; cv=none; b=NVP2pWYo0BwqkFeC0HtTHaDOtmTJ2sFEvZ6DL+dH9UJ/sjAdTiiHPjpWNzB/XfdRxOAnREEN6V+Ee7rDkgjzfkT9CefxfRm95Dv87ewWCXD8o9ACfc9xYrX1bzPHJY5bc6o2SwzwZ+DdvLhDH2Ao6uryOqC00flZ33/g6e5/Qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282985; c=relaxed/simple;
	bh=l/irF7qWRI3dA5cb2ldWh+ucpLVHW7zJqzz459U2Jlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOdJ+y/OAEYCWvxrdHI00yiMfsMiuxZwOmQyNhYoxnJCg+SFhM74BDQy5SgWRzc8+OkGVMbNVEhA26X1RxVGgP/MYq8TSYzY7zQH6z1UnSOM+2Ky/1v4XE8gcIkEM3Irl92Ec2z6RrGeEPtbOaEccUVs4lUDrXImzpDSQMo5CQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwLOuY7U; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwLOuY7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282984; x=1818818984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l/irF7qWRI3dA5cb2ldWh+ucpLVHW7zJqzz459U2Jlg=;
  b=JwLOuY7UFjB8hEXKtX1sY3AwpmJLzrSwSqnTLlfUEWIqVb7F26xxl1qe
   /l0ajtcqGvi9uIXwzjBGM69D1yZ+TAhCyCH7w2IWr/b5w/gcUHrs1ZcJ9
   ejnUmGEsexqGvtnpF0wA5SqrK82V6Na6fXRpkqJ8S23g8yBH6zU0bhA7k
   VTBzepkiWiqN8RnC6qmmyJJHefQgf8zgvzvlNJJaIKZEfRYC3yU8/gpEh
   ZUbQbetu2u7dhc5dnqORMUH1Nv6Z2+xzSrk1QbZUI0IsJQjgKAF39fWQE
   CGgrrm7j2uzB2lG564Jyss/BdKy9qja/o3Rw4zVTYrLCnrews2Xr+NwD5
   Q==;
X-CSE-ConnectionGUID: dhXjCZytSJSWgMmxGVrJKA==
X-CSE-MsgGUID: mLKuupcgTnSxCeGEKnGAbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640243"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:44 -0700
X-CSE-ConnectionGUID: CtKNlnNdTSiTYB2EO/BDQQ==
X-CSE-MsgGUID: o30ALhBSSYGroWvagdFF5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451610"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:40 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
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
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: [PATCH 5/6] x86/virt/tdx: Make TDX module initialize the extensions
Date: Fri, 21 Aug 2026 11:29:19 +0800
Message-Id: <20260821032920.256225-6-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821032920.256225-1-yilun.xu@linux.intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX module extensions need memory for their own internal state and data
to serve SEAMCALL leaves. Several add-on features depend on the
extensions to execute their SEAMCALL leaves.

After providing all required memory to the TDX module, initialize TDX
module extensions via TDH.EXT.INIT, then those add-on features can use
their SEAMCALL leaves normally.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
v1:
 - Fix return value for SEAMCALL helpers (Chao)
 - Print SEAMCALL error code for SEAMCALL helpers (Xiaoyao)
 - Changelog & code comments
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 52888424fe7d..1f43d2eb2345 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -48,6 +48,7 @@
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE			53
+#define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 8c2fdaf0b8c0..873b8393f32f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1289,6 +1289,23 @@ static __init int tdx_ext_mem_setup(void)
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
 	int ret;
@@ -1308,7 +1325,11 @@ static __init int init_tdx_module_extensions(void)
 	if (!tdx_sysinfo.ext.ext_required)
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

