Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9B3EB7F1
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174271; cv=none; b=J1ThPj8bZR7YG0IRxeYyNJLRxUMuUcPasrls7zl1diQkLoYmKFDzym8hSauVT8C5VHUr253TX2GEK2OfKZ1n2NpNdPepvrFprgjxbcVR3JACPq4VHJ6NVHhOkfBZeDiEC4J9BnFlxJzoSeDW8HBFjYahn3vGfn3c44fdBR0D5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174271; c=relaxed/simple;
	bh=6rB+UB1kEMw6k+b86L/qIAQ+B3zVuFeQgsyZVjk7hWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSw/UYkCKKDTYKwGVkHYu+/y4jyVd1fwVfSq4UCTWaJZL9qMhVXLcj6GoywzwwCdsaBtiCu58cGgpOvBXSiemu5oLwb/3w3Qp9o9sN0MWNsNAXtlnnpLVnGSdBuDdNBR0iv3xOTSry2TnA4GgPk4r4EGAiwETU11G86eFMyZqZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7iBk7An; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l5XQUBdm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7iBk7An";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l5XQUBdm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773174269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhOFlLPWZiB7d69MOKPXsBv2+W178XJ/rSiUNGxujFE=;
	b=L7iBk7AnCiKJ2pVwk5zGgJeaIvpDNoxIkYB1xFQxisQRVAN95fpSqXiMNG6XseDae5rUR9
	L7x+TI04+HvpuYz0oTuCg+qvev/b87LCpra92JBDh70uoFwjuVDqmvr+2+kYrTH7g4tlff
	I0qVtYjmFjAn94m7g9EAX8KRcx8VBqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-L4p3XYPJP7GJH8GZSGidGQ-1; Tue, 10 Mar 2026 16:24:27 -0400
X-MC-Unique: L4p3XYPJP7GJH8GZSGidGQ-1
X-Mimecast-MFC-AGG-ID: L4p3XYPJP7GJH8GZSGidGQ_1773174267
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485335f4466so26899055e9.0
        for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773174266; x=1773779066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhOFlLPWZiB7d69MOKPXsBv2+W178XJ/rSiUNGxujFE=;
        b=l5XQUBdmVrT+ewRmTjOO+nADGU6txzrWISBoLBnfJKCvlEXpEe2A5SBlTRBG1refRa
         7yosjJKXblqdcN++Bw5sknOmRJOmWtBxN0LQZvaROLEX1foju63ZGbJEDc2DMx5MCafS
         kh5f+KTUANTaKcR2Ielm3FuKaveifyWalQM5guptC2qSZrlACkrpWcshTLqLC0VOaGTv
         pwdaYKDgT3ho+pQIs4qavw8940GJYUSPaUFCkGSIpWBDOVUNvHU2OYJhQzo8BPab79TW
         xvkyHMJG5CDMFpvT3BqJQGWNLBx/YvyJ4q5MIHVcQhe3mB7S1pGKbOoEq4gaXP5E3o4T
         16Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174266; x=1773779066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LhOFlLPWZiB7d69MOKPXsBv2+W178XJ/rSiUNGxujFE=;
        b=YRHPhwdjsT0B106BExFxUHbvkJDcowncgVdBsOJmFKE9H6FGXl47nvp49UX18HH8yS
         jTA9pQS7D6A00PoYJDcsMO6ZIx53wbFtxSU6vJ/vLJ78fKhWC9yiAoUFJev4cQE66fA6
         0r/8WTw+QpsGo/4wnxDxSOSUMwS7uCoKY/sgACgopDwdxrqXbkp50ILXh+BXz1pByeUw
         y5XioyIlR3HbgtDgBfjZ+2RKvdgT26s8h9XFHVws5heosZ0bxNOeWzls1JYOqj+CuIRv
         RFSg5N9Qh0ljx9Javmllor3DKPHyWCe94S13AqqJFtQraO189XqzmylYLtCIuZVZzOPl
         C38A==
X-Forwarded-Encrypted: i=1; AJvYcCVEU5Ugwf5qP0bkeIKTejuVs6+neQifqfEn6BtJH9pULuZFr48wD3U1Esckl2wHLJY4UhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTG5k30r+22TFOrrmmXUkmk5eCRgt9I6xoVh4717vf8Y7FsCNu
	gN5k0wrkBn4QbqJlFcJOD11M5VvSJn7wwukrad0Z5AjmykRgJojfpRpioiA3DQIo8onkAkMgpFR
	xiRi2R5deONBuTBqY3c3f5F2x/8orfAqYvokYMZkSTlJaT8ilqmDAHw==
X-Gm-Gg: ATEYQzxBzQV9aOue5uWdflcW68w2MTi43U5LR2ETRKRyr/4UTMbs5RgwHLcX7bpoECs
	5rsawyXkc7CnOn1IfBo2PzaY7fP1qI0e5JJhGbMKPjmlmdsY8HWdXxhhauH5eq1Rrdn97iKj6WY
	ZPbaf7NTUnbOsYtcYZzRlP1rEY9PGeQ7jHEWxwh4tKTmXsoVqLq7kyaMWj05R3B8AJC/gPK0Woy
	roiQ1BRTHhZvcIBXQHxKSUIMoilRqmJ/CcJHlKbzIlS26nv+k9FgA/7eM1rIOV76LzXH1H+UOIj
	4J30RP5SwMx/3GPi5J4j+JkoIfFGX0b7JbEJJc1YKuJ/Om5zAi/9m6U9l1AOd7XyjsLQ6BvhZrU
	A8O2AsrW+WIGmgL5mNubMCLYXMJLsubCJmFuvVauBuflG4NyjflXpz3Bv8vofO2W/xubVZAeu1X
	qRZ8pAGa7g6l2qlk4E95XmgDhLncQ=
X-Received: by 2002:a05:600c:4f95:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-4854b13e0f6mr1539325e9.33.1773174266475;
        Tue, 10 Mar 2026 13:24:26 -0700 (PDT)
X-Received: by 2002:a05:600c:4f95:b0:483:3380:ca11 with SMTP id 5b1f17b1804b1-4854b13e0f6mr1538915e9.33.1773174265985;
        Tue, 10 Mar 2026 13:24:25 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a307bc4sm4723665e9.3.2026.03.10.13.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 13:24:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	xinyang@anthropic.com,
	stable@vger.kernel.org
Subject: [PATCH 4/5] selftests: kvm: add a test that VMX validates controls on RSM
Date: Tue, 10 Mar 2026 21:24:13 +0100
Message-ID: <20260310202414.406078-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310202414.406078-1-pbonzini@redhat.com>
References: <20260310202414.406078-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test checking that invalid eVMCS contents are validated after an
RSM instruction is emulated.

The failure mode is simply that the RSM succeeds, because KVM virtualizes
NMIs anyway while running L2; the two pin-based execution controls used
by the test are entirely handled by KVM and not by the processor.

Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/evmcs_smm_controls_test.c         | 150 ++++++++++++++++++
 2 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e85467..dc68371f76a3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -71,6 +71,7 @@ TEST_GEN_PROGS_x86 += x86/cpuid_test
 TEST_GEN_PROGS_x86 += x86/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86 += x86/dirty_log_page_splitting_test
 TEST_GEN_PROGS_x86 += x86/feature_msrs_test
+TEST_GEN_PROGS_x86 += x86/evmcs_smm_controls_test
 TEST_GEN_PROGS_x86 += x86/exit_on_emulation_failure_test
 TEST_GEN_PROGS_x86 += x86/fastops_test
 TEST_GEN_PROGS_x86 += x86/fix_hypercall_test
diff --git a/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
new file mode 100644
index 000000000000..af7c90103396
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/evmcs_smm_controls_test.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Red Hat, Inc.
+ *
+ * Test that vmx_leave_smm() validates vmcs12 controls before re-entering
+ * nested guest mode on RSM.
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "smm.h"
+#include "hyperv.h"
+#include "vmx.h"
+
+#define SMRAM_GPA	0x1000000
+#define SMRAM_STAGE	0xfe
+
+#define SYNC_PORT	0xe
+
+#define STR(x) #x
+#define XSTR(s) STR(s)
+
+/*
+ * SMI handler: runs in real-address mode.
+ * Reports SMRAM_STAGE via port IO, then does RSM.
+ */
+static uint8_t smi_handler[] = {
+	0xb0, SMRAM_STAGE,    /* mov $SMRAM_STAGE, %al */
+	0xe4, SYNC_PORT,      /* in $SYNC_PORT, %al */
+	0x0f, 0xaa,           /* rsm */
+};
+
+static inline void sync_with_host(uint64_t phase)
+{
+	asm volatile("in $" XSTR(SYNC_PORT) ", %%al \n"
+		     : "+a" (phase));
+}
+
+static void l2_guest_code(void)
+{
+	sync_with_host(1);
+
+	/* After SMI+RSM with invalid controls, we should not reach here. */
+	vmcall();
+}
+
+static void guest_code(struct vmx_pages *vmx_pages,
+		       struct hyperv_test_pages *hv_pages)
+{
+#define L2_GUEST_STACK_SIZE 64
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	/* Set up Hyper-V enlightenments and eVMCS */
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
+	evmcs_enable();
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(load_evmcs(hv_pages));
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	GUEST_ASSERT(!vmlaunch());
+
+	/* L2 exits via vmcall if test fails */
+	sync_with_host(2);
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t vmx_pages_gva = 0, hv_pages_gva = 0;
+	struct hyperv_test_pages *hv;
+	struct hv_enlightened_vmcs *evmcs;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct kvm_regs regs;
+	int stage_reported;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_SMM));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	setup_smram(vm, vcpu, SMRAM_GPA, smi_handler, sizeof(smi_handler));
+
+	vcpu_set_hv_cpuid(vcpu);
+	vcpu_enable_evmcs(vcpu);
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	hv = vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
+	vcpu_args_set(vcpu, 2, vmx_pages_gva, hv_pages_gva);
+
+	vcpu_run(vcpu);
+
+	/* L2 is running and syncs with host.  */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	vcpu_regs_get(vcpu, &regs);
+	stage_reported = regs.rax & 0xff;
+	TEST_ASSERT(stage_reported == 1,
+		    "Expected stage 1, got %d", stage_reported);
+
+	/* Inject SMI while L2 is running.  */
+	inject_smi(vcpu);
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	vcpu_regs_get(vcpu, &regs);
+	stage_reported = regs.rax & 0xff;
+	TEST_ASSERT(stage_reported == SMRAM_STAGE,
+		    "Expected SMM handler stage %#x, got %#x",
+		    SMRAM_STAGE, stage_reported);
+
+	/*
+	 * Guest is now paused in the SMI handler, about to execute RSM.
+	 * Hack the eVMCS page to set-up invalid pin-based execution
+	 * control (PIN_BASED_VIRTUAL_NMIS without PIN_BASED_NMI_EXITING).
+	 */
+	evmcs = hv->enlightened_vmcs_hva;
+	evmcs->pin_based_vm_exec_control |= PIN_BASED_VIRTUAL_NMIS;
+	evmcs->hv_clean_fields = 0;
+
+	/*
+	 * Trigger copy_enlightened_to_vmcs12() via KVM_GET_NESTED_STATE,
+	 * copying the invalid pin_based_vm_exec_control into cached_vmcs12.
+	 */
+	union {
+		struct kvm_nested_state state;
+		char state_[16384];
+	} nested_state_buf;
+
+	memset(&nested_state_buf, 0, sizeof(nested_state_buf));
+	nested_state_buf.state.size = sizeof(nested_state_buf);
+	vcpu_nested_state_get(vcpu, &nested_state_buf.state);
+
+	/*
+	 * Resume the guest.  The SMI handler executes RSM, which calls
+	 * vmx_leave_smm().  nested_vmx_check_controls() should detect
+	 * VIRTUAL_NMIS without NMI_EXITING and cause a triple fault.
+	 */
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.53.0

