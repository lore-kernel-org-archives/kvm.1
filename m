Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922463;
	b=JstGS/ZYgtgvdrEcyjOzWPdXu5nOE2Iji0OAMpCPuYjgc4Z4RPDTa07T83LTRR1Bdv4Z
	 GwiXJBVSC89LuPbtiegJ/zF80AWnt89dGQqt3BS1vRoB36pQT7ycKfSd+9/WNxKvMuQgW
	 G7SWZUctTP9VnHwb5lqjXYDhGkiNAE+aytiZYK9QLfVIFJ+GU9trTfoZ1zIQc9QFBbsNd
	 UwZrtpBKQVJyvXwLtHskK4UmuN6RTsZdeq6KhAIAjehl8ulHEwK6HeJy3nR5GxrZjV6XZ
	 D2ZV0v3FG2A5Rf58BB1YWcndCrO5jgYq4lz3EQBJZHnv9FsuKiEyw2PQxBSV2mOLyfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=x/RKRDin2OptMojaeCsUiaSs9Kk46RnHWwkRmbHSsgw=;
	b=cIa+nJgbsUBSmcwIsu+QuEse9tNzHCKL06PUomVUNppBAArWMtQkGsn301LfvW35blzf
	 aJmzj+8j2Mkj4pOXNRWoS8SnNoicAYwUwJlFYuVX8DjAOfTYf8wZ22ZqHe4t/tU6lNKtg
	 t8stDmm5LCXqt4tFEUN3UbkjOVh/IhSYijKAydSk8wHT/O3ge+WvaHejlbEycXQEKBXlf
	 2lFPPTT4Wioh6k+eKNLRFGIQpAGIVV75+hKZgsG6xhg3cpPL/7lf4NQirtqI6v8lQYJqe
	 tRKS32nKvuUTUJAy6Ce4/LThNm+kZULXtzW8Q20+I6d7TwA0dvTpxZcj8+uh/yxW9Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L6n7bzpW;
	arc=none smtp.remote-ip=209.85.210.198
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D6606EEA7
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A16D6606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L6n7bzpW
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8862ed0539dso51254b3a.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922462; x=1794527262; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x/RKRDin2OptMojaeCsUiaSs9Kk46RnHWwkRmbHSsgw=;
        b=L6n7bzpWcfZVSFAQs0JDAT4gtSFfVu3c0zFD0jIUJdSPXjVqoe7FXPJwO6vXqiTkeo
         s7LNsuqr+YSzNvs7Njjsn7jiQx83hnNSe0e65ulqRXeXRfBynjwYZm3Oi2BxcCzWgtZo
         6cLiI+dKWwJJgYjXw7vcugiHKR0eUvKOkxojeXGu7LoS+waUQvnvHrE1B2LwoKCvbyty
         Hl8Jx1dfKSyV+awoRd04HOf3RmPzIa2Ak4Y8oMULO4IKFgvVHME97MdffKN5BaneI8Q6
         4MDW9Gupmz0q5AJDa+oEw6ro/YUqpsUTZsaRImErs2Mk+Kj7RMjQLXKrIms+8GxEMCJL
         woVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922462; x=1794527262;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/RKRDin2OptMojaeCsUiaSs9Kk46RnHWwkRmbHSsgw=;
        b=UPTuLgJoMj6xlxVFtrTR/x3ZdO0b1VVQ7e61bCd4WpJLOUxtQDGESMw47WaHBBdMgz
         cod69PUZrttdaJe/v5qP6ElZwGiAzXO3nOMbmudxhBhmgSjvf0ZQEJikRgJln4RXjWsK
         ok6+mwbVKECUQMH9BByaFtlChjO2GQ8XTjrOJA26onmGucWf7s2NpuiKUqu4Fp+FMaAe
         dR5iuNxs8iD1fkUDy5JNPpKfLxAJKzXtuYymsmwD767hVVZm5mfeQTwl+pSGf5q32TKN
         WzjBULYA6MJciYbnzugh4BZSgtIo1aNPivkU4RiRrf5HMNeBA9T1BaLWlgUxYu1iNEov
         UMbw==
X-Forwarded-Encrypted: i=1; AKwUvByzemUOAIk9B088dyReUKdKJ0i8piXMRlf+xQreTqcs3GJaBZmnoBVpLtvWu1QoYEq+aFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+QJk46L9XjB732f8MGJSbt/BlplRoCRUGyhEq1xNSIIAQmIBJ
	YLQ/wTQ/iOfCxGzXUKrEMarkC/VKjv865QusV4otdzvAmpZ7PapeEhKPCR0qmRZYkulrkRLKgFK
	o9P405g==
X-Received: from pgdo3-n1.prod.google.com ([2002:a05:6a02:6203:10b0:cca:c02e:bfd6])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9e95:b0:3e4:b458:5239
 with SMTP id adf61e73a8af0-3ebb2a24b3dmr1114411637.45.1793922461520; Thu, 05
 Nov 2026 15:47:41 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:53 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=5511;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=fyaOP4udR9+MT2Tk1b6aFON/Dhf2LGDor7nYKiUbRYs=; b=sCJHaKCV+jtAxAEHWQg4Va9n6Zt7Kf9a3pdCEp2bZPJyYse5oeR8d9GsFM6j1ZQHO7iLG20k1
 xXviMGo4M3PDZM5M7oVekKE118j994Hb8ukewnlO8WWY6HvLirV/sCk
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-9-2024e8fa517a@google.com>
Subject: [PATCH v16 09/20] KVM: selftests: Set up TDX boot code region
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
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 38 ++++++++++++++++++++++
 5 files changed, 49 insertions(+), 2 deletions(-)

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
index f76489ffb48d..43b4157e4a13 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -47,5 +47,6 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 })
 
 void tdx_init_vm(struct kvm_vm *vm);
+void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index b8dbb16d5a28..36003cfd8d6a 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -825,8 +825,10 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
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
index 564144c40f0a..b4a7089b3636 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -1,8 +1,46 @@
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
+	const size_t total_size = TD_BOOT_CODE_SIZE;
+	const size_t boot_code_size = td_boot_reset_vector_trampoline - td_boot;
+	const gpa_t boot_code_gpa = X86_RESET_VECTOR - boot_code_size;
+	gpa_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
+	size_t nr_pages = (SZ_4G - alloc_gpa) / PAGE_SIZE;
+	u64 gmem_flags = 0;
+	gpa_t gpa;
+	u8 *hva;
+
+	if (kvm_has_gmem_attributes)
+		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
+	vm_mem_add(vm, VM_MEM_SRC_SHMEM, alloc_gpa, TD_BOOT_CODE_SLOT,
+		   nr_pages, KVM_MEM_GUEST_MEMFD, -1, 0, gmem_flags);
+
+	gpa = ____vm_phy_pages_alloc(vm, nr_pages, alloc_gpa,
+				     TD_BOOT_CODE_SLOT, true, false);
+	TEST_ASSERT(gpa == alloc_gpa, "Failed vm_phy_pages_alloc");
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
2.56.0.455.g6c5a503b38-goog

