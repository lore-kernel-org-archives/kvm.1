Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641298;
	b=0rzS1gKRzn0AvmMRR3LG9zZNk6zuZ4w34n57wdtTQFzD9Ua+jds1FAgpPmiyPe9J/l87
	 cRA3ftBAjW/5X0zsxerX++Sp7nS9Pbk6i3hVqLI9NIj2bA/W3q82tWbbEP1eEIJQTOUUi
	 Q5//+OtjEAr3aC4VplBrKZ/Js9JDwRpYATU2w1ZTyyxrJr9exOlG1qo8k2lhriDW4f/sr
	 dszek3XAfDm02tTmoEBfjbk9PkEMYCmeU4rQ3k/hAXWD+d9Ft/qbcNTBG8srBT86TZ4dD
	 HhAjaI4Q7BRQbscwraj217jfhsUiQr+tyV+68OibMuEEzMbTwSCntk2Z7wtrLXkuRRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641298;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=gtzJs2vnWx+b0n8mkZJ4H40lASvEtkz2eef5LU+gV0Q=;
	b=Bd0jfUypHG+KvHQ2zkkAN/b+McGLGenYLcDLxJw1Vjmg7YHUwFrSk+iiv+coEvrLH+0Q
	 VVqjGlD8eP8PoUDrpAEpzzS6jtKEfihZEKtWpf3YiXyhnFY1isk+LcVeDYzsezkrh+GHS
	 sgY7ToX7vtrQK5jr26qd5sGiFtSWg4kGHVEDYRNvhMMF5CnQy8FlUOPX4XM4zZgXcOFUB
	 n/HUSmAnMm3qKxOTKOUEpWA6Jnzf6/i04+igYlDwIp3+yTmoD0I17jBPl4a+roE/8Kjsg
	 cziokKzFJObk/1rLYhkSGtPG989bXMIAXom86VU72RMyGUBayuLg9S/JnWHfN9VboOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B3xQSiZe;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2AE6070CA4
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD2AE6070CA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B3xQSiZe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtzJs2vnWx+b0n8mkZJ4H40lASvEtkz2eef5LU+gV0Q=;
	b=B3xQSiZeYKKUbkOzQdGDCVmWhiWHxDiXUJ+mB5DuPdVUibd95gK4a19RxCoq8KrFo0oD1E
	YCvAxc4iRftzhjeg9Vd+fS8o/QK2+NFN34xiqXPznBU1YeHdnj3G7YZQf4PdohxOmGb4rg
	Y3+JmuNMeeaQkfd6Hxvd2eF/EBV6ino=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-HdAt9Z21OjanBJRfDnNpCg-1; Mon,
 02 Nov 2026 12:41:35 -0500
X-MC-Unique: HdAt9Z21OjanBJRfDnNpCg-1
X-Mimecast-MFC-AGG-ID: HdAt9Z21OjanBJRfDnNpCg_1793641294
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99B2D1800674;
	Mon,  2 Nov 2026 17:41:34 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BD4530000E3;
	Mon,  2 Nov 2026 17:41:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 06/45] KVM: selftests: Test address translation for Hyper-V direct L2 hypercalls
Date: Mon,  2 Nov 2026 12:40:50 -0500
Message-ID: <20261102174130.8779-7-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Test that the TLB flush hypercalls, when executed by L2, translate their
input addresses through the guest's EPT or NPT.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-5-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c    | 12 +++++++++++-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index c81f2dd4f2a1..2e1150c4bbbf 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -18,6 +18,8 @@
 #include "hyperv.h"
 #include "vmx.h"
 
+#define L2_HCALL_INPUT_GPA	0x100000000ull
+
 static int ud_count;
 
 static void guest_ud_handler(struct ex_regs *regs)
@@ -64,6 +66,8 @@ void l2_guest_code(void)
 	rdmsr_from_l2(MSR_GS_BASE); /* intercepted */
 
 	/* L2 TLB flush tests */
+	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
+			 L2_HCALL_INPUT_GPA, 0);
 	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
 			 HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS);
 	rdmsr_from_l2(MSR_FS_BASE);
@@ -239,7 +243,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 int main(int argc, char *argv[])
 {
 	gva_t vmx_pages_gva = 0, hv_pages_gva = 0;
-	gva_t hcall_page;
+	gva_t hcall_input_page, hcall_page;
 
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -250,17 +254,23 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_ENLIGHTENED_VMCS));
 	TEST_REQUIRE(kvm_hv_cpu_has(HV_X64_NESTED_DIRECT_FLUSH));
+	TEST_REQUIRE(kvm_cpu_has_ept());
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_enable_ept(vm);
 
 	hcall_page = vm_alloc_pages(vm, 1);
 	memset(addr_gva2hva(vm, hcall_page), 0x0,  getpagesize());
+	hcall_input_page = vm_alloc_page(vm);
+	memset(addr_gva2hva(vm, hcall_input_page), 0, getpagesize());
 
 	vcpu_set_hv_cpuid(vcpu);
 	vcpu_enable_evmcs(vcpu);
 
 	vcpu_alloc_vmx(vm, &vmx_pages_gva);
 	vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
+	tdp_identity_map_default_memslots(vm);
+	tdp_map(vm, L2_HCALL_INPUT_GPA, addr_gva2gpa(vm, hcall_input_page), PAGE_SIZE);
 	vcpu_args_set(vcpu, 3, vmx_pages_gva, hv_pages_gva, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
 
diff --git a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
index 3a3dc31072e8..1c95b86ce2a5 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_svm_test.c
@@ -18,6 +18,8 @@
 #include "svm_util.h"
 #include "hyperv.h"
 
+#define L2_HCALL_INPUT_GPA	0x100000000ull
+
 /* Exit to L1 from L2 with RDMSR instruction */
 static inline void rdmsr_from_l2(u32 msr)
 {
@@ -45,6 +47,8 @@ void l2_guest_code(void)
 	GUEST_SYNC(5);
 
 	/* L2 TLB flush tests */
+	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
+			 L2_HCALL_INPUT_GPA, 0);
 	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE |
 			 HV_HYPERCALL_FAST_BIT, 0x0,
 			 HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES |
@@ -146,7 +150,7 @@ static void __attribute__((__flatten__)) guest_code(struct svm_test_data *svm,
 int main(int argc, char *argv[])
 {
 	gva_t nested_gva = 0, hv_pages_gva = 0;
-	gva_t hcall_page;
+	gva_t hcall_input_page, hcall_page;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
@@ -154,15 +158,22 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
 	TEST_REQUIRE(kvm_hv_cpu_has(HV_X64_NESTED_DIRECT_FLUSH));
+	TEST_REQUIRE(kvm_cpu_has_npt());
 
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_enable_npt(vm);
 	vcpu_set_hv_cpuid(vcpu);
 	vcpu_alloc_svm(vm, &nested_gva);
 	vcpu_alloc_hyperv_test_pages(vm, &hv_pages_gva);
 
 	hcall_page = vm_alloc_pages(vm, 1);
 	memset(addr_gva2hva(vm, hcall_page), 0x0,  getpagesize());
+	hcall_input_page = vm_alloc_page(vm);
+	memset(addr_gva2hva(vm, hcall_input_page), 0, getpagesize());
+
+	tdp_identity_map_default_memslots(vm);
+	tdp_map(vm, L2_HCALL_INPUT_GPA, addr_gva2gpa(vm, hcall_input_page), PAGE_SIZE);
 
 	vcpu_args_set(vcpu, 3, nested_gva, hv_pages_gva, addr_gva2gpa(vm, hcall_page));
 	vcpu_set_msr(vcpu, HV_X64_MSR_VP_INDEX, vcpu->id);
-- 
2.52.0


