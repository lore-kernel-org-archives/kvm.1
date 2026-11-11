Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376857;
	b=m9zZAS3lSGNSaS5joNo5DDMvNNVNJP2mrDkPZyFUwBzUynpzXot20HyKMKaprpwCmzLI
	 tEQWn+RJYuleOSRQyVa8Rn/LGBazLua1NQn7W0xnwLHdfgrhs7kGrn7LIGVoArYo2KeUv
	 Qux4ZHygmhjso1VSe5yF6FTamZLWV2C4oaJSzWrm/vB1dC0mdab5nCH6btKcFoWKvn5GH
	 oT0F/8zFuKc1xwH9SMJJOp0VvkMRQUuz6Pm/dx4GToSY0JsKRaMSMA61MgyPqnc8mI7vK
	 D3agwb15epGz0teBlt5/uBc3Pwubp6WeEiNWECCrgDhs/uMu3t1WSD9zkDebPIyMORA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376857;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=fAnMylkcIwCzBcds4wvEKNpzHtQXj/ncrwRzNJMI2gY=;
	b=BIbyuX03qxymP6JCH69yWu39uGIX8bd2CArqAI1wYzTLmcHgFpAZZcpWPBL7+g28fjgb
	 E8X+sTghOV1AksiEWQl48HcpId0FEAzPFNcjoThF8z75KHxcHLw9mmWo8PyytVkFsPrDU
	 1cjRoOwa4ugUkPjoCGvFRdOiowBwcZfNPIWlj1A/Pzp82NDFRIutiHeF/ZZquLzT/X2t+
	 qXs4bjQcrjBVUTOk40RIdwfEA0gmraTmYy3nDx2fRiYnM5JtzK+pwt9v0vJ5GIATRE5bA
	 sJiKgSjafPIAIeZxvDaW2rTmtQ9/QGBo7ViqSOmFmzZ38RoYo5IW3YadjZo1YNBHDYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GBrzmbvw;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3960A6F79
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E3960A6F79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GBrzmbvw
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so1779817a91.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376857; x=1794981657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fAnMylkcIwCzBcds4wvEKNpzHtQXj/ncrwRzNJMI2gY=;
        b=wgX+/cv4idu+USXogldtXzq76MEfJlr60Ll9wL0+6oAeL+0JPEVfDmjQqVsjvatvy8
         1G/xoqLfuMX81hvqImER7VmEQwvIPATz5vkbIFAUPjczkZvLRsExZYWiD5L/3WGKfNnu
         Sz1k8U4sBGDz98WZhYaWSROmOljoA/56NN2DGTtiPAhii8G+JwjHjj8rsXffC0+GSKjt
         yZI8imAfDAhZCI3PPsNiMu867Q2TWt6AEZSm1ArVcGg1s2PyK2t2IHDyjQr7QskpR7Sy
         EsCk9hIfLU1GXubXEhHzrIpXPhXmt7dHw+Irq8U2WqRzEcfEuYlxuG8utyfTcjX2Sq6t
         URVA==
X-Forwarded-Encrypted: i=1; AL+hErFpFyu/l+Q0zLT3xppxe9weqQz549i31VbQvihOHd0crqO/NZxr4m0y8FFtTjQdZb/VPZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9LY9My2mbveHutSxUvhqDFVWDmOna8HAXGDxmqkrZXHkGMfHq8
	MK95dGIVweDVnZiHQtgGdEo2LboDJ7x+vYQgoyaPzr8DlTYEA5q3U4ssfQGfJxf/Sn3JXHGWlGX
	d6DlxzzsAvc+n7HwbIjnS5YpYsZM8A7U6thQ9fUgR2B9VXJBKODlg37sv4akQwP1kGcGoI637Kj
	hzHbSgFeyhL0V/zKCcRnbHg4oyzLPgX3/tIbdtKyk1xXUszkaCVYHeJmcQgKpGYw7w26ozflUrK
	1MP
X-Gm-Gg: AYBFou3PVBslcf5UkzXX4EJLGBeD8Ey1oNlNv5Ycl6d0/6pFCHQVce7TLmWHF/X5ML5
	KvTR0s8VS+m8Ut9PH0XLb+EkY6hO7lknDgzxao5nFZTh+h1T9DJb5j1m+lsd2gyV0lsgLR0nKFO
	+BMAsTgp92aWwO/KKo0wxdH15JWaMe8kbxgM+POvOjkT5s5St9Lj7edp4vo1C95q3WVakt3Lnj+
	pidsBHWGZwMEi+hxwDxNop/OYJlSvOsLc301DITrWRDJOOwjs/EsbFRtOsTZz+2q+X94wwfCpHC
	VRulxjIU+Mjya3LmaKusH1kj9v58U8F1apG1NzehKcs80rdoH1nk/jCSi6ml3gCRiEGenedD/Ez
	1lv+kODmCFLhpMH1qNub43TPKVGSIoZyS7rJL4ZNReaSpZrqlmAxlJz+AkgFvplYF5NmEK5qqwa
	vV+/e0VFEAXMpX++jkYKBgsDdU8OUGJm/d
X-Received: by 2002:a17:90b:4e88:b0:3ac:8741:e2e4 with SMTP id 98e67ed59e1d1-3b182f9c39cmr1582677a91.52.1794376856642;
        Tue, 10 Nov 2026 22:00:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b17e3294bfsm1332967a91.8.2026.11.10.22.00.56
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 22:00:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb7f9bb86so601674685a.2
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 22:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794376855; x=1794981655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fAnMylkcIwCzBcds4wvEKNpzHtQXj/ncrwRzNJMI2gY=;
        b=GBrzmbvwTsBvHVFRYx0H7rt4vCfevXhKDJhG0ZpK001RBPbUDtm36EspvX6rTiWgbF
         BKRXOWzI2hllpigkiwEDAIGxMI5hz4dFri4m7UnZJNhHQp6WkuSKjwcUydD1eqSaRaJq
         tSqeqmsvxXy/O0oy5t5LsDZU23WuIAkUKoCSo=
X-Forwarded-Encrypted: i=1; AL+hErGLqRMcHVkVFny6Bbb9KPdHt539+6LhmlFdGCee5zf3G5/RYl9LANdeH9p6DlCvcK/fJs8=@vger.kernel.org
X-Received: by 2002:a05:620a:4116:b0:93c:a191:88fe with SMTP id af79cd13be357-947afcd01f4mr210495685a.8.1794376854949;
        Tue, 10 Nov 2026 22:00:54 -0800 (PST)
X-Received: by 2002:a05:620a:4116:b0:93c:a191:88fe with SMTP id af79cd13be357-947afcd01f4mr210486185a.8.1794376854139;
        Tue, 10 Nov 2026 22:00:54 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7e7f3bsm411506885a.37.2026.11.10.22.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:00:52 -0800 (PST)
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
Subject: [PATCH v3 12/12] KVM: selftests: Test nested VMware backdoor routing
Date: Wed, 11 Nov 2026 01:00:01 -0500
Message-ID: <60dbf049b84e8d48da4b4c6138e759d8e2cfb92b.1794374897.git.zack.rusin@broadcom.com>
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

Add vmware_nested_backdoor_test.  With KVM_VMWARE_ENABLE_BACKDOOR and
KVM_VMWARE_ENABLE_NESTED_BACKDOOR enabled, run L2 under an L1 that
intercepts #GP, and verify that a VMware backdoor access from CPL3 in
L2 is handled by L0 and exits to userspace.  Verify that an access with
the wrong magic value, one to the first port above the two backdoor
ports, and one from CPL2 still cause a #GP exit to L1, as does a valid
access without the nested flag.  With only the nested flag, expect L0
to handle the access only if enable_vmware_backdoor is set.

This is the situation the flag exists for: L1 receives the #GP for the
backdoor access but can't service it, so only the narrow set of
backdoor accesses may be taken away from L1.  Exercise VMX and SVM
separately, because KVM routes nested exceptions to L1 through
different paths on the two vendors.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 MAINTAINERS                                   |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/vmware_nested_backdoor_test.c     | 223 ++++++++++++++++++
 3 files changed, 225 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a735c9221e..3118792a22df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15050,8 +15050,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/virt/kvm/kvm.git
 T:	git https://github.com/kvm-x86/linux.git
 F:	arch/x86/kvm/vmware.*
-F:	tools/testing/selftests/kvm/x86/vmware_backdoor_test.c
-F:	tools/testing/selftests/kvm/x86/vmware_hypercall_test.c
+F:	tools/testing/selftests/kvm/x86/vmware_*.c
 
 KVM X86 Xen (KVM/Xen)
 M:	David Woodhouse <dwmw2@infradead.org>
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fe7ba905facd..6dd1f336da99 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -142,6 +142,7 @@ TEST_GEN_PROGS_x86 += x86/userspace_io_test
 TEST_GEN_PROGS_x86 += x86/userspace_msr_exit_test
 TEST_GEN_PROGS_x86 += x86/vmware_backdoor_test
 TEST_GEN_PROGS_x86 += x86/vmware_hypercall_test
+TEST_GEN_PROGS_x86 += x86/vmware_nested_backdoor_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_access_test
 TEST_GEN_PROGS_x86 += x86/vmx_apicv_updates_test
 TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
diff --git a/tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.c b/tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.c
new file mode 100644
index 000000000000..3d12be7906e0
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmware_nested_backdoor_test.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025-2026 Broadcom. All Rights Reserved. The term
+ * "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "test_util.h"
+#include "vmx.h"
+
+#define VMWARE_BACKDOOR_PORT	0x5658
+#define VMWARE_MAGIC		0x564d5868
+#define VMPORT_CMD_GETVERSION	0x0a
+
+#define NESTED_BACKDOOR_FLAGS	(KVM_VMWARE_ENABLE_BACKDOOR | \
+				 KVM_VMWARE_ENABLE_NESTED_BACKDOOR)
+
+struct nested_backdoor_case {
+	u64 flags;
+	u64 rax;
+	u64 rdx;
+	u32 cpl;
+	bool expect_l0;
+};
+
+static struct nested_backdoor_case guest_case;
+
+static void guest_done_handler(struct ex_regs *regs)
+{
+	GUEST_DONE();
+}
+
+static void l2_guest_code(void)
+{
+	unsigned long rax = guest_case.rax;
+	unsigned long rbx = 0;
+	unsigned long rcx = VMPORT_CMD_GETVERSION;
+	unsigned long rdx = guest_case.rdx;
+
+	asm volatile("inl %%dx, %%eax"
+		     : "+a"(rax), "+b"(rbx), "+c"(rcx), "+d"(rdx));
+	GUEST_ASSERT(guest_case.expect_l0);
+	asm volatile("int3");
+}
+
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	generic_svm_setup(svm, l2_guest_code);
+	vmcb->control.intercept_exceptions |= BIT_ULL(GP_VECTOR);
+
+	vmcb->save.cpl = guest_case.cpl;
+	vmcb->save.cs.selector = USER_CS_SELECTOR | guest_case.cpl;
+	vmcb->save.cs.attrib &= ~SVM_SELECTOR_DPL_MASK;
+	vmcb->save.cs.attrib |= guest_case.cpl << SVM_SELECTOR_DPL_SHIFT;
+	vmcb->save.ss.selector = USER_DS_SELECTOR | guest_case.cpl;
+	vmcb->save.ss.attrib &= ~SVM_SELECTOR_DPL_MASK;
+	vmcb->save.ss.attrib |= guest_case.cpl << SVM_SELECTOR_DPL_SHIFT;
+	vmcb->save.ds.selector = USER_DS_SELECTOR | guest_case.cpl;
+	vmcb->save.ds.attrib &= ~SVM_SELECTOR_DPL_MASK;
+	vmcb->save.ds.attrib |= guest_case.cpl << SVM_SELECTOR_DPL_SHIFT;
+	vmcb->save.es.selector = USER_DS_SELECTOR | guest_case.cpl;
+	vmcb->save.es.attrib &= ~SVM_SELECTOR_DPL_MASK;
+	vmcb->save.es.attrib |= guest_case.cpl << SVM_SELECTOR_DPL_SHIFT;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	if (!guest_case.expect_l0) {
+		GUEST_ASSERT_EQ(vmcb->control.exit_code,
+				SVM_EXIT_EXCP_BASE + GP_VECTOR);
+		GUEST_DONE();
+	}
+	GUEST_FAIL("L1 received nested SVM exit 0x%lx",
+		   vmcb->control.exit_code);
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	prepare_for_vmx_operation(vmx);
+	load_vmcs(vmx);
+	prepare_vmcs(vmx, l2_guest_code);
+
+	vmwrite(EXCEPTION_BITMAP, BIT_ULL(GP_VECTOR));
+	vmwrite(GUEST_CS_SELECTOR, USER_CS_SELECTOR | guest_case.cpl);
+	vmwrite(GUEST_CS_AR_BYTES, 0xa09b | guest_case.cpl << 5);
+	vmwrite(GUEST_SS_SELECTOR, USER_DS_SELECTOR | guest_case.cpl);
+	vmwrite(GUEST_SS_AR_BYTES, 0xc093 | guest_case.cpl << 5);
+	vmwrite(GUEST_DS_SELECTOR, USER_DS_SELECTOR | guest_case.cpl);
+	vmwrite(GUEST_DS_AR_BYTES, 0xc093 | guest_case.cpl << 5);
+	vmwrite(GUEST_ES_SELECTOR, USER_DS_SELECTOR | guest_case.cpl);
+	vmwrite(GUEST_ES_AR_BYTES, 0xc093 | guest_case.cpl << 5);
+
+	vmlaunch();
+	if (!guest_case.expect_l0) {
+		GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON) & 0xffff,
+				EXIT_REASON_EXCEPTION_NMI);
+		GUEST_ASSERT_EQ(vmread(VM_EXIT_INTR_INFO) & 0xff,
+				GP_VECTOR);
+		GUEST_DONE();
+	}
+	GUEST_FAIL("L1 received nested VMX exit 0x%lx",
+		   vmread(VM_EXIT_REASON));
+}
+
+static void __attribute__((__flatten__)) l1_guest_code(void *test_data)
+{
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_svm_code(test_data);
+	else
+		l1_vmx_code(test_data);
+}
+
+static void setup_user_environment(struct kvm_vm *vm)
+{
+	struct idt_entry *idt = addr_gva2hva(vm, vm->arch.idt);
+
+	idt[BP_VECTOR].dpl = 3;
+	vm_install_exception_handler(vm, BP_VECTOR, guest_done_handler);
+	vm_init_user_mode(vm);
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
+static void run_test(const struct nested_backdoor_case *test_case)
+{
+	gva_t nested_test_data_gva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int port_exits = 0;
+
+	vm = vm_create(1);
+	guest_case = *test_case;
+	sync_global_to_guest(vm, guest_case);
+	vm_enable_cap(vm, KVM_CAP_X86_VMWARE, test_case->flags);
+	vcpu = vm_vcpu_add(vm, 0, l1_guest_code);
+
+	if (kvm_cpu_has(X86_FEATURE_SVM))
+		vcpu_alloc_svm(vm, &nested_test_data_gva);
+	else
+		vcpu_alloc_vmx(vm, &nested_test_data_gva);
+	vcpu_args_set(vcpu, 1, nested_test_data_gva);
+	setup_user_environment(vm);
+
+	for (;;) {
+		struct kvm_run *run = vcpu->run;
+		struct ucall uc;
+
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		if (run->io.port == VMWARE_BACKDOOR_PORT) {
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
+			TEST_ASSERT_EQ(port_exits, test_case->expect_l0);
+			kvm_vm_free(vm);
+			return;
+		default:
+			TEST_FAIL("Unexpected I/O exit on port 0x%x (ucall 0x%lx)",
+				  run->io.port, uc.cmd);
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	bool module_default = get_kvm_param_bool("enable_vmware_backdoor");
+	const struct nested_backdoor_case test_cases[] = {
+		{ NESTED_BACKDOOR_FLAGS,
+		  VMWARE_MAGIC, VMWARE_BACKDOOR_PORT, 3, true },
+		{ NESTED_BACKDOOR_FLAGS,
+		  0, VMWARE_BACKDOOR_PORT, 3, false },
+		{ NESTED_BACKDOOR_FLAGS,
+		  VMWARE_MAGIC, VMWARE_BACKDOOR_PORT + 2, 3, false },
+		{ NESTED_BACKDOOR_FLAGS,
+		  VMWARE_MAGIC, VMWARE_BACKDOOR_PORT, 2, false },
+		/* L1 keeps the #GP without the nested flag... */
+		{ KVM_VMWARE_ENABLE_BACKDOOR,
+		  VMWARE_MAGIC, VMWARE_BACKDOOR_PORT, 3, false },
+		/* ...and the nested flag needs the backdoor to be enabled. */
+		{ KVM_VMWARE_ENABLE_NESTED_BACKDOOR,
+		  VMWARE_MAGIC, VMWARE_BACKDOOR_PORT, 3, module_default },
+	};
+	unsigned int supported;
+	int i;
+
+	supported = kvm_check_cap(KVM_CAP_X86_VMWARE);
+	TEST_REQUIRE((supported & NESTED_BACKDOOR_FLAGS) ==
+		     NESTED_BACKDOOR_FLAGS);
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) ||
+		     kvm_cpu_has(X86_FEATURE_VMX));
+
+	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
+		run_test(&test_cases[i]);
+
+	return 0;
+}
-- 
2.53.0

