Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F703D6487;
	Wed, 27 May 2026 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925644; cv=none; b=TRwuaywgwzzRH9DB+PumsxIa2nhREm+wb6aiJskAoQV1ZTW1w85WyjVPxpl7fL2auH0Oi9mL9JTkoJ0ymnE1vSjjoJm0vp203ylINirE7rH+xU2if5goG9kyiw17phmKR9GeTChImmQPwdPN4PlyP7/s3MwBCaCRhWnvmukxkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925644; c=relaxed/simple;
	bh=ySStj5wTCcL5x3zBqamnC6pC0mLKKke+qmjS5ARZM+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urjZTkqBENDhcBt9intzdL0rPTMMDZybnTVVSGmZKyeK7TUcnVmN/Nx0pwLSK2AX6T0+RdmQb/pp2B82u1LdlCNYAkb7dg3wELTED92FNNnLiSintcWu6pQBzXwhiB2+RS0XhWhMInOBVSteRfzpU683Zd32JwZqYHlzYwAxaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnqYEMG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnqYEMG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0211F00ACA;
	Wed, 27 May 2026 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925643;
	bh=/4xqYTAetiwpn4T1YrIUcTJoj2l0gLO6N9btuBFDewo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SnqYEMG7g8wE3UZjMPzR4O6sLTT/HZVrX8R0GhYU3Vnq9yEqX0F3qAkH16sFAk3tz
	 OrgSagZ6hAIbcGxQQqeZjF69xgHYNW8Q7ChcNjqxjLTsCELPaXEZtgiwSfN8P5zUT9
	 rY/ip5NXghapEH13Vl+PoZohr+nomGh3sgM8HyvgFuhFoQJtOYEPszzH/hpFLGIXf2
	 scWVLda+lwY4XKvnoSTfu2ZpjltoyerbL2cyO0vseaefG9yKL+GNdB5UwR5eXiFspq
	 5k4xHIIrqMRa3pzgKNgDgAgr7MQyNNzISTkQdgloyYwiFyyl9p9IRgUpYRrUhqld4t
	 yCX3gw+Y5cZuA==
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
Subject: [PATCH v7 07/17] KVM: x86/pmu: Do a single atomic OR when reprogramming counters
Date: Wed, 27 May 2026 23:47:01 +0000
Message-ID: <20260527234711.4175166-8-yosry@kernel.org>
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
2.54.0.794.g4f17f83d09-goog

