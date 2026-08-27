Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421E38AC88;
	Thu, 27 Aug 2026 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800446; cv=none; b=R7jhpQLECLL1Lcp3fjWk/jdDsLkOmBH59aFvz/dot6J8AKjxOCIFw+nVEu8gVl4OC9N0pr8huv4YE2v81OsyUtuyTPBCgo54HK1y7OxwUMV/7MRVjhnn5DZ5fKVFUrQsDAGLXjVbC8JsHnQjJSFrWUc2FEFor7DWWhgrGvLs2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800446; c=relaxed/simple;
	bh=C7AG+FFJ4OjI97Ua5YzNJ5TTkUPgg7ctdaMgkiJfvGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WV58zXPtPxJqnSU8C1h6d0dKxUIje3hLLA88ym+l0+1gPCocmvPQMQNOrKbrQ7wBzQG41Hu0O50nVSyMY5JBld6KfUF9aHrZHMOgIXG0+YSXyZazDfOFhLgyacPAIPpcW3nLprTC9Bfv7HXPBi/wMoajaZPUYOXYzjfa+C4x9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcTn263/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcTn263/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787800442; x=1819336442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C7AG+FFJ4OjI97Ua5YzNJ5TTkUPgg7ctdaMgkiJfvGc=;
  b=fcTn263/b0g7qtQcxqgXciMyvn8JraRv6FCC9r3gUL5H6NmjnE7T7jxA
   39EmJoZX4jnCNnQqEhapvg4eoQrLCxzlPoOLVW5rdfyWkJIEUi+MJ7cxv
   Lnrvt6U05c4ikIdIQkGG2BZqmP4r80wLXC4jr5268MDZ/QGNw0XDrp26F
   QVHytQ6qCGJdZIQovbYQUu8iyvm0quYErDtZzhI+PdhQaI+Izr5PFCymC
   Sc0Qbh1ugvHI4iswAQzn1y2wSB6Xwua2Swg7VrjZcuIRhc0n9hTV3hRo6
   UAc6F7AIxs7BfO4li27858DPFYuFRCBlzk8XaHa3Nten+f/h27RDL+pHO
   g==;
X-CSE-ConnectionGUID: HDyXIvinQluRq2qA7joKAw==
X-CSE-MsgGUID: SVuFLbGvTpqNb+bAZRSjHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="98964543"
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="98964543"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:14:01 -0700
X-CSE-ConnectionGUID: RIN6N52eTdaHiAuIDTkFYw==
X-CSE-MsgGUID: AV9OpNZ6TS+CHPeSuE8AwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,245,1779174000"; 
   d="scan'208";a="271264035"
Received: from litbin-desktop.sh.intel.com ([10.239.57.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 20:13:59 -0700
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
	binbin.wu@linux.intel.com
Subject: [PATCH v3 2/4] KVM: TDX: Report CORE_CAPABILITIES as configurable
Date: Thu, 27 Aug 2026 11:18:35 +0800
Message-ID: <20260827031837.2863609-3-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CORE_CAPABILITIES (CPUID.0x7.0.EDX[30]) to KVM's allowlist of TDX
directly configurable CPUID feature bits, even though KVM doesn't support
MSR_IA32_CORE_CAPS for TDX guests, to accommodate legacy TDX module
behavior.

Older TDX specs define the CORE_CAPABILITIES CPUID bit as fixed-1, so
userspace may expect the bit to be enabled for TDs.  If the bit becomes
directly configurable in a newer TDX module but is not reported as such to
userspace, userspace can no longer enable it once KVM starts validating
the CPUID configuration input.

Reporting CORE_CAPABILITIES as configurable keeps userspace able to enable
the bit across the fixed-1 => configurable transition, and lets userspace
infer that the bit is no longer fixed-1 so it can adjust its expectations.

Keep MSR_IA32_CORE_CAPS unsupported for TDX guests, as existing TDX users
have not needed guest access to the MSR, and advertising the CPUID bit as
configurable is enough for userspace to handle the legacy-module
compatibility case.

Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v3:
- Move this patch earlier in the series to avoid breaking userspace during
  bisection. (Xiaoyao)
- Drop the code for MSR_IA32_CORE_CAPS access.
---
 arch/x86/kvm/vmx/tdx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index d4a3a42cfd9d..b020518717ac 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -147,6 +147,12 @@ static void __init tdx_initialize_cpu_cfg_caps(void)
 		TDX_CFG_F(AVX512_VP2INTERSECT),
 		TDX_CFG_F(SERIALIZE),
 		TDX_CFG_F(TSXLDTRK),
+		/*
+		 * KVM does not support MSR_IA32_CORE_CAPS, but older TDX specs
+		 * define this bit as fixed-1.  Report it as configurable so
+		 * userspace can know the feature is no longer a fixed-1 bit.
+		 */
+		TDX_CFG_EXTRA_F(CORE_CAPABILITIES),
 	);
 
 	tdx_cpu_cfg_cap_init(CPUID_7_1_EAX,
-- 
2.46.0

