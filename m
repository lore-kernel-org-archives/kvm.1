Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC23361DC1;
	Thu, 12 Feb 2026 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906990; cv=none; b=coMSvCFr3ItFqA/uRDTpE6CLvLO5h4UgUBj0fCOz4rs8Np1YwPL0qYMEI01FCYsnyb+VAKx5SvMpdqMcu7UBLm4M6b7fbKzxw5YZZkC236zdRq95s131+K3AkWPAcNrgYHgBsobBejykOzxr9JZJMUWP6Nc5MklGmNt2/Wka26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906990; c=relaxed/simple;
	bh=XNjGb74PLFtejz7tdMieajk5jWJt9QEap7aZlzkACPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt6xz9lFZhO6ZKj81J4wAxziSd89iPdhDiJxaMPHXI9V2/hmurDB0HM7v2JR2cgnilcIySNeshuL5WAnS3qi7YZeDgMsVXBEGLOA5GFB0XJxEsD3Pgvm9DMquyzti3LaB26eMcNym9bdExo55axjhcZSNNkI8K0msNmNtMGTKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TegPunog; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TegPunog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770906988; x=1802442988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XNjGb74PLFtejz7tdMieajk5jWJt9QEap7aZlzkACPo=;
  b=TegPunogdl2VTVNBNvSD9rDQKjuFkkNXsSEuAnXDavrgadAjp60KWxz+
   sB1XMniWp2zE21KWUXet952szfPA8cEBNFkWY7T63tXNGjKzCUJAxHFZM
   ueiPuW9YKJzFMmDG+MOfsuMndzu7lk/CbwX7SqVzhql/rTBNjC4vZ6e0W
   QlBd0Gsh3cUFl44LURMI2fOvTsziCMAXGof0wegPfVDuUE8C/xikl4gwO
   CS5ZZj2kSmD+/27KbdjT1m+XtisQE+CcIe54ICY3Um6Ry/a09K2XnV7Po
   TPhFixm1ZV5E9huD985pvRPDzrnPFZdpNFVTrCnAmbgQyAaxWfEmRswXK
   w==;
X-CSE-ConnectionGUID: gF+W0p6FQg2wp7+As50PUQ==
X-CSE-MsgGUID: jrFjadWARmiaU7IwpdqKQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89662877"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="89662877"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:36:26 -0800
X-CSE-ConnectionGUID: pNDgzLglTKSCj+N/Gx3MVQ==
X-CSE-MsgGUID: tTiPWpVASRGKAwxzy59kJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211428282"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 06:36:26 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	x86@kernel.org
Cc: reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com,
	zhenzhong.duan@intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	vishal.l.verma@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 17/24] x86/virt/seamldr: Do TDX per-CPU initialization after updates
Date: Thu, 12 Feb 2026 06:35:20 -0800
Message-ID: <20260212143606.534586-18-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212143606.534586-1-chao.gao@intel.com>
References: <20260212143606.534586-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After installing the new TDX module, each CPU should be initialized
again to make the CPU ready to run any other SEAMCALLs. So, call
tdx_cpu_enable() on all CPUs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 4537311780b1..e29e6094c80b 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -200,6 +200,7 @@ enum tdp_state {
 	TDP_START,
 	TDP_SHUTDOWN,
 	TDP_CPU_INSTALL,
+	TDP_CPU_INIT,
 	TDP_DONE,
 };
 
@@ -260,6 +261,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 				args.rcx = __pa(seamldr_params);
 				ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
 				break;
+			case TDP_CPU_INIT:
+				ret = tdx_cpu_enable();
+				break;
 			default:
 				break;
 			}
-- 
2.47.3

