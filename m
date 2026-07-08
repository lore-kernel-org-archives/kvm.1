Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429A373BFE
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481808; cv=none; b=bXgY0THxQZn7Jh5As7ltsxpMTrGlMRPzSa/S/8itZ8YN+MK1G80Wy/DEOjS1YLwJJEANeYxd2Wtum+RlhEdVAi5LZlWffnVakJHltE8JrvsRY/znS2yPRsaew/m1unb9pBdWmXb8ZXLzQeWgZF333eip94jv1PylxVSzqXjiCFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481808; c=relaxed/simple;
	bh=oHl0N2vpojWj02TJpZJMDrHhq8G9Cg4fhg6BkSVUMOQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSG0ovEnRa5nEQLEX09vTDdyOg4HXazLcu3gX2Pl5/VvYQx1ZDQftA6b8Oas7A0dX1ojWYES9xRDh30g2tC4z+ONHx3JWOmzcjckz5+a12e9nFx6CaGC+lQvUSyQziiSlP5+1m7hgBV7Ox4FshAJrxcvvPTNdRZ33VeP68Y30h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALQNp7nC; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALQNp7nC"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso231915a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 20:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783481801; x=1784086601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bdv2Ctkz/FW0hn4mHAySYNVwcrKaEen484H6Mm8b//s=;
        b=ALQNp7nCjSaV+L8xQKA5qhW5opNpkN5HmIxJwhtPxPB6qFuyB3gDhHMaZ6dROm4K6u
         00G04EIVDwhBldLffBL6YrBnb65rW7gTV+7CiTsQxi/VREFnLLHZnm+HZzMKa1cU/eW9
         7pDRdePkjEjX1Md+c7NvdiynT4gWZ6iVwAFg1OSlACC5rYRVHfuV+DuATpV1SHH7qOB4
         e6GFXvp2hDExT1jSX/5FLCWTg0e2lGT14iJCfmOc9w7VOX1775Bs3Y9J39n9mutaOB90
         HofagCkO+zV+f6n0Mk0e5xGHk2aWXXkwyD/disJ/mTEIt+zYFAn8uYN1eGxqfq5FPsyM
         Kveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783481801; x=1784086601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bdv2Ctkz/FW0hn4mHAySYNVwcrKaEen484H6Mm8b//s=;
        b=k1brzAo7mSwk63ydjUKIewykU8RulSaOsOhKLmAhPVaTf7qcJy0N+U3qfQ9spZKl/V
         s4zFIo1FNW9V6fec9LcIbF2u8oBPqsp5x9pNnPanwmhTkk9gz7Xa2WwRqXh/CI3WENCw
         /CmYqJDTKX+GFRTrWVGK35Cf5RrZ3WKRB6++M3SIz09cg2u81oALjuQiS63dFSo+3Han
         gXMjXBZDy6zDwpJVWKo5I907vir6pVazOfg0Tg2yltomlU2OTnAJo/rpQREvFRSDvHu3
         necDpboWoWm3eNcTwRzPD+37FE0UcsuCA5nzrIoongYUyq58eKOYO/FuW9wW6G6XHiaH
         i9HQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrPbtRdP9ZEi98nUE98F+gkypa5NbZx6urzCW1u9XNgIEpQ046qzd4FHBkRGe9UW/gEOM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweu95MTaAJ7utd4bqOZ6eIbdNGY1dJrVh6lrXh3cp75ispFluV
	grHs0IC/UPaajY/DIMi0M+nHwt7G3Kb0HUqDPN3PUo9pIynUMXlZiPJd
X-Gm-Gg: AfdE7cm/xPorxDBLoyKrTxb6NMj2ggi2kpZTheik+38JXJUtKT4z6pQNHtSmYESsrwc
	WUUGSPtlTQFBsoz1RUQ9VenZ/Zp5fJeyLad3hOtIcLX8cj/3Z2ncgtjhb3B0TM/keboKne1zx+Y
	Nn5tuqSNNV3Oor/8awYWew+l92LfwTvkDdnUacpWcE4504EexucV4L7E6lYydY8NNLPYUkHCu0v
	u/Pfht4jiNBFhE0L7th3DmWMLcqG2pEJ2ph2ndsPUqOAu1v76BxDFvFFSTh188pDpdUtxVDPxa0
	9IAVCpgwdppQu9MSl/SKp63fK6It1znio31qRaXq3L19k3Ykh4GxoXxIcnieEs6AbLCoc/CWXEe
	P3SwkazeP7fgLsxADoqD1puaNFn3oLhKv5OzQ8/es6GUP0XqcRfI5DiAlpe9Na+KbsRhMXtafPf
	Qz215hS0ZczDGUIrskG1QgwhsBVNP24pn5fGoDLXw=
X-Received: by 2002:a17:90b:5290:b0:387:e0db:3d8d with SMTP id 98e67ed59e1d1-3894395516amr711810a91.40.1783481801232;
        Tue, 07 Jul 2026 20:36:41 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm21092850eec.29.2026.07.07.20.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:36:40 -0700 (PDT)
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Tue, 07 Jul 2026 20:34:36 -0700
Subject: [PATCH v3 13/17] riscv: kvm: Add emulated test csr
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-riscv_insn_table-v3-13-3f8e5f75ba97@gmail.com>
References: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
In-Reply-To: <20260707-riscv_insn_table-v3-0-3f8e5f75ba97@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alex@ghiti.fr>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Conor Dooley <conor@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Jesse Taube <jtaubepe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783481777; l=5057;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=oHl0N2vpojWj02TJpZJMDrHhq8G9Cg4fhg6BkSVUMOQ=;
 b=f0/7JmOW73SvUy0ZQ6FNsrrekd4jPc1glCSUOAPV1wBR0CHqyzyAdPHvMn6Kgn7F2HQA/J1RT
 JVOWRlWMUMtAgaNQP6Ht6OpkBNnT+1o0lQcFeJd/mP/Dc/RKXZIqzFo
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

To test the riscv kvm implementation of emulated CSRs, add support to
emulate the vsscratch csr when CONFIG_RISCV_KVM_TEST_CSR is set.

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
---
 arch/riscv/Kconfig.debug                   |  1 +
 arch/riscv/include/asm/kvm_host.h          | 10 ++++++++++
 arch/riscv/include/asm/kvm_vcpu_test_csr.h | 15 +++++++++++++++
 arch/riscv/kvm/Kconfig.debug               | 16 ++++++++++++++++
 arch/riscv/kvm/Makefile                    |  1 +
 arch/riscv/kvm/vcpu_insn.c                 |  5 +++++
 arch/riscv/kvm/vcpu_test_csr.c             | 21 +++++++++++++++++++++
 7 files changed, 69 insertions(+)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index eafe17ebf710..be202267da6d 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -1 +1,2 @@
 source "arch/riscv/kernel/tests/Kconfig.debug"
+source "arch/riscv/kvm/Kconfig.debug"
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 75b0a951c1bc..4d30d30ebefc 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -167,6 +167,12 @@ struct kvm_vcpu_reset_state {
 	unsigned long a1;
 };
 
+#ifdef CONFIG_RISCV_KVM_TEST_CSR
+struct kvm_test_csr {
+	unsigned long val;
+};
+#endif
+
 struct kvm_vcpu_arch {
 	/* VCPU ran at least once */
 	bool ran_atleast_once;
@@ -265,6 +271,10 @@ struct kvm_vcpu_arch {
 		gpa_t shmem;
 		u64 last_steal;
 	} sta;
+
+#ifdef CONFIG_RISCV_KVM_TEST_CSR
+	struct kvm_test_csr test_csr;
+#endif
 };
 
 /*
diff --git a/arch/riscv/include/asm/kvm_vcpu_test_csr.h b/arch/riscv/include/asm/kvm_vcpu_test_csr.h
new file mode 100644
index 000000000000..a844fccaafc3
--- /dev/null
+++ b/arch/riscv/include/asm/kvm_vcpu_test_csr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_VCPU_RISCV_TEST_CSR_H
+#define __KVM_VCPU_RISCV_TEST_CSR_H
+
+#include <asm/kvm_vcpu_insn.h>
+
+#define KVM_RISCV_VCPU_TEST_CSR_FUNCS \
+	{.base = CSR_VSSCRATCH,	.count = 1,	.func = kvm_riscv_vcpu_test_csr },
+
+int kvm_riscv_vcpu_test_csr(struct kvm_vcpu *vcpu, unsigned int csr_num,
+			    unsigned long *val, unsigned long new_val,
+			    unsigned long wr_mask);
+
+#endif /* !__KVM_VCPU_RISCV_TEST_CSR_H */
diff --git a/arch/riscv/kvm/Kconfig.debug b/arch/riscv/kvm/Kconfig.debug
new file mode 100644
index 000000000000..dc76e02120a3
--- /dev/null
+++ b/arch/riscv/kvm/Kconfig.debug
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "arch/riscv/kvm testing"
+
+config RISCV_KVM_TEST_CSR
+        bool "Test KVM CSR emulation"
+        depends on KVM
+        default n
+        help
+            Enable this option to enable the emulation of a test hypervisor csr.
+            The KVM test csr is the vsscratch register. Once this is enabled,
+            reading/writing to the vsscratch register will trap into the host
+            supervisor and reflect the change.
+
+            If unsure, say N.
+
+endmenu # "arch/riscv/kvm testing"
diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
index 296c2ba05089..5092b86751c4 100644
--- a/arch/riscv/kvm/Makefile
+++ b/arch/riscv/kvm/Makefile
@@ -38,6 +38,7 @@ kvm-y += vcpu_sbi_sta.o
 kvm-y += vcpu_sbi_system.o
 kvm-$(CONFIG_RISCV_SBI_V01) += vcpu_sbi_v01.o
 kvm-y += vcpu_switch.o
+kvm-$(CONFIG_RISCV_KVM_TEST_CSR) += vcpu_test_csr.o
 kvm-y += vcpu_timer.o
 kvm-y += vcpu_vector.o
 kvm-y += vm.o
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 78adc2830819..c3e4cf2cd44b 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -10,6 +10,8 @@
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
 
+#include <asm/kvm_vcpu_test_csr.h>
+
 struct insn_func {
 	unsigned long mask;
 	unsigned long match;
@@ -112,6 +114,9 @@ static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
 static const struct csr_func csr_funcs[] = {
 	KVM_RISCV_VCPU_AIA_CSR_FUNCS
 	KVM_RISCV_VCPU_HPMCOUNTER_CSR_FUNCS
+#ifdef CONFIG_RISCV_KVM_TEST_CSR
+	KVM_RISCV_VCPU_TEST_CSR_FUNCS
+#endif
 	{ .base = CSR_SEED, .count = 1, .func = seed_csr_rmw },
 };
 
diff --git a/arch/riscv/kvm/vcpu_test_csr.c b/arch/riscv/kvm/vcpu_test_csr.c
new file mode 100644
index 000000000000..b8aa503cdaba
--- /dev/null
+++ b/arch/riscv/kvm/vcpu_test_csr.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_vcpu_insn.h>
+#include <asm/kvm_vcpu_test_csr.h>
+
+#define vcpu_to_test_csr(vcpu) (&(vcpu)->arch.test_csr)
+
+int kvm_riscv_vcpu_test_csr(struct kvm_vcpu *vcpu, unsigned int csr_num,
+			    unsigned long *val, unsigned long new_val,
+			    unsigned long wr_mask)
+{
+	struct kvm_test_csr *test_csr = vcpu_to_test_csr(vcpu);
+
+	*val = test_csr->val;
+
+	if (wr_mask)
+		test_csr->val = (test_csr->val & ~wr_mask) | (new_val & wr_mask);
+
+	return KVM_INSN_CONTINUE_NEXT_SEPC;
+}

-- 
2.54.0

