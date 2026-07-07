Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F642F701
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438733; cv=none; b=jrQ9mdzleP6ppwBWVKnWMfvZDSucDZENsKGaFoXvR9kG31i6rT2WV8a8tDqMXcUwzS6e9Lfls+QH1yvR6Ofg7l+MiMpXR/I3OJ+gPPdriFBvDfJniJGKoT0e1s/iBzefoFNsJSOHB4v2rbHYXCcxnkhZqcukIAciz9jPLIDtyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438733; c=relaxed/simple;
	bh=SO5eeYPZCjDEPtTUp5vp0e259QcOYfs80Q/ywveYhqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bk1dIMWSMeMkGulw6dPk3i1pX2ctrRf8RBzZC5AMdPNTDOw3Cs4U7aH7ZfUoGGVo+/yNpO8YParQCzjNv2BIIQOWIy+9fZNQYyugtPRwuaDkQC4l44R0LMw1Y12Uh+arZN64twN4dxhxDXK1MqCp+26dZbHBTg/9vAaRv7ou5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fzLhAEC5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fzLhAEC5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493c19bad03so41418605e9.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783438730; x=1784043530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=fzLhAEC5wQsBnTk+jxhHrp4fycMQkxifDEka/Xv1ujO7gSeylfR1jTqVfrJXK2ruv1
         H5jSNYmJwtkOs7H/f3abwRIrw+dbpHYxDemkR2WrI2ye/GaorrcqfMmkTAZYY8gtjuEO
         7GEjVZ8m5b0sRp40XsTYv6+QnbarMsgsHwDzZzhmmvl4W6hEqMkmBDQnyi1C/56YrsTk
         pMoE7mPCmg398Y3f4UV0C/OE23ocqKg2GeZAKxFKKWTw8w65W00s5aHKhrfWFp6a2r3W
         PyxasVNkx6uV8ALLgdBGIUhZPF3HWEPTiAkTBK1DLd6GwQXgp7DMhNpaQe+DLbv63ihZ
         Z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783438730; x=1784043530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FzCn0X+c0BW10b/0YxzB57zNLgSGohyBE3JQzpVoRI=;
        b=jVHkdiHbxljA+E7CRiQMA8ZktZssTkDaakqSsrZ4AVpFX0ptQVJ8uozPdBhD3C1cZo
         T2284W75hWKW1ezg4Y2NcDmi4At7x8z2RenVBaRIrIrIwe75ydW0uAU7cYnBSdZvz0UX
         wP283ZpO14lFNTQs+o4fsWir96R0XJ1e5QYraJ1MlRUSEe5ZAfkjMrdDW6I5xamXXKms
         oMOjO2BhFodnWLY38ggzk73COaRmLJ1ffUslmCOiwSC28uDe//W8OIIfBqA8RR4CPbqA
         jLVSPn4XEJDUPXqZTPOJgLOA/evaRPzxpwu/miRSKyXXc5N9n0knf3q/n+PMeKCU0TP7
         pnng==
X-Forwarded-Encrypted: i=1; AHgh+Rq9V59i6U/ADj5D1MmU43Hxk8rGaL+v0RYonISYlAIRl301UGrzZGG9/uBdB8WdwL5uGu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUFoDVnDNfnJTOddkdM3Vp7F4TiQnb6gACIlQyRLREqb1Kj6/
	4wNm7kEA57KdgwiS0wy/rs5AJYZwvx3HsmLhvFvS+PdwifhKTCSZOfDXl1gp2Wkj4e4=
X-Gm-Gg: AfdE7cl0CHg3f/lZ7hkF6Ax02txfJZrpiUcXGnLto6LhqKsdJGnOI9T46uy7A6oDMr6
	bpM7/xlYEvswLLuGaKEUqo8Hc5mYSh8ape3j7GFS4nX9HyuI8KrlCdg1dqP0BCHkosz4l6j7YPJ
	tyjkfDhlw8SJr54VU0aZd6ntRdWfhW6OAOlZqF4wVmaVubeTP4yk6+zOxTLv2kepIW/yihJv8z+
	ijJzFu6bblq5/pdYkb5mOAnyMIOELehHWGoRFGr1X106CU+4avZQ9lmHo5cWxTgorvKdcpPPjSl
	xsMd0Uw7Hvu2PiNV+vSR9uQY5ufwWAGBfOUDirowO1lb66ASqppl6xl8SOQHq/2e9kTCzVw4nxy
	jxKzzadIhd/LjiuQIS1f2Kuzpdw1AXfghfKQzxytcETJLfhxYE652LEpAbnQnXLqUSbEyt6CUkH
	PoRifBA4odN7hOqVZxCsYSfY4YZknbIUyodaXe/s+TllqnuW2K0SL+7/lamhVo8BbbmG4ip2rcW
	34fOBGqnXufCw==
X-Received: by 2002:a05:600c:810b:b0:492:67df:3dfa with SMTP id 5b1f17b1804b1-493df080788mr55474505e9.34.1783438726830;
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5b811sm101111785e9.13.2026.07.07.08.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:38:46 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>
Cc: Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86: Avoid indirect includes through linux/module.h -> linux/elf.h
Date: Tue,  7 Jul 2026 17:37:04 +0200
Message-ID: <20260707153819.4172541-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707153819.4172541-1-petr.pavlu@suse.com>
References: <20260707153819.4172541-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several x86 files use ELF-related declarations and currently rely on them
being provided indirectly through linux/module.h -> linux/elf.h:

* arch/x86/entry/entry_fred.c: ia32_enabled() -> asm/ia32.h,
* arch/x86/entry/syscall_32.c: vdso32_image -> asm/vdso.h,
* arch/x86/kernel/cpu/intel.c: ELF_HWCAP2 -> asm/elf.h,
* arch/x86/kernel/fpu/xstate.c: elf_coredump_extra_notes_write(),
  elf_coredump_extra_notes_size(), NT_X86_XSAVE_LAYOUT, elf_note ->
  linux/elf.h,
* arch/x86/kernel/process.c: mmap_is_ia32() -> asm/elf.h,
* arch/x86/kernel/signal.c: get_sigframe_size() -> asm/elf.h.

Add the missing includes to these files in preparation for removing the
linux/elf.h include from linux/module.h.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 arch/x86/entry/entry_fred.c  | 1 +
 arch/x86/entry/syscall_32.c  | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/fpu/xstate.c | 2 +-
 arch/x86/kernel/process.c    | 1 +
 arch/x86/kernel/signal.c     | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index fb3594ddf731..ea3bb4298065 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -9,6 +9,7 @@
 
 #include <asm/desc.h>
 #include <asm/fred.h>
+#include <asm/ia32.h>
 #include <asm/idtentry.h>
 #include <asm/syscall.h>
 #include <asm/trapnr.h>
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 31b9492fe851..12fceffc99ef 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -12,6 +12,7 @@
 #include <asm/traps.h>
 #include <asm/cpufeature.h>
 #include <asm/syscall.h>
+#include <asm/vdso.h>
 
 #ifdef CONFIG_IA32_EMULATION
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, compat)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index abb3984336eb..18cf40f08557 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -17,6 +17,7 @@
 #include <asm/cpufeature.h>
 #include <asm/cpu.h>
 #include <asm/cpuid/api.h>
+#include <asm/elf.h>
 #include <asm/hwcap2.h>
 #include <asm/intel-family.h>
 #include <asm/microcode.h>
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a7b6524a9dea..8b90bf86a742 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/compat.h>
 #include <linux/cpu.h>
+#include <linux/elf.h>
 #include <linux/mman.h>
 #include <linux/kvm_types.h>
 #include <linux/nospec.h>
@@ -26,7 +27,6 @@
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
 #include <asm/prctl.h>
-#include <asm/elf.h>
 
 #include <uapi/asm/elf.h>
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 85435044e33c..e40f7f3d3489 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -54,6 +54,7 @@
 #include <asm/mmu_context.h>
 #include <asm/msr.h>
 #include <asm/shstk.h>
+#include <asm/elf.h>
 
 #include "process.h"
 
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 2404233336ab..0fe2d7a6b1af 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -29,6 +29,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 
+#include <asm/elf.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/fpu/signal.h>
-- 
2.54.0

