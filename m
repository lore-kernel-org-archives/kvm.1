Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965765326B5
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883534; cv=none; b=YPpsUGZpFPcOLZtHdrdSB9hoOW22RdP+8KdW3QpUq8iF7w+buTDatq7k6cfDZ/MZ/1ONql7fD0eL4tcPIS0fInU1zSAPOuyT2tgS012MPAIrwlFGJuh2uHyb8GqD/M+n8Ip66uJKS89szK7Xfq+m82hXyf3hFMrPPBvO0g15e7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883534; c=relaxed/simple;
	bh=rZSUlmnklCjSidXt9Wto0VjbnMY1avAw3XwYgF2UZS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mVnIMEw+u9UaostmzX9dps/3ZeZKTf6D0UR9P00Ofsf1yesgo/nSDLZLRmBGooRYCw1DU1FCGo8YrWO1CiY4+en0BaL98n7nBf9TaEPSxeB7MJ76WwGo8jCFRdcixQ++Xe7jLCMqg8ZwEzSkwLJODUUb4tj266/hP0Cucp7aZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5aEG3TQ; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5aEG3TQ"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8710450f731so4812083b3a.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883530; x=1791488330; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/SHN0sSvwheqQ8KGKeFT7YW5j5XFWKj522jCKeXoSE=;
        b=R5aEG3TQzYmAxiX3NgSwgIg5ixBRa7YYd0Ws2oD1pm+TVe76DAOzxGwBE+Ir2UzcJ6
         nMRlb85eXhpkElh/e9pobE9SnFPY61zZBtDPpKkqIzMgpQdgAb0yXCvVfOeZ1t2Zn7NQ
         ZlU7swZ9DTq66GreOQfa8+doiIqDTNqaARfi1wlYgdsXYo/qH6sIreOvEVCPw3OgyaeY
         YiPiM/7NOQe3jSaHbp5dxFRHst1ISzhbMmFHJsfIGt24HR/4XO5MSHqu8tKPKdqCiIiw
         1lvo5wqUmYKXFOzA1Ra7yE3eIP+oDQbbKG8RuT8ZmihZcoGc3UhzCmxo3TUuOFefApcX
         D+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883530; x=1791488330;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/SHN0sSvwheqQ8KGKeFT7YW5j5XFWKj522jCKeXoSE=;
        b=iMu3mNo7x07e2nkIfrsuAPCm9xfUhrPCscRvvUdS4WXuX7KDLnMNSDnazOG4MmbwsS
         K+feWGGdlxcOTTZ2mL1Xsm8j+7kdZOOkxp3CN9qZyCqEiIAM+nMSVifpiIOdebT18D+V
         teAFJInMeMF5C7+waMLhlTnLTJQ1pY+YCrSOT2nnEfOpcD/Y+eBwWhUNYOPXwptpk3Hg
         O245WvTNzaViUzFILm0aqfgHX0Kp1UP5KOgY9K/i8ZZqnyie/ZCv42YuBD+aos1troCF
         3igvXu2MEOSi1rX3ytoXCuQRM6o3/pgrvfDjymXCwvGEsfJJFk0y9jjBx1Lc+dyDh52p
         AfVQ==
X-Forwarded-Encrypted: i=1; AKwUvByxcDL9+N/NZc8nboidgsA/Hx6ckhpU9I5m97+SR8T4RoBxwj1NLlm1aciKcXT80fyt1ts=@vger.kernel.org
X-Gm-Message-State: AFuF++n7iHBT+sP+y0es4Rfx9nIWalS7YzjkCil1X+aPDayT5ut+uj+5
	gVXKerb6lioqQJANiCkSj4MMY6hefggXN+lkhe0BwxOKtl0HYY9PSHLDgVRS3GeO1uVC2EmcKxC
	gRGlURQ==
X-Received: from pfbdn3.prod.google.com ([2002:a05:6a00:4983:b0:886:c063:eb7])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4191:b0:886:6722:5304
 with SMTP id d2e1a72fcca58-88af5da4797mr440373b3a.34.1790883529931; Thu, 01
 Oct 2026 12:38:49 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:36 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=5394;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=Ws6P4tgDetAmZ2/mm6SGsEyyc2B138SatS7RhdOPxLc=; b=P7GVXt2Awr63edHkWTDmNQqdN+eA8ellNEv1lNHinYr7k8YJXrRa4thSH5YtcaM9UWlHuoTSc
 EiO4ouGwrbKBaIld4BfmxHUKNg3dA193dMARMYwIqQGY43VMaTSuxPv
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-9-7c62a5d8a992@google.com>
Subject: [PATCH v15 09/23] KVM: selftests: Set up TDX boot code region
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

Because the reset vector is located just 16 bytes below the 4GB
boundary, there is not enough space to fit the entire TDX boot code. To
solve this, insert a small trampoline at the reset vector that jumps to
the actual boot code.

Place the boot code immediately in front of the trampoline. Because they
are contiguous, they can be copied and mapped with a single operation.

Use virt_map() to create an identity map in this memory region to allow
for seamless transition from paging-disabled to paging-enabled code.

Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 .../selftests/kvm/include/x86/tdx/td_boot.h        |  2 +-
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c    |  4 ++-
 tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S  |  6 ++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 35 ++++++++++++++++++++++
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
index 577e7b23c51c..8f47a3893f59 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -72,7 +72,7 @@ struct td_boot_parameters {
 	struct td_per_vcpu_parameters per_vcpu[];
 };
 
-extern u8 td_boot[], td_boot_code_end[];
+extern u8 td_boot[], td_boot_code_end[], td_boot_reset_vector_trampoline[];
 
 #define TD_BOOT_CODE_SIZE (td_boot_code_end - td_boot)
 
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 571f7ce4b8fe..e14566919601 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -47,5 +47,6 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 })
 
 void tdx_init_vm(struct kvm_vm *vm);
+void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 0c3779e7c275..e3cf56c9c852 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -818,8 +818,10 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
-	if (is_tdx_vm(vm))
+	if (is_tdx_vm(vm)) {
 		tdx_init_vm(vm);
+		tdx_vm_setup_boot_code_region(vm);
+	}
 
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
index 726ec51e040e..a04011b91ae4 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
@@ -56,6 +56,12 @@ td_boot:
 	ljmp $(KERNEL_CS),$1f
 1:
 	jmp *TD_PER_VCPU_PARAMETERS_GUEST_CODE(%eax)
+	int3
+
+.globl td_boot_reset_vector_trampoline
+td_boot_reset_vector_trampoline:
+	jmp td_boot
+	int3
 
 /* Leave marker so size of td_boot code can be computed. */
 .globl td_boot_code_end
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 3a8900ff2540..6187cfcf6a74 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -1,8 +1,43 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/sizes.h>
+
 #include "processor.h"
+#include "tdx/td_boot.h"
 #include "tdx/tdx_util.h"
 
+/* Arbitrarily selected to avoid overlaps with anything else */
+#define TD_BOOT_CODE_SLOT	20
+
+#define X86_RESET_VECTOR	0xfffffff0ul
+
+void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
+{
+	const size_t total_size = td_boot_code_end - td_boot;
+	const size_t boot_code_size = td_boot_reset_vector_trampoline - td_boot;
+	const gpa_t boot_code_gpa = X86_RESET_VECTOR - boot_code_size;
+	gpa_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
+	size_t nr_pages = (SZ_4G - alloc_gpa) / PAGE_SIZE;
+	u64 gmem_flags = 0;
+	gpa_t gpa;
+	u8 *hva;
+
+	vm_mem_add(vm, VM_MEM_SRC_SHMEM, alloc_gpa, TD_BOOT_CODE_SLOT,
+		   nr_pages, KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
+
+	gpa = vm_phy_pages_alloc(vm, nr_pages, alloc_gpa, TD_BOOT_CODE_SLOT);
+	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc\n");
+
+	virt_map(vm, alloc_gpa, alloc_gpa, nr_pages);
+	hva = addr_gpa2hva(vm, boot_code_gpa);
+	memcpy(hva, td_boot, total_size);
+
+	hva += boot_code_size;
+	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
+		    "Expected RESET vector at hva 0x%lx, got %lx",
+		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
+}
+
 static const struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

