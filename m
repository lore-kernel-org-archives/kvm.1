Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E84553C3BA;
	Tue, 13 Oct 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905638; cv=none; b=hhKJ1z9ODgLAsLpPoZR5ccMZr0kmI7FNzZBR3NmzN3X0i1MtpYNjXhanmIgm3m61LgXlIBSn11zn1bzOvbIZMxdM8vUOp4DwK2MALm8VixaqCKm5J0D3BeBk+mDU56Xmhpii5+4A6b4+Ev1Mf3o9l3yDuR0MCR6blVWaOxyb7YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905638; c=relaxed/simple;
	bh=HXN1J/O4JVopgXVptVtMkJsZFZ/22R1t/CjYF61yEgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZP5YFhbOvPKWuT+8o81mM4twD87KRXgRt+T3GADJFpSPxYl6ebkE+TGkES3MBBl34qn9zPIZG0PegT4O5/IwixdqCD7IymGf0JbsZhr/HtuS09qlkMuhUMyknKWDobV9s4+Ooq6NWbqs6mi7VnSqRgZCgoomyOUwivfCnn2NMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmNKxkYh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmNKxkYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791905637; x=1823441637;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HXN1J/O4JVopgXVptVtMkJsZFZ/22R1t/CjYF61yEgA=;
  b=jmNKxkYh7SOKNbhZwGXtjeCcZEGrwPnf1LgZywwRqnYtf8cworDcGIu6
   ihvb1evJ92ika8FsTIWCAHa3ivcAkvvfTIzviqLbbxV/9/JtnoX+dEC8l
   q7UoUAHNIUZfFmtJkRW1tNYYSoH5DQe0MoijaYtvR6zieBiFro60Y757E
   HKazhg6Uwd9PoqPtR3Z+zyB18Rj1lMUzHPoToxOkSWm9HLWZPe8g8AjQ/
   zipJrYdabVpabW1dKuOHYEGyU3PPUxeZVoV5L18SRdePVmNkLPCDZYBkv
   AEC6I/6jxkZiSLYO+Qvv9qxak8gd5RoqeP/8suBEu3YclqD1lfJnLOrVh
   w==;
X-CSE-ConnectionGUID: 2kRFsQQSR/m6rrC5JSfEEA==
X-CSE-MsgGUID: 13gYlhxpSACuEJ3reLpnjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="643437"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="643437"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:33:57 -0700
X-CSE-ConnectionGUID: u1/SJJyoRsWp8a38h4nwLA==
X-CSE-MsgGUID: J9yQodpARhaQJUyyVTmHyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1388269"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 13 Oct 2026 08:33:53 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 13 Oct 2026 23:28:56 +0800
Subject: [PATCH v4 6/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-tdx-module-ext-v4-6-de5ffac65470@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3676;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=HXN1J/O4JVopgXVptVtMkJsZFZ/22R1t/CjYF61yEgA=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWSd84twPHjFW+RRLPu9d90W/Tf/Kk0QlW47WzR5Xcpf0
 2w7D7e+jk4WBjEOBkMxRZYFHrOcprTPYtr6aec1mDmsTCBDhGUqM3NK8/QqSh0y80pSc/SS83MZ
 uDgFYKruGDD8M5m2+F2bwqYzjJobYvvE50e9MJwkeCur16uhdtKabSZtmgz/vd4eEnqqtpHZ5Pa
 JCdU7/694smeixV8FHUvX4mRhRfZgTgA=
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

Runtime TDX module update introduces a mechanism to update the module
firmware while preserving and restoring TDX operations. The extensions
functionalities should also be re-initialized as part of the restoration
process.

The TDX architecture supports an update flow which allows updated
extensions to consume more memory than their original boot-time
requirement. So the arch defines the extensions re-initialization flow
the same as boot-up initialization: the host queries TDX module how much
additional memory needed, allocates it, adds it to the module via
TDH.EXT.MEM.ADD, then re-initializes the extensions via TDH.EXT.INIT.

Linux runs the updates in stop_machine() context, which prevents memory
allocation. So for Linux, a compatible update must not install updated
extensions that require additional memory.

Given that the memory for the extensions must not increase, the
re-initialization skips the memory adding steps. It is simplified as:

  - Check if the extensions are supported via TDX_FEATURES0_EXT. If not,
    skip the extensions re-initialization.

  - Re-initialize the extensions via TDH.EXT.INIT. The SEAMCALL leaf
    will fail if the updated extensions require more memory, which
    indicates the update image is not compatible.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - Collect Reviewed-by tags

v3:
 - Add this patch back cause the latest discussion decides the
   re-initialization won't be integrated in TDH.SYS.UPDATE, a dedicated
   TDH.EXT.INIT call is still needed (Dave & Rick)
 - Drop the ext_required check (Rick)
 - Rename the reinit function as reinit_tdx_module_extensions() (Tony)
 - Move the reinit function right under tdh_sys_update() (Rick)

v2:
 - Removed this patch cause the TDX module is expected to re-initialize
   the extensions on TDH.SYS.UPDATE

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
index f1cc0422d129..4cce77b6a31f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1353,7 +1353,7 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
-static __init int tdx_ext_init(void)
+static int tdx_ext_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 ret;
@@ -1384,6 +1384,19 @@ static __init int init_tdx_module_extensions(void)
 	return tdx_ext_init();
 }
 
+/*
+ * Don't update the memory requirement metadata or try memory allocation in
+ * stop_machine(). If an incompatible update requires more memory, let the
+ * extensions re-initialization fail.
+ */
+static int reinit_tdx_module_extensions(void)
+{
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	return tdx_ext_init();
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1567,6 +1580,10 @@ int tdx_module_run_update(void)
 	if (ret)
 		return ret;
 
+	ret = reinit_tdx_module_extensions();
+	if (ret)
+		return ret;
+
 	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
 	/*
 	 * Only fails if there is something unexpected

-- 
2.25.1

