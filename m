Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516229;
	b=5rDgFijcjBkZUnbrpn+eWMkaC1DhfAuIis1tWHpqy/CFSJt1fcRTWTg+yTXIFFxN0qL0
	 2n3rOlcrqN8vv+NeWpixboYL2NibjS4/NMPBzpqEOKrYco97LVBPLDOvUmP2Rlvnx6m4e
	 oKH5BEGzpkravVpIO+kvkCRE2UcyYTGUxrQRbMHrbg+UeH5DnnTRscRwf16QqaZTdsUUI
	 /mP8i/G3IVwHHRGP0UrYFo6hYfaJlo45bTETHJvW0uLl2RR46G1y9UQC6kighDOvL4hks
	 WA9y923NDWt9eANj2DOj8+H0l8Og3/anCKM/OvGWz/6edJ5DS/7DmLclEkTg9kTuJ0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T9BF9MbTocVN1xuC+XyiEeUpEyi3xrb6r55CdUVDfw4=;
	b=NZH5EwE8IuVJRlM8w9bvHU6ZUiJKTBYKh1aAMpUciWRCkKeFwNOIsVML8+Cw9heaqH8j
	 HyQbXfmVFZu739710UwEth5MKJBDzl+rfXAvNtG+jti6a/n549GUCDB6CWdS3KwdOEWxK
	 7V8OEiEbakthqR7xj6kevXYkk/2U1jkg+eftjn7qBAtoyQcKzwSRqqPI6L5se5CZDYiYh
	 6vVebjD1yjS9lOmGCVE1FzWGeMxAi7Il+jZ6rRFcjPdYgYEzAVSBJFgyCN4/Z6970J8+v
	 IpLy0dwW2a79zwyHyrs05Jjdg5qJA4rHieRlwtZLqqIi/K70hjMPtRGjvLhcub2tf3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UadNiXX3;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9243606A88E;
	Thu, 12 Nov 2026 20:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9243606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UadNiXX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794516229; x=1826052229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4c3etUsGVZuCOjPbIQGMxcrH8IgQ4fdoVx2/wSzMk6Y=;
  b=UadNiXX3x6O296BrCHGa4jSwFJOraFIcDiRsbNtAF1ugfAdA+PtwsIiE
   YB22Rb3dAwdra2cIeqtB2+RyAqriJ4qWFvp9UhQvLcGOJydQz4tmogOt1
   NTq0tERCav7paNmQjyWfnERUrSVfHVDur8fKtiUo6rQu9DeE/JIWT8w8n
   d+qNr4i6CY7Gu9AyJakvGAyYfZGHHNpA7kn3UbUSUlMsYrb0SJgOkHVO6
   dEkHcS3hDWdn6qRDUaEiSxnU15pUNBYsvattqj5z7AcPmRjyIw2EYRGFa
   E6RK3nPi6Ico7AqxjFcnxdgC0Dryqre4iYeKcaAYPkyDItsRmzlJLedNx
   g==;
X-CSE-ConnectionGUID: EV09b4oCTqeP43fvcSSEYA==
X-CSE-MsgGUID: NozM8WaHTC6of7/nNsw+nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3192238"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3192238"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:47 -0800
X-CSE-ConnectionGUID: 5jInnF1zQ3yiajkbbW/aOg==
X-CSE-MsgGUID: lXpwG+/lRde1gw///djJbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9087878"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:43:47 -0800
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
Subject: [PATCH v4 05/21] KVM: x86/pmu: Use pmc_exists in PMC lookup helpers
Date: Thu, 12 Nov 2026 13:32:11 -0700
Message-ID: <20261112203227.289379-6-zide.chen@intel.com>
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

pmu->nr_arch_{gp,fixed}_counters cannot represent non-contiguous GP or
fixed counters.

Introduce kvm_is_{gp,fixed}_pmc_supported() to validate counter indices
via pmu->pmc_exists, and switch the PMC lookup helpers to use them in
preparation for dropping nr_arch_{gp,fixed}_counters.

No functional change intended.

Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- Move kvm_for_each_{gp,fixed}_counter() and kvm_{gp,fixed}_pmc_mask()
  to the patch where they are first used. (Yosry)
- Move pmc_exists64 union to the patch where they are first used.
- Retitle to reflect that this patch now converts PMC lookup helpers.
- Do not carry over Jim's Reviewed-by due to above changes.

v2:
- Rename kvm_{gp,fixed}_pmc_supported() to
  kvm_is_{gp,fixed}_pmc_supported() and simplify them by removing the
  temporary bitmap. (Sean)
- Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter() and
  kvm_for_each_fixed_counter(). (Sean)
---
 arch/x86/kvm/pmu.h | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 090c9bbb74f4..fbab4f5c9181 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -88,6 +88,18 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
 	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
 }
 
+static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
+{
+	return idx < KVM_MAX_NR_GP_COUNTERS &&
+	       test_bit(idx, pmu->pmc_exists);
+}
+
+static inline bool kvm_is_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
+{
+	return idx < KVM_MAX_NR_FIXED_COUNTERS &&
+	       test_bit(KVM_FIXED_PMC_BASE_IDX + idx, pmu->pmc_exists);
+}
+
 /*
  * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
  * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
@@ -104,11 +116,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
  */
 static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
 {
-	if (idx < pmu->nr_arch_gp_counters)
+	if (kvm_is_gp_pmc_supported(pmu, idx))
 		return &pmu->gp_counters[idx];
 
 	idx -= KVM_FIXED_PMC_BASE_IDX;
-	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
+	if (kvm_is_fixed_pmc_supported(pmu, idx))
 		return &pmu->fixed_counters[idx];
 
 	return NULL;
@@ -168,9 +180,12 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
 static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
 					 u32 base)
 {
-	if (msr >= base && msr < base + pmu->nr_arch_gp_counters) {
+	if (msr >= base && msr < base + KVM_MAX_NR_GP_COUNTERS) {
 		u32 index = array_index_nospec(msr - base,
-					       pmu->nr_arch_gp_counters);
+					       KVM_MAX_NR_GP_COUNTERS);
+
+		if (!kvm_is_gp_pmc_supported(pmu, index))
+			return NULL;
 
 		return &pmu->gp_counters[index];
 	}
@@ -183,9 +198,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
 {
 	int base = MSR_CORE_PERF_FIXED_CTR0;
 
-	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
+	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
 		u32 index = array_index_nospec(msr - base,
-					       pmu->nr_arch_fixed_counters);
+					       KVM_MAX_NR_FIXED_COUNTERS);
+
+		if (!kvm_is_fixed_pmc_supported(pmu, index))
+			return NULL;
 
 		return &pmu->fixed_counters[index];
 	}
-- 
2.56.1

