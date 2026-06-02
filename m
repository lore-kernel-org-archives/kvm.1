Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2ED1F0E34
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780366885; cv=none; b=HEL53yztrdqitC2DB1gTXf6aciMp5FOTOanQsnLGizyxVyyxWZ1UfMT2AD7ghfgw57ddVNkOz0q4JMh1I/YFK/m/abrEi7VdaK5fGUU/Ob9Ma/JngaDyQ3/0vdCqM6QJ55Z4fVf8JRH2YL8NDQxp8pLqa6Jm8WvTLwqFGBCjgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780366885; c=relaxed/simple;
	bh=wGNQpiHz1pCNTrrSt5QwXlafi2bZ4HZjwb5jivmh2xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK+0Uw+uTWg0Dux20zk0lPRl+yNneV3SZPlnsrauCyeGJEtu+Q0qoVsyB/5SILdUEWGcYWPPOdR5sjG7fN+jjqlrLkVkGgWZ0VHXuB/1zhav83QxSJtdmAKQCKrL86u9aS6qA95C6CHqN4rpl3sZrTuJ1R08fXn7aShghNXDGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=nadddTCn; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="nadddTCn"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-59f967189e7so698704e0c.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 19:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1780366883; x=1780971683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQDD5JDYiOKnudM+NIwg1Mg02MK+DhBWU+mqdr1mSng=;
        b=nadddTCnFObhptmEKRYUYloRRx5/IT+84aBKl08B/EXnUIyraL4eIiQINZMAAjbro2
         wO566qNKbguVzJZrxdTcqx+4rMqGrnyo2s8hI9NyTgh8VE/0EOFs5dEZABmr3iEGAcvZ
         OTTiLkDq1UDouznUNtaApOFhal4O18aHU9I2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780366883; x=1780971683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RQDD5JDYiOKnudM+NIwg1Mg02MK+DhBWU+mqdr1mSng=;
        b=gzg/YWSBy5BcWW5E3ae3JJcWMFpOruq2yCY4objAA4/V3u5pn7R6kiFQItQLTR+vUn
         oHHU5sbVUL25OiDsk9SU7ryxhxlW8HqAhrV/gJtoW9qbKuk1nL7tbYVIcpLzkq9UlOY7
         QJgR9Pw3Ca2nTHLPeMl6SqrZApKPib8nou2DZ8gx+IFArgors1CMkZ3D9BcSJBIVB+5i
         rrH1u5l1VM7ktffAEqxk9CGEXqdxSbWsb3mZ+aGwF6nlI555mKv8Ywvz3E3SncwsbWBt
         cbEHd6ZbZ8zM5gXCWuzoNhPLZg/V+3IVbFrr0K1udsYF5CitFYReAgq0/IBnhcOLCUqD
         0pLA==
X-Forwarded-Encrypted: i=1; AFNElJ94QQp8RYdOtrjjEOI4uXwu+C9glLJWwELzb+ywjuVDKLTb/6/YPM1JargrA3VFSgyozG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3X3ezlZu865ovdmabF5fJ9g8opq6JoGMYKQFkSDF4tkekgG24
	xbucNLJwzbhAH9KbMaZBWvF4DFIyfpgCRacsKOGqjP95xV4VVin4Le4cm8cGLzrUIDJJGKH9l9u
	xaDRlqcM=
X-Gm-Gg: Acq92OH3MoWDwh7+by+LYL4MtkQNnwfCOL/zT/74fIgwfZ2RMBesZga/As5RdRApKBp
	6b9noPsAFxHB38InspAfp5uf3O7iIKiPLJ2rdjpP4aLaiX/PGEopwzHCa8f/B5iC1VyxzEtuG+R
	938kM7AFOC6H5ZYps99NeouAxjoMeLtoN0ccoyuS42Mg61Cs4sZi1d7vT7q2r//s1Nqu3xvhhIb
	uGXjvHOS2Z/ZZnA6eKAQcPlfjYQGfFBRbZEZm14JVFj9ZbrVgv6JPFJe042tb57RN/JhQrQ7AEg
	c9ZljGUHQkT+DbsnS4VrrPh+wtMVoVNKQyL9NGw2M1jyJNR4PFigzrLgrjjQMo81cEw70S8MRzo
	ouiNXyXq5ynRQYsZNEp0SEO53ncpzz3HjjI6zyW/jIPudvaS7MOiKH/2Jj2LM7C+HZXzc8iaw2Y
	5DFE0REOXCf6/hIiktF9nipIP8UIEfu8zCbS/XKg==
X-Received: by 2002:a05:6122:4f91:b0:56f:6cc0:681e with SMTP id 71dfb90a1353d-59bee971799mr7376380e0c.1.1780366883051;
        Mon, 01 Jun 2026 19:21:23 -0700 (PDT)
Received: from tarski ([179.105.152.38])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a1c3c784a2sm3648243e0c.15.2026.06.01.19.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:21:22 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	zhao1.liu@intel.com,
	mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [RFC PATCH 1/1] target/i386: Add support for KVM APERF/MPERF passthrough
Date: Mon,  1 Jun 2026 23:20:48 -0300
Message-ID: <20260602022048.752453-2-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602022048.752453-1-anderson@allelesecurity.com>
References: <20260602022048.752453-1-anderson@allelesecurity.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for exposing and enabling APERF/MPERF MSR passthrough
for x86 QEMU guests when running under KVM.

The Linux kernel supports a KVM capability allowing the hypervisor to
disable read intercepts on the IA32_APERF and IA32_MPERF MSRs, enabling
guests to track effective frequency directly without VM-exits. QEMU
currently lacks a native way to request this capability or expose the
corresponding feature bit to the guest.

This patch adds the `aperfmperf` feature flag via `FEAT_6_ECX`
(CPUID.06H:ECX[bit 0]). To ensure safe tracking across power states,
the flag ties into QEMU's existing host power management framework.
When host CPU power management is explicitly requested by the user
(via `-overcommit cpu-pm=on`) and the `+aperfmperf` flag is provided
to the CPU, QEMU will invoke the KVM ioctl to drop the APERF/MPERF
MSR read intercepts.

This implementation allows guest operating systems (such as FreeBSD
or Linux) to dynamically calculate CPU utilization and turbo-boost
metrics without incurring performance overhead from hypervisor trap-and-
emulate loops.

Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
 target/i386/cpu.c     | 17 ++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c..bd9131dade 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1544,6 +1544,21 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .cpuid = { .eax = 6, .reg = R_EAX, },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
+    [FEAT_6_ECX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            "aperfmperf", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = { .eax = 6, .reg = R_ECX, },
+        .tcg_features = 0,
+    },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
@@ -8770,7 +8785,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         /* Thermal and Power Leaf */
         *eax = env->features[FEAT_6_EAX];
         *ebx = 0;
-        *ecx = 0;
+        *ecx = env->features[FEAT_6_ECX];
         *edx = 0;
         break;
     case 7:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67e2ecf325..87864969c7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -700,6 +700,7 @@ typedef enum FeatureWord {
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
+    FEAT_6_ECX,         /* CPUID[6].ECX */
     FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
@@ -1232,6 +1233,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_XSAVE_XFD        (1U << 4)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
+#define CPUID_6_ECX_APERFMPERF (1U << 0)
 
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8..ca722ff9e9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         }
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
+    } else if (function == 6 && reg == R_ECX) {
+        ret |= CPUID_6_ECX_APERFMPERF;
     } else if (function == 7 && index == 0 && reg == R_EBX) {
         /* Not new instructions, just an optimization.  */
         uint32_t ebx;
@@ -3291,7 +3293,8 @@ static int kvm_vm_enable_disable_exits(KVMState *s)
         disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
                           KVM_X86_DISABLE_EXITS_HLT |
                           KVM_X86_DISABLE_EXITS_PAUSE |
-                          KVM_X86_DISABLE_EXITS_CSTATE);
+                          KVM_X86_DISABLE_EXITS_CSTATE |
+                          KVM_X86_DISABLE_EXITS_APERFMPERF);
     }
 
     return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
-- 
2.54.0

