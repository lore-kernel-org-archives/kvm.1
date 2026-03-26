Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0C3C8723;
	Thu, 26 Mar 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514751; cv=none; b=ZUjHRyBEWiYMdxnIpPy4Umm75Ird89N8LdWfk5ooaKOEM7SCN9Y+9PyMXdDP0Q59WgsysjKTZm0uE5c/TKC56R4gzXZaXA5yLrZnLJZ9rmWg0h7lm29AJaCgtnGO2MakX15eSJqeKtRTnj3s0GI/Y31zboq9RW4AvJYvdOiYv1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514751; c=relaxed/simple;
	bh=fQKrYHkZJpxSGimkiGxtLcw+e+KUn0RJSmSCt/vaidE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqyCO4RL6Q39BH6l5giirbi++7DRjD2KtN7aOfaanWYrx57j7Lpd1lwOKnACEi4vJgJqNEPxkuLB4xdhlYhBttbtWfOysxnijKdXREG9TbEpquD4fLFAliDZVazuJWA36CdJ0hHwq5Xt1ret0FhSRJjgpPTJ2QKnNzfRC/FIc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFg9twDH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFg9twDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514749; x=1806050749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQKrYHkZJpxSGimkiGxtLcw+e+KUn0RJSmSCt/vaidE=;
  b=TFg9twDH40TyjlxnQ8QLcDlpch1ZpDsiemmqPmGDVJwPmxEekjInkBH0
   9ylBAlaT/UXtjffOGUp/pIdLgidCYwtRHRF4Zp5egwXWdvrWjxCka+Y3P
   eVvVD/PVWDlLflDs6TgYTiQMOgE3y2RwJ7NCcNavvoyFUeHLLwjSsXfnK
   4OzH2/sHKW1x6cOWh0HnnMr3PI0lxJeT0FCeXgtLGzZbT9dYmNxoMJ/8F
   iL0HnhnSW/Cz02RPIoig8lRkEZYwPlfsSLOAIJz7EOY+Sehu63pY38HUI
   0qlVbPKSO+ByBRx3BuANHE5U3tpuEVhBydcs+/GdNx//bElH6KggfA0na
   g==;
X-CSE-ConnectionGUID: gWonGnb2Tse3IHRgNXOfLw==
X-CSE-MsgGUID: X02f/lMWQ5StW+gYJlwZdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644787"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644787"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:28 -0700
X-CSE-ConnectionGUID: Gm9b5PD8R6Omp+mOhYdKXQ==
X-CSE-MsgGUID: IQ6p66X9RmGhAor2Z5r+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967263"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:27 -0700
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
Subject: [PATCH v6 22/22] x86/virt/seamldr: Log TDX module update failures
Date: Thu, 26 Mar 2026 01:44:13 -0700
Message-ID: <20260326084448.29947-23-chao.gao@intel.com>
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

Currently, there is no way to restore a TDX module from shutdown state to
running state. This means if errors occur after a successful module
shutdown, they are unrecoverable since the old module is gone but the new
module isn't installed. All subsequent SEAMCALLs to the TDX module will
fail, so TDs will be killed due to SEAMCALL failures.

Log a message to clarify that SEAMCALL errors are expected in this
scenario. This ensures that after update failures, the first message in
dmesg explains the situation rather than showing confusing call traces from
various code paths.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---
v4:
 - Use pr_warn_once() instead of reinventing it [Yilun]
v3:
 - Rephrase the changelog to eliminate the confusing uses of 'i.e.' and 'e.g.'
   [Dave/Yilun]
---
 arch/x86/virt/vmx/tdx/seamldr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 0ab2413e3754..276330179783 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -235,6 +235,11 @@ static void ack_state(void)
 		set_target_state(update_data.state + 1);
 }
 
+static void print_update_failure_message(void)
+{
+	pr_err_once("update failed, SEAMCALLs will report failure until TDs killed\n");
+}
+
 /*
  * See multi_cpu_stop() from where this multi-cpu state-machine was
  * adopted, and the rationale for touch_nmi_watchdog().
@@ -274,10 +279,13 @@ static int do_seamldr_install_module(void *seamldr_params)
 				break;
 			}
 
-			if (ret)
+			if (ret) {
 				WRITE_ONCE(update_data.failed, true);
-			else
+				if (curstate > MODULE_UPDATE_SHUTDOWN)
+					print_update_failure_message();
+			} else {
 				ack_state();
+			}
 		} else {
 			touch_nmi_watchdog();
 			rcu_momentary_eqs();
-- 
2.47.3

