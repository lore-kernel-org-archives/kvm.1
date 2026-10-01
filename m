Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45246D093
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883526; cv=none; b=mc0EMu3YryZnMScnK9P5mBbqGGymTKtaToehg+1pDVMoqw+QDiVH6JAg0ymkqBrXvZX8/9PwCdKZjJ1cmtvLNEoQG9wdtzWCkEld/gQ4tyBQ0DgmUeuE+0PxghDRywj4yRejIVyC9uPQyCUtHLXkE/hJ0nWZ5DrTN0ohvKYQdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883526; c=relaxed/simple;
	bh=QizpkzsD7XaPKqD1gbrUcb+2OeYMrUo3+OzEEWdUl6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WpJYBqpzXdBBe1yVHnPYw8DRQZPVqWkcE55V8KHz/LPso/qq4vF431jQ4w+hkp3fnebyeyqsEECluwcE7x4WWeOswkEgvofU5gqdxL5Ekynqqp+McEuUVuKawDfBLAYl1xmK0VgEbIyS+3hv0RzOL4rli4IAchnje2qDuh3b4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLLi26TU; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLLi26TU"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so4924659a12.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883523; x=1791488323; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlrDRlD12bI/REyMAeS7oVe6Bf+bYhgVoOHbjN9ce80=;
        b=VLLi26TUeo1/6dAiWLiTeIAqOyn1UwHCM3KRK9WxXydBs6JhMVrd2wja8DRDpc0s7t
         kmBpbuscHAwrmO25VqpzjGDYVirZl0Gs7Mgq94hvjtrZL65DM8+WG4/XNlByLz7CH4GZ
         O2oVre9EbrZkalCwZtW+QGDVDnoWLG2f8pRg09VPMxe38yX+K4+BWLNi1V3prke/QboV
         sDhJAvI+Qdm3R8mSnCEh7UNNDUxP66/KeAxb4In8t3DKCMBn8J84z40gdEBL0Hyq1OwA
         V5K448v9UqvLJmxbbuTWh29qqtrZEKPgimzPf2EAFJHTvJqjM8Teu+sv8DtCZ0Mov95l
         XRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883523; x=1791488323;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlrDRlD12bI/REyMAeS7oVe6Bf+bYhgVoOHbjN9ce80=;
        b=KW3b4MCo7I0qvE1jfMdERcgAEpVsXPXWhP72aE6xWvCW8jdPvgVBIy5xACBWiG2JZk
         I2Dh2JaWOZqxTwtuRPBeaU1lXxcLUzkPNshVyBrsvtAPPX+pNPI5E2HVcLvLFTcEx9wT
         6qFzShRvZBa7+y8eheSVJ9adBDnCih2rvECSlSiL++mrS546nwDtlS9BXvdYPos1Hp7k
         R1kJcoHSfawWCIe7BIh1GAhLIe6uw0b2ZWcPgjcJb7hrbJajT9aRX32AtlnlCv7AaYlR
         8EBkOqebRa6u5HUID//U4MuESAxFaa/Ra2nelnBJaJlA0DhBhoRqI/rIRFB5fp1X9rBz
         Rr3w==
X-Forwarded-Encrypted: i=1; AKwUvByaDicjNJj+UniRAiGDFYmXDpeZMhEWDwTY0skMEUOT9tQKALDmvxmlC+mfwrc0ZKItjeo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCY3vsTITi4aNBLLX6ocrCXxteNnrRjongwFqdmSh/mJ1VUDB4
	gdf8XqUm69wqR0EiSixmoo9mxcdIoFvAtDJuuW611u8weNnBiVY59AjhSYSJ8cQQ3euuBkVwMYo
	CHAMHwQ==
X-Received: from pjbkh5.prod.google.com ([2002:a17:90b:34c5:b0:3a4:95bf:7386])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:8c:b0:3a4:b50a:1113
 with SMTP id 98e67ed59e1d1-3a6d39f30ecmr232637a91.37.1790883522879; Thu, 01
 Oct 2026 12:38:42 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:28 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=10132;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=00ofFk2lZW2JoXCCSIQgXe0ovr2P7LEPBWahIXD4UQ8=; b=HjFUYwwD9Ep9aydeatAEXDD1hlJOvBS2mbaX2m/JZDLABPO32m6v7w5cp0MoBVWk3K6rYEQ/F
 WDUWCvweJ2xDGICf1MlbhOLx226lkO7ZT/8BFw33C4SWNZiZo7g2cB6
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-1-7c62a5d8a992@google.com>
Subject: [PATCH v15 01/23] KVM: selftests: Add macros to simplify creating VM
 shapes for non-default types
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <iweiny@kernel.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Add VM_TYPE() and __VM_SHAPE() macros to create a vm_shape structure given
a type (and mode), and use the macros to define VM_SHAPE_{SEV,SEV_ES,SNP}
shapes for x86's SEV family of VM shapes.  Providing common infrastructure
will avoid having to copy+paste vm_sev_create_with_one_vcpu() for TDX.

Use the new SEV+ shapes and drop vm_sev_create_with_one_vcpu().

Opportunistically move the existing VM_SHAPE() (now __VM_SHAPE()) macro
below the definitions of VM_MODE_DEFAULT so that all of the SHAPE/TYPE
macros are bundled together.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h     | 27 ++++++++-------
 .../testing/selftests/kvm/include/x86/processor.h  |  4 +++
 tools/testing/selftests/kvm/include/x86/sev.h      |  2 --
 tools/testing/selftests/kvm/lib/x86/sev.c          | 16 ---------
 tools/testing/selftests/kvm/x86/sev_dbg_test.c     | 13 ++++---
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   | 40 +++++++++++-----------
 6 files changed, 45 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 777fa3dbf88d..426bc05fe62f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -221,18 +221,6 @@ struct vm_shape {
 
 kvm_static_assert(sizeof(struct vm_shape) == sizeof(u64));
 
-#define VM_TYPE_DEFAULT			0
-
-#define VM_SHAPE(__mode)			\
-({						\
-	struct vm_shape shape = {		\
-		.mode = (__mode),		\
-		.type = VM_TYPE_DEFAULT		\
-	};					\
-						\
-	shape;					\
-})
-
 extern enum vm_guest_mode vm_mode_default;
 
 #if defined(__aarch64__)
@@ -270,8 +258,23 @@ extern enum vm_guest_mode vm_mode_default;
 
 #endif
 
+#define VM_TYPE_DEFAULT			0
+
+#define __VM_SHAPE(__mode, __type)		\
+({						\
+	struct vm_shape shape = {		\
+		.mode = (__mode),		\
+		.type = (__type),		\
+	};					\
+						\
+	shape;					\
+})
+
+#define VM_SHAPE(__mode)	__VM_SHAPE(__mode, VM_TYPE_DEFAULT)
 #define VM_SHAPE_DEFAULT	VM_SHAPE(VM_MODE_DEFAULT)
 
+#define VM_TYPE(__type)		__VM_SHAPE(VM_MODE_DEFAULT, __type)
+
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
 #define PTES_PER_MIN_PAGE	ptes_per_page(MIN_PAGE_SIZE)
 
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..ed50007e3504 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -386,6 +386,10 @@ static inline unsigned int x86_model(unsigned int eax)
 	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
 }
 
+#define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
+#define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
+#define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 
 #define PAGE_SHIFT		12
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index dec383e59a47..eb4ab573febf 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -53,8 +53,6 @@ void snp_vm_launch_start(struct kvm_vm *vm, u64 policy);
 void snp_vm_launch_update(struct kvm_vm *vm);
 void snp_vm_launch_finish(struct kvm_vm *vm);
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(u32 type, void *guest_code,
-					   struct kvm_vcpu **cpu);
 void vm_sev_launch(struct kvm_vm *vm, u64 policy, u8 *measurement);
 
 kvm_static_assert(SEV_RET_SUCCESS == 0);
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 93f916903461..95d8520eea34 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -158,22 +158,6 @@ void snp_vm_launch_finish(struct kvm_vm *vm)
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_FINISH, &launch_finish);
 }
 
-struct kvm_vm *vm_sev_create_with_one_vcpu(u32 type, void *guest_code,
-					   struct kvm_vcpu **cpu)
-{
-	struct vm_shape shape = {
-		.mode = VM_MODE_DEFAULT,
-		.type = type,
-	};
-	struct kvm_vm *vm;
-	struct kvm_vcpu *cpus[1];
-
-	vm = __vm_create_with_vcpus(shape, 1, 0, guest_code, cpus);
-	*cpu = cpus[0];
-
-	return vm;
-}
-
 void vm_sev_launch(struct kvm_vm *vm, u64 policy, u8 *measurement)
 {
 	if (is_sev_snp_vm(vm)) {
diff --git a/tools/testing/selftests/kvm/x86/sev_dbg_test.c b/tools/testing/selftests/kvm/x86/sev_dbg_test.c
index eaa8201b937d..998c1b1d59a1 100644
--- a/tools/testing/selftests/kvm/x86/sev_dbg_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_dbg_test.c
@@ -70,17 +70,14 @@ static void __test_sev_dbg(struct kvm_vm *vm, int nr_bytes)
 	}
 }
 
-static void test_sev_dbg(u32 type, u64 policy)
+static void test_sev_dbg(struct vm_shape shape, u64 policy)
 {
 	int sizes[] = { 1, 8, 15, 16, 17, 32, 33 };
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int i;
 
-	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(type)))
-		return;
-
-	vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, NULL);
 
 	data = addr_gva2hva(vm, vm_alloc(vm, BUFFER_SIZE, KVM_UTIL_MIN_VADDR));
 	memset(data, 0xaa, BUFFER_SIZE);
@@ -112,7 +109,9 @@ int main(int argc, char *argv[])
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
 	/* Note, KVM doesn't support {de,en}crypt commands for SNP. */
-	test_sev_dbg(KVM_X86_SEV_VM, 0);
-	test_sev_dbg(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM))
+		test_sev_dbg(VM_SHAPE_SEV, 0);
+	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM))
+		test_sev_dbg(VM_SHAPE_SEV_ES, SEV_POLICY_ES);
 	return 0;
 }
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index bf27b6187afa..5aebf7f52c44 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -104,7 +104,7 @@ static void compare_xsave(u8 *from_host, u8 *from_guest)
 		abort();
 }
 
-static void test_sync_vmsa(u32 type, u64 policy)
+static void test_sync_vmsa(struct vm_shape shape, u64 policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
@@ -114,7 +114,7 @@ static void test_sync_vmsa(u32 type, u64 policy)
 	double x87val = M_PI;
 	struct kvm_xsave __attribute__((aligned(64))) xsave = { 0 };
 
-	vm = vm_sev_create_with_one_vcpu(type, guest_code_xsave, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code_xsave);
 	gva = vm_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
 			      MEM_REGION_TEST_DATA);
 	hva = addr_gva2hva(vm, gva);
@@ -150,13 +150,13 @@ static void test_sync_vmsa(u32 type, u64 policy)
 	kvm_vm_free(vm);
 }
 
-static void test_sev(void *guest_code, u32 type, u64 policy)
+static void test_sev(void *guest_code, struct vm_shape shape, u64 policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
 
-	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
 	/* TODO: Validate the measurement is as expected. */
 	vm_sev_launch(vm, policy, NULL);
@@ -201,12 +201,12 @@ static void guest_shutdown_code(void)
 	__asm__ __volatile__("ud2");
 }
 
-static void test_sev_shutdown(u32 type, u64 policy)
+static void test_sev_shutdown(struct vm_shape shape, u64 policy)
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = vm_sev_create_with_one_vcpu(type, guest_shutdown_code, &vcpu);
+	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_shutdown_code);
 
 	vm_sev_launch(vm, policy, NULL);
 
@@ -218,28 +218,28 @@ static void test_sev_shutdown(u32 type, u64 policy)
 	kvm_vm_free(vm);
 }
 
-static void test_sev_smoke(void *guest, u32 type, u64 policy)
+static void test_sev_smoke(void *guest, struct vm_shape shape, u64 policy)
 {
 	const u64 xf_mask = XFEATURE_MASK_X87_AVX;
 
-	if (type == KVM_X86_SNP_VM)
-		test_sev(guest, type, policy | SNP_POLICY_DBG);
+	if (shape.type == KVM_X86_SNP_VM)
+		test_sev(guest, shape, policy | SNP_POLICY_DBG);
 	else
-		test_sev(guest, type, policy | SEV_POLICY_NO_DBG);
-	test_sev(guest, type, policy);
+		test_sev(guest, shape, policy | SEV_POLICY_NO_DBG);
+	test_sev(guest, shape, policy);
 
-	if (type == KVM_X86_SEV_VM)
+	if (shape.type == KVM_X86_SEV_VM)
 		return;
 
-	test_sev_shutdown(type, policy);
+	test_sev_shutdown(shape, policy);
 
 	if (kvm_has_cap(KVM_CAP_XCRS) &&
 	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
-		test_sync_vmsa(type, policy);
-		if (type == KVM_X86_SNP_VM)
-			test_sync_vmsa(type, policy | SNP_POLICY_DBG);
+		test_sync_vmsa(shape, policy);
+		if (shape.type == KVM_X86_SNP_VM)
+			test_sync_vmsa(shape, policy | SNP_POLICY_DBG);
 		else
-			test_sync_vmsa(type, policy | SEV_POLICY_NO_DBG);
+			test_sync_vmsa(shape, policy | SEV_POLICY_NO_DBG);
 	}
 }
 
@@ -254,13 +254,13 @@ int main(int argc, char *argv[])
 	 * though X86_FEATURE_SEV is set.  Gate every type on KVM_CAP_VM_TYPES.
 	 */
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_VM))
-		test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+		test_sev_smoke(guest_sev_code, VM_SHAPE_SEV, 0);
 
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SEV_ES_VM))
-		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+		test_sev_smoke(guest_sev_es_code, VM_SHAPE_SEV_ES, SEV_POLICY_ES);
 
 	if (kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SNP_VM))
-		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+		test_sev_smoke(guest_snp_code, VM_SHAPE_SNP, snp_default_policy());
 
 	return 0;
 }

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

