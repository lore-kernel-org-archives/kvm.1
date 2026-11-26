Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654119;
	b=QZr4adeX0aF9iUOBdV0V91U5Rk/x5na9+t99bSiHCEsaD/eUAKaRy/TFwiTwA3uMjACe
	 EVsHtS5YWMjofJhWwuo6JLj0KimFrdYB11cA1Hu8/eH+LTTH2tnEQRxQ4uDurbqmdMWhR
	 zmLR8ISemvGEWoa+PO9rm+6pdvuGP7BjKYh4V2LLuO7sBs9M9mISSbPGJZai+gFwieAkg
	 baboXjH0fMnjYaF3XW9QI0iO2VZhrwY59vh3K0hjHrMUxQONCaHtxIeDrVX7nbGY0OKU8
	 d+bFG33F+RX4dJMhuK+oRw9tcheGz5+WP2S93hudfRG0PVhDMWcLbh70XPnqTo7+UZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/WyPLTBGknmwe8eJ3NMjtwhXRdSaGrllf4Qm0YL+i6Y=;
	b=zcAuQIPyY02qP7CXX+1uYOu+0qf6guJHNfZthSYObIIkU/ToKHG/4yrQ6CR8BXX0F0/1
	 STpC6FXzxKR0ZTV1SvQk60fQSguLmCS/hmnjuid4saU2H1hFGbgbvbwFuSUtQ4vABNLbd
	 WGpMsT9n/Jp59TfLshvzUhHJzmpYfomrlHC+5OU2apQeDAh81uIaFLVsftkneF3t0RoW3
	 Ds+F6gk4dPUyBS5N21BraKPgmuoOcZZAkwnUexWFVx4Z1V94HI7Y5pQYhC7h2vb3LJwtI
	 iae3yc8n4dAxNYLafxdin5EGS1aZrDHCmGOG+QBJeEPW5ppspex+DKCr27iTRccAdzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1mw31Pf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B6606A331
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1mw31Pf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18981F000D0;
	Thu, 26 Nov 2026 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654119;
	bh=/WyPLTBGknmwe8eJ3NMjtwhXRdSaGrllf4Qm0YL+i6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C1mw31Pf10XftUHWltIvWB3+IOXu0DlBE+vrG/As3EzdpA82atWQ8UT0/QAObxzWr
	 3nAaDAMWRmkiz6PMnBSmZE7btvJSe7GpCbL6a6zeyTsXvNR7L8CTKjx4IxAesmTzcg
	 /VZy8ET3GUzLkq1SxMuEW3uEJWvWD8nXfhFQ4B391U8Onmrdpj5/6l9P0oLFxw4iZM
	 d6+a4bkC4NR41c2RQAHdrl48ArdSwpGXY4EpCBLrmvRXfZTvhaoizLAyhvayhEvaEs
	 Fy/dT+0YJ9efFoUQ8dEekuCkS6bQg4F3SZUwy9wlqUau0URR2FUh1SO5nj/q3MaTkA
	 uzpp4KGCfPVkQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 2/3] x86/pmu: Account for VMRUNs in emulated instruction checks on AMD
Date: Thu, 26 Nov 2026 00:48:30 +0000
Message-ID: <20261126004831.2712453-3-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.911.g883d8bcb20-goog
In-Reply-To: <20261126004831.2712453-1-yosry@kernel.org>
References: <20261126004831.2712453-1-yosry@kernel.org>
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

AMD CPUs count a successful VMRUN as a retired instruction and as a
retired branch in guest mode, i.e. every VM-Exit taken in the measured
window of check_emulated_instr() adds one to both counts, including the
10 VM-Exits for the 5 forced emulations and the 5 CPUIDs themselves.
E.g. on AMD Turin, the counts are 32 instructions (22 expected) and 15
branches (5 expected) with a mediated PMU, and 33/16 with KVM's
perf-based vPMU, which also intercepts the GLOBAL_CTRL write that
enables the counters.  KVM's accounting of the emulated instructions is
exact, the excess is all VMRUNs.

Since commit 7999ff1d28b0 ("x86/pmu: Treat all AMD CPUs as having
instruction/branch overcount errata"), the test only checks that the
counts are at least the expected counts on AMD, which always passes: the
measured window has 12 native instructions and no native branches, so
the 10 VMRUNs alone yield 22 instructions and 10 branches, enough to
pass ">= 22" and ">= 5" and to overflow the counters from the -22/-5
presets, even if KVM didn't account for any of the emulated
instructions.

On AMD, add the 10 synchronous VMRUNs to the expected counts and to the
presets, so that the counters only reach the expected counts, and only
overflow, if KVM retired all of the emulated instructions and branches.

Fixes: 7999ff1d28b0 ("x86/pmu: Treat all AMD CPUs as having instruction/branch overcount errata")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 x86/pmu.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index db4198c2b64ae..06d4992daf710 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -70,6 +70,12 @@ do {								\
 #define KVM_FEP_INSNS		22
 #define KVM_FEP_BRANCHES	5
 
+/*
+ * The number of VM-Exits, and thus VMRUNs, caused by the kvm_fep_asm() blob:
+ * one for each of the 5 forced emulations and 5 CPUIDs.
+ */
+#define KVM_FEP_VMRUNS		10
+
 /*
  * KVM_FEP is a magic prefix that forces emulation so
  * 'KVM_FEP "jne label\n"' just counts as a single instruction.
@@ -755,6 +761,21 @@ static void check_emulated_instr(void)
 		.config = EVNTSEL_OS | EVNTSEL_USR | gp_events[instruction_idx].unit_sel,
 	};
 	const bool has_perf_global_ctrl = this_cpu_has_perf_global_ctrl();
+	uint64_t instr_exp = KVM_FEP_INSNS, brnch_exp = KVM_FEP_BRANCHES;
+
+	/*
+	 * AMD CPUs count a successful VMRUN as a retired instruction and branch
+	 * in guest mode, i.e. the VM-Exits for the forced emulations and CPUIDs
+	 * add one to both counts each.  Account for them in the expected counts
+	 * and the presets, so that the counters reach the expected counts, and
+	 * overflow, only if KVM retired all of the emulated instructions and
+	 * branches.  Asynchronous VM-Exits can add more, which the ">=" checks
+	 * for the overcount errata tolerate.
+	 */
+	if (!pmu.is_intel) {
+		instr_exp += KVM_FEP_VMRUNS;
+		brnch_exp += KVM_FEP_VMRUNS;
+	}
 
 	report_prefix_push("emulated instruction");
 
@@ -764,8 +785,8 @@ static void check_emulated_instr(void)
 	__start_event(&brnch_cnt, 0);
 	__start_event(&instr_cnt, 0);
 
-	brnch_start = -KVM_FEP_BRANCHES;
-	instr_start = -KVM_FEP_INSNS;
+	brnch_start = -brnch_exp;
+	instr_start = -instr_exp;
 	wrmsr(MSR_GP_COUNTERx(0), brnch_start & gp_counter_width);
 	wrmsr(MSR_GP_COUNTERx(1), instr_start & gp_counter_width);
 
@@ -788,14 +809,14 @@ static void check_emulated_instr(void)
 	// Check that the end count - start count is at least the expected
 	// number of instructions and branches.
 	if (has_perf_global_ctrl && !pmu.errata.instructions_retired_overcount)
-		report(instr_delta == KVM_FEP_INSNS, "instruction count");
+		report(instr_delta == instr_exp, "instruction count");
 	else
-		report(instr_delta >= KVM_FEP_INSNS, "instruction count");
+		report(instr_delta >= instr_exp, "instruction count");
 
 	if (has_perf_global_ctrl && !pmu.errata.branches_retired_overcount)
-		report(brnch_delta == KVM_FEP_BRANCHES, "branch count");
+		report(brnch_delta == brnch_exp, "branch count");
 	else
-		report(brnch_delta >= KVM_FEP_BRANCHES, "branch count");
+		report(brnch_delta >= brnch_exp, "branch count");
 
 	if (this_cpu_has_perf_global_status()) {
 		// Additionally check that those counters overflowed properly.
-- 
2.56.1.911.g883d8bcb20-goog

