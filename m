Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C9F3BF677;
	Thu, 26 Mar 2026 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514743; cv=none; b=naKEPXbRLIf94bAOT0iitgUmD7MAX5ufDoNOi0H6idr0IgmUEe/ZY4ZG63HABHuywWPF6RwWb7NdxRqi/N8hIDelEZN7Tvtt+mDVpkrz+fdn6LNW9Ot/G24qdVdsl6oA4hz91pucntvsMQIQf44jvsZz8+zeR24ZVT6c15nevVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514743; c=relaxed/simple;
	bh=nZIjkeSVnZT593UpsPc5pD8DdilhJOgI5a05J4luZ6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBdADcAHT1hJdeAD2a7QTDx4vN3lBHzNbccAo+Mw0gSKhrxi7rQwmtgmch9iZcdhHzzm/t06di1J9N59MeOf9b0Xi1Z99VjddEG4a+qL+fdAvlbr6gpI63v8JzI9Oy5Y/9qERMjPhVMB66BHZLKFOSaky6AiLMq2YhcYobz4jnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeG9GXdL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeG9GXdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514742; x=1806050742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZIjkeSVnZT593UpsPc5pD8DdilhJOgI5a05J4luZ6U=;
  b=TeG9GXdL2waq80frRWnN00F35OocHBYFsfT/lYvhAoX4Q6uC/gbvM6MH
   +KzpLzsj0FYislXiCyTIW3iO+YNCormJX+P0kBS3MauIEHMEX/WTz6Zu8
   xMRJCUCm8AptkolOSmkICWQGR1Y6eH5dOqQYpJEeS9+Q20fUj+xGQPoUA
   09DvwmXVjR8RfX5sl4DO8S4kFhDbOpzOWQ4p2umlx6kJWhE5yOlQAs1O+
   63zncO5q4cPRPhUDERdF0nq0jpeXhlQ5Scfmj/JERl5yXM11QYP8StfSu
   /xVdA35n/rPSSxf1hz1BJc1YBCPn70JCSVzy3GkVxcKVcKxZ/9ZNp4ZAO
   w==;
X-CSE-ConnectionGUID: 6hXrEZavT2m9Jl8NPTfQYQ==
X-CSE-MsgGUID: +qqGKtTjSBG72U2Tui4cFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644719"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644719"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:24 -0700
X-CSE-ConnectionGUID: WCWK48lsQXuDI3UzBdLcRg==
X-CSE-MsgGUID: NnFyng9dR/ethUa+N7Jkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967225"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:23 -0700
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
Subject: [PATCH v6 14/22] x86/virt/seamldr: Do TDX per-CPU initialization after updates
Date: Thu, 26 Mar 2026 01:44:05 -0700
Message-ID: <20260326084448.29947-15-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
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
index 0c282a7565a1..8b196ce45546 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -201,6 +201,7 @@ enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
+	MODULE_UPDATE_CPU_INIT,
 	MODULE_UPDATE_DONE,
 };
 
@@ -261,6 +262,9 @@ static int do_seamldr_install_module(void *seamldr_params)
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

