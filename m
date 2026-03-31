Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849403ED12F;
	Tue, 31 Mar 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961017; cv=none; b=KQphB/lFfGc/bMQWojx9D+E+3MQYAIZm1Rqu0WK6x2ALuC1Fmi0Z/5gjBbHpEdPIlVPN31YAy0ZZOT+9dby+75tCqT1TdbWzS7bX6RJYD3NY3NNdvecgwxZ23vMDOWYhhHSV6pAueDfis7yOtfyruZ7yzEymWUwR2+mrR8+lykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961017; c=relaxed/simple;
	bh=+z7VhfClXUX08Td0N9S47C3Ah3/xwNuBnxRDdqg4LwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGhU9Mske6X0iDJpSzeHugDxepCFrp0PFJ+396WqFb+FlEYWK8WS3vg/isNIeiYUTPXe1Z20sXsp4JYi1Cf3Ru2ffd0DGCks6UIkoiwmALDpCnfR2uV6eszRIhvya69FmDyyHhi/YbmdEjUkefdD5RMwbUtFf4DbP29gLafAG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SvdpJx5Q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SvdpJx5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961016; x=1806497016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+z7VhfClXUX08Td0N9S47C3Ah3/xwNuBnxRDdqg4LwQ=;
  b=SvdpJx5QoI0oV9GDyL68UoRCzT4ruVb/UIJXysecECvmLLBI1tfD7bpu
   qlXlbSXG6c4PxHxc5jlg5dVsvvS6hQb82LPwx+k3XBoUdtdms5t/foSJG
   dOKzxY1RicdgPkqkoKV8R85jVR1VCcQnOG6X2XgW8fzHkbyo3DV62h+xm
   sgKW/JdHrKgBFRUYkEcmwf6rADfM0m7Y4VFahIxBm/JEHjSzQW7zRUAbb
   K/dkvvtZqlh+GJAVpfd10FpNJv/AkM0DidKoykXKmDHmXi/i2Zo/wsM/N
   jgYrPQsmiq1yQcs0kkF5kHVsD5NcwwB7o+ElDxyEuiOY9wUIQW/+KAQ9Z
   A==;
X-CSE-ConnectionGUID: jisUfGFZSXyccf5i+UhoZA==
X-CSE-MsgGUID: VMWw2V/qQEekc8bTZgy6uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084545"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:35 -0700
X-CSE-ConnectionGUID: r8esO7IGQj61zsNND8QBrA==
X-CSE-MsgGUID: d+qp7eH2QE2Zy+SsUTqFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492139"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:34 -0700
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
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v7 14/22] x86/virt/seamldr: Do TDX per-CPU initialization after updates
Date: Tue, 31 Mar 2026 05:41:27 -0700
Message-ID: <20260331124214.117808-15-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After installing the new TDX module, each CPU needs to be initialized
again to make the CPU ready to run any other SEAMCALLs. So, call
tdx_cpu_enable() on all CPUs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 3e46f3bfaa8b..bb1d1487c467 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -218,6 +218,7 @@ enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
+	MODULE_UPDATE_CPU_INIT,
 	MODULE_UPDATE_DONE,
 };
 
@@ -278,6 +279,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 			case MODULE_UPDATE_CPU_INSTALL:
 				ret = seamldr_install(seamldr_params);
 				break;
+			case MODULE_UPDATE_CPU_INIT:
+				ret = tdx_cpu_enable();
+				break;
 			default:
 				break;
 			}
-- 
2.47.3

