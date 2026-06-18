Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40033DD51D;
	Thu, 18 Jun 2026 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771999; cv=none; b=dNaEvHJ9Ck+v8rMNjnjYniV4uvq8QSsiuOVspA2g4JCRv/diEkeCt/4T0+SauAUqEpM95KdcGDEBXMGUUWWy9HZUBLs8rNYG7fvvXIUU40MKbtyGJ2ehpPrsOvnsEitgaoDcNvBkzvK7+Rx3WpNO2eKT+6qat4P5F8+lBT45mNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771999; c=relaxed/simple;
	bh=jBH7uTNhDTqMBXJ5mrNbFZ3iv91a+qULr5SXxL4aBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fWNqSkq0t+jYL0amN75vi1hZ8pE+VtDb/whH14cqWYyuR4nouQUsU5gpBEQ4X+i4C/d8egP9RJ2Gc37aSb3f8oalEFSCWz+hhl3YVQICaZ1YGr9fX+HTyuX4jO4t/Z+HboUZERtx4MYClGPYre7SOzAlT3HvO+vIeZDYFWrq1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcLub21T; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcLub21T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771998; x=1813307998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jBH7uTNhDTqMBXJ5mrNbFZ3iv91a+qULr5SXxL4aBQY=;
  b=hcLub21TVNrkphDLTxUMoDU+2WtOdGC/MEIq41x4eoqQs37J5axGl/2/
   VqUChTyCjKouf0s9cUyLoJwotnNbHnaxmYGJgzqoXF2Ffs5RlqcbVRmOV
   +WH9NOAJlszL63CFSF2/uWwGvyt5B5XjhpYKn4KMDOdnKtrwb1rcfhTTe
   tW8BSSatADXenfNcpkScVKzKJgHDH3jp+yXT2KXMjIssTR7jqSqlUcYeR
   ZaqC3TjJziNW2ZPNvwipNk4tq/vdREgfvyAseUh3HVfKAOSDxOVSsKAt7
   GgjcZBdFkDPQH6kmYylFiehijgLjw7wBT1sRUhbh/2m+cAua8HNRU16Yx
   Q==;
X-CSE-ConnectionGUID: FDbVyRHiSpeFGeCOhcsgNg==
X-CSE-MsgGUID: 6iX7pem/QBiC9bghlVkaAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584809"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584809"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:57 -0700
X-CSE-ConnectionGUID: dQsTnG6LTi+w5hX4e6b4Og==
X-CSE-MsgGUID: XX8j4MYsSUiogH40yLhX7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392411"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:53 -0700
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
Subject: [PATCH v2 12/17] x86/virt/tdx: Reinitialize the Quoting extension after TDX module update
Date: Thu, 18 Jun 2026 16:13:50 +0800
Message-Id: <20260618081355.3253581-13-yilun.xu@linux.intel.com>
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

From: Peter Fang <peter.fang@intel.com>

Invoke TDH.QUOTE.INIT again after a runtime module update to trigger the
necessary rekey procedure in the TDX module.

Keep the existing Quote buffer since memory allocation is not permitted
during the update. Compatible TDX module updates must not increase the
Quote buffer size, or an undersized buffer might cause Quote generation
to fail. See [1] for module update details.

[1] Documentation/arch/x86/tdx.rst, Section "TDX module Runtime Update"

Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ac0da4966697..81e7b6b1dacb 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1353,8 +1353,11 @@ static __init int tdx_quote_create_buf(unsigned int npages,
 	return -ENOMEM;
 }
 
-/* Initialize quoting extension */
-static __init int tdx_quote_init(void)
+/*
+ * Initialize quoting extension.
+ * It also rekeys the TDX module after a runtime module update.
+ */
+static int tdx_quote_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 r;
@@ -1539,6 +1542,22 @@ static __init int init_tdx_module_extensions(void)
 	return 0;
 }
 
+static void update_tdx_quoting_extension(void)
+{
+	int ret;
+
+	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
+		/*
+		 * The TDH.QUOTE.INIT call renews the quoting keys.
+		 *
+		 * A module update must not increase the quote buffer size, or
+		 * quote generation may fail and break attestation.
+		 */
+		ret = tdx_quote_init();
+		WARN_ON(ret);
+	}
+}
+
 /*
  * Mostly the same flow as init_tdx_module_extensions(), but rejects adding
  * more memory.
@@ -1561,7 +1580,13 @@ static int update_tdx_module_extensions(void)
 	if (sysinfo_ext.memory_pool_required_pages)
 		return -EFAULT;
 
-	return tdx_ext_init();
+	ret = tdx_ext_init();
+	if (ret)
+		return ret;
+
+	update_tdx_quoting_extension();
+
+	return 0;
 }
 
 static __init int init_tdx_module(void)
-- 
2.25.1

