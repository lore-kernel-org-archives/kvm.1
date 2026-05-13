Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD84CA274;
	Wed, 13 May 2026 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685118; cv=none; b=SqF3cF9BbAorD7ybyFit3zsjbskGyu5RnijuQzD9MSTcMkboazi6yrQjwIokXULqZAVeQHI+iq7Vuor1WNFjwu+eXsZShcPRgCqfdd8mjiH/MFF6QZFu4Pa03WuHWUTt48EGjm85SHEFqdh8V5hGZgHTX0X2gO/sfqXlb4GxNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685118; c=relaxed/simple;
	bh=Eaje9rcq+hNWK5XIn6HNCyCfWVyJ7d+TYb5MybZ0Uu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfYq9GzzYvSA5KGKck6Zz6fACty/768wKjOAq1WCAWHcGSNcCn0IpGTyjqMgfTJKQhcx//iapuNSOtkyoj7mHnSi2zGzj3gZdlzxOcbbYrukgdehup6cb8qoLdXAySigsW4ZNcvQDN/f5lHkzY2gp4LS76bW0KyuzgMttSyB5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOnKvi6R; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOnKvi6R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685116; x=1810221116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eaje9rcq+hNWK5XIn6HNCyCfWVyJ7d+TYb5MybZ0Uu4=;
  b=jOnKvi6Rn6MruN0xNNT7s9SBSI+SH93xUiCeFCTfPPl1ua5dLB8NMEhh
   o9E6cOQs5mYaRALXQuGK7d8bsIojI6zd5HFaqc1rd2fRRAeJGcokWtams
   x7dB/a8dVcUg/88jhwBwU/B5AtJoOdx7jdXYWJqKxFHw7hm1uoJrWKsA2
   YczVW9SEyvlBmi+Si6Sm/yEjMMFATgYxwxLMCZ6kfBTnwbnj3J3Ivg0Si
   xcESrww6i4nv0kv02R2h4vW0p5hleMY0s5Adk3929XUB9xMuXPxPMW9RS
   G5L2DRbonKvaK0VKLN9dTc/ZnOl4ECNfwuOmEXOpqz5RKl4c59Tjv4m0A
   A==;
X-CSE-ConnectionGUID: os09Oo15S6+iF4qa7WPO4w==
X-CSE-MsgGUID: aeyczR8TRyyW2iuXh9Nt4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921747"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921747"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:54 -0700
X-CSE-ConnectionGUID: zEljFDf8SDeyb7dsaZjTmQ==
X-CSE-MsgGUID: D0ta9n1cQY2UpGcBWjVwyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716883"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:53 -0700
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
Subject: [PATCH v9 15/23] x86/virt/tdx: Reset software states during TDX module shutdown
Date: Wed, 13 May 2026 08:09:58 -0700
Message-ID: <20260513151045.1420990-16-chao.gao@intel.com>
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

The TDX module requires a one-time global initialization (TDH.SYS.INIT) and
per-CPU initialization (TDH.SYS.LP.INIT) before use. These initializations
are guarded by software flags to prevent repetition.

After TDX module updates, the new TDX module requires the same global and
per-CPU initializations, but the existing software flags prevent
re-initialization.

Reset all software flags guarding the initialization flows to allow the
global and per-CPU initializations to be triggered again after updates.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v9:
 - use a global structure for TDX global state and use memset to
 zero the whole structure [Dave]
---
 arch/x86/virt/vmx/tdx/tdx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index da3c1e857b26..20b3b33e4677 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1271,7 +1271,7 @@ int tdx_module_shutdown(void)
 {
 	struct tdx_sys_info_handoff handoff = {};
 	struct tdx_module_args args = {};
-	int ret;
+	int ret, cpu;
 
 	ret = get_tdx_sys_info_handoff(&handoff);
 	WARN_ON_ONCE(ret);
@@ -1281,7 +1281,21 @@ int tdx_module_shutdown(void)
 	 * module can produce and most likely supported by newer modules.
 	 */
 	args.rcx = handoff.module_hv;
-	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear global and per-CPU initialization flags so the new module
+	 * can be fully re-initialized after a successful update.
+	 *
+	 * No locks needed as no concurrent accesses can occur here.
+	 */
+	memset(&tdx_module_state, 0, sizeof(tdx_module_state));
+	for_each_possible_cpu(cpu)
+		per_cpu(tdx_lp_initialized, cpu) = false;
+
+	return 0;
 }
 
 static bool is_pamt_page(unsigned long phys)
-- 
2.52.0

