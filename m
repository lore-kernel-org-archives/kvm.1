Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F634CA287;
	Wed, 13 May 2026 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685118; cv=none; b=iqJYK5BndHsccRWZqZ48974ZUPGyMNTG+rSCnPakVr/FG+XF/oBY8y1aW7TV8cW6HFuY5lBjHJjwdTjw8b4l1HsuBLit2oQV8SsqPmklsCxAZp8HS36OkJgNNThYHUtF/yobOJ/nQbzXPWhHEmpj2KMxHOT2dwA6lBV9YPx5LfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685118; c=relaxed/simple;
	bh=pVfScDnFT5LQzUKrbNHeZ9wxSjJOj5uItEQNF5d741E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu0Uc/Tpl7ARb82ptFOPeanT7Gk20QKZzE08+JPLvP2Z5mw9vQiOv3Hc6mAkqbbdspCV7qV0wj0zeMMFFyNZuBAACQQEihTKQ5i4p+XBRQjhg6AcfBpBwvupqj6JzUkiyQIhUti2iBxbtOoF8ilpamWcIIXrQTeLr00OOPk1pOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPO0rSUx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPO0rSUx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685117; x=1810221117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVfScDnFT5LQzUKrbNHeZ9wxSjJOj5uItEQNF5d741E=;
  b=iPO0rSUxAAXz84HXHLiivcpqpgslRZrQS3JggHWdny5i8x3DRWkcYQkk
   gYmfTo0IRoj+EQUgkgp6ikkX3+XdcGZbxohgYjJr4U+/FDJ9WTeWALd6I
   1vndGiHrxPKgazFvHzxRMQqHCYN7pfMHPAen+RfFnZkf2ayzemvEp0b4H
   j6L8ShX16XJwUnU0SZBO1pNNMo+bW6YNfU8pK6f+Jb27Het/fJogwKdOf
   8pVNb7XO/m3ubwTAXsfqkP5y6XyK+Hm6MgRD7WmxGUB4R1EjZSl1pQSk7
   u9wGWaWDJwGVjhUiF2AZiSFQ7CfxiqrLf4ih7KtHR0j/DmOMMsnpN78PR
   g==;
X-CSE-ConnectionGUID: ClcRMEukTBqtro5yHuoSsA==
X-CSE-MsgGUID: ycRYzClnQ7GOYuorfX6wXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921771"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921771"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:56 -0700
X-CSE-ConnectionGUID: +itVP+tMQSaPFRL/gJvtTQ==
X-CSE-MsgGUID: sPdDWnQkQwOmHiOpgoCkjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716898"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:56 -0700
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
Subject: [PATCH v9 17/23] x86/virt/seamldr: Do TDX per-CPU initialization after module installation
Date: Wed, 13 May 2026 08:10:00 -0700
Message-ID: <20260513151045.1420990-18-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After installing the new TDX module, each CPU needs to be initialized
again to make the CPU ready to run any other SEAMCALLs. So, export and
call tdx_cpu_enable() on all CPUs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h      | 1 +
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 arch/x86/virt/vmx/tdx/tdx.c     | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 27376db7ddac..5d750fe53669 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -107,6 +107,7 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 
 #ifdef CONFIG_INTEL_TDX_HOST
 void tdx_init(void);
+int tdx_cpu_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 9d0e7e8c6c20..e4a3271051f6 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -177,6 +177,7 @@ enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
+	MODULE_UPDATE_CPU_INIT,
 	MODULE_UPDATE_DONE,
 };
 
@@ -254,6 +255,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 		case MODULE_UPDATE_CPU_INSTALL:
 			ret = seamldr_install(seamldr_params);
 			break;
+		case MODULE_UPDATE_CPU_INIT:
+			ret = tdx_cpu_enable();
+			break;
 		default:
 			break;
 		}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 20b3b33e4677..5e54da302f2d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -106,7 +106,7 @@ static int try_init_module_global(void)
  * (and TDX module global initialization SEAMCALL if not done) on local cpu to
  * make this cpu be ready to run any other SEAMCALLs.
  */
-static int tdx_cpu_enable(void)
+int tdx_cpu_enable(void)
 {
 	struct tdx_module_args args = {};
 	int ret;
-- 
2.52.0

