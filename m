Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149C4FD297
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739443; cv=none; b=jTl51GzPD0KnvmsZ58FA4yyw5qiSV8NPMJ/jhsFwnZ8lpATfIhrp6vLvF5CV3gqPKCSAmAYBtCW8MM/SlVqCwyjDkmWGNc96CueSxyxk38fnHhJaSZoW0Gdd7SeHQwMXoP1+KtUI6Pt5Y8HH/8fvzSX7ho2FYX2RSxhRG7nlTXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739443; c=relaxed/simple;
	bh=mTV3xX4GH7tj1q4A10HKa/9dzjZveMdRRiqNyw0Wi38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LX5rqpnAZnPT+EqKNf3rkVh1Bc43P4ULSHqPjQRFTo0rBdYb2TN8C+XylSC3RIRkhfwnyPEfZA2zGn5DWzc1t6QUVqEQ9YoDefKdfy1hi3tt1U3DDf4qFPVhNZcPqBvMIi8pgQSnqwMx3T9HZ0sQVIufHOGoy9AdiHwChNyO9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj/XmCKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj/XmCKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rRcphcq6LZt+l3KFOWlD7eC1zWunLI9ySIRYJJB8xM=;
	b=Bj/XmCKPkEDG0pqnV1uS8dhuXIgwBKu/86Oxii0azuKAXYrPw+x4xdSO6ulzlpj9j4hNhk
	2fpQF2a2hWvbFn/IFk3nPSiHK+ASYOXazlNENLDKZpJXYu68rs7TUsOswc1bUMWaAiHr8X
	caYYD8gAatdcLqvlhEHhla2lo6GfBkc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-N_Rip33cO2yeRIFyeODglg-1; Fri,
 18 Sep 2026 09:50:36 -0400
X-MC-Unique: N_Rip33cO2yeRIFyeODglg-1
X-Mimecast-MFC-AGG-ID: N_Rip33cO2yeRIFyeODglg_1789739435
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A4A35180AE2E;
	Fri, 18 Sep 2026 13:50:35 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 068561956042;
	Fri, 18 Sep 2026 13:50:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 04/31] KVM: selftests: Test address translation for Hyper-V direct L2 hypercalls
Date: Fri, 18 Sep 2026 09:50:03 -0400
Message-ID: <20260918135030.171564-5-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Test that the TLB flush hypercalls, when executed by L2, translate their
input addresses through the guest's EPT or NPT.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/x86/hyperv_evmcs.c    | 12 +++++++++++-
 tools/testing/selftests/kvm/x86/hyperv_svm_test.c | 13 ++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
index 63ea1533e4ea..29baae74ad3a 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_evmcs.c
@@ -18,6 +18,8 @@
 #include "hyperv.h"
 #include "vmx.h"
 
+#define L2_HCALL_INPUT_GPA	0x100000000ull
+
 static int ud_count;
 
 static void guest_ud_handler(struct ex_regs *regs)
@@ -60,6 +62,8 @@ void l2_guest_code(void)
 	rdmsr_from_l2(MSR_GS_BASE); /* intercepted */
 
 	/* L2 TLB flush tests */
+	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE,
+			 L2_HCALL_INPUT_GPA, 0);
 	hyperv_hypercall(HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE | HV_HYPERCALL_FAST_BIT, 0x0,
 			 HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES | HV_FLUSH_ALL_PROCESSORS);
 	rdmsr_from_l2(MSR_FS_BASE);
@@ -228,7 +232,7 @@ static struct kvm_vcpu *save_restore_vm(struct kvm_vm *vm,
 int main(int argc, char *argv[])
 {
 	gva_t vmx_pages_gva = 0, hv_pages_gva = 0;
-	gva_t hcall_page;
+	gva_t hcall_input_page, hcall_page;
 
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -239,17 +243,23 @@ int main(int argc, char *argv[])
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
index 1f74b0fa9b83..18f0ad6debd8 100644
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


