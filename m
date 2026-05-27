Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B33D16F5;
	Wed, 27 May 2026 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925643; cv=none; b=FteetzO81qIYIaBAWEdYw6h/qKhv3uF3EHPwPRPAbWfVF75AyhEPB8WAWLSX4FQhOIcNLQCQnf9hN3rNotd5kZjXXj9t9s/Tw2fjeY+JO/LrTq/N7MndU4nsqS5lZDYZulKVydtwi8/IogQRxImQBbJ+JXVSWlWW81UehDuq8TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925643; c=relaxed/simple;
	bh=G/MiT6wcqobLrSddK4gBSbHHxNnlmJDSsQGVQLMbiZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAeGleFq/opjsAry1ZbKj1kAHEMLKk7gtnx+pU43OAAsOTv+3/MazDVL1u4Lplr7S9BPG2dD8zBuLXcrrB82NNzdE88sExe4vdIkXsKqDISdWzjNYZivNZkPZTy9XwWiNGV5qEhLqmKPzhMkiSaKc8j8U786VPRfoYo0lF0mOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EM6Bcuek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EM6Bcuek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006DA1F00ACA;
	Wed, 27 May 2026 23:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925641;
	bh=wRywIKLjaYBvGlLXm2ij6Kp5db8CtObLdxRCXVphEG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EM6BcuekQV9D2dWJru8TMMHyT+4yLm3ksJOSsCdFodM6krxvGb2cqPpcti2sy/Gwd
	 KRunu9SuPVuE4vUeXQ7QJ7L34iMglp84plFnASptpjopywbz6NlRQguSyH1VGqRdV0
	 ZwEyNHb7gz1LfSjrpFBPLao7H3N+6cEPHfz7H4nNz9vN3Wj+QiMcs0k1ZdjqnNMmXB
	 7xWqiCVCk9QVFZyaQ4FA9ue6SmQBx2hq7JDeMa06laUETHcicFaYiAEPN86A0IVq26
	 1doOYbkmsQIhPmsDXZXLA8oDYquVrXQbhgTdrL4WTxvjHzBaIQfdQhK0DT2jYyDXvo
	 ReJVNbusDRDHw==
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
Subject: [PATCH v7 04/17] KVM: nSVM: Move VMRUN instruction retirement after entering guest mode
Date: Wed, 27 May 2026 23:46:58 +0000
Message-ID: <20260527234711.4175166-5-yosry@kernel.org>
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

A successful VMRUN retires in guest mode and should be counted by the
PMU as a guest instruction. Move the call to
kvm_pmu_instruction_retired() after potentially entering guest mode,
such that VMRUN is counted correctly.

The PMU event will be matched against L2's CPL, but otherwise this does
not change the behavior in terms of guest vs. host, because KVM does
not virtualize Host-Only/Guest-Only PMC controls yet, so all
instructions are counted regardless of the vCPU's host/guest state. But
this change is needed for the incoming support for Host-Only/Guest-Only
controls to count VMRUN correctly.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 0063ccbd327bc..7456cacde296c 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1155,10 +1155,8 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (!svm_skip_emulated_instruction(vcpu))
 		return 0;
 
-	kvm_pmu_instruction_retired(vcpu);
-
 	if (ret)
-		return 1;
+		goto insn_retired;
 
 	/*
 	 * Since vmcb01 is not in use, we can use it to store some of the L1
@@ -1188,6 +1186,12 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
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
 
-- 
2.54.0.794.g4f17f83d09-goog

