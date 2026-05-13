Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F654CA274;
	Wed, 13 May 2026 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685122; cv=none; b=ctHsIFYxrZocKNALpo+mvE6kcSh4xStVlFDKDJLxjAgtxCMFUr65T7KM1oko+wWAQ3rF74+LFs2x+sOctFgLkdbeWnOGvQWJfTKnFyJRXcvIE0g0d6uPR4okLQAlIUMlMGn/Yj41Jc0ZKPnCnsVReFij/oMPix+2bDju6dT9C74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685122; c=relaxed/simple;
	bh=LgJAWydLHvR8ezJs7eq/SLlr4i/XqNnAZA8qUlJbBtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKivIjIkFAnMEbFTPi3y8H28EgQG3NIS43YVPUnF5wJsArYWQC84jO1BkQ54CHIdXW69dQZFb/KUy3k8EDRGSMNT7wKCltPZ+Ad5ezgBNRqzZKIq7RBtEBujekw1XheHhvQRkmBz/tmhyCwWRuY04+PDemlbttCC+MlpXXthcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F60GaVZi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F60GaVZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685121; x=1810221121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgJAWydLHvR8ezJs7eq/SLlr4i/XqNnAZA8qUlJbBtw=;
  b=F60GaVZiu+PTTDfZGQHMOBm1idYF9j8hqJJFZTBtZcmCQt0aHVGyTqfv
   5KUtN/BIS9FJbPOaZqdcHUkWsFE1ahb1JoAc9z6E0s+VOCEwH18CQIxef
   7Ah4cb2idb4pdn449J7gnCt3vMexpYg27w8dqkBN54697iRHIK/M45Opv
   QZGYC3MqHlx4i3yYAxnJj+oFjNv29uPqmkcgX421+0ecBUWY1bzdhYNJQ
   fPEI8lnSA3zZlKcHzXiETxmJG27NktMQv/KyMXCUGoHDm49DeZkUa+M1n
   9lFozWlgvPpBw9kupvTXRC+PqU80CMXAmLZe+fOXOdp4ebOipgVxPMbhc
   g==;
X-CSE-ConnectionGUID: 3BdbuMWZTx2t710wxh2EFg==
X-CSE-MsgGUID: t2kOQPDWRnW7tICT4tJH+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921779"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:57 -0700
X-CSE-ConnectionGUID: +70KIATCQYm4NRINAyKfZQ==
X-CSE-MsgGUID: 20f9AGtaSqSy4yuzSz/M0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716904"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:57 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
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
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v9 18/23] x86/virt/tdx: Restore TDX module state
Date: Wed, 13 May 2026 08:10:01 -0700
Message-ID: <20260513151045.1420990-19-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
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

For error handling, Intel® Trust Domain Extensions (Intel® TDX)
Module Base Architecture Specification, Chapter "Restore TDX Module
State after a TD-Preserving Update" states

  If TDH.SYS.UPDATE returns an error, then the host VMM can continue
  with the non-update sequence (TDH.SYS.CONFIG, TDH.SYS.KEY.CONFIG
  etc.). In this case all existing TDs are lost. Alternatively, the host
  VMM can request the P-SEAMLDR to update to another TDX module. If that
  update is successful, existing TDs are preserved.

Given the complexity and uncertain value of above recovery paths, simply
propagate errors.

Also note that the location and the format of handoff data is defined by
the TDX module. The new module knows where to get handoff data and how
to parse it. The kernel doesn't need to provide its location, format etc.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c |  5 +++++
 arch/x86/virt/vmx/tdx/tdx.c     | 13 +++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index e4a3271051f6..6a39c9e3ef7d 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -178,6 +178,7 @@ enum module_update_state {
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_CPU_INIT,
+	MODULE_UPDATE_RUN_UPDATE,
 	MODULE_UPDATE_DONE,
 };
 
@@ -258,6 +259,10 @@ static int do_seamldr_install_module(void *seamldr_params)
 		case MODULE_UPDATE_CPU_INIT:
 			ret = tdx_cpu_enable();
 			break;
+		case MODULE_UPDATE_RUN_UPDATE:
+			if (primary)
+				ret = tdx_module_run_update();
+			break;
 		default:
 			break;
 		}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5e54da302f2d..7eb1b67af656 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1298,6 +1298,19 @@ int tdx_module_shutdown(void)
 	return 0;
 }
 
+int tdx_module_run_update(void)
+{
+	struct tdx_module_args args = {};
+	int ret;
+
+	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
+	if (ret)
+		return ret;
+
+	tdx_module_state.initialized = true;
+	return 0;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index f0c20dea0388..bdfd0e1e337a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -47,6 +47,7 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
+#define TDH_SYS_UPDATE			53
 #define TDH_SYS_DISABLE			69
 
 /*
@@ -110,5 +111,6 @@ struct tdmr_info_list {
 };
 
 int tdx_module_shutdown(void);
+int tdx_module_run_update(void);
 
 #endif
-- 
2.52.0

