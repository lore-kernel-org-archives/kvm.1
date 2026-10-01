Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1952D2D9
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883531; cv=none; b=pYFgGP2Ha1/xWefNlPrTRz/TMhZLIjk1taRNFMLWH35l9C24zCXAhD11nwudXAt7ySCNQdbeOWiNU/MiXQAThnox67X/usTsd9Bualo8UYIVa/uwBI5y1crlCsKutQ4GAPE2OLZ4NWcJ6+i+/i4rTskz+FwdjcSWm3WCK2T56F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883531; c=relaxed/simple;
	bh=L90AcCVt8yzrQmsXHU/gHG5nF1bf+aQ/coVUN/MeLwo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OtB0qf/lmUXLGTKDzuYGsQlIuoplp9iqCN+mQfUyzdx6ZltHmFUczsB2UD+9e445BPmhjGHnm+ozLdeI9h2pLNG9vIr/wuWsd+aVKX5ceUxvGm6RYqqsVhvQcZdgvxT+uxAe3eoTSnCoVlBRWGAnc5wupyOjvUwkRpacSw+Tz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohvexGdY; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohvexGdY"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a6f4ba619so4259978b3a.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 12:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790883528; x=1791488328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xC/JVf1lePMZaSLx8T7aJJSQJc+p0OaDr/bCQS59dxE=;
        b=ohvexGdYlS6oy2bWFqdI3XvwnCz5b5gF1/wslMlg/0JgI4yJH/E69UVdcfRVnLlpsW
         Y1gKa7UaD7qBWKfJ5LbMf7SwvOsi7S1+vCfthUbjfpqdc3hTLJnVyCbSw8kdzeEDht1N
         HYSpuq449OZh9vLkl2u6QUgbnIc7yyOtCASdqpOVr8hW48oUQsAF0Cvkl2dGrOYtz2Re
         h/+/hztaXb0LsVt8uPKKCV7y8TdRw3rzF1HZWz2+sUcHyKm0+lziCdxYEU5aZSQcafHy
         783KhxQVutREBACqnUDsHZ8TghmJ7e32/8yL2kobM7zsyBeAumA9fFL4Vi6EHa3BD/ng
         XFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790883528; x=1791488328;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xC/JVf1lePMZaSLx8T7aJJSQJc+p0OaDr/bCQS59dxE=;
        b=YQqayJ+Q1Tx/59Ik0oJpRz1eOV1pFxjUCNJ+bDKjTPpp7xIYYWPDwm8zrubYMqDmGB
         EsNPHo1fdF5pZN+g2HEDITw5zm9NAS9R3Oj2FrbgBaI4He+/F9V5IC/Jm5yn+G+JK+hb
         mLeT706HcIp5JTEwd3aeDC2BOG/LyI+hteONWM8gcP/ChqGUN9SptbnbeDOEXVDXyd2D
         wkS5Lhy8fDkUQw7vHtjjK6oGKvE7U+9wJ7b4rLC9PxqLuncn6O342qEukhejI5cLfEYw
         5La5uL8AuX+XF8LhJKUSM1eFCQ+lM6yCPaGk9BsKN1aDnSLuu+gXhixIbo/D1HdzR0Lc
         EWxA==
X-Forwarded-Encrypted: i=1; AKwUvBznxH/PfKaK4P6Y7euzhFYJEo9x34RzcaNXckM4DdeCL4mksABWTttFnIS59WSBuAIyxkA=@vger.kernel.org
X-Gm-Message-State: AFuF++lo6HzbRJRE5Ohs1P3Nkgo39eb8/9RUPJ12pEzKP+iot/P36sg3
	OkVuWt9lL1cwJFAJWecMI0iJtyiyAMeE2waM75nFg1acNMTXBgOqJMAl9Ua4ImxqzycMyYapZxi
	mfkVAWA==
X-Received: from pfbdn3.prod.google.com ([2002:a05:6a00:4983:b0:886:c063:eb7])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2889:b0:886:5f48:3fca
 with SMTP id d2e1a72fcca58-88af5da61f4mr494395b3a.37.1790883527312; Thu, 01
 Oct 2026 12:38:47 -0700 (PDT)
Date: Thu, 01 Oct 2026 19:37:33 +0000
In-Reply-To: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790883521; l=9071;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=F7nPTHsmoPu8WcZAo4OeFx/yNcRMOt9UzlmbU7aiHLc=; b=P9O8kZ2QLknHYGvdbe8S3+46LOpov7u5EQkEvqQZiUHRVq6fZivRF7syRZvZjgAsgRU+l8mjZ
 UmkOfW+SbLBCLaIZ9zK4YXQQXYbTYBhk3ZBXe0uZJL6D1TRTs+8KUyI
X-Mailer: b4 0.14.3
Message-ID: <20261001-tdx-selftests-v15-6-7c62a5d8a992@google.com>
Subject: [PATCH v15 06/23] KVM: selftests: Introduce structures for TDX guest
 boot parameters
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
Content-Transfer-Encoding: quoted-printable

From: Sagi Shahar <sagis@google.com>

Introduce `td_boot_parameters` and `td_per_vcpu_parameters`, and export
their offsets to assembly via the kbuild infrastructure.

TDX guest registers are private and must be initialized by guest-side
assembly. These structures allow the assembly code to retrieve boot
parameters and index into per-vCPU data based on the vCPU ID, while
keeping host and guest definitions synchronized.

Use kbuild.h to expose the offsets into the structs from c code to
assembly code.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
 tools/testing/selftests/kvm/.gitignore             |  3 +-
 tools/testing/selftests/kvm/Makefile.kvm           | 35 +++++++++---
 .../selftests/kvm/include/x86/tdx/td_boot.h        | 66 ++++++++++++++++++=
++++
 .../selftests/kvm/lib/x86/tdx/td_boot_offsets.c    | 21 +++++++
 4 files changed, 117 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftes=
ts/kvm/.gitignore
index 1d41a046a7bf..eef6055242b2 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -9,4 +9,5 @@
 !config
 !settings
 !Makefile
-!Makefile.kvm
\ No newline at end of file
+!Makefile.kvm
+include/x86/**/*_offsets.h
\ No newline at end of file
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selft=
ests/kvm/Makefile.kvm
index 8f514008daa2..8fc38a93a725 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -20,6 +20,8 @@ LIBKVM +=3D lib/userfaultfd_util.c
=20
 LIBKVM_STRING +=3D lib/string_override.c
=20
+LIBKVM_ASM_DEFS +=3D lib/x86/tdx/td_boot_offsets.c
+
 LIBKVM_x86 +=3D lib/x86/apic.c
 LIBKVM_x86 +=3D lib/x86/handlers.S
 LIBKVM_x86 +=3D lib/x86/hyperv.c
@@ -269,6 +271,10 @@ OVERRIDE_TARGETS =3D 1
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
=20
+# Enable Kbuild tools.
+include $(top_srcdir)/scripts/Kbuild.include
+include $(top_srcdir)/scripts/Makefile.lib
+
 ifeq ($(ARCH),x86)
 include ../vfio/lib/libvfio.mk
 endif
@@ -285,15 +291,24 @@ CFLAGS +=3D -Wall -Wstrict-prototypes -Wuninitialized=
 -O2 -g -std=3Dgnu99 \
 	-fno-stack-protector -fno-PIE -fno-strict-aliasing \
 	-I$(LINUX_TOOL_INCLUDE) -I$(LINUX_TOOL_ARCH_INCLUDE) \
 	-I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -Iinclude/$(ARCH) \
-	-I ../rseq -I.. $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+	-I ../rseq -I.. -I$(OUTPUT)/include/$(ARCH) $(EXTRA_CFLAGS) $(KHDR_INCLUD=
ES)
 ifeq ($(ARCH),s390)
 	CFLAGS +=3D -march=3Dz10
 endif
+
 ifeq ($(ARCH),x86)
+
 ifeq ($(shell echo "void foo(void) { }" | $(CC) -march=3Dx86-64-v2 -x c - =
-c -o /dev/null 2>/dev/null; echo "$$?"),0)
 	CFLAGS +=3D -march=3Dx86-64-v2
 endif
+
+KVM_GEN_HDRS :=3D $(patsubst lib/x86/%.c, $(OUTPUT)/include/x86/%.h, $(fil=
ter lib/x86/%, $(LIBKVM_ASM_DEFS)))
+$(shell mkdir -p $(sort $(dir $(KVM_GEN_HDRS))))
+$(KVM_GEN_HDRS): GUARD =3D $(shell echo $(*F) | tr a-z A-Z | tr '.' '_')
+$(KVM_GEN_HDRS): $(OUTPUT)/include/x86/%.h: $(OUTPUT)/lib/x86/%.s FORCE
+	$(call filechk,offsets,__$(GUARD)_H__)
 endif
+
 ifeq ($(ARCH),arm64)
 tools_dir :=3D $(top_srcdir)/tools
 arm64_tools_dir :=3D $(tools_dir)/arch/arm64/tools/
@@ -326,11 +341,8 @@ LIBKVM_S :=3D $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ :=3D $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS =3D $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ)
-LIBKVM_OBJS +=3D $(LIBCGROUP_O)
-ifeq ($(ARCH),x86)
-LIBKVM_OBJS +=3D $(LIBVFIO_O)
-endif
+LIBKVM_ASM_DEFS_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.s, $(LIBKVM_ASM_DEFS)=
)
+LIBKVM_OBJS =3D $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIB=
CGROUP_O) $(LIBVFIO_O)
 SPLIT_TEST_GEN_PROGS :=3D $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ :=3D $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS=
))
=20
@@ -355,7 +367,9 @@ $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%=
.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
=20
 EXTRA_CLEAN +=3D $(GEN_HDRS) \
+	       $(KVM_GEN_HDRS) \
 	       $(LIBKVM_OBJS) \
+	       $(LIBKVM_ASM_DEFS_OBJ) \
 	       $(SPLIT_TEST_GEN_OBJ) \
 	       $(TEST_DEP_FILES) \
 	       $(TEST_GEN_OBJ) \
@@ -367,6 +381,9 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
 $(LIBKVM_S_OBJ): $(OUTPUT)/%.o: %.S $(GEN_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
=20
+$(LIBKVM_ASM_DEFS_OBJ): $(OUTPUT)/%.s: %.c FORCE
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -S $< -o $@
+
 # Compile the string overrides as freestanding to prevent the compiler fro=
m
 # generating self-referential code, e.g. without "freestanding" the compil=
er may
 # "optimize" memcmp() by invoking memcmp(), thus causing infinite recursio=
n.
@@ -375,11 +392,15 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
=20
 $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
+$(LIBKVM_OBJS): $(KVM_GEN_HDRS)
 $(TEST_GEN_PROGS): $(LIBKVM_OBJS)
 $(TEST_GEN_PROGS_EXTENDED): $(LIBKVM_OBJS)
 $(TEST_GEN_OBJ): $(GEN_HDRS)
=20
-cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include =
lib ..
+FORCE:
+
+cscope: include_paths =3D $(LINUX_TOOL_INCLUDE) $(LINUX_HDR_PATH) include =
lib .. \
+			$(wildcard $(sort $(dir $(KVM_GEN_HDRS))))
 cscope:
 	$(RM) cscope.*
 	(find $(include_paths) -name '*.h' \
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h b/tools/=
testing/selftests/kvm/include/x86/tdx/td_boot.h
new file mode 100644
index 000000000000..bf2282931d49
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_H
+#define SELFTEST_TDX_TD_BOOT_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/*
+ * Layout for boot section (not to scale)
+ *
+ *                                   GPA
+ * _________________________________ 0x1_0000_0000 (4GB)
+ * |   Boot code trampoline    |
+ * |___________________________|____ 0x0_ffff_fff0: Reset vector (16B belo=
w 4GB)
+ * |   Boot code               |
+ * |___________________________|____ td_boot will be copied here, so that =
the
+ * |                           |     jmp to td_boot is exactly at the rese=
t vector
+ * |   Empty space             |
+ * |                           |
+ * |=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80|
+ * |                           |
+ * |                           |
+ * |   Boot parameters         |
+ * |                           |
+ * |                           |
+ * |___________________________|____ 0x0_ffff_0000: TD_BOOT_PARAMETERS_GPA
+ */
+
+/*
+ * The exact memory layout for LGDT or LIDT instructions.
+ */
+struct __packed td_boot_parameters_dtr {
+	u16 limit;
+	u32 base;
+};
+
+/*
+ * Allows each vCPU to be initialized with different rip and esp.
+ */
+struct td_per_vcpu_parameters {
+	u32 esp_gva;
+	u64 guest_code;
+};
+
+/*
+ * Boot parameters for the TD.
+ *
+ * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
+ * before boot, so to run selftests, these registers' values have to be
+ * initialized by the TD.
+ *
+ * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GPA.
+ *
+ * The TD boot code will read off parameters from this struct and set up t=
he
+ * vCPU for executing selftests.
+ */
+struct td_boot_parameters {
+	u32 cr0;
+	u32 cr3;
+	u32 cr4;
+	struct td_boot_parameters_dtr gdtr;
+	struct td_boot_parameters_dtr idtr;
+	struct td_per_vcpu_parameters per_vcpu[];
+};
+
+#endif /* SELFTEST_TDX_TD_BOOT_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c b/to=
ols/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
new file mode 100644
index 000000000000..7f76a3585b99
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot_offsets.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+
+#include <linux/kbuild.h>
+
+#include "tdx/td_boot.h"
+
+static void __attribute__((used)) common(void)
+{
+	OFFSET(TD_BOOT_PARAMETERS_CR0, td_boot_parameters, cr0);
+	OFFSET(TD_BOOT_PARAMETERS_CR3, td_boot_parameters, cr3);
+	OFFSET(TD_BOOT_PARAMETERS_CR4, td_boot_parameters, cr4);
+	OFFSET(TD_BOOT_PARAMETERS_GDT, td_boot_parameters, gdtr);
+	OFFSET(TD_BOOT_PARAMETERS_IDT, td_boot_parameters, idtr);
+	OFFSET(TD_BOOT_PARAMETERS_PER_VCPU, td_boot_parameters, per_vcpu);
+	OFFSET(TD_PER_VCPU_PARAMETERS_ESP_GVA, td_per_vcpu_parameters, esp_gva);
+	OFFSET(TD_PER_VCPU_PARAMETERS_GUEST_CODE, td_per_vcpu_parameters,
+	       guest_code);
+	DEFINE(SIZEOF_TD_PER_VCPU_PARAMETERS,
+	       sizeof(struct td_per_vcpu_parameters));
+}

--=20
2.56.0.rc1.315.gc6ed9934b7-goog

