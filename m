Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D719B3D34B9;
	Fri, 21 Aug 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351470; cv=none; b=j8Ga9BIqffgbcGPiJHpVwOxNyrLLVxOqhHOgP4DHPd8NB9oyA2c7z9V+35+ug2Y4hb+sctdumHRP0mb/Fm6hKJ5jfJ7EE0ij1KpnbAWy6utawe5B54UVbn2Q1woUfwKCa5a/11m36d3PawtupyMqoyXgXfTb3mbRuFwhPVpJau8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351470; c=relaxed/simple;
	bh=upuespX5CuZ22nzOyqZKJBfoV85lZn9Vv0+7Y2fIM80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEFxt9l8ig7uPv55M0d654Yg6NLujsjAv8Cvz8WIv+L3G3GxLuGgv4hoRUEHSQNc9WOv/uB1FQ631GLxKgQTxVfoXEPXMskpRbcbOVVwoDtIEyvqHYGJ0t888sLiwQ1jilIKRHAKKw5V82cORW/SzxgFJWI+eryfHzilGpQtG60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fnYa9cVg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fnYa9cVg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787351468; x=1818887468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=upuespX5CuZ22nzOyqZKJBfoV85lZn9Vv0+7Y2fIM80=;
  b=fnYa9cVgArQIXA3lrH/S1u2iFGYUwETOsY4gBQWAeH2TDpSI/aeFF/nH
   Hmj2/LDY08pdMDWXOzGU1R3+UP2kK2wVcBYNB2dHgi4+7X6ojnfVc6NAy
   W2PY1Me6L0LyE4zVeVF75fCwHd0FBz6duvL2MKqGQur/c9v3EIA58WaXW
   lRSF7NWO8osjqVk7paC1tyun/vClevEGrLw/RaCajAE8Gd0nzBdjm4++m
   Elb271lri4sz7N/4zJ2nKLThbEtegz3ct9MjZdKNo2SsdFxijAf76HNT8
   Pr7x2wIxwoWI2uqi9AtJLg0FUFXy/E2s1hsqKxKZmtcXJ9KcmH7WUKDMt
   A==;
X-CSE-ConnectionGUID: NVCQPbAHS8qfBn4t9nWAWQ==
X-CSE-MsgGUID: i4z/IiAWQYCrBwAx7LC7mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="88032656"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="88032656"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:52 -0700
X-CSE-ConnectionGUID: NxCwRNupQtai6cBsB/6vig==
X-CSE-MsgGUID: y1x4pJPmTgunX95JSC0MPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="271679807"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 15:30:52 -0700
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
Subject: [PATCH 19/23] KVM: x86/pmu: Always intercept GLOBAL_INUSE under PerfMon masking
Date: Fri, 21 Aug 2026 15:19:58 -0700
Message-ID: <20260821222002.54907-20-zide.chen@intel.com>
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

Unlike IA32_PERF_GLOBAL_CTRL, hardware does not filter GLOBAL_INUSE
reads based on the PerfMon mask at all, so always intercept this MSR
and filter out host-owned bits in KVM.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a241efb99b3d..2bd1ffe65510 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4339,8 +4339,15 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
 				  MSR_TYPE_RW, intercept);
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS_SET,
 				  MSR_TYPE_RW, intercept || pmu->version < 4);
+
+	/*
+	 * IA32_PERF_GLOBAL_INUSE reads are not subject to PerfMon mask
+	 * filtering.
+	 */
 	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_INUSE,
-				  MSR_TYPE_RW, intercept || pmu->version < 4);
+				  MSR_TYPE_RW,
+				  intercept || kvm_vcpu_has_perfmon_mask(vcpu) ||
+				  pmu->version < 4);
 
 	intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
 	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
-- 
2.55.0

