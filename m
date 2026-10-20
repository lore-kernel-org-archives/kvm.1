Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493009;
	b=bYXdy76+a/b4+r+aqi/QJ4iAydnsZTuqHvkqGBZcOxYcNHgHu8Ve0y+j6bvWRBQ+Ncax
	 ebYcrxuuJ3MtiQysY9cPT2kvGG7fehVIIjX8cr/ogeBKncG+ofh7Pn/dcaA7rBanvTCvr
	 PKKpaESk9zZyD2WOqCWYKt2r4MjxzPm95Hhb+3E+RqcAKHlegx8TquwcttblJ8C9IzhYb
	 feDdYXH5KbiEdY7uLqVqFqCsDai6nDDsdm+K28c4KvKdvBcDjMfaO1KuE4KNwIH9jKe/L
	 7jW/ePbrf+YDoPSGo/4t341A+AbS+xtuCgWmwkN73fkgpKTkterDlmwUETir72AfM7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EmgF4PQPx9bMlndd3x44tzG0fL4M//RuzZARimvwNlE=;
	b=mMm6c9ZddA2ZpeAGXHwAzL5zkQJT0UVLLkE8ZH+nb89naje50DqFiKmIsP5F/kL21xmQ
	 o9zn6ROHyZF9MUpQSDuytW24LeqmuofAj7Emo7ozaqjyt/RUeFdm2OmKzhrL2oS4Cp0BY
	 zp127GjcTl8XEz0dydX89Q0pKzDf9gXebOaL28vb34h0DHUpnKWRlEptD//HaQbHH9h+h
	 72Y6iS3TtG+Rm7pASSWG4dQAk13tUjPvfwoucZKBSSgDoAkCBYEImetmCVNtaVJWiuzCW
	 tuFKBbED9CpMeVDK7OkjRDHUl0h6k8c0/NWDQDhISBsMdwcXKw4akdPxVzNsZjeG7CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wWfUidDZ;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974360A2620
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4974360A2620
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wWfUidDZ
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso26647475e9.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493008; x=1793097808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EmgF4PQPx9bMlndd3x44tzG0fL4M//RuzZARimvwNlE=;
        b=wWfUidDZuhj0c23MWYPZ6Hb8I2nHA1/XIiAAz1jVoVqCzkS6lTFvfcLsoWbbIxTACz
         CP8tupxokSOUwZ6gX8U8gEQwpE9CFhSbF8qf+n7OvoWxJyxvmzIeO0PwlrGYwQE7OhNQ
         zJr6+cl1zauAHjWLqmmjRbbJx9j8bNhB/+M9TPEnJfUdjYjACTPumqsIPd4AaJpMoWmz
         XA+uOQvUtxhSacX+y7Et7OxNhdvwMkQyLElQbej7aMpCj/Aj28UfEGwWHygFsxSUutIF
         Erqv71yIdgYCi7dvqD7sEdNGw92rwT7gcrC34DH7dPkVejN79NQy3UBvyEksZQOEuAZ9
         sYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493008; x=1793097808;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmgF4PQPx9bMlndd3x44tzG0fL4M//RuzZARimvwNlE=;
        b=Paq0xh0PTBa9KQGFhMRnzx3wXRF3tpqoE08khCXfHrIp84HqX6I1GnJ4NgIloXPlHW
         J4t8G1NSLIBnPdBoHa1mdztAwYVhWlrKQpWh2QjFWnr7j30EEoMHCsDzzGQ87OCdMNad
         GxoVpZhWAG2eDA4X2wb7ltWii2glZPujNR04/xGXftBaA27HVHfblpXNklmGE5X/lnl5
         TPvqlJv7kPX5hta2nXifvvyMKwNMIESQSOvPW9lm0FPZ1Xofjo82OTJWq2P66cBYi8fk
         V5+yy+3+a1zw5ZPpFj9fTXfHY3/xS0b5spznuvQWJY1m7D+BMI1xugkNBE3GrGePTxY/
         4Lxg==
X-Forwarded-Encrypted: i=1; AKwUvBxPHmY0+7YRbsWO5UmyPFhU68cfjzp/GetBRdYSU0zErkIo4t3Lfg2n7mblH88vAhibwlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6wIQ+fyHK/W4glo0rcXN5RGUu63YIDTxsuPXTh49ZFhJfGqe3
	coXkq9FQGl5M+HqXWcwFt9bGUfiPX23o0//FXtj3MiGezRlY2fGt0Wf++vfJYIfOToM=
X-Gm-Gg: AYBFou0AmPbt3EAm/lH2yNC4DN99gXT80gSuwlktpjyqHQxWJA8zcTEqxWOalrNTjPZ
	GhTV7Ci8S2+9nMQGIV9kuO5rp9DcadcEQQ5L3p0uGf36PgXatlVL9/N1dhWpsLdlFKB11D3F6Dr
	xnFuxNDD1CvMbiSctxgeGqEb4783zdi3HX9zZtzZwazyRRhzs18dYeEaVUb0tkTFU0fUbLbBN1Z
	16BQKFtvZrfzp9PYccTuoRrSqy5T4Qjfd/8ilctyAEh44ImDykoQO2jiI0n+aXf1XXOlXS/Vkl9
	vQ53oX+CJZQikQBLUJOaq8lNAKXdBtVsUeGAY0dXdrDZfF75hFxhyaFSYPq6dIue8V1Lob7vFAW
	Gfl9Ao1UugEneywfyk5rD1tNy3OWmJPbtEDe9RuhXkHPmwENgcDiL4qKn3swRLJpfJ9qaQurX5v
	RJe3F3buuhZJYiKB2q2ZJurNz0a3g2YGSmxRr/sicHdwLsco/DAPRVxzshnydO8+oD0K/gRw==
X-Received: by 2002:a05:600d:4187:b0:4a1:f99e:f22d with SMTP id 5b1f17b1804b1-4a1f99ef467mr11426185e9.6.1792493007433;
        Tue, 20 Oct 2026 03:43:27 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f863e709sm9184055e9.3.2026.10.20.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 14B1A5FACD;
	Tue, 20 Oct 2026 11:43:21 +0100 (BST)
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
Subject: [PATCH 07/23] target/loongarch: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:43:01 +0100
Message-ID: <20261020104320.3686723-8-alex.bennee@linaro.org>
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
 target/loongarch/kvm/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 941142305e4..4bc08f195ed 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -29,6 +29,8 @@
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
 #include "trace.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 static bool cap_has_mp_state;
 static unsigned int brk_insn;
@@ -1648,3 +1650,26 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+static const KVMCPUOps loongarch_kvm_cpu_ops = {
+};
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
+
+    kacc->cpu_ops = &loongarch_kvm_cpu_ops;
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

