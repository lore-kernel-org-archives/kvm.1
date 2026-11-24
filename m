Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557206;
	b=TFIxwONsYTbm3HeGPnS4uMWEUy4FwPMnwAryLaAtIVf6rv9M6tY8gvT81VUsuN2M/3rW
	 Af4pBOZiouvIW8CpfjkZuz6Hfim/WEvriFlaAKY7/v7Sk72gT2oOT2V8ALwmkgOSyMsI5
	 hwyWWlZt3Q1W5QyHDH1p9Sa0GgajkDno44meV3HZy2xi4QhUMEt6K6zQXlB3MyTlv5FVm
	 4tFDPCFGST/o3Uqq7IIlb8IY1+mpgxHqCEPd6y22WeJ/0emNGsw5zNmq9SUrq4ZL+kHdd
	 enA/SFdWk0Yu1BCGDcaC8OfzeR/17ym0yZPUv4GAzV9Rn+2zChfpOZWUhHxHNMhFWXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557206;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZTmew+ylFAd06hgt19LZqGaVOyDr1ZEPWAerw8v6tZE=;
	b=DMz0FSpDFDIyrYrOYFv9O1Z4c0cYc4Fp7ierXjTiXOPFmFG5mp5jjX2P13TYq6Tzgyyw
	 XFOXUKa38CmRDDR9h4vMOqIi/2ufkXoQXCIP+5+VNFZSj0DqygceusQfqeLxP4gq/s6aG
	 TcivhofD1t19wWwUdI6MdbpW2k/uiDOE5O43545AWibmKufqsr7vEZwaepJ9yuFrSjoLq
	 a8xnzcaz+S4JNLNB1tugRVk/moLsQt0adqQWebnvcEQ6zCX9Nf6NngZeFWpgloz8GhVQ2
	 TUilfIYufDmdQ4URzdGO5EblDkggauxTpre0L36OXPxNa6m8nmt5iLykbqWse7xTjlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mg8o2+bz;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743E606A680;
	Tue, 24 Nov 2026 21:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C743E606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mg8o2+bz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557205; x=1827093205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNG+kpI8bKzDjsT8cPNG2HlOU9qklwo2AtSTAwz7jNM=;
  b=mg8o2+bzVAs7OhXeAA0K9NYp9/Q0s3gi6jsMX+WyoLk8vLaAgEZxNd8s
   JhLj4rXRvt9ovY5JR/Crd268hESliW6tIQMUS4kFs94EaBL4emO3f0pIP
   QpfK6lkmjuRdnrL1cfd4PzK3BuMyia9bfhYl7az664EV6wf3//5mFjYEf
   9rCZnPuXtEjNcYnnu/2bkgvH7HgJwswxH4iLjyuvft8rk3ThOzCf+XUcY
   5c378w5u8Q+3Z7TRMHk24f1s8WMBXfLuzwUgwsW0yMYIYSNyUroYp12Po
   L8HJ4Ra2VkWfbkrejcgAxECSLBdUDw2UhDAlvdCPNf8J7V7x8y+Ekx3Zv
   g==;
X-CSE-ConnectionGUID: FXh8v8ALTn2zw4X7IEF1hw==
X-CSE-MsgGUID: 14cb88FNR9SSm7oxkFqbkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4305986"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4305986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:24 -0800
X-CSE-ConnectionGUID: um5LEYSpQfqgXm4b50+KNw==
X-CSE-MsgGUID: VrVQzimzQ3CSKPkgEwKv6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271898"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:23 -0800
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
Subject: [PATCH v10 03/18] perf/x86/intel: Track common hybrid capabilities
Date: Tue, 24 Nov 2026 14:38:46 -0700
Message-ID: <20261124213901.120572-4-zide.chen@intel.com>
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

Now that intel_update_pmu_caps() updates intel_cap on hybrid_pmu[],
the assignment in intel_pmu_init_hybrid() is obsolete and can be
dropped. Additionally, ADL P-cores report perf_metrics correctly, so
hardcoding perf_metrics for P-cores is not required.

Intersect capabilities across all online PMU types. This clears all
potentially inflated asymmetric features (such as rdpmc_metrics_clear)
from x86_pmu.intel_cap when the BSP is a P-core.

For erratum RPL018, set perf_metrics in the base x86_pmu.intel_cap
on all-P-core systems to keep x86_pmu consistent and allow consumers
like KVM to detect Topdown support.

Opportunistically fix a typo in the comment. 

Fixes: f83d2f91d259 ("perf/x86/intel: Add Alder Lake Hybrid support")
Signed-off-by: Zide Chen <zide.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v10: new patch.
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dbd84d82f36d..44bede63f0c6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6280,11 +6280,23 @@ static void intel_update_pmu_caps(struct pmu *pmu)
 
 		/*
 		 * Restore perf_metrics on platforms with broken
-		 * perf_capablities.
+		 * perf_capabilities.
 		 */
 		if (intel_pmu_broken_perf_cap() &&
-		    hybrid_pmu(pmu)->pmu_type == hybrid_big)
+		    hybrid_pmu(pmu)->pmu_type == hybrid_big) {
 			hybrid(pmu, intel_cap).perf_metrics = 1;
+			if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+				x86_pmu.intel_cap.perf_metrics = 1;
+		}
+
+		/*
+		 * For hybrid, x86_pmu.intel_cap tracks common capabilities
+		 * across all online PMU types. A bitwise AND is safe because
+		 * multi-bit PEBS/LBR format fields are identical across core
+		 * types when supported, or zero if unsupported on a core.
+		 */
+		x86_pmu.intel_cap.capabilities &=
+			hybrid(pmu, intel_cap).capabilities;
 	}
 }
 
@@ -7746,14 +7758,10 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 				     __EVENT_CONSTRAINT(0, pmu->cntr_mask64,
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
-		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		if (pmu->pmu_type & hybrid_small_tiny) {
-			pmu->intel_cap.perf_metrics = 0;
+		if (pmu->pmu_type & hybrid_small_tiny)
 			pmu->mid_ack = true;
-		} else if (pmu->pmu_type & hybrid_big) {
-			pmu->intel_cap.perf_metrics = 1;
+		else if (pmu->pmu_type & hybrid_big)
 			pmu->late_ack = true;
-		}
 	}
 
 	return 0;
-- 
2.56.1

