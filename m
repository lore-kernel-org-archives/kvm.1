Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929841;
	b=lwDV2xKbjbewpOb0OHR6RqLLwWADPzosOLcQCY0sW1b0lB83n87fVvVHGxndSlPqjpJT
	 zvacGww+UjU/RAEXAxOwZLnobbcxNTMb4S4tnKK7rV96MQY14orgQDW4oVm8pd6XfAOgV
	 GWil4jA1Oi4/RKWij754ki8YoBNlLy2ZbmkLighaEEzLDyGGAZiNhp3ZRQEMB8YwjrS/G
	 mVlTmL1di6GXICA0QJVW4W7xNWztX4FbxCQhM3Xu5Yga/sghfypRdNfAOYRxRPbU3o5wQ
	 T+oiEIEbxcgTGxHjTygEgyaVGW1qyg9CisEuw430vgXT+FG/X2z69UxG6lCa9jFidHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929841;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OMpJBSulBkFqyrFQejcsGHZ1Oc2zY5q+OnIXOsS/O0s=;
	b=C+v9d3XzeRlNOElbi97KyxcHUnhwhYzGgI1LNBkd8zIKMgWy2EwKUWreZii4ho/F+R/2
	 ACJmZTWQWrwl3/E7z3vjjXVbZa0N63K0N0d23a23nWK857TrfumGPAPXwRLPwBmifbRfX
	 9EFX8DqBWP3niPeOBASVrqiHwFxtHHHAUmYzRJKRBtMbkiXGWY5RAgjsXYElqJDp3VgeM
	 ndAAysKfBkLCsexJ41BltP7rvll1pyH4mGabAD7AtAJ/H31c9eBrq3kHXCQIo/8cibZkN
	 o5lNSRMqfIqD0QVxwYd+HQWt7IxvQgijxzvE7sjhegx3WUuAYM1+CGX+/Ks2L1LjpnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XKWbtQOe;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03732606D834;
	Fri,  6 Nov 2026 01:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03732606D834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XKWbtQOe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929841; x=1825465841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VdAwz3NAdOY30FiVN69AeGpaVaZr+Nwa6A64T0MPzQk=;
  b=XKWbtQOeLRC1UZPo7G/Zr2TwTjRUAFU0ty1eqHAWEfmn0u+YQd5QfRI3
   EQUsO2zPmJ3wPWVRvZqBvgdNDuxDQgu4GogcNaNAvmHIjfGNFqUga//DF
   Gs8Qf4xn7klRyf3kW7OnzD28YzpRZbu1f36oyouJIKWQzGaiSld9z+7Bg
   ClswITX5VVXYNS45BmEF3iTfbqd3ZHE5vnzq8jdJdNgpg2tvGg3scXu+M
   GeOPGVqT+DK9A3hnMpZaW13qNrB+0DAzGaFMk4S3BMHjNn2v1FtPsjxgV
   ZJvtpi5agZ5AJ5gJ+ldV1tU5413/X5dzXiVp0ktG9oqOsSYz3GiNDGjmM
   A==;
X-CSE-ConnectionGUID: VVE6mGtmQfWGkHkd514PqQ==
X-CSE-MsgGUID: KUde3riVRfyZFN+s10P56A==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740207"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740207"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:32 -0800
X-CSE-ConnectionGUID: h0SBA05eSNu6O/z4ee1JaA==
X-CSE-MsgGUID: t25u7cvqRMK/QBOjCZBtkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067214"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
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
Subject: [PATCH v3 17/18] KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
Date: Thu,  5 Nov 2026 18:39:26 -0700
Message-ID: <20261106013927.166209-18-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106013927.166209-1-zide.chen@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

KVM currently caps the guest PerfMon version at 2 for all Intel
platforms. Now that KVM emulates the basic architectural PMU features
introduced in PerfMon versions 3 through 5, raise the guest PerfMon
version to 5. Features that require additional emulation support, e.g.
architectural LBR will be enabled separately.

PerfMon versions 3 and 4 continue to be exposed as version 2 because
KVM cannot safely virtualize AnyThread due to cross-VM information
leakage. PerfMon v5 is supported because it provides the
AnyThread-deprecated capability, allowing KVM to indicate that
AnyThread is deprecated.

When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
retains the existing cap of version 2.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Simplify version cap logic since mediated PMU already requires
  version >= 4. (Jim)
v2:
- Cap vPMU v3/v4 to v2, as AnyThread cannot be safely virtualized.
  (Sashiko)
---
 arch/x86/kvm/pmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index afb3e18a9879..f949fdbf359c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -175,7 +175,17 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
 	}
 
 	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
-	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+
+	/*
+	 * PMU v3/v4 has AnyThread support, which KVM cannot safely virtualize.
+	 * Only expose PMU v5+ for Intel mediated PMU, where AnyThread is
+	 * deprecated; otherwise, cap at PMU v2.
+	 */
+	if (is_intel && enable_mediated_pmu && kvm_pmu_cap.version >= 5)
+		kvm_pmu_cap.version = 5;
+	else
+		kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
+
 	kvm_pmu_cap.cntr_mask64 &=
 		GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
 	kvm_pmu_cap.fixed_cntr_mask64 &=
-- 
2.56.0

