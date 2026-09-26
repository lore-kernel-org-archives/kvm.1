Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D681381AF0
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400794; cv=none; b=TMP/KZqIAHF1eVROMh6Kog/cMMX15NhrP0daz9Hmy7z2ZpnklFk6zAbZkxcgU/IBH0S4b4hSOmUdTnMVGTRxTAuUvcRfCp1yNbwGE4C+aWipRy6Ir8Qt0k9mYms/d0wQd6MsqvxXBm0hQ21fn8Kj4U5eZatCHxMyRPOPkeapilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400794; c=relaxed/simple;
	bh=LMp023DhEIXcR4ErkWRS5BQ4rWfJzKmQCi8TPCAek/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjD29XWZ5FC19mxtvH2cvUn4Lh08nu6L08ABd3iLjqFlBBjp3BSSHAkmt9gJSLxpVPwyzeYiafYf4Uaq69E0REpRV+2O7r+MG51UuQ6Vnuk0QDpZau8aUlyPf+5i2b0DBLpzVf1GHfe7NWMtCf9VDJIxsWptKNQtpYiQO40Klhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuffYMjD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuffYMjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KNVOV0eyh2M4+KXjnLvAqRSBgpIqHoq9eBpyO/IwUuQ=;
	b=HuffYMjDwaXMUeFhR/soNHEDO9/DuwiZg6fuKbDMBLqL45juxpeWoFO9mCsMxtLUYq4KKM
	hdyO7CRw9BFYctYFpt5OltQq7U/AyEqfxYK/MswxGBR3jL4iJd3Q/yvyq+22i1fdzABXhi
	3xZ9MgVmzuFgzYzm5EyfMVT9kfUUytE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-_MJzJGMYNsaCeHo6A5fh7Q-1; Sat,
 26 Sep 2026 01:33:04 -0400
X-MC-Unique: _MJzJGMYNsaCeHo6A5fh7Q-1
X-Mimecast-MFC-AGG-ID: _MJzJGMYNsaCeHo6A5fh7Q_1790400783
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 633B418005BE;
	Sat, 26 Sep 2026 05:33:03 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEA891956086;
	Sat, 26 Sep 2026 05:33:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>
Subject: [PATCH 11/11] KVM: selftests: Extend nested x2APIC test to validate using eVMCS for vmcs12
Date: Sat, 26 Sep 2026 01:32:53 -0400
Message-ID: <20260926053253.195597-12-pbonzini@redhat.com>
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
Message-ID: <20260813223610.2043560-7-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../selftests/kvm/x86/nested_x2apic_test.c    | 53 +++++++++++++++----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
index e94d4e77256b..eb89d5bfc0fe 100644
--- a/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_x2apic_test.c
@@ -50,12 +50,24 @@ static void l1_svm_code(struct svm_test_data *svm)
 	stgi();
 }
 
-static void l1_vmx_code(struct vmx_pages *vmx)
+static void l1_vmx_code(struct vmx_pages *vmx, struct hyperv_test_pages *hv_pages)
 {
 	u64 control;
 
+	if (hv_pages) {
+		wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+		enable_vp_assist(hv_pages->vp_assist_gpa, hv_pages->vp_assist);
+		evmcs_enable();
+	}
+
 	GUEST_ASSERT_EQ(prepare_for_vmx_operation(vmx), true);
-	GUEST_ASSERT_EQ(load_vmcs(vmx), true);
+
+	if (hv_pages) {
+		GUEST_ASSERT(load_evmcs(hv_pages));
+		current_evmcs->hv_enlightenments_control.msr_bitmap = 1;
+	} else {
+		GUEST_ASSERT(load_vmcs(vmx));
+	}
 
 	prepare_vmcs(vmx, NULL);
 	GUEST_ASSERT_EQ(vmwrite(GUEST_RIP, (unsigned long)l2_guest_code), 0);
@@ -128,14 +140,14 @@ static void l1_test_x2apic_intercepts(void)
 	nr_irqs = 0;
 }
 
-static void l1_guest_code(void *test_data)
+static void l1_guest_code(void *test_data, void *hv_pages)
 {
 	x2apic_enable();
 
 	if (this_cpu_has(X86_FEATURE_SVM))
 		l1_svm_code(test_data);
 	else
-		l1_vmx_code(test_data);
+		l1_vmx_code(test_data, hv_pages);
 
 	GUEST_ASSERT_EQ(x2apic_read_reg(APIC_TASKPRI), 0);
 	x2apic_write_reg(APIC_TASKPRI, 0xf0);
@@ -150,9 +162,9 @@ static void l1_guest_code(void *test_data)
 	GUEST_DONE();
 }
 
-static void __test_x2apic_intercepts(void)
+static void __test_x2apic_intercepts(bool use_evmcs)
 {
-	gva_t nested_test_data_gva;
+	gva_t nested_test_data_gva, hv_pages_gva = 0;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
@@ -169,7 +181,14 @@ static void __test_x2apic_intercepts(void)
 	else
 		vcpu_alloc_vmx(vm, &nested_test_data_gva);
 
-	vcpu_args_set(vcpu, 1, nested_test_data_gva);
+	if (use_evmcs) {
+		vcpu_set_hv_cpuid(vcpu);
+		vcpu_enable_evmcs(vcpu);
+
+		vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
+	}
+
+	vcpu_args_set(vcpu, 2, nested_test_data_gva, hv_pages_gva);
 
 	vcpu_run(vcpu);
 
@@ -188,17 +207,29 @@ static void __test_x2apic_intercepts(void)
 	kvm_vm_free(vm);
 }
 
-#define test_x2apic_intercepts(inhibit_apic_setting)	\
+#define _test_x2apic_intercepts(inhibit_apic_setting)	\
 do {							\
+							\
 	inhibit_apic_setting;				\
 							\
-	__test_x2apic_intercepts();			\
+	__test_x2apic_intercepts(use_evmcs);		\
 } while (0)
 
+#define test_x2apic_intercepts(use_evmcs_setting)	\
+do {							\
+	bool use_evmcs_setting;				\
+							\
+	_test_x2apic_intercepts(inhibit_apicv = true);	\
+	_test_x2apic_intercepts(inhibit_apicv = false);	\
+} while (0)
+
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
 
-	test_x2apic_intercepts(inhibit_apicv = true);
-	test_x2apic_intercepts(inhibit_apicv = false);
+	test_x2apic_intercepts(use_evmcs = false);
+
+	if (kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS))
+		test_x2apic_intercepts(use_evmcs = true);
 }
-- 
2.52.0

