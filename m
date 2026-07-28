Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B13123D7C2
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199442; cv=none; b=FuXIzetCg1LdRuJnPXHnhH2CxQvVTaTFYP4zNMUaCbEJf0CdKEnYCVoMuiFa2nhzyIkrbOm0c/IBDjUW5mNONDQ4YkRiXu0y7z3DL7JiFvf4gvvdn9xnjilo0MNLhr+bG0mZFe/dtPyD0X5Me8akF1n94g3JyKbswwfWryJ0WVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199442; c=relaxed/simple;
	bh=KnXgjyjfWrZ1Kav/HM0YRzGa3zLfYclxmj3T9MDdpEY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J8qD2qqHGz55IThCPx71GFpwo1d38WEk5IsfmeyrKKlABtNHIk0tAD6WDDDJ5Q6JeU4LWeubLbe6TkR3XNFLBE6pBrvCCEnA4IjIPAjedIYCFgdwpaZctO/z8bfycUYxNOjGaZTilzGFXWk8BeSGEYK5Q3CrujmNA7VZQtOGn/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=im/K0BzG; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="im/K0BzG"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacf17c7e0so45787035ad.0
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785199440; x=1785804240; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kq233dhoaDKQgdxaAZop0K9XdHgfgVQqWKzBXz6++L8=;
        b=im/K0BzGWC/Id+bh5eR/SWYWyiBVDpuMLeS+4P6tf+VaTpdXWVb4WKLuNPWdSsDYLZ
         bRjh4DFz879Cdo821CGQccz8/aQW33wlkKD4It7phRojkfez69SRZGvHzIqB0wZGVjqy
         hxgS2Ui90Z3Jv8jyxialYginEs6iNxQ3TkCwsnT5oy6RW51GRYoHzSXztYi+zrz61IeZ
         6gebALHH0fJGa8YWvgmt8iDN8PCNWuqPh1zqQV/fQ8q3Z1rgDvEaOHBNhA6MffQXP+0t
         1yNLQhR9eNyCR3aKwvFbZsPGlN0Xr393EDEeKh2iM0bGkOpnuLq+0cvB1rB0inm71M2e
         uCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785199440; x=1785804240;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kq233dhoaDKQgdxaAZop0K9XdHgfgVQqWKzBXz6++L8=;
        b=ks13UC1zXvCUWxur942TIYa6dkzJ9IVhBPoCZQskjTfdBdnPr5+WhUevKFCXoOPMTS
         ZlS7aNSzrVQPmvsPpwd/IrgaRBl1CPZq2xywaNrE0dirHM74fNmsoC3BUyAYQFSW+xlR
         BKkFwcy7TzFqzmE1LmeDU8zajZrijJs+7nmzTfcJlXDbiZXCyK3etFUnHbhQsXrIaNZq
         MWg+uvAw1fTwo+fSKmGFUjgyhqbPZM9KiL+XMTq01qpSP/Biwi00nn6U7Cgt9LKXXiEy
         k40goRW8fmtM2lzbxl96YldioBOuDKEMP5ZDQPkso6el2RO5e5dUY698Jrnz+dO9n2ZE
         pkLQ==
X-Gm-Message-State: AOJu0Yy+ISss5+QTV4wPKy8xNxXclTWQnorMGXE4LD1ZLul2imfwkeBo
	csWkucf1i1mrKJbpsqIwo9Msyx0LQiTfP+g1Iwu7lg83+xCDpVqTlAuMmZGdCx33jkJlIvCkYFl
	g2o4Nzg==
X-Received: from plblq13.prod.google.com ([2002:a17:903:144d:b0:2c8:903:9ae7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2cf:b0:2c9:97a7:f543
 with SMTP id d9443c01a7336-2d015d258a7mr1656135ad.41.1785199440298; Mon, 27
 Jul 2026 17:44:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 27 Jul 2026 17:43:51 -0700
In-Reply-To: <20260728004351.887076-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728004351.887076-7-seanjc@google.com>
Subject: [PATCH v4 6/6] KVM: selftests: Extend the invalid nVMX guest state
 test to cover RSM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

From: Hao Zhang <hao_zhang_kdev@163.com>

Extend the invalid nVMX guest state to cover RSM, i.e. to validate that KVM
synthesizes SHUTDOWN for L1 if SMRAM is clobbered with invalid guest state
during an L2 => SMI => RSM => L2 sequence.

Note, unlike the existing testcase, clobbering SMRAM should result in L1,
not L2, getting SHUTDOWN / TRIPLE_FAULT, as RSM is architecturally defined
to trigger shutdown if the CPU detects invalid state.

Not-yet-signed-off-by: Hao Zhang <hao_zhang_kdev@163.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/vmx_invalid_nested_guest_state.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index ab00265d6c94..6f546deb193a 100644
--- a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
+++ b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
@@ -2,6 +2,7 @@
 #include "test_util.h"
 #include "kvm_util.h"
 #include "processor.h"
+#include "smm.h"
 #include "vmx.h"
 
 #include <string.h>
@@ -11,6 +12,22 @@
 
 #define ARBITRARY_IO_PORT 0x80
 
+/*
+ * The 64-bit SMRAM state-save area starts at SMBASE + 0xfe00.  TR starts at
+ * offset 0xfe90, and attributes is the second 16-bit field in the descriptor.
+ */
+#define SMRAM64_TR_ATTRIBUTES_OFFSET	0xfe92
+#define SMRAM_GPA			0x1000000
+
+/*
+ * SMI handler that runs in 16-bit Real Mode.  Syncs with L0 via port I/O, then
+ * executes RSM to trigger the consumption of invalid guest state.
+ */
+static u8 smi_handler[] = {
+	0xe4, ARBITRARY_IO_PORT,	/* IN $ARBITRARY_IO_PORT, %al */
+	0x0f, 0xaa,			/* RSM */
+};
+
 static void l2_guest_code(void)
 {
 	/*
@@ -114,9 +131,45 @@ static void test_invalid_l2_guest_state(void)
 	kvm_vm_free(vm);
 }
 
+static void test_invalid_l2_guest_state_rsm(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u16 *tr_attrs;
+
+	if (!kvm_has_cap(KVM_CAP_X86_SMM))
+		return;
+
+	vm = vm_create_and_run_l2(&vcpu);
+
+	/*
+	 * Inject SMI while L2 is active, run the vCPU to get I/O exit from L1,
+	 * then stuff TR in the SMRAM state-save area so that RSM restores
+	 * invalid L2 state.
+	 */
+	setup_smram(vm, vcpu, SMRAM_GPA, smi_handler, sizeof(smi_handler));
+	inject_smi(vcpu);
+
+	vcpu_run_to_io(vcpu, false);
+
+	/* Clear the present bit in SMRAM to make TR unusable. */
+	tr_attrs = addr_gpa2hva(vm, SMRAM_GPA + SMRAM64_TR_ATTRIBUTES_OFFSET);
+	*tr_attrs &= ~BIT(7);
+
+	vcpu_run(vcpu);
+
+	/*
+	 * For RSM, L1 gets the SHUTDOWN because RSM is architecturally defined
+	 * to result in shutdown if the CPU detects invalid state in SMRAM.
+	 */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
 
 	test_invalid_l2_guest_state();
+	test_invalid_l2_guest_state_rsm();
 }
-- 
2.55.0.229.g6434b31f56-goog

