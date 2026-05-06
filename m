Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473530EF9B;
	Wed,  6 May 2026 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032687; cv=none; b=QD5sgcN/aFIhSXAeuP+Wdp8mXiW8i9ukU3sYFhBmHRGU1RF00UBVPKRZbl+lhTJhOxoBOf+WGWJOyUEQD6RmqTUc3f0S+ochHuftPBP86jcmAT4+GdCo1+I8eL/1l920E1jLF1HMRU+YrmPcckjRkKsmVfyVsm+kWzq/ShHq6h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032687; c=relaxed/simple;
	bh=gQNoIoPM8at1RTCuEi1IITPXgmkxHGtuc1LZwRLbNHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJq0P9GXoFz7Nrpc/CEEiq3aXwOhTQQq/NSaHXvF3HXDsCGmN+i6EaHiVXpctSmGUjlk0eDSVb5qBONxbF/oEX22pGCyh1xqIJ1kAlYsalIXNq0bQjNcbJytWBQo4KWcosyr+DtU4Bvj0CQnD027tn0YsoaQ9RTnYLdpNKWtRn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1JFoMhH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1JFoMhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8F2C2BCC9;
	Wed,  6 May 2026 01:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032687;
	bh=gQNoIoPM8at1RTCuEi1IITPXgmkxHGtuc1LZwRLbNHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1JFoMhHFFgF9mBAsyFYjuFjyJMDkf1ng1PQrWz64B2s2z7m+FvDeit42QQVt4uzE
	 MwVjJ5CZIMfpkKjiJjzy9JIubXuIcc/+wIUTPzzxhN7V13JTk1pZHfiNJ3wytyAckA
	 YRda92cIkLfhA31PVTZFcsc1oQkzZYxcLRaQ1/AzTGzdKqxd4oac+ee8lgFCzEL52u
	 H1gwOMqjxGvistYgr7Dt9G3wjgk3u8BpoH1g2kEfAAw4yN/a+5R5GDh3d6Vb7vZg89
	 +ZPcxiEAxLt6rvMXlugC5wBsDmSuj0A3yT2zzqTejs4c4oMrCuN+jBRSpwQdYfqPTL
	 CmbzKp/MgmqPg==
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
Subject: [PATCH v6 12/16] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU
Date: Wed,  6 May 2026 01:57:28 +0000
Message-ID: <20260506015733.1671124-13-yosry@kernel.org>
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
index b892a25ea4ca9..c18286545a7ac 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -213,7 +213,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
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

