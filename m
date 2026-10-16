Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC846D54C;
	Fri, 16 Oct 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141840; cv=none; b=NorpHuflynVuxpjhwIoafLGddLbq7unbPqQIJpEv1zf1RhP1fyHAg17kEHJUVxHSuBfZwqff2BaZ2YQQ3p4otyZ8mg6sXs4wM7BWGNCY2G3IfYs3SKRngChQk4u4Ka36NmyNepcfEL5PosrXeka7LTfsaWQXb6BsxYBaJN2IdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141840; c=relaxed/simple;
	bh=t7kZV/NP102JqCTi1GPnUaYoCMg3ix0YJ4NTPM+mV8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBhyZycKMy2LBqrg04cwU/BxFUMPGMiB7WWEsr9UlFa5gisWb+rXKapLRbe49tWw3urB1kjxLVvbXypPeyrn1UUgiDt9jzq4vmO/s2lvzuDQ8dCuV84sCz6A5JzhC8B0QNqDKNbeQFyCyMbyri1FdWcpi4sJ8GNxaZRYV5zrCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIoyHDPz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIoyHDPz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792141838; x=1823677838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7kZV/NP102JqCTi1GPnUaYoCMg3ix0YJ4NTPM+mV8Y=;
  b=SIoyHDPzDJZPvMUk3bGpPIUq+rPToEtrWTl/YubnpZ2KEJEICPvTXlXb
   kB4TFN0HYTni0fEgkxC7ZVSTklLjVqLgpx+wdi5hVuwvCbALocf56ntWZ
   mj1J9ybc7v5h9vR0T7tVA2yDnUzEkebdJ4T2yNOh/niw+9BreqCGTHZ8o
   bLz8uIK1QvRpEoM/LwspKA5H9Jc4Ci0fmMBmTSieBq4gBMZ5VEFytf9in
   2e8THkEA8OT2P0ljh6QGqEBRkNcdvK1tr7oBQoz9Zw7mz6GyOg3tU/RyA
   FX9CjWLbPR4DKNyASrVLj4nuoNDDOxySU/nWZav9gEZwt6k6NUVLnSGSU
   Q==;
X-CSE-ConnectionGUID: vRHruBAtRdW6oDl/FJ9w/A==
X-CSE-MsgGUID: /vqP/aKGSUuRlxRtUm5RvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="927145"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="927145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:37 -0700
X-CSE-ConnectionGUID: eoCvsTxbSfiKAbTCO4xUDg==
X-CSE-MsgGUID: C1Ua2bSETtaoPnz6OCZJLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1812570"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 02:10:35 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com,
	andrew.cooper3@citrix.com,
	nik.borisov@suse.com,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	tony.lindgren@linux.intel.com,
	kishen.maloor@intel.com,
	dedekind1@gmail.com,
	adrian.hunter@intel.com,
	binbin.wu@linux.intel.com
Subject: [PATCH v5 3/5] KVM: TDX: Add CORE_CAPABILITIES to the allowlist
Date: Fri, 16 Oct 2026 17:14:20 +0800
Message-ID: <20261016091422.3182216-4-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
directly configurable CPUID feature bits to accommodate the legacy TDX
module definition of the bit, even though KVM doesn't support
MSR_IA32_CORE_CAPS for TDs.

Older TDX module specs define CORE_CAPABILITIES as fixed-1, so userspace
may expect the bit to be set for TDs.  The bit is redefined as directly
configurable due to #VE reduction.  Leaving it out of the allowlist would
prevent userspace from setting it once KVM starts validating the CPUID
input to KVM_TDX_INIT_VM, which would be an unexpected behavior change for
such userspace.

Reporting CORE_CAPABILITIES as directly configurable also lets userspace
detect that the bit is no longer fixed-1, and thus update its stale
knowledge.

Keep MSR_IA32_CORE_CAPS unsupported for TDs, as no existing TDX user needs
guest access to the MSR.

Note, CORE_CAPABILITIES is the only bit that is both unsupported by KVM
*and* redefined from fixed-1 to directly configurable due to #VE
reduction, and no further #VE reductions are expected.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v5:
- Clarify in the changelog that #VE reduction redefines the bit from
  fixed-1 to directly configurable.
- Change the shortlog from "KVM: TDX: Report CORE_CAPABILITIES as
  configurable" to "KVM: TDX: Add CORE_CAPABILITIES to the allowlist"
  since the patch doesn't change the CPUID reporting behavior yet.
- Add RB from Xiaoyao.

v4:
- Add #VE reduction related background to the changelog. (Kishen)
- Add RB from Tony.

v3:
- Drop the code for MSR_IA32_CORE_CAPS access.
---
 arch/x86/kvm/vmx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b6e096079655..13aaf7eb11b5 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -219,6 +219,13 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 		TDX_CFG_F(AVX512_VP2INTERSECT),
 		TDX_CFG_F(SERIALIZE),
 		TDX_CFG_F(TSXLDTRK),
+		/*
+		 * KVM doesn't support MSR_IA32_CORE_CAPS, but older TDX module
+		 * specs define this bit as fixed-1.  Report it as configurable
+		 * to accommodate the legacy TDX module definition, and to let
+		 * userspace detect that the bit is no longer fixed-1.
+		 */
+		TDX_CFG_INDEPENDENT_F(CORE_CAPABILITIES),
 	);
 
 	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,
-- 
2.46.0

