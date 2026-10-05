Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4CD4DD3B2;
	Mon,  5 Oct 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222369; cv=none; b=goS8rSOLwQPFbuujQGPBJiTfP8++E6iuLUWaSqCmDacWYhD/dzcwFPsqgRNBuTecjCMZal/hRWHeL69fl+rFSd2kINmzkKG8Clv1V13bXDmk4bDas9JHRv0LP6i4bOQ5yqrB4beU8jL3sNVRZ/OOqg/etcuMOEg9CP9roAD/zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222369; c=relaxed/simple;
	bh=iGuv5VDguEIXkmUglvkB0dvuBQIrLhdgSHguekRaHWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVK5wggNcSD8ZHQIsLQiG/qdm5X98N9DNSwhGM96mDXMiEsx2U4TWnS6nrIugm/6fb91hAufxT9Y5T8o3But4FjASHjZukUhGtVB2oQqqKNAOVfzk0e/EDM67+etCj+n7z0NM1p2gS7W0U+98Xk4IaosMfdBKZzM0TqXapLYIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emP0ROdz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emP0ROdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222368; x=1822758368;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iGuv5VDguEIXkmUglvkB0dvuBQIrLhdgSHguekRaHWA=;
  b=emP0ROdz/oP11D/a1o7Wm5PiRm2RCDmEZjANHt6AJHxf+AQqdjOgcDwF
   nFCTK5j8WNH/UpWpoMH5dB7keAMfEELkC4FQV0+MrFYgAaGIW5uoKMaR6
   SyckHBE8aZb5v16wZIF5E1YNVkRHTHJcIfJYmMotNqkA+bgk6TaFltqrx
   /4d+m9bA6v06at2lNqcCIvu72I4GOO04403uftoWBge0quiGbE9QNOjnc
   StE3AhMGnG9GvOH//7NrQDyvmVg2NABcWaSQK21p/EY8YxOemPAcmuXuJ
   uKKCDU/ZHdrZ5yYflnfpFY9/+Gvy/EmUZkQPjkjbmy6a56rgvRSYKzeh8
   Q==;
X-CSE-ConnectionGUID: XCMWyMBFQjKhgBLTJprkrA==
X-CSE-MsgGUID: u2tY3aMVSg+zteLqx1FB0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102419833"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102419833"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:46:07 -0700
X-CSE-ConnectionGUID: MZzaQNl3StaEBbUIYAFDSA==
X-CSE-MsgGUID: 1FaYpGd3R1uGfVZqQLBJJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276002475"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 10:46:02 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 06 Oct 2026 01:41:49 +0800
Subject: [PATCH v3 5/6] x86/virt/tdx: Re-initialize the extensions on
 runtime TDX module update
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-tdx-module-ext-v3-5-db52cb05b918@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3401;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=iGuv5VDguEIXkmUglvkB0dvuBQIrLhdgSHguekRaHWA=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWQdfjg740zu8Qs+H9xvrXU2a5u+6Z/KJ8HK03yW0+MZ4
 ydrPzr/qqOThUGMg8FQTJFlgccspynts5i2ftp5DWYOKxPIEGGZysyc0jy9ilKHzLyS1By95Pxc
 Bi5OAZgqKWOGf6YZzNPeWWYv2cVwMvz1tIjefY+eXr7BOf3+W52fT2/XzLVgZHi4P/yPNWPunP3
 BfCpzFt5Zw1hVpBIey6mQHh8wLUqhmR8A
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

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
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
index d8df3b2b1d17..5d5f9da1ab02 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1348,7 +1348,7 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
-static __init int tdx_ext_init(void)
+static int tdx_ext_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 ret;
@@ -1379,6 +1379,19 @@ static __init int init_tdx_module_extensions(void)
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
@@ -1562,6 +1575,10 @@ int tdx_module_run_update(void)
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

