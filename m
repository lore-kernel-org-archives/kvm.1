Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D0471401
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762079; cv=none; b=qnnV+R98wInamgL9//7oowfyJYVaJHUB4y82Uv7ieHgJZG6JqXZiUJ8JO1td7WADGauNjDJRmbH2PG8IzXd4RT9qCvAjI+UYdbHAZd/wG6XM5din1tMCZXkSBDUsox0n9nzZhF1tue19BCa24rEkQpaU7INvpsSrC7EnFGSjk8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762079; c=relaxed/simple;
	bh=C2Lgd2bjrR01cgtK5z0m5n4bvOQy3kz4DS6yFHHKVvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+ewmdZksHBqSWnwPUKO2KcUzxVDiW1z7CuqS7uuz99JBXiAg7fgVTtX7FIFnLjmzW3QLutbYJTQo9W0pADEqcRDbP9TlTngbbyw4LGlBNi+ONjqTpFAW+8RdLxvW96WvBMl/+Z1TXQi6gFffaZK8GCREL5KJ2xNlnTvM4eSZ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6eaXI9c; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6eaXI9c"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc640dfde3so501315ad.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762076; x=1785366876; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XNZd91+mo5o4oegz4xZP/Z+TCzb0UFRc92DILYArhCE=;
        b=i6eaXI9cG9QBdXTShzD+5IRyGibsYRay9DxRoNL2cIeR0C8mEXKVXjuoJER7ENtvMD
         9c8fHz1ApCP/SOkjEI7Nzv+3h2xMnMTl5X/YLIQqD4KOenSkur/TxjwWc60UOb+Dh/A1
         Nby0mkToscZkb5LhGlq4jSUr5DgOcbZIb7Bxh+Fem5RPtAOYPqT3Q+cnIFFgB3LWErpa
         AID2L0DFuxaFHd5hfuqfFc8jMFWRiTvUzLebT9Q+K553ncLNl6XAAN6xP5/SHXqXFCZI
         vBAdaMPF/u1PSt3H04m8lFEpTmL6EUYkO+QtqzcXEDlqe40QutGbmKu9AZB7gL2GAA5E
         rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762076; x=1785366876;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XNZd91+mo5o4oegz4xZP/Z+TCzb0UFRc92DILYArhCE=;
        b=LkJxgIXzAGkOvfRO2byW/zzXhpvrS036n52MNeY8kbsXINen6Y6TH2hEHNzUr8YVNj
         vfC5UNdlwvpZsTbzO6HTZef8cBCrd4Aickbo9/h9oMCWC01EFhfB0VJH7+mE3n4LqEzX
         OY1IDIE7hDaF3k3GXl1qGYFMQbNmHoGbBRWM0M699MRAHizGgAP1LiQEPMxn7RqcT86c
         qJcxOSlK4ZxSiqo1N0bNTXzs1TrbrUrEDUnQabuKizhej7HPGR67jWAdg3Iakyu3niSX
         sr1Z+Ne0OyweAmsJJGK2dj9CF/WQwbaWAjSzNSXEbJl7WV1b4HT6N3YbhYl1o0BxeVW+
         izSg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5twML5W+PSQVrjGMiufA0SFqi97luGBqDKuUFm1KwE2RAzRewjfQ+AXsh/1Ixu53qgZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC1IcS0AqkLrQCmE9pAnakWNmU7o/4rCz0KAXdTtEAmDzhIMly
	KN++uR6tSFO7h/+nHcfzjBpN7KE/lrP9uDU6xTbtgiZ1ZPoy9tN5cXyF3v6PNr/1NEQZmuIIjqC
	sHpNwEg==
X-Received: from plbmp15.prod.google.com ([2002:a17:902:fd0f:b0:2cf:2c71:64bd])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2c08:b0:2c1:ea95:8297
 with SMTP id d9443c01a7336-2cfa6a560cemr9965915ad.7.1784762075897; Wed, 22
 Jul 2026 16:14:35 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:23 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=4116;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=mszFJBolFZ3EeT/w/UfjhdbhJ7NRQ2ZbBHD1RZXRdfA=; b=RWRWEHuu6HLzQSUjkNtKQAU3uFQqOM5gWQjxuE3PUW8aH1xfIjbJfzO6A3P/zXGcuHCDOw3wK
 V4s8uFtQ2A6AkDAyW9OflMI1SPi9f59poJqSKHTDHQ/8Tp7deaDKOef
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-18-15ad654a50db@google.com>
Subject: [PATCH v14 18/22] KVM: selftests: Add helpers to init TDX memory and
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
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Oliver Upton <oupton@kernel.org>
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
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  2 +
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 63 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 307e2c0bc9c9..35f0b2b7ac40 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -72,4 +72,6 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 void tdx_vcpu_load_boot_parameters(struct kvm_vm *vm, struct kvm_vcpu *vcpu);
 void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
+void tdx_vm_finalize(struct kvm_vm *vm);
+
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index be63d8652a02..831b0e5160df 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/align.h>
+
 #include "processor.h"
 #include "tdx/td_boot.h"
 #include "tdx/tdx_util.h"
@@ -251,3 +253,64 @@ void tdx_init_vm(struct kvm_vm *vm, u64 attributes)
 
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
+		void *source_pages = NULL;
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
+			if (!kvm_has_gmem_attributes)
+				source_pages = (void *)hva;
+
+			vm_mem_set_private(vm, gpa, size_to_load);
+			tdx_init_mem_region(vm, source_pages, gpa, size_to_load);
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
2.55.0.229.g6434b31f56-goog

