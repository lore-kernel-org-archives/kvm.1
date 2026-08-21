Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E73437BE81;
	Fri, 21 Aug 2026 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282989; cv=none; b=uywOz+Qf8eMH6giM4a2kim+VAp3w4bmuWE4nbDdHAwsEBoZRw2cLTODKK7AQTP+pBLKQYrX+9hE3mcI+7qshNYztooh/Kq9ShxhvBfZTO4SobUuxQNyEeNo5Ld7odn1dBuOLtbRrxYVmvoDP5mIHfEfRyEBowBt+kEefVgkXUH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282989; c=relaxed/simple;
	bh=fzUOMAIqwO0DVyi3x/N/fYS/A72QSG8Go1HWcQQ+AeQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pd8OjdT/ooQtxPOlstf4yRQMbMYH8PFbVr7l9mEyVnnA6WApp6vujapsV8lOkeXdnpYWCu+UJBrLEYhwVhSdymANQe38vzUnu2j8lsxRgv0r2ttVXTmBqZTbx9/g1/WWY+BjkkBs1NZiVmyOKY1bq43t2VXNHGJG2I0w3mh16/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlz8q1qm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlz8q1qm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282988; x=1818818988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fzUOMAIqwO0DVyi3x/N/fYS/A72QSG8Go1HWcQQ+AeQ=;
  b=hlz8q1qmVkILA7/Xqrn9rmvljSxfK5yzfEjBGAh+jEKMU9wxq6Qrl+IH
   tJMjp50MZaU8G67KW3pDBWTqxvmEGMzjHlw2JeidqIh71wFniN+SHmW4X
   Nmntlyva6wpADwW794F6aO9oRAu6P7l/OGrkue0a5BnWhPk/PXgaNIIdd
   SsbpZizcX7SAyDjf4ccZ1kfG2uERANoR3BKMrA5M4jqsy4d+sYolwAR3o
   1MHkBNPM1XzUzHAyiUR3jcXS2U2yxNrfWCgWWmGZVdBWGl82zKXm1JayM
   a4ThFa2gVMX3o1ivqrBaxo5SuyFXayI0fWsQrtvs6i9GCXMKLi5Xeo7/k
   Q==;
X-CSE-ConnectionGUID: bwynWMNmSySkdQ67pdK9Ag==
X-CSE-MsgGUID: 6qrG6ip3SWesBdildYcM4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640248"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640248"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:48 -0700
X-CSE-ConnectionGUID: xvuB3YbHTviLia6tARPfSQ==
X-CSE-MsgGUID: iZHs2rGVTYWm7r4Vac2riA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451614"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:44 -0700
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
Subject: [PATCH 6/6] x86/virt/tdx: Re-initialize the extensions on runtime TDX module update
Date: Fri, 21 Aug 2026 11:29:20 +0800
Message-Id: <20260821032920.256225-7-yilun.xu@linux.intel.com>
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

Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. As part of the
restoration process, the host must re-initialize the extensions to
restore their functionality.

Linux runs the updates in stop_machine() context, which prevents memory
allocation. This introduces a hard restriction that the updated TDX
environment must not consume more memory for the extensions.

The impact of the memory allocation restriction can be mitigated by
another requirement. Runtime updates should keep the add-on features
unchanged across updates, so that existing TDX users can continue to
operate without disruption. This requirement minimizes the chance of
increased memory demand. As a result, the restriction only affects the
compatibility rule for choosing the update image.

To adhere to these requirements, the post-update initialization for the
extensions can be simplified as:

  - Check if the extensions were originally initialized during boot up.
    If not, skip the re-initialization.
  - Assume no more memory needed, skip the memory adding step.
  - Re-initialize the extensions via TDH.EXT.INIT. The SEAMCALL leaf
    will fail if the updated module requires more memory, or if it drops
    the extensions initialization entirely, which indicates the update
    image is not compatible.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
v1:
 - Don't update the extensions metadata any more, only check the
   metadata originated at boot time.
 - Remove memory_pool_required_pages check, let TDH.EXT.INIT fail if
   more memory required.
 - Changelog & code comments
---
 arch/x86/virt/vmx/tdx/tdx.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 873b8393f32f..1ca3996f32dc 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1289,7 +1289,7 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
-static __init int tdx_ext_init(void)
+static int tdx_ext_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 ret;
@@ -1332,6 +1332,19 @@ static __init int init_tdx_module_extensions(void)
 	return tdx_ext_init();
 }
 
+/*
+ * Don't update the extensions metadata, just follow the requirement originated
+ * during TDX module initialization. Let the extensions re-initialization fail
+ * if more memory is needed, or if ext_required is dropped after updates.
+ */
+static int update_tdx_module_extensions(void)
+{
+	if (!tdx_sysinfo.ext.ext_required)
+		return 0;
+
+	return tdx_ext_init();
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1532,6 +1545,10 @@ int tdx_module_run_update(void)
 	 */
 	WARN_ON_ONCE(ret);
 
+	ret = update_tdx_module_extensions();
+	if (ret)
+		return ret;
+
 	tdx_module_state.initialized = true;
 	return 0;
 }
-- 
2.25.1

