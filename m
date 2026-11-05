Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922475;
	b=zatNynWN0nG3zPL+Ove6g26QRBNFnslRlIGQz+M6ivZ4s5IevfhsG8FW39yF0oVEB+wY
	 VUrupL137AibplujZpnSNExew/saZy16/i7pWO/8F3wofhK9aNQczCTb/IT3x103yEZ7A
	 CMbmZqjNqte6pfvHMv59fF7sOHzaEJr2IPtYE8OOxjUcA/Y3HzXdv5AyS2KOX1oMmroD6
	 IFdQYG26V1wpyDb3I5ApJVxemla+jKqAJURWwh5690jUZCWxP/kMasVxcubLy74Z/dd27
	 YB3gYCsegt2DBiJL01P9B/7Xv6pmu4SVp4gheBedGS8fxus6n1UU1+chJpOvWK0HUuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=dltJxZOaaLIRzlIDxCRL5isHAiYz3/DbONY34y9BZj8=;
	b=MDPHTXQ4I7Pmjyy1RCqw294zdTkGU8HIFkXsnPyX+G8fQ64aUh+DmCY5IM6I/Y5veVDG
	 KgGysBSPSLJ31oHav0cJr814n4CwgHja5B6s0P3oQZebulQOHCjhfvu99xvLIiUBIPcGL
	 3ORN4IC8kYOVxsuxGtqbphiIrxnQTiq4FWAPD58LvEmomZ0LB/SDskKYEp+EzWSYQsowp
	 9QOvehNj2eJ/bEzwWL7gQ0F9KxUJgC4oH8gSPoU8+VsGXU3eQ2u2aQUvmz/Lq3BvH83RN
	 m2MZfjRDBy/AQQUQgoMWtMWjz0o9/HFWtyL3ksB1Yazn4xgO9/knBAmwJzzvItEMFDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mFapDrC5;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FD606D839
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868FD606D839
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mFapDrC5
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eb5375cd68so609475ad.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922474; x=1794527274; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dltJxZOaaLIRzlIDxCRL5isHAiYz3/DbONY34y9BZj8=;
        b=mFapDrC5bbYYwkEE8q5HPgPaZPQU9NcALsUX7gtCeQlSUQYx46JDoNpdTWxmDB72o3
         n/YPFKADv06WtHuv5T1lQWl51/fH5dlj3Yxkd5htxkSuiIC1CRZRF9RtATc2SP+foDMl
         wpVaVtk+LPlPy07x7P1FK9UMcXdUKotfdoSfwI4Q4V6tQdQq4enUFlKI9W2F1iL5FWjr
         pJWQ8C3H5LC1hv1f8ItyOu+JrDy30GMiJJ2fsXBjT7357nB7izxQFQ0XutuDhCo8VfsO
         ISpnNvzqE+ns73YuI0mldM7ID7kEaerIgfag32iIwGll9mUNLlEFeyZY8Ji8/Hon7/8F
         4UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922474; x=1794527274;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dltJxZOaaLIRzlIDxCRL5isHAiYz3/DbONY34y9BZj8=;
        b=EBMZsuliWjVo0nXE7e6bjeyB91VcNwsaf+TmTPRNC1zGGs7NkLXRffEIf+Oqg4fWup
         /0ktEixsTFouRX76lEz2y3RbX3LEaox9atKDxDQjEZhiCcPM+KxlECiHRmlACnx8DZQH
         ccPR/D3vIqBgJ3j/hWuSUtVmuRn5SUFffGihxaT9gJ515zPW1eMZ0IgrG9RJ/vP6VFkE
         P4Q7Pypxm92igeu9ifvFYNu7qqvwowAdlvScD17TKGlzE6c8bZ+2qWyA7i21YzLMl0DE
         oCN9OT/hrZoJRrf7mAQ04by0gSGTZwNA9DtHVrmp5n41Q6du0L5HJYsyrjHjE2XhW1pg
         driA==
X-Forwarded-Encrypted: i=1; AKwUvBzssZHjBrCZpxbIEhQ6eeesDcVq9rNHqIm7LEgp1Ea1DsnRWKKbr9wZdTNOJsMfN1mx6zw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y8P7lagLl3sAtUDXrz347ZWlNL2rYZJgm3De2X3BKr1uiPV73
	jRtyQN8iShX0Qt19nCEuTQpuLmqV3DPAx9XKBQpUyh+yTlb/ybFZHFqgbKEOkH324Gh/8THx0tS
	o5eoJPg==
X-Received: from plbkk12.prod.google.com ([2002:a17:903:70c:b0:2e9:6e08:e249])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f687:b0:2df:ad58:cf54
 with SMTP id d9443c01a7336-2ed40bdde10mr11672345ad.34.1793922473653; Thu, 05
 Nov 2026 15:47:53 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:56 +0000
In-Reply-To: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=4756;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=xg4VCXAEcI/squiJR5LykngUMIA2TG3fuJmNzqsXTYk=; b=Aqkp8MzL3DHBTEXTKQtgCet5lNRmh6G+KNMhKEoKvCWwSpBvnv7ANRei87X+c6tDZollC/ud7
 wcGy4KzQUpPAsQ4mHa1U8bQqxgIQjM6O+47atZY3EJ7zJ0toeuQkto1
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-12-2024e8fa517a@google.com>
Subject: [PATCH v16 12/20] KVM: selftests: Call KVM_TDX_INIT_VCPU when
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
 .../selftests/kvm/include/x86/tdx/tdx_util.h       | 22 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 27 +++++++++++++++-------
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 11 +++++++++
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 4330290d29e9..9d951f67b3b5 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -46,9 +46,31 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 		    #cmd, ret, errno, strerror(errno), hw_error);	\
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
+									\
+	TEST_ASSERT(!ret, "%s failed, rc: %i errno: %i (%s)",		\
+		    #cmd, ret, errno, strerror(errno));			\
+})
 void tdx_init_vm(struct kvm_vm *vm);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
 void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
+void tdx_vcpu_init(struct kvm_vcpu *vcpu);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index a215ab6c2ea4..110d23e50bcc 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -865,15 +865,26 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = __vm_vcpu_add(vm, vcpu_id);
-	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
-	vcpu_init_sregs(vm, vcpu);
-	vcpu_init_xcrs(vm, vcpu);
+	/*
+	 * Both kvm_get_supported_cpuid() (for legacy VMs) and KVM_TDX_GET_CPUID
+	 * (for TDX VMs) return VM-scoped CPUID, e.g. the APIC ID isn't
+	 * populated per vCPU. This is fine because KVM selftests don't
+	 * currently test CPUID topology enumeration.
+	 */
+	if (is_tdx_vm(vm)) {
+		tdx_vcpu_init(vcpu);
+	} else {
+		vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
 
-	/* Setup guest general purpose registers */
-	vcpu_regs_get(vcpu, &regs);
-	regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
-	regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
-	vcpu_regs_set(vcpu, &regs);
+		vcpu_init_sregs(vm, vcpu);
+		vcpu_init_xcrs(vm, vcpu);
+
+		/* Setup guest general purpose registers */
+		vcpu_regs_get(vcpu, &regs);
+		regs.rflags = regs.rflags | X86_EFLAGS_FIXED;
+		regs.rsp = vm_alloc_stack(vm, DEFAULT_STACK_PGS);
+		vcpu_regs_set(vcpu, &regs);
+	}
 
 	/* Setup the MP state */
 	mp_state.mp_state = 0;
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index e8deef076f9a..1719dc1bb060 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -91,6 +91,17 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
 	params->gdtr.limit = kvm_get_default_gdt_limit();
 }
 
+void tdx_vcpu_init(struct kvm_vcpu *vcpu)
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
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.56.0.455.g6c5a503b38-goog

