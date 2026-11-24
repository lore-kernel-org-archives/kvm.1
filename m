Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557205;
	b=ydeUTMSS+FtqA21hAufLrdjigiORM2rKoa1PHk4tbSdQy02tmx7ZEki+rJiIIUzbYCwF
	 VmhLd7V+ueRa0AFRJY2jnD2hVXlogHnENMZAhb5eqNE0X5uX1pEcdohLtiPZZYuh8R7Lh
	 JF4PtggiUWR5RlOQO14lx6R3ad+VpdDasZQhaw6Srf3jgG9EpFJnfneUvkyQty0xGMwPZ
	 oItrqk5SXUPk3X7qs7Jiprs26/CrS0YdbF/W5qP7CfLP2NLMLbpsPepeo0bd5cgpfMoNs
	 5h9zqXq6uakD+ifaJYFVOOZEqZ+OBmeQbuQbGz7x4uNtxOcz+Hy2VjD5Ub/zLwbIEOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557205;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HtZkI43h8cfujaEfzuD6NUu3D2SfFoDYvDVNLgDvo8k=;
	b=G3dJ33CgLI8oP4qMfR4ZnxHULINc9OhfVbyvAg7ODpbF2VA03xefljUwSITtS3/xIjS/
	 B1CZZBRCxPDYEohaM7OUB/6gzy19vlBSAW2oQAgKby8/mrxRFV6EgsfKXQ840o41LSuHQ
	 Be9UAQWB70fDr5qdNmDvoKBs8bAAx5hh/BVu9Ikw+8An8J8BXA+yVLdNDd5tf/2v88kEO
	 1PdPUr9F8ig1MvOgaZ57vuHPECM+57uqCPIg/vy9J/A6Nj3cyovVsnc3mq6Qc544qeRVw
	 mkxHg1jh4IWA6kEavS8iycvi72S/vxrFaz8pyqi1fY0NnhynKfAeK3YcxzWHzWT2Sew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QOm1Lve1;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE14606A33A;
	Tue, 24 Nov 2026 21:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE14606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QOm1Lve1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557205; x=1827093205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BP7e9JqyMZe3zXkZnuNFBxpKPLrC0T9dqJsIOE+M69k=;
  b=QOm1Lve1BHyhZQ1OshfJL2QD9exu9PNnh2QsscmfJarVKFJfYChmwpq8
   g1rgZey1zrAlT6596nSr/OlTEHGYrCBMs+89VUr4HHoqT9dFws8IWkYFk
   2X/wSkUSbT6pU5uE8jCM1yvy6KvrDLMa9HVL2SgzstZ7jLYJZai/HMcs5
   /aWc4ecTYIDT+nx/MRmsBiEgl1x5OWnurG9F+1X2O3CNWEx4YfjAOjMUZ
   YS12ay90gFcwQr124lJen+UKuuLhL2GHmxJbFvT7ePIR2fzLpyBDzODFj
   mh3zT6YqPWoFVgkwHO8bJTpFtDCHM3QRRlVBq+RaygbBDQteAAdJOodh4
   A==;
X-CSE-ConnectionGUID: 6KOZeE9+SLi3lGyW3Y8czw==
X-CSE-MsgGUID: h14x5X2SRkaB++r010/A2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4305979"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4305979"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:23 -0800
X-CSE-ConnectionGUID: XQj4WDDPQY6gnz90DrBt0w==
X-CSE-MsgGUID: GYFJR7NGS8CPppOuFP22eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271894"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:22 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v10 02/18] perf/x86/intel: Do not inflate capabilities for guests
Date: Tue, 24 Nov 2026 14:38:45 -0700
Message-ID: <20261124213901.120572-3-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_broken_perf_cap() works around erratum RPL018 by forcing
perf_metrics on for RPL and MTL P-cores. When running as a guest, this
may erroneously advertise a feature the vCPU does not possess.

Skip the workaround when running under a hypervisor.

Fixes: 97588df87b56 ("perf/x86/intel: Add common intel_pmu_init_hybrid()")
Fixes: dd384d661f06 ("perf/x86/intel: Fix intel_cap handling on hybrid PMUs")
Signed-off-by: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v10: new patch.
---
 arch/x86/events/intel/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c76d9aa8e5eb..dbd84d82f36d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6163,6 +6163,10 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
 
 static inline bool intel_pmu_broken_perf_cap(void)
 {
+	/* Don't inflate capabilities when running as a guest. */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return false;
+
 	/*
 	 * The Perf Metric (Bit 15) is always cleared on P-core of
 	 * RPL and MTL. Details can be found in RPL018 erratum.
-- 
2.56.1

