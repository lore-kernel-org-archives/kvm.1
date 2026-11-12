Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516233;
	b=iS8RAv+u4qNES12i4W4DsH83N6SbIOK0KM0x0UyUrE9n8taDCrXthYTJvGnaFBQUj7EY
	 mzKJsI8Faj1ehQ3V7P6nt2tkIRrrlIC5E6VAFuLcPtAjfvqf5zpUMEmpcyAexyxMLgxI8
	 yXjyxMiUeeGRYdZyElEoa/Og53rhbRRKsGJj7UFdJLUixO2njem75vkzPLMxjuSCpsV/+
	 wHLwObWDpz68w8QstifB/aP0tozyKUFzBsUOxzgzq5CCLIySntxEuWT37n+N97ZOx+gez
	 I7kN22mlBd19aUZzx3NT3rcbSCYhqfUP2lsAe/DSDDkRxQkllJ45e178ch0ZufdW+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BKyCixUwSDIl+QpToE4IrR4fhUODa76FLWdRkgjQn2o=;
	b=u4+5cCgPXPs78zqwtEu8VBK5fT1EFz1DYX4DWW3a2te9Bp1bm93R1qFPdpGiRUAinLJU
	 XutNgx+1ZhrhV+jzocsEp6gyeYBSLA4cfRBAJoCmM7JfhOARBdFmZPprvtXcsgBcR1kbp
	 ab2DseSHGQxUXRHDvNIJCwV7pLQBQlNnt8NBvi6ercCgW8fKlKEs+PmVqrCrh2sqDPmjk
	 usV0BjqRdrXOgl3FHGrxWCUZ2QwL0XT6qYWgJAoWFKLdkY6gsBdZ8GF/7BpQPkMGbm+r7
	 r6MQ1Qrak+SMcGRI11uMPm7I+ru2jFhkmNAl28fvlm8i+V6ySDsoylA5eNJhtmvenyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DU+Fh+uz;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21F66070F99;
	Thu, 12 Nov 2026 20:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F21F66070F99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DU+Fh+uz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516233; x=1826052233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCOIvslnFKjewk4LTSgRHrl900PNWBuaD4bxZjViAN8=;
  b=DU+Fh+uzXMe47tAQa5B4Nmjbntk/Ui1EmWpzfhDAivUfnvNLXbxETNAx
   vn5hgNYm26JuS5HBQFmsvv4OOLK0pRoK0bjNpBesTcDiWe7dQlUQQCv5c
   cPxU6mhhGWl/k1QJDcG+Mr4ado0489IRXZcQ+HuD4noNym4ckUytrJOnP
   aBQTvDV418pb0mrJNG8Vmk/l4rBFcbN5QjhJxSHGF8FRVyo8kMTMMUYic
   r16A8P/RbSKdt25zz1rBKFcL2JmEbBmCAgqT/2bebGKfcCTcU4WH/OQZl
   B0ycnXNYtegGBWNUBZ9HOsXuXWukEHCDWseKr6x6GqzQtNnslhLJsNocg
   A==;
X-CSE-ConnectionGUID: wad4MkYrToOPY9aL29vHqg==
X-CSE-MsgGUID: LSUxr6qaTYeGvGQqkX5zHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192332"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192332"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:52 -0800
X-CSE-ConnectionGUID: pdD0Bxj/T6CbNYemns7/3A==
X-CSE-MsgGUID: hdzpDXtmTFyyQR9kZSJ5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087948"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:53 -0800
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
Subject: [PATCH v4 20/21] KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
Date: Thu, 12 Nov 2026 13:32:26 -0700
Message-ID: <20261112203227.289379-21-zide.chen@intel.com>
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
Reviewed-by: Jim Mattson <jmattson@google.com>
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
index 39fc3f72b92d..7b4137fbcb4f 100644
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
2.56.1

