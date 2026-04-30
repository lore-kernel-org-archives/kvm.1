Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90663B6C08;
	Thu, 30 Apr 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580882; cv=none; b=OcVR4Ph7bF3aW/L1Nkm0VItF4f2oGHQaZ6NUmF6X1PvtTDRZd0GcuOjkLnJaq2pq4G2lC6gOW22RRr7MFGa33StHvQq6ewpxcPe/vdELaE1ppnagP77o3l7BvbGQLsjcLZE6J7iWynVJL5k0sg/AeOWEeRmY1c8ik0omPuKsxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580882; c=relaxed/simple;
	bh=cEJJ2WyrU/9RGR1OUnEPy2odZL0xSqI7NatJ9TETZUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rK6SC0A7h4VVAcoezdGmSEi1SVuQz4DrFoGLraoy4/t6gEF9CYhxFGowXe3y7R4oG1FqAS+3OA30YCg5lJdnfhhtbRTw+iLL+Yy9rAj+UD4sdhD5Kjj+NCQynmMbP5U1zAB7CR6wafbmFJemLmZHXE9S5Kkf8jQJlHUDo3DXugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJVMt+0n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJVMt+0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0ECC2BCB8;
	Thu, 30 Apr 2026 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580882;
	bh=cEJJ2WyrU/9RGR1OUnEPy2odZL0xSqI7NatJ9TETZUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJVMt+0nsh8aXA4Nng9mp9Q2s4rtXm+K0yg13KpzVV1CHth5Io0XlgFQeOeffZK1j
	 WS88NvlOtL1DMKqbaYu26ZYA/71CuWhCr1seSLyZcU9BTY7mIXr+PRU4AJfo26RaZN
	 AcCe7ODlPoe1wlYCJU9LvUCQ4LGm9qmoiRBFxqoYI80q6a0i8PseNheW7gAK7BKGin
	 AiLuS2kJduBDV+KDBdqO5Q7xlMk0mXNUcuAzpa+6vxc+fAV54Ct1Dv5pcxV/E2mzJU
	 K12o6aGBxfeG5DJSdFBaU1ABD8CkzgmcXbnkWt3Tkhhx+cPHUMAhsczW9cqkjImekl
	 GwbZd5FFkCu9Q==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v5 05/13] KVM: x86/pmu: Rename reprogram_counters() to clarify usage
Date: Thu, 30 Apr 2026 20:27:42 +0000
Message-ID: <20260430202750.3924147-6-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430202750.3924147-1-yosry@kernel.org>
References: <20260430202750.3924147-1-yosry@kernel.org>
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
2.54.0.545.g6539524ca2-goog

