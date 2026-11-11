Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376843;
	b=zeO1B8/tAb32CHYTX6QNq+R+R8Fh3+VGaIGz1xTRGuQm8U5hz44D/CFD8hRnRVZoi3T/
	 DF4FOMnGQqLsF7a3/iivapQJvui1kGkqYnRRxYOEgHtEcAR2oRY7qh4d2KVGWUz16tcmr
	 YtEPFH9UReija7EHU9Uy6qq2yE3hPbfNNm3HgLPkeOEyjLuzoagJbUPs8iVZDhy3uGlxh
	 MsrmhCVdtV9XM2mHKQ3sVMBhD8Tdg/PAX3khOx1gey9XCenrQSXnnGNLWqS0Hd7TeQpB/
	 lBo63jWRwOcmHcakHhEhbuSluzCQi3kodh1OyGHvEgpnzw5IqvuK61nyo/folcNBN6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376843;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Vgb5KbfLXjqL8iV/MCTqSzX96RhTYAbLrdtarSFXk0A=;
	b=1+D3JxLAAt9qG7RSHHSsNDMeZpHkaArilkrlD+4gHlO/rqEpHlaPK19XzNRJeUBKNCjH
	 XiaBBb8h9JS8xJ3Q70otFv8avtMgNSAq0DiG4AFQWl+AgbsEyhUY/bQ5RArR0RnCsiWk4
	 93msQLDdcn79LZb7gWzfFQTdZr6I15jvK+QAY1C/0apcOf3HybQOS6XMpAwXeVCPhu4ux
	 6hqre/N35oV0h/HHDwjbtzfWcN668kee4luErZutYO4z+Ag2fJuKyWqo4nXay/Xgx4PWi
	 eolLUsjpjcX3R4X3B0uPUqwNHS+D+7MwvoNl6qveR17IJpaBzvgJof70gDnU2qUgwpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YO8gsR4f;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AFB60A383D
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02AFB60A383D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=YO8gsR4f
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso1205580a12.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376842; x=1794981642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vgb5KbfLXjqL8iV/MCTqSzX96RhTYAbLrdtarSFXk0A=;
        b=r2DODfKQ0K7G7QTGwMRM5qNrHwJ5KHL+5NF8qISHRn8hhSiqtn8ekEdeKvAXQz5Ba5
         C8xgBWa1k31x3YxFM/2/vfcNXT0ESkIcFe05Ap7iqoPqq+cPswP9hoWUB6y3FYqJcM0O
         lVpu2993vJXhGg2YkctS27/sXDdAc504m5G8T5StIK2piB+FYAio3nb6eitRpI41ygR/
         EVyMVtR4fXf5ciTmzt39OVkmKcQHI+cBx5MGdwLgkTmAo6MPyU48cSH4e45SRvxg6uDr
         v0GALbSjn2rIAXUqh3RsuJ0P5q11+WFt9jPndlCHbEfDUep8D9jPez8lROJhh/wHQutO
         sgKQ==
X-Forwarded-Encrypted: i=1; AL+hErHhtwUd0PDv31yHJ2Puuz+FY3LwMEIdGFlizBPhyGjsfEm2TINMXD5YIJB17KmSrwg9Hwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z80QjDbudHOHYRnXrbv5H2QRUwT0ppOs+DlyIIf18TkrrEG5lby
	QzJEqJXZ46U8TKUt8Qvnh2rWBeznxj8tbhEK3hmvsLzNwGe3YzSA0myn4i8HpLt/STdwQPcjVS+
	+v7HMg+B8XZ9zI+b/9FUcYvo6W3R0Y9IQ0MZZV+wLf+qgH+OHgFiZPogYB5OJaPt3dYlXNNn2Jy
	TxsV6UcYZ5ZCvKjLf+gaJXAFBQpbUvQXc/lSsT2oMeputbcpOxL/A3nbc0o60BJ7uLZZ69/stGO
	bu9
X-Gm-Gg: AYBFou2iKpWcJwKwkAeQZ2RCnaYFgrNRC0Ce4VLIf61Hwoy+Zex1cqivm9LSNsxmAKn
	2nZEbMcHQaNdH4R/l0xcSUhCZkzoj0mRk49OcQ5jz7KIG+I9Dav99CJWo06iHSTMjWdxRWGQO3V
	NYXzQMnDDyYeiho2cy2i+Y2RxUDZiy5GB3aa8T3DdACWYEtlbUC1Js6hT/7BR27f8Q2AILbnE5g
	suAET8fhILiQeni5Bi6rZcbYeAhbmIK61lzjTMy8sizd+WtrHBRfEVwVQ9uS9X4OzrWUngBxGW1
	eWg6IiQ2OK+KBV5b85wi6DIksL2fx485h8S26y4m3mDvCXcPqBAuOUlkvfbJqmMRG1UVQCPWAe5
	lTZThHjM5tBFqRupqOWFzP6z+E7cb+G+kWsX2TGTzppZaV9Pu/SUWqKZYfk0C3oEKSHDA4nSo0N
	NNQax3i1WTe0mth+cqf01oX0nzqG02Z7uI
X-Received: by 2002:a17:90b:2f04:b0:3ac:8af9:4a6a with SMTP id 98e67ed59e1d1-3b182fe6ff1mr1454372a91.42.1794376842250;
        Tue, 10 Nov 2026 22:00:42 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17db74a03sm1327954a91.6.2026.11.10.22.00.40
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:42 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-946038e22f5so668611085a.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376839; x=1794981639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vgb5KbfLXjqL8iV/MCTqSzX96RhTYAbLrdtarSFXk0A=;
        b=YO8gsR4fYDDlhERZZDonCaPPpQ77QNj5fspgq1GVoGUlu3tXoHFb9jM8VAwviT4Wqs
         /Ym5rEFYjvw+yptsub7G2Go2IBxFCMswJpgSxL56SU2Us4WKbic0yOyvuglA3rW7nS7q
         AdzUqHqlNgpANU81RZ0TkzLgNhZx/B88ZWtrg=
X-Forwarded-Encrypted: i=1; AL+hErHLvObjlfqzd3KtJe1DdJOHw9zsDtkA92bHP9UmTf0ctKLT9XWgRJo3sg/t6v5Kd5VDX1A=@vger.kernel.org
X-Received: by 2002:a05:620a:1a25:b0:93f:5f83:2ca3 with SMTP id af79cd13be357-947b007e993mr212500485a.54.1794376839309;
        Tue, 10 Nov 2026 22:00:39 -0800 (PST)
X-Received: by 2002:a05:620a:1a25:b0:93f:5f83:2ca3 with SMTP id af79cd13be357-947b007e993mr212492885a.54.1794376838652;
        Tue, 10 Nov 2026 22:00:38 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:37 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Doug Covelli <doug.covelli@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 09/12] KVM: selftests: Port VMware backdoor coverage
Date: Wed, 11 Nov 2026 00:59:58 -0500
Message-ID: <4dca09deb85d2d5db157888ae4a2de7cbf6421d2.1794374897.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794374897.git.zack.rusin@broadcom.com>
References: <cover.1794374897.git.zack.rusin@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add vmware_backdoor_test, adapted from KVM-unit-tests' vmware_backdoors
test.  From CPL3, with CR4.PCE clear and no I/O permission bitmap in
the TSS, read the VMware pseudo-PMCs with RDPMC and issue backdoor
commands on the backdoor port with IN.  Verify that the pseudo-PMC
reads succeed and the port accesses exit to userspace only when the
backdoor is enabled and raise #GP otherwise, and that other PMC indices
and ports always raise #GP.  Repeat the pseudo-PMC checks at CPL3 with
CR4.PCE set and at CPL0, where RDPMC doesn't fault before KVM handles
it.  Skip the pseudo-PMC checks if KVM doesn't virtualize a PMU, as KVM
then injects #GP for every RDPMC.

Run the checks for a VM that relies on the enable_vmware_backdoor
default and for a VM that enables KVM_VMWARE_ENABLE_BACKDOOR, and
verify that KVM_CAP_X86_VMWARE rejects every flag it doesn't report.
KVM-unit-tests can only cover the module parameter, which applies to
every VM, while the selftest also covers the per-VM capability.

Suggested-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/aIEoNpe-LFoH6LBm@google.com
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/vmware_backdoor_test.c  | 272 ++++++++++++++++++
 3 files changed, 274 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmware_backdoor_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 017053e8f76e..39fa67a180f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15050,6 +15050,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/vmware.*
+F:	tools/testing/selftests/kvm/x86/vmware_backdoor_test.c
 
 KVM X86 Xen (KVM/Xen)
 M:	David Woodhouse <dwmw2@infradead.org>
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 95867977beb3..0ef08d7783ae 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
 TEST_GEN_PROGS_x86 += x86/userspace_io_test
 TEST_GEN_PROGS_x86 += x86/userspace_msr_exit_test
+TEST_GEN_PROGS_x86 += x86/vmware_backdoor_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_access_test
 TEST_GEN_PROGS_x86 += x86/vmx_apicv_updates_test
 TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
diff --git a/tools/testing/selftests/kvm/x86/vmware_backdoor_test.c b/tools/testing/selftests/kvm/x86/vmware_backdoor_test.c
new file mode 100644
index 000000000000..e4e87d2ce3c3
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmware_backdoor_test.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025-2026 Broadcom. All Rights Reserved. The term
+ * "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
+ *
+ * Adapted from kvm-unit-tests' x86/vmware_backdoors.c.
+ */
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define VMWARE_BACKDOOR_PMC_HOST_TSC		0x10000
+#define VMWARE_BACKDOOR_PMC_REAL_TIME		0x10001
+#define VMWARE_BACKDOOR_PMC_APPARENT_TIME	0x10002
+
+#define VMWARE_BACKDOOR_PORT	0x5658
+#define VMWARE_MAGIC		0x564d5868
+#define VMPORT_CMD_GETVERSION	0x0a
+#define VMPORT_CMD_ILLEGAL	0xfff
+#define VMPORT_DEFAULT_RETVAL	0xdeadbeef
+#define RANDOM_IO_PORT		0x1234
+#define RANDOM_PMC		0xfff
+
+struct insn_result {
+	u64 value;
+	u8 vector;
+};
+
+struct backdoor_results {
+	struct insn_result pmc[4];
+	struct insn_result port[3];
+};
+
+enum backdoor_mode {
+	USER_MODE,		/* CPL3, CR4.PCE clear */
+	USER_MODE_PCE,		/* CPL3, CR4.PCE set */
+	KERNEL_MODE,		/* CPL0 */
+};
+
+static struct backdoor_results results;
+static bool expect_backdoor;
+static bool test_pmcs;
+
+static struct insn_result guest_rdpmc(u32 pmc)
+{
+	struct insn_result result;
+	u32 eax;
+	u32 edx;
+	u64 error_code;
+
+	asm volatile(KVM_ASM_SAFE("rdpmc")
+		     : "=a"(eax), "=d"(edx),
+		       KVM_ASM_SAFE_OUTPUTS(result.vector, error_code)
+		     : "c"(pmc)
+		     : KVM_ASM_SAFE_CLOBBERS);
+	result.value = ((u64)edx << 32) | eax;
+	return result;
+}
+
+static struct insn_result guest_inl(u16 port, u32 command)
+{
+	struct insn_result result;
+	unsigned long rax = VMPORT_DEFAULT_RETVAL;
+	unsigned long rbx = VMPORT_DEFAULT_RETVAL;
+	unsigned long rcx = command;
+	unsigned long rdx = port;
+	u64 error_code;
+
+	asm volatile(KVM_ASM_SAFE("inl %%dx, %%eax")
+		     : "+a"(rax), "+b"(rbx), "+c"(rcx), "+d"(rdx),
+		       KVM_ASM_SAFE_OUTPUTS(result.vector, error_code)
+		     :
+		     : KVM_ASM_SAFE_CLOBBERS);
+	result.value = rbx;
+	return result;
+}
+
+static void guest_read_pmcs(void)
+{
+	results.pmc[0] = guest_rdpmc(VMWARE_BACKDOOR_PMC_HOST_TSC);
+	results.pmc[1] = guest_rdpmc(VMWARE_BACKDOOR_PMC_REAL_TIME);
+	results.pmc[2] = guest_rdpmc(VMWARE_BACKDOOR_PMC_APPARENT_TIME);
+	results.pmc[3] = guest_rdpmc(RANDOM_PMC);
+}
+
+static void guest_check_pmcs(void)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		GUEST_ASSERT_EQ(results.pmc[i].vector,
+				expect_backdoor ? 0 : GP_VECTOR);
+		if (expect_backdoor)
+			GUEST_ASSERT_NE(results.pmc[i].value, 0);
+	}
+	GUEST_ASSERT_EQ(results.pmc[3].vector, GP_VECTOR);
+}
+
+static void guest_done_handler(struct ex_regs *regs)
+{
+	if (test_pmcs)
+		guest_check_pmcs();
+
+	GUEST_ASSERT_EQ(results.port[0].vector,
+			expect_backdoor ? 0 : GP_VECTOR);
+	GUEST_ASSERT_EQ(results.port[1].vector,
+			expect_backdoor ? 0 : GP_VECTOR);
+	if (expect_backdoor)
+		GUEST_ASSERT_EQ(results.port[0].value, VMWARE_MAGIC);
+	GUEST_ASSERT_EQ(results.port[2].vector, GP_VECTOR);
+
+	GUEST_DONE();
+}
+
+static void guest_user_code(void)
+{
+	if (test_pmcs)
+		guest_read_pmcs();
+
+	results.port[0] = guest_inl(VMWARE_BACKDOOR_PORT,
+				    VMPORT_CMD_GETVERSION);
+	results.port[1] = guest_inl(VMWARE_BACKDOOR_PORT,
+				    VMPORT_CMD_ILLEGAL);
+	results.port[2] = guest_inl(RANDOM_IO_PORT, VMPORT_CMD_ILLEGAL);
+
+	asm volatile("int3");
+}
+
+/* At CPL0, only the pseudo-PMCs depend on the backdoor. */
+static void guest_kernel_code(void)
+{
+	guest_read_pmcs();
+	guest_check_pmcs();
+	GUEST_DONE();
+}
+
+static void handle_vmware_port(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs regs;
+	u32 *data;
+
+	TEST_ASSERT_EQ(run->io.direction, KVM_EXIT_IO_IN);
+	TEST_ASSERT_EQ(run->io.size, 4);
+	TEST_ASSERT_EQ(run->io.count, 1);
+	TEST_ASSERT_EQ(run->io.port, VMWARE_BACKDOOR_PORT);
+
+	data = (void *)run + run->io.data_offset;
+	*data = 0;
+
+	vcpu_regs_get(vcpu, &regs);
+	regs.rbx = VMWARE_MAGIC;
+	vcpu_regs_set(vcpu, &regs);
+}
+
+static void test_unsupported_flags(u64 supported)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+	int bit, ret;
+
+	for (bit = 0; bit < 64; bit++) {
+		if (supported & BIT_ULL(bit))
+			continue;
+
+		errno = 0;
+		ret = __vm_enable_cap(vm, KVM_CAP_X86_VMWARE, BIT_ULL(bit));
+		TEST_ASSERT(ret == -1 && errno == EINVAL,
+			    "Unsupported VMware flag %d: ret=%d errno=%d",
+			    bit, ret, errno);
+	}
+	kvm_vm_free(vm);
+}
+
+static void run_backdoor_test(bool enable_cap, bool expected,
+			      enum backdoor_mode mode)
+{
+	struct kvm_sregs sregs;
+	struct idt_entry *idt;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int port_exits = 0;
+
+	expect_backdoor = expected;
+	memset(&results, 0, sizeof(results));
+
+	vm = vm_create(1);
+	sync_global_to_guest(vm, expect_backdoor);
+	sync_global_to_guest(vm, test_pmcs);
+	sync_global_to_guest(vm, results);
+	if (enable_cap)
+		vm_enable_cap(vm, KVM_CAP_X86_VMWARE,
+			      KVM_VMWARE_ENABLE_BACKDOOR);
+	if (mode == KERNEL_MODE) {
+		vcpu = vm_vcpu_add(vm, 0, guest_kernel_code);
+	} else {
+		vcpu = vm_vcpu_add(vm, 0, guest_user_code);
+
+		idt = addr_gva2hva(vm, vm->arch.idt);
+		idt[BP_VECTOR].dpl = 3;
+		vm_install_exception_handler(vm, BP_VECTOR, guest_done_handler);
+		vm_init_user_mode(vm);
+		vcpu_enter_user_mode(vcpu);
+	}
+
+	if (mode == USER_MODE_PCE) {
+		vcpu_sregs_get(vcpu, &sregs);
+		sregs.cr4 |= X86_CR4_PCE;
+		vcpu_sregs_set(vcpu, &sregs);
+	}
+
+	for (;;) {
+		struct kvm_run *run = vcpu->run;
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		if (run->io.port == VMWARE_BACKDOOR_PORT) {
+			TEST_ASSERT(expected,
+				    "Disabled VMware backdoor reached userspace");
+			handle_vmware_port(vcpu);
+			port_exits++;
+			continue;
+		}
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_DONE:
+			TEST_ASSERT_EQ(port_exits,
+				       expected && mode != KERNEL_MODE ? 2 : 0);
+			kvm_vm_free(vm);
+			return;
+		default:
+			TEST_FAIL("Unexpected ucall 0x%lx", uc.cmd);
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int supported = kvm_check_cap(KVM_CAP_X86_VMWARE);
+	enum backdoor_mode mode;
+	bool module_default;
+
+	TEST_REQUIRE(supported & KVM_VMWARE_ENABLE_BACKDOOR);
+
+	test_unsupported_flags(supported);
+
+	/* KVM serves the pseudo-PMCs only if it virtualizes a PMU. */
+	test_pmcs = kvm_is_pmu_enabled();
+	if (!test_pmcs)
+		ksft_print_msg("vPMU disabled, skipping pseudo-PMC checks\n");
+
+	module_default = get_kvm_param_bool("enable_vmware_backdoor");
+	run_backdoor_test(false, module_default, USER_MODE);
+	run_backdoor_test(true, true, USER_MODE);
+
+	/*
+	 * RDPMC at CPL0, or at CPL3 with CR4.PCE set, doesn't raise the #GP
+	 * that the emulator handles, so check the pseudo-PMCs there as well.
+	 */
+	if (test_pmcs) {
+		for (mode = USER_MODE_PCE; mode <= KERNEL_MODE; mode++) {
+			run_backdoor_test(false, module_default, mode);
+			run_backdoor_test(true, true, mode);
+		}
+	}
+	return 0;
+}
-- 
2.53.0

