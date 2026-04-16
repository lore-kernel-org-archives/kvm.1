Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F439B49D
	for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776381053; cv=none; b=JwoTcd8WR+usxmRSVYtIQZFY0bzc9RdzAy7RJyRQ3fZ09fZIIpmYM3A6dEvkUqQFuHEAUpglLjuh1lksKV45KvPCMAp17KKF/4dsUJqeJOhBaNbFBnDTuFqp3GbNpGxHRn2nu4tCzXsj6O54PGYAvpmfvNO3M9O7orb3+B6a2JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776381053; c=relaxed/simple;
	bh=m4XaX8Jz+FsMeYdAGEkpWFL5GaceHm5GV84xoWA3Kf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X7AewS12AqIQjd9Bd8GgWbsrTGuSGFZDSrg05bW7PjvFsrpySBcsQBtkUpqVdphx06k88oMbCWJVkBFHgTcOCWnqegAAofnisa/jHlIWTCzlOCZEALU+07q7+zNKTfcsMbuE7l+7VX5XPT7NdHOkuYQpPYjdLGCGbyy4LZecT2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y7nQJHoC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7nQJHoC"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c794d89a715so34919a12.1
        for <kvm@vger.kernel.org>; Thu, 16 Apr 2026 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776381051; x=1776985851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TGFUBJqdj697HeMyWfcv7hzZssdk/CwlMwin6XkTx9U=;
        b=Y7nQJHoChayOxnaNGAPuqp931pFRKQWiA/vCTP6r5z6gv7z5JZi5Utz+Eky/y4eoT+
         brWUc5EwlcVhYcf+ghf3oHepqaLczglG5tsF6WvrBRbUYEZOK9sGhcmqjDMikkGhcJ+4
         cPipOIi7tKstO3ROqubbIzHz8k9sn0lsg2dtYN4JGD6Frj3Xk9K5HHJ0oR0/+ykvhmJU
         a0YIA5gQdUnBf5DdXLdS0Mtkcg93aiOcEle57kL6Pr5fuU7Zf1oBFg5p6CMs3jVnneRf
         Qr4JYCnKonMgS/m0fAlcGr2wWG5Cz1rUHeIPsBm7cEtsz5MH0z3J13Bje7DmDPN/YRp5
         B23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776381051; x=1776985851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGFUBJqdj697HeMyWfcv7hzZssdk/CwlMwin6XkTx9U=;
        b=XyBI7cHQm8pMccGMk1szUQ4UaJvrDts69eADyU3As/gu+HoShQcYM56zAHT+BITMxh
         U5yDoiWz0xsp3h2LcXsNoG5dzu1/ufz1vnvsn/t8CI8h9qmTPXW1exFSSS5HrVGrjX8k
         0moj7/XYsC89CQOQLljSjkXYZRVXs1zoyqKaiXczlXEcMLieqYpqT6Yfm1roI8MWhiXL
         OcHmk39oYKndzBqtmOSeBvgmNjcgloRYhl29o6+0ccvWIxaKag4LBsnzYG3Pki+0MPRa
         s1XcPT3Ug7NnU2kaqf/3dU63G/tlJ9ozufRV22pxL1IwGjMSTsLMWDnN9s71iFjliP4Y
         BCvQ==
X-Gm-Message-State: AOJu0YxGfhKCg1MO9NeHXWEbWrftD7tRi1q3EWw7k7oCKNsjdJPoMx0b
	DjIPWAN1nXghEplSBv0dB/PqBI9aa0Cu9XT2eBc8y2qITxYZOOhAIjwQVWKBW2znwCUqkum1tIq
	UnDLpNg==
X-Received: from pfbky41.prod.google.com ([2002:a05:6a00:6f69:b0:82f:6a88:310b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7287:b0:39c:2a9c:bbe2
 with SMTP id adf61e73a8af0-3a08d7545b4mr259210637.24.1776381051386; Thu, 16
 Apr 2026 16:10:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Apr 2026 16:10:39 -0700
In-Reply-To: <20260416231043.3402410-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416231043.3402410-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416231043.3402410-3-seanjc@google.com>
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
index 008b4169f5e2..669dbec927ac 100644
--- a/tools/testing/selftests/kvm/include/x86/sev.h
+++ b/tools/testing/selftests/kvm/include/x86/sev.h
@@ -144,4 +144,28 @@ static inline void snp_launch_update_data(struct kvm_vm *vm, vm_paddr_t gpa,
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
2.54.0.rc1.513.gad8abe7a5a-goog

