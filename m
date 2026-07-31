Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB244E67E
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519234; cv=none; b=svCcTFSQGLBTnqk7LNwWOPiJGZdKgiPUdqtv2uvEv8BJukzrL91sx+uALkMCeY8RYTpk/48INg3jMKw+tef6Gu1udDVEvTjOtkfb/GjoYr+6R6uGGy6vb0rISJZshhAi8rHaeXX5qVUmxYpRbOAjHzcLBesNSI+4i2jEH3rrLUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519234; c=relaxed/simple;
	bh=+gogjg/3D4gQHcPEQRIYtYjXFvse8XsAoXE16fKGJuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YeHq5S/aumm/PJC3SJ1/lMXaJdWBOresvgjFOMOLqAOwTIw4A71ae3i60i9rO6hQWOZGToqxxf9KXD7/gstUfnOhcNIn3sZtRtE1YlQAOfOfO6wxVbKHA5TsD0ehukMnrgfZzFI9GeEMKxSseehNthk26cyvWcJkqFY52W53cd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQfjOLfj; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQfjOLfj"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so1996981a91.0
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519230; x=1786124030; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OXBC54gDOgEf6948QYc+7NMHsIhOHZjkaHYeMetA6x8=;
        b=CQfjOLfjsLWberS6pngvlxSL4xKcz0E2CVF/ly/7Fgg4rrNZwxW3PFaRAme52U/lE0
         1IlqPZCqu64RYPQPivIltkkknQZl0Hg+GUSFZmj93zJS1U4ZsY2HYD1EGGsuh5nMSyJs
         do8ZV5nUPQZroOKMQlTWA7sajf24H6FzeYfAgEZPOd+DnNssOEuf9ZdhXjuwDnJ57ItV
         suh2LXCKLVPnR038L2M65vNHhcIlbgfF4rmZMjWCM7yGVW1d9KuA2nQduCcwzvFrRN3m
         9uQUECQoL9fcgroAMnBnw9Xq9m5+chhaj5UbFMz7y7+1ffbCuVB/+nRbMj5130uqvSdr
         qnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519230; x=1786124030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OXBC54gDOgEf6948QYc+7NMHsIhOHZjkaHYeMetA6x8=;
        b=OBB3MiHffhknNmr6XU/fcTLIxAP7KFHQj2OpQ549GowBop2CHZfXVotAuYeOdLqA7h
         1vL8WeoBlGqWAejpU+WrmeK4ojSfloYs9MibmlOr6x6tHSRsi3/NI1CM3nu517CGS0ts
         r9sIEGL1hrB7ujUX2dDBfQNS/qu+YmjTx5OQ4Pr9KxHubjY9HObdX5gPRfTod+kv+BcP
         XxUosO+7WgRXM0u9Z0/YvO9PCbXioOTnqoL14VBXRhvquwjkpoQIxTV8k/MqZgzmVxOD
         7HAL7VVDD63ht2HUbtY/SJKaYpXhkIhOE1o0kNvkHjWbiVkKoPa9GFO4j/YIOmQNdbwO
         qxyA==
X-Gm-Message-State: AOJu0YzH8JOG1I/vwllKkPyk9JuT3l8PlUws2zxIrOWjZVujFlhciTf9
	J1AAa7mygj7rAC/t73PXkbTPENJj0/3Rx0ebOlm+BEiAXnWbRELGWSVAlj1nk6yj75bL8hiCNWV
	AIpi67Q==
X-Received: from pghm11.prod.google.com ([2002:a63:f60b:0:b0:c8a:604f:6851])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:93a1:b0:3c4:2cf9:2896
 with SMTP id adf61e73a8af0-3c92a8af306mr633679637.45.1785519229414; Fri, 31
 Jul 2026 10:33:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jul 2026 10:33:40 -0700
In-Reply-To: <20260731173340.2644656-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260731173340.2644656-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
Message-ID: <20260731173340.2644656-7-seanjc@google.com>
Subject: [PATCH v5 6/6] KVM: selftests: Extend the invalid nVMX guest state
 test to cover RSM
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hao Zhang <zhanghao1@kylinos.cn>, Hao Zhang <hao_zhang_kdev@163.com>
Content-Type: text/plain; charset="UTF-8"

From: Hao Zhang <hao_zhang_kdev@163.com>

Extend the invalid nVMX guest state to cover RSM, i.e. to validate that KVM
synthesizes SHUTDOWN for L1 if SMRAM is clobbered with invalid guest state
during an L2 => SMI => RSM => L2 sequence.

Note, unlike the existing testcase, clobbering SMRAM should result in L1,
not L2, getting SHUTDOWN / TRIPLE_FAULT, as RSM is architecturally defined
to trigger shutdown if the CPU detects invalid state.

Signed-off-by: Hao Zhang <hao_zhang_kdev@163.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86/vmx_invalid_nested_guest_state.c  | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c b/tools/testing/selftests/kvm/x86/vmx_invalid_nested_guest_state.c
index 4b1bb190c2c6..c8379124b317 100644
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
2.55.0.508.g3f0d502094-goog

