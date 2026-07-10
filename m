Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE22D5923
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783659893; cv=none; b=bVYynozvTr7Bm1gMO3OFUI8y9NeKP8jRWwYLNTZOPpFNJpHNthDfw1ROnpET5dhjpyyoIV8D3OxQPUDTOTyFysSnBiKNMXKr6A6hGzltByQeDDS+jWBLJXii1l7JNn2jsW3H/Qgna8ACteRbXZJBgvjEs3d5FrRjR/43UCcr2a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783659893; c=relaxed/simple;
	bh=Ee5h3a+W5f3ibqlTXgZPTSxEQElEMmrTZwF3obM2BgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yn49fTq4ENstJm1fwjObv8GW7JvbL5TYBRlxyQRKgNbAkYEfRIEV4Ru44KdmCKIQGzn3ZSozNamzXoesWx1eTeoyFOuZGeMaVYzVFH+QbXvk6wjCy74/sOV0uiSJPOvwD4LjOiTsSbiTUGNTz3dHb2dpRsmiNl8SD7Uz2iP/VdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJqn48Js; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJqn48Js"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so344175a12.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 22:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783659891; x=1784264691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCR7U2oQcx1FdDakp70I1j/IWLZLY09DaAlfyQH/X+M=;
        b=CJqn48JsRCNBqNN5Gs1F8b48yPcAW5kE6sY9woLAaSq9VTvbaQJLYLpp+h9aZQQEoP
         4jwjIUFqUREM9/F/KvREIpVi6FS72U4AOpuM+xmHmhxD6WEu3TwFCbWUlaRUSHll0BLu
         eWZl1hJs5jXC6sf5CLGQs+gaXfStiB0AZ/JOJbUTWZZIOW0SeeNz6y+lOKJJBkTjapl/
         BTHg+PuHUTyEHuaywavWAXjAqk3Pdv35ejQ/SSfOCc7lsfIfXREul73CIPcxYv1c50gS
         uEVKTWClxqWqHYzeKoq50BUeBoZpZHqfrA0arbbk8vqPxu9ik4FDRVyrW8elNTCNUClG
         aPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783659891; x=1784264691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCR7U2oQcx1FdDakp70I1j/IWLZLY09DaAlfyQH/X+M=;
        b=d++eclFGrsm0qBofTGMmxOb66D04F0MFh9v9W1RwfCyPQuKp2tOiKCVGW6IsNc5pIS
         E21Qpu2Rn/YdKVlda7OVa1BnroWKEe5vyTW2v0C7KMz93LUG7xCQfFz1mwA/QRilOcus
         TgvDAP8sk8N5Yp5CIIhHCzjG9wsMgOzm1j1iSSVVhx3hqf4J9PkaMatvlc2c37sJ1WN7
         C++G/jrHvIMxHU41o80ujyqJIubP7o+jj7UKZnRFXLiMHGtY3l7YDxFvUf1+n4081Pah
         885FJnSOMSIAo8QTUWIUz7cjUeiK2AkZ7mS9MgJeqMy1y+B5FbCgkpaHckYEmzf7ruGo
         pKyg==
X-Gm-Message-State: AOJu0YyL/rmrg7bDOqxK5c5RHGwv+sWRbad/Z4kwBVv3xvbdFWL2rxVC
	KrF07ENrlJlnzMxc5Xyn7AJw6guGsrgSkAzZqMmyhCvU05W0/DvNQ7fC
X-Gm-Gg: AfdE7ckJYKWYkGTN7NCi11IWjxRix1ScoE+gPLUSwhs6XejPEmGfnEDdzrlgqGD623A
	gn8vNypkpFhWrusnT50Enl2+WkrHRDJqkfe6qtxpBj5/By7cKRV0VJ3y9Anvenn3VwMpUyIgdf8
	vbkhVwgaI4l87Y+PHK6+NCU/5Yty6XWnpR+UEbO6kN42eo9NCkiWSJDcJSaF+xVHiF9/JFVErOK
	Uy2tZTbTcTxj0vbvpKaPx9YzwYJNRoMajmFWrErNqfujcB/a5o4s5t/fXAluBHOre9MJ0zaeoDa
	nJXnRt0FYG49UwacE0UGs9H6+dcO57BfsQqGYGvuo+ezyC97Z+smvC+iFriOUqTStYZ2CrOfiqs
	qB/BenzrxoFEnU/094nVAslm14j4c93T8n7ZW5k4DKEyevQ/a94C86VbSk/P9qfHXeXTiHg002I
	Vxf/KqGxoawmFdFeY+WIKKo3E7F8T0q7vnzOQVNJMkdauN6Q==
X-Received: by 2002:a05:6a20:3d24:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3c0f0af5f2dmr2635397637.22.1783659890936;
        Thu, 09 Jul 2026 22:04:50 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm38731347c88.11.2026.07.09.22.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:04:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	shuah@kernel.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH v3] KVM: selftests: Add a test for KVM_CREATE_VM VM type enforcement
Date: Fri, 10 Jul 2026 10:34:42 +0530
Message-ID: <20260710050442.826777-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709174955.628913-1-hemanth.selam@gmail.com>
References: <20260709174955.628913-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM_CAP_VM_TYPES advertises the bitmap of VM types that KVM_CREATE_VM
accepts, but nothing verified that the ioctl actually enforces it: that
every advertised type can be created and every non-advertised type is
rejected. sev_init2_tests carried a TODO for this ("check that
unsupported types cannot be created. Probably a separate selftest"),
but the check is not specific to SEV or KVM_SEV_INIT2, and not even to
x86.

Add a standalone test that walks the type space and, for each value,
asserts that KVM_CREATE_VM succeeds iff the corresponding bit is set in
KVM_CAP_VM_TYPES, and otherwise fails with -EINVAL. The walk extends
past bit 31 so that out-of-range type values, which can never be
advertised in the u32 bitmap, are also confirmed to be rejected. The
test only depends on KVM_CAP_VM_TYPES, so it lives in the common set and
is skipped on architectures that don't advertise the capability.

Drop the now-addressed TODO from sev_init2_tests.c.

Tested on an AMD SEV-SNP capable host. With KVM_CAP_VM_TYPES=0x15
(DEFAULT/SEV/SNP), only the advertised types are created and everything
else is rejected:

  $ strace -e trace=ioctl ./vm_types_test 2>&1 | grep KVM_CREATE_VM
  ioctl(3, KVM_CREATE_VM, 0)    = 4              # DEFAULT
  ioctl(3, KVM_CREATE_VM, 0x1)  = -1 EINVAL      # SW_PROTECTED
  ioctl(3, KVM_CREATE_VM, 0x2)  = 4              # SEV
  ioctl(3, KVM_CREATE_VM, 0x3)  = -1 EINVAL      # SEV-ES
  ioctl(3, KVM_CREATE_VM, 0x4)  = 4              # SNP
  ioctl(3, KVM_CREATE_VM, 0x5)  = -1 EINVAL      # TDX
  ... 0x6..0x3f all -1 EINVAL ...

Reloading kvm_amd with sev_snp=0 drops the bitmap to 0x5 and only types
0 and 2 are then created, confirming the test tracks the advertised set
rather than hard-coded types.

Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
Changes in v3:
 - Reworked into a separate, generic test that checks all VM types
   against KVM_CAP_VM_TYPES (per review), instead of adding negative
   checks to sev_init2_tests; also cover out-of-range types. Dropped the
   manual fd cleanup and the redundant errno in the assert message, and
   removed the addressed TODO from sev_init2_tests.c.
 - Dropped the separate "SEV: Sanity check the launch measurement" patch
   that accompanied v1/v2; this revision is a single patch.

v2: https://lore.kernel.org/all/20260709174955.628913-1-hemanth.selam@gmail.com/
v1: https://lore.kernel.org/all/20260709164751.621326-1-hemanth.selam@gmail.com/

 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 tools/testing/selftests/kvm/vm_types_test.c   | 50 +++++++++++++++++++
 .../selftests/kvm/x86/sev_init2_tests.c       |  4 --
 3 files changed, 51 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/vm_types_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d28a057fa6c2..ad74d0b98694 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -66,6 +66,7 @@ TEST_GEN_PROGS_COMMON += kvm_page_table_test
 TEST_GEN_PROGS_COMMON += set_memory_region_test
 TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
 TEST_GEN_PROGS_COMMON += memslot_perf_test
+TEST_GEN_PROGS_COMMON += vm_types_test
 
 # Compiled test targets
 TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
diff --git a/tools/testing/selftests/kvm/vm_types_test.c b/tools/testing/selftests/kvm/vm_types_test.c
new file mode 100644
index 000000000000..e8ef3b018f6c
--- /dev/null
+++ b/tools/testing/selftests/kvm/vm_types_test.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Verify that KVM_CREATE_VM accepts exactly the VM types enumerated by
+ * KVM_CAP_VM_TYPES, and rejects every other type with -EINVAL.
+ */
+#include <errno.h>
+#include <stdbool.h>
+#include <unistd.h>
+
+#include <linux/kvm.h>
+
+#include "kvm_util.h"
+#include "test_util.h"
+
+int main(void)
+{
+	unsigned int supported_types;
+	unsigned long type;
+	int kvm_fd, fd;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_VM_TYPES));
+
+	kvm_fd = open_kvm_dev_path_or_exit();
+	supported_types = kvm_check_cap(KVM_CAP_VM_TYPES);
+	pr_info("KVM_CAP_VM_TYPES: 0x%x\n", supported_types);
+
+	/*
+	 * KVM_CAP_VM_TYPES is a u32 bitmap, so only types 0..31 can ever be
+	 * advertised.  Walk past that range as well to confirm that any
+	 * out-of-range type is rejected rather than silently accepted.
+	 */
+	for (type = 0; type < 64; type++) {
+		bool supported = type < 32 && (supported_types & (1U << type));
+
+		fd = __kvm_ioctl(kvm_fd, KVM_CREATE_VM, (void *)type);
+
+		if (supported) {
+			TEST_ASSERT(fd >= 0,
+				    "KVM_CREATE_VM(%lu) should succeed, KVM_CAP_VM_TYPES=0x%x",
+				    type, supported_types);
+			close(fd);
+		} else {
+			TEST_ASSERT(fd < 0 && errno == EINVAL,
+				    "KVM_CREATE_VM(%lu) should fail with EINVAL, KVM_CAP_VM_TYPES=0x%x",
+				    type, supported_types);
+		}
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/x86/sev_init2_tests.c b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
index 8db88c355f16..d4227dc922ab 100644
--- a/tools/testing/selftests/kvm/x86/sev_init2_tests.c
+++ b/tools/testing/selftests/kvm/x86/sev_init2_tests.c
@@ -77,10 +77,6 @@ void test_vm_types(void)
 {
 	test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
 
-	/*
-	 * TODO: check that unsupported types cannot be created.  Probably
-	 * a separate selftest.
-	 */
 	if (have_sev_es)
 		test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
 
-- 
2.43.7

