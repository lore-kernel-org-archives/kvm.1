Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D43C2770;
	Thu, 30 Apr 2026 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777580884; cv=none; b=SSBAzD1bDafP7sUTWfFDR5o1OZsYhQfgJoz0/ZwgdELuJeDQPaDTPRnXXa14nbao6Ae3y/KkWXYW99EVf+tzjK+C3Z+lZxM+KW6DeRFUyCXI1Fr4oe9eMob1Rjz95H7n2CDylVqODglZbK8moBBFC+Y0amKFLlDIcRgPC+QPnw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777580884; c=relaxed/simple;
	bh=jomTo8ULRF9A5DKW6Mw8BQ1xjcVBIxIeA+FHWs1aIkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUZdSaVV9tuc79StOlkrZEWIIQ6AHco/eged0FHamQyBVcrLZXSyFEZrfbr4bx32SrjJ6JBn5EJnT8eAOGyvOT0gBPQhFVEQIt3X79CM/aGYrp0ssVsm8Olj6qudNVnK2mTHh4CnXeBGRMGKKay9enrdMRxq4v9yTKL+AaNUHjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwGaA/u3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwGaA/u3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2C3C2BCC4;
	Thu, 30 Apr 2026 20:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777580884;
	bh=jomTo8ULRF9A5DKW6Mw8BQ1xjcVBIxIeA+FHWs1aIkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwGaA/u3qCfXVySR57ZzqS1+MjDZK+oaWbcrpyXGpqGVEYIE6oZovoZUohnArrr44
	 yGqAqaFKfwt/utONOLHsDi359C7lqgvuVzsq0Lm1qM4WvRAa5TRmLQiOrAY5DldfQp
	 a6w84OvJCU8e6ia0RJEeLd8QuIJRQ0tFnDwQDDsrvuVyEJQY86MqdU49aM6EJ50Upm
	 TaJLkAaUMiwOPT8TKvbWHjOZMW1hOAviV9UPwfkdFfY3QuZYVdiONHYeRuIsauSBm2
	 7YRCeuSvRykgD/PrPXvmilUeDDZnpUcYcJQ/YpB4lKguPX95ZuKhrOXMpvcu2FvuBA
	 3P4glocdeKnHA==
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
Subject: [PATCH v5 09/13] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU
Date: Thu, 30 Apr 2026 20:27:46 +0000
Message-ID: <20260430202750.3924147-10-yosry@kernel.org>
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

From: Jim Mattson <jmattson@google.com>

Now that KVM correctly handles Host-Only and Guest-Only bits in the
event selector MSRs, allow the guest to set them if the vCPU advertises
SVM and uses the mediated PMU.

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 902d7eb4a461b..b12c35b4fccbf 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -207,7 +207,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	}
 
 	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
+
 	pmu->reserved_bits = 0xfffffff000280000ull;
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
+		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
+
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
-- 
2.54.0.545.g6539524ca2-goog

