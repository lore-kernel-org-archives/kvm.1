Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F40369D41
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405455; cv=none; b=LS4M6IkRvNv+3PzysFu6+/M1/eZ+bxQxri8VmYeNI7AMR0N9tmQ26CxwdZS4B/Ul+lB3QpJuL7lsTMyrQZjSYYOhdZgCIQEfxIVf9ykkAeVI2m7QIaxGVb/l5oQLIfyMMj8YH/Tjfo7gc9sb98Zi4bz+hAA/ux9vowuQqAdjpig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405455; c=relaxed/simple;
	bh=aD3HXwrZjvyRYUcRcwFGw0yeikfKSuTlbRJOfhgmGv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZToQ0qy5/rGMwBlo/GteAZG5roIUjhYlFhyvqJTvIrBa8z5RCffrW+m/IWQfbkih/C+kj66G8WPZZR8E8ulRQrgcGKaqA2D4iA7FnRSfZ4+AdSQu7pg1goTXi6EawmF8uN+GVzYe721wjDKCJfF/jeGr1Mv07jImY8T66z2lo9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NpQ2J+0Q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NpQ2J+0Q"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8276c91addso3739364a12.2
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405453; x=1780010253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/YlviOZ+xjrC4BOAGoW0+eAq9T/F0XwYkP7ZCZ/m/M=;
        b=NpQ2J+0QFdQFjmTLPh1OQqDiBnGquBtPdVrTQlOXZGmOd55n9HMIalh+t/drqAHfq3
         FWiBvBZmmzvFD3ATUqRrHGd9Mzn85MpO9AsBhQPjrGOP12pJ5MLmFA0nYPTp6L5g97BK
         zQNTHMP0VztcpGKzn1nC0iBNUEzO48XK6hWido5gEpHB+wjXRdXYjnvVDYpbYqYXBsGX
         agJID+6ChO1DNYxZuywsk6IxZDCUtKlJ+IopLOaXuiPlsONDn6HZlXM6aqvAWiO5ES5o
         CQZDAHtiESC3C7Ki3qE0drTOGvToeLwjnN4n7iOCD8UhgbZuEiC1Djn6wumUyxsJ5Ksl
         qSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405453; x=1780010253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/YlviOZ+xjrC4BOAGoW0+eAq9T/F0XwYkP7ZCZ/m/M=;
        b=AhISFl+5HbqauVXC7id+YznbYP4byjIwmH0US7RVfcozm76H1iKp+/BPSCbY9GV1YQ
         lqJWhWGGZaJSwVWTDLIVIXdpPIGrd6nlgyvVMWJ2cs19rqXlRQTug/S7q8yhNSrwd+9S
         B2PeXZ1hkKJD6Ne1hfhv1B66MM8qPp1DW9RNvYhvXEXfGwdVndMsQbKp9hUjzgGf8bWQ
         nogGlNIsCNfv3KlkDfOlFjT3IIdECILIiDj8+WPFYvP+dfL/HDSjMtBpqxSanj/OtA51
         H8blJgKOHdU9/WOXfv2OduutLITelKZyVpNU6jSXB4DVQWBxSi/3DK5HOS1dvBxPCDOm
         R/qg==
X-Forwarded-Encrypted: i=1; AFNElJ8PV1yW3anRQ2AhU5pbfGxLErDWeR+Cd/+o3zj9c/PCqEPj/l2ndtPfzr7EdHqETGAwV8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkAuF24E+2d+aSfyd9VFWgW91xrliPLEN0bUE0m5LFNuz6Q+6
	qwGBGuOYcJZQ//j7+2rtAvpp2yN2m7Fdo4Gv1tW+X56eiPzHcIpaU5V3WXpZBy0/OMxSx+xexS1
	qWmJOTA==
X-Received: from pgbeq12.prod.google.com ([2002:a05:6a02:268c:b0:c80:23f0:ab71])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7289:b0:39b:89e0:2e37
 with SMTP id adf61e73a8af0-3b328cfdaacmr919032637.14.1779405452327; Thu, 21
 May 2026 16:17:32 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:52 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=4707;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=BN33KsLCHuN/RaDg069+CrjelUstN+iG9teg2YCApZE=; b=loF/v83C5t/5hp0/ahmXFWBR+WYQZ874vo2GsRCiAyg2Tya7wLx7XnsShach+t2H4yPM2PTlv
 2JG44wiBlf8AX4pd48vxzI+01vl6kdEwlFYBV63GwdxY3S75xE8vHsr
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-11-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 11/22] KVM: selftests: Set up TDX boot parameters region
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

Allocate memory for TDX boot parameters and define the utility functions
necessary to fill this memory with the boot parameters.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
 tools/testing/selftests/kvm/lib/x86/processor.c    |  2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 56 ++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index d66ea7bc85f9..9660ea9d2f31 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -41,5 +41,7 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
+void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
+void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index dfabdfd17976..c7c4a37b3170 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -794,6 +794,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 	if (is_tdx_vm(vm)) {
 		tdx_init_vm(vm, 0);
 		tdx_vm_setup_boot_code_region(vm);
+		tdx_vm_setup_boot_parameters_region(vm, nr_vcpus);
+		tdx_vm_load_common_boot_parameters(vm);
 	}
 
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index bbfaa9af9c60..b16bf24f3ef1 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -3,10 +3,12 @@
 #include "kvm_util.h"
 #include "processor.h"
 #include "tdx/td_boot.h"
+#include "tdx/td_boot_asm.h"
 #include "tdx/tdx_util.h"
 
 /* Arbitrarily selected to avoid overlaps with anything else */
 #define TD_BOOT_CODE_SLOT	20
+#define TD_BOOT_PARAMETERS_SLOT	21
 
 #define X86_RESET_VECTOR	0xfffffff0ul
 #define X86_RESET_VECTOR_SIZE	16
@@ -51,6 +53,60 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
 	hva[2] = 0xcc;
 }
 
+void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus)
+{
+	size_t boot_params_size =
+		sizeof(struct td_boot_parameters) +
+		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
+	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
+	gpa_t gpa;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TD_BOOT_PARAMETERS_GPA,
+				    TD_BOOT_PARAMETERS_SLOT, npages,
+				    KVM_MEM_GUEST_MEMFD);
+	gpa = vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_SLOT);
+	TEST_ASSERT(gpa == TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pages_alloc\n");
+
+	virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npages);
+}
+
+void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
+{
+	struct td_boot_parameters *params =
+		addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
+	u32 cr4;
+
+	TEST_ASSERT_EQ(vm->mode, VM_MODE_PXXVYY_4K);
+
+	cr4 = kvm_get_default_cr4();
+	if (vm->mmu.pgtable_levels == 5)
+		cr4 |= X86_CR4_LA57;
+
+	/* TDX spec 11.6.2: CR4 bit MCE is fixed to 1 */
+	cr4 |= X86_CR4_MCE;
+
+	/* TDX spec 11.6.2: CR4 bit VMXE and SMXE are fixed to 0 */
+	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
+
+	/* Set parameters! */
+	params->cr0 = kvm_get_default_cr0();
+	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
+		    "PGD must be within 32-bit address space for 32-bit boot code");
+	params->cr3 = vm->mmu.pgd;
+	params->cr4 = cr4;
+	params->idtr.base = vm->arch.idt;
+	params->idtr.limit = kvm_get_default_idt_limit();
+	params->gdtr.base = vm->arch.gdt;
+	params->gdtr.limit = kvm_get_default_gdt_limit();
+
+	TEST_ASSERT(params->cr0 != 0, "cr0 should not be 0");
+	TEST_ASSERT(params->cr3 != 0, "cr3 should not be 0");
+	TEST_ASSERT(params->cr4 != 0, "cr4 should not be 0");
+	TEST_ASSERT(params->gdtr.base != 0, "gdt base address should not be 0");
+	TEST_ASSERT(params->idtr.base != 0, "idt base address should not be 0");
+}
+
 static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	struct kvm_tdx_capabilities *tdx_cap = NULL;

-- 
2.54.0.746.g67dd491aae-goog

