Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376854;
	b=fb/9F+KzrwTCWXLdDOXga60j+0JUa6MCBeb962A95jOlegOnkPCSGuLkWesAbtsCTtGA
	 kbfBFxMYdg2BTCHmmDOF1D7rlbZvAhPNVS5U4N7EADw6SQ2ON7rtqRFfmOjD5F/kZEbHq
	 JK0skHKY+hZjjWF74VZ41HIImyNs2TV7AWnpI3Xcwo+hiY8QorCp3fltAnLMBQ7utcFG6
	 ThuQP7pJMeDgo9XqoqC6aWLSqpLfPW3jWHT6O1TW48I1ocp7hNf3m+fcpUkCCg8/mYVz7
	 jmkA9inEJ7zaiAuZ5K96rrP8WGd5J4Xg0QhsVmvr6IS4O5lG1DXSMzD8e7B+QVBfnVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376854;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=TSSS47OuX18AkZ0WWvwghAEXSlqCI7mH8QyE7+GhZEU=;
	b=eWh0V3vFLlAe2OnemoIIwVx2QNDliMgwrAiAhxmBCW8bnyCKcrY/rKxWFKmL4Qk1bdYL
	 aBpM3Kb0LIas5AHg5lkJvdJncgiERa1QF28WJZinNkhzIBWI01BVXUJNl5TyoT/X7ziuN
	 4jRUDLVPaoxxHGYqI26idQf+UHbbYe9NInVBVeU3B3KqizHEQDjDnfS4Gk7+vZfm5H+Xf
	 2Ht16aOp8QC6xmIzU9lKKFoYDRVN+Oe99/dK6+Ycz+9U77Ak/byOOV/w5Vt6vbG4wgx2C
	 2X/An2py14GZw81aBbeZskxuNGR6nHuvdvP4fg290v4Xpf/uSbTPggbPsJRQqKHDXfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=T7fdPXcE;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA07E606A33D
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA07E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=T7fdPXcE
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3b0e0e65adbso1454306a91.3
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376852; x=1794981652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSSS47OuX18AkZ0WWvwghAEXSlqCI7mH8QyE7+GhZEU=;
        b=K6VUJcBhV/0ozqU8dLxJdD93dGKHbBFun6cmr+KVvKIxxMH60xmNnoemh0C4YeisAW
         hos6/CABwZ6OhqOmSmh6Lm2d6jZj+ZCf0ywukf1nH3IxyKMWQ7vlWTjgw98xjh0aeOoT
         GueOiRL+JOgyy5Ciz1l/RP74HIidyQOoLjXh3C7316ZzeifHFD2rmL/ElWeOV+TDV9Qz
         qPmHsLi+NKFJxbBTRJ43ttdPIi/rjaksWohBT3lzEAihNp9dvBXGzg6svSuh6AHegzcG
         keygb9h4AxkqorJT6vvlk7QWHldhoFYC8L4gVPz1XBwZKOCPG9GWHMYOLWDo8VrVM7sF
         HdQA==
X-Forwarded-Encrypted: i=1; AL+hErGXVbd3k0nzCjFCe/Wb8n1p1IFGGBtzK8Gq30fy1OoXT3oul+GXVRtcHwMfMSeAcGDLK50=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j5KPN1KZK7+GW29MWV8pVjo3qzjVvYEOBuXttZbXbw0U8enuJ
	vfwnvEdOCSEGv+dte9QY0P8RzypV27Z+qp8vqsaOJa92yCkuDJCZASO1x0UdfemaJhD2WbkrkDa
	T+pWI9Cu2bn2NwC9XewluYtm7iR2a7GRm61FK7Ah6+L6IodqlgV0nuE9ttnUSklQ8vA30pD6fXM
	RWcFerE5pFmWsF8hb8XHL8R7/z5DbixlsLlXGhdTqY+3mFDY448JauDgU8y0LyDdjs+Z0rwzEHv
	g5R
X-Gm-Gg: AYBFou2TOiLCyJ6iYkTJ8QpWeEW6Nk3bYIxBfPIXRj+bntm4H/RUY41MEKQDJ2saQZA
	qSwz6PcRB2bonWEE5Mtr1J93t4eCD73h6PaYkD3LtSnrBLmWesEr6pQTGTIu8pBp7Dkbyk0/M0Q
	XlOQdA6n0rN9XFIoG7nV6vJEph/oZIa2SgXzeukRGMVlsxuHhTSZSAImtPoKZVQCtQYAPxiVZoN
	fF8VqqMFhEgP8g8vmBxA1E1HPlSbqcYuQAovT+OZ1Pd6ClSCxfR+Rnb7v2zUxTgkTwXetPbUXdr
	OO17nMct2BvJMrWZHJefFcPMwcPjFOFPpuIkav7wyGSFHx/HjmWSxcv84q4zngffxP3lB/0ttUd
	iQp7LkrY3gGShl+fNkR991jNrcVSTFjpCuhzMdXvay1BViBV61Zp+iASG/Y58sG6TymtZ550npQ
	2nf7Q6vdDXyCYiJyVH1PhOdZrCO48QlBqL
X-Received: by 2002:a17:90b:3b85:b0:3a8:32f2:f4a5 with SMTP id 98e67ed59e1d1-3b182f4255emr1560766a91.53.1794376851800;
        Tue, 10 Nov 2026 22:00:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17de30a7csm1360902a91.1.2026.11.10.22.00.43
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f322ef7d3so661879585a.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376843; x=1794981643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TSSS47OuX18AkZ0WWvwghAEXSlqCI7mH8QyE7+GhZEU=;
        b=T7fdPXcEiW98CK4fM5gIdQDwqLP3vJ+Tl6hpXKQ5av4trSlPglvOH+TsFxVsmx9m6L
         TRoRK7KQ2rxjz+llsEQp/sA4jAWSLdCHcGBMqUw2WH2cck+vsqMjtBP5IGfanOj14RvL
         O8soRrFIb0/wxXtfthUGyi6QtP+sHgIPdsFyk=
X-Forwarded-Encrypted: i=1; AL+hErHM8nwqWUclGr6PwskLy29THaA4eGVw+HvDwKCog/369AlMcQ9tXkfV6taKsYm3ghAX/LQ=@vger.kernel.org
X-Received: by 2002:a05:620a:800e:b0:93f:2aa8:c549 with SMTP id af79cd13be357-947aff97dbamr199065385a.24.1794376842488;
        Tue, 10 Nov 2026 22:00:42 -0800 (PST)
X-Received: by 2002:a05:620a:800e:b0:93f:2aa8:c549 with SMTP id af79cd13be357-947aff97dbamr199059485a.24.1794376841877;
        Tue, 10 Nov 2026 22:00:41 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:39 -0800 (PST)
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
Subject: [PATCH v3 10/12] KVM: selftests: Test VMware hypercall exits
Date: Wed, 11 Nov 2026 00:59:59 -0500
Message-ID: <e6dfd2e43c8a6ea04fe59b1b5825138ad5523273.1794374897.git.zack.rusin@broadcom.com>
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

Add vmware_hypercall_test to cover KVM_VMWARE_ENABLE_HYPERCALL and
KVM_EXIT_VMWARE, and enable VMware hypercall exits in xen_vmcall_test.

Check the exit's calling convention and CPL reporting at CPL0 and CPL3
and in 64-bit and compatibility mode, that all GPR inputs are visible
in full width through KVM_SYNC_X86_REGS, and that synchronized GPR and
RFLAGS outputs complete the call.  Check that #UD, #GP and #PF
completions keep RIP at the hypercall, deliver the requested error code
and CR2, and can also return modified registers.  Check that invalid
completions fail with -EINVAL and that the call is retried afterwards,
that the flags can't be enabled after vCPU creation, that hypercalls
without the magic value still reach KVM, and that protected VM types
neither advertise nor accept the flag.

xen_vmcall_test already issues Xen and Hyper-V hypercalls from one
guest; enabling VMware hypercall exits there verifies that the magic
value filter leaves both alone.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/vmware_hypercall_test.c | 388 ++++++++++++++++++
 .../selftests/kvm/x86/xen_vmcall_test.c       |  12 +-
 4 files changed, 401 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmware_hypercall_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 39fa67a180f5..38a735c9221e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15051,6 +15051,7 @@ T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/vmware.*
 F:	tools/testing/selftests/kvm/x86/vmware_backdoor_test.c
+F:	tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
 
 KVM X86 Xen (KVM/Xen)
 M:	David Woodhouse <dwmw2@infradead.org>
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 0ef08d7783ae..fe7ba905facd 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -141,6 +141,7 @@ TEST_GEN_PROGS_x86 += x86/ucna_injection_test
 TEST_GEN_PROGS_x86 += x86/userspace_io_test
 TEST_GEN_PROGS_x86 += x86/userspace_msr_exit_test
 TEST_GEN_PROGS_x86 += x86/vmware_backdoor_test
+TEST_GEN_PROGS_x86 += x86/vmware_hypercall_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_access_test
 TEST_GEN_PROGS_x86 += x86/vmx_apicv_updates_test
 TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
diff --git a/tools/testing/selftests/kvm/x86/vmware_hypercall_test.c b/tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
new file mode 100644
index 000000000000..d882d3661022
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025-2026 Broadcom. All Rights Reserved. The term
+ * "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+#define HYPERCALL_INSN_SIZE	3
+#define VMWARE_MAGIC		0x564d5868
+#define ARG_RAX			(0xdeadbeef00000000ULL | VMWARE_MAGIC)
+#define ARGVALUE(x)		(0xdeadbeef5a5a0000ULL + (x))
+#define OUTVALUE(x)		(0x1234500000000000ULL + (x))
+#define FAULT_ADDRESS		0xdeadbeefcafef000ULL
+#define FAULT_ERROR_CODE	0x5a
+
+static const u8 vmx_vmcall[HYPERCALL_INSN_SIZE] = { 0x0f, 0x01, 0xc1 };
+static const u8 svm_vmmcall[HYPERCALL_INSN_SIZE] = { 0x0f, 0x01, 0xd9 };
+
+struct vmware_test {
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	gva_t insn_gva;
+};
+
+static void unused_guest_code(void)
+{
+	GUEST_DONE();
+}
+
+static const u8 *native_hypercall_insn(void)
+{
+	if (host_cpu_is_intel)
+		return vmx_vmcall;
+	if (host_cpu_is_amd_compatible)
+		return svm_vmmcall;
+
+	TEST_FAIL("VMware hypercall test requires an Intel or AMD-compatible CPU");
+}
+
+static void set_compat_mode(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vcpu, &sregs);
+	sregs.cs.l = 0;
+	sregs.cs.db = 1;
+	vcpu_sregs_set(vcpu, &sregs);
+}
+
+static struct vmware_test create_test(bool cpl3, bool compat, u64 rax)
+{
+	struct vmware_test test;
+	struct kvm_regs regs;
+	u8 *insn;
+
+	test.vm = vm_create(1);
+	TEST_ASSERT(vm_check_cap(test.vm, KVM_CAP_X86_VMWARE) &
+		    KVM_VMWARE_ENABLE_HYPERCALL,
+		    "Ordinary VM does not advertise VMware hypercall exits");
+	vm_enable_cap(test.vm, KVM_CAP_X86_VMWARE,
+		      KVM_VMWARE_ENABLE_HYPERCALL);
+	test.vcpu = vm_vcpu_add(test.vm, 0, unused_guest_code);
+	test.insn_gva = vm_alloc_page(test.vm);
+
+	insn = addr_gva2hva(test.vm, test.insn_gva);
+	memcpy(insn, native_hypercall_insn(), HYPERCALL_INSN_SIZE);
+	insn[HYPERCALL_INSN_SIZE] = 0xf4; /* HLT */
+
+	vcpu_regs_get(test.vcpu, &regs);
+	regs.rax = rax;
+	regs.rbx = ARGVALUE(2);
+	regs.rcx = ARGVALUE(3);
+	regs.rdx = ARGVALUE(4);
+	regs.rsi = ARGVALUE(5);
+	regs.rdi = ARGVALUE(6);
+	regs.rbp = ARGVALUE(7);
+	regs.rip = test.insn_gva;
+	vcpu_regs_set(test.vcpu, &regs);
+
+	if (cpl3) {
+		vm_init_user_mode(test.vm);
+		vcpu_enter_user_mode(test.vcpu);
+	}
+	if (compat)
+		set_compat_mode(test.vcpu);
+
+	return test;
+}
+
+static void destroy_test(struct vmware_test *test)
+{
+	kvm_vm_free(test->vm);
+}
+
+static void assert_hypercall_state(struct vmware_test *test, bool cpl3,
+				   bool compat)
+{
+	struct kvm_vmware_exit *vmware = &test->vcpu->run->vmware;
+	struct kvm_regs *regs = &test->vcpu->run->s.regs.regs;
+
+	TEST_ASSERT_EQ(vmware->type, KVM_EXIT_VMWARE_HCALL);
+	TEST_ASSERT_EQ(vmware->hcall.longmode, !compat);
+	TEST_ASSERT_EQ(vmware->hcall.cpl, cpl3 ? 3 : 0);
+	TEST_ASSERT_EQ(regs->rax, ARG_RAX);
+	TEST_ASSERT_EQ(regs->rbx, ARGVALUE(2));
+	TEST_ASSERT_EQ(regs->rcx, ARGVALUE(3));
+	TEST_ASSERT_EQ(regs->rdx, ARGVALUE(4));
+	TEST_ASSERT_EQ(regs->rsi, ARGVALUE(5));
+	TEST_ASSERT_EQ(regs->rdi, ARGVALUE(6));
+	TEST_ASSERT_EQ(regs->rbp, ARGVALUE(7));
+}
+
+static void run_to_vmware_exit(struct vmware_test *test, bool cpl3,
+			       bool compat)
+{
+	test->vcpu->run->kvm_valid_regs = KVM_SYNC_X86_REGS;
+	vcpu_run(test->vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(test->vcpu, KVM_EXIT_VMWARE);
+	TEST_ASSERT(test->vcpu->run->kvm_valid_regs & KVM_SYNC_X86_REGS,
+		    "KVM did not return synchronized GPRs");
+	assert_hypercall_state(test, cpl3, compat);
+}
+
+static void compare_regs(const struct kvm_regs *actual,
+			 const struct kvm_regs *expected)
+{
+	TEST_ASSERT_EQ(actual->rax, expected->rax);
+	TEST_ASSERT_EQ(actual->rbx, expected->rbx);
+	TEST_ASSERT_EQ(actual->rcx, expected->rcx);
+	TEST_ASSERT_EQ(actual->rdx, expected->rdx);
+	TEST_ASSERT_EQ(actual->rsi, expected->rsi);
+	TEST_ASSERT_EQ(actual->rdi, expected->rdi);
+	TEST_ASSERT_EQ(actual->rsp, expected->rsp);
+	TEST_ASSERT_EQ(actual->rbp, expected->rbp);
+	TEST_ASSERT_EQ(actual->r8, expected->r8);
+	TEST_ASSERT_EQ(actual->r9, expected->r9);
+	TEST_ASSERT_EQ(actual->r10, expected->r10);
+	TEST_ASSERT_EQ(actual->r11, expected->r11);
+	TEST_ASSERT_EQ(actual->r12, expected->r12);
+	TEST_ASSERT_EQ(actual->r13, expected->r13);
+	TEST_ASSERT_EQ(actual->r14, expected->r14);
+	TEST_ASSERT_EQ(actual->r15, expected->r15);
+	TEST_ASSERT_EQ(actual->rip, expected->rip);
+	TEST_ASSERT_EQ(actual->rflags, expected->rflags);
+}
+
+static void test_synchronized_output(bool compat)
+{
+	struct vmware_test test = create_test(false, compat, ARG_RAX);
+	struct kvm_run *run = test.vcpu->run;
+	struct kvm_regs actual;
+	struct kvm_regs expected;
+	int ret;
+
+	run_to_vmware_exit(&test, false, compat);
+	expected = run->s.regs.regs;
+	expected.rax = OUTVALUE(1);
+	expected.rbx = OUTVALUE(2);
+	expected.rcx = OUTVALUE(3);
+	expected.rdx = OUTVALUE(4);
+	expected.rsi = OUTVALUE(5);
+	expected.rdi = OUTVALUE(6);
+	expected.rsp = OUTVALUE(7);
+	expected.rbp = OUTVALUE(8);
+	expected.r8 = OUTVALUE(9);
+	expected.r9 = OUTVALUE(10);
+	expected.r10 = OUTVALUE(11);
+	expected.r11 = OUTVALUE(12);
+	expected.r12 = OUTVALUE(13);
+	expected.r13 = OUTVALUE(14);
+	expected.r14 = OUTVALUE(15);
+	expected.r15 = OUTVALUE(16);
+	expected.rflags = X86_EFLAGS_CF | X86_EFLAGS_ZF;
+	run->s.regs.regs = expected;
+	run->kvm_dirty_regs = KVM_SYNC_X86_REGS;
+	run->immediate_exit = 1;
+
+	errno = 0;
+	ret = __vcpu_run(test.vcpu);
+	run->immediate_exit = 0;
+	TEST_ASSERT(ret == -1 && errno == EINTR,
+		    "Completion with immediate_exit failed: ret=%d errno=%d",
+		    ret, errno);
+
+	expected.rip += HYPERCALL_INSN_SIZE;
+	expected.rflags |= X86_EFLAGS_FIXED;
+	vcpu_regs_get(test.vcpu, &actual);
+	compare_regs(&actual, &expected);
+	destroy_test(&test);
+}
+
+static void test_valid_exception(u32 vector, u32 error_code, u64 address,
+				 bool dirty_regs)
+{
+	struct vmware_test test = create_test(false, false, ARG_RAX);
+	struct kvm_run *run = test.vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_sregs sregs;
+	struct kvm_regs expected;
+	struct kvm_regs regs;
+	u64 fault_rip;
+	int ret;
+
+	run_to_vmware_exit(&test, false, false);
+	expected = run->s.regs.regs;
+	fault_rip = run->s.regs.regs.rip;
+	run->vmware.hcall.exception.inject = 1;
+	run->vmware.hcall.exception.vector = vector;
+	run->vmware.hcall.exception.error_code = error_code;
+	run->vmware.hcall.exception.address = address;
+	if (dirty_regs) {
+		expected.rax = OUTVALUE(1);
+		expected.rcx = OUTVALUE(3);
+		expected.rdx = OUTVALUE(4);
+		expected.rsi = OUTVALUE(5);
+		expected.rdi = OUTVALUE(6);
+		expected.rbp = OUTVALUE(8);
+		expected.rflags = X86_EFLAGS_CF | X86_EFLAGS_ZF |
+				  X86_EFLAGS_FIXED;
+		run->s.regs.regs = expected;
+		run->kvm_dirty_regs = KVM_SYNC_X86_REGS;
+	} else {
+		run->kvm_dirty_regs = 0;
+	}
+	run->immediate_exit = 1;
+
+	errno = 0;
+	ret = __vcpu_run(test.vcpu);
+	run->immediate_exit = 0;
+	TEST_ASSERT(ret == -1 && errno == EINTR,
+		    "Exception completion failed: ret=%d errno=%d", ret, errno);
+
+	vcpu_regs_get(test.vcpu, &regs);
+	compare_regs(&regs, &expected);
+	TEST_ASSERT_EQ(regs.rip, fault_rip);
+	/*
+	 * KVM_GET_VCPU_EVENTS delivers a pending exception payload when the
+	 * exception-payload capability is disabled.  Read CR2 afterwards.
+	 */
+	vcpu_events_get(test.vcpu, &events);
+	TEST_ASSERT(events.exception.pending || events.exception.injected,
+		    "Exception %u was not queued", vector);
+	TEST_ASSERT_EQ(events.exception.nr, vector);
+	TEST_ASSERT_EQ(events.exception.has_error_code, vector != UD_VECTOR);
+	if (vector != UD_VECTOR)
+		TEST_ASSERT_EQ(events.exception.error_code, error_code);
+	if (vector == PF_VECTOR) {
+		vcpu_sregs_get(test.vcpu, &sregs);
+		TEST_ASSERT_EQ(sregs.cr2, address);
+	}
+	destroy_test(&test);
+}
+
+static void test_invalid_completion(u32 inject, u32 vector, u32 error_code,
+				    u64 address, u32 pad1, u32 pad2)
+{
+	struct vmware_test test = create_test(false, false, ARG_RAX);
+	struct kvm_run *run = test.vcpu->run;
+	u64 fault_rip;
+	int ret;
+
+	run_to_vmware_exit(&test, false, false);
+	fault_rip = run->s.regs.regs.rip;
+	run->vmware.pad1 = pad1;
+	run->vmware.hcall.exception.inject = inject;
+	run->vmware.hcall.exception.pad2 = pad2;
+	run->vmware.hcall.exception.vector = vector;
+	run->vmware.hcall.exception.error_code = error_code;
+	run->vmware.hcall.exception.address = address;
+	run->kvm_dirty_regs = 0;
+
+	errno = 0;
+	ret = _vcpu_run(test.vcpu);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "Invalid completion was accepted: ret=%d errno=%d", ret, errno);
+
+	run->vmware.pad1 = 0;
+	run->vmware.hcall.exception.pad2 = 0;
+	run->exit_reason = KVM_EXIT_UNKNOWN;
+	run_to_vmware_exit(&test, false, false);
+	TEST_ASSERT_EQ(run->s.regs.regs.rip, fault_rip);
+	destroy_test(&test);
+}
+
+static void test_non_vmware_hypercall(void)
+{
+	struct vmware_test test = create_test(false, false,
+					      KVM_HC_MAP_GPA_RANGE);
+	struct kvm_regs regs;
+
+	vm_enable_cap(test.vm, KVM_CAP_EXIT_HYPERCALL,
+		      BIT(KVM_HC_MAP_GPA_RANGE));
+	vcpu_regs_get(test.vcpu, &regs);
+	regs.rbx = PAGE_SIZE;
+	regs.rcx = 1;
+	regs.rdx = 0;
+	vcpu_regs_set(test.vcpu, &regs);
+
+	vcpu_run(test.vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(test.vcpu, KVM_EXIT_HYPERCALL);
+	TEST_ASSERT_EQ(test.vcpu->run->hypercall.nr, KVM_HC_MAP_GPA_RANGE);
+	destroy_test(&test);
+}
+
+static void test_protected_rejection(void)
+{
+	struct kvm_vm *vm;
+	unsigned int supported = kvm_check_cap(KVM_CAP_VM_TYPES);
+	int vmware_caps;
+	u32 type;
+	int ret;
+
+	if (supported & BIT(KVM_X86_SEV_ES_VM)) {
+		type = KVM_X86_SEV_ES_VM;
+	} else if (supported & BIT(KVM_X86_SNP_VM)) {
+		type = KVM_X86_SNP_VM;
+	} else if (supported & BIT(KVM_X86_TDX_VM)) {
+		type = KVM_X86_TDX_VM;
+	} else {
+		ksft_print_msg("No protected x86 VM type, skipping rejection test\n");
+		return;
+	}
+
+	vm = vm_create_barebones_type(type);
+	vmware_caps = vm_check_cap(vm, KVM_CAP_X86_VMWARE);
+	TEST_ASSERT(!(vmware_caps & KVM_VMWARE_ENABLE_HYPERCALL),
+		    "Protected VM advertises VMware hypercall exits");
+	TEST_ASSERT(vmware_caps & KVM_VMWARE_ENABLE_BACKDOOR,
+		    "Protected VM does not advertise the VMware backdoor");
+	errno = 0;
+	ret = __vm_enable_cap(vm, KVM_CAP_X86_VMWARE,
+			      KVM_VMWARE_ENABLE_HYPERCALL);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "Protected VM accepted VMware hypercall exits");
+	vm_enable_cap(vm, KVM_CAP_X86_VMWARE, KVM_VMWARE_ENABLE_BACKDOOR);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	struct vmware_test test;
+	unsigned int supported;
+	int ret;
+
+	supported = kvm_check_cap(KVM_CAP_X86_VMWARE);
+	TEST_REQUIRE(supported & KVM_VMWARE_ENABLE_HYPERCALL);
+
+	test = create_test(false, false, ARG_RAX);
+	errno = 0;
+	ret = __vm_enable_cap(test.vm, KVM_CAP_X86_VMWARE,
+			      KVM_VMWARE_ENABLE_BACKDOOR);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "Enabling VMware flags after vCPU creation should fail");
+	destroy_test(&test);
+
+	test_synchronized_output(false);
+	test_synchronized_output(true);
+
+	test = create_test(true, false, ARG_RAX);
+	run_to_vmware_exit(&test, true, false);
+	destroy_test(&test);
+
+	test = create_test(false, true, ARG_RAX);
+	run_to_vmware_exit(&test, false, true);
+	destroy_test(&test);
+
+	test_valid_exception(UD_VECTOR, 0, 0, false);
+	test_valid_exception(GP_VECTOR, FAULT_ERROR_CODE, 0, false);
+	test_valid_exception(PF_VECTOR, FAULT_ERROR_CODE, FAULT_ADDRESS, true);
+
+	test_invalid_completion(2, UD_VECTOR, 0, 0, 0, 0);
+	test_invalid_completion(1, DE_VECTOR, 0, 0, 0, 0);
+	test_invalid_completion(1, NMI_VECTOR, 0, 0, 0, 0);
+	test_invalid_completion(1, DF_VECTOR, 0, 0, 0, 0);
+	test_invalid_completion(1, 32, 0, 0, 0, 0);
+	test_invalid_completion(1, UD_VECTOR, 1, 0, 0, 0);
+	test_invalid_completion(1, UD_VECTOR, 0, FAULT_ADDRESS, 0, 0);
+	test_invalid_completion(1, GP_VECTOR, 0, FAULT_ADDRESS, 0, 0);
+	test_invalid_completion(0, 0, 0, 0, 1, 0);
+	test_invalid_completion(0, 0, 0, 0, 0, 1);
+
+	test_non_vmware_hypercall();
+	test_protected_rejection();
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
index 2585087cdf5c..096de77884a8 100644
--- a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
@@ -81,6 +81,7 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
+	unsigned int vmware_caps;
 	unsigned int xen_caps;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -88,7 +89,16 @@ int main(int argc, char *argv[])
 	xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
 	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL);
 
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm = vm_create(1);
+	vmware_caps = kvm_check_cap(KVM_CAP_X86_VMWARE);
+	if (vmware_caps & KVM_VMWARE_ENABLE_HYPERCALL) {
+		vm_enable_cap(vm, KVM_CAP_X86_VMWARE,
+			      KVM_VMWARE_ENABLE_HYPERCALL);
+	} else {
+		ksft_print_msg("VMware hypercall exits unavailable; "
+			       "skipping coexistence coverage\n");
+	}
+	vcpu = vm_vcpu_add(vm, 0, guest_code);
 	vcpu_set_hv_cpuid(vcpu);
 
 	struct kvm_xen_hvm_config hvmc = {
-- 
2.53.0

