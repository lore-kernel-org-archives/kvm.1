Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E037FF70
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400794; cv=none; b=PGiP+9tiIVwrUcp28XJUzqcmanytHfWvnKg4/x4DrRfDBjzDZNQ60F6G6/+hXRA8guqiUElb6n7KGHEMvxloPK7sVuAey50mHVmC6vV9J0HSQcwTMxYUvW2LAayhKg1M4G8Eot6Z4N0KV9RcPwbeQSOUFtdbeqkwFgI/hUWBxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400794; c=relaxed/simple;
	bh=84jBuZHjvWEOYvlqApKE2itRSyEZzTuRi0uFVjZZObI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fihfedDYsS+V28aMLcZsx21CNGCDluMC09aTZibsyHwObjIapf6TAwQf8duiuE28usRgKwl+jtRWFIP6jQpFL7VEpIG9EERFXTqNlAlq2N6cHiwcH0MSxfw2AIkwZM2xHD7BXfE6BkfcGLNZokzT5tQmsGPDzWC2wmhbNSBJeJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BrUNv1jG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrUNv1jG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va45/tLKH02wPDVhyav7hTl+b7KSNm6AR5n1eHsIfgs=;
	b=BrUNv1jGTF1d4fMsArBMtZ1wCWqlXr0QSAV5J8crfxkYUq7tdgwCqnsvqj9rUfOdbdRRL9
	vlzX4/ST5znhl0fd+p+0TqKu75lHRREfeSoi7hCtk+waxPf8MOc1FWBGmWtWQu7jCEsYYa
	yBwpby8j6Q0ctB1XNKF/YaO6lmOwBJ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-A1kVxPFENoeeJRKAqlbS0w-1; Sat,
 26 Sep 2026 01:33:03 -0400
X-MC-Unique: A1kVxPFENoeeJRKAqlbS0w-1
X-Mimecast-MFC-AGG-ID: A1kVxPFENoeeJRKAqlbS0w_1790400782
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7A341800632;
	Sat, 26 Sep 2026 05:33:02 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33D651956042;
	Sat, 26 Sep 2026 05:33:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 10/11] KVM: selftests: Extend nested x2APIC test to validate disabling x2APIC virt
Date: Sat, 26 Sep 2026 01:32:52 -0400
Message-ID: <20260926053253.195597-11-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260813223610.2043560-6-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/kvm/x86/nested_x2apic_test.c    | 74 ++++++++++++++++---
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index 3b59ba3e3342..e94d4e77256b 100644
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@ -29,10 +29,12 @@ static void l2_guest_code(void)
 	if (inhibit_apicv)
 		wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & GENMASK_ULL(11, 0));
 
-	x2apic_write_reg(APIC_TASKPRI, 0xf0);
-	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xf0);
+	for (;;) {
+		x2apic_write_reg(APIC_TASKPRI, 0xf0);
+		GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0xf0);
 
-	asm volatile("cpuid" ::: "eax", "ebx", "ecx", "edx");
+		asm volatile("cpuid" ::: "eax", "ebx", "ecx", "edx");
+	}
 }
 
 static void l1_svm_code(struct svm_test_data *svm)
@@ -58,22 +60,52 @@ static void l1_vmx_code(struct vmx_pages *vmx)
 	prepare_vmcs(vmx, NULL);
 	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP, (unsigned long)l2_guest_code), 0);
 
+	control = vmreadz(PIN_BASED_VM_EXEC_CONTROL);
+	control |= PIN_BASED_EXT_INTR_MASK;
+	vmwrite(PIN_BASED_VM_EXEC_CONTROL, control);
+
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
-	control |= CPU_BASED_USE_MSR_BITMAPS;
+	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_TPR_SHADOW;
 	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
 
+	if (control & CPU_BASED_ACTIVATE_SECONDARY_CONTROLS) {
+		control = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+		control |= SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+			   SECONDARY_EXEC_APIC_REGISTER_VIRT |
+			   SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY;
+		control &= (rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2) >> 32);
+		GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
+	}
+
 	GUEST_ASSERT(!vmlaunch());
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
+	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
+			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
 }
 
-static void l1_guest_code(void *test_data)
+static void l1_vmx_code_part2(void)
 {
-	x2apic_enable();
+	u64 control;
 
-	if (this_cpu_has(X86_FEATURE_SVM))
-		l1_svm_code(test_data);
-	else
-		l1_vmx_code(test_data);
+	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
+	control &= ~CPU_BASED_TPR_SHADOW;
+	GUEST_ASSERT_EQ(vmwrite(CPU_BASED_VM_EXEC_CONTROL, control), 0);
+
+	control = vmread(SECONDARY_VM_EXEC_CONTROL, &control);
+	control &= ~(SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
+			SECONDARY_EXEC_APIC_REGISTER_VIRT |
+			SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY);
+	GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, control), 0);
+
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_CPUID);
+	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP,
+			vmreadz(GUEST_RIP) + vmreadz(VM_EXIT_INSTRUCTION_LEN)), 0);
+}
+
+static void l1_test_x2apic_intercepts(void)
+{
+	GUEST_ASSERT_EQ(nr_irqs, 0);
 
 	sti_nop();
 
@@ -93,6 +125,28 @@ static void l1_guest_code(void *test_data)
 	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT | POSTED_INTR_NESTED_VECTOR);
 	GUEST_ASSERT_EQ(nr_irqs, 3);
 
+	nr_irqs = 0;
+}
+
+static void l1_guest_code(void *test_data)
+{
+	x2apic_enable();
+
+	if (this_cpu_has(X86_FEATURE_SVM))
+		l1_svm_code(test_data);
+	else
+		l1_vmx_code(test_data);
+
+	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0);
+	x2apic_write_reg(APIC_TASKPRI, 0xf0);
+
+	l1_test_x2apic_intercepts();
+
+	if (this_cpu_has(X86_FEATURE_VMX))
+		l1_vmx_code_part2();
+
+	l1_test_x2apic_intercepts();
+
 	GUEST_DONE();
 }
 
-- 
2.52.0


