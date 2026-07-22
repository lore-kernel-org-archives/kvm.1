Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2854582DA
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762059; cv=none; b=QnDjwqF0h7SxVczsjwHqYjg+r4Z5HV1cETRF4gl1uOXI3e+DOjTYWAP4+FU1tYIj4SPW4rrgB2KW093iAeTfYB0+w73L8GzIUefhGHruiW364l0d4s8EqpyQ+PbC17ZSRizqfpv+57TSfyaZ/Z6e0KUvLFvM8RdUXVcjZoqDQl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762059; c=relaxed/simple;
	bh=6xK7BW/lODxtVnPAti2SllMF/rRYhYWlPawQZ6OdvSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rY2/53io78ysbFvzybbcRS/IaR6FOHCM7uH8CNUoH5UAc1vVUpwJ+d6PMtPWK33TR/xWDsml0qbjtJI+IG6oVd9xzQGuU7OzMvOFrvmT9YuLvDRy4GKzKakP8fa03F2c8zsBa8PZq6+5Bg51bNSd90ND1R2j2j9yEvYyCL0lQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuP5VHqc; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuP5VHqc"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso7489393b3a.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762057; x=1785366857; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Nniw3rM0vx5yQvDpQ3gzLadmFEyXkP7wMFQo59ckcE=;
        b=nuP5VHqcii+QOq4tEAKTO6h93QwKtTJ9P5I1Dv2B8kMi+tJ0i8zxW+VRyHv34d8SXY
         E9eeqjwHXVCgV15pIZB/7ltUjdAhZSW5jHLvJYEqhw91oTKbZhkGpocPkP7QTgfz2Lir
         ESNAXJIY2k9CiZmi9zLZTSxmUP/NSqLuUU7q4ZJqBSGXJbAC8GNy8poUCPkCFkQpFTAt
         wTKPFBZUa2dxoNaAO2oWBh5wyE+ML8aguUWrgn1aPUJ8sRWzcUe6z+wwwWba7CFwXKkc
         +OgYLOrK6eE3GsHe9zRayxrjF4YyEBSRXhhUvtEy67eUj9PfGhGySyEpP4d0w8WG7Tw5
         3iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762057; x=1785366857;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Nniw3rM0vx5yQvDpQ3gzLadmFEyXkP7wMFQo59ckcE=;
        b=PZ1X0KBvDKo+8DDPVzkBr1Uxi+qSqHNgLZ7xfCuaZNXDG95mlVrhvGDiirvN7LTt1f
         ZuDqoNHC8CftH01kQMLMcFP4V5cdkHMLXhwoN2ryKnzrTXWbJ9eI/a76SFLE5Dt16qVU
         aeepj+PQQs9ZMC4ECDvZ7M53Cc8PR+u5vxc38tyxjbz/fPPZ2cZnLrDGFlwy8ddFFYbH
         70tvFsqqp1dHJWF6p0i6KJsCen8th4SxpIHLn0dXXFQGef7NJQxDRWQ7U7iSp5tFzNlS
         meFfdIpAhZGbA+3YZXRX//5oGHX9kHj7yqFhq1I4tOIWAnHq3ox3DutH+VBnxsTkpjOT
         ahAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQU+txTVTUJ20ua5DxMUsd5LN0rge+PfoO3XL++JZPblhncBIwAerUxC+qRKkF4/A4Ixw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDJ0RFJJ9rUO/ZQPXagzcBd7CwiE8LaAM6+wMybUiy/k/WnudR
	TBOQKf2/XJkgZYVH7OfEMG1wE8aYk5Msnkvs/IvPYR5w/wa69ENUvZf81lCgfN7drcHvMm3H7fA
	3zV1sCQ==
X-Received: from pgc10.prod.google.com ([2002:a05:6a02:2f8a:b0:c80:1fe6:ac57])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:338c:b0:84a:46ec:3b9c
 with SMTP id d2e1a72fcca58-84e2e957883mr296813b3a.31.1784762056694; Wed, 22
 Jul 2026 16:14:16 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:06 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=8466;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=2W8WgKYZE6tdsrSJhFkV2BZFvYpKlmme9GBgA9yovX0=; b=jhHS5wsQJnyizLbOK2K2wlB3XhUxpwUS1p60BbJqP/qr3hIV33WL3Xg3dNU5RfDldg3a5+5XC
 rJdS6X8fh21BBiWhV3RGJxoVb1IIlqdHFdT70DlCHXf8tAfPb3BS2Hh
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-1-15ad654a50db@google.com>
Subject: [PATCH v14 01/22] KVM: selftests: Add macros to simplify creating VM
 shapes for non-default types
From: Lisa Wang <wyihan@google.com>
To: Andrew Jones <ajones@ventanamicro.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h     | 27 ++++++++-------
 .../testing/selftests/kvm/include/x86/processor.h  |  4 +++
 tools/testing/selftests/kvm/include/x86/sev.h      |  2 --
 tools/testing/selftests/kvm/lib/x86/sev.c          | 16 ---------
 tools/testing/selftests/kvm/x86/sev_smoke_test.c   | 40 +++++++++++-----------
 5 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index dc70c6da63fa..2a3923dad570 100644
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
index 77f576ee7789..0aa6eecfcbde 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -365,6 +365,10 @@ static inline unsigned int x86_model(unsigned int eax)
 	return ((eax >> 12) & 0xf0) | ((eax >> 4) & 0x0f);
 }
 
+#define VM_SHAPE_SEV		VM_TYPE(KVM_X86_SEV_VM)
+#define VM_SHAPE_SEV_ES		VM_TYPE(KVM_X86_SEV_ES_VM)
+#define VM_SHAPE_SNP		VM_TYPE(KVM_X86_SNP_VM)
+
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 
 #define PAGE_SHIFT		12
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 1af44c151d60..944c59dbe510 100644
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
diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 1a49ee391586..fe2c438882ae 100644
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
 
@@ -247,13 +247,13 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
 
-	test_sev_smoke(guest_sev_code, KVM_X86_SEV_VM, 0);
+	test_sev_smoke(guest_sev_code, VM_SHAPE_SEV, 0);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
-		test_sev_smoke(guest_sev_es_code, KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+		test_sev_smoke(guest_sev_es_code, VM_SHAPE_SEV_ES, SEV_POLICY_ES);
 
 	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
-		test_sev_smoke(guest_snp_code, KVM_X86_SNP_VM, snp_default_policy());
+		test_sev_smoke(guest_snp_code, VM_SHAPE_SNP, snp_default_policy());
 
 	return 0;
 }

-- 
2.55.0.229.g6434b31f56-goog

