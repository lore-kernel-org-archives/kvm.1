Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3536682D;
	Sun, 15 Mar 2026 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583187; cv=none; b=uhFCisNWk665hdGEtFMHiuPAKMYlWnYfAOkWcu+MDX9/wcgIYfSTVBYwXM06sGuGJb/PUBAc1dsPbVrkw5HOhSPn9bhqtBROh7ttifU3FweFIt3RHZ7crJ8yIhabLz5LhG5Rmr+tgRrSKkQUvSvGSKkG1i3joMsxvpGFAexyLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583187; c=relaxed/simple;
	bh=++GAWHtFRzuZ2kWjliZqn74GIC5sgxuhyQCc1cMypwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9FMikTXsBBVDFfjSHeQzgZjggm1qA+WCsBcVJJOMyHkq4b4rv07+Ud6TmnGuyAM7PaTjThbt5GaLQ1z3JNmoQVCpwn0s2dkIcfsirUBN0s6OTiG1Yivl94/DuKyBvZLjjlw6Gchw9jIC8ZsblNhulOM5zv5WmiPdvUz+zoUXLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqlN69QP; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqlN69QP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583186; x=1805119186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++GAWHtFRzuZ2kWjliZqn74GIC5sgxuhyQCc1cMypwQ=;
  b=XqlN69QPNGKFqk40JzERp3HbamnUi+2W4cKybv3vRX0LMLsF7s4zJuHl
   6GAjxklF/mEuj2MP1hhBcqLpwv2vIh2Ih99X3Pii/8Lli6Xagu//APR0q
   vRwkaT3x5CxjLh1sRoE6w6sCcXrtaoVQql4O/GEQcs/rTJ3xv4IxR6TBG
   evhfhXHkTxlh1yNAdpRCc9qwRZ2HLOXcF8Hn7INXAhjwEOUzZyst2cRF4
   FQv3n10eHN3rkN2kvvPaf779JYwrfKgBz8LwTBc64REczqrmOHGlOKo8N
   94ax+9jPQviiPtrYHulsTSNQdolnwOOzIK42gITCNrfnX8C1wqHGghcyi
   w==;
X-CSE-ConnectionGUID: Lu8gVJpsQsm+2xJ7M8b33A==
X-CSE-MsgGUID: WP43ArQdQS+Q0+is7KOD9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732519"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:42 -0700
X-CSE-ConnectionGUID: zR3pIQYwSXeY+eiNQhZSxw==
X-CSE-MsgGUID: 4fAGjPkYQ+ePkgfydZeFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123059"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:42 -0700
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
Subject: [PATCH v5 14/22] x86/virt/seamldr: Do TDX per-CPU initialization after updates
Date: Sun, 15 Mar 2026 06:58:34 -0700
Message-ID: <20260315135920.354657-15-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
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
---
 arch/x86/virt/vmx/tdx/seamldr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index a64271f94aed..4d8c96d82c05 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -188,6 +188,7 @@ enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
+	MODULE_UPDATE_CPU_INIT,
 	MODULE_UPDATE_DONE,
 };
 
@@ -250,6 +251,9 @@ static int do_seamldr_install_module(void *seamldr_params)
 				args.rcx = __pa(seamldr_params);
 				ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
 				break;
+			case MODULE_UPDATE_CPU_INIT:
+				ret = tdx_cpu_enable();
+				break;
 			default:
 				break;
 			}
-- 
2.47.3

