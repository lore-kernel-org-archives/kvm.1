Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106452C1595;
	Wed,  6 May 2026 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032682; cv=none; b=BgrZCmdqeuk8D+jQHk7JlPrthS9t7F4g4rL8eYXxYXSrQ3CUVO61XlV3pnw2UtAuZ+Y5QHEv8TRvHvwNSJkMVYCB4tfPZdiTjeFKeiDp4Ccq1UIxuJC8GnVlxqjhTroKFyjUWHX/YL4d/Tn5PYd8Byc9pNBs1Pd3cPz4GMDK8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032682; c=relaxed/simple;
	bh=3VXogewOmNTOmXsw7CVdZC4grJsyIcf5O6wmSDCMd98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaPV9Y2Xtz4muC9FSgCYh8kVX8Iy3DGG2dwJbn10bXQRDet1SNDAL1AfkKHHCzMxHiIea2iUFSJpxoESc3+oTcxP2XkmPOSU4jjW3GjWPbjTHIhR8UQkcmguDqkY+uMUqrEg7ipQh8pNYdL3X7YZAjH2MdDxh8Ds+5t6HjZ2mhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GADWGPOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GADWGPOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476C5C2BCB4;
	Wed,  6 May 2026 01:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778032681;
	bh=3VXogewOmNTOmXsw7CVdZC4grJsyIcf5O6wmSDCMd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GADWGPOdXUuWQhvUgwzCvEKBVJHIZpnLomA9N6p2ixfLIjAWO6tP2a3COzDmuUaMY
	 76IiMgdLsOHJfcFuBbSmGkfH+zuZeH67i9qkJXcuaIQfmJ2Luq5GNeTbTy80I3IHGD
	 rVOBmWz+6EWDe2uYqKi9uOqgnL3kbTwVpaLy9SZjp/xYKb3aWpEP3qAGwnl8GtlD5u
	 Y0URpBPtyY8/sHwFSd/ThKr2GmI4pbduFIqlwfiWw79tyEyeXll/QQU6NuF/1c9JbE
	 dKng6tsisJO4MSiZ2udUrzITg3OWP12KQra1eCyfph5z28vP6eACl3Q7LKbMSb0RxQ
	 Hk0JiCjiKc4gw==
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
Subject: [PATCH v6 03/16] KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
Date: Wed,  6 May 2026 01:57:19 +0000
Message-ID: <20260506015733.1671124-4-yosry@kernel.org>
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

A successful VMRUN retires in guest mode and should be counted by the
PMU as a guest instruction. However, __kvm_skip_emulated_instruction()
is called before entering guest mode to advance L1's RIP to the
instruction following VMRUN. This is needed as the RIP is saved in
vmcb01 to be restored on VM-Exit.

Since VMRUN emulation is the only caller of
__kvm_skip_emulated_instruction(), move retiring instructions for PMU
purposes to its wrapper, leaving __kvm_skip_emulated_instruction() as a
transparent wrapper around the vendor-specific calls.

Note that this is currently a noop because KVM does not virtualize
Host-Only/Guest-Only PMC controls yet, so all instructions are counted
regardless of the vCPU's host/guest state. But this change is needed for
the incoming support for Host-Only/Guest-Only controls to count VMRUN
correctly.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c |  9 ++++++++-
 arch/x86/kvm/x86.c        | 11 +++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 0f6ea490d707b..58c78c889a812 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -30,6 +30,7 @@
 #include "lapic.h"
 #include "svm.h"
 #include "hyperv.h"
+#include "pmu.h"
 
 #define CC KVM_NESTED_VMENTER_CONSISTENCY_CHECK
 
@@ -1135,7 +1136,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		return 0;
 
 	if (ret)
-		return 1;
+		goto insn_retired;
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
@@ -1165,6 +1166,12 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 		nested_svm_vmexit(svm);
 	}
 
+insn_retired:
+	/*
+	 * A successful VMRUN is counted by the PMU in guest mode, so only
+	 * retire the instruction after potentially entering guest mode.
+	 */
+	kvm_pmu_instruction_retired(vcpu);
 	return 1;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 31dc48a8111e5..08be0a63b93bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9274,14 +9274,7 @@ static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu)
 
 int __kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	int r;
-
-	r = kvm_x86_call(skip_emulated_instruction)(vcpu);
-	if (unlikely(!r))
-		return 0;
-
-	kvm_pmu_instruction_retired(vcpu);
-	return r;
+	return kvm_x86_call(skip_emulated_instruction)(vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_skip_emulated_instruction);
 
@@ -9294,6 +9287,8 @@ int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 	if (unlikely(!r))
 		return 0;
 
+	kvm_pmu_instruction_retired(vcpu);
+
 	/*
 	 * rflags is the old, "raw" value of the flags.  The new value has
 	 * not been saved yet.
-- 
2.54.0.545.g6539524ca2-goog

