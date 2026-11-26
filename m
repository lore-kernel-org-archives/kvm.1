Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795654119;
	b=MZNXIGfDJ0fwFr8+ahlf7z53FHsgkzZ79SojdU0u2K2GHNwRHFe/z4vkZfAfjJ7bhtE7
	 dC9gIwhyfBlmzd1m/ykLHMo9eeiDF3UHGnj/+M7jIISK2SpCnWm20cIFJx8zSO5twegCX
	 zMXtBFboZD5zkSFqStpcRI2NoiTLBwYsAQa7eJEt5TfZorLuvflHdZ8GssUyjBOHTz1S3
	 gdTykqqu+oX4expjkU7LJRKIROsvTWFDd1FXNu7R7TYZhmAzzWIIBN5HMPCjggvVsLD2j
	 c3oTe9sEDBJFqCu7DdnQDEIkFJBpMwA79YVB5KWssy5q0NjytjhCWVHFeJ82ivStAMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RMb1fbSrcTqw6OYahE1gTZIFMjBSinkZamkat5lrPTU=;
	b=yUi3XoY6bDmbryp5DX1WsAkKTgScmO/ZabKY4SSMwzijS8sSOxE2KMveQdm4sIFtHfz8
	 A0og2INVTqmAPOpcKejVHoSBZ1i+Q2Efu6lRHIZrzj0+7n6aya/odRBvDjOqskiWEQOVT
	 ZV57ObiWqAltNc0mGOG5EHFY05Hh7Hc8T2/JmloX1Ri6Jc/Dz849zeWW/YlTRf+OWkrsj
	 /U0qAw3zIRoz4Xs6qayc9DCbWITsRt+nv9EyMYwvs1+LFHYkIx6f+bs2KY1qUDutfx08c
	 dtcWfeBXY+rfBRmze493q7gkfJGnOP8X3LIMUC6gP0ftj5lAloDoRsGUzXsnK6QBdgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxPCsVhW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED843606A323
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxPCsVhW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD861F000C6;
	Thu, 26 Nov 2026 00:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654118;
	bh=RMb1fbSrcTqw6OYahE1gTZIFMjBSinkZamkat5lrPTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GxPCsVhWeyRg2skeUXRlCRpx9BbUT2dQneGKu+zbhvTQ+MSgFM03r3G0xfx7y/JUf
	 HnGLpwaYID3OwL64ry9F+Xwj7CHDh1GarBySBNU+8pQ0j95mkY+YbeAwWKorvCiH7+
	 fJBq4/Qhh4vvnJkT40b744mGpZ8VN5aGWEnJ0XbaQ6NO93vLONIhCGfroD1XdY1UUd
	 fIXPNfezidAtHT+NZCA3kyzMTYEs/mchNFjdbPKUTQtwHwHFjKe72oKDQflbYdK6SP
	 ltN49zIpfiBfizNdJ+kBqzRZ9GEsW+/9cFGj5eRVmNU3ddzdQMmg8aqVBuO+RnUPT2
	 QHC+0NhoxyKUQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 1/3] x86/pmu: Mask emulated instruction count deltas to the counter width
Date: Thu, 26 Nov 2026 00:48:29 +0000
Message-ID: <20261126004831.2712453-2-yosry@kernel.org>
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

check_emulated_instr() presets each counter to -N, N being the expected
number of instructions or branches, and computes the number of counted
events as "count - start", where start is -N as a 64-bit value.

That only works if the counter wraps.  The counter is only
gp_counter_width bits wide, so if it counts fewer than N events, it
reads back as a large positive value (2^width - N + delta), and the
64-bit subtraction yields 2^width + delta instead of delta.  E.g. a
48-bit counter preset to -22 that counts only 10 events reads back as
0xfffffffffff4, and the difference is 0x100000000000a instead of 10.

The "==" checks still fail in this case, but the ">=" checks, used
without GLOBAL_CTRL and on CPUs with the instructions/branches retired
overcount errata (i.e. all AMD CPUs), pass even though the counter
didn't count the expected number of events.

Mask the differences to the counter width, so that a counter that didn't
count the expected number of events fails the ">=" checks.

Fixes: 20cf91472daa ("x86/pmu: Test PMU virtualization on emulated instructions")
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 x86/pmu.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/x86/pmu.c b/x86/pmu.c
index a54eb3843621c..db4198c2b64ae 100644
--- a/x86/pmu.c
+++ b/x86/pmu.c
@@ -736,7 +736,7 @@ static void check_running_counter_wrmsr(void)
 static void check_emulated_instr(void)
 {
 	u32 eax, edx, ecx;
-	uint64_t status, instr_start, brnch_start;
+	uint64_t status, instr_start, brnch_start, instr_delta, brnch_delta;
 	uint64_t gp_counter_width = (1ull << pmu.gp_counter_width) - 1;
 	unsigned int branch_idx = pmu.is_intel ?
 				  INTEL_BRANCHES_IDX : AMD_BRANCHES_IDX;
@@ -782,17 +782,20 @@ static void check_emulated_instr(void)
 	__stop_event(&brnch_cnt);
 	__stop_event(&instr_cnt);
 
+	instr_delta = (instr_cnt.count - instr_start) & gp_counter_width;
+	brnch_delta = (brnch_cnt.count - brnch_start) & gp_counter_width;
+
 	// Check that the end count - start count is at least the expected
 	// number of instructions and branches.
 	if (has_perf_global_ctrl && !pmu.errata.instructions_retired_overcount)
-		report(instr_cnt.count - instr_start == KVM_FEP_INSNS, "instruction count");
+		report(instr_delta == KVM_FEP_INSNS, "instruction count");
 	else
-		report(instr_cnt.count - instr_start >= KVM_FEP_INSNS, "instruction count");
+		report(instr_delta >= KVM_FEP_INSNS, "instruction count");
 
 	if (has_perf_global_ctrl && !pmu.errata.branches_retired_overcount)
-		report(brnch_cnt.count - brnch_start == KVM_FEP_BRANCHES, "branch count");
+		report(brnch_delta == KVM_FEP_BRANCHES, "branch count");
 	else
-		report(brnch_cnt.count - brnch_start >= KVM_FEP_BRANCHES, "branch count");
+		report(brnch_delta >= KVM_FEP_BRANCHES, "branch count");
 
 	if (this_cpu_has_perf_global_status()) {
 		// Additionally check that those counters overflowed properly.
-- 
2.56.1.911.g883d8bcb20-goog

