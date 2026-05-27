Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC7F3DFC94;
	Wed, 27 May 2026 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925647; cv=none; b=fAGSEuFvy8fzArQbvxqIA3cGBKI2u3tpDAm8Mkd6l36KP3f6FBCB2S7Z4uKyqdzvG5NP9thmlw0BY8Og//FakQKbVfEt7BlZV/dJsjE+lTXEgv4iyjxN+0lg46TsAWHGzJx44zZPajLRqWCNeQaS4UXLiVOxh+En7haBsV1GTLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925647; c=relaxed/simple;
	bh=1OjvkToNiF7PIOdJwlONk0WyJNtFLGgXSS4wYXS2+Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avMllXdoYI9zuMEYdILrwx2RmGFvRLLHDr2H0/tgIMOotg7hqeXiLgxGlV1FqZtCGqfioNF5cDWuCig2WBZxCBB8F3XII2RGRroMHnJiuYGd9kZiMIpc8zhsMe/NUsstcz5Uz1sWTWnrgM1V31hBpHqhz1gwTA6a2Ro5wB6EuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MszNCFk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MszNCFk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E884F1F000E9;
	Wed, 27 May 2026 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925646;
	bh=zIGTWLcUYHa8BBkPNoQV8lYXGIV+Jsa5WbC4uAOIHik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MszNCFk7zliXmge1CJbZmFYVg3RkpyNAnCWJbFtnVPOXn9fn+QbsQNqOK/eZ88R6L
	 gx+NfVQ96rNUuefgSfL5uvxVQgWw82Tew0/xZhi9q1bS3fb9AthQpiA037orE2Qia2
	 LqdSfy0L/dTKlgFndDc0sBpleL7KfXa9P1RTNVNgWaXPW+lNimGnYwBz7MqWNzRiLG
	 tFIcpYqNWJv+R1VerMDIkph3rnBvJc2y56RNgp1C2CjndJj315JU717WwadN48V7UE
	 hDkyJkD5oBHeubnRAEsxNzRx4GKYoj9Bh1PyHArs/CeJDz2y6PgOAbUJBsIx/4Mbc4
	 L8vzZy6xhwwVQ==
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
Subject: [PATCH v7 11/17] KVM: x86/pmu: Track mediated PMU counters with mode-specific enables
Date: Wed, 27 May 2026 23:47:05 +0000
Message-ID: <20260527234711.4175166-12-yosry@kernel.org>
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

Instead of always checking of a counter needs to be disabled for
mode-specific reasons (e.g. Host-Only/Guest-Only bits in SVM), add a
bitmap to track such counters. Set the bit for counters using either
Host-Only or Guest-Only bits in EVENTSEL on SVM.

This bitmap will also be reused in following changes to selectively
apply changes to such counters.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/include/asm/kvm_host.h | 2 ++
 arch/x86/kvm/pmu.c              | 1 +
 arch/x86/kvm/pmu.h              | 9 +++++++--
 arch/x86/kvm/svm/pmu.c          | 6 ++++++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0f3cbf9fc1ae1..32a413182a751 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -615,6 +615,8 @@ struct kvm_pmu {
 	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
 	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
 
+	DECLARE_BITMAP(pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
+
 	u64 ds_area;
 	u64 pebs_enable;
 	u64 pebs_enable_rsvd;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 8159b07e9bc20..84c834ad2cd47 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -936,6 +936,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 	pmu->need_cleanup = false;
 
 	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
+	bitmap_zero(pmu->pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
 
 	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
 		pmc_stop_counter(pmc);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index cc7f55d4a78b4..34c3c6913ef62 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -202,8 +202,13 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 					pmc->idx - KVM_FIXED_PMC_BASE_IDX) &
 					(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER);
 
-	return (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) &&
-		!kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
+	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
+		return false;
+
+	if (!test_bit(pmc->idx, pmu->pmc_has_mode_specific_enables))
+		return true;
+
+	return !kvm_pmu_call(pmc_is_disabled_in_current_mode)(pmc);
 }
 
 extern struct x86_pmu_capability kvm_pmu_cap;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 41ee6532290e9..b892a25ea4ca9 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -168,6 +168,12 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			pmc->eventsel = data;
 			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
 					   AMD64_EVENTSEL_GUESTONLY;
+
+			if (data & AMD64_EVENTSEL_HOST_GUEST_MASK)
+				__set_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
+			else
+				__clear_bit(pmc->idx, pmu->pmc_has_mode_specific_enables);
+
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
-- 
2.54.0.794.g4f17f83d09-goog

