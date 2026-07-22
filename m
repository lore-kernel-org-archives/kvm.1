Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28E459AFB
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762069; cv=none; b=djNe6U1fF6hqSrenNw1IQKW+b7X693XEdDvfGYCkYx7dRUY1iBO9PrbZWfkE9Hz3rVvx1XBz7fcM7tkD/FlCgktt/Y7ijbAW1lObLCPX+sZ+/QVzhJ1tjj+9mIHfjX8i2S/7vMTtp0bhmKLDM2YGo5MpAVe7fcjtpr8OQBrSGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762069; c=relaxed/simple;
	bh=uMJpVpNeOdwMaxoQvFL9M1BthKdmt9TO/QVPx01YhrU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mEMEozg6tyHOmnEvcUPapDjaZkegRvOpOvG+fM1/OfueHgBe9NnMTxFwPBToyFvXGQo+8xw6MseMYgx3QLvsWiOmQvZ/kqCOvsjqpxGVId+a79WgVDKnF0pZVRfSxfVKzhVP/UNIerpRd+HJJBXg5aiWKI3+41QygZgoBYdulSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCq5WiWH; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCq5WiWH"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccafc5e82cso540265ad.3
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762066; x=1785366866; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZfCfgCc362FDxQaAsRRtIxEbjY1lDj4dpO1uwBrjGg=;
        b=SCq5WiWHsOoltgQDgaxa1fRSKLqzKoprHOL2hVS+1bkkYNZNpKXu3XkB5pl1slYwZ5
         lqXU7l24SZoZfofS3jRBMLY1/huDh+zVj6/00NMALXYpHklymdObzSQs5UV0MJhfQVX4
         3ELVtY4mTxLthG+S0yZkzyIiM6zWm4df+nGjtCOBwW8YB5qd7/IK8hDpuJ93GNf3ZnoL
         gYnWDLHRiHfc3IT3ltN363HAf9z2RYLYMy9weNBxzyD5hoyYXitu0EZCGrmcY3rxZpXf
         tgyMXDykpK9Z5mforwGavN2Fx1G9p4jbNpsdP7sAduMc3AuWIYfAWpcHSR2Xcpuql6sD
         8hkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762066; x=1785366866;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZfCfgCc362FDxQaAsRRtIxEbjY1lDj4dpO1uwBrjGg=;
        b=BYw5xZS2OG+GqHvu9MOnctfPXejpYJV9dDPzcvQB9zgEuBPHdGkHtpUz5V/KA1cwc+
         alNmlSB4rim15Rgb4NxvI4o16f6r0lmkJyxqOZRbYt8cLFrO6nTrFXOazeWq32YU4Izq
         0xz1zeSO5OzkBNNJxNkI+iwR8TYLJJtdxUDOFsPzx/odZ0tlZX7Ei2Cot0yrzM3khssK
         ldREYDrfkDu5KfDQ32RKKeoJ+ytlZnZglrKhRetTvJOQO9qYr0MfcJwwjg1kjVRCX+PW
         Y4Paf124vFfbrGiGgpIh+MgIAcXuVg4SwfD3M6kv7xmNguIjmniig61+3cifeBDRCQeg
         fY2Q==
X-Forwarded-Encrypted: i=1; AHgh+RrqBD9IlCC9EpnKUZOn6hAlJP1Lhf0RRHNNfN2RE8fdmv0tcBbokWJuSRN9w/7AeCcav0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDcVUxmwuELpmlNWtl8AKW9btKVeMuSORqxYw7VR3K9al+OBe
	F2IKa1yVtbUkI+jStMSDz7zk1YciBXiMQG4JzzNmkE5Xp5QtgmMJ9/tK3BOWR1lfrpbbWelB267
	qa3kWNg==
X-Received: from plcm9.prod.google.com ([2002:a17:902:f209:b0:2cf:7342:ecfb])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea05:b0:2c9:e9c7:2b59
 with SMTP id d9443c01a7336-2cfa6c7569cmr9933285ad.35.1784762065950; Wed, 22
 Jul 2026 16:14:25 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:15 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=4623;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=a5KKFZL0jXGvpSn59PVTTvyWAfVdsMJYuj2P3eOP+Iw=; b=VdXm08FD+Hm10IK7Q5OZXwNMUpOOjkshSUyqDMR+d/KSpGqd1+jni0/d7dOk78ipzaMlLxJiw
 0I1AF/Dt+V/Dg0QnyN/jHpUlnCREVUpaq6w4xZAzE19Ka/Ixq8U1Fo+
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-10-15ad654a50db@google.com>
Subject: [PATCH v14 10/22] KVM: selftests: Set up TDX boot code region
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

Add memory for TDX boot code in a separate memslot.

Use virt_map() to get identity map in this memory region to allow for
seamless transition from paging disabled to paging enabled code.

Copy the boot code into the memory region and set up the reset vector
at this point. While it's possible to separate the memory allocation and
boot code initialization into separate functions, having all the
calculations for memory size and offsets in one place simplifies the
code and avoids duplications.

Handcode the reset vector as suggested by Sean Christopherson.

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdx_util.h       |  1 +
 tools/testing/selftests/kvm/lib/x86/processor.c    |  4 +-
 tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c | 46 ++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
index eb8602dce0bc..642ffa010da3 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx_util.h
@@ -45,5 +45,6 @@ static inline bool is_tdx_vm(struct kvm_vm *vm)
 })
 
 void tdx_init_vm(struct kvm_vm *vm, u64 attributes);
+void tdx_vm_setup_boot_code_region(struct kvm_vm *vm);
 
 #endif /* SELFTESTS_TDX_TDX_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index ad75e19bb3a2..f93953777ca1 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -791,8 +791,10 @@ void kvm_arch_vm_post_create(struct kvm_vm *vm, unsigned int nr_vcpus)
 		vm_sev_ioctl(vm, KVM_SEV_INIT2, &init);
 	}
 
-	if (is_tdx_vm(vm))
+	if (is_tdx_vm(vm)) {
 		tdx_init_vm(vm, 0);
+		tdx_vm_setup_boot_code_region(vm);
+	}
 
 	r = __vm_ioctl(vm, KVM_GET_TSC_KHZ, NULL);
 	TEST_ASSERT(r > 0, "KVM_GET_TSC_KHZ did not provide a valid TSC frequency.");
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
index c01a26567b73..d64d153d19e2 100644
--- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
@@ -1,8 +1,54 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "processor.h"
+#include "tdx/td_boot.h"
 #include "tdx/tdx_util.h"
 
+/* Arbitrarily selected to avoid overlaps with anything else */
+#define TD_BOOT_CODE_SLOT	20
+
+#define X86_RESET_VECTOR	0xfffffff0ul
+#define X86_RESET_VECTOR_SIZE	16
+
+void tdx_vm_setup_boot_code_region(struct kvm_vm *vm)
+{
+	size_t total_code_size = TD_BOOT_CODE_SIZE + X86_RESET_VECTOR_SIZE;
+	gpa_t boot_code_gpa = X86_RESET_VECTOR - TD_BOOT_CODE_SIZE;
+	gpa_t alloc_gpa = round_down(boot_code_gpa, PAGE_SIZE);
+	size_t nr_pages = DIV_ROUND_UP(total_code_size, PAGE_SIZE);
+	const u64 gmem_flags = 0;
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
+	memcpy(hva, td_boot, TD_BOOT_CODE_SIZE);
+
+	hva += TD_BOOT_CODE_SIZE;
+	TEST_ASSERT(hva == addr_gpa2hva(vm, X86_RESET_VECTOR),
+		    "Expected RESET vector at hva 0x%lx, got %lx",
+		    (unsigned long)addr_gpa2hva(vm, X86_RESET_VECTOR), (unsigned long)hva);
+
+	/*
+	 * Handcode "JMP rel8" at the RESET vector to jump back to the TD boot
+	 * code, as there are only 16 bytes at the RESET vector before RIP will
+	 * wrap back to zero. Insert a trailing int3 so that the vCPU crashes in
+	 * case the JMP somehow falls through. Note! The target address is
+	 * relative to the end of the instruction!
+	 */
+	TEST_ASSERT(TD_BOOT_CODE_SIZE + 2 <= 128,
+		    "TD boot code not addressable by 'JMP rel8'");
+	hva[0] = 0xeb;
+	hva[1] = 256 - 2 - TD_BOOT_CODE_SIZE;
+	hva[2] = 0xcc;
+}
+
 static struct kvm_tdx_capabilities *tdx_read_capabilities(struct kvm_vm *vm)
 {
 	static struct kvm_tdx_capabilities *tdx_cap;

-- 
2.55.0.229.g6434b31f56-goog

