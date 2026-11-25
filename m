Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631230;
	b=iHEIxDu+xA31sDShq0MBhHwgxAblu3N1Zq00s+4afVypLoauRFbRNG2hpNhKfSy6IQCm
	 Ut1o1d/uPx8/pHIy7jrdImGV7vaukowzqRflm99IPYtFz9ViKU+ju8l2LImwgVjSywMmS
	 4RciVKZAborzins5pFxKn+irskOle4XIqrprOwIEL6jS9z9OW+nBDVY/HWmYyFlpyduBH
	 hPFCJ6Fa2QgnKs4b5+b3Jerwg0ayETjxQmow+zn5v14ycEIsi5hqv8qalGWNQB9KBWulX
	 PlH7k8+NlF106temCa0pZfd5Euq6usd28XoZlrKeMclOxzy7uRIXWPK8k3CIkx+Rj+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PNampHbyZurVq7cZQ3GYn0BQ21Y1ghiTk/1ymemcw+0=;
	b=YOjMBLOCL8GO4a0E6Kzn+80oR92BuIo1lAquTidTPAV1YWwwNxzzAeYWhEwFd5oqrWmQ
	 HubvC+er60ViX0aXhZZrthFoPQzNwdIwKistiQ0ZfXKR0gzGVGs42IGGN3tn5J3lCOie7
	 4/S6OPjAe4xrd5r/hOq3StvhUNj24WXWeT8BBG+sI9mrm8lle074ZUWJE1JCm2OfNQ330
	 ONiaRw6OG5JAj6GcoRngdSlv5Gb3UiDE90jlh9reZeKZP3SKvk8bcvbv1E+HeKTSG/wXL
	 kzJeU1mOZxN3bxhZJTWHsmb6P0cqHkqSdJ/2EiKl65sPj2urM0JiMOwF07NJEPWiDAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnj1efAU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B38606A688;
	Wed, 25 Nov 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnj1efAU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C171F000C4;
	Wed, 25 Nov 2026 18:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795631230;
	bh=PNampHbyZurVq7cZQ3GYn0BQ21Y1ghiTk/1ymemcw+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnj1efAUuo7wihnV51ofbmi/DjqPGWZhVhr793ZgIF68drgk68rNzSPXyZBEAz8I6
	 ruRtmX/SRsz6EINjQ0g+1zRNqkarIBFOPy6z+rZdwd9okpBi57Fe1Ry6gqoBV8wG0S
	 CEWq+vjm/69ZN28Z/VUNqSLR4Z2u0uvmrW8omEe9rxplWIl9lF3PHyDSRLPnaaLhVe
	 CEUwFSxsQt01ngb3RMKGQoAtsSxs5pfVIjCoOducdLLG6ox/21Uy+uBh3BP4jELAOk
	 YOufOrQpt5nSYsAjh/njjdHg8GNE6LbDuy4BiD6OhlSQ7XL8AagHd2+aA/pUUId5xU
	 EOVXDLcWT6y3g==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH 3/3] KVM: selftests: Set EFER.SVME via KVM_SET_SREGS in svm_pmu_host_guest_test
Date: Wed, 25 Nov 2026 18:27:03 +0000
Message-ID: <20261125182703.1694998-4-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
In-Reply-To: <20261125182703.1694998-1-yosry@kernel.org>
References: <20261125182703.1694998-1-yosry@kernel.org>
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

Extend svm_pmu_host_guest_test to set EFER.SVME from userspace via
KVM_SET_SREGS and verify that Host-Only counters resume counting. Switch
the existing filter syncs to GUEST_SYNC2() so the guest can select
between updating the PMU event filter and setting EFER.SVME.

Setting EFER.SVME via KVM_SET_SREGS exercises the __set_sregs_common()
-> svm_set_efer() -> svm_pmu_handle_nested_transition() path from
userspace (and specifically from KVM_SET_SREGS, where kvm->srcu is not
held).

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 .../kvm/x86/svm_pmu_host_guest_test.c         | 31 ++++++++++++++++---
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
index c5b5cd788d93f..3f743dbaf851f 100644
--- a/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
@@ -37,6 +37,11 @@
 
 #define LOOP_INSNS	1000
 
+enum sync_cmd {
+	SYNC_SET_FILTER,
+	SYNC_SET_SVME,
+};
+
 static __always_inline void run_instruction_loop(void)
 {
 	unsigned int i;
@@ -128,12 +133,12 @@ static void l1_guest_code(struct svm_test_data *svm)
 	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
 
 	/* Step 5: Set KVM_PMU_EVENT_DENY - all counters stop */
-	GUEST_SYNC(KVM_PMU_EVENT_DENY);
+	GUEST_SYNC2(SYNC_SET_FILTER, KVM_PMU_EVENT_DENY);
 	run_and_measure(deltas);
 	assert_pmc_counts(deltas, 0);
 
 	/* Step 6: Set KVM_PMU_EVENT_ALLOW - back to all except Guest-only */
-	GUEST_SYNC(KVM_PMU_EVENT_ALLOW);
+	GUEST_SYNC2(SYNC_SET_FILTER, KVM_PMU_EVENT_ALLOW);
 	run_and_measure(deltas);
 	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
 
@@ -153,6 +158,11 @@ static void l1_guest_code(struct svm_test_data *svm)
 	run_and_measure(deltas);
 	assert_pmc_counts(deltas, BIT(PMC_NONE));
 
+	/* Step 10: Set SVME via KVM_SET_SREGS - Host-Only counters resume */
+	GUEST_SYNC1(SYNC_SET_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
 	GUEST_DONE();
 }
 
@@ -174,6 +184,7 @@ static struct kvm_pmu_event_filter *alloc_event_filter(u64 event)
 int main(int argc, char *argv[])
 {
 	struct kvm_pmu_event_filter *filter;
+	struct kvm_sregs sregs;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
@@ -201,8 +212,20 @@ int main(int argc, char *argv[])
 		case UCALL_DONE:
 			goto done;
 		case UCALL_SYNC:
-			filter->action = uc.args[1];
-			vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, filter);
+			switch (uc.args[0]) {
+			case SYNC_SET_FILTER:
+				filter->action = uc.args[1];
+				vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, filter);
+				break;
+			case SYNC_SET_SVME:
+				vcpu_sregs_get(vcpu, &sregs);
+				sregs.efer |= EFER_SVME;
+				vcpu_sregs_set(vcpu, &sregs);
+				break;
+			default:
+				TEST_FAIL("Unknown sync cmd %lu", uc.args[0]);
+				goto done;
+			}
 			break;
 		default:
 			TEST_FAIL("Unknown ucall %lu", uc.cmd);
-- 
2.56.1.839.g22a8290db9-goog

