Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D91E3AFB11
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787206449; cv=none; b=UdjangNrpY6LNA5L64aPvPP0hq1OiuZf1Q45++tj4aYnN/DRakFpPNORKUMIJJx750j1yWGw3HF1ho6j2ka8J8Va4RXOQIQJhBEqFqbpszleejuAx4wx4M4YZV02bh16+dXgTC+T2o4EEi2VKGT5VaAh6LAH+m2BSDV2/diHXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787206449; c=relaxed/simple;
	bh=uLk8iNHfd4NPvrWYw61lAQBRN8fcRiCh0Q/odHDzIeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoNp3jyg61O1LlggcUEkr8Jt3TeK5G/YLTixjkDRF8S4aaxqfGVRfbE9gOIz+9SVfeE1jZwC4kFtmrBIJvUmI1LbHvH44EvKyd1kozxfKP8LJGaJ9wKCG1i3BaO51+DAaewLIxb1J0XC3+tDwosyGax1GOzU5oqFkmOWrISGw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeP6CM8K; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeP6CM8K"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1795836b3a.1
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787206446; x=1787811246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ge48iWvqQuweSPFBnOAGMpJHsKcBn/Ek99Lc6vdvC7E=;
        b=EeP6CM8K3RrzC/nxwVQne2LZmBMtqRbyHLUdP1vSlPoCa6yWDA5mi75m1KKewv4PZE
         LiHG6gPHWCfRjzi6QJnaWMbI+CcujRwQGjr8acmaJ93/rrir5IycsbYASTGKrEqCoLO7
         lhMAGuipPusF7qSYYsChDBkjsPW3dsD2PAxQYST8QpSsXEF3k4w4YX6LVmyXdb+qqDFm
         x6SQcHu2oPoeHPELEuZCNTK79mNJwas5c6pD47xzH1ngQ7dEgf7jDCSpxzDz33sn/P1J
         gALUbu6be9mmkS24Gs91Serfn8p5VFscGrwyOrqjohjkkdJW+rtLfcRKIIB8rLl273VN
         LrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787206446; x=1787811246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ge48iWvqQuweSPFBnOAGMpJHsKcBn/Ek99Lc6vdvC7E=;
        b=dsjf8tnLBvhuvyGRXwgwtRTNiGJ7crnjNIoE7pGpDfgToT4G/SSjhVztdugo1W5u/d
         3k+0vwCqUH1CNDSX9EpyempHA9DJPLOgueR7yms9QHuJhxbVV5NJ1A5JvLgxL6WsmDp2
         5ksKER8NBJclda2sX1RVFrBa7IGJ2obYt5sKxlQF7N9ETh5/Y2wvnWSpAhA9TczAZlul
         8RSmAFCAsDPQT7Ehoii3psBYFlccfbZCHc1AtGwTlrRnLLqlBksZUZHPYGH6Vr/7j3Ww
         mcq7LRFhLDoDxdUxmX6E2EqHkOJnnVclpTHWGz9+n4LmNx22loVK4RiULLa6CmQMkRX6
         e8xQ==
X-Forwarded-Encrypted: i=1; AHgh+RqzCyTRIdIBo7strnzAz1xh1YoFEJdhSj/zNAMj47CuyJfhSaBqIO3ENNWCpFyTuCoTJUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3z6JuFRVHQ+i8cXxF3KD7OTXkbXgQCRxPEgpzMUy0uoIKRIRU
	ev669pcYMmlTepxnDM5nuTeFFpMxMI17BwQjvhRf1pnM2mTbiQvK7JRB
X-Gm-Gg: AR+sD13f1c2+jIuug9R1ybvvQn3NEjfEMihLSc0E18xh72OSqMgKo2TjT9ogkbzp+dR
	/r3cAQd+p4j7K66bWiM9oS8ks5nrFK50mWpLWqz3g7lKxVZ0u0xRoGxmWGv2x16Wa6TfKieVc1g
	xtKFSrQYtPD1XL7vzsiofqZrcmiyo0stICWDv8DCwxkJmpjHe65QPBwqSGTncd73ocyRxllfWe/
	FoeYTzBJivjJKmsh3Jh5Ozvsmtiqs+OUjdWEyuWlIHy3dVq8+2iAT0DeKSvD3412fiIzqabdKga
	IGV1XQowSpFSdK5hwiQ2/L/SuuBoKcRN5UeMu3gWE3+juVcT9eZ92/3rkMAPPBq2FafIYriOsLs
	WY5E/vgAYF79Mq4YzKEkuD6Put2hV+uoi6oUFeiwZrmaqdvuIHLcojDM8RG/I4o1y8184r2aBCD
	8+LZMqp/648IUveeFfUpkLVtnXp7yjFpjr5CUnKoV6GXvT/nP5zc9jk4IIqi+7Bow=
X-Received: by 2002:a05:6a00:189c:b0:84f:b01d:3693 with SMTP id d2e1a72fcca58-851d39419a7mr16069430b3a.15.1787206446026;
        Wed, 19 Aug 2026 23:14:06 -0700 (PDT)
Received: from 6a8281486e01 ([183.241.215.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3640dd4sm1260483b3a.41.2026.08.19.23.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:14:05 -0700 (PDT)
From: Saul Freedman <fre3dm4n@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	mtosatti@redhat.com,
	kvm@vger.kernel.org,
	Saul Freedman <fre3dm4n@gmail.com>
Subject: [PATCH RFC 1/1] target/i386: skip ICEBP before reinjecting #DB
Date: Thu, 20 Aug 2026 06:13:55 +0000
Message-ID: <20260820061355.196465-2-fre3dm4n@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820061355.196465-1-fre3dm4n@gmail.com>
References: <20260820061355.196465-1-fre3dm4n@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KVM handles an ICEBP trap itself when userspace debugging is disabled:
it advances RIP and queues #DB for delivery to the guest.  When hardware
breakpoints are enabled, KVM instead reports the #DB to userspace before
advancing RIP.

QEMU currently reinjects that event without advancing RIP, so the guest
returns to ICEBP and traps again indefinitely.  KVM_EXIT_DEBUG does not
preserve KVM's exact ICEBP classification, but ICEBP has no mutable DR6
cause bits and is a one-byte opcode that may be preceded by instruction
prefixes.  Use those properties to recognize the instruction, advance RIP
past its complete encoding, and reinject the trap-like #DB.

Also convert the DR6 value reported by KVM_EXIT_DEBUG to the exception
payload form expected by KVM_SET_VCPU_EVENTS.  Clearing the active-low
bits leaves breakpoint, single-step, task-switch and RTM payload bits
unchanged.

The fix was tested on Intel VT-x with a real Linux guest executing a
kernel-mode ICEBP instruction while an unrelated hardware breakpoint was
installed through QEMU's GDB stub.

Signed-off-by: Saul Freedman <fre3dm4n@gmail.com>
---
 target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45f..c02a155 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6240,6 +6240,48 @@ void kvm_arch_remove_all_gdbstub_hw_breakpoints(void)
 
 static CPUWatchpoint hw_watchpoint;
 
+static int kvm_debug_exit_icebp_len(CPUState *cs, CPUX86State *env,
+                                    const struct kvm_debug_exit_arch *arch_info)
+{
+    int offset;
+
+    if (arch_info->exception != EXCP01_DB ||
+        arch_info->dr6 & ~DR6_FIXED_1) {
+        return 0;
+    }
+
+    /* An x86 instruction is at most fifteen bytes, including prefixes. */
+    for (offset = 0; offset < 15; offset++) {
+        uint8_t opcode;
+
+        if (cpu_memory_rw_debug(cs, arch_info->pc + offset,
+                                &opcode, sizeof(opcode), false) != 0) {
+            break;
+        }
+
+        if (opcode == 0xf1) {
+            return offset + 1;
+        }
+
+        switch (opcode) {
+        case 0x26: case 0x2e: case 0x36: case 0x3e:
+        case 0x64: case 0x65: case 0x66: case 0x67:
+        case 0xf0: case 0xf2: case 0xf3:
+            continue;
+        default:
+            if ((env->hflags & HF_CS64_MASK) &&
+                opcode >= 0x40 && opcode <= 0x4f) {
+                continue;
+            }
+            break;
+        }
+
+        break;
+    }
+
+    return 0;
+}
+
 static int kvm_handle_debug(X86CPU *cpu,
                             struct kvm_debug_exit_arch *arch_info)
 {
@@ -6280,13 +6322,31 @@ static int kvm_handle_debug(X86CPU *cpu,
         ret = EXCP_DEBUG;
     }
     if (ret == 0) {
+        uint64_t exception_payload = arch_info->dr6;
+
         cpu_synchronize_state(cs);
+
+        if (arch_info->exception == EXCP01_DB) {
+            int icebp_len;
+
+            icebp_len = kvm_debug_exit_icebp_len(cs, env, arch_info);
+            if (icebp_len != 0) {
+                env->eip += icebp_len;
+            }
+
+            /*
+             * KVM_EXIT_DEBUG reports an architectural DR6 image, while
+             * exception payloads use the VMX pending-debug format.
+             */
+            exception_payload &= ~DR6_FIXED_1;
+        }
+
         assert(env->exception_nr == -1);
 
         /* pass to guest */
         kvm_queue_exception(env, arch_info->exception,
                             arch_info->exception == EXCP01_DB,
-                            arch_info->dr6);
+                            exception_payload);
         env->has_error_code = 0;
     }
 
-- 
2.55.0
