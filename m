Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDE5355F22;
	Fri, 21 Aug 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351467; cv=none; b=GGkl8uIEI8PWKjv4ryB2w7nKuUWXepxNLoNjCSb3DhJOqLfp9KK5C0wxQ6eneTcfMLCyx8QDljSeBzeiN/VUgUoW0yiL0P0wfT0ijfGRPIVlTIBvdlGuu64JgSZylEDE6Se7Y8UfeIUQJB+R9f5i+4Z5Ig8PXkla7CBXSuyqDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351467; c=relaxed/simple;
	bh=tDcts3H/AYcc95rlxKvj4w8Itq6g1Kg8MSLANJnSMMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al0vQvi8DKHIr5HOmEnrD3tztk7vqIEAZYAr9khnE6agGIw3nQasAeeaDnpeCD7hzF5XJb9h5zQpswRQ8H0Gdtq2Izz61T4wuNhvOeIx6gVG4r83ITNZb04RlDOlsSIlAMhCE3YiIn6EoRJ85ZI28PdtTAQXRLfrvvdp7mc9ITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ds6j4Ty6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ds6j4Ty6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351465; x=1818887465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDcts3H/AYcc95rlxKvj4w8Itq6g1Kg8MSLANJnSMMs=;
  b=Ds6j4Ty6HIFNJTLL8pnyw222Y0YS6rY31RTOa6Cr2cbOIwK4l9QK6qD8
   k52/utxmiViecO4Kva4ZXlPsNSolste/n7q0RXrSGzzzBSan00DhzxO4W
   gNsZ+roVE+EZZeDbySaHLJ2aIxt3ZV/Jdpp2nH7PbxnQeGNGf+KjH0Uw5
   MfVA2cCinF3+CCjyUVV9KaVw+RL0AIjBxb/ZmsQ89WdrF/7xT3sjUmHAL
   n33y2x7tNAbZEIaNoNMXLTIxY+FW7J/uzb7n2PicCtCue5glOXjktFXer
   0vTFHOjuyZMjZD9cEzIxVqgK1dZDyBcqYdwBeZ+LNucexEp1P06mJKk72
   g==;
X-CSE-ConnectionGUID: AjL2k+cDQ4aMbSCfkLDGQg==
X-CSE-MsgGUID: anQWelttRyOHHKWd4flXXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032635"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032635"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:50 -0700
X-CSE-ConnectionGUID: YAE6s+G+ShOnCdJgvGecfA==
X-CSE-MsgGUID: MGOxZFaXSi63/VPYXhjUIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679787"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:50 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH 15/23] KVM: x86/pmu: Relax MSR intercept policy under PerfMon masking
Date: Fri, 21 Aug 2026 15:19:54 -0700
Message-ID: <20260821222002.54907-16-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821222002.54907-1-zide.chen@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PerfMon mask is configured for the guest, hardware already
delivers #GP(0) on RDPMC for any counter or PERF_METRICS whose
corresponding PerfMon mask bit is clear, so KVM does not need to
intercept RDPMC, nor separately gate access in software, to enforce
the same restriction.

No changes are needed in intel_emulate_rdpmc(): the existing checks
already fully reflect the PerfMon mask restrictions for GP counters,
fixed counters, and PERF_METRICS respectively.

Similarly, guest reads of IA32_PERF_GLOBAL_CTRL are subject to a
logical AND with the PerfMon mask, and writes cause a #GP(0) if the
guest attempts to set a bit whose corresponding bit in the PerfMon
mask is clear.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/pmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index c447f32c1cb1..337d2f55a216 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -808,6 +808,14 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
 		return true;
 
+	/*
+	 * When PerfMon mask is enabled, KVM need not intercept RDPMC or
+	 * accesses to IA32_PERF_GLOBAL_CTRL, as hardware blocks or filters
+	 * out access to non-guest-owned RDPMC indices or GLOBAL_CTRL bits.
+	 */
+	if (kvm_vcpu_has_perfmon_mask(vcpu))
+		return false;
+
 	/*
 	 * Note!  Check *host* PMU capabilities, not KVM's PMU capabilities, as
 	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
-- 
2.55.0

