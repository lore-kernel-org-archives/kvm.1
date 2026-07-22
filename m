Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020B459AD8
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762070; cv=none; b=PNHb/9z94FpuyZW19xdDp7enc9XLR/kXE+XMAlQZ5bk/MtPaFLiFqP3ennc5pnb4U7XnywyF4WrtoY3R4axaeHzExJyG3DlaogKQCaFcpS/TIsgS7+oEX616kzM0kIRKWbPQgKzDZe2w8qaGbx4c27aTsxYW8gnxR++je2v2g04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762070; c=relaxed/simple;
	bh=zZzVrLnqgX5NCe2uXFsKt1T0XrTCHMmVN/7IIfMKdPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=acP3TKi76sCGVLid6V/asqnDnTdtv622ggZ84PlTKa6+DJyB2DJJENZSJS3gTH6EXVTfUa0yCRh1xVDvH7uAhuxhMAjOYJRf1aIQGC3J6EnbORuikQVjjrJ8wBYILj0irnAAEIBU8zUIp5BbUGd/deaqSEMGXa5jkgE93Mf++sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GC8NWR4y; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GC8NWR4y"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca124bf0189so2012a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762067; x=1785366867; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGDAjh7yFH3A4fNogRP5xVRIbvOG+E+4bwq+sQxTTxs=;
        b=GC8NWR4ycFpgpS9b0eo3Aw67k0+pNnJ8jKzVFjpWXiM+VhkCKXdtnXyiA+Ui07suAe
         eXqvg5efpYAy1xnfa9iTjBZbdLkmeSLXSBVkaBiWi1bIroN4xKWsz9P/7LFN94n6kIRR
         UfIBMseC6qf6nYb6LdErfFJtmsoOO1+m5xEmXerbc6IZhMMkXC/C+BUkhYXPsdc7zxNh
         Rdo6IKVR2w1N1sX3jMNR+gEiz8uR+l9zFzGTerawIDxiTo5/oN3IlPaEIMjWAFVLQlYk
         resO/8+0KsXPe4OHIdZZQCFtmOPzywShchFdhuKWUqQfNXh57co5TF7LS1kkRItKfWyO
         eBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762067; x=1785366867;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGDAjh7yFH3A4fNogRP5xVRIbvOG+E+4bwq+sQxTTxs=;
        b=Ek0JBD1OYFFhwu4n0z834VLkw1wFR8jSszy9aIM3rACY9SQJL06ieulQ315zZojVYZ
         p1D8CW9YDSiPQUpWsMuiX187ZjlUxP7aX08nz0dFZ7uYhPAvqtAHudMQN5tGLwrQmZ2M
         Kwjg3+RiQlDpC9fRNG/1Lau4jt/geGpN4yuOeOQnf/4xPj3e1rQ3J90uZ9wmnpp1UzkA
         i39EDU619H1/Pa3ppKc1GVDvJpiSCfKd4GlxrUUXMwj2xzyxj2cuo7HCf5Nz1tbJag8d
         WjLylDYHOLegVnERUR6Oc4haWPiTdfyaFyzlWQu88/Oy7q3hg85wLFxCbpQW00oHtfVF
         xoVA==
X-Forwarded-Encrypted: i=1; AHgh+RqE2Y5sif1VsxlAJCSp80CNBOLyIOWRPU9yifF3cG8bSDyrEyuKQkBGWXB3IsB5lzlUK08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTg+3LlJ5AMSdiQqajl8KgwLNTgG3x0V4F/bhChukP4Yh5xTzz
	lFVI2KLhCDQHTj9/Mvc+TGA3ICUqNEftyXt5vCjk0WA2mGs3Gd+AzPrmi/o1UjHnc4mxT4gQFn3
	V7+9p+w==
X-Received: from pgcv17.prod.google.com ([2002:a05:6a02:5311:b0:c93:59ff:8d6d])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a97:b0:3a2:c9a1:2c26
 with SMTP id adf61e73a8af0-3c44c95c87bmr312696637.7.1784762066939; Wed, 22
 Jul 2026 16:14:26 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:16 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=4491;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=P3owxtLsKMvv9okvSM89mKMQ3BM4k0MGM2Mh0dCe1uA=; b=62zD9UnHJb4hBmlcuiUbSAkoiFlVPJ3RSH5zmYrf06sE+0OJIjaJyfs2g2w8mdcK2zLz//sYZ
 22kl9844njFBc+NDTJGIfUGPRgvH/RX3v53+wzJP4N/ROQjc6Ddq2rK
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-11-15ad654a50db@google.com>
Subject: [PATCH v14 11/22] KVM: selftests: Set up TDX boot parameters region
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
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 51 ++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 642ffa010da3..f5003cbaa106 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -46,5 +46,7 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
 void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
+void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus);
+void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index f93953777ca1..748c6041f8bf 100644
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
index d64d153d19e2..2ce8c297f7ed 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -6,6 +6,7 @@
 
 /* Arbitrarily selected to avoid overlaps with anything else */
 #define TD_BOOT_CODE_SLOT	20
+#define TD_BOOT_PARAMETERS_SLOT	21
 
 #define X86_RESET_VECTOR	0xfffffff0ul
 #define X86_RESET_VECTOR_SIZE	16
@@ -49,6 +50,56 @@ void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
 	hva[2] = 0xcc;
 }
 
+void tdx_vm_setup_boot_parameters_region(struct kvm_vm *vm, u32 nr_runnable_vcpus)
+{
+	size_t boot_params_size =
+		sizeof(struct td_boot_parameters) +
+		nr_runnable_vcpus * sizeof(struct td_per_vcpu_parameters);
+	int npages = DIV_ROUND_UP(boot_params_size, PAGE_SIZE);
+	const u64 gmem_flags = 0;
+	gpa_t gpa;
+
+	vm_mem_add(vm, VM_MEM_SRC_SHMEM, TD_BOOT_PARAMETERS_GPA,
+		   TD_BOOT_PARAMETERS_SLOT, npages,
+		   KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
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
+	cr4 = kvm_get_default_cr4(vm->mmu.pgtable_levels);
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
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.55.0.229.g6434b31f56-goog

