Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557209;
	b=km6HsWE06DIge4i6Vb5s4w8RpyL/eHt3rZ605oxtTyy2XBSZfAYQFuGiDaAUCK/Ega68
	 fGrdhfZ7XMm3/rTAwi1sHb3AkQkD/MIij582T7sRYKRppHtlg9HCQnm/ERhLgPEBwNUN2
	 gZNKPB2C06sBsgw8MRIza1hausQFsFVyrDMOWTpI/pshyCuSZqNHMzSzB5icDV69r/Xi6
	 dX6PnIdIeANiLJyqxSlo9C2Txnw/bjzbcjsx/nbts8uIUIXKwSWA6g/BKLjHJdiFY8QqE
	 e4C8IUbzfss62W1ma2Mq3bWJ1nT0dnjJNgk/9GLorkR83eeDNTDPwSySLRix5Yl4XgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HJFKT+3cEp/SIDOrK2IyT13IGiUZpBE5c4DPsZD9kcQ=;
	b=jA42KZOSojrGCw+AklgzqJWf+pdDPWHyLJ2nLCswOLbAyk32FP02vqoyGemhuJXOneE7
	 DrmnPh8vXtIaa/gJ8hjr2MGnEboCQkdZ+ceRfsrgZfnORAvZUwBnGyQ67jZOtc58bb4Q2
	 P34F5SzXElGlfx+mG01LHzoF8Kl4zGMz41z9M3rkNr+oFCwHMu6iRmivMlysMS+e62tql
	 xNkfsO93gOQN0vMGshf0FkIKu0nViAP4omfAkIpx10L3xb5/zaVV9zBCEW0JHkvjQDXaR
	 lNkS0XteghtpAArHfV3ttB0FwBriwVQkddNGPN9FDjurGJs2iVXx33LdQEQktSF5+kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WC80m0UO;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8960A261B;
	Tue, 24 Nov 2026 21:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A8960A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WC80m0UO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557208; x=1827093208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RlAWSRyBTrW8VrG0qB1GGkaT6pJ7br82MA0DK0V9CuA=;
  b=WC80m0UOO88Vfl4uPuaHyQkKxB16fsYe4pNj50lcbQPxDoQhfK69u30b
   s+nkxXFw4XyASZo1KayvlqAzPlRh7cF8QS8gIVA0a6xLccdxkYX3fd8e3
   lF3CkI4JQM14wF+CKXZKyw/qkM+CH/T0zv3OBjUuCBsgc/zxDi0mviuIU
   vn4/IqrqZfVKuIiWqyQkZqCdnrphRWmNIt6Xh8Tt393bj6RMzU+KY3Y6N
   wYNibw98V5xtPCnFfBtNkTorKIhOe35QOPGZahmnMvDVkFDHvN0ytDlRY
   g5Am/kvVfZ75JwJG341in6/KtIHc0GAU51BbF32SG7BAYb6MUndvpSH7T
   Q==;
X-CSE-ConnectionGUID: H7rFQpDKQBSZiv5UeZdcDw==
X-CSE-MsgGUID: +sURD0H7SHKd9CP21eXK0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306034"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306034"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:28 -0800
X-CSE-ConnectionGUID: 8eDY1IckQrCVKshOdXdMnQ==
X-CSE-MsgGUID: 9SynQOs9Tp+/5CVOIhY5jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271927"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:27 -0800
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
Subject: [PATCH v10 09/18] KVM: x86/pmu: Mask only OS/USR bits when filtering fixed counters
Date: Tue, 24 Nov 2026 14:38:52 -0700
Message-ID: <20261124213901.120572-10-zide.chen@intel.com>
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

In preparation for supporting AnyThread deprecation and RDPMC Metrics Clear
Mode, mask only INTEL_FIXED_0_KERNEL and INTEL_FIXED_0_USER when updating
fixed_ctr_ctrl_hw in kvm_mediated_pmu_refresh_event_filter().

Masking the full 0xf nibble would cause two issues:

1. AnyThread for fixed counters 0-2: When a counter is allowed, copying
   the full nibble from guest-visible pmu->fixed_ctr_ctrl back into
   hardware-visible pmu->fixed_ctr_ctrl_hw would resurrect AnyThread in
   hardware, defeating SMT cross-VM isolation.

2. Metrics Clear for fixed counter 3: If an event filter denies fixed
   counter 3, clearing 0xf inadvertently strips METRICS_CLEAR_EN from
   hardware. If the guest sets METRICS_CLEAR_EN and executes native RDPMC,
   metrics will remain uncleared, returning stale data.

Masking only the OS/USR bits gates hardware counting without
clobbering other control bits, matching general-purpose counter
filtering which only masks the event ENABLE bit.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v10:
- New patch split from "KVM: x86/pmu: Support RDPMC Metrics Clear Mode".
---
 arch/x86/kvm/pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index eef2f792dc9e..dba651d4e449 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -557,7 +557,10 @@ static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 			pmc->eventsel_hw |= pmc->eventsel &
 					    ARCH_PERFMON_EVENTSEL_ENABLE;
 	} else {
-		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
+		u64 mask;
+
+		mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX,
+					       INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER);
 
 		pmu->fixed_ctr_ctrl_hw &= ~mask;
 		if (allowed)
-- 
2.56.1

