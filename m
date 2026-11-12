Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516232;
	b=aLaHA5a6QYthDXnoEDxo2WPlmKVOeFrQK4QJILTuG4kWAGJOeOw+9EPhBzYgF7fPfV71
	 q/vt96G3s3ZjE3t50Sw60iInIxIbRKUXhbR1alSCWirGKxu8vOnic8jTkkGi3d99Gmcyl
	 0TuNFZ3Iybe9fb1fWNPlFdHWI1DsxmkxCwzxRRJN6+623rD4dwxKm75xt+y0mcuGCVhHO
	 gWiX8UABjNBV7paHubCryD9YZEMMb2OvjKblPzAJ4I2/RZ1ualXdSesIwDJ1Bm/3sFIsz
	 UNvzkjMA9nu9x3P/uf+NPflDFL+PsijHsRbQlYSib7pyC2l/3shOWP5k79klSiqo0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516232;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fMGN1R2Zne7QQxFv0o3yqrZlMWOy4APf8vVKoRSWD+0=;
	b=00avxzP8THTY+p1AsBdnx5TcclSfIgLPfgJNm3Jwqw4FUXpZNA7pDCWQlaiM/Phg756x
	 s8VV8jT+uS8D0BC33lq3AQiUOawUz+rx8xKR29CThTTu3Ez4uwq/MU8qBd1iAc58U7TFG
	 eHP56Eh2G2tW0R/f9iYcpPoEeIqmiwq00o5p+Cv55sk5dIYwvaeSjeqyiL2yKvy8jLqTy
	 W8DZyj/Bxyf/WROpA+hbxAswtujKmnQJWwhPXzh46wZcags4KrToaD3KK1BI0vnyRbPxe
	 ABqGEIKyWPsbHOqX9W6zhkcdQ6ldvJn0xaibdCDz36IfIcm9qeMvmG/17MLh9tFy9mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G91MGtwD;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5389660A6F5E;
	Thu, 12 Nov 2026 20:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5389660A6F5E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G91MGtwD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516232; x=1826052232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5lU31ZelKLr1SKZ+pyZ0w5+jWxephymaqaseeS+1Pvg=;
  b=G91MGtwD+pJAkaULNXglfW3zqj2S53RMNzpLJL6OVISMPzqqwD+9dEZh
   fDFih9sBMMIQ2RS4QhkXHhk7TVEDTZGa1txu8hMf0yUjB7vZkqyDswKly
   87tJbT524o/uVvvEe5VaqAtbOGj8QjxA87IM0GyndPplUb5mCN+KJgqee
   pY2Vs9QdAA8TtuIYrCHKloJt0zM4GDQRFra0aBeWMvF9WBZKIEIhPqDog
   sPUOm9kWQbQMynS45Y4MmSWqB2cqKd15/WFyfqu3qSmoaY6NZDNiXFY/D
   jshauX5Ix9unuR8efVMLIRP5qrPhZjJm+nnJ95tPJ3iGvAuMv8b6l+m8r
   g==;
X-CSE-ConnectionGUID: pBcyFTKRQ3qo6G/kJFuqdQ==
X-CSE-MsgGUID: c5Z2CIcTQBCXFjVJu6QbFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192319"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:52 -0800
X-CSE-ConnectionGUID: aYZ2fpfUS5iLs+MOiTkXOw==
X-CSE-MsgGUID: fsiyOLm9Rxqz8CUwmz7GeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087937"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:52 -0800
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
Subject: [PATCH v4 18/21] KVM: x86/pmu: Mask only OS/USR bits when filtering fixed counters
Date: Thu, 12 Nov 2026 13:32:24 -0700
Message-ID: <20261112203227.289379-19-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112203227.289379-1-zide.chen@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
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

In preparation for supporting AnyThread deprecation and Fixed Counter 3,
mask only INTEL_FIXED_0_KERNEL and INTEL_FIXED_0_USER when updating
fixed_ctr_ctrl_hw in kvm_mediated_pmu_refresh_event_filter().

Masking the full 0xf nibble would cause two issues:

1. AnyThread for Fixed Counters 0-2: When a counter is allowed, copying
   the full nibble from guest-visible pmu->fixed_ctr_ctrl back into
   hardware-visible pmu->fixed_ctr_ctrl_hw would resurrect AnyThread in
   hardware, defeating SMT cross-VM isolation.

2. Metrics Clear for Fixed Counter 3: If an event filter denies Fixed
   Counter 3, clearing 0xf inadvertently strips METRICS_CLEAR_EN from
   hardware. If the guest sets METRICS_CLEAR_EN and executes native RDPMC,
   metrics will remain un-cleared, returning stale data.

This gates hardware counting without clobbering other control bits,
matching general-purpose counter filtering which only masks the event
ENABLE bit.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
v3:
- New patch.
---
 arch/x86/kvm/pmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index bd5954e62080..39fc3f72b92d 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -557,7 +557,9 @@ static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 			pmc->eventsel_hw |= pmc->eventsel &
 					    ARCH_PERFMON_EVENTSEL_ENABLE;
 	} else {
-		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
+		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX,
+						    INTEL_FIXED_0_KERNEL |
+						    INTEL_FIXED_0_USER);
 
 		pmu->fixed_ctr_ctrl_hw &= ~mask;
 		if (allowed)
-- 
2.56.1

