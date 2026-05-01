Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8300423151
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667750; cv=none; b=nlTUpgffvahExoo8rapL/q4euieR7T33oaE99EQRAeXaRLZ5/LWFZZjM+7oXT7iAgiipZEbCa4oSxENxLdQZla+rrT/jZNxUYHVlC6MO5iFZerWpHNlA1hx7Ky4wWJRYa0bVovJAGnVKAIzvGJK+f0j2n5pDzoYgOs/ju8NiNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667750; c=relaxed/simple;
	bh=T8keK2iQ6iTkPs8KyUsMfRfqAPB/cM9X954693/oHy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GzPVNQfg9maUPvEOzZkdrl0wEg9hgVJibIdQnsGTMuaZVbpNuPq66WcOA7DNSVeS74ZvW30f6Al6EsL+Rw9xDX9rBCdtOloUbNbcI1sx8AU8A45IXoWXXn8wyZZqrhdjIWzL8Onx+w3op4eV9CaECpJAi0M8VPFYPX7xzNdfkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tuRSEtTW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tuRSEtTW"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-364edd430e6so1604103a91.2
        for <kvm@vger.kernel.org>; Fri, 01 May 2026 13:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777667745; x=1778272545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Fixb+34puzyJhKjzcaNI0NuMW7dHJYkjk7ReqMjzN1Y=;
        b=tuRSEtTWeqaYMl3t498MMCdf4CJNiHtYWm8E1Rbco20T98FcRPal46mC6mpr6DXztJ
         hPpWWBE6EEeoKWRqOhPHXiSktcUiJV1ldn3zf0ZrelvNVSYvfHqBAoohi88W7n/okGZ6
         SbCFlE5vnJx9bKsYq89cXRRVjSeDJJPD/+mD9MHgRNsn9yxB1ku3NC/4KgWGXs2ypCzr
         TH/RDrX0aS1svGwbYqn+K+TqR4ce+duXGv632PkF8pLzkxAVBb+1dxagcIXez9cGX3Vx
         GAofFqWngeUGZnbc8v4j+dQY7fUe9WwnQWgE7uoa7zl/7uRUep1yZQ1HL7Th6mpfeTDv
         //mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667745; x=1778272545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fixb+34puzyJhKjzcaNI0NuMW7dHJYkjk7ReqMjzN1Y=;
        b=tZI/WIz0Gzt4yiCFdyxYQlPWNNVttjwoqsuaXVDGumt85UozrJM3vUCsL5KRky9ci2
         Kw8/1gUPXW/qs6w1lcwMz791JEJ6ulv0AbKNpu79xj8RzhctNf1R6oHVTjj5jUn3BjGH
         gCxXI6iRbYU7Mzj2z5cZt9jjx9PYF1GFEXV5a7dhXaLI10t8MT6jZADCfwknegO6ZaKV
         z12CyuGzYZ+hvhp5kNrG1zkVw5EOqvjjtT9oKnlUfIsMeSRJ/f8tWj2w7aU3yToXebGM
         O+6cvXjQkG8c+/ejMNmsYvLI77SLC2Ayt/ca7GrjLHlaBR39LDIyPvieCXY5NyvXxXbL
         8tYA==
X-Gm-Message-State: AOJu0YzK+kMocZMatorctr3z9otNxT6A8h8BUSdp3eh29ayQeKU8fmyh
	HyV/djAG4fcliLJBZTAo0bi3ARTGP1ckYbmv53Jg8kToh1Ap5CXYGLYNPgGnSeYF4TE0KTeVi9A
	Ehsp07Q==
X-Received: from pjbbt14.prod.google.com ([2002:a17:90a:f00e:b0:35c:20f3:4ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510b:b0:35f:b46e:e329
 with SMTP id 98e67ed59e1d1-3650cd08149mr770187a91.6.1777667744898; Fri, 01
 May 2026 13:35:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 May 2026 13:35:33 -0700
In-Reply-To: <20260501203537.2120074-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501203537.2120074-3-seanjc@google.com>
Subject: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV {en,de}crypt
 debug ioctls
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest to verify KVM's handling of {de,en}crypt debug ioctls,
specifically focusing on edge cases around the chunk (16 bytes) and page
(4096) sizes, where KVM had multiple bugs.  E.g. KVM would fail to handle
small sizes that aren't naturally aligned and sized, would buffer overflow
if the destination was unaligned but the source was not, etc.

Attempt to strike a balance between an exhaustive test and a reasonable
runtime.  On a system with both SEV and SEV-ES support, the current runtime
is under 45 seconds.  Which isn't great, but it's tolerable, and it's not
obvious which of the combinations are "better" than the others.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/sev.h |  24 ++++
 .../testing/selftests/kvm/x86/sev_dbg_test.c  | 118 ++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/sev_dbg_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..82fa943b9503 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
+TEST_GEN_PROGS_x86 += x86/sev_dbg_test
 TEST_GEN_PROGS_x86 += x86/sev_init2_tests
 TEST_GEN_PROGS_x86 += x86/sev_migrate_tests
 TEST_GEN_PROGS_x86 += x86/sev_smoke_test
diff --git a/tools/testing/selftests/kvm/include/x86/sev.h b/tools/testing/selftests/kvm/include/x86/sev.h
index 1af44c151d60..dec383e59a47 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -144,4 +144,28 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, gpa_t gpa,
 	vm_sev_ioctl(vm, KVM_SEV_SNP_LAUNCH_UPDATE, &update_data);
 }
 
+static inline void sev_dbg_crypt_memory(struct kvm_vm *vm, unsigned int cmd,
+					void *dst, void *src, unsigned int len)
+{
+	struct kvm_sev_dbg dbg = {
+		.src_uaddr = (unsigned long)src,
+		.dst_uaddr = (unsigned long)dst,
+		.len = len,
+	};
+
+	vm_sev_ioctl(vm, cmd, &dbg);
+}
+
+static inline void sev_decrypt_memory(struct kvm_vm *vm, void *dst, void *src,
+				      unsigned int len)
+{
+	sev_dbg_crypt_memory(vm, KVM_SEV_DBG_DECRYPT, dst, src, len);
+}
+
+static inline void sev_encrypt_memory(struct kvm_vm *vm, void *dst, void *src,
+				      unsigned int len)
+{
+	sev_dbg_crypt_memory(vm, KVM_SEV_DBG_ENCRYPT, dst, src, len);
+}
+
 #endif /* SELFTEST_KVM_SEV_H */
diff --git a/tools/testing/selftests/kvm/x86/sev_dbg_test.c b/tools/testing/selftests/kvm/x86/sev_dbg_test.c
new file mode 100644
index 000000000000..55530cc2be05
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/sev_dbg_test.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <fcntl.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "sev.h"
+
+#define BUFFER_SIZE	(PAGE_SIZE * 2)
+
+static u8 *data;
+static u8 src[BUFFER_SIZE] __aligned(PAGE_SIZE);
+static u8 dst[BUFFER_SIZE] __aligned(PAGE_SIZE);
+
+static void validate_dst(int i, int nr_bytes, u8 pattern)
+{
+	for ( ; i < nr_bytes; i++)
+		TEST_ASSERT(dst[i] == pattern,
+			    "Expected 0x%x at byte %u, got 0x%x",
+			    pattern, i, dst[i]);
+}
+
+static void validate_buffers(void)
+{
+	int i;
+
+	for (i = 0; i < BUFFER_SIZE; i++)
+		TEST_ASSERT(src[i] == dst[i],
+			    "Expected src[%u] (0x%x) == dst[%u] (0x%x)",
+			    i, src[i], i, dst[i]);
+}
+
+static void ____test_sev_dbg(struct kvm_vm *vm, int i, int j, int nr_bytes)
+{
+	u8 pattern = guest_random_u32(&guest_rng);
+
+	if (i + nr_bytes > BUFFER_SIZE || j + nr_bytes > BUFFER_SIZE)
+		return;
+
+	memset(&src[i], pattern, nr_bytes);
+	sev_encrypt_memory(vm, &data[j], &src[i], nr_bytes);
+	sev_decrypt_memory(vm, &dst[i], &data[j], nr_bytes);
+	validate_buffers();
+	validate_dst(i, nr_bytes, pattern);
+}
+
+static void __test_sev_dbg(struct kvm_vm *vm, int nr_bytes)
+{
+	/*
+	 * In a perfect world, all sizes at all combinations within the buffers
+	 * would be tested.  In reality, even this much testing is quite slow.
+	 * Target sizes and offsets around the chunk (16 bytes) and page (4096
+	 * bytes) sizes.
+	 */
+	int x[] = { 1, 8, 15, 16, 23 };
+	int p = PAGE_SIZE - 24;
+	int i, j;
+
+	____test_sev_dbg(vm, 0, 0, nr_bytes);
+
+	for (i = 0; i < ARRAY_SIZE(x); i++) {
+		for (j = 0; j < ARRAY_SIZE(x); j++) {
+			____test_sev_dbg(vm, x[i], x[j], nr_bytes);
+			____test_sev_dbg(vm, x[i], p + x[j], nr_bytes);
+			____test_sev_dbg(vm, p + x[i], x[j], nr_bytes);
+			____test_sev_dbg(vm, p + x[i], p + x[j], nr_bytes);
+		}
+	}
+}
+
+static void test_sev_dbg(uint32_t type, uint64_t policy)
+{
+	int sizes[] = { 1, 8, 15, 16, 17, 32, 33 };
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int i;
+
+	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(type)))
+		return;
+
+	vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
+
+	data = addr_gva2hva(vm, vm_vaddr_alloc(vm, BUFFER_SIZE, KVM_UTIL_MIN_VADDR));
+	memset(data, 0xaa, BUFFER_SIZE);
+
+	vm_sev_launch(vm, policy, NULL);
+
+	sev_decrypt_memory(vm, dst, data, BUFFER_SIZE);
+	validate_dst(0, BUFFER_SIZE, 0xaa);
+
+	memset(src, 0x55, BUFFER_SIZE);
+	sev_encrypt_memory(vm, data, src, BUFFER_SIZE);
+	sev_decrypt_memory(vm, dst, data, BUFFER_SIZE);
+	validate_dst(0, BUFFER_SIZE, 0x55);
+
+	__test_sev_dbg(vm, PAGE_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		__test_sev_dbg(vm, sizes[i]);
+		__test_sev_dbg(vm, PAGE_SIZE - sizes[i]);
+		__test_sev_dbg(vm, PAGE_SIZE + sizes[i]);
+		__test_sev_dbg(vm, BUFFER_SIZE - sizes[i]);
+	}
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));
+
+	/* Note, KVM doesn't support {de,en}crypt commands for SNP. */
+	test_sev_dbg(KVM_X86_SEV_VM, 0);
+	test_sev_dbg(KVM_X86_SEV_ES_VM, SEV_POLICY_ES);
+	return 0;
+}
-- 
2.54.0.545.g6539524ca2-goog

