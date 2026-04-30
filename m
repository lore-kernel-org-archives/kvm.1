Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546FA3BB9E7;
	Thu, 30 Apr 2026 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580883; cv=none; b=gS1mpJAAPkLYTGJbE1TspoB7piHAP3Wp774LlrvhT3X27uak4AWcc+vjnKNee828WvRmoBGtjYruMViitZU4+Os1XrubwiXxNTZ6ljR2xYd/J9fs2wJTHUEeSEiltnBS6jUjq7HBozosJJj9+SgsLWmefyjiTX509GqQ6/W0bdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580883; c=relaxed/simple;
	bh=443kmV2JABqO+wrTnYMBhbBvjwSW6NmQa1jp4Q2mwMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZV+M6m3I5JSAuidnMDFMCYfA0YVleotgNVz5QY6gmWNvSxzsn3unn7MLKanTEwZngq6OcA7SffWeoFmz+WhZwgZjpD+bZpI6Hb1H6Q7UTC6c0D6+WWuCm3LELFzzJR7d5gex/MaJQlgkKWqySInCM52BHSmvSS2vrCtTyoeu0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml/M0TxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml/M0TxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69C0C2BCB3;
	Thu, 30 Apr 2026 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580883;
	bh=443kmV2JABqO+wrTnYMBhbBvjwSW6NmQa1jp4Q2mwMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ml/M0TxLnThzvMHsey0heeJkXv4/lsVGm1W7EXprDBb8gXb/IkdcyILWHlVE2/BZL
	 RgtfF+edhIhve0Uyrd7PFWwLb3T3Kvhq3GbTYpfgtVo+Z2B+mUIpqIC1cm+i651ULh
	 qxa3+mcHFhFPthDo1t6xsYXPg7vhn/awNmsPlrOTNCY+GAKmoVOZXVE1sa4ST8ZECk
	 vL/N8F6V2ehE8CPFu19MVx58tFfoVD7LnLEv3CUXKu/l5KXadwY83/vnLPmGaF4ZyG
	 QGhaOKkbXCNDMp8q1H0c/bqSpe4tUajin+7G4v4xSqOVrsIO3yTeKKl+p1wZ4f1pht
	 2/DWQ6JzF1DPQ==
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
Subject: [PATCH v5 06/13] KVM: x86/pmu: Do a single atomic OR when reprogramming counters
Date: Thu, 30 Apr 2026 20:27:43 +0000
Message-ID: <20260430202750.3924147-7-yosry@kernel.org>
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

Do a single atomic OR using the atomic overlay of reprogram_pmi bitmask,
instead of one atomic set_bit() call per counter.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/pmu.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index f8286067722b0..0e99022168a85 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -213,13 +213,10 @@ static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc)
 static inline void kvm_pmu_request_counters_reprogram(struct kvm_pmu *pmu,
 						      u64 counters)
 {
-	int bit;
-
 	if (!counters)
 		return;
 
-	for_each_set_bit(bit, (unsigned long *)&counters, X86_PMC_IDX_MAX)
-		set_bit(bit, pmu->reprogram_pmi);
+	atomic64_or(counters, &pmu->__reprogram_pmi);
 	kvm_make_request(KVM_REQ_PMU, pmu_to_vcpu(pmu));
 }
 
-- 
2.54.0.545.g6539524ca2-goog

