Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51B9366DD8;
	Sun, 15 Mar 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583189; cv=none; b=JkJseNSCNaA1JHIBKq0vN/T2c7KucDSIS4dK5oDXsWkTMKVA4OeR4mlVM2A2POJ2fVoXqPKopeujK7ycyyjIQyRUNFIvZGJsET98KW4S4NLh+q+GrEsi2o/CNNbKMDXgAf5NswOaGSFkboaznMUFyySnWO9NMs39JTV6MrqWRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583189; c=relaxed/simple;
	bh=AYfSh9nzWzuIHJmcskKQuynmtaR40yx4tJ14HWl8bd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aixDRFCEOzEcaRcUr23t5GT3tT9StQX35MdYlTSoq68Gmtg/fwuFEtj0HiP8hcD2rkjnOjPTWvG7rt09+PxQiT2V1lKrP++Lg9b3CPdtOhXpkhn86KrNnynuqMlQVZ9e3LK9HJuiQlQ49T5WySYCTqa5526mqn0oQaixLGy5YYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEp4xd//; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEp4xd//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583187; x=1805119187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AYfSh9nzWzuIHJmcskKQuynmtaR40yx4tJ14HWl8bd8=;
  b=kEp4xd//OoZ7HZR3tY9Y4+ppvjULAOBwtoWb+EIRH3ID0AdC+zJ9Iobd
   0vSEJzEnogL8kw6rZvEmhRXhlLz0YIhwxsgCkgRKNEg65ZoYV18MaSFdF
   HoS/j6Ho3FjXrnDJVUzl72QKYAhx/BKKEamISIlLXJfZjhAXNWZu4Pd7E
   MKvi3Dk5AlIbI4F8zJuY5hvZPXVM8hsNW/uYJ2ng9Ghz5skG1OBQ22BEy
   VoSphOZrOoJiBY+Hqrqwk/G6CHNSp6vn2ZkTTGTc8iq8bPLeBrW+emoSA
   vxQcC+p4EBYppIjJBxcYso/2h/KWiyqTC1gU6dnFTp2BUm4vPAOcl/bQp
   g==;
X-CSE-ConnectionGUID: ruFjpnVBR0yAv5Desne9lQ==
X-CSE-MsgGUID: Vajefu/yS7+BQ5IL34xJLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732527"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732527"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:43 -0700
X-CSE-ConnectionGUID: DJVbfy+eSmyG32NZfNkHSg==
X-CSE-MsgGUID: zKDMovnDRjiEZZLx7qgWyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123065"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:43 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 15/22] x86/virt/tdx: Restore TDX module state
Date: Sun, 15 Mar 2026 06:58:35 -0700
Message-ID: <20260315135920.354657-16-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TDX module state was packed as handoff data during module shutdown. After
per-CPU initialization, the new module can restore TDX module state from
handoff data to preserve running TDs.

Once the restoration is done, the TDX module update is complete, which
means the new module is ready to handle requests from the host and guests.

Implement the new TDH.SYS.UPDATE SEAMCALL to restore TDX module state
and invoke it on one CPU since it only needs to be called once.

Note that Intel® Trust Domain Extensions (Intel® TDX) Module Base
Architecture Specification, Revision 348549-007, Chapter 4.5.5 states:

  If TDH.SYS.UPDATE returns an error, then the host VMM can continue
  with the non-update sequence (TDH.SYS.CONFIG, 15 TDH.SYS.KEY.CONFIG
  etc.). In this case all existing TDs are lost. Alternatively, the host
  VMM can request the P-SEAMLDR to update to another TDX module. If that
  update is successful, existing TDs are preserved

Don't implement the two alternatives due to their complexity and unclear
benefits.

Also note that the location and the format of handoff data is defined by
the TDX module. The new module knows where to get handoff data and how
to parse it. The kernel doesn't need to provide its location, format etc.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
v5:
 - Massage changelog [Kai]
v3:
 - use seamcall_prerr() rather than raw seamcall() [Binbin]
 - use pr_err() to print error message [Binbin]
---
 arch/x86/virt/vmx/tdx/seamldr.c |  5 +++++
 arch/x86/virt/vmx/tdx/tdx.c     | 16 ++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 4d8c96d82c05..806edf50a952 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -189,6 +189,7 @@ enum module_update_state {
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_CPU_INIT,
+	MODULE_UPDATE_RUN_UPDATE,
 	MODULE_UPDATE_DONE,
 };
 
@@ -254,6 +255,10 @@ static int do_seamldr_install_module(void *seamldr_params)
 			case MODULE_UPDATE_CPU_INIT:
 				ret = tdx_cpu_enable();
 				break;
+			case MODULE_UPDATE_RUN_UPDATE:
+				if (primary)
+					ret = tdx_module_run_update();
+				break;
 			default:
 				break;
 			}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cfe76d4ca570..9f137d15553f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1207,6 +1207,22 @@ int tdx_module_shutdown(void)
 	return 0;
 }
 
+int tdx_module_run_update(void)
+{
+	struct tdx_module_args args = {};
+	int ret;
+
+	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
+	if (ret) {
+		pr_err("update failed (%d)\n", ret);
+		tdx_module_status = TDX_MODULE_ERROR;
+		return ret;
+	}
+
+	tdx_module_status = TDX_MODULE_INITIALIZED;
+	return 0;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 1c4da9540ae0..c62874b87d7a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -47,6 +47,7 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
+#define TDH_SYS_UPDATE			53
 
 /*
  * SEAMCALL leaf:
@@ -120,5 +121,6 @@ struct tdmr_info_list {
 };
 
 int tdx_module_shutdown(void);
+int tdx_module_run_update(void);
 
 #endif
-- 
2.47.3

