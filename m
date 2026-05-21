Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D137F729
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405459; cv=none; b=qlAL4R6XwlJqTGh90sy2OuFAG72p8W18A4FLJNtQYv5BDBN2qUCY2dAtPTPPw4xNWLy7ny/uJVGH3dg0MEQXcnP7D4ryJh2KXuU+iZ0GxTP8qFQ65m/z56me8fb41qoJEF2AMvGHVM6yfTVqLIPJzM+6123y8XPkzgkuhfTbU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405459; c=relaxed/simple;
	bh=D9P4tE7ZCaYPM4Lo49MsNRm8+yLU+Sliee5dpTvJ25w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K3PnqunXg36YzSFkjCGgXDIjncknrb0nVwlIuoQywUHfppfLigTRoLBud8wfOYTkLDqPOlZloqVzsLWAXuKpM5AaJfvJcVSdcxv57wLHmDisgALtBqqyb8xtn+uKaZfVOCIxqDpllrZZWYgvfuRvPyut5HXMp4hxYpBk7plHqrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYAqQt0M; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYAqQt0M"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82bd90afbbso3434120a12.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405456; x=1780010256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fal733LKjrF+aMDpk8cvZFYXhl0cvYkDiUzCCzsnAww=;
        b=vYAqQt0Mk94VQz23WYEyatsySoqYDAdB7B8YfsOQVWLpz+dL8XUNIIloUL1K3TgRR8
         6Gch7BiEr89MCamnGAdNY5a5snkGisc3X3l9twlCn1cGtWOzBKDwuFcUbn911MfFD72g
         P5iIPq+qndUFTW5QCUl7vpVKM2i5ulLztlArGTBvPhCA2rcX14JhApMObfuYFSH7+xIx
         uNULUSlRvb8NQQNtPtbww4F1Ie6Xy9Navr1eyNro2ha25i+KzgnCIclNXP+phBsPrjJj
         X/D4wHS9Djd2iBFGyMV2ASvRzw5/0I+lAjOGtXveHGg4eA+kNRl5ESnUmXzXBGVLmDBx
         nW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405456; x=1780010256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fal733LKjrF+aMDpk8cvZFYXhl0cvYkDiUzCCzsnAww=;
        b=cjRif24k+NtpNgbgAPQ3OaMSJwupGfFAuOEXuMutZ3ad9cKomRxwicec7xmwpXN6Uu
         WkOI/70pJXHGrQbC8qmST+cmkSEfSyAwzFIzeNnpTMdtGQ2IDZT1Qd7XM3qLDvO4ck79
         qWKT+0LLyTgHAiahupQ3xIjcrWa1YqRvyjcjr69++TUnR5S+A8/Gvgga4xtUHHkgnGRm
         q8VsBup64gf0rcSUEVTF608aq7wgNxH16ngyb3OTee+AKeVTjC+7wf20skPIS3I7Sf6X
         /Z+MicfXh4R613q0iBBqD0bm/JKXuv1qVuJlY3XmHaroma6d1ovs/CLmHTNlshRzqhzl
         xi1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+o9yL9+qEcQo8bxhmFC9Nv9RUr0M6wLyjO8uMTtk/BmbCYMOyAYb+A+prfhCczCit7ARw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5V9PFLQZLCqBmW/XIZnMxlrY51NqbC5aa3uAcVKG+/B5BVIj
	QjMA9Cj9SzFXqS+ZQUm1cZHEYNbfbsDxTfreTaYKsuAmyjIhzB5b7ZxeFh7uxpfXWMly+YxBqUE
	L2s7Q6w==
X-Received: from pgjp8.prod.google.com ([2002:a63:e648:0:b0:c82:7805:9e3d])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:d86:b0:3b3:2703:117
 with SMTP id adf61e73a8af0-3b3293ba4b1mr850267637.41.1779405456015; Thu, 21
 May 2026 16:17:36 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:56 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=3611;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=E/2s/eNKzRwgdQCwtrmupmp2YCJsCjvR2i/0uIlmg2Q=; b=Swfurcg53BseZBzTaHEl3au1Y9oIM0oCuSEReJiWE4K0//Cc7hFlYPMq0rXNDoeKRNIgZIPoT
 NeEz6rKaTbfCT2pCI6J1SMuW7t1VBKiqv7rOlRakIJw9SUOF2RdHH6i
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-15-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 15/22] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
vcpu creation.

Since the cpuids for TD are managed by the TDX module, read the values
virtualized for the TD using KVM_TDX_GET_CPUID and set them in kvm using
KVM_SET_CPUID2 so that kvm has an accurate view of the VM cpuid values.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 24 ++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 33 ++++++++++++++++------
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 9660ea9d2f31..4d01f806b37d 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -39,6 +39,30 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, vm);		\
 })
 
+#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
+({									\
+	int r;								\
+									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (u32)(_flags),				\
+		.data = (u64)(arg),				\
+	} };								\
+									\
+	r = __vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+	r ?: tdx_cmd.c.hw_error;					\
+})
+
+#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
+({									\
+	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
+									\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd,	ret, (vcpu)->vm);	\
+})
+
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 8b0aa64384a1..757da2295ba0 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -838,6 +838,17 @@ gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 	return stack_gva;
 }
 
+static void tdx_vcpu_init(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+{
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	tdx_vcpu_ioctl(vcpu, KVM_TDX_GET_CPUID, 0, cpuid);
+	vcpu_init_cpuid(vcpu, cpuid);
+	free(cpuid);
+	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_VCPU, 0, NULL);
+}
+
 struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 {
 	struct kvm_mp_state mp_state;
@@ -845,15 +856,21 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	struct kvm_regs regs;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = kvm_allocate_vcpu_stack(vm);
-	vcpu_regs_set(vcpu, &regs);
+	if (is_tdx_vm(vm)) {
+		tdx_vcpu_init(vm, vcpu);
+	} else {
+		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags = regs.rflags | 0x2;
+		regs.rsp = kvm_allocate_vcpu_stack(vm);
+		vcpu_regs_set(vcpu, &regs);
+	}
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;

-- 
2.54.0.746.g67dd491aae-goog

