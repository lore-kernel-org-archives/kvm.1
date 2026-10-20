Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493005;
	b=IBElmom2pwDKKzXAJ6PRscKUV1YF+FkjRZNcM7b7PN+TB9izIfiJXOWjMSg0rLYKW2bq
	 RKh5kzZr0se4A5sPwBeT4pD4j3WGfCVNy9YZrQOX17se+m3wYZOOfy7mRyMy5LQegGUsX
	 qSyONLVldTxiD6UVUYnTHzXSwLaOuYWwPIWE1DdNDkTgbKt5X5vksVg9E42BS5c+xR2XH
	 EWTDAr+lDx40mgKp6dUn2fTS6U810lxdBazkBLxXaSlv5SOYuSgMyqcSIZaPe3lWXkEFK
	 E9lw5knUH5iKJyWG1hy0lCgcmE9Q0qyUTUWg5Jc6FyoGeCHnklPStmd9SY1pZHKs+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EQ7gfcnpJP7Ud8+3W5PCJuKE2nJX2Z7vYXXp9omA0HY=;
	b=kAgBq3wQxZzvd5xjT/bvQ+A1WRnDWUaEXsc7vZAVhkflVh0Bzdnc1l3r9e5VBgJxUd57
	 8fBH75gETx+8p3IkCUJjHTTAcvOiIOhP7yMe+xYG+nRKGC41ll7r4OoWwhY9gWuz/lyeM
	 os0g/zEfnStFkOIv/MiXjRRNUCJtkbLiNLu73DQyBjraWAzLKXud6XZ5YZLom+K1Ox83K
	 +UtClAgxvvuziuBu+zR9PNFM1HgxS9Dm5ABszOQobA6MX9wHlPv9gww3BPGQI8edvozRg
	 s1yZX4BCEq4AaJnyULIbpXOx7Pu5x1DWoJUd7HlXn8cuYFQPfpQGbay8C7uW2OeBl+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DRoOkJDR;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F1606A334
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 509F1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DRoOkJDR
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4649b35bso2532900f8f.3
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493004; x=1793097804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EQ7gfcnpJP7Ud8+3W5PCJuKE2nJX2Z7vYXXp9omA0HY=;
        b=DRoOkJDRgFzpR4HTZMMJtbttWE1M6q1lQM1iGVoVztA6H66KrPWe4nXokQ9jzwU39I
         AqxH0F8MJFlrWUW1+Ommc6OSy3m8GiQ98tkHX3CNO137TUscoMwZ4VIGnUNWDDC/3pTE
         WO6qThtDAJfjMLLhouqdn8Pf2n0Z+0li8O3PGlWodlbAIPVwUfJztlsfrE/zGRCOqIF8
         zhgTO6/dv51Tj3r2MqoXc3vgTZnBuWt1EEemnyr8qzZUU6j320skgX4P0GfH3MewKLmE
         DhthAG3/US1MxJJJiLaN2PqZjWxAYRyUK4wTwITs+elCq/YdXdmz0rkWaC3ZYSC3SNk/
         muWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493004; x=1793097804;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EQ7gfcnpJP7Ud8+3W5PCJuKE2nJX2Z7vYXXp9omA0HY=;
        b=Jv5PKjI368KlKykSTYHdY6BKaLgNnO8ASaK2+qewGpZmbVn/El8Duek6PPzD7BRwpp
         +BknlzLQH6/zDayOkSuA6RusTIUqaVxqxXCLtRRSmbeYcMokEODLK97USffeo3SHpJKl
         FJo7c+5wxWFmYya1mEhbLRmwAW6ZAwCH8oF8SShjbfF8mpvIXxp/zbSPIM54vCwuaf7D
         uSv53wZ8zkd1sYCgOBtYh5grao4ocoHJJ4UXZGY9uOzDMPfMJsVgDT8/GP29cwZlOhag
         1ZX4i7/QLIClqDZo4GVdQH5Upoc/qClvXXamxLccwsaiGSbJN8CDblSe3bsZT8lcgoJJ
         3SsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzHLPRISpgMtFNqQ+5cwtPoIt8xsKQYceWdLcxtdwGBWE96uDyNqx1lH1gCFm23erw96XQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPiXxjDxQa14MN4vnC6lCAC+//in0sw3zxtQiqCT4sMTDNY1bp
	WlC2uP1Px0IQ7lYsXi511rAaTtJuBwxnEg2h8d8DCiNRZrnvKhEJZ/FPBdmjstNis6Y=
X-Gm-Gg: AYBFou1Le3qT91BSg/1i2pzn4qhO5SJSTsTPw2wpgaqkkSjWrQmG9Df8SJUyoOdcpqg
	3SI/XkCf+bHgRJPWWiHmTPyYzk3/ZoK4t5WlJnH8TZ0HDBZvZMmF5oeAZKxeiKRYySlSnY4C8Na
	p4jqrjJdfsgeXNm1CqYsB1WWZP3mW3px7T03RP3WsqqBjScVgzWyGA3N5QxaGAyepOCe8heIcYJ
	xsiiinBlncpb+sExx/F2NUpZaBSecMd7HWRxpIqg40XbU97WkCSx64KXpVG6BEH/YGV6NeU87Dz
	u4K9aw8OCNOYb48dQ3cVYHsTSi82X3HZUcsopQHBsko2wbTTK/TR2LLEiT2Pmu3/HTTXBDcF1Af
	aq+X11F7Ei8tIBcXLzLc3PxmGzp6ZSHn2RBcxwNsN/MPp5By+k/ZKa5atchTUW3F49jUsH1WVxz
	9a6xll3TjVhPciZnBNPVICrOW5hVRb/G82DutkD8hVvlGvKf1PBJ/nzTvlDoIoma2gPy8F9HQ=
X-Received: by 2002:a05:6000:607:b0:48d:f58f:c91 with SMTP id ffacd0b85a97d-48e07bb5919mr21536746f8f.19.1792493003575;
        Tue, 20 Oct 2026 03:43:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820822sm5769631f8f.34.2026.10.20.03.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id 92FE85F9E2;
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
Subject: [PATCH 03/23] target/ppc: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:42:57 +0100
Message-ID: <20261020104320.3686723-4-alex.bennee@linaro.org>
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
 target/ppc/kvm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8e89a6c665c..8e9328beeb9 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -50,6 +50,7 @@
 #include "system/kvm_int.h"
 #include "system/kvm.h"
 #include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 
 #include CONFIG_DEVICES
 
@@ -3080,17 +3081,22 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
 
+static const KVMCPUOps ppc_kvm_cpu_ops = {
+};
+
 static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
 
     acc->cpu_target_realize = kvmppc_cpu_realize;
+    kacc->cpu_ops = &ppc_kvm_cpu_ops;
 }
 
 static const TypeInfo kvm_cpu_accel_type_info = {
     .name = ACCEL_CPU_NAME("kvm"),
 
-    .parent = TYPE_ACCEL_CPU,
+    .parent = TYPE_KVM_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
     .abstract = true,
 };
-- 
2.47.3

