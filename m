Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4C23BB138
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481811; cv=none; b=rhBn0Ef5pWGJ136jXP/tOYip7BzrvtwobO6Cq/UcEuSqA2c1uF0iCG6iTlZhoU9cgZITnq1v62ITnj3y5O8u08kigchzTsC8w2JKTgGqIEfK25X3N3JmfBIH2GytSpZ3MlrZK+xsjYcs+wO60dg9eo6ryeLAeGqqAbr4Qyu0Sro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481811; c=relaxed/simple;
	bh=qi/WyV6rxMYApvKgE9MTfWvRwuKF3Auj3h2yBnFI9Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqB4RBn0DP+pQJXPFZ0I5QEIdOh+9sylo+0Rpx4nfoRGa8jH4XPb66wgUVS1zRmIwK12cCdbWGQY1m1ai8xDHFrNXobhxpPMvOijJDcaUdNrjWDa2IxSz0Mkkk6Hh33GaEOtFxEle+z+laPwgqscP6PVEsC3yRNnxxh4AqXNlVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+PJSOkY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+PJSOkY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84347ad88edso301651b3a.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481803; x=1784086603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bprvjfkZ0oqVTmlvbtRw94STPHY60J1TjXPxacGDgk=;
        b=e+PJSOkYL1quemdbWB8KV7ELRvmStqo9igrTZRmFpup1yPtUoQ6a7Ja/gqz5CdPRdp
         sGHxRxdh52RjzouAlEvnd/Gj7Ph2LIJfTJApO+GhLgqnHqCFUlST4ZfkBJEay5aks/9N
         2l9pXY1rieuoexMR0xYWOZjJ5OQjGG3X2H/hdTKlE5KFpMtlWrcxkAqdZoBrl0iWF0Nb
         NVuGdjrkr3hS+FkSW+IgOVB3S1queS6u5KoHD/tfalC18H7ayRPWoydFr28hJ7l7ZMXO
         V5ugTGv8nh0YryyyMN4WwR6ytGUmXi27hYsTDj2jKzmUF+OuMT3CRH9ePuPLCPAl8H/B
         WHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481803; x=1784086603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bprvjfkZ0oqVTmlvbtRw94STPHY60J1TjXPxacGDgk=;
        b=SFv1A4idt5w7fcqD+8v4Oevl/0wsB5Sg7MMOPok2SGIuGvDFedZq0g8rgvK62euitj
         +/qpUo2UBykd8CGodHc7n7JM4Z4AlaX1ANBF1I/URrHXqZtop+T3Cy2JAcxDpWicghxr
         h+mvdE1z6gW00sfQAZv+4YY9mL3wuuBvZ1P/UUTh7ABJ48OX6sTOXoqNJIF65nycGB4p
         1iokYNNFLxELMsdpAyKNfsM/vSZ3HVjOOudYbztAN/iuR6iU9JKZvRalD/tq+/Px3hRf
         RvnQoNljKOysVZ7kqgWWSW7HQ/oHk3VCbLWZDrrORQBrRTep9O7vY7jzx5Qvt46NAI3+
         buXA==
X-Forwarded-Encrypted: i=1; AHgh+RoBMsONPwL6zmOScyFfNX1fxny5xaUa8xYb38JgTK0KoRGTqSUAD/d88/UNJlzkbs7MCMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZBDWeL1lGfc2Ru6mAz0ZTNBlGCdazPTUPy1FJRcgo7aiPcY6
	xYbNezrWaR3DjijmnKaqHZ1nDwVgAFyIw5isr81LUe4GSWj/IkXlP5LA
X-Gm-Gg: AfdE7cm8q6eGIGf/v/2AOnSKUTi/eG9I1nMgNclb3Tf+61wljqHjGH0hoWQRFQm65i7
	qiMFQYp6GQvMZxzZHgf1qU2RPSTpznnlcZXkUj7cic8RDdXrhgK80GbGORlgYZNXUYmQcE+58Av
	nqUzdXTefgcZlQ7QNMmYbjsgD813hvSGLr9J2TbGbPTJYavEsQSDTXwrqbPigo/wo66nAblj4m1
	7iZ9oM0FX1Jkhmc3GlCQuVfvj3s7uxv7DPxIsETHHAZZbdDx0NUgbNaL864aXZlYRB9BpRmKzhm
	oMLtfUlVEw8E/7mqaw5RlY5D3EZ4S6J3OAb1Gwcv1flMMqNMZmg+TJcankSUNNanO0DTLe3id6r
	J+sKJ1jnzBeDD4xMRJFKM8hTUN9BiiZ3sOB55ZWJltlRC3LzzHfsaSHRtvsHWTntmdKMqqOsVcS
	P83iRTcXANpzezhIXwv30ZkClhzCXKYAxZFKJv3EM=
X-Received: by 2002:a05:6300:220d:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3c0bd23ef9dmr601090637.50.1783481802761;
        Tue, 07 Jul 2026 20:36:42 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:42 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:37 -0700
Subject: [PATCH v3 14/17] KVM: riscv: selftests: Add csr emulation test
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-14-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
In-Reply-To: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481778; l=4678;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=qi/WyV6rxMYApvKgE9MTfWvRwuKF3Auj3h2yBnFI9Mg=;
 b=QczF1j024KNg8/dB49Lgm4Ao2CfVqUU6ddLzHSDUYeMCWduTnE82y0t5vR2FFGF8EVkyU4Mi0
 eWDQJmNv8UjAE94S/3gzb4BUmUKXenPsYliWICDyA0ktInJOh35mlXn
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

Introduce a kvm test that uses the emulated test csr to validate that
all emulated reads/writes to csrs function as expected.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 tools/testing/selftests/kvm/Makefile.kvm     |   1 +
 tools/testing/selftests/kvm/riscv/csr_test.c | 133 +++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 07a5fc2bf67c..88ccd15e8f94 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -212,6 +212,7 @@ TEST_GEN_PROGS_s390 += s390/irq_routing
 TEST_GEN_PROGS_s390 += mmu_stress_test
 
 TEST_GEN_PROGS_riscv = $(TEST_GEN_PROGS_COMMON)
+TEST_GEN_PROGS_riscv += riscv/csr_test
 TEST_GEN_PROGS_riscv += riscv/sbi_pmu_test
 TEST_GEN_PROGS_riscv += riscv/ebreak_test
 TEST_GEN_PROGS_riscv += riscv/mmio_test
diff --git a/tools/testing/selftests/kvm/riscv/csr_test.c b/tools/testing/selftests/kvm/riscv/csr_test.c
new file mode 100644
index 000000000000..bdedf7c84001
--- /dev/null
+++ b/tools/testing/selftests/kvm/riscv/csr_test.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * csr_test.c - Tests the csr functionality. CONFIG_RISCV_KVM_TEST_CSR needs to be enabled.
+ */
+#include "kvm_util.h"
+#include "ucall_common.h"
+
+#define CSR_TEST 0x240
+#define MASK 0x15
+#define FP 0x00006000
+
+/*
+ * Use the fcsr as a U-mode accesible csr and compare against the custom 'test'
+ * hypervisor csr (currently using vsscratch)
+ */
+#define test_csr(write, initial, mode)								\
+static void test_##write(void)									\
+{												\
+	unsigned long hypervisor_result, reference_result, old_hypervisor;			\
+	asm volatile (										\
+		"csrs	sstatus, %[enable_fp]\n"						\
+		"csrw	fcsr, %[init]\n"							\
+		#write"	zero, fcsr, %[mask]\n"							\
+		"csrr	%[ref_res], fcsr\n"							\
+		: [ref_res] "=&r" (reference_result)						\
+		: [enable_fp] "r" (FP), [mask] #mode(MASK), [init] "r" (initial)		\
+		: "memory"									\
+	);											\
+	asm volatile (										\
+		"csrw	%[test_csr], %[init]\n"							\
+		#write"	%[old], %[test_csr], %[mask]\n"						\
+		"csrr	%[hyp_res], %[test_csr]\n"						\
+		: [hyp_res] "=&r" (hypervisor_result), [old] "=&r" (old_hypervisor)		\
+		: [test_csr] "i"(CSR_TEST), [mask] #mode(MASK), [init] "r" (initial)		\
+		: "memory"									\
+	);											\
+	/* Check that writing works */								\
+	GUEST_ASSERT_EQ(reference_result, hypervisor_result);					\
+	/* Check that reading works */								\
+	GUEST_ASSERT_EQ(old_hypervisor, initial);						\
+	GUEST_DONE();										\
+}
+
+test_csr(csrrw, 0x0, r)
+test_csr(csrrs, 0x0, r)
+test_csr(csrrc, 0x15, r)
+test_csr(csrrwi, 0x0, i)
+test_csr(csrrsi, 0x0, i)
+test_csr(csrrci, 0x15, i)
+
+static void run(void *guest_code, char *instruction)
+{
+	int fd;
+	struct ucall uc;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	fd = kvm_create_device(vm, KVM_DEV_TYPE_TEST);
+
+	vcpu_run(vcpu);
+
+	TEST_ASSERT(get_ucall(vcpu, &uc) == UCALL_DONE,
+		    "CSR instruction '%s' failed: '%s'", instruction,
+		    uc.buffer);
+
+	close(fd);
+	kvm_vm_free(vm);
+}
+
+static void check_test_csr_guest(void)
+{
+	unsigned long scause, stvec;
+
+	asm volatile(
+		".option push\n"
+		".option norvc\n"
+		"la	%[stvec], 1f\n"
+		"csrw	stvec, %[stvec]\n"
+		"csrwi	%[test_csr], 0x0\n"
+		"1:\n"
+		"csrr	%[scause], scause\n"
+		".option pop\n"
+		: [scause] "=&r" (scause), [stvec] "=&r" (stvec)
+		: [test_csr] "i" (CSR_TEST)
+	);
+
+	/* An illegal instruction will be generated if CONFIG_RISCV_KVM_TEST_CSR is not enabled. */
+	if (scause == 2)
+		GUEST_FAIL("CONFIG_RISCV_KVM_TEST_CSR not enabled.\n");
+	GUEST_DONE();
+}
+
+static int check_test_csr(void)
+{
+	struct ucall uc;
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int success;
+	int fd;
+
+	vm = vm_create_with_one_vcpu(&vcpu, check_test_csr_guest);
+
+	fd = __kvm_create_device(vm, KVM_DEV_TYPE_TEST);
+	if (fd < 0)
+		return 0;
+
+	vcpu_run(vcpu);
+
+	success = get_ucall(vcpu, &uc) == UCALL_DONE;
+
+	close(fd);
+	kvm_vm_free(vm);
+
+	return success;
+}
+
+int main(void)
+{
+	/* Skip if CONFIG_RISCV_KVM_TEST_CSR not enabled */
+	if (!check_test_csr())
+		exit(KSFT_SKIP);
+
+	run(test_csrrw, "csrrw");
+	run(test_csrrs, "csrrs");
+	run(test_csrrc, "csrrc");
+	run(test_csrrwi, "csrrwi");
+	run(test_csrrsi, "csrrsi");
+	run(test_csrrci, "csrrci");
+
+	return 0;
+}

-- 
2.54.0

