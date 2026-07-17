Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E0245012
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784305754; cv=none; b=YUShiVqNbRNvVnMwo3Ss05X3Mi4k7jl9IAyncQt8LF96YwtuLcKH1GQVHI8p+dee2RLTnehNtQTS+NyMROoMpQbdIMp1phOFoLpeLhdKRMNxnQQ8mc9IqCk9hLq8Hxwz8q4jV5n5GKVFunW2FQMR8J5+39MX18XfS0ZDi96OGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784305754; c=relaxed/simple;
	bh=9MYW3bBbi2i/MCwaF0cxTgYpEofrRgFEczZ5M3urHG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAOqY1zFOL0P1svhrw266vA0+o4iTzGurRsANrLDIDSp06IE9kv1o7RKI7d6NSA+JBN8aUjr3ISa71zx3gGxz5ha57EwuopcCIeD1NAtnXgcac4nxJXTEzzE9d9gnwmgrZMEx01xUm0s3w/O+1Q8VEWNK/L+NY9Y/j98LuNbUS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzIkSGtG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzIkSGtG"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e7391839cso4223552a12.0
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784305753; x=1784910553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DEr5HrFCxcvmv99sNHbFWPBTdDmCHwXF9XTon2pDmFY=;
        b=nzIkSGtG/KFJn88dui1Hnm71LUJ8E3QjETs3TYCttY2qmnsKbyNnEmEQBzbmJPymuu
         aeGJTAdnl07nmvUkewvyjf5o4accKHfnSJ50VhgbWoMaLqYQ38DubIYC7ct+cyyqanQq
         K3OOeyC93ZqC6jlYQzlFew/MiqtppqdnVN6TxfDxNX5vlpvPm1KWW5Q4BqnNUlwkZV2Z
         vSWSnTgvYeovhCUKx6I9sBYZXn9E2fgk16gkCNuxP2a7g8aOZN2eTEFUe0xuBtfIDmtF
         xyzp9LQAS192M0kN2I8RkGTLyMxzmLpclT3BedfE8I68LSP2JWNpBDHj7YOS4Zlg0VhC
         SWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784305753; x=1784910553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DEr5HrFCxcvmv99sNHbFWPBTdDmCHwXF9XTon2pDmFY=;
        b=dyIdcOU74n99AY1YImgufKMfT+atews1ljBeDpYvRZw8/k2dJsy+rWpKuOAAZ0dQiv
         DoHIW2AHGeJFKX0AYUQnvodcRRrrjWVFs8WTxNEppXeBc1KIUYAOUCFgL1RJKPCCtzCe
         l5N6zThC7SGFlXnujOYekaONwPdbUVzm81FSaoYYjNwZhG1at1pnjDAt9r8DgoJzR9Sq
         RHsHaINHXWcy/8pNEfI3MOM+5bObPA5dN5uVPk47Y1Xa6Db3xxmulKKm1fzuumzDVZvI
         N4UJj3nezLrxsoqNVvlm4Se4ZLKs1kKEu8lSnFGrD8KU8xVfEfqEn+nDzeIWHaVDSUt4
         DEqw==
X-Gm-Message-State: AOJu0YwjVoYKH/suv8Rcb3lVTsLdoe72vgnx6riXrSw/oBxtptBqvIOl
	IlnaJi1f+MtFl5rYhSbE84mEbLp97rK7ARXzpU9UnkpM3pQ+X465kGZ0
X-Gm-Gg: AfdE7cn1z9fQN69nQz3gvG0fdy6PfL1326By4wPsEemogYaIfls1FaPbvLvO/ltmCyS
	ogZ7pbS9YMOf++fXw1rd/4InyawSG6cIMfytldkf6To+AhyOc08hlsihZS08/0+crIGYdQXf31Z
	WLWNPlBlvUiuU/K7M+EQO5tuKFEamZSuqJRRuUHjr4RBw9rUU04E1tuBDzEMOeHTCHTXfwgarCo
	/hcb+ZLUGeI8tfn5I3lco2x6gkC7E4utuZwh+xrqQM9U/VfyH7A6Dkht3sQmAddmPY3n4ZigKGZ
	zeWyLAzd/OGrZ+o6tx/47BPPhA3Za6V0s3jLTXgcS1/GUvcxYz1SeDzzMgaLE4hpcpfXHesNDJS
	RMhQXhPRkNfa8A3oHZ8aNl7FyaBpa+tPYMDYlrO05MW/yB60x7dKaCTIemAjX2RrLk4gQzDInRT
	IE0CizRiKIKvxygKuOtwtt8yfb1ndqaXdp2V1yJc8=
X-Received: by 2002:a05:6a21:6b16:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3c3ad5f55ccmr3830156637.10.1784305752399;
        Fri, 17 Jul 2026 09:29:12 -0700 (PDT)
Received: from fedora ([2a09:bac5:3aec:1a96::2a6:33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb6e8sm6363056c88.9.2026.07.17.09.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 09:29:12 -0700 (PDT)
From: Shivank Sharma <shivanksharma2376543@gmail.com>
To: pbonzini@redhat.com,
	seanjc@google.com,
	anup@brainfault.org
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Shivank Sharma <shivanksharma2376543@gmail.com>
Subject: [PATCH] KVM: selftests: Fix typos in x86 and riscv tests
Date: Fri, 17 Jul 2026 21:58:38 +0530
Message-ID: <20260717162838.1562808-1-shivanksharma2376543@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling typos found by an automated checker in the KVM
selftests for x86 and RISC-V.

Signed-off-by: Shivank Sharma <shivanksharma2376543@gmail.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c              | 4 ++--
 tools/testing/selftests/kvm/x86/hyperv_clock.c                | 4 ++--
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c                | 2 +-
 .../selftests/kvm/x86/vmx_invalid_nested_guest_state.c        | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index e56a3dd6a..20388f0b9 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -492,7 +492,7 @@ static void test_pmu_events_snaphost(void)
 	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
 	int i;
 
-	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	/* Verify presence of SBI PMU and minimum required SBI version */
 	verify_sbi_requirement_assert();
 
 	snapshot_set_shmem(snapshot_gpa, 0);
@@ -518,7 +518,7 @@ static void test_pmu_events_overflow(void)
 {
 	int num_counters = 0, i = 0;
 
-	/* Verify presence of SBI PMU and minimum requrired SBI version */
+	/* Verify presence of SBI PMU and minimum required SBI version */
 	verify_sbi_requirement_assert();
 
 	snapshot_set_shmem(snapshot_gpa, 0);
diff --git a/tools/testing/selftests/kvm/x86/hyperv_clock.c b/tools/testing/selftests/kvm/x86/hyperv_clock.c
index c083cea54..d5d779623 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_clock.c
@@ -56,7 +56,7 @@ static inline void check_tsc_msr_rdtsc(void)
 	tsc_freq = rdmsr(HV_X64_MSR_TSC_FREQUENCY);
 	GUEST_ASSERT(tsc_freq > 0);
 
-	/* For increased accuracy, take mean rdtsc() before and afrer rdmsr() */
+	/* For increased accuracy, take mean rdtsc() before and after rdmsr() */
 	r1 = rdtsc();
 	t1 = rdmsr(HV_X64_MSR_TIME_REF_COUNT);
 	r1 = (r1 + rdtsc()) / 2;
@@ -181,7 +181,7 @@ static void host_check_tsc_msr_rdtsc(struct kvm_vcpu *vcpu)
 	tsc_freq = vcpu_get_msr(vcpu, HV_X64_MSR_TSC_FREQUENCY);
 	TEST_ASSERT(tsc_freq > 0, "TSC frequency must be nonzero");
 
-	/* For increased accuracy, take mean rdtsc() before and afrer ioctl */
+	/* For increased accuracy, take mean rdtsc() before and after ioctl */
 	r1 = rdtsc();
 	t1 = vcpu_get_msr(vcpu, HV_X64_MSR_TIME_REF_COUNT);
 	r1 = (r1 + rdtsc()) / 2;
diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index c7fa114ae..5cc71658f 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -129,7 +129,7 @@ void guest_code(struct vmx_pages *vmx_pages, struct hyperv_test_pages *hv_pages,
 	/*
 	 * NMI forces L2->L1 exit, resuming L2 and hope that EVMCS is
 	 * up-to-date (RIP points where it should and not at the beginning
-	 * of l2_guest_code(). GUEST_SYNC(9) checkes that.
+	 * of l2_guest_code(). GUEST_SYNC(9) checks that.
 	 */
 	GUEST_ASSERT(!vmresume());
 
diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index a2eaceed9..a07968c16 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -81,7 +81,7 @@ int main(int argc, char *argv[])
 		    ARBITRARY_IO_PORT, run->io.port);
 
 	/*
-	 * Stuff invalid guest state for L2 by making TR unusuable.  The next
+	 * Stuff invalid guest state for L2 by making TR unusable.  The next
 	 * KVM_RUN should induce a TRIPLE_FAULT in L2 as KVM doesn't support
 	 * emulating invalid guest state for L2.
 	 */
-- 
2.55.0

