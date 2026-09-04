Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24143C7DE;
	Fri,  4 Sep 2026 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559169; cv=none; b=gOu0zJC5HFaoKwIg8bFhPy+IxTyOuqFUTNBQgve5cSRjNltSbHBvGd33h2MunVzvXVPvJ492z7jx7UVCD6ZOPDiMiZCtIdhlkQGgtYUvHcrUYfSntgQKMUQH5FeHZffvfiQmrMK+G7gOwrudxbn1WgwOh4dfgoj3dJTdY2RhQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559169; c=relaxed/simple;
	bh=yHxQ4VNziey9j8Q6p8JRnEQNBf+rRCkXU8IToy3XJAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0acTCElQHCaeTtDHVM6Kna/jWA+zHOSJZI4zYyGxu4IAP6EyhHnQ+9wg6SlkaGB/Wz2xnT/06GTDsJIpxr87Ug6gHbt1ZVUk28qupxs7Eud9PiQVeoJ2rJaPGkvhctejHiDxxvgSEFkgMg5b33WkaQ2l/Ud7aHdv5Vas3LfrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X4RA/fkO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X4RA/fkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559166; x=1820095166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yHxQ4VNziey9j8Q6p8JRnEQNBf+rRCkXU8IToy3XJAM=;
  b=X4RA/fkObaZf6PcwjJ6XtaR7UVWmY3kMrLXKMas3tOLv7rvf/Jf0L3j1
   a9irlxh4isrnxzIcV+OeeMyFqelOaB35vHrTei1mtZdPJsnOSIjBtUo/o
   fls4Mx6klWE+AB9pCWbgliCM9XY9oQCn8ayB25qN5j+zMgrJ2w6K5XFIM
   3fDA3HwsM2k3vdUa5H17pEGOiSbxyyvKSIXKzxMXaiu+/h7h/e67mLDwN
   F59dqomqxxzoXH+CSp8L2G02J9BQ0fRoVdVcsB45U15HbeSnQCV2v91Zj
   t37vNQcG6c7zheObmIU5Pd7Gb4VbBIgTmcYiez2coIceuN7Ljd3752sWq
   g==;
X-CSE-ConnectionGUID: Ss7VK5LeSumYnX+J9CajgA==
X-CSE-MsgGUID: TGfjGLfFScWuMmzFQrRTVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224794"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224794"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:23 -0700
X-CSE-ConnectionGUID: axK80tfRROCFmAOIrkJPBw==
X-CSE-MsgGUID: Gt9EnO1BQdeSg+J9V5u78w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675022"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:23 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v11 00/11] Dynamic PAMT
Date: Fri,  4 Sep 2026 14:58:30 -0700
Message-ID: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is a quick v11 of the Dynamic PAMT TDX series, to fix the two minor 
issues. The main change is to remove the kernel parameter, and go back to 
essentially a v5 version of patch 9. The other tiny change is correct the 
__maybe_unused ordering noise that came from applying a change to the 
wrong patch.

Differences from v10 are simply:
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e7558b8382acf..68647ff4bdd24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7582,16 +7582,6 @@ Kernel parameters
 
        tdfx=           [HW,DRM]
 
-       tdx_dpamt=
-                       [X86] Controls whether TDX will use Dynamic PAMT
-                       to save memory, when supported.
-
-                       Valid parameters: "on", "off"
-                       Default: "off"
-
-                       For details see:
-                       Documentation/arch/x86/tdx.rst
-
        test_suspend=   [SUSPEND]
                        Format: { "mem" | "standby" | "freeze" }[,N]
                        Specify "mem" (for Suspend-to-RAM) or "standby" (for
diff --git a/Documentation/arch/x86/tdx.rst b/Documentation/arch/x86/tdx.rst
index de09967ce8d8c..a36ea2bd4301d 100644
--- a/Documentation/arch/x86/tdx.rst
+++ b/Documentation/arch/x86/tdx.rst
@@ -219,13 +219,7 @@ When Dynamic PAMT is in use, dmesg shows it like::
   [..] virt/tdx: 10092 KB allocated for PAMT
   [..] virt/tdx: TDX-Module initialized
 
-Dynamic PAMT is only enabled when supported and the ``tdx_dpamt=`` kernel
-parameter is set to "on". The feature is off by default because TDX module
-internal details prevent Dynamic PAMT from working on all keyid partitioning
-configurations. When the TDX module is fixed to include these constraints in
-its enumeration of Dynamic PAMT support, kernel support can be changed to
-default on. For more information, consult the Intel TDX documentation about
-Dynamic PAMT.
+Dynamic PAMT is enabled automatically if supported.
 
 TDX Interaction to Other Kernel Components
 ------------------------------------------
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2acab6e5f5f87..7891e42b27508 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -50,8 +50,6 @@
 /* Number of DPAMT pages to be provided to TDX module per 2MB region of PA */
 #define TDX_DPAMT_ENTRY_PAGE_CNT 2
 
-static bool tdx_enable_dpamt __ro_after_init;
-
 struct tdx_module_state {
        bool initialized;
        bool sysinit_done;
@@ -2056,9 +2054,6 @@ EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 {
-       if (!tdx_enable_dpamt)
-               return false;
-
        return sysinfo->features.tdx_features0 & TDX_FEATURES0_DYNAMIC_PAMT;
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_supports_dynamic_pamt);
@@ -2334,13 +2329,6 @@ void tdx_free_control_page(struct page *page)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
 
-static int __init tdx_dpamt_setup(char *str)
-{
-       return kstrtobool(str, &tdx_enable_dpamt) == 0;
-}
-
-__setup("tdx_dpamt=", tdx_dpamt_setup);
-
 void tdx_sys_disable(void)
 {
        struct tdx_module_args args = {};


Remaining patches without Dave's RB:
[PATCH 04/11] x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
[PATCH 09/11] x86/virt/tdx: Enable Dynamic PAMT
[PATCH 10/11] Documentation/x86: Add documentation for TDX's Dynamic PAMT

Background
==========
Dynamic PAMT is a TDX feature that allows saving memory by allocating some 
of its page tracking metadata dynamically, instead of statically at boot. 
These static allocations take roughly 0.4% of system memory. The savings 
are variable depending on system and TDX usage, but could be up to 100x. 
For more Dynamic PAMT background, please refer to [0]. For more analysis 
of the savings in different scenarios, see the v6 coverleter[1].

It occurred to me that since the Dynamic PAMT effort began, RAM has become
much more expensive. Consequently, this feature is even more valuable now.
It would be good to enable it for TDX users.

Base
====
This is based on v7.3-rc1. A branch of this series can be found here: [2].

Testing
=======
I just did some regression testing with our standard automated testing for 
this one. I left Tested-by tags per Hongyu's preference.


[0] https://lore.kernel.org/lkml/20250918232224.2202592-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20260526023515.288829-1-rick.p.edgecombe@intel.com/
[2] https://github.com/intel-staging/tdx/tree/dpamt_v11

Kiryl Shutsemau (2):
  KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
  KVM: TDX: Get/put PAMT pages when (un)mapping private memory

Rick Edgecombe (9):
  x86/virt/tdx: Simplify PAMT layout calculation
  x86/virt/tdx: Allocate page bitmap for Dynamic PAMT
  x86/virt/tdx: Add __tdx_pamt_get/put() helpers
  x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
  x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
  x86/virt/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault
    path
  x86/virt/tdx: Enable Dynamic PAMT
  Documentation/x86: Add documentation for TDX's Dynamic PAMT
  x86/virt/tdx: Optimize tdx_pamt_get/put()

 Documentation/arch/x86/tdx.rst              |  21 +
 arch/x86/include/asm/kvm-x86-ops.h          |   1 +
 arch/x86/include/asm/kvm_host.h             |   1 +
 arch/x86/include/asm/tdx.h                  |  23 +
 arch/x86/include/asm/tdx_global_metadata.h  |   9 +-
 arch/x86/kvm/mmu/mmu.c                      |   4 +
 arch/x86/kvm/vmx/tdx.c                      |  99 +++--
 arch/x86/kvm/vmx/tdx.h                      |   2 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 448 +++++++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                 |   2 +
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  23 +-
 11 files changed, 538 insertions(+), 95 deletions(-)

-- 
2.55.0

