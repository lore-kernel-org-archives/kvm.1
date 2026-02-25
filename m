Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB332279DA2;
	Wed, 25 Feb 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771981202; cv=none; b=krT0Uh9x59cUH99Ia8RrTko8u129NmMfYbiGsghTuNnU8TlhK3Cmbl3YMpTksQ27Jkqu1GNca6kR0UnYWFxN4Iy5HDX0WllTSQ9CjQ5UduUGjgjfTh5ZjilL0g6p7Niy9mPYw5euZaegdqQaqPuo9gG4JATW8r/basfIOrjwOg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771981202; c=relaxed/simple;
	bh=Zo5WU3kbA0CZiONRwgdIatjelZENz1f9HZ9OS+fG6GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2/EGi9HWMnJAQNEEO3ZMgvZCuC94DwrK9lbOqxPoACOHaKZ/UtV4IrY/ByOkRKbkwzYf50ZVSVPFVdCWM6JtAf78N5YBybFuHrz21+0fiqaaSnRSOh4j46CAEUnjUNWo0Bwp095HQIytCf1YCGvM6A+xihLa+gjUNQZ11HXOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGbBw/rB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGbBw/rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C83CC2BCB6;
	Wed, 25 Feb 2026 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771981202;
	bh=Zo5WU3kbA0CZiONRwgdIatjelZENz1f9HZ9OS+fG6GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGbBw/rBGyblcBUMPeKcnrDjf1klhwFZxsXxHXZCg2ywy+d/wQdzWNeScKbD0ac73
	 XKxPQRnPiW44yQGE1FP0fu7pTvKIynHEH7v/Mz0Eu0s78GodVyGYai4kG28pcMJiTr
	 lKKjqNxCpr5GBHtbERiUs2LBCT6VUmD99ywf7ej/dq7E7BnIVgIiJftRpe1PWk/bsO
	 i3hIruNdouRUz+cctAF6kv5QKizvAU7CpzjUSktaazE6kYi3fw5uuVfS/ziaY4Zqav
	 P/M0jCUABUqau+0grA/aiYsZ9X3/IBAX9smlo4uqusk8uhdcgGRP4Mm6MuBgztQlKU
	 M+2LqPK+TwJyw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 5/8] KVM: nSVM: Always use NextRIP as vmcb02's NextRIP after first L2 VMRUN
Date: Wed, 25 Feb 2026 00:59:47 +0000
Message-ID: <20260225005950.3739782-6-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225005950.3739782-1-yosry@kernel.org>
References: <20260225005950.3739782-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For guests with NRIPS disabled, L1 does not provide NextRIP when running
an L2 with an injected soft interrupt, instead it advances the current RIP
before running it. KVM uses the current RIP as the NextRIP in vmcb02 to
emulate a CPU without NRIPS.

However, after L2 runs the first time, NextRIP will be updated by the
CPU and/or KVM, and the current RIP is no longer the correct value to
use in vmcb02.  Hence, after save/restore, use the current RIP if and
only if a nested run is pending, otherwise use NextRIP.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 arch/x86/kvm/svm/nested.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 9909ff237e5ca..f3ed1bdbe76c9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -845,17 +845,24 @@ static void nested_vmcb02_prepare_control(struct vcpu_svm *svm,
 	vmcb02->control.event_inj_err       = svm->nested.ctl.event_inj_err;
 
 	/*
-	 * next_rip is consumed on VMRUN as the return address pushed on the
+	 * NextRIP is consumed on VMRUN as the return address pushed on the
 	 * stack for injected soft exceptions/interrupts.  If nrips is exposed
-	 * to L1, take it verbatim from vmcb12.  If nrips is supported in
-	 * hardware but not exposed to L1, stuff the actual L2 RIP to emulate
-	 * what a nrips=0 CPU would do (L1 is responsible for advancing RIP
-	 * prior to injecting the event).
+	 * to L1, take it verbatim from vmcb12.
+	 *
+	 * If nrips is supported in hardware but not exposed to L1, stuff the
+	 * actual L2 RIP to emulate what a nrips=0 CPU would do (L1 is
+	 * responsible for advancing RIP prior to injecting the event). This is
+	 * only the case for the first L2 run after VMRUN. After that (e.g.
+	 * during save/restore), NextRIP is updated by the CPU and/or KVM, and
+	 * the value of the L2 RIP from vmcb12 should not be used.
 	 */
-	if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS))
-		vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
-	else if (boot_cpu_has(X86_FEATURE_NRIPS))
-		vmcb02->control.next_rip    = vmcb12_rip;
+	if (boot_cpu_has(X86_FEATURE_NRIPS)) {
+		if (guest_cpu_cap_has(vcpu, X86_FEATURE_NRIPS) ||
+		    !svm->nested.nested_run_pending)
+			vmcb02->control.next_rip    = svm->nested.ctl.next_rip;
+		else
+			vmcb02->control.next_rip    = vmcb12_rip;
+	}
 
 	svm->nmi_l1_to_l2 = is_evtinj_nmi(vmcb02->control.event_inj);
 	if (is_evtinj_soft(vmcb02->control.event_inj)) {
-- 
2.53.0.414.gf7e9f6c205-goog

