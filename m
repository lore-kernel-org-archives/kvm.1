Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493007;
	b=Xoqwl/6DMG8KE93HMaqiEdNiZ8/S+DLXg+pkZAmgHfzu56Qe3zgs3iBSJTwKcKD64qg5
	 LLGZWfvxysK4CJ82lSZmzfTE4zWMQ2OLnys9EtmZ40FwI7jBzvI/mvWDwfAi8qcElp0e5
	 +usBxpo7hNPlvAqFrSKCGDgEiuxrRY/tRYgq7bzoyV3PTFIriMcV1t0k0GBBZL2nrXBy0
	 QeY14FV6AMSX1kY7RyCwLSk0PldvUP5wcDkUuJN6Sx2yVTMD6RnF4B3si+YoJHoDqfZB8
	 GXlBUVC7w9QdqLN6f7A9cH2DEv9GcXurQAS4b2/W5/TT11DIAObOCy/PZ8aCaFDI37A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xpvK8hxiiby7P5GAABphDAJ86oAgF7lyRnWJr7JT/sM=;
	b=aY8YJ5blicSqVvTk0BrGW1+qQ8rkifmwesIphNhT/xVmO6xLg/N96wtSUWTRqQ42vrue
	 9VFwYUhAjo8ze/Bp04/vrOAJT7oL56HNRQJjctDahBcyJuGy7quAuXrO1q+ju/gX+lKLh
	 2ky1OHtgA4+hDleSG7OIGVmS0lALO09G7kCsp8w5grKqkXFfohVY1DD+8CA4v/0ya8aWC
	 D7eXSjVXSB7hvYqPVjIeBFGiK85dkIBrA0+gaYLUfKg6O+1reWw3/YA6B3iwQ/ZccrmCj
	 7KjoksQkEzMqsUs8wAw2LX2UzGhVtpNoUdSFwa06B9H2bZ1ZY3Swc9wwQrcS6KwBOTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pfert0Wh;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779860A2613
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A779860A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pfert0Wh
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1592880f8f.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493005; x=1793097805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xpvK8hxiiby7P5GAABphDAJ86oAgF7lyRnWJr7JT/sM=;
        b=Pfert0Whzua5hnm67pqr6YPC0mwWkJwmcvWKLgbCqVMG3ksf2Q8vDW9wZ6LChAIYg3
         0DSk4vxe2edLEJMp0iiS1CTRap1wmBVgSEU/bUN8wWGAKLDzIrcxlKk8HiShahwZ4xbT
         AOCyDpZuiMeQpZR/tbekm0g3mFqVDTJTx7KHxcuEsdS1W2Qw+sTTUCxaoBCdMfxCoLVQ
         bDwSuVzZjpnANTjZZqPWTSfsmI8Ob48tY36UE/kXaH7uSBZozaxORjgpL0ehVQK3aPsh
         TUJ34LcgbWmg2hhw27VffgohZkhtxqS2gy6Lk5x0SyUfAMtqmA74vwgG/P8G5RlmOlJ0
         5vBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493005; x=1793097805;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xpvK8hxiiby7P5GAABphDAJ86oAgF7lyRnWJr7JT/sM=;
        b=t/blgCSw4vfmVHKA5LHX5NF9QPBrg0FTlXkGTyG0WjmAbL6zFHA16HxL2EpCwu7hUc
         puUsznkBgUN+i/DYM8A/ZVBrKkzrdRL6sTX/v8C7GLOiT2OERF9Erqmjgxu8GY95kq8d
         7s6PiuoOdk9G0HR17eHc5YP+mVieC7oMAqrZHWe0jULk30Lr6Exl0k7EUz1dJRWLMCRQ
         2tqXhGPUlm8GNwlJC/GJZi2MpDkvL4pj77wtGBd+5T1L2QwHvjX9Ylyq6xuNgBE6bAHc
         KBH+Q6xMi1iNCVKHgZ847ifbvtxOnLx3Hc/t3iBqUEIC801gi5VKnKywsuEz8VYf4Cyd
         aSsg==
X-Forwarded-Encrypted: i=1; AKwUvBzHLAClFxo7rwvQxOJ27FUcl5nQnKoojyEkDhllHyJJ7SMzbmEe1MSRkWH/UkGt0XnihY8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUiOuhBnN2d6Mb/IXWYBmk+n94LYg98cRec0iiBmAX27bXFaxz
	Zh+Cd5f3K0j7Y/BTuQb0bPUDbI3AeofCMZOw9t1VI2v2KFTlMlbcYLqafANmU346riI=
X-Gm-Gg: AYBFou3bS5Wv/kKB2ast/R0THbJ7j3N8QCaVTXdOKnhfoKGWXvqGlQtwWngoK+UMJuj
	H0NudH2g4Gym3XAp4L+pagxNY6IGEnSI2e4/y8nwvHYK2oF6uwkv5KH50JwgbsGKTWNEcSiWxLL
	bfCrtORZVF9fCA09La7RccIRzrBVIBKozO/YgytTSlePsUaXkvXY405AQvGe8jEstu5SZ4MNd1w
	FhEM5NxY6yAra0x6Wu8xsiaDXJk8+3LFl47Nn9jvTVtlAGMDfYOmGHiUqhx53FdtO4v/1mwPSEV
	OseQAZJNqWP6SaR2mezVXyLYZ8FuGKgVWptcmGmVx+JuDUpqKzsvsxUP7O7JR1x2M88zQuMD3AY
	HfI5A7IwH70BeTbAIHE1RIXkyaANrsFp176lIq8Lcm56Tee3AxIKVGrq7EdEADRiGZO/xOPes/K
	Y7rDWWrBOdbbJpj/i5HcOSa/XwwZXOq1cwBQwOxgrWL84wVP1Sh27MmckcPI4GSuXKXghuV9M=
X-Received: by 2002:a05:6000:2388:b0:48d:dec7:974c with SMTP id ffacd0b85a97d-48e07985764mr20442510f8f.7.1792493005061;
        Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818237sm5338778f8f.27.2026.10.20.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id CBA755FA65;
	Tue, 20 Oct 2026 11:43:20 +0100 (BST)
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
Subject: [PATCH 05/23] target/arm: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:59 +0100
Message-ID: <20261020104320.3686723-6-alex.bennee@linaro.org>
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

We will fill in the functions in future commits.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3d905f8565d..7a3c957c3a5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -42,6 +42,8 @@
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
 #include "migration/blocker.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(DEVICE_CTRL),
@@ -2662,3 +2664,26 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3)
 
     kvm_arm_destroy_scratch_host_vcpu(fdarray);
 }
+
+static const KVMCPUOps arm_kvm_cpu_ops = {
+};
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
+
+    kacc->cpu_ops = &arm_kvm_cpu_ops;
+}
+
+static const TypeInfo kvm_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("kvm"),
+    .parent = TYPE_KVM_ACCEL_CPU,
+    .class_init = kvm_cpu_accel_class_init,
+    .abstract = true,
+};
+
+static void kvm_cpu_accel_register_types(void)
+{
+    type_register_static(&kvm_cpu_accel_type_info);
+}
+type_init(kvm_cpu_accel_register_types);
-- 
2.47.3

