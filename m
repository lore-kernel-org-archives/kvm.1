Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DF2949E0;
	Wed,  6 May 2026 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032683; cv=none; b=OTnh4Rlk9+9o+jONWBOz7cn7sZeDtrHj1zvbuwaH/kS0iI843yS2T0i9ZXzm5w1lP4NHKEMpvEGs3Qe5L5xXZK1Ab7d1V9ZTQA82bzm4fxXax7PZdNeJgmhPXmCnhgtI0gVjCc4zYJM+ixJlQR8GwsVJTXfVskm3p9S5fksBabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032683; c=relaxed/simple;
	bh=443kmV2JABqO+wrTnYMBhbBvjwSW6NmQa1jp4Q2mwMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewusgr3Da8utZpCp4rdhVpQs0rst79nL8ahlTHv2veniaSGdbTUYJ0uUBRR0eQQ7YVXiIsz4KztDCn8sjwTh95dUZTGXhZVFyWa5HnA2k3W2u7TrSktIhvFTKG2aghYgJrqVaKxp1AaRaGr4Wrh6XNaTC3+5IGJAv9HXlzXxeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogj5zDMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogj5zDMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4B9C2BCC9;
	Wed,  6 May 2026 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032683;
	bh=443kmV2JABqO+wrTnYMBhbBvjwSW6NmQa1jp4Q2mwMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogj5zDMR1dyZAwlQyY2gthesC8Cv+VHcZ11BVBGZ/WNGGZeHM28FokG+T64LsU3J5
	 6w3sCXRKKF+O2P4Rib4W7m382T5oRzE2IJswPQ+HlQBsmELXFPoWJ4joDpxYLzvAC+
	 0E3OyfzhrveK92o2skjeZgmZD0OYerUA3KYNT2Z31LvG0m3aJnX+aYWSKWJ+GJhJMr
	 V7fyDd+ydZf6bltYJ6/2VaZG5k934tL9xuYd7HhQS7G0UzTP3ghCv0oB8l9FYPl0JX
	 AK5CoSxGOnIfjz1GPaSj0mQdUXtpf7C8EvxCaogQRLqXGx5tu8UB+PHBkV8I9h1NMF
	 UIIUB2HDlg6pA==
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
Subject: [PATCH v6 06/16] KVM: x86/pmu: Do a single atomic OR when reprogramming counters
Date: Wed,  6 May 2026 01:57:22 +0000
Message-ID: <20260506015733.1671124-7-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260506015733.1671124-1-yosry@kernel.org>
References: <20260506015733.1671124-1-yosry@kernel.org>
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

