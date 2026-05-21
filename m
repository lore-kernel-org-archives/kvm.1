Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD8382295
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405462; cv=none; b=srcn4JRGyhiWz3nAEJ3ThVIsyddtH/BlUyyQz4lIB/x35IrGXcwJs0vBPrJaXEyuCssTXDIMHj1Pj6GbcxVv96eFR2l+TiqsckH9yPrAvsRXJRiYfd4I+TlGhTpLQ/e8W5XgvSLqyIngwTIIh5aSNSYWtFRQSoXGm8dPmF75Vuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405462; c=relaxed/simple;
	bh=eCQGEilrFzCSke04dBVK+Ehw7MktZ+9FE7KQ/w4+U38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jo6gPtmlwWWZIUbrVwvLLAo6w+GJ0RDYI4zWCFzu2ar3i+ZX1yp0i3STmSw/HslYZ+WeJUgriHQarnmhpOAcrp50eJQCSU91mXwYn9/fXgTSRPbEB09Bk+h4GjXa1a3YC7vONx+I2sE7KHsTZ+u9OA82HTWePDccj0PnPZ+p1us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=esQr/2oJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="esQr/2oJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8292a9605aso3226712a12.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405459; x=1780010259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ppKjO62UQfdArPgp2kAo56nPWxnTEV/KCrnv6x28ZIU=;
        b=esQr/2oJ+YBUQy+AWIs622u0Pb88TKrRGPVAjmSN03q7AGIMgVl0dpTXwx076LFFVS
         Ar7HlvaxHkAIu9ygHypG8AI6cguZC5lxPKJpIXIhPgVEKy+x3hZa6xobVeOAA+9Q4F3l
         SgKp5arDJfOsU4Ef8j1y5Lpz3rf4Rs4D/EKDOWK24/yECOTX4rphnESrdzrt+YZfzMoj
         t1eKwIiRBif9jKCHZQq1CyOCIBu3PTfEBpzid71fY2Dph2ARyo6u55pr7w9ATJ0KiG3L
         wkiI8drr9Wtl+T5We5MNNAYYnmUsWifeXljNyB6U45w8mjVDI5i8PZE39U2AKrxRaXf1
         v1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405459; x=1780010259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppKjO62UQfdArPgp2kAo56nPWxnTEV/KCrnv6x28ZIU=;
        b=csfABZQJB41e4yHb3C9a+UIv+wIhXY1JktXJraZjSNQUQvLVSY5b32XsZJ+xWWrkf6
         vEHYik/frvf79Nw4QurYGpOeyYRfJd8UWLJkO+Vrlc90IJ2cDzwFvnaIETlwpZNshIKu
         j2za/wBrjZlYLtzrkVOcmOWxjdlzrKyEJhBJDBeW1x3kc74vMwRbbYNDKqUNpstaTmGq
         CAT0rNQjsYkyCjJGLGI5lAIhuoMjCa7ewnZUjYtCv2lHh/yYGLiffCC0GRtFoamXWI7L
         zvSALBBjC+nIh1B1OUme/XRkqd2rXMUzlbLq1GEHvVwOF1Xe/gGNuq0IjvJVf9sGHwYL
         ZXhg==
X-Forwarded-Encrypted: i=1; AFNElJ9QPaOkgs6ET/UyThBLpo0pnso257sx/kz3X2yd69FN0nxt5giujG1mu517dp3+VKdwDbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFR2Uhrqe4K/CAicSkshxVH3hbnkcVzbFOL4vHYXSUbpU+za/
	JfUMbOaPuyYXsmDkujYKkdyTSO4sTKb5I1EYAvN0K3Ug8zZ66lZkzLRqCBaua6Px9uzCZ9sH5pG
	0flQqJg==
X-Received: from pfbid5.prod.google.com ([2002:a05:6a00:8a85:b0:82f:7163:35c4])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa09:b0:82f:3828:a01d
 with SMTP id d2e1a72fcca58-8415f32e98dmr1146332b3a.29.1779405458780; Thu, 21
 May 2026 16:17:38 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:59 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=3960;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=DeOFHqEu6JwczUh+KlQMiTP7jszkBUMlOFVl56kapW0=; b=BaP70pJ0S+7VDjL6qRypKTMiI8DdNL0JFqXhlohgbR54il7ooFUZ1U0iS9vbludbI99TR2X+o
 vLvljCK28XHBC76b3d/J5CAI/2QR/2ABg1oQ/b9nrLlu9rmEgsWohUL
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-18-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 18/22] KVM: selftests: Add helpers to init TDX memory and
 finalize VM
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

From: Ackerley Tng <ackerleytng@google.com>

TDX protected memory needs to be measured and encrypted before it can be
used by the guest. Traverse the VM's memory regions and initialize all
the protected ranges by calling KVM_TDX_INIT_MEM_REGION.

Once all the memory is initialized, the VM can be finalized by calling
KVM_TDX_FINALIZE_VM.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 59 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index efa4c7f7b1c1..8276622c50d2 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -70,4 +70,6 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
+void tdx_vm_finalize(struct kvm_vm *vm);
+
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 158cba1b95e3..584e6600b588 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/align.h>
+
 #include "kvm_util.h"
 #include "processor.h"
 #include "tdx/td_boot.h"
@@ -273,3 +275,60 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
 
 	free(init_vm);
 }
+
+static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
+				u64 gpa, u64 size)
+{
+	u32 flags = KVM_TDX_MEASURE_MEMORY_REGION;
+	struct kvm_tdx_init_mem_region mem_region = {
+		.source_addr = (u64)source_pages,
+		.gpa = gpa,
+		.nr_pages = size / PAGE_SIZE,
+	};
+	struct kvm_vcpu *vcpu;
+
+	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
+
+	TEST_ASSERT(size && IS_ALIGNED(size, PAGE_SIZE),
+		"Cannot add partial pages to the guest memory.\n");
+	TEST_ASSERT(IS_ALIGNED((u64)source_pages, PAGE_SIZE),
+		"Source memory buffer is not page aligned\n");
+	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, flags, &mem_region);
+}
+
+static void tdx_load_private_memory(struct kvm_vm *vm)
+{
+	struct userspace_mem_region *region;
+	int ctr;
+
+	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node) {
+		const struct sparsebit *protected_pages = region->protected_phy_pages;
+		const gpa_t gpa_base = region->region.guest_phys_addr;
+		const u64 hva_base = region->region.userspace_addr;
+		const sparsebit_idx_t lowest_page_in_region = gpa_base >> vm->page_shift;
+		sparsebit_idx_t i, j;
+
+		if (!sparsebit_any_set(protected_pages))
+			continue;
+
+		TEST_ASSERT(region->region.guest_memfd != -1,
+			    "TD private memory must be backed by guest_memfd");
+
+		sparsebit_for_each_set_range(protected_pages, i, j) {
+			const u64 size_to_load = (j - i + 1) * vm->page_size;
+			const u64 offset =
+				(i - lowest_page_in_region) * vm->page_size;
+			const u64 hva = hva_base + offset;
+			const u64 gpa = gpa_base + offset;
+
+			vm_mem_set_private(vm, gpa, size_to_load);
+			tdx_init_mem_region(vm, (void *)hva, gpa, size_to_load);
+		}
+	}
+}
+
+void tdx_vm_finalize(struct kvm_vm *vm)
+{
+	tdx_load_private_memory(vm);
+	tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
+}

-- 
2.54.0.746.g67dd491aae-goog

