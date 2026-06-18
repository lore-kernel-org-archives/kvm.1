Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368438F92D;
	Thu, 18 Jun 2026 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771965; cv=none; b=Bg++hX+/yHq2bMmyLKigwpk5iOCju63F4v0sNzp9fkFzv3WtcofuHurJW/M4i7JtssOhnW8Pneyvb1tTDd2yQQ3dnIVYoGfa7ldb9BUbjbi8/YzgGAS6ddRauKP+7M/KACejbniaF9C1ayEyZ1xS1giUFii0APo/dxu5RqwImFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771965; c=relaxed/simple;
	bh=N9Sc30FlbIg2szyKtjbpI7X82n0klj/oS+UdslbDv8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pF0ZlvHUwl9CaEe1BBlbPkil/d2a8XD4qCHsfdg6eMpPsZlQHlKaRDG34dsaCutT5FCIGrbS0STGwJ1MCjStxjN7+jMo2+y9mSFOXmWsX6FzW9Jh/c9ITxCHwZiyqnZaYhC70raQVutzR0/NxSf+LRQ/QTQqayq70HcSXsCUj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDRacbQs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDRacbQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771964; x=1813307964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9Sc30FlbIg2szyKtjbpI7X82n0klj/oS+UdslbDv8Y=;
  b=nDRacbQsOiQUKEdwwGva33cnHEZqH7vNcFz/qCwTyvAGvDqJJ+hCLMzf
   mpotJBCgL8+4MJ8/wAm2MpBViVseJ3c0nDP5mhtCgt14+VM0fjp6jELnW
   TPF91+35DCWSmhCD1wkNDAADOjL7YVoPS4FEzclXdnxFNFEDT/JVyxVta
   /uQdR/rmwnbMK5Zg12Xw9CyF+anLiPeRif1Iw/5AeGlWkAfzs4mn1dEXX
   ZfwJEpT0kiscOWMcDU/zIEtzJdleI9UQqTkbV9iQaAH4uQHpkZ9o1yrK4
   aHgHiUk1OcJKSbtWT6AiomqgiLRHOo3FeA0LURJYxNYZdQEB/hg4W96tO
   A==;
X-CSE-ConnectionGUID: XMVYRUj+TUmfgQbl9LIhSw==
X-CSE-MsgGUID: JtKlFs4TR8mdo0v0VX0I5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584650"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584650"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:24 -0700
X-CSE-ConnectionGUID: gEVEZgpQSwGUzU8UPkM/fw==
X-CSE-MsgGUID: 57db2UfoQvGg+9EeHFqGog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392236"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:19 -0700
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
Subject: [PATCH v2 05/17] x86/virt/tdx: Make TDX module initialize the extensions
Date: Thu, 18 Jun 2026 16:13:43 +0800
Message-Id: <20260618081355.3253581-6-yilun.xu@linux.intel.com>
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

After providing all required memory to TDX module, initialize TDX
module extensions via TDH.EXT.INIT, so extension SEAMCALLs can be used.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index a100634087e7..2deb0a5c902e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -63,6 +63,7 @@
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE_V0		53
 #define TDH_SYS_UPDATE			SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
+#define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index dab17822c1c6..900928de373a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1167,6 +1167,22 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+/* Initialize TDX module extensions for extension SEAMCALLs */
+static __init int tdx_ext_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 r;
+
+	do {
+		r = seamcall(TDH_EXT_INIT, &args);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
 #define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
 #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
 #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
@@ -1285,7 +1301,11 @@ static __init int init_tdx_module_extensions(void)
 	if (!sysinfo_ext.ext_required)
 		return 0;
 
-	return tdx_ext_mem_setup(sysinfo_ext.memory_pool_required_pages);
+	ret = tdx_ext_mem_setup(sysinfo_ext.memory_pool_required_pages);
+	if (ret)
+		return ret;
+
+	return tdx_ext_init();
 }
 
 static __init int init_tdx_module(void)
-- 
2.25.1

