Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CD4779BF
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628666; cv=none; b=USoeRGUMedXlYeKMyA8rwRIizO6Xke0MbE82iZycRzVT1ZRCjvFyQLEeZcRAw/Ql4AutywyT+Yjx9T3kRYiOZdpvroO1To2APnZnBhYqVWnJb7r0/YAlVpwgdObI86DGSpvMHlKXR68zgfaVSRc/QZdVAWMeUoIK6RhnqyXds4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628666; c=relaxed/simple;
	bh=jitglgJ45fsE0O8Dne3B8fAMDpX/24Xt7Rej/Bc7tXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bNOhEcRRmbTUVAtfHIOCGlOYvLiQhAUOCiW+H+nJXXo02nQ6GQ5hxXjDK9N5nIXWOFDAa1YVPkodArijAl7DxCx6VCC/IOtOf8Yxn64HxheKjrtG7SMxOpqtxJZimxQFCRInNmgNpZuHo/Tg8+/LAl0qK9lkGllp1HufHHde9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=amz58OLX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="amz58OLX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c2da7fa311so49373585ad.3
        for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628664; x=1782233464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4vWdS0gGh8Qnkd6KWcp4c6P4oeAatRbK+RzZ1mQj5U=;
        b=amz58OLXwJRR2YQJYJUWjy4h042DoJHjcOq6cu1q4THcfYG9YlM8rbZw8+PvVvr45R
         A55mpqsKkr6qvCW3Jl+BPlEEcMrTMj3a5+kItzhudk8ipsisWswU14KBgJNO7YIyX/+i
         j03PYPo2RKYu/kEU/gij+DgIsZHMFsjPfIFhNfnwunvFKA5TGy6pfTa0LeirVvZDFVzm
         6DcrO17RRghUN/KR+UIDjIPti+56e6AnXsYdyi2yqw8UqB+lLFk1G6UVxvV7Pk1WbDsb
         RTd0W9UZO5gvyu2PCyY2A7HFZYiM2wUg9/+6jyz337uaP+LEltLdvAjJzCFkvjhLuoPq
         spXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628664; x=1782233464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4vWdS0gGh8Qnkd6KWcp4c6P4oeAatRbK+RzZ1mQj5U=;
        b=MGccmiZXwt/uZh0kvfhMHgWfe+9z3udd1K1SFjFjzG7HFkeZwQCxBdrnBq9RtZ+0wk
         y3kF8k/mSeZR+D6+FDIdRyk6tcy1XrRWPI7A1+RPEv0KOYqB/rsHVNzwrGz+8aFcIgY0
         ZCLFHrS3NIsvxEUj51b0DZeeogFHjMZKHuEQl1tC239SU+yRPlwJKl8/ttKYlk5Tn/X0
         phiNViktQG8xFTDjLSRkTQjde3ZQKNqt9pLyS8WTA+LVklDQIRik8goin+4T30cdEkaN
         tGMJFVeJg2hJrTkdjzBIj0WKQpY8RYujaElcQocSejOlThR4vRqzBiDZj5w2XCIi10km
         ya/w==
X-Forwarded-Encrypted: i=1; AFNElJ8lFO4eLq+kN3g1FQ0rOCihu6JFCzUIkDSUY2pyI2rfvC+iPX63MTQIBXUYrwAVz99Hoks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwmMhlkwn45yyhbPJuVMscGhnoT1kl7yHoIhZjSzEb53+73Lt+
	KqkGavwQFgvvxb9N8NDe9v42qpIEtd7mgMTmAEj9eou8PFYbylyZOUNQ0xeHH0dswm5/PGJmTaM
	Z04qmOw==
X-Received: from plbmf16.prod.google.com ([2002:a17:902:fc90:b0:2b9:53bb:4a09])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:944:b0:2c4:608:167c
 with SMTP id d9443c01a7336-2c410cd152emr203328415ad.6.1781628663233; Tue, 16
 Jun 2026 09:51:03 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:51:02 -0700
In-Reply-To: <e0b99e9a-c20f-4def-ac4b-0070996c10ef@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-1-6983ae4c3a4d@google.com> <e0b99e9a-c20f-4def-ac4b-0070996c10ef@intel.com>
Message-ID: <ajF-9isiWxPyzxci@google.com>
Subject: Re: [PATCH v13 01/22] KVM: selftests: Add macros to simplify creating
 VM shapes for non-default types
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Ackerley Tng <ackerleytng@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Chao Gao <chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Erdem Aktas <erdemaktas@google.com>, 
	Ira Weiny <ira.weiny@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Ryan Afranji <afranji@google.com>, 
	Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 16, 2026, Xiaoyao Li wrote:
> On 5/22/2026 7:16 AM, Lisa Wang wrote:
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index dc70c6da63fa..041bdbfb93f7 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -233,6 +233,19 @@ kvm_static_assert(sizeof(struct vm_shape) == sizeof(u64));
> >   	shape;					\
> >   })
> > +#define __VM_TYPE(__mode, __type)		\
> 
> It seems the name "__VM_SHAPE" fits better?
> 
> > +({						\
> > +	struct vm_shape shape = {		\
> > +		.mode = (__mode),		\
> > +		.type = (__type)		\
> > +	};					\
> > +						\
> > +	shape;					\
> > +})
> > +
> > +#define VM_TYPE(__type)				\
> > +	__VM_TYPE(VM_MODE_DEFAULT, __type)
> 
> and I think making it one line would be OK?
> 
> So something on top:
> 
> ---8<---
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h
> b/tools/testing/selftests/kvm/include/kvm_util.h
> index 041bdbfb93f7..a1b5d2029d05 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -223,17 +223,7 @@ kvm_static_assert(sizeof(struct vm_shape) ==
> sizeof(u64));
> 
>  #define VM_TYPE_DEFAULT                        0
> 
> -#define VM_SHAPE(__mode)                       \
> -({                                             \
> -       struct vm_shape shape = {               \
> -               .mode = (__mode),               \
> -               .type = VM_TYPE_DEFAULT         \
> -       };                                      \
> -                                               \
> -       shape;                                  \
> -})
> -
> -#define __VM_TYPE(__mode, __type)              \
> +#define __VM_SHAPE(__mode, __type)             \
>  ({                                             \
>         struct vm_shape shape = {               \
>                 .mode = (__mode),               \
> @@ -243,8 +233,8 @@ kvm_static_assert(sizeof(struct vm_shape) ==
> sizeof(u64));
>         shape;                                  \
>  })
> 
> -#define VM_TYPE(__type)                                \
> -       __VM_TYPE(VM_MODE_DEFAULT, __type)
> +#define VM_SHAPE(__mode)       __VM_SHAPE(__mode, VM_TYPE_DEFAULT)
> +#define VM_TYPE(__type)                __VM_SHAPE(VM_MODE_DEFAULT, __type)

Oh, that's way better!  I say we go straight there:

--
From: Sean Christopherson <seanjc@google.com>
Date: Tue, 28 Oct 2025 21:20:27 +0000
Subject: [PATCH] KVM: selftests: Add macros to simplify creating VM shapes for
 non-default types

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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 28 +++++++------
 .../selftests/kvm/include/x86/processor.h     |  4 ++
 tools/testing/selftests/kvm/include/x86/sev.h |  2 -
 tools/testing/selftests/kvm/lib/x86/sev.c     | 16 --------
 .../selftests/kvm/x86/sev_smoke_test.c        | 40 +++++++++----------
 5 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index dc70c6da63fa..46bae183d7fc 100644
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
@@ -270,8 +258,24 @@ extern enum vm_guest_mode vm_mode_default;
 
 #endif
 
+#define VM_TYPE_DEFAULT			0
+
+#define __VM_SHAPE(__mode, __type)			\
+({						\
+	struct vm_shape shape = {		\
+		.mode = (__mode),		\
+		.type = (__type),		\
+	};					\
+						\
+	shape;					\
+})
+
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

base-commit: e49bb0b5e1e3a8d7783bc7222c02cc6ff90fa2aa
--
