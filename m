Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690605;
	b=BWuunGaYWwCxRUEH1aqDfaJ0vKnpFmLRzx7AfGdsJ5Ycfzvh/wJQogHyELGmHzfB5S0N
	 3Byq3u8wLLL4az/FKOn58w9+lW186wT/0XkOJURMYgFjdz0sNxUgIAhNEhqLBDd2QwoO9
	 r1gkwx0c5Xt9aQGdqke2vLk9F6tZAKRxyFtcRHdt8g7OS/gDgPkt/v8bWgPcpV6xVK+07
	 hoTLzZOaIUDXvqFjwz2vWq2lcXWPazixoXzr2ixioLTDKf/9WauGYocZ3fYtlC8XsnbLX
	 XwGY7h5dgikcPOsFCQvAaadrkzF7hrTtc8D3nk27wi70BculsiN8gICZwrDNBTiUCdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690605;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
	b=25DBrhzuq202fKqNxfhmsthg6kUixvhYKyKUmrhX8jySrQCWSe8rTTgzYwtW7tWOsMcU
	 ETFyZi0aQBZStqsLQBcdpZCyoRMZIko5p+FFk0zqJHAUDt4yttVeSFsFOaIL5MTW88efV
	 SKUqQlU922LLSWIZBtbmrmpDF6HWbwpYdmPT/MTb6Xf7YiddAGwKt49fkhQbTReT7N/Jn
	 b9V18yoU/bnNi/u2r5uyQXzqag1WogpH79sqpkTJ3Eb55h26M7ccdZ2GzXFX87j1I2AlC
	 XCoAw+iR/OD9fc7AuiP0kUvIoneYpNhl8Upy4rp6WLRXm4PQ+nv/csxoHyqwmt0Kl/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=boSllIkK;
	arc=none smtp.remote-ip=209.85.216.99
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F281606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 07:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F281606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=boSllIkK
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2425921a91.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 23:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690604; x=1794295404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
        b=loGmDinxvKKfVpbvWEi3V6YxRg3eHAZmw1Pd7aLWWyqpYB6V0NtafYForiJjsSndL2
         Z/wEXUU5R89TZLOsf5v1ZrC0nCh9jjbfFNF+cF0Pzv11eAceB/Ye2QPhYQR17GGagKVj
         qKqSpQwwiWhCxbHArWpEvoZKys1FdU735CLQUkUuqr8S80zoY0MP9ds0QeJD2bKF3g1j
         v65Wu6+hQMPZah9namUxbkSBbNVQOz8vesSHlR8KNyPk5HWpL2udlNbGpCuBsDR35Q+e
         nd6eAzGhlVC5TUgpsD+3d/j8LO0E62RXssChHgdT8uwyj0aiw3IOasMUIqyE6PjcCR7s
         IY1g==
X-Forwarded-Encrypted: i=1; AKwUvBzix8G3BLOMWcDnm9tdal8sHO0nm4VyWRuyqDIyt0SB6nJeEB/Ywvknd0FkzoJJfCKj66U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6Ap4ryGRgzI9ZTaAV07N1uvatSe5/CiNV61+tmewMVlOhuYXh
	NxdjMrF+sCDo4l2EyMLLC2PVyBn/vZyN8QP6/Rz28TuPhPa2JjxMMCUCz5R/b7x2UhNLY8qaR44
	5k/xNuFPx13bEVTTzXTYV6CRyBL1dfb2PX+XpoIKRF9il5u1ugOjCYIpn1LnkbJF/B0IvTXEKjJ
	W25zYJp7+F1kHvkWLOaFJWqb4Zs8yWDf+4WoO25VPM+A4Z4sH4k5LPH8gcnzKeduvxbej+nLiYr
	+05
X-Gm-Gg: AYBFou25Zgk/CPXBvW8ELDw6k1AnZdriCc4ld5JKtd4gvgTd8YJ/ZX7+4oQ68FJ0bAC
	8OqRuqew+N3XEd693rhy/aZ/uIOxJPv+BtVzupvlfnON2pUNlMvCnWa4rRmFBWfCpHQLHM5jhH8
	lgtB8f4+bfsJoKxc7o08RtJ908EDQbjCjeeYIoiWfjHYMSfI2BDeZpcOxriiLPvXVESJnlz00eW
	U3etfPV88vqOXuZEKFcey0/FxDMcn7vJFVCyB/McBFrcNr0Hvygv3M1wVtFY8s41QQKW7yu/lwb
	IREsH1HVdTOddPHeHN5sJyaVN/53QpiY1QoglGwTzorgQLQZ4Bi4G9UDpcdehUG/KWL4rCQa0il
	VTn+sirhUq7X9YkuKk3c+eZ+kQQfuZQkIYDM/k4H4t1TqZU+RRxxQ8i1OBsIRADeNqgkXE7ppDu
	tL7EDm1sAM4aY2G8Tjhce2lVNMFmeYljJr
X-Received: by 2002:a17:90b:4a02:b0:3ac:6fcf:81a2 with SMTP id 98e67ed59e1d1-3ae89821660mr8867956a91.57.1793690603918;
        Mon, 02 Nov 2026 23:23:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c9d77b9sm1283324a91.4.2026.11.02.23.23.23
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:23:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eacc615f73so2986635e0c.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 23:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690603; x=1794295403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1wn8B8AtBDch11Kn2VubYj0NKMdWprvKTv7qKouH7kM=;
        b=boSllIkKcnKI+Vfe+hTdk349znMDTrlk44MJtQqp40UtQAn2cV18VBe5UhCVvr3hG2
         4KnJ2fFNxkwYM4rxGRoL/u6yhSi7mBB1NdpPU+pxmD/oo4WL8vVz+fFq2I/8Eca1k10z
         fdgdDyVbrcvcy4QcSjqhpqifth8CIykcDNlfE=
X-Forwarded-Encrypted: i=1; AKwUvBw4+1mLgyqMdAMfpLnQc8RNnJNx6bRUNAzR80bkbmDasZFGlJWVFELWNOii+ojMo+tfH1w=@vger.kernel.org
X-Received: by 2002:a05:620a:1a04:b0:93e:7939:acd0 with SMTP id af79cd13be357-944216bd289mr2142667285a.37.1793690150306;
        Mon, 02 Nov 2026 23:15:50 -0800 (PST)
X-Received: by 2002:a05:620a:1a04:b0:93e:7939:acd0 with SMTP id af79cd13be357-944216bd289mr2142663485a.37.1793690149883;
        Mon, 02 Nov 2026 23:15:49 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:15:44 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 1/3] x86/vmware: Move high-bandwidth hypercalls out of line
Date: Tue,  3 Nov 2026 02:14:56 -0500
Message-ID: <5c509e51a3e04b95a6447fabc9db20d72152a8f3.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The high-bandwidth helpers contain inline assembly which temporarily uses
%bp as a VMware ABI register. Keeping that assembly in vmware.h duplicates
it in callers.

Move both helpers to vmware.c and export them for the vmwgfx module.
Preserve their unwind hints and remove the redundant caller-wide objtool
annotations from vmwgfx.

Preserve the argument sequence from commit e0e022004bbe ("x86/vmware:
Fix i386 high-bandwidth hypercall arguments").

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/vmware.h       | 62 +-------------------------
 arch/x86/kernel/cpu/vmware.c        | 68 +++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c |  3 --
 3 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index fb011cef01e7..f3ffe358d2a3 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -253,12 +253,6 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
 	return out0;
 }
 
-#ifdef CONFIG_X86_64
-#define VMW_BP_CONSTRAINT "r"
-#else
-#define VMW_BP_CONSTRAINT "m"
-#endif
-
 /*
  * High bandwidth calls are not supported on encrypted memory guests.
  * The caller should check cc_platform_has(CC_ATTR_MEM_ENCRYPT) and use
@@ -266,66 +260,14 @@ unsigned long vmware_hypercall7(unsigned long cmd, unsigned long in1,
  * This assumption simplifies HB hypercall implementation to just I/O port
  * based approach without alternative patching.
  */
-static inline
 unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
 				      unsigned long in3, unsigned long in4,
 				      unsigned long in5, unsigned long in6,
-				      u32 *out1)
-{
-	unsigned long out0;
-
-	asm_inline volatile (
-		UNWIND_HINT_SAVE
-		"mov %[in6], %%" _ASM_AX "\n\t"
-		"push %%" _ASM_BP "\n\t"
-		UNWIND_HINT_UNDEFINED
-		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
-		"mov %[magic], %%eax\n\t"
-		"rep outsb\n\t"
-		"pop %%" _ASM_BP "\n\t"
-		UNWIND_HINT_RESTORE
-		: "=&a" (out0), "=b" (*out1)
-		: "b" (cmd),
-		  "c" (in2),
-		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
-		  "S" (in4),
-		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT(in6),
-		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
-		: "cc", "memory");
-	return out0;
-}
-
-static inline
+				      u32 *out1);
 unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
 				     unsigned long in3, unsigned long in4,
 				     unsigned long in5, unsigned long in6,
-				     u32 *out1)
-{
-	unsigned long out0;
-
-	asm_inline volatile (
-		UNWIND_HINT_SAVE
-		"mov %[in6], %%" _ASM_AX "\n\t"
-		"push %%" _ASM_BP "\n\t"
-		UNWIND_HINT_UNDEFINED
-		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
-		"mov %[magic], %%eax\n\t"
-		"rep insb\n\t"
-		"pop %%" _ASM_BP "\n\t"
-		UNWIND_HINT_RESTORE
-		: "=&a" (out0), "=b" (*out1)
-		: "b" (cmd),
-		  "c" (in2),
-		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
-		  "S" (in4),
-		  "D" (in5),
-		  [in6] VMW_BP_CONSTRAINT(in6),
-		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
-		: "cc", "memory");
-	return out0;
-}
-#undef VMW_BP_CONSTRAINT
+				     u32 *out1);
 #undef VMWARE_HYPERCALL
 
 #endif
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index f7ab9e7902cf..7cfc894f0663 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -30,12 +30,14 @@
 #include <linux/reboot.h>
 #include <linux/static_call.h>
 #include <linux/sched/cputime.h>
+#include <asm/asm.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
 #include <asm/hypervisor.h>
 #include <asm/cpuid/api.h>
 #include <asm/timer.h>
 #include <asm/apic.h>
+#include <asm/unwind_hints.h>
 #include <asm/vmware.h>
 #include <asm/svm.h>
 
@@ -67,6 +69,72 @@ struct vmware_steal_time {
 static unsigned long vmware_tsc_khz __ro_after_init;
 static u8 vmware_hypercall_mode     __ro_after_init;
 
+#ifdef CONFIG_X86_64
+#define VMW_BP_CONSTRAINT "r"
+#else
+#define VMW_BP_CONSTRAINT "m"
+#endif
+
+unsigned long vmware_hypercall_hb_out(unsigned long cmd, unsigned long in2,
+				      unsigned long in3, unsigned long in4,
+				      unsigned long in5, unsigned long in6,
+				      u32 *out1)
+{
+	unsigned long out0;
+
+	asm volatile(UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
+		"rep outsb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
+		: "cc", "memory");
+	return out0;
+}
+EXPORT_SYMBOL_GPL(vmware_hypercall_hb_out);
+
+unsigned long vmware_hypercall_hb_in(unsigned long cmd, unsigned long in2,
+				     unsigned long in3, unsigned long in4,
+				     unsigned long in5, unsigned long in6,
+				     u32 *out1)
+{
+	unsigned long out0;
+
+	asm volatile(UNWIND_HINT_SAVE
+		"mov %[in6], %%" _ASM_AX "\n\t"
+		"push %%" _ASM_BP "\n\t"
+		UNWIND_HINT_UNDEFINED
+		"mov %%" _ASM_AX ", %%" _ASM_BP "\n\t"
+		"mov %[magic], %%eax\n\t"
+		"rep insb\n\t"
+		"pop %%" _ASM_BP "\n\t"
+		UNWIND_HINT_RESTORE
+		: "=&a" (out0), "=b" (*out1)
+		: "b" (cmd),
+		  "c" (in2),
+		  "d" (in3 | VMWARE_HYPERVISOR_PORT_HB),
+		  "S" (in4),
+		  "D" (in5),
+		  [in6] VMW_BP_CONSTRAINT(in6),
+		  [magic] "i" (VMWARE_HYPERVISOR_MAGIC)
+		: "cc", "memory");
+	return out0;
+}
+EXPORT_SYMBOL_GPL(vmware_hypercall_hb_in);
+
+#undef VMW_BP_CONSTRAINT
+
 unsigned long vmware_hypercall_slow(unsigned long cmd,
 				    unsigned long in1, unsigned long in3,
 				    unsigned long in4, unsigned long in5,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index fd77ab6568cb..20ab4019680c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include <linux/objtool.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -289,7 +288,6 @@ static int vmw_send_msg(struct rpc_channel *channel, const char *msg)
 
 	return -EINVAL;
 }
-STACK_FRAME_NON_STANDARD_FP(vmw_send_msg);
 
 
 /**
@@ -384,7 +382,6 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 	return 0;
 }
-STACK_FRAME_NON_STANDARD(vmw_recv_msg);
 
 
 /**
