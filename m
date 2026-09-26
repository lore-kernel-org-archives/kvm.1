Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62E7371CFF
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400794; cv=none; b=g1/8LDTQKM1TpAtbxh2RWgspIVLxagVED3z9LOgq92pSrGpNfCcPSJqN1l5y62pbwrTalHdl0WF8vS0/foGzLtIQkgi79MnK0Ka18Du0a1WzOYQfaswbazAI3wvgnMZ2UOYgX3OXdotDwIpl36IRq0mngs2snvp78gS/ghbW3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400794; c=relaxed/simple;
	bh=xcWx2XfEoFQY0Oze+QRhr1BZnMwBGrdUDI8F5ui96Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7gc2Mct6N0Qbpq/FSEsHdyqSsJXXs+cklEMmLczM4/Ghoy7TXypNxZUzyZP4NqZNjwbl3XbkmxXk9HJmvYwS6jiFSjVpk1ioLK8A3IhBfhRYCTZ7VZdivSLlBmHpX618Ga8O2dc+PXwg016nV/u6GmVJ+p9/0hp3xtMDHv1zEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYQJ3d73; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYQJ3d73"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9D7UxZMovIJPaD3/L8K7Sdj8yR5mvMSMSxU70deVL8=;
	b=JYQJ3d73d1ekMwnAksIIX+4TjGNfdsNjhAmugr6kVxF6SnNRpn/yQqtTlZNrFdx1bWOkIl
	SxhNx1JXWR+4zZNpXsLRTyaCocAh5b05lOHWrfC7t5HIsZ3IaLJpi7o1sxQ7uToillrsMh
	Pemem8H3cnodyOCi2Re+oe1lbV2c1Ag=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-apraSQZBOfu2yfbh5kyX4g-1; Sat,
 26 Sep 2026 01:33:01 -0400
X-MC-Unique: apraSQZBOfu2yfbh5kyX4g-1
X-Mimecast-MFC-AGG-ID: apraSQZBOfu2yfbh5kyX4g_1790400781
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6181180AE30;
	Sat, 26 Sep 2026 05:33:00 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 629C41956086;
	Sat, 26 Sep 2026 05:33:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 08/11] KVM: selftests: Run the nested x2APIC with and without APICv being inhibited in L2
Date: Sat, 26 Sep 2026 01:32:50 -0400
Message-ID: <20260926053253.195597-9-pbonzini@redhat.com>
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
Message-ID: <20260813223610.2043560-4-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/kvm/x86/nested_x2apic_test.c    | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index e77b4c347272..a1072bf499ee 100644
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@ -15,6 +15,7 @@
 #define POSTED_INTR_WAKEUP_VECTOR	0xf1
 #define POSTED_INTR_NESTED_VECTOR	0xf0
 
+static bool inhibit_apicv;
 static volatile unsigned int nr_irqs;
 
 static void guest_irq_handler(struct ex_regs *regs)
@@ -25,7 +26,8 @@ static void guest_irq_handler(struct ex_regs *regs)
 
 static void l2_guest_code(void)
 {
-	wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & GENMASK_ULL(11, 0));
+	if (inhibit_apicv)
+		wrmsr(MSR_IA32_APICBASE, rdmsr(MSR_IA32_APICBASE) & GENMASK_ULL(11, 0));
 	asm volatile("cpuid" ::: "eax", "ebx", "ecx", "edx");
 }
 
@@ -78,20 +80,20 @@ static void l1_guest_code(void *test_data)
 	GUEST_DONE();
 }
 
-int main(int argc, char *argv[])
+static void __test_x2apic_intercepts(void)
 {
 	gva_t nested_test_data_gva;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
-
 	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
 	vm_install_exception_handler(vm, POSTED_INTR_VECTOR, guest_irq_handler);
 	vm_install_exception_handler(vm, POSTED_INTR_WAKEUP_VECTOR, guest_irq_handler);
 	vm_install_exception_handler(vm, POSTED_INTR_NESTED_VECTOR, guest_irq_handler);
 
+	sync_global_to_guest(vm, inhibit_apicv);
+
 	if (kvm_cpu_has(X86_FEATURE_SVM))
 		vcpu_alloc_svm(vm, &nested_test_data_gva);
 	else
@@ -115,3 +117,18 @@ int main(int argc, char *argv[])
 
 	kvm_vm_free(vm);
 }
+
+#define test_x2apic_intercepts(inhibit_apic_setting)	\
+do {							\
+	inhibit_apic_setting;				\
+							\
+	__test_x2apic_intercepts();			\
+} while (0)
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
+
+	test_x2apic_intercepts(inhibit_apicv = true);
+	test_x2apic_intercepts(inhibit_apicv = false);
+}
-- 
2.52.0


