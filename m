Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE703D811F;
	Wed, 27 May 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925645; cv=none; b=pJXmqmfKzvBZewQOXRcVvHNSf7iFj+kH9gculSmyTtcC78XS4rOGza50AqONH8IpWbJdMtfe28qIFFR/HTsZ7YproYQ2/fNPkj1ORo7x2qKPnBZUavvlzQ+FMyRo9GYbWcoKo950SEGfwOWTbzL8RHm179n1Rnj+GiLQ6leA3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925645; c=relaxed/simple;
	bh=RH39PNn/B2K1ju7y7kb3Q9hqqhSA+ENKgCm8lSkjoDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZhBPjqjifYLJZqYcAJPXldj/gA84tctSjnByDA28EXm59vnp9/44VLmctl+w+AiGDZag9uTssMcdH0aoxlgsLVBOP5dFLf1v7/I13Xk7x260QaqDGSMMloaEiVqUNRl5M+d695yjmRrs3rPBdo+imcVyoAFdfhYEQ86oFXl8AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SklgLZYh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SklgLZYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E7F1F00A3D;
	Wed, 27 May 2026 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925643;
	bh=Q3xofZqOzvu5Onur3sOZTMIEKlsNXZMa7Z/7OwCz1yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SklgLZYh+Phi3oRi8jAtnZb88ZB3ZoukK8PiG5i+nvX/9z90vkE0eVip1Yb5KokXa
	 iJG7lJyEHWoq4x0ECRXUvkOidmeHIpgjpaHjZUYVB/nHfg0z7QYxDIVDhvPyH2Y/OT
	 YiX7yKiKrzhiBs6wT7/F1hZNgi3falAcR+039wqXlf1duHBK9SQONS2GjAAdgandT7
	 ZKDCs29/x1yrkQ/L5J+2+XDvEMMmXXUwKtCQ8ww1vQ6TYayft1YbSb38kQCAiC0Btf
	 Xok0e+p3j81Im4bwcOVEEiuV5R6Uw0GJzghnbM78WP0w9IJkBinyjTv/Et0locxJYh
	 V4vgYWIptN2Gw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v7 06/17] KVM: x86/pmu: Rename reprogram_counters() to clarify usage
Date: Wed, 27 May 2026 23:47:00 +0000
Message-ID: <20260527234711.4175166-7-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
References: <20260527234711.4175166-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename reprogram_counters() to kvm_pmu_request_counters_reprogram()
clarifying that it is more similar to
kvm_pmu_request_counter_reprogram(), and less similar to
reprogram_counter(). The kvm_pmu_* prefix is also appropriate as the
function is exposed in the header.

Opportunistically rename the argument from 'diff' to 'counters'.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.c           | 2 +-
 arch/x86/kvm/pmu.h           | 7 ++++---
 arch/x86/kvm/vmx/pmu_intel.c | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index d6ac3c55fce55..afbc731e72174 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -889,7 +889,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->global_ctrl != data) {
 			diff = pmu->global_ctrl ^ data;
 			pmu->global_ctrl = data;
-			reprogram_counters(pmu, diff);
+			kvm_pmu_request_counters_reprogram(pmu, diff);
 		}
 		/*
 		 * Unconditionally forward writes to vendor code, i.e. to the
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index b1f2418e960ac..f8286067722b0 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -210,14 +210,15 @@ static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
 	kvm_make_request(KVM_REQ_PMU, pmc->vcpu);
 }
 
-static inline void reprogram_counters(struct kvm_pmu *pmu, u64 diff)
+static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
+						      u64 counters)
 {
 	int bit;
 
-	if (!diff)
+	if (!counters)
 		return;
 
-	for_each_set_bit(bit, (unsigned long *)&diff, X86_PMC_IDX_MAX)
+	for_each_set_bit(bit, (unsigned long *)&counters, X86_PMC_IDX_MAX)
 		set_bit(bit, pmu->reprogram_pmi);
 	kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
 }
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 27eb76e6b6a03..9bd77843d8da2 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -391,7 +391,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (pmu->pebs_enable != data) {
 			diff = pmu->pebs_enable ^ data;
 			pmu->pebs_enable = data;
-			reprogram_counters(pmu, diff);
+			kvm_pmu_request_counters_reprogram(pmu, diff);
 		}
 		break;
 	case MSR_IA32_DS_AREA:
-- 
2.54.0.794.g4f17f83d09-goog

