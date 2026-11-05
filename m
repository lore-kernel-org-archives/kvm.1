Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922477;
	b=qRl5e2K/pZaSD7flhwi2nqg5EhXfWxAbn0PwSnEZDYY8HvGz8SJ9wR1PjBbigJrZHsdt
	 3aSh5GJJaBb4Segc46GBiIfa+A6Wf9y4tBIZq7YSjEg07tuiVleFXFTgx7Iz+0CJFlQI4
	 WUQnLM7n8LnoCrB7vJH1rmKW8ctns4oXxYq5s/BGpTL0IDyuQrssjaDfsb5BhHOvugzw0
	 DjtqEJkEQKLtYA7/vnuD+FIkBcjt599PoXtZ4Cedt4bOM/BMaKJCDhvzL0BPVK988WBwq
	 FC5FzeFq5L8eOXtp9yiVauKztTKiwrr23Kzk3JEj2IAxr3F1urZpdRlh/C4KY/bmYXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LEEA2Tm4kPEuiFuwPm6vN9ZoPvkNTxKJCKru87/Ki1Y=;
	b=VMbTl7d1y1nuxqwlMAPIADVECCtaTH2zwSX5fy9mMOrNZvE/zPLJ7YVJlx6GG/gM775/
	 /Daq9gxftVSr+xrtbcdSs2GXagiX64rbnm/EDd3ccSeT1yK0AJIb+06cTH1JMcTssETdu
	 JgFKMwIWBEJr3fSBzdNvEXzulQfGaOBdDZtp9wXmKF4rzvruc6WmMnlMvYZ+2MYT1Wawk
	 tJsHKTopQkiOE45V6d9ArrlIcuCMYO1kl5JTK8EuD9PWFMChVlOyp0D81z2fvqpAvqtY7
	 C637aluNMYl8pMBdjw1VYNlkkuPYIcDR4Pn/q6zE8TCa3tn/nVlRPPE9vc5QNc3BUPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mkBDJPnB;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434376082BF9
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 23:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 434376082BF9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mkBDJPnB
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so119202a91.3
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793922477; x=1794527277; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LEEA2Tm4kPEuiFuwPm6vN9ZoPvkNTxKJCKru87/Ki1Y=;
        b=mkBDJPnBpOJI7ZDHZ/cokPtxysCsyUsPC+CEi3TMzsQdSEL3aY8+epwkW5mNfiSki1
         e3qpVaCtWJc0QwQelZ69DrbxtExBsz+i33uiLdGM8zHOjj7ce4LOTXTEhB4W8dD0OU8q
         Nj1sslqEzmpMWJ0W91ReP7ac2RPN8f8oikM8NJjSD/4ZAB0HpxX7dQ9/rrVSm2xIIJsm
         PkBhERn3pkBdd04ux5FfZ+t474l/kX6amyalyQenAKxTRK0zE03eALcjjcvVhEGh3VBX
         Zjhwyz1SSlAGmfw2FXrfhI+T0VhvTXwkHev7Ne6Zfa+ETw1IdLwX22mBAlkO0RFsDSHu
         Xupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793922477; x=1794527277;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LEEA2Tm4kPEuiFuwPm6vN9ZoPvkNTxKJCKru87/Ki1Y=;
        b=GVd/RvAzcrneEwbY+92Rjhz/dWWiy7fWoIAigqArL1hmd0dTs12z5PVL8B7tA1Hl5/
         EIDmCal6XHSlYsBaQESq35gl62I/FhXGEAJz+dplKaDOSrHLx9gMvCGRElGr6G/0bPD2
         oq8h4VAeE5O0g0T/9ZC27lbgf3TBFadfQ88QKTRoV990nnZsLddD/LEXp2otmZEi+62w
         dqXhBpizyD8Lnu25w8pUwYG42ek322FDLeBx/DqwyOZdCax5xk3UoEr4CjYzYC58lvjz
         IvA9I5+AudC9IAOAV6jf5p9hvSzTqZCci4iD2lVGyBkC302vOmv0cMUb6Lz3J4FzBKiG
         Gpyg==
X-Forwarded-Encrypted: i=1; AKwUvBwv39LoxZrimPh9OFbvyAVwvJrBUQQWXnAh69PoGpye33lL62hmwooMLctb7p4QEBGEELk=@vger.kernel.org
X-Gm-Message-State: APuU4Z96XJC2vubtEzmF/kJQEHep8yJ36G82zTaa4b+GzpiL8mbkYXY4
	BHnUdgjHDpijeVJtXZ/7nfpRtVeHIAoZaXlk91KlY2kn6JHNiAm3exDEConr6zPeH3EG2NlLzG+
	CZOK7mA==
X-Received: from pjbkl7.prod.google.com ([2002:a17:90b:4987:b0:3b0:98dd:7ee1])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a10:b0:3b0:a38a:6715
 with SMTP id 98e67ed59e1d1-3b0db7109dfmr651139a91.59.1793922476377; Thu, 05
 Nov 2026 15:47:56 -0800 (PST)
Date: Thu, 05 Nov 2026 23:46:59 +0000
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793922452; l=4183;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=1fvLyz4z13NOla+r1Hs/PHs9uu0rmBs1fjzBUkzz5ls=; b=URFC8RL1z2/ZNFCgOd5qDDtoX2nyoFhNLaevMBRotwPmJ5vC3rmXdQQwK9H2ZBcga0vYT5Ufu
 8WbXpQfFQ8iAhgNsNuFnDerSLmV+oaqLomuf/g5u2c9ub0IXp/b6CX+
X-Mailer: b4 0.14.3
Message-ID: <20261105-tdx-selftests-v16-15-2024e8fa517a@google.com>
Subject: [PATCH v16 15/20] KVM: selftests: Add helpers to init TDX memory and
 finalize VM
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
	linux-kernel@vger.kernel.org, x86@kernel.org, Lisa Wang <wyihan@google.com>, 
	Ira Weiny <iweiny@kernel.org>
Content-Type: text/plain; charset="utf-8"

From: Ackerley Tng <ackerleytng@google.com>

TDX protected memory needs to be measured and encrypted before it can be
used by the guest. Introduce tdx_load_private_memory() to traverse the
VM's memory regions and initialize all protected ranges by calling
KVM_TDX_INIT_MEM_REGION.

Once all initial private memory is initialized, the VM can be finalized
by calling tdx_vm_finalize(), which invokes KVM_TDX_FINALIZE_VM.

Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  3 ++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 61 ++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index 1cc876891589..67e717521409 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -74,4 +74,7 @@ void tdx_vm_load_common_boot_parameters(struct kvm_vm *vm);
 void tdx_vcpu_init(struct kvm_vcpu *vcpu);
 void tdx_vcpu_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code);
 
+void tdx_load_private_memory(struct kvm_vm *vm);
+void tdx_vm_finalize(struct kvm_vm *vm);
+
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index 324f3c41aa61..ea40bd51530d 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/align.h>
 #include <linux/sizes.h>
 
 #include "processor.h"
@@ -237,3 +238,63 @@ void tdx_init_vm(struct kvm_vm *vm)
 
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
+		    "Cannot add partial pages to the guest memory.");
+	TEST_ASSERT(IS_ALIGNED((u64)source_pages, PAGE_SIZE),
+		    "Source memory buffer is not page aligned");
+	tdx_vcpu_ioctl(vcpu, KVM_TDX_INIT_MEM_REGION, flags, &mem_region);
+}
+
+void tdx_load_private_memory(struct kvm_vm *vm)
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
+	tdx_vm_ioctl(vm, KVM_TDX_FINALIZE_VM, 0, NULL);
+}

-- 
2.56.0.455.g6c5a503b38-goog

