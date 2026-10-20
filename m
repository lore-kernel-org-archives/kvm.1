Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493517;
	b=F7DBKmghTCRqWqK7x9TUCqBmCezT0bdMnqnyp9IaRhyUWj8qrhHU5oS2tx3YtxYMqzsd
	 bYH7pEj0AUMHTYNgGFwb1uM0KghxVpZxXo8f3Ne5ZM1IF8q+m8O0gPKuulnM1Ue7LUVyz
	 ea4yBvVivzQjNTeso0VVWmgafW2TvuX0vdNSv4OPny570FghgCauNJyu1d9Ic6tOsvVWJ
	 LE4yOUjcpfQhPWU2aRaWEGF2Uzm/BqxdDF/FT79iOe/JntRi/HlQ/14OdhWtqp8ks8EqL
	 nP8enHM8p32oE20e0EphBYen0SoMLcSXdL/kVz48VZ2GZvtJi6r879acI4mTrOvlXWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Ko6yZh9M1s2VW5tIdG2OCTSHQVjujibVM95DZEJ7phw=;
	b=M4ekcrzI6q9rXXQ0dAbfmBZTPiiWhRwIy7WvQ4nBWRoK73dsUd9PAYMAsur/oxAPi1SZ
	 iKVMFvBuzR2WJzjyz9mdeR5hNiHhkAPkZoFLEjmTI+L1hxZd2Q6yRNdbhZoppE1AyA9vq
	 bm0/hDGbqM6HSnRaLhpjBxK1xpRdQ4LteE6rMNGd4+KVIqg2UYQQeSL0r340Pkbp2vrv1
	 jtc6Ugowd64eSc+2qjg3GV2nmH/25fvaIVTb8QByVSO27ytyo4DNR6y1ovWMQRx4ripaq
	 iREoDIpmEbQyE4X1kHXHsihMvxT+9eRKoJ2jRe26a/k5NWpI67dkgvo0sPjgcyRZTYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PoXPZ8YD;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BF60A3819
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499BF60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PoXPZ8YD
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c45111bebso1912461f8f.0
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493515; x=1793098315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ko6yZh9M1s2VW5tIdG2OCTSHQVjujibVM95DZEJ7phw=;
        b=PoXPZ8YDshKNfSGDlFq54ZiT3REVhQWlWmpKaOqkkSRW2y0KUG7T0pSmqI70Pjvzf4
         v7NU0g9SBvCOmH/WzR6sfC+RSt2ZEmQpseGvn2Sy7EymxRoDgUu0OlGtIDAQqEXl0KVM
         mItupb7FHHXFQSx+wYmsuxCBlq5po77ewuTgvGdG8PeQ8Ne9U7jFfDp1mJlh54wbUguD
         wlQdDkx/O6Qotwj3khhhQd/iLkl9upDenxPqemFSO9gDsEAHT19avIpjaQMZdOqD3IR3
         /4L0xzrW9sQexqppsDPeu/AwAtFBw801P2m1GfLKD/IYW2KtQTjkTvqQnc/FQo+nsrL4
         0Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493515; x=1793098315;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ko6yZh9M1s2VW5tIdG2OCTSHQVjujibVM95DZEJ7phw=;
        b=TGMrKthPJq0u9HDS1Q5PAa1rCdsqAzz/HLAvUnKNU1VIC4FJIeGwpd9dNryIOwwJoC
         AM8zkgIxc6GsocstcBX1ZjAAoRjn+e0NSSJu8v5KmUAeEdMZpRJA9ZsEND6cgoj3FA8S
         xpj0Di1sfsV62ut48mDVUYH8qLg2e831tIPizpEhmytZt15OrsHayXfRckKMYNpB94WO
         nQm4Vfsx+9IrwyFUv3H+tNpSWJsrRamEx5iqIDlE4TynuyN+dTJ1KiLfpA+zdsRX9MzV
         mNY92sSggmgvB56Oe71DqlWa0KU+5dHq6M6O3sPscJXWAhB2cKvRR7F0tHvmPwnUb9AX
         vzHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTiZnwi8dhbw3rYhYMhfbSJyD0a9dXz3VmmfSfT09gSdh8ycsid9lILfnjR+3h0Dv7bHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnq5VAHW7whghHRnb3dwFRIMZVmoyvBCjMd+z5Tc/c98XJT0QZ
	wc84ZUiP890/FlfxL/nXDDxxpHIRPQz0rlNmn3howx4i7iiPPh57R9JYvBdqqXcnbUY=
X-Gm-Gg: AYBFou1AdVvQScf9wR0E5nMd9ChML6mAXjn29a+150iNG2nQ0ETEtT841Y/rG1S+kBp
	oNeR4xgiVQgqENX24PFMq8ChgyNDtOw1v919Wm+W+en5FMaIawVKy82PiQwjS0zfHrsqk4DUzTR
	Vpu3A5Ezf8TV/n9NzPqarpryF1x2mPHx/Srpxo93cu3Wg5QaHkz4bsGoEI9p31RfUxZzKDcOvUr
	ogmzIHLcUpsSMbHmDCgQSiQhrdjhD1rhsB1xWe7SRZEGymVBzymWZQoNsMAIDZ+kIuoSYg8d9xm
	QhruUfs11NJnE1WMzEEHXlKWJtu3tUEQPajxJNwRISHpV9ar0m75D2HWicS4LFEWiPxv2o+T3Nj
	QdJDglWk/rHrvgyuXcyFU36LOpwHIEB6upKAm2xHxJKdrjLH1Q1E3WT6KdlCVatMJ0t0PcRGTsd
	BVUJzFYdsaIDpM8KGkV5V3RFghEBnj5cnG4EHQ7YlpAZiC1S0GC0Zp6d6ytjbA/66nbuGYEQ==
X-Received: by 2002:a05:6000:29d2:b0:48b:f93:3b87 with SMTP id ffacd0b85a97d-48e07fc7a04mr13714326f8f.30.1792493514603;
        Tue, 20 Oct 2026 03:51:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d80f9cdsm5176970f8f.11.2026.10.20.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:51:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 95B4C5FA43;
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
Subject: [PATCH 22/23] accel/kvm: cache KVMCPUOps
Date: Tue, 20 Oct 2026 11:43:16 +0100
Message-ID: <20261020104320.3686723-23-alex.bennee@linaro.org>
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

Doing a QOM cast each time we need KVMCPUOps is overkill, especially
considering it is a single static assignment when we configure the
accelerator. Cache the value on kvm_init_vcpu and use it.

We also assert that anytime the system asks for KVMCPUOps it should be
at a point we can honour the request.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/accel/kvm/cpu-ops.h | 13 +++++++++----
 include/hw/core/cpu.h       |  3 +++
 accel/kvm/kvm-all.c         |  4 ++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/accel/kvm/cpu-ops.h b/include/accel/kvm/cpu-ops.h
index d43bc845ad5..075bac1d494 100644
--- a/include/accel/kvm/cpu-ops.h
+++ b/include/accel/kvm/cpu-ops.h
@@ -156,11 +156,16 @@ DECLARE_CLASS_CHECKERS(KVMAccelCPUClass, KVM_ACCEL_CPU, TYPE_KVM_ACCEL_CPU)
  */
 static inline const KVMCPUOps *kvm_get_cpu_ops(const CPUState *cpu)
 {
-    if (cpu->cc->accel_cpu) {
-        KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(cpu->cc->accel_cpu);
-        return kacc->cpu_ops;
+    if (cpu) {
+        if (cpu->kvm_cpu_ops) {
+            return cpu->kvm_cpu_ops;
+        }
+        if (cpu->cc->accel_cpu) {
+            KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(cpu->cc->accel_cpu);
+            return kacc->cpu_ops;
+        }
     }
-    return NULL;
+    g_assert_not_reached();
 }
 
 #endif /* ACCEL_KVM_CPU_OPS_H */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 456154df6f6..1e164036286 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -473,6 +473,8 @@ struct qemu_work_item;
  *    ring is enabled.
  * @kvm_fetch_index: Keeps the index that we last fetched from the per-vCPU
  *    dirty ring structure.
+ * @kvm_cpu_ops: Cached pointer to the KVMCPUOps table to avoid QOM lookups
+ *    in the run loop.
  *
  * @neg_align: The CPUState is the common part of a concrete ArchCPU
  * which is allocated when an individual CPU instance is created. As
@@ -554,6 +556,7 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
+    const struct KVMCPUOps *kvm_cpu_ops;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5189cdc6a01..041113ed9b5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -746,6 +746,9 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
     KVMState *s = kvm_state;
     int ret;
 
+    assert(ops);
+    cpu->kvm_cpu_ops = ops;
+
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_vcpu_id(cpu));
 
     if (ops->pre_create_vcpu) {
@@ -4111,6 +4114,7 @@ int kvm_on_sigbus(int code, void *addr)
      * we can only get action optional here.
      */
     assert(code != BUS_MCEERR_AR);
+    assert(first_cpu);
     ops = kvm_get_cpu_ops(first_cpu);
     if (ops && ops->on_sigbus_vcpu) {
         ops->on_sigbus_vcpu(first_cpu, code, addr);
-- 
2.47.3

