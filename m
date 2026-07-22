Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112147125B
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784762081; cv=none; b=YEgb85St0YaB5wH0Jyp2LNzaJ7QGhxTheET7UNwKZO5qyFqDsV6H78plsuq95KkkDb/A+DheQ2hnzXILI68ksIva7clCAmJqR8axL5U1reUdN9sC2o0jkfbjQsbo3E7SrORZBcNQ95hAg0WXUYj8AhXGNCencMfaOJ2RraVBCCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784762081; c=relaxed/simple;
	bh=J2jP33MsvXzcPyd71zMa34BP+SHntkFHO92tJSH/otQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JzufC1AAqXf4NGYsrukBbMEZo5OvsRfPyItDSs/fKqAxjubkGL3lEc8oqC0VyPDu3qwe75aXpGujimez0STmE8nEwsgR5TQrDYPqPZ5K9r+jl2+VhWrI55sp5D1/gSwPO2kr2bVR2UWXur/UhzT8Yjx1kVKMHMklLzWKrVlb/mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foecDQCp; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foecDQCp"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca860baea9fso136398a12.2
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784762078; x=1785366878; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OE9BObxgnpVBtB0susWSfoNAQmdWjz8VkVFbMsNsCVk=;
        b=foecDQCpaALgNr1xMmroZEUQ6VJH5GJFriLyTDXMHEI6REry4HNYgTYQdn3fRW+Gvi
         IGQ1Q99am0//xJVarzpihKuWw1IDMwhRllTtifL60FWKd9eBxydyoyl3L7OvWpZ28ouA
         /S3MAGUx0jp80A46JUhOXKvJzfnn+kcGDWsLgeF1ykxhhHB2ITAQfzo0A7fCZGxivUio
         +pPe6E0hE+9Ai5NV0gY1LpVcP51N8dw+bFQ8bkyF6MNkvKehpcevoCPSfT85gVQlJUJe
         XwViD+AvMmLSFm6edvBrlpp2amdWZMdrgjhmXNwPYSIhtGhMtIBRaN3FiVKh6e5o2aa6
         hP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784762078; x=1785366878;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OE9BObxgnpVBtB0susWSfoNAQmdWjz8VkVFbMsNsCVk=;
        b=I8D3JbQ6dmYp3wlGEOjHGiut/hXSfyAiAIXvFCRYG+ZKHt59qODmAEKZxEC4hKcQn1
         BStklI+GzYFvyh7rhR1QI98Boc6xjaXoFhTjld8BaRMo3N7tCnEH5rk2vgyW0z6zMuFg
         fNDrLId3N/x68xrNJsj66yytjjsU/BhJd1/13v2V8Cyt60UDv/2odvqkIdJvMjVxkRDn
         b+b33yfER4+Msv/8ob1HGPNxoj4E+y1ETMLTypIbr7Zzzj2ZNVcikYDl1VU66mpqpjA/
         PTfzYMcWlFX2ofQp7MxcTStojb0TpfeYgrJYHF/j6jqT3KBWVvB3klArbuGKTXrX/DPr
         l7Jw==
X-Forwarded-Encrypted: i=1; AHgh+Rq2i1NLOE+ddmeEs2g5jMRSIso9EzXED3oISLBk4NdIcXBR+q1gGtlJs7FyGiRqc9ZpQ5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9J8ncSSCkW2rIwvXhjPRaSKUA2npgWRHRL/nBi/QPujLAQiq2
	yObF0elegqPo/cVa59+qloS2XqqmJOeI1u1LjYe81BarOuSFHgOQkJeUQ/wtwWTnFAmANu5lfx9
	f+clccQ==
X-Received: from pggh14.prod.google.com ([2002:a63:c00e:0:b0:c9e:142c:425e])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:748a:b0:3c3:bb13:438
 with SMTP id adf61e73a8af0-3c44b0504bcmr554799637.32.1784762077746; Wed, 22
 Jul 2026 16:14:37 -0700 (PDT)
Date: Wed, 22 Jul 2026 23:13:25 +0000
In-Reply-To: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-tdx-selftests-v14-0-15ad654a50db@google.com>
X-Developer-Key: i=wyihan@google.com; a=ed25519; pk=cRi0fKzS5BMxlHyHY2pJv3w/1zcgfYKr6EYGYppdMYc=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784762054; l=3161;
 i=wyihan@google.com; s=20260319; h=from:subject:message-id;
 bh=LhPITB0/P3+C8fkpUXhj3CMOp+sdIRyRL+NpJnysUVU=; b=KwG/mq0dqAwUImRbDSEcbPFdl15WaqHL4VOTMgbqjf6a4Ej+o01Emqg1/da9WwWbbYyH6qqAZ
 KDHbmghfo96Bij8EdsXBK7NyAbD5HONradFoDKSUxowWKqebJozW8wK
X-Mailer: b4 0.14.3
Message-ID: <20260722-tdx-selftests-v14-20-15ad654a50db@google.com>
Subject: [PATCH v14 20/22] KVM: selftests: Implement MMIO WRITE for the TDX VM
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

From: Erdem Aktas <erdemaktas@google.com>

Implement the tdx_mmio_write() to allow TDX VMs to request MMIO
emulation.

Follow the Intel Guest-Hypervisor Communication Interface (GHCI) spec
to the minimum extent that a spec-abiding TDX module will pass the
request to KVM. Skip implementing the #VE handler as described in the
GHCI spec to reduce selftests dependency.

To perform emulated I/O, VMs use the TDG.VP.VMCALL instruction to
request MMIO.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
Co-developed-by: Lisa Wang <wyihan@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm          |  1 +
 tools/testing/selftests/kvm/include/x86/tdx/tdx.h | 17 +++++++++++
 tools/testing/selftests/kvm/lib/x86/tdx/tdx.S     | 37 +++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 645d9aac61db..28b33ed8c2e6 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -33,6 +33,7 @@ LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
+LIBKVM_x86 += lib/x86/tdx/tdx.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdx.h b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
new file mode 100644
index 000000000000..6355a30bb47f
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdx.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_TDX_TDX_H
+#define SELFTEST_KVM_TDX_TDX_H
+
+#include <linux/types.h>
+
+#define TDG_VP_VMCALL_VE_REQUEST_MMIO    48
+#define TDVMCALL_MMIO_WRITE		  1
+
+u64 __tdcall(u64 leaf, u64 r12, u64 r13, u64 r14, u64 r15);
+
+static inline u64 tdx_mmio_write(u64 address, u32 size, u64 data_in)
+{
+	return __tdcall(TDG_VP_VMCALL_VE_REQUEST_MMIO, size,
+			TDVMCALL_MMIO_WRITE, address, data_in);
+}
+#endif /* SELFTEST_KVM_TDX_TDX_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
new file mode 100644
index 000000000000..dff48a3624a1
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx.S
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+.globl __tdcall
+/*
+ * u64 __tdcall(u64 leaf, u64 r12, u64 r13, u64 r14, u64 r15)
+ */
+__tdcall:
+	push %r12
+	push %r13
+	push %r14
+	push %r15
+
+	/* Map C ABI fast arguments to TDX GHCI payload registers */
+	/* RDI=leaf, RSI=r12, RDX=r13, RCX=r14, R8=r15 */
+
+	mov %rdi, %r11
+	mov %rsi, %r12
+	mov %rdx, %r13
+	mov %rcx, %r14
+	mov %r8,  %r15
+
+	/* TDCALL boilerplate */
+	mov $0, %rax
+	mov $0xFC00, %rcx	/* Expose R10-R15 */
+	mov $0, %r10
+
+	/* tdcall instruction */
+	.byte 0x66, 0x0f, 0x01, 0xcc
+
+	/* Extract status */
+	mov %r10, %rax
+
+	pop %r15
+	pop %r14
+	pop %r13
+	pop %r12
+	ret

-- 
2.55.0.229.g6434b31f56-goog

