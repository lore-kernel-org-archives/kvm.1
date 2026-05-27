Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36C83C9890;
	Wed, 27 May 2026 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925649; cv=none; b=tf9P6fc+gYe8xNUBo/5YZcGHNJujjiZAkBUsheD6FIACcuRMjGFtgXQaQcxl/j+66CIuhL5Ci86x36uE7zTkpgVVqsZnEkcaQy5Txz8tvfOB7kygEkZadOsLAsrKv9BQFeVhVYNC+VHZlwyLGKHzwWchWRc4gJZ4eTeMkO8+wUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925649; c=relaxed/simple;
	bh=V8BIKaq66vQ/UDXTvrEVR48q0FJMy+iJC3s2mvcGFUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/Hadp5z9P005Fu8oev0SRbPQJaFsZ5ufIWg3rKPJTSR10vlHX472n3Y5SzS4CVEUNZcBvXBXRW87pDxxahmD+ND6uinMLOzIGiBgVWAXPCtrrPE9XKSxdxsKSsmrSRU0XmgLObVV9e5ICC9JQzQt785GnVjPdKk2whLM1Vpd4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4ksVVrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4ksVVrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD91F00A3D;
	Wed, 27 May 2026 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925647;
	bh=dOoldtVY2Gku7aJgZIqdcLHChMYQnv835HrQuauIHFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l4ksVVrYveE+S77KquiOc6w8NBzalwBlMO69u/FCa+MFIDACDT40A74gyMaSsUV/V
	 wZpTE/C1TEg91ExPBCqGwRPs6UExqQjOxC0ZeRDzJ0cOv/h1DBLQv1jmzJ7y+TAjVS
	 M2QWm7FGTlC7onC98VUYFlWtC2qLY/C+veqpGRqKqzAReRE1lSGPRZZfYVRGhalQkN
	 m6Z+CtHWNmSkETzE0YDL0yFXCuokhrSkht4lonftbLiw5udazWII/gobvLswJiAfSO
	 MerwkzpFyPuneJIlBq9EdUF5hb/EU1RZEDldJ5OeU+j8CevDCIm+Lt33ZS1WbPaA5C
	 WomND3wfXEgiA==
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
Subject: [PATCH v7 13/17] KVM: x86/pmu: Allow Host-Only/Guest-Only bits with nSVM and mediated PMU
Date: Wed, 27 May 2026 23:47:07 +0000
Message-ID: <20260527234711.4175166-14-yosry@kernel.org>
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
2.54.0.794.g4f17f83d09-goog

