Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42D366803;
	Sun, 15 Mar 2026 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583186; cv=none; b=O9JEk2NSTlDCWb0TyoqCzxe1yyRpJKFNcFP6oVAbGwSq16UO17C2XaJWnWeboI0v9Xr2wKzdq6U/ehXWMuM5YRuozl9odHvf3ygxV2dasQjPzIN/mckfymC5UW1pbBAFPD513sG+TfDghxd+XB1HRfIf45p+Kxtp0Mr92rC7TUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583186; c=relaxed/simple;
	bh=erQXWjYg3IDmZ3KFFHbWEdsLQ8MJHunpoDYV6dXAb0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhS4DAGELFTdwNDT1Y7z2qCyXXM/AeXVoxIb0VZ4nQEvOG8ie6U4uq6dQ0O9Y2bV8eYoyhAy7XuUOYGUEaNpKd9UDqmrcFZOeEGBgEjrqlL6CGyEE5h8epLfwS/lLEgShQPuBt6e3T13M16MaQMXxNNjWgMkzpzg81x3WE1eJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wid2+Jzt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wid2+Jzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583185; x=1805119185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=erQXWjYg3IDmZ3KFFHbWEdsLQ8MJHunpoDYV6dXAb0I=;
  b=Wid2+JztBWYZBqlIywIt40Cz6tpA2B/8TEjpeJJBxII+GpqzLM7wF99H
   hyO42zKbVtDOkQJu3VfCsj1ZOJ/ZeiE8FFUXz+59hL4kEpJWnZhqoe3kU
   psjCk9GjX14qu5apzP0Ve4Q663hPyhrvCDzRp2I86Zf4F3Zwg/9j+uJ1O
   MZN9f5GN3a3j0b4z7CAGNelj8pZZ5IMnMG7+LF6vRLWPE4ANLbBxRNnZa
   dMYYozOeWFrn86Av+JzHIchqUzG6HcN4irZJZYxVW6hxURomBFoSv8kB6
   5gI1w9hUZ6+rNJT3uhrLHgTK4NDAE3/LGSQmiOt6q7nc/+GF15yzfEZ4l
   A==;
X-CSE-ConnectionGUID: Bx5cFw9BSi63yMR+cBiT8Q==
X-CSE-MsgGUID: NALLxX9ST7CBGaOPVSMDbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732510"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732510"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:42 -0700
X-CSE-ConnectionGUID: J5qrRmD0SSap9cNFnezhOA==
X-CSE-MsgGUID: t4xAvQ2BQbqdrHWs4En3rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123056"
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
Subject: [PATCH v5 13/22] x86/virt/seamldr: Install a new TDX module
Date: Sun, 15 Mar 2026 06:58:33 -0700
Message-ID: <20260315135920.354657-14-chao.gao@intel.com>
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

Following the shutdown of the existing TDX module, the update process
continues with installing the new module. P-SEAMLDR provides the
SEAMLDR.INSTALL SEAMCALL to perform this installation, which must be
executed on all CPUs.

Implement SEAMLDR.INSTALL and execute it on every CPU.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
---
v5:
 - drop "serially" from the changelog as it doesn't matter to
   this patch
---
 arch/x86/virt/vmx/tdx/seamldr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index bb4aa6327eee..a64271f94aed 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -19,6 +19,7 @@
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
+#define P_SEAMLDR_INSTALL		0x8000000000000001
 
 #define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
 #define SEAMLDR_MAX_NR_SIG_4KB_PAGES	4
@@ -186,6 +187,7 @@ static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
 enum module_update_state {
 	MODULE_UPDATE_START,
 	MODULE_UPDATE_SHUTDOWN,
+	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_DONE,
 };
 
@@ -225,6 +227,7 @@ static void ack_state(void)
 static int do_seamldr_install_module(void *seamldr_params)
 {
 	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
+	struct tdx_module_args args = {};
 	int cpu = smp_processor_id();
 	bool primary;
 	int ret = 0;
@@ -243,6 +246,10 @@ static int do_seamldr_install_module(void *seamldr_params)
 				if (primary)
 					ret = tdx_module_shutdown();
 				break;
+			case MODULE_UPDATE_CPU_INSTALL:
+				args.rcx = __pa(seamldr_params);
+				ret = seamldr_call(P_SEAMLDR_INSTALL, &args);
+				break;
 			default:
 				break;
 			}
-- 
2.47.3

