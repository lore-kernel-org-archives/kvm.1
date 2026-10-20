Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539950;
	b=AxoBnZBiu6b0ZcnKpgx5AGRCPP5c+Vsi3xnVhttR8X5LYwMYodVv7KGC6p1YuY72XsQl
	 C0pTpORFmqlYofZuY+O6flR7i16vjJAQ7iu3f3DokimKjeIdr4MBaqEA21iKWaTYYaxoM
	 Iwyj6oFJur8NDI8UQICNt5Y8VrDcFMRxVU/eMRq8fRZr17rxCapedSu9qamWOTufbnY1+
	 V2t2XFLYNyBPFqmoD6KWHznUFvuud/KLJyLjpnKC+a3pMH6mFZmahBt87m51C101Ys7aj
	 2/86BCJLcKqfi9oDbbwjTWZivQB7kQ4P8R5IgRScPJLwpvkARKzWsmqjvbM/oiW8NeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YEGdw3pKXaMUYTXJ7wX+CUT9vka2gOUaultJzDkOS+w=;
	b=KGeZfsCRb0cDBCZQnOdlBrqt+iJtrX2VzYDEl0rj1cDhrpiygzRGVKW1HC+CN1XO07Tu
	 nXtNDe7U3JQFtdkVZsejFp/076nR/J3909u31JkUqmWvtTyIZgIyBmuCICOAMHIf35FtF
	 q869rfydzncyLjAaLKhVE+fkYXg0poSQMLCxKB8OmOdIBvp5U7W1PJXne0f4LxfHiDVWc
	 11KmspQRvijTLhpd8W0/Uoo8rjPqztG4rkt9g5zPXXISr2+aXQ5/zz0UMth50oxDz20E8
	 F71ZVEuH8UUKxtI5DwOrNcAK3h3oWJlRwwE1infUWedB0ClEX3DiXFEUCjZrl6s2w4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FSkorMM0;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F7606A321
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 23:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 830F7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FSkorMM0
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so269916a91.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792539949; x=1793144749; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YEGdw3pKXaMUYTXJ7wX+CUT9vka2gOUaultJzDkOS+w=;
        b=FSkorMM07Od/RRtvJ+2SyAd9Jlv7qzW3os3KVctoV9c0IQMScIuWIOuSTvyBdyRQAw
         Em74+/L158IzoCAdLOMXKtEVmdT2eaT4gKB6WQ/gbgWlgCMSM+hTgLXdrjsvpnRCZp2D
         Vmp1KVkWXwIlWh/bU2oMiCaf7YpmPFMcA1YDdq02Yy89udZysTIYG+eSFcqIBrGlBXVT
         8dOSXA2DUsobJSDki+wKeG8nd5AM9S9nqvj2WmZPAtBYbwyI0rMu6nI9ZsImu9uDhMUm
         +tp+SI57VuIoCstmMZ+mSNcKDpq4w18adYVhvw+04z0OISbqp4c7Ew4t0C7OmySCl5vX
         MlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539949; x=1793144749;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEGdw3pKXaMUYTXJ7wX+CUT9vka2gOUaultJzDkOS+w=;
        b=BVI2Enakdjk7oR3HbXIUYiwVe1UIzHJ6955+nmzPWYb0C1XZ4cFwCV/9jO70L+YcUo
         wbAVA/GmMsDnRzQ158LqdZv/Pyy4B74rQhEl4dNf3GDw7MkmfcVFozHVi74YKDpxKi+b
         T88UOVJQk66YRV1QPbX7/5AsLPIRV/o8BU3Q4Ffa84477R8P2faPvre8Foz5JZ62AKmu
         VmkAGSUovvwW9idGOGQgaYOFODFRmF4iGPhMBj+Vt0p0hFVSgoWwF44LtUCP473liYiO
         0rusgTcHy1LHTAqS9o7EJqqWPyAJil604osJJ5R5KWBbm4uV5sbCN133W23S14jB9oJG
         WUaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbwjZgIsK5jQ6g+33qOtnz0S6uO4MoLbossol4SfFU87KcrDuzO7Y2gO/c4DsgCCEBkWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/6wwB5UnDw5vIR5/7haVl8h+HF2YJ0E/Ps++WJqXTXpGCOe0v
	IlkEWpsSpw9B/Oa+BqvaXQa8rbih6ioonEmv9VL+93uWXhOmBrmA/2phydC3P3twSgE9NEzMy/o
	eC8KXL6wtQeHVJA==
X-Received: from plbjx9.prod.google.com ([2002:a17:903:1389:b0:2ea:3bc:770d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:ba06:b0:3ad:870d:1bfa with SMTP id 98e67ed59e1d1-3ad870d1c45mr212842a91.23.1792539948705;
 Tue, 20 Oct 2026 16:45:48 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:45:30 -0700
In-Reply-To: <20261020234535.3182385-1-jmattson@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020234535.3182385-1-jmattson@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020234535.3182385-5-jmattson@google.com>
Subject: [PATCH 4/4] KVM: selftests: Verify MSR filter changes apply to
 passed-through MSRs
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Add a test to verify that userspace MSR filter changes take effect for
MSRs that KVM has already passed through to the guest.  KVM tracks the
desired interception state for some MSRs to avoid redundant bitmap
updates, and such optimizations can easily cause KVM to skip refreshing
the MSR bitmaps when only the filter has changed, leaving MSRs passed
through despite userspace denying access.  This is a regression test
for the SVM and VMX LBR MSR fixes that precede it.

Prime as many passthrough paths as is practical: disable APERF/MPERF
and C-state exits if allowed, request AMX permission so that the guest
can write XFD, and have the guest enable LBRs, set SPEC_CTRL, and set
XFD.  Then cycle through a sequence of filters that allow everything, or
deny reads, writes, or both for every MSR of interest, and verify that
every denied access (and only denied accesses) exits to userspace.  The
sequence covers every possible transition between the four filter
states, to catch stale state tracking from any prior state.

Add a new test rather than extending userspace_msr_exit_test, as the
existing test focuses on the semantics of individual filters, whereas
this test needs to prime KVM's on-demand passthrough paths before
installing filters, and then cycle through many filters on a single
vCPU.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/msr_filter_update_test.c          | 392 ++++++++++++++++++
 2 files changed, 393 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/msr_filter_update_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f43549a56f0b..9cefaf64809d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -92,6 +92,7 @@ TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
 TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
+TEST_GEN_PROGS_x86 += x86/msr_filter_update_test
 TEST_GEN_PROGS_x86 += x86/msrs_test
 TEST_GEN_PROGS_x86 += x86/nested_close_kvm_test
 TEST_GEN_PROGS_x86 += x86/nested_dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86/msr_filter_update_test.c b/tools/testing/selftests/kvm/x86/msr_filter_update_test.c
new file mode 100644
index 000000000000..9b9ba3fa398c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/msr_filter_update_test.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Verify that changes to userspace MSR filters take effect for MSRs that KVM
+ * has already passed through to the guest, i.e. that KVM refreshes its MSR
+ * bitmaps on filter changes even if its desired interception hasn't changed.
+ *
+ * Intel PT MSRs aren't covered, as KVM passes them through only while the
+ * guest is tracing (RTIT_CTL.TraceEn=1), which requires valid output setup.
+ */
+#include "kvm_util.h"
+#include "processor.h"
+
+#define ACC_R	KVM_MSR_FILTER_READ
+#define ACC_W	KVM_MSR_FILTER_WRITE
+#define ACC_RW	(ACC_R | ACC_W)
+
+struct test_msr {
+	u32 index;
+	const char *name;
+	/* Accesses to perform; never write MSRs where doing so is unsafe. */
+	u8 access;
+	/* Value to write for write-only MSRs. */
+	u64 write_val;
+};
+
+/* Stringify in the outer macros, before the MSR name is macro-expanded. */
+#define __MSR(msr, str, acc, val)					\
+	{ .index = msr, .name = str, .access = acc, .write_val = val }
+#define MSR_R(msr)		__MSR(msr, #msr, ACC_R, 0)
+#define MSR_W(msr, val)		__MSR(msr, #msr, ACC_W, val)
+#define MSR_RW(msr)		__MSR(msr, #msr, ACC_RW, 0)
+
+/*
+ * MSRs that KVM may pass through to the guest on Intel and/or AMD.  MSRs that
+ * don't exist on the host, or that KVM doesn't support for the guest, are
+ * still useful: denied accesses must exit to userspace regardless of whether
+ * KVM would have emulated or rejected them.
+ */
+static const struct test_msr msrs[] = {
+	MSR_R(MSR_IA32_TSC),
+	MSR_RW(MSR_IA32_SPEC_CTRL),
+	MSR_W(MSR_IA32_PRED_CMD, PRED_CMD_IBPB),
+	MSR_W(MSR_IA32_FLUSH_CMD, L1D_FLUSH),
+	MSR_RW(MSR_IA32_SYSENTER_CS),
+	MSR_RW(MSR_IA32_SYSENTER_ESP),
+	MSR_RW(MSR_IA32_SYSENTER_EIP),
+	MSR_R(MSR_IA32_APERF),
+	MSR_R(MSR_IA32_MPERF),
+	MSR_R(MSR_CORE_C1_RES),
+	MSR_R(MSR_CORE_C3_RESIDENCY),
+	MSR_R(MSR_CORE_C6_RESIDENCY),
+	MSR_R(MSR_CORE_C7_RESIDENCY),
+	MSR_RW(MSR_IA32_XFD),
+	MSR_RW(MSR_IA32_XFD_ERR),
+
+	/* LBRs: AMD LBR virtualization, and Intel's legacy LBR stack. */
+	MSR_RW(MSR_IA32_DEBUGCTLMSR),
+	MSR_RW(MSR_IA32_LASTBRANCHFROMIP),
+	MSR_RW(MSR_IA32_LASTBRANCHTOIP),
+	MSR_RW(MSR_IA32_LASTINTFROMIP),
+	MSR_RW(MSR_IA32_LASTINTTOIP),
+	MSR_RW(MSR_LBR_SELECT),
+	MSR_RW(MSR_LBR_TOS),
+	MSR_RW(MSR_LBR_CORE_FROM),
+	MSR_RW(MSR_LBR_CORE_TO),
+	MSR_RW(MSR_LBR_NHM_FROM),
+	MSR_RW(MSR_LBR_NHM_TO),
+	MSR_RW(MSR_LBR_INFO_0),
+
+	/* CET. */
+	MSR_RW(MSR_IA32_U_CET),
+	MSR_RW(MSR_IA32_S_CET),
+	MSR_RW(MSR_IA32_PL0_SSP),
+	MSR_RW(MSR_IA32_PL1_SSP),
+	MSR_RW(MSR_IA32_PL2_SSP),
+	MSR_RW(MSR_IA32_PL3_SSP),
+
+	/* Mediated PMU, Intel. */
+	MSR_RW(MSR_IA32_PERFCTR0),
+	MSR_RW(MSR_IA32_PMC0),
+	MSR_RW(MSR_CORE_PERF_FIXED_CTR0),
+	MSR_R(MSR_CORE_PERF_GLOBAL_STATUS),
+	MSR_RW(MSR_CORE_PERF_GLOBAL_CTRL),
+	MSR_W(MSR_CORE_PERF_GLOBAL_OVF_CTRL, 0),
+
+	/* Mediated PMU, AMD. */
+	MSR_RW(MSR_K7_PERFCTR0),
+	MSR_RW(MSR_F15H_PERF_CTR),
+	MSR_R(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS),
+	MSR_RW(MSR_AMD64_PERF_CNTR_GLOBAL_CTL),
+	MSR_W(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0),
+	MSR_W(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET, 0),
+
+	MSR_RW(MSR_STAR),
+	MSR_RW(MSR_LSTAR),
+	MSR_RW(MSR_CSTAR),
+	MSR_RW(MSR_SYSCALL_MASK),
+	MSR_RW(MSR_FS_BASE),
+	MSR_RW(MSR_GS_BASE),
+	MSR_RW(MSR_KERNEL_GS_BASE),
+};
+
+#define NR_MSRS ARRAY_SIZE(msrs)
+
+/*
+ * Accesses denied by the filter in each phase.  The sequence covers every
+ * possible transition between the four filter states (allow all, deny reads,
+ * deny writes, deny both), to catch KVM failing to propagate filter changes
+ * from any prior state.
+ */
+static const u8 phases[] = {
+	0, ACC_RW, 0, ACC_R, 0, ACC_W, ACC_R, ACC_RW, ACC_W, ACC_RW, ACC_R,
+	ACC_W, 0,
+};
+
+/* MSR filter ranges, which must cover every MSR in msrs[]. */
+static const u32 filter_bases[] = { 0x00000000, 0xc0000000, 0xc0010000 };
+#define FILTER_NR_MSRS	(KVM_MSR_FILTER_MAX_BITMAP_SIZE * BITS_PER_BYTE)
+
+/* All zeroes, i.e. deny everything in the range. */
+static u8 deny_bitmap[KVM_MSR_FILTER_MAX_BITMAP_SIZE];
+
+/* Guest-only: the last value read from each MSR with no filter in place. */
+static u64 guest_vals[NR_MSRS];
+static bool guest_val_valid[NR_MSRS];
+
+/* Host-only: userspace exits observed during the current phase. */
+static int nr_read_exits[NR_MSRS];
+static int nr_write_exits[NR_MSRS];
+
+/*
+ * Get KVM to pass through as many MSRs as possible.  Failures are expected
+ * and ignored, e.g. if the relevant feature isn't supported.
+ */
+static void guest_prime_passthrough(void)
+{
+	static const u64 spec_ctrl_vals[] = {
+		SPEC_CTRL_IBRS, SPEC_CTRL_STIBP, SPEC_CTRL_SSBD,
+	};
+	int i;
+
+	/*
+	 * Enabling LBRs activates LBR virtualization on AMD, and creates a
+	 * guest LBR perf event (and thus passes through the LBR stack) on
+	 * Intel.
+	 */
+	wrmsr_safe(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR);
+
+	/* KVM passes through SPEC_CTRL once the guest sets a non-zero value. */
+	for (i = 0; i < ARRAY_SIZE(spec_ctrl_vals); i++) {
+		if (!wrmsr_safe(MSR_IA32_SPEC_CTRL, spec_ctrl_vals[i]))
+			break;
+	}
+
+	/* VMX passes through XFD once the guest sets a non-zero value. */
+	wrmsr_safe(MSR_IA32_XFD, XFEATURE_MASK_XTILE_DATA);
+}
+
+static void guest_access_msrs(u8 deny)
+{
+	u64 val;
+	int i;
+
+	for (i = 0; i < NR_MSRS; i++) {
+		const struct test_msr *msr = &msrs[i];
+
+		/*
+		 * Denied reads are handled by userspace, so only record the
+		 * value if the read is allowed (and doesn't #GP).
+		 */
+		if (msr->access & ACC_R) {
+			if (!rdmsr_safe(msr->index, &val) && !(deny & ACC_R)) {
+				guest_vals[i] = val;
+				guest_val_valid[i] = true;
+			}
+		}
+
+		if (!(msr->access & ACC_W))
+			continue;
+
+		if (!(msr->access & ACC_R))
+			val = msr->write_val;
+		else if (guest_val_valid[i])
+			val = guest_vals[i];
+		else if (deny & ACC_W)
+			val = 0;
+		else
+			continue;
+
+		/*
+		 * Writes that are allowed only ever write the MSR's current
+		 * (or a benign) value.  Denied writes are dropped by userspace.
+		 */
+		wrmsr_safe(msr->index, val);
+	}
+}
+
+static void guest_code(void)
+{
+	int i;
+
+	guest_prime_passthrough();
+
+	for (i = 0; i < ARRAY_SIZE(phases); i++) {
+		guest_access_msrs(phases[i]);
+		GUEST_SYNC(i);
+	}
+
+	GUEST_DONE();
+}
+
+static void set_msr_filter(struct kvm_vm *vm, u8 deny)
+{
+	struct kvm_msr_filter filter = {
+		.flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
+	};
+	int i;
+
+	/* No ranges, i.e. disable filtering, if nothing is denied. */
+	if (deny) {
+		for (i = 0; i < ARRAY_SIZE(filter_bases); i++) {
+			filter.ranges[i].flags = deny;
+			filter.ranges[i].base = filter_bases[i];
+			filter.ranges[i].nmsrs = FILTER_NR_MSRS;
+			filter.ranges[i].bitmap = deny_bitmap;
+		}
+	}
+
+	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter);
+}
+
+static int find_msr(u32 index)
+{
+	int i;
+
+	for (i = 0; i < NR_MSRS; i++) {
+		if (msrs[i].index == index)
+			return i;
+	}
+
+	TEST_FAIL("Unexpected userspace exit for MSR 0x%x", index);
+	return -1;
+}
+
+static void handle_msr_exit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	int i = find_msr(run->msr.index);
+
+	TEST_ASSERT(run->msr.reason == KVM_MSR_EXIT_REASON_FILTER,
+		    "Wanted KVM_MSR_EXIT_REASON_FILTER for %s, got reason %u",
+		    msrs[i].name, run->msr.reason);
+
+	if (run->exit_reason == KVM_EXIT_X86_RDMSR) {
+		nr_read_exits[i]++;
+		run->msr.data = 0;
+	} else {
+		nr_write_exits[i]++;
+	}
+	run->msr.error = 0;
+}
+
+static int check_exits(const char *type, const char *name, int nr_exits,
+		       bool denied, int phase)
+{
+	int expected = denied;
+
+	if (nr_exits == expected)
+		return 0;
+
+	pr_info("Phase %d: %s %s: wanted %d userspace exit(s), got %d\n",
+		phase, name, type, expected, nr_exits);
+	return 1;
+}
+
+static void verify_phase(int phase)
+{
+	u8 deny = phases[phase];
+	int i, nr_failures = 0;
+
+	for (i = 0; i < NR_MSRS; i++) {
+		nr_failures += check_exits("RDMSR", msrs[i].name,
+					   nr_read_exits[i],
+					   msrs[i].access & deny & ACC_R, phase);
+		nr_failures += check_exits("WRMSR", msrs[i].name,
+					   nr_write_exits[i],
+					   msrs[i].access & deny & ACC_W, phase);
+	}
+
+	TEST_ASSERT(!nr_failures,
+		    "Phase %d (deny =%s%s): %d MSR filter failure(s), see above",
+		    phase, deny & ACC_R ? " RDMSR" : "",
+		    deny & ACC_W ? " WRMSR" : "", nr_failures);
+}
+
+static void run_phase(struct kvm_vcpu *vcpu, int phase)
+{
+	struct ucall uc;
+
+	memset(nr_read_exits, 0, sizeof(nr_read_exits));
+	memset(nr_write_exits, 0, sizeof(nr_write_exits));
+
+	set_msr_filter(vcpu->vm, phases[phase]);
+
+	for (;;) {
+		vcpu_run(vcpu);
+
+		if (vcpu->run->exit_reason == KVM_EXIT_X86_RDMSR ||
+		    vcpu->run->exit_reason == KVM_EXIT_X86_WRMSR) {
+			handle_msr_exit(vcpu);
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], phase);
+			verify_phase(phase);
+			return;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	u64 disable_exits;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int i, j;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_USER_SPACE_MSR));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_MSR_FILTER));
+
+	for (i = 0; i < NR_MSRS; i++) {
+		for (j = 0; j < i; j++)
+			TEST_ASSERT(msrs[i].index != msrs[j].index,
+				    "%s (0x%x) is listed more than once",
+				    msrs[i].name, msrs[i].index);
+
+		for (j = 0; j < ARRAY_SIZE(filter_bases); j++) {
+			if (msrs[i].index - filter_bases[j] < FILTER_NR_MSRS)
+				break;
+		}
+		TEST_ASSERT(j < ARRAY_SIZE(filter_bases),
+			    "%s (0x%x) isn't covered by the MSR filter",
+			    msrs[i].name, msrs[i].index);
+	}
+
+	/*
+	 * Request permission to expose AMX to the guest, if possible, so that
+	 * the guest can set XFD.  Ignore failure, as KVM omits AMX (and thus
+	 * support for non-zero XFD values) from the supported CPUID if
+	 * permission isn't granted, and priming XFD is done on a best effort
+	 * basis.
+	 */
+	vm_xsave_request_permission(XFEATURE_MASK_XTILE_DATA);
+
+	vm = vm_create(1);
+
+	/*
+	 * Pass through APERF/MPERF and the C-state residency MSRs if allowed.
+	 * This must be done before creating vCPUs.
+	 */
+	disable_exits = vm_check_cap(vm, KVM_CAP_X86_DISABLE_EXITS) &
+			(KVM_X86_DISABLE_EXITS_APERFMPERF |
+			 KVM_X86_DISABLE_EXITS_CSTATE);
+	if (disable_exits)
+		vm_enable_cap(vm, KVM_CAP_X86_DISABLE_EXITS, disable_exits);
+
+	/* Userspace exits must be enabled before installing any filters. */
+	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_FILTER);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
+
+	for (i = 0; i < ARRAY_SIZE(phases); i++)
+		run_phase(vcpu, i);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.56.0.212.g129ede20d9-goog

