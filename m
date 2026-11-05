Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922464;
	b=SH3ZNf7ZRD9KLR7Qz1g8Jd+EWsLZac9tsQCZq8S1HGrFaaJXKP+eOPizr3rO8+ZgxKtb
	 E6eUoTmiL3c6vxRdVjOsNI/nZCPOsqsJOYRKd8PY0teqriDXX2otV004DGODMO0D+GX7A
	 +0CGYXP5iQuvL8R46VVpN89B3VcV5At+eY/Ah91cLFEzU6JssH4aVN527E4tYFLH18gG8
	 WSfd+7Zh3XQ3LUzaN3UhgjGLyzQ2Ng55kk8ZpnxEiaHvRmg1Xav8GevmcJequLHuy6r+5
	 K5gpjrdx/7j7ORnso/Zese64KD3sCP7iAThDOL9LlgieIbJkE7Bnr/ry51dFQEU6baQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tkUD1+HlFzOrZ1P0ClOG0AeXVQBT8WKUQ6xzERWmYvU=;
	b=A27FpFYUiqbBjYL9D+AvcOthJcbtsn3/lxoSmUl4iVfMvffjCYAkkVMMfkpbsjHVjXCC
	 kRhJurft2wLdzweoujcJJGr13uHvp/S42THJ+R1s8bZ1W7f+Dn08xPYzJuudSft2jSXrh
	 pu1BvvFFCOZDqPhJ5a0RJrQRAGPrrvM+ehPZlhgqFGSEcc7pPogCNkd9vtXLBkMJUoKe7
	 pELt36i4qu/gSMX4sk/d7qIyyzgl6ZqniuyixD13XiBlcwgH3iAM8xXcilYnkFEQlg7s/
	 BaPvG6r+wwb5ThVoKfyGQh7cIvmdLO49/w1wP9vy5thfneeitN38FT9JGJKkc4aYaGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HnjlMRPI;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608EF606D804
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 608EF606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HnjlMRPI
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adad90c894so108096a91.1
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922463; x=1794527263; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkUD1+HlFzOrZ1P0ClOG0AeXVQBT8WKUQ6xzERWmYvU=;
        b=HnjlMRPI/GLzGW4XP1YIpVdAGuqr1R583yOe8lOoM3grmvLowouWRaqzx2vlooWzS7
         r3hrmjg2RamKmKwBF8O+mqMOqL0JWK61pkIuntEUnT+Pz8ukhCbauBkW0QC/eUv2POR5
         kp0kRL8vS93Bb7D7YAGfCXk7i+c8QxvbiK3Jb6RFHb9FrIeVCtqioA9xJU2jiyzVDcmY
         K1snQclY8gj+HHgXkp48xyP9RsLrHlQdpdnGgD5InfuZVvUuHhuI4bOHK8uqh8yz/3fl
         aPZ+R3c3EIJVylXuWkQq+xlflLq2ChnJJq1EMecdeQBaQZM7QJTXEHHh1Nq2qHHveO/L
         wm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922463; x=1794527263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tkUD1+HlFzOrZ1P0ClOG0AeXVQBT8WKUQ6xzERWmYvU=;
        b=jSnTHEkvNEl3XuFrvBiQImMTPu383KSKtqsFO/X/3Hgyxe1vu32dhNe+7ZpJH94i3u
         H+SykctEHV1UyzsHqNQOToCtvPUBYyso/sKwa00JANxDXMXfnQ/E4iYdazyjdiewUNxq
         3hleCKM2mPuKh0MCCKzk0URLtgjmZh2RGTkUyTT8nfc1bW8vCh82VnUOlWVtqTOvL+s+
         Q7zVJE9D53N6/VQPWaoyOZCyh5uSWBlBzyarvl6ct9DFsuji3YZwbwQ51J/Sy0qBtHU4
         o/J1BWz+ZbQEEqoBBwc0nJB57YtgElvfp3TdOu9DImyqYjTMVhmTK4i6c9jsIovmVxz5
         77ug==
X-Forwarded-Encrypted: i=1; AKwUvByoNg//YebbC3F2oGEjMbgY4Cc4UE7av+o88mGintWU90uk3h/XJFAKZ7Fq5KCJ6W8K+68=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XIH2cS89n6S7lxI1lB2aWph8oOZWhsh0LqPZptQozNOwgEcVK
	3tG2MnoFEJ1h78JMkgCqPV7tka/NMuBLth7J98SaoyqRTsimeAatprOdl/FomNr08KOcvAFh8H1
	wUviAog==
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:3ac:748b:a8ac])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3890:b0:3ab:a3ee:33ad
 with SMTP id 98e67ed59e1d1-3b0db6bbc23mr686251a91.22.1793922462484; Thu, 05
 Nov 2026 15:47:42 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:54 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=4634;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=ZhhGPoqOEWroNK2UMoDhfkXAKKHsS5bAWSvZia0Q+5g=; b=uVMhZ2FdXPVbJGSlxB0VIQkQMJxICidUPHappnc6GTwjrTjmUXfU6ZGsWugbETFpbF5CFbVWJ
 2HldDLha7v/C8BNW9SX9+39zImGJYb+4DPneXwuaYp4n4Z/+paCrboY
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-10-2024e8fa517a@google.com>
Subject: [PATCH v16 10/20] KVM: selftests: Set up TDX boot parameters region
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

Allocate memory for TDX boot parameters and define the utility functions
necessary to fill this memory with the boot parameters.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
 tools/testing/selftests/kvm/lib/x86/processor.c    |  2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 50 ++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 43b4157e4a13..4330290d29e9 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -48,5 +48,7 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 
 void tdx_init_vm(struct kvm_vm *vm);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
+void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
+void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 36003cfd8d6a..a215ab6c2ea4 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -828,6 +828,8 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 	if (is_tdx_vm(vm)) {
 		tdx_init_vm(vm);
 		tdx_vm_setup_boot_code_region(vm);
+		tdx_vm_setup_boot_parameters_region(vm, nr_vcpus);
+		tdx_vm_load_common_boot_parameters(vm);
 	}
 
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index b4a7089b3636..e8deef076f9a 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -8,6 +8,7 @@
 
 /* Arbitrarily selected to avoid overlaps with anything else */
 #define TD_BOOT_CODE_SLOT	20
+#define TD_BOOT_PARAMETERS_SLOT	21
 
 #define X86_RESET_VECTOR	0xfffffff0ul
 
@@ -41,6 +42,55 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
 		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
 }
 
+void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus)
+{
+	size_t boot_params_size = sizeof(struct td_boot_parameters) +
+		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
+	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
+	u64 gmem_flags = 0;
+	gpa_t gpa;
+
+	if (kvm_has_gmem_attributes)
+		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
+	vm_mem_add(vm, VM_MEM_SRC_SHMEM, TD_BOOT_PARAMETERS_GPA,
+		   TD_BOOT_PARAMETERS_SLOT, npages,
+		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
+	gpa = ____vm_phy_pages_alloc(vm, npages, TD_BOOT_PARAMETERS_GPA,
+				     TD_BOOT_PARAMETERS_SLOT, true, false);
+	TEST_ASSERT(gpa == TD_BOOT_PARAMETERS_GPA, "Failed vm_phy_pages_alloc");
+
+	virt_map(vm, TD_BOOT_PARAMETERS_GPA, TD_BOOT_PARAMETERS_GPA, npages);
+}
+
+void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm)
+{
+	struct td_boot_parameters *params = addr_gpa2hva(vm, TD_BOOT_PARAMETERS_GPA);
+	u32 cr4;
+
+	cr4 = kvm_get_default_cr4(vm->mmu.pgtable_levels);
+
+	/* Per the TDX spec, CR4 bit MCE is fixed to 1 */
+	cr4 |= X86_CR4_MCE;
+
+	/* Per the TDX spec, CR4 bit VMXE and SMXE are fixed to 0 */
+	cr4 &= ~(X86_CR4_VMXE | X86_CR4_SMXE);
+
+	/* Set parameters! */
+	params->cr0 = kvm_get_default_cr0();
+	TEST_ASSERT(vm->mmu.pgd < (1ULL << 32),
+		    "PGD must be within 32-bit address space for 32-bit boot code");
+	params->cr3 = vm->mmu.pgd;
+	params->cr4 = cr4;
+	TEST_ASSERT(vm->arch.idt < (1ULL << 32),
+		    "idt must be within 32-bit address space for 32-bit boot code");
+	params->idtr.base = vm->arch.idt;
+	params->idtr.limit = kvm_get_default_idt_limit();
+	TEST_ASSERT(vm->arch.gdt < (1ULL << 32),
+		    "gdt must be within 32-bit address space for 32-bit boot code");
+	params->gdtr.base = vm->arch.gdt;
+	params->gdtr.limit = kvm_get_default_gdt_limit();
+}
+
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.56.0.455.g6c5a503b38-goog

