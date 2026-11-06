Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793929834;
	b=BIDn27ULQYEX1wuKXYeW6/yPAQTidXmg5jSm9o1fDrGeGzwwVcncFJojanw5nhpvRKGD
	 BUZNm/fL/wzz31YGgBuQbqCyHOSsdluTkjXIHKZd4xwOP6d3tAJuvSoDBVhsmZx57MfLz
	 Q0cr9FpHJcvBmsR7KVh2FbEocRWihEfs8/UZnUtzoNeHKZ5vvHmyUG9fjX59uiFkuDm1o
	 E9sdjrHbjQAbSUgm7UCu6BSnaJ091vIpgwi8+OwQg1Y584Ch4BF8L0nJgBiPlmbFsrO6/
	 QHcUDWQTRLVXlCjSJqqgGDFcdBP30ZYhQNa7H/TChLnwXdEKuhscOuvUQOuFw+nQCNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793929834;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L0P/AIwyg9rrBt9AKpocPfHXt7KBUvl+jRY4OOml8XM=;
	b=K0EisTNjQ0OieE3fWB/UnLTrxwVTDaYnk/AT39T61DX8I2lQpdu45aL374JssLCFQ3Jd
	 ccRloMEv8+G7lpReXZBw/HnW0e3xJuc2BL39cMIEjUq/I+a+Aeh0NECIpfX9/bbnffqux
	 AJb0KUpD2haZvqF/T++CiCE4aq4AAoBeQ5El/liEUQLs7Hm7zF6krXsasoNATkB5gExYY
	 pgb4bL39kVJy/kDJXrmQ1JaVAFSEvqMgkzFgqoY2lv9rhYTRsme2hpqTtShzVnfMCXF2g
	 aUG27sqaCorgtzTLBNCmbHuTs71y3hKBE9AiM+5wvUjmX5wHTcgUjbK93z/vneWzYHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIry+6yZ;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09B606A333;
	Fri,  6 Nov 2026 01:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C09B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AIry+6yZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793929833; x=1825465833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YVWLUKG8MIL2NJqzRY3H8YrX8VQ+HZA6G2J6gkJ601Y=;
  b=AIry+6yZZB7PZ0e1A7Vv+B68orPZAzNFN+puf8+0BkdPWvQQ4bjV/gF+
   7xTblFjzGA+VQnQcEi6Z64hmFvgRMKVYAa5ohNFw1PEJSRPDw6kE7pd3T
   rTzdeBnO7hIiAOEmgAS1Sob2F2w+iFgBjw9yd+vxCKlEuBmDJM9KPYIf0
   2AY7xABQXpeRwMTqLAJo/663hHPsO4w0yKYa1cqg8eLKNr/xnSaAyFKPV
   oEToQpYcqnMiq9Fb35P0aS4oebQvTPhrTUTgQ2fYRSkLWsHKyeYpYc+5M
   4eUYUCejt9ZpL/ydXF+FS4RStb2cUDW730Rd1EcpR3AUbL25rq+S80Zlz
   Q==;
X-CSE-ConnectionGUID: RhDwWQpGS9CP+gVW9Rrt/A==
X-CSE-MsgGUID: 7rQd1Ub8SB2BhV4MMqemtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2740136"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2740136"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 17:50:31 -0800
X-CSE-ConnectionGUID: 0SAgthxxS5Sw0qH2rADziw==
X-CSE-MsgGUID: fVX0xJHuTdyL6t3qoPqkQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7067181"
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
Subject: [PATCH v3 06/18] KVM: x86/pmu: Expose kvm_host_pmu to vendor modules
Date: Thu,  5 Nov 2026 18:39:15 -0700
Message-ID: <20261106013927.166209-7-zide.chen@intel.com>
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

kvm_host_pmu holds the unadulterated host PMU capabilities, which
can be used to compare against guest capabilities to determine whether
certain MSRs should be intercepted by KVM.

Exposing it directly avoids the need to introduce per-field accessors,
which would add boilerplate without hiding any implementation detail
worth encapsulating.

Opportunistically, fix typo "Unadultered" in the comment.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/pmu.c | 5 +++--
 arch/x86/kvm/pmu.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 6cd67f044b6e..b9c493c6db48 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -27,8 +27,9 @@
 /* This is enough to filter the vast majority of currently defined events. */
 #define KVM_PMU_EVENT_FILTER_MAX_EVENTS 300
 
-/* Unadultered PMU capabilities of the host, i.e. of hardware. */
-static struct x86_pmu_capability __read_mostly kvm_host_pmu;
+/* Unadulterated PMU capabilities of the host, i.e. of hardware. */
+struct x86_pmu_capability __read_mostly kvm_host_pmu;
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_host_pmu);
 
 /* KVM's PMU capabilities, i.e. the intersection of KVM and hardware support. */
 struct x86_pmu_capability __read_mostly kvm_pmu_cap;
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 016935c3a8ec..98e6f2443b82 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -252,6 +252,7 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 	return !kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
 }
 
+extern struct x86_pmu_capability kvm_host_pmu;
 extern struct x86_pmu_capability kvm_pmu_cap;
 
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
-- 
2.56.0

