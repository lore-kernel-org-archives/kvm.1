Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045BA5383F2
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883539; cv=none; b=tw2X5995Rb9eroWZjZKBoWGFNUXHr5Tt/rR7AnqvvQKXNdFEgKWM9+D8+18ZwKGGpGgxwsGfAHZzwc8mJ5HUhg2mSsJG8iqHCSXbArfDpRfocpIiZDZ/f6sqnzWFUi1plA/R4WgoQomHJuYeA4n4r6ye1GROtpReRH/rOZNaQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883539; c=relaxed/simple;
	bh=70yzso9mTpjtAZvDQw6MEGUzLnCLrVD066F6p3Zhl2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z5HpRhUP+2pRl/L9bzp9sjvuyjw8JJ0j1G1crnqm50xh4qVDrR7/Gsin5x/xJ6dRUUlzJQqRIeNsx5VUfL/ktgvbd9uNYEer9aCjp0ecYLYc3ioYcvMYpacwxK5gy5kglRfynvhG8gOy/QDZ+GI4khi4V7nS65rOky9N8eGgbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2TbK0n4; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2TbK0n4"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so11116252a91.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883535; x=1791488335; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A4TZAQ6Bf7T7xY4lGMxLLjKedsMydQ7E/lyehw+8438=;
        b=Y2TbK0n45DVOPvHYGOY2hubox3jAuBv4sXHsAIctUycY7fE5vWnISLob9OkpYVlNN/
         pSbKPQsxK9XoMS9KHIyjSVIu3JEfSVkE7dLPcgrFikmS1J/9e4bk3dtiB5GDeIu+Lycx
         6rJky+blnRa3XuExYq+4DxtGOoIh0135zpM/lHg6FaO/z4QE1E3KFyL+xokrjDGPXhlv
         Isqx4i2/fKfJ27NNXk3Mgt4UpjMdLjwV/VnGmG6P4qAHoo3IM4hBrmcMly5chYbd2B4+
         mMkWUM1AIbZEUmokpgAsnqQcRA7WxzqBueY8DrtbgUWD9I3q3fqt03AQhXkV0OMZ06q3
         tb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883535; x=1791488335;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4TZAQ6Bf7T7xY4lGMxLLjKedsMydQ7E/lyehw+8438=;
        b=j5C/8NkU86Rh/TB5FHEqnSPGp0VmdopG2bsyWlYKVqibhxTbL90WDUNkur18/9dVLr
         IstJlGJY4qcW70x+2fQj6mnnYCjNyTT1QDy92KnepNZk/07g+qfrDGwHabUsOSoZOej3
         tbRddgeavENnbm+Ekql9vdhsvDGvVmt+L+D9g+VoTjc+Nr9SdWn1ZZYcg1VNyjbDtFbU
         qIvzI6bMh7rGJOKSZLwUaU3WY+b7pCZOOFm3Y6VY87PoYM1EOemL0uaLLz9Hy01aDy8d
         Gubta1UMqBYiC9qsWqPHVOxr0+nu5aPXyK3ae/01FOzsVWW4cLO67JWjfWbbgL6akj3f
         NQ/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxv83V594RYcbCkkmAmASdCf4Y9tXZYJirwglIOQnB0n0SkT6dtgIpTK2ybXu+j5DG5UZg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJumhHbLbUux+OUhCo+nojO3B7D2JcVRGDpeWkw+zK+km9ZVsbz
	8RYhGILUKp2EifosWZ6o4AuXvT1SGu5jM7i6YqK3kzoCwC1OeFKvKYClRyNGDZ2c6WU6KGzz58X
	gfOupYg==
X-Received: from pjbic4.prod.google.com ([2002:a17:90b:4144:b0:3a4:ddaf:87c4])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1642:b0:3a4:a1f1:fea4
 with SMTP id 98e67ed59e1d1-3a6ce761d36mr503563a91.26.1790883535257; Thu, 01
 Oct 2026 12:38:55 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:42 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=4160;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=6uzrO/K0PGoda6MU5XX7QhxZsSju3qRYklqNZ/DxwCk=; b=RMhvLxjHiZg/NAnzEV+4iZSvnKzg391Z6Rf12P7z3bBg4BZXIhza2N6BA9uH87y5RlaEPFRD8
 nBU9vUy2uxmDkD2JzzqsG8amoq78F2lsZMMiIV6WErqijh6SmMz4Rv0
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-15-7c62a5d8a992@google.com>
Subject: [PATCH v15 15/23] KVM: selftests: Call KVM_TDX_INIT_VCPU when
 creating a new TDX vcpu
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
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sagi Shahar <sagis@google.com>

TDX VMs need to issue the KVM_TDX_INIT_VCPU ioctl for each vcpu after
vcpu creation.

KVM_TDX_INIT_VCPU has a strict prerequisite for the CPUID state. To
satisfy this requirement, call KVM_TDX_GET_CPUID and KVM_SET_CPUID2 to
pull the CPUID configuration from the TDCS and commit it into KVM,
allowing KVM_TDX_INIT_VCPU to succeed.

Additionally, unlike tdx_vm_ioctl(), tdx_vcpu_ioctl() doesn't check
hw_error. KVM's vCPU-scoped TDX ioctl handlers don't propagate SEAMCALL
errors into hw_error: the error is handled in the kernel and only an
errno is returned. Checking the ioctl's return value and errno is
therefore sufficient.

Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 20 +++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 48 ++++++++++++++++++----
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index e529c587aeae..f5b2f32f2118 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -46,6 +46,26 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 		    (unsigned long long)hw_error);			\
 })
 
+#define __tdx_vcpu_ioctl(vcpu, cmd, _flags, arg)			\
+({									\
+	union {								\
+		struct kvm_tdx_cmd c;					\
+		unsigned long raw;					\
+	} tdx_cmd = { .c = {						\
+		.id = (cmd),						\
+		.flags = (u32)(_flags),					\
+		.data = (u64)(arg),					\
+	} };								\
+									\
+	__vcpu_ioctl(vcpu, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd.raw);	\
+})
+
+#define tdx_vcpu_ioctl(vcpu, cmd, flags, arg)				\
+({									\
+	int ret = __tdx_vcpu_ioctl(vcpu, cmd, flags, arg);		\
+	TEST_ASSERT(!ret, "%s failed, errno: %d (%s)",			\
+		     #cmd, errno, strerror(errno));			\
+})
 void tdx_init_vm(struct kvm_vm *vm);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 4a753fb43007..4af9cbf3fabb 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -876,16 +876,48 @@ gva_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
 		    "__vm_alloc() did not provide a page-aligned address");
 	stack_gva -= 8;
 
+	return stack_gva;
+}
+
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
+struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
+{
+	struct kvm_mp_state mp_state;
+	struct kvm_vcpu *vcpu;
+	struct kvm_regs regs;
+
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | 0x2;
-	regs.rsp = kvm_allocate_vcpu_stack(vm);
-	vcpu_regs_set(vcpu, &regs);
+	/*
+	 * Both kvm_get_supported_cpuid() (for legacy VMs) and KVM_TDX_GET_CPUID
+	 * (for TDX VMs) return VM-scoped CPUID. e.g. the APIC ID isn't
+	 * populated per vCPU. This is fine because KVM selftests don't
+	 * currently test CPUID topology enumeration.
+	 */
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
2.56.0.rc1.315.gc6ed9934b7-goog

