Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016416;
	b=jkFFhBc09uGrfs427mJu9/m8qAZB44x65duSHmsSsdTGppCc7xRNo1DNAHQPYy/uEwbX
	 XcmK43gh1N9pfEQhdetLviut4dBxxa9bL1x483qbgxdgiZJcl+1o+wtbFs/E91WMu/wsC
	 1bGsz3NvFfBkQeRh1RnlXpLj/UEsMuzJmcgewgQFdUjx/0cX0YI23Wj1vZaCCNBHfOjsh
	 WbAF9igXtBMdSEx1sfv5ItQiZuqRWVFIBpfy67qyGnl4emUbBofMNtSipdbVqfldv8d0s
	 alQW/jqJ8DP3nd7vBw2nrNsahfNkUzQcxjCLphdGCWqXYYB2ww5SwJpiPyW13dxyr0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rQufxoiW6mBGjeYNxiqBhROlIjKV0eamLrpxHGbovrE=;
	b=BmoRhr1VRghrsaFHPtGexxoNKMZAOYbxTdzjooU5sWgOM9mkCCi/c+4Pr3kK1LSWAtcL
	 RBnT6HA2QaOFQWOMTTYsLYRIJ3Zzwm8jg62rJ77XE5/0Z12j9zT4rdc6g04w+CQ7Pm/5m
	 8Gjo/EPufJ98gQB5rjsW8sURTefv9TetWTKRZ9sKR1oBBou3Lmp8ZL19iKoNC04o5+POa
	 3VUHBqMXgMplR5sD1O4jST3Bm9c0UTv3GShSqoGbqgylTXMJImKrEUugWDYramtNz0FSI
	 qby9R02hzzegH4qmjNmRHjkp5sLZk+dl+/Cnm51v4jKyhYIkadeV/TaR327xSN9PhmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=allelesecurity.com;
	spf=pass smtp.mailfrom=allelesecurity.com;
	dkim=pass header.d=allelesecurity.com header.i=@allelesecurity.com header.a=rsa-sha256 header.s=google header.b=LtfJaHB3;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3266A606A32C
	for <kvm@vger.kernel.org>; Sat,  7 Nov 2026 01:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3266A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=allelesecurity.com header.i=@allelesecurity.com header.a=rsa-sha256 header.s=google header.b=LtfJaHB3
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b300713befso10193837b3.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 17:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1794016415; x=1794621215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rQufxoiW6mBGjeYNxiqBhROlIjKV0eamLrpxHGbovrE=;
        b=LtfJaHB3aLYcDAs8dFaL2lcdom+8vb3iEi2HAx32HjhSJTgxXYgHKkHUOqONSdRc/C
         hF3baeFYGqWumZis3DvYDAYQEhdQoPA+aB/esf7KlXETIRBPaUl4QemAkatfOrulHUDt
         u5jef/ejmo06kOJKeeq/pa+3hU4ArR8Ww9BK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794016415; x=1794621215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQufxoiW6mBGjeYNxiqBhROlIjKV0eamLrpxHGbovrE=;
        b=YARFRsZBV45V1YyA0ogJ8PuyoDBDcrrqmToq6WrxIUJZZz1kPAuRzOnhlznf01oFcS
         C5vsK7DSosY5qApRjaLYHCtID5goJ9iRveG6AOJsDyM8wJOfGjucCnAB1LKgQBfA4k2V
         j3f4B88GPoq8q+ZyGfPLSWq3NFsXJRuT+K7i1sMUCdhLhhR5+kFi9EGgjxvR+gCA4Llu
         Mj0fPv+L1tBDvEXU9yczvclfslBdro/sCTcARjNH2TvbKO+NnizeVt6N0fUzPtuIKAHX
         WVp5WqGB42YJajn8SmPWO8z8by4vE2v9AwfD6g2kAOmoibGUbp2k3LqJYQazDXDSQ+/k
         /XIQ==
X-Forwarded-Encrypted: i=1; AL+hErEPhCNqP+uINGBMxcCaPex8o6mL13PDoearCH2iuwUUGp1h9uDK9A1hdCqJq5u+/unppwc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rvKep1vaTCiOD0/XLLKNPqbxO83VSGQnOsg1wNt3Sp5H+2xq2
	cRxiJVOIEXkij/ZspPYbTZgoo1XdCUtKb3IpjHW7J0fZapCbw6buB0fyI+QVhX7BifM=
X-Gm-Gg: AYBFou2tn6k24Ikc0dVhvVEO8n+0YJVljppoe0fTbVFHZVQ0mIHKAauxk/BOyQSPh8S
	uFDd3mGuKsaNIWVfNY/MD7fslb0g717URhjMTpkS6QbC0TBbdIKs8vfKRqVW694XK2sFDrACyhA
	WkUnfxQkhCtlAjo0hZUz1NfHh6C1WEIY15QUQ5ZJ0shTT1qH5CxlIBYxvoFx8xgFtjDCeT/fbvs
	Z3sIfPxV7odFOO5q39Fp9f3w91GvOlCdlDzH+h6+MSkmXRajknzQBKBkdPkYGmUCIlkgrtQ/jzw
	FsQ8AZ/YplPPfZZWASzdVTHu3/kp9ABSvDlr7DzUO2vx/0O4xnNyqbVP9chacJbucdLlU/2AC0m
	v+WDhrkfejo89GsqQOcNkKlW1jPMfY5gr08FJ+UKZ0hh3p8+iUJi8fcatoPrI/QQV9GbiSyicJR
	6YioHeMoi4sSBZ/TcMb0lKFcarA8JXlyhku9rTEjuOlqaQBiPXFncDfdy47GqToWnejO31JOQsG
	5YfnnmNYj2U9Dia72LnQLGisr7gpWPMIbVLFvoEyf36hiTuNxrZboLdQXAxP8AlI11ahpofR2N8
	8C6gX1o9WhZNcUQaSdOc+EGSNCWJgTW2xLTwWuwTitb+/uS9c83p
X-Received: by 2002:a05:690c:8d0e:b0:8b3:416:b1b8 with SMTP id 00721157ae682-8b34194a4admr22766267b3.11.1794016415117;
        Fri, 06 Nov 2026 17:53:35 -0800 (PST)
Received: from weyl ([179.105.152.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7fec67sm32336817b3.22.2026.11.06.17.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:53:34 -0800 (PST)
From: Anderson Nascimento <anderson@allelesecurity.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	zhao1.liu@intel.com,
	mtosatti@redhat.com,
	kvm@vger.kernel.org,
	Anderson Nascimento <anderson@allelesecurity.com>
Subject: [PATCH v3] target/i386/kvm: Add APERF/MPERF MSR passthrough
Date: Fri,  6 Nov 2026 22:51:41 -0300
Message-ID: <20261107015141.473255-1-anderson@allelesecurity.com>
X-Mailer: git-send-email 2.56.0
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

Introduce support for exposing and enabling APERF/MPERF MSR passthrough
for x86 QEMU guests when running under KVM.

The Linux kernel supports a KVM capability, KVM_X86_DISABLE_EXITS_APERFMPERF
under KVM_CAP_X86_DISABLE_EXITS, allowing the hypervisor to disable read
intercepts on the IA32_APERF and IA32_MPERF MSRs. This lets guests track
effective frequency directly, without VM exits. QEMU currently lacks a
way to request this capability or expose the corresponding feature bit
to the guest.

This patch adds:

- the `aperfmperf` CPU feature flag via FEAT_6_ECX (CPUID.06H:ECX[0]),
  marked unmigratable and excluded from auto-enable;
- the `aperfmperf` property on the KVM accelerator.

`-accel kvm,aperfmperf=on` makes QEMU enable the KVM capability at VM
creation and report the CPUID bit as supported. QEMU fails to start if
the host KVM does not support the capability. `-cpu
...,migratable=off,aperfmperf=on` exposes the bit to the guest. Both are
required for the guest to use the MSRs.

This allows guest operating systems (such as FreeBSD or Linux) to
compute effective CPU frequency from APERF/MPERF, which is not possible
today since the bit is never exposed and KVM does not emulate these
MSRs. Since the guest reads the raw host counters, pinning vCPUs to
host CPUs is recommended for meaningful results.

Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
---
Changes in v3:
- Added it as a standalone accel option, no longer depending on cpu-pm.
- Added the flag to no_autoenable_flags.
- Link to v2: https://lore.kernel.org/qemu-devel/20260602140348.774203-1-anderson@allelesecurity.com/

Changes in v2:
- Marked aperfmperf as unmigratable.
- Link to v1: https://lore.kernel.org/all/20260602022048.752453-1-anderson@allelesecurity.com/
---
 accel/kvm/kvm-all.c      | 13 +++++++++++++
 include/system/kvm_int.h |  1 +
 target/i386/cpu.c        | 19 ++++++++++++++++++-
 target/i386/cpu.h        |  2 ++
 target/i386/kvm/kvm.c    | 25 +++++++++++++++++++++++++
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 411f28dde2..bff66b2381 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4264,6 +4264,12 @@ static void kvm_set_kvm_rapl_socket_path(Object *obj,
     s->msr_energy.socket_path = g_strdup(str);
 }
 
+static void kvm_set_kvm_aperfmperf(Object *obj, bool value, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->aperfmperf_enable = value;
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
@@ -4284,6 +4290,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->xen_evtchn_max_pirq = 256;
     s->device = NULL;
     s->msr_energy.enable = false;
+    s->aperfmperf_enable = false;
     s->honor_guest_pat = ON_OFF_AUTO_OFF;
 }
 
@@ -4330,6 +4337,12 @@ static void kvm_accel_class_init(ObjectClass *oc, const void *data)
     object_class_property_set_description(oc, "rapl-helper-socket",
         "Socket Path for comminucating with the Virtual MSR helper daemon");
 
+    object_class_property_add_bool(oc, "aperfmperf",
+                                   NULL,
+                                   kvm_set_kvm_aperfmperf);
+    object_class_property_set_description(oc, "aperfmperf",
+        "Allow frequency related MSRs for APERF/MPERF interface in Guest");
+
     kvm_arch_accel_class_init(oc);
 }
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938..651f5e7b83 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -160,6 +160,7 @@ struct KVMState
     uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
     struct KVMDirtyRingReaper reaper;
     struct KVMMsrEnergy msr_energy;
+    bool aperfmperf_enable;
     NotifyVmexitOption notify_vmexit;
     uint32_t notify_window;
     uint32_t xen_version;
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index eab0d5a4d4..ca5b321df4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1548,6 +1548,23 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
+        .no_autoenable_flags = CPUID_6_ECX_APERFMPERF,
+    },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
@@ -8781,7 +8798,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         /* Thermal and Power Leaf */
         *eax = env->features[FEAT_6_EAX];
         *ebx = 0;
-        *ecx = 0;
+        *ecx = env->features[FEAT_6_ECX];
         *edx = 0;
         break;
     case 7:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3945e90371..4b730c5e30 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -709,6 +709,7 @@ typedef enum FeatureWord {
     FEAT_SVM,           /* CPUID[8000_000A].EDX */
     FEAT_XSAVE,         /* CPUID[EAX=0xd,ECX=1].EAX */
     FEAT_6_EAX,         /* CPUID[6].EAX */
+    FEAT_6_ECX,         /* CPUID[6].ECX */
     FEAT_XSAVE_XCR0_LO, /* CPUID[EAX=0xd,ECX=0].EAX */
     FEAT_XSAVE_XCR0_HI, /* CPUID[EAX=0xd,ECX=0].EDX */
     FEAT_ARCH_CAPABILITIES,
@@ -1241,6 +1242,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_XSAVE_XFD        (1U << 4)
 
 #define CPUID_6_EAX_ARAT       (1U << 2)
+#define CPUID_6_ECX_APERFMPERF (1U << 0)
 
 /* CPUID[0x80000007].EDX flags: */
 #define CPUID_APM_INVTSC       (1U << 8)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e29ecaba57..72634d2c3b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -501,6 +501,12 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
         }
     } else if (function == 6 && reg == R_EAX) {
         ret |= CPUID_6_EAX_ARAT; /* safe to allow because of emulated APIC */
+    } else if (function == 6 && reg == R_ECX) {
+        uint32_t ecx;
+        if (s->aperfmperf_enable) {
+            host_cpuid(6, 0, &unused, &unused, &ecx, &unused);
+            ret |= ecx & CPUID_6_ECX_APERFMPERF;
+        }
     } else if (function == 7 && index == 0 && reg == R_EBX) {
         /* Not new instructions, just an optimization.  */
         uint32_t ebx;
@@ -3401,6 +3407,18 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
     return 0;
 }
 
+static int kvm_vm_enable_aperfmperf_msrs(KVMState *s)
+{
+    int supported = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
+
+    if (!(supported & KVM_X86_DISABLE_EXITS_APERFMPERF)) {
+        error_report("kvm: APERF/MPERF passthrough is not supported by this host");
+        return -ENOTSUP;
+    }
+    return kvm_vm_enable_cap(s, KVM_CAP_X86_DISABLE_EXITS, 0,
+                             KVM_X86_DISABLE_EXITS_APERFMPERF);
+}
+
 int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 {
     int ret;
@@ -3586,6 +3604,13 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    if (s->aperfmperf_enable) {
+        ret = kvm_vm_enable_aperfmperf_msrs(s);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
 
     if (first) {

base-commit: 99e6fa0053ba1b1454b8c4446f857c430547a702
-- 
2.56.0

