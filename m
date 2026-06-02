Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E13E1D17
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409103; cv=none; b=pwZTwbEbheB8q6FOZX5FC48GMXj6uNm5jG0k63rtUMMZpN2tzoOWABG7jD6vmbG5B8Be+QxLHeEugnBJtASwaYAzUoUlp2yRjbDlzoKZUHe0yjz8HNPDMH0FVp3xOsb+cAtrXkjuQHw/mH/epitD2w/ALQHeuKFmyaaErOmVVGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409103; c=relaxed/simple;
	bh=oSQBC1wXHNLRU+Aw1J7HRYcdfDizv3RRc/9t993TbzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8uZQ5B3Rrejm1CRfr3Lrfxy8VmdR44KyqRKUnZK8y586kAKSOrJqzta206S0wOtwiEv4zfXPI9Y7Dumoy+aSzWoytAN9QUrIDbpfj2cJdrYFQwZ7WJNQV43pps18CkDdiTjTJp2GY0CV5vf/pYpzINAzOW5vED6ti1wh9YNVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=UvICAdJj; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="UvICAdJj"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-963ebce7076so383303241.3
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 07:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1780409101; x=1781013901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmSaH4fUuZZEN3sgO5R99mha2OHiYvLyU1oJPcEKSh4=;
        b=UvICAdJjnFnOoj8LWOkm0i06MK7DkfhSFBty2uUBxM8t4KFLGDCmcH6ksiAWkhsQf+
         ZIpyVui3+m08rPPzM5eHRGtpNwBcqJ4cQDY9puy5CDqPHqiaIff7acXfyAZs4eUcHGha
         a/agWir8Q9iuSXUvA9CgWeeaCmV8m8NaBRkts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780409101; x=1781013901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CmSaH4fUuZZEN3sgO5R99mha2OHiYvLyU1oJPcEKSh4=;
        b=aYspxu6dv7NJSdNtqqL/v0eIVz2EWlST30riTS1vzbGVvIVhNQmoQxfFNn5Gt4XH3e
         eNZs5tCLb6Avr2Mpa2FJm2rF+VEqKHrIr+RykgdkvZg/jQSsYFC78327AavT0zJBlP+M
         b6weYPACUmBfLoGe7+dXIDz8jKOc9SmgVMR+Oc+yhwMyYGS48MGJyMlk0YAlM1Q5nvIg
         Do7GL+tAhc2JJme/VInYNx6TAiolvjRKr0GKH/aOyBbAyTSJl1mAUPyvQHAic8Kfbaxo
         x6KFAaMQ5C8XSAQumh7EdEenphtRVjoknua+liThvb7flQfhFPrRAic/J3Jtp1AxUshw
         7ZgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dGGhu4UUS176BySKtTG5I7FTPCHQl0AUME2Mf7B+qzO/PIUsdWRknYGdH7dsgjCv/2Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrIp/6eq8r3bnu5H9fqbP5dhvOwpy3tEhFOAI3oRbrjCkdXFiQ
	2T/nQm7DFRyOd0/HnnlYZCxhM2IAAATokcmYkK/f53iJZNeP3VjI/3j7jmyrjwxxVmo=
X-Gm-Gg: Acq92OEe/BteZCWdZeWfhL5X43LE8gVzQh1HQPyQUDiPMDgvIgVgzZdfYiTLu5+1hR0
	OaHk2IQpBr5SpKE7tQ9psuPLuQi5+Q4dV2SSceNbevsGlaw/5s7ygmCr/GVLw+7oY8R1i1yblCU
	n8NNAqu9ZaQtj3hIYIjL9EJ5rN+/Pieedjx2od5SpHI2AI20A44HQXuG1csUHrz45mNu7R+C2hG
	kC60EyB+YXO75QdjvWp0BSvH9lRr3CR0QObKnrCA1Xh1e21KjaQuja2W3R0up1v1TnzomHi277A
	qHdW3f3GANe1PDMsYfRfKjeHr/tXoxWsJA+yH0Zh475DodkvK/9+42HA7WmeDQRnqFkkcUYhllN
	VXPX6Jtk45MCxaBvg+cwQWGzpFM7jCIBIpcPd4GprGwWMWiIfGBsi4H0k4CPuVD75ztvw/uPIt6
	IlIL64EAXmAR9fuMMWSvRZu/523ATKCasRcrDYqw==
X-Received: by 2002:a05:6102:1526:b0:602:a9f3:74d8 with SMTP id ada2fe7eead31-6c69806f3bamr6319981137.25.1780409100964;
        Tue, 02 Jun 2026 07:05:00 -0700 (PDT)
Received: from tarski ([179.105.152.38])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6d1ff3909b3sm6097602137.6.2026.06.02.07.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 07:05:00 -0700 (PDT)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	pbonzini@redhat.com,
	zhao1.liu@intel.com,
	mtosatti@redhat.com
Cc: Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF passthrough
Date: Tue,  2 Jun 2026 11:03:47 -0300
Message-ID: <20260602140348.774203-2-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602140348.774203-1-anderson@allelesecurity.com>
References: <20260602140348.774203-1-anderson@allelesecurity.com>
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
Changes in v2
- Added migration flags
- Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-anderson@allelesecurity.com/

 target/i386/cpu.c     | 18 +++++++++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  5 ++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c..544738d406 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1544,6 +1544,22 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
+        .unmigratable_flags = CPUID_6_ECX_APERFMPERF,
+    },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
@@ -8770,7 +8786,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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

