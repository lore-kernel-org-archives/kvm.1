Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD05376497
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 23:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405452; cv=none; b=Qww5RvCqJ6i0uB/cOqqg5XPdueJHHP8T+KgfW9UiK07l+ALOIji68JPqeBPHUUxktMvA8fNP0Kne1yJktavRqLPQjsEj8zjvFeaogDdABZurZ/q3I9j07Pux9NCzMJ5JbHZpAb8cgzb4th346zB18Sm4d1DDUvFVeQjOtuoc1KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405452; c=relaxed/simple;
	bh=NMvFXFsJ4XVQXpc0SEeVabXtCHJZfN1K9W0dcf3dxhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dhrMIaBqa3RSg05e6D9ObIkSY2E84Eva+XsmnFvtZJAF+Or4YKS0j3zzLQ1YslyhzQOIy1tLdY6xEpBxlDXU2SjcuEWdTJJ0IN4Y/vG+1NqofsmMUv7oIYTJnWXcdDo49iwBf7GYUgRzFk3tEJdxvw52d6XHtBb/cwu00FcFixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2Xr6Dks; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2Xr6Dks"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba054e0304so60467325ad.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 16:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779405448; x=1780010248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuT7Oa4jc09yaVnGJONiUjVx+++nAViPkDT406Nds6w=;
        b=l2Xr6DksN1sUmTC7BsyHxB0CF7zj1rtC6AUYXKYxv3wymOMMNWm3+X1mp185ph2wx5
         X2IxRXtKl/A88ih+bDtfEdrcB8cjTJVSsdmzYwVC0/fuLt7E8mlK1GhYVvhuF7bJdZMh
         0QqMcpIiFJtpLUg8+8i6ZXf931hZKnRYiS4vCIHWjkpvvZsb0xPPT9y0KfvTeZ+ewLlx
         rSJQSjKcElndHEhu267fgHaW7uqq4aTy7l9Zg5L5fG0Tp00Jl/DqM5L5aFGzy3ay2kBg
         pkJ9iflZdrNnVX7m3DDFhkn/uzj8Bpw73TVUwZW5+fHmBzy4Q66IIgZFTp5ilrYjCVC7
         5iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405448; x=1780010248;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XuT7Oa4jc09yaVnGJONiUjVx+++nAViPkDT406Nds6w=;
        b=JGY2UJhaMjr6dCwkTI39qz4iDiYSxNxqQ4ywEAk8ZC/jxCNRsRqmy1+lhBpCHPT3jv
         MVXVXbgxzVBKD9rHEf8Dif2y95+kehaXxMJRSUr71EqkqYLl3f92tYou5MYl2psV5wR3
         P9w4R6jl6bo1fgs7yTsV25EP7Ru3lQIGmnkLDGrBrDUST3R97mPFPSiI5w1fkqO7qYK5
         Pv1RKcji4yZtDl6kHo/Wflkw1PmoNFEYrj8ipcaPp/5ZrnTjB8HhRZsXI72wu9vLprdV
         VFy4fg+Eyf1peOYnRSJoQt2SusGtuZwymJrhdSVxSP8WtxM+TcflCrIjNDZBiY7eUdJB
         Shyw==
X-Forwarded-Encrypted: i=1; AFNElJ+ULCyNxfnrkZMCQLuKQuOn7U6D2uVWTKJ3OexlWHJH66zmXiT/uiJYT02uMLNlotPu5Wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9dxVnHLOXKgMDJJ/t84mWk6/pjmnbOywuaPTEb61FkHQ0sOu
	iaXdFU/oxLDSaEY0JGjMtEwxLhrqfrEoukA+IbPFCJmDdpvBaCU5/okPfRFLqy5UCZm/CN81QCc
	4qNv21Q==
X-Received: from plbkh5.prod.google.com ([2002:a17:903:645:b0:2bd:8434:6d14])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d60d:b0:2ba:838b:bfae
 with SMTP id d9443c01a7336-2beb089e812mr6491055ad.18.1779405448141; Thu, 21
 May 2026 16:17:28 -0700 (PDT)
Date: Thu, 21 May 2026 23:16:48 +0000
In-Reply-To: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779405439; l=9025;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=VJ5v/qCpIL1Nuw4X+jBr/p2Fwyd+Kv2GMLG00keGkJM=; b=UMxSbaugF7X01jUNc29+zrw8fB8Y7DSNknGwphV/QlC520pzkrVmszSpAwpMoAg8jD/m691HX
 Kzu+NSucTaoBjZ0ce9B0SerBIILGICmRzhvr6DljLfJxuOJveIgz1Cq
X-Mailer: b4 0.14.3
Message-ID: <20260521-tdx-selftests-v13-v13-7-6983ae4c3a4d@google.com>
Subject: [PATCH  v13 07/22] KVM: selftests: Introduce structures for TDX guest
 boot parameters
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

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/.gitignore             |  3 +-
 tools/testing/selftests/kvm/Makefile.kvm           | 29 ++++++++-
 .../selftests/kvm/include/x86/tdx/td_boot.h        | 69 ++++++++++++++++++=
++++
 .../selftests/kvm/lib/x86/tdx/td_boot_offsets.c    | 21 +++++++
 4 files changed, 119 insertions(+), 3 deletions(-)

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
index e5769268936a..02fad7b35eac 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -19,6 +19,8 @@ LIBKVM +=3D lib/userfaultfd_util.c
=20
 LIBKVM_STRING +=3D lib/string_override.c
=20
+LIBKVM_ASM_DEFS +=3D lib/x86/tdx/td_boot_offsets.c
+
 LIBKVM_x86 +=3D lib/x86/apic.c
 LIBKVM_x86 +=3D lib/x86/handlers.S
 LIBKVM_x86 +=3D lib/x86/hyperv.c
@@ -260,6 +262,10 @@ OVERRIDE_TARGETS =3D 1
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
=20
+# Enable Kbuild tools.
+include $(top_srcdir)/scripts/Kbuild.include
+include $(top_srcdir)/scripts/Makefile.lib
+
 INSTALL_HDR_PATH =3D $(top_srcdir)/usr
 LINUX_HDR_PATH =3D $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE =3D $(top_srcdir)/tools/include
@@ -272,15 +278,24 @@ CFLAGS +=3D -Wall -Wstrict-prototypes -Wuninitialized=
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
@@ -313,6 +328,7 @@ LIBKVM_S :=3D $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ :=3D $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
+LIBKVM_ASM_DEFS_OBJ +=3D $(patsubst %.c, $(OUTPUT)/%.s, $(LIBKVM_ASM_DEFS)=
)
 LIBKVM_OBJS =3D $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIB=
CGROUP_O)
 SPLIT_TEST_GEN_PROGS :=3D $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ :=3D $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS=
))
@@ -338,7 +354,9 @@ $(SPLIT_TEST_GEN_OBJ): $(OUTPUT)/$(ARCH)/%.o: $(ARCH)/%=
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
@@ -350,6 +368,9 @@ $(LIBKVM_C_OBJ): $(OUTPUT)/%.o: %.c $(GEN_HDRS)
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
@@ -358,11 +379,15 @@ $(LIBKVM_STRING_OBJ): $(OUTPUT)/%.o: %.c
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
index 000000000000..af4474dee387
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/td_boot.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_TDX_TD_BOOT_H
+#define SELFTEST_TDX_TD_BOOT_H
+
+#include <stdint.h>
+
+#include <linux/compiler.h>
+#include <linux/sizes.h>
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
+#define FOUR_GIGABYTES_GPA (SZ_4G)
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
2.54.0.746.g67dd491aae-goog

