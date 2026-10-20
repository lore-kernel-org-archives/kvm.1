Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493017;
	b=N6oU4JmxW/Lw61O9NgVODW3PanPU7oW8w3Ryc9pILuwnZJGd8Sh0jBec7Ml3hbpSGxzT
	 BET9E/Sn5DrItduuXwjSFByBW0srr2FLHHJ6tgGy2Yx4JElaPuXvx/OQl+kzz0624WlY/
	 drg1rx30B5YMj7TIsa/23N9sofmuDrMAXPDPZ48gt3z820jX4EsjRvGF7E4OqbhoYhUwo
	 u40iprPLh8QyQNszDL5xNPrzfCXVHvk/wlL2KqnU2OfMlkHZlkQDoj7/2uRf2RbG46LYm
	 vT+a+D28vZZUlNqiXISoi4t6ymOZlFjTyTKM0T1wGxnWYMnEIs9Bz68+kQZ1KSs5Ymw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3nKJ8HDcn3r8uziE9nKrYpZyKDrGZlceKJ4Jq+Ujj9I=;
	b=HGuRD6WwOo2CSrMCyIEbX+bdfp4Hci9Xa7Wx4dPtJIqSSJZtimEKa0RKXQWvzNTzE8Td
	 Pcjq76WPu9VS5MO3XYWeVlpIqZMDJWGXr9xwaRRtKWY2ARn9dk34ywFyYea3u3/16MwSu
	 Y4H6fvbyW6mBBQSc6nz0f77ZhnOFHbhljVKVoIWfY/Uxz2g1dlGE1NiIIOQGVgbzmm8Lh
	 0mkfk/a6k9t5nJ/95wgMZffNDltEFJiP9muCZYDOncaPhCXjYbiWOGNtC41wngqk0er+R
	 P4h3t1gswIE4+m5+dN2xdxP83yNdDTaTw9ileGbwz2nyPJypsks3PaK0MEMHVfy20Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pcrcx1fw;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066460A4AFC
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6066460A4AFC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pcrcx1fw
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4be28b82so2372310f8f.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493016; x=1793097816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3nKJ8HDcn3r8uziE9nKrYpZyKDrGZlceKJ4Jq+Ujj9I=;
        b=pcrcx1fwj7G//JPU9EkcF16Vuz/kzOsihfjuSClD9XlQqWjqSd/viC6AIHsDgvgNCA
         em5oeP91CODEgCDc/0PRVlEJBdBaBIfoU0BWlRLPi65MjqefnTYYirSOdgPtrjsQe6po
         2EmZes33zArGXL1SKXAGcOFH55Ha97boQ1/EHOdyEPWZm//JYRG8dTBeTU7IntAcGLB4
         +0PLL7053sF5R/Ad5tXsr1b6lyuVrtmAae1RPRIoubAQvYwCtGUm9oTd+1qFoEZppxwX
         3nAQNv0f9lhp06Rgs14olmMQw5ODheVmAVALIFM1halR6+GqJYxmzooRbdP8tF247g7q
         3Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493016; x=1793097816;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3nKJ8HDcn3r8uziE9nKrYpZyKDrGZlceKJ4Jq+Ujj9I=;
        b=u+c2nIUtAYK2uNKAcFOu5VBQh88NfbftDSjN8QUl/NuHeAKng7Lt/uagu+QGkiucDd
         AwdmzIXvRfeSVvPNZX0uU5kxo4RkDdQ7Kl85uV/5gavycTabqyWFcKSb58DG4Q1MJfFB
         qpUvRrlehJg5dhF1CH4loXV3oouAsjuonUT2vHkt4ZmrmSZfChvZpg1+gQ4nx/ZDBle4
         BbU0vTL10JP2kRgksQ1kplDnMVfwvLsZZFrZ7ZrbU9/BBrg5kkZYcE3tDTjLDAov3stf
         Qut4ixsxSmZdVKV3SCqSp6Kc9SqKEEfhPBA/bg8BZfsZqFIj8a6LgdMzsI8m73cMzfmh
         8H0A==
X-Forwarded-Encrypted: i=1; AKwUvBzjeZ9sb2ez1eZtJjTY0cYeSKGJMCNoK+0m7su3GRreomVge/16hdQIv4u/CCowrcTc3Sg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5sEujoOKGrz0UhzsC87DJdwHehg0PCmmxnylS3xbHikXCPGwQ
	A3diUEafYk7OCwQa4MPA/T+eYNoce5Xmo2wsQH5WgJVnwgOon9soS69qugfKjQRk/t0=
X-Gm-Gg: AYBFou0Ydvfd+6Yx36qDLhjGob9nz7FxFwv/lm0wynId7R1+FUFpHMgSnAVpHMSZEdS
	8xpPkoVMh/W8hm80n4EDAa3e8h9+YyDu1Ob+ugu1ktIO7G6ZLy55KTSrGVEdz0La/plNYn38v2y
	NlUhurKmcL2fgg5L4j9E2wzsr/ZauT1jrOw0nKq2++sLGgY15YtTkWNwL4DMIaI83SFLDIzgX19
	g3dSWw5C8ZkeEljHWfMFVAcPOwdIcrvDD9gAbEA2H6me3MfRIVm2201RYIQNg18NF3W/NMFyzKp
	6Al21tWD1bXOkT/C/vdaUldC8iOZJZpTb7g7L5geG7EiXehYYX1HLO5Llc/yIyjWo2Zh9sejL6Q
	XyHDJ7MSBfVbVs43XLqnjPhsWzVYMuTFZdWxfP/WwPnCDwWf3iqUE6ncPChUv1aX0h0+DBCu3/N
	2kNCbSxGaA8ZWqVj1Cr43EYsTH4UQKIVIT0sUlxTvsrCI7y02wDFPcwrOGcuF73pulWgMnuw==
X-Received: by 2002:a05:6000:5ca:b0:48d:ff06:c626 with SMTP id ffacd0b85a97d-48e07f9eacbmr20650207f8f.35.1792493015656;
        Tue, 20 Oct 2026 03:43:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80fafdsm5465775f8f.9.2026.10.20.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 015BD5F9E2;
	Tue, 20 Oct 2026 11:43:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Song Gao <17746591750@163.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Bernhard Beschow <shentey@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paul Durrant <paul@xen.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	David Woodhouse <dwmw2@infradead.org>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	qemu-ppc@nongnu.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	qemu-arm@nongnu.org,
	linux-edac@vger.kernel.org,
	Glenn Miles <milesg@linux.ibm.com>,
	Chao Liu <chao.liu@processmission.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	qemu-riscv@nongnu.org,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 19/23] accel/kvm: remove TARGET_KVM_HAVE_GUEST_DEBUG
Date: Tue, 20 Oct 2026 11:43:13 +0100
Message-ID: <20261020104320.3686723-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020104320.3686723-1-alex.bennee@linaro.org>
References: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With guest debug and breakpoint handling now migrated to struct
KVMCPUOps, accel/kvm dispatches dynamically via ops. If an
architecture does not support guest debug or breakpoints, the
callbacks are simply NULL and common code handles this gracefully.

As a result we can drop TARGET_KVM_HAVE_GUEST_DEBUG. Remove it from
target configs and eliminate the #ifdef guards.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/targets/aarch64-softmmu.mak     |  1 -
 configs/targets/i386-softmmu.mak        |  1 -
 configs/targets/loongarch64-softmmu.mak |  1 -
 configs/targets/ppc-softmmu.mak         |  1 -
 configs/targets/ppc64-softmmu.mak       |  1 -
 configs/targets/riscv64-softmmu.mak     |  1 -
 configs/targets/s390x-softmmu.mak       |  1 -
 configs/targets/x86_64-softmmu.mak      |  1 -
 include/system/kvm.h                    |  7 -------
 include/system/kvm_int.h                |  2 --
 accel/kvm/kvm-accel-ops.c               |  4 ----
 accel/kvm/kvm-all.c                     | 15 +++++----------
 12 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index d34aead41c4..6f60ca6505c 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 38a8f85201f..2eef68dc55e 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=i386
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-32bit.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index a425b3dbaae..3b3a9021980 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=loongarch64
 TARGET_BASE_ARCH=loongarch
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= loongarch-base32.xml loongarch-base64.xml loongarch-fpu.xml loongarch-lsx.xml loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 867898bd47c..c47887f8992 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -1,5 +1,4 @@
 TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power-core.xml power-fpu.xml power-altivec.xml power-spe.xml
 TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 10d7a2681e7..8c6dc84b821 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -1,7 +1,6 @@
 TARGET_ARCH=ppc64
 TARGET_BASE_ARCH=ppc
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index a10dc03c04c..18b674230ab 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 478988e6d4a..6a629c6479e 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=s390x
 TARGET_BIG_ENDIAN=y
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index c7f8746b4f5..491173df466 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -1,6 +1,5 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
-TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= i386-64bit.xml i386-64bit-apx.xml
 TARGET_LONG_BITS=64
diff --git a/include/system/kvm.h b/include/system/kvm.h
index cfc0144d9a5..1a52e7e5261 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -232,14 +232,7 @@ void kvm_irqchip_change_notify(void);
  * calling down to the KVMCPUOps::update_guest_debug callback after the generic
  * fields have been set.
  */
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
-#else
-static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
-{
-    return -EINVAL;
-}
-#endif
 
 /* internal API */
 
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 0876aac938d..9d1d3fd3deb 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -113,9 +113,7 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
-#endif
     int max_nested_state_len;
     int kvm_shadow_mem;
     bool kernel_irqchip_allowed;
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 445d7d7f545..ab10de6ac30 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -86,12 +86,10 @@ static bool kvm_cpus_are_resettable(void)
     return !kvm_enabled() || !kvm_state->guest_state_protected;
 }
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 static void kvm_update_guest_debug_ops(CPUState *cpu)
 {
     kvm_update_guest_debug(cpu, 0);
 }
-#endif
 
 static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
@@ -106,12 +104,10 @@ static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->synchronize_pre_loadvm = kvm_cpu_synchronize_pre_loadvm;
     ops->handle_interrupt = generic_handle_interrupt;
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     ops->update_guest_debug = kvm_update_guest_debug_ops;
     ops->insert_gdbstub_breakpoint = kvm_insert_gdbstub_breakpoint;
     ops->remove_gdbstub_breakpoint = kvm_remove_gdbstub_breakpoint;
     ops->remove_all_gdbstub_breakpoints = kvm_remove_all_gdbstub_breakpoints;
-#endif
 }
 
 static const TypeInfo kvm_accel_ops_type = {
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3bd61264a7e..5b96fac513e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2964,9 +2964,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     s->sigmask_len = 8;
     accel_blocker_init();
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     QTAILQ_INIT(&s->kvm_sw_breakpoints);
-#endif
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
@@ -3077,7 +3075,6 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_vm_attributes_allowed =
         (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
     if (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0) {
         as->gdbstub.sstep_flags = SSTEP_ENABLE;
 
@@ -3088,7 +3085,6 @@ static int kvm_init(AccelState *as, MachineState *ms)
             as->gdbstub.sstep_flags |= SSTEP_NOIRQ;
         }
     }
-#endif
 
     kvm_state = s;
 
@@ -3832,7 +3828,6 @@ bool kvm_arm_supports_user_irq(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
 }
 
-#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc)
 {
     struct kvm_sw_breakpoint *bp;
@@ -3869,6 +3864,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     const KVMCPUOps *ops = kvm_get_cpu_ops(cpu);
     struct kvm_set_guest_debug_data data;
 
+    if (!ops || !ops->update_guest_debug) {
+        return -EINVAL;
+    }
+
     data.dbg.control = reinject_trap;
 
     if (cpu_single_stepping(cpu)) {
@@ -3878,9 +3877,7 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
             data.dbg.control |= KVM_GUESTDBG_BLOCKIRQ;
         }
     }
-    if (ops && ops->update_guest_debug) {
-        ops->update_guest_debug(cpu, &data.dbg);
-    }
+    ops->update_guest_debug(cpu, &data.dbg);
 
     run_on_cpu(cpu, kvm_invoke_set_guest_debug,
                RUN_ON_CPU_HOST_PTR(&data));
@@ -4022,8 +4019,6 @@ void kvm_remove_all_gdbstub_breakpoints(CPUState *cpu)
     }
 }
 
-#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
-
 static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 {
     KVMState *s = kvm_state;
-- 
2.47.3

