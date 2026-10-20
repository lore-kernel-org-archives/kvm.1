Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493007;
	b=vIQXMBjHxu/bQFE3yhiE0C3pVGDZFD7vbf2SERc/PdQSzhFlAlGTtXBMIfRN0/+K3BW6
	 XfZNFniFV4rddIv8OUEdOuYb6pOSOpKDRcyMY+8sCiJY+IZZDDkRCPat/6KpxMPHJOTdo
	 z9XHW5ncR+OUVXRMi+PiVpEHhzU2IESlrsjCNUXo0SXJ7IhBFXICyquhUR0eZ1451uGxl
	 8aZCsb5cdjR9SRKxbN0DPfuabDLJzZv5aehoLOqM6VsSR1948AVojIioIljNeCFrCqitK
	 eNwd2ewDXEpyd82o/fba7eC9BYh3Mi/QYThGcxVeVZC/uwsroLa4yRLVa7wZb1URfaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493007;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=clY0Exi/Fk2cbqeICRgpqzcE6k7M0cr1lXEHsMtE1Ok=;
	b=FCbxI9Ozkza04Rnp4jFp4Ua2PqxzMY10oT5ckYftTMNyWDuo/tcT0AvyVpDkLYQ1SmhL
	 LDbWCcI0BGRaEGWKpiYTwqw97tg524F+D/+EsWb6T8kLHmZe+qq/SOBslg0bS7H5a3SLl
	 28CpW8V2Z7UShw6gALoWv6xVGQ0pgIXyL5kvbV4S4sv7rHIDTxD8LIuLsb02QlrOwon8h
	 Tmz2tKaJGXnVcguHbIU2iq5OqMTmtiGub9zO64o9LBkxq8bNq+d1D6r647J3Ro6huHapM
	 Nd/ra4Y0gVL/sf5grQfWV6ZGZUIOxPa/lTDeQq0bXQDJGgY980xK2QNkt+LbBFqeR8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FcuRUPpw;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620F60A261C
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D620F60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=FcuRUPpw
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so15262015e9.1
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 03:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792493005; x=1793097805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=clY0Exi/Fk2cbqeICRgpqzcE6k7M0cr1lXEHsMtE1Ok=;
        b=FcuRUPpwx2+HLMhUTJDbV+mwJ67egmBifbmTT6KVKS/dVEC/yxvulpEIe3WyG7g5iy
         Dtbio+pgy3tsg0gwQbxBez07+z645Ycoj2ySMABaujiG/kzCAME1WyLys/0Y+bWy3Dzt
         v+tFMJwAhnKFFZxb6MTSzZPR7uj99YfV6u6vQLxqs62mU6alQyL4RlDJ/m69m0wkbbfr
         dcq2ADQDR2mQ5Zm3KW0mW0AZFpKdOLjMvSFQ5SP3xuzB6jKzU5fQ2GZO+UBNGxSZTFy0
         Mj/GnfT9oxWlhjTIng/6uyVMywryY0Sihw7Yq999fy/7FaQZ20XFchvrkcHoJHGAy237
         8JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493005; x=1793097805;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clY0Exi/Fk2cbqeICRgpqzcE6k7M0cr1lXEHsMtE1Ok=;
        b=o2P/1ssR84fLzmD86bepDi7ZbguYO+cRhf8jgbJ+NNV8yzHoUPoHPa948pYgQSWaeH
         kTiYfmPaarYEiY/XuCsYRFUAvz7mPaCRMt7gf9mQL73I0jsvH64n1XQNEh673ceJfzi5
         n/7FzbaevzXiDq0/EI6onzcZHdp1WEIoW57HT+E6ogUV9qnZO5OIlORh+IdlOe3b9bwz
         Hvx9BPfpOd/YEr6PBtPDF+MUE7OqzdE7dZHRzNWJWiyGvloCSJyuuPyMIG37b2ZnrsqU
         j2f6zSpTgqEOMPoFZdaCy5PdZbG9NCKKJddsd6pWMpUn8AU6ctQsHWVfKw0UdkCydY2Y
         Hn7g==
X-Forwarded-Encrypted: i=1; AKwUvBw2c86AX9n/6FUSnU3823V0JNgkS/Up5vcxfB8ia08MsWr8OGWMWenUTwS1kkK9qTLJxBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0mgDgOAaLNCzjpYEWGahMrnyL9rgS3SaeVyf4fjqyVy1Ufom8
	7VX1O0HpQnCZfV/ku2jCjVE19a2jDCxG5kxLzFWkP/rj2Wb1vSOqT2nTI5+fQedCGuk=
X-Gm-Gg: AYBFou1XEs485gJld8LczPhbfRuX4CzOKRdyeViDy+q5m/PGkGmARrNTXtXnu5kkZrJ
	9jBym+V6zypAMQFDtoIDcwYXqYYYkXnG4xm3rYrJyF1yxYCP5HhOEJsBbVhuBMUJebL8QFQqqpS
	2ACadzAqi3LiGlVijzkesl0YuXy2YTUeX0nNIXNN/poAVu3cJxhXEjvcQXrk/VoyzjN7Rq52TJP
	hq6DKpNtbSOONdtXlJ6B8NGIhArB3t3Wy8NYNTYO1p9g4eu4vp4WAsn7fu9O1PeJlTplska9N0W
	xFavx95gpw2SdrrIiufIUKb2FkEkoNKCNbV+RlQZS6FC81WDAz8oayGxdecJy/6o4drbKis+I9t
	Ev1rB6QZGhdJAfVWXK2V2zvlfnZGOhQlaua9J0hd/pRsXHyZrvehuqf70RicdQrpDy5PHLpK/6p
	icmwGVMSL/knqQKXyqjJv5ze4MFLQ/9LirdtbmXc96piQjKJwTeIXD5XjsgA8VTFjNDUxgHQ==
X-Received: by 2002:a05:600c:3513:b0:4a1:a39b:e75b with SMTP id 5b1f17b1804b1-4a1d7607560mr224796055e9.21.1792493005376;
        Tue, 20 Oct 2026 03:43:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc809csm64722745e9.8.2026.10.20.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
	by draig.lan (Postfix) with ESMTP id EA3605FAB3;
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
Subject: [PATCH 06/23] target/s390x: wire up empty KVMAccelCPUClass
Date: Tue, 20 Oct 2026 11:43:00 +0100
Message-ID: <20261020104320.3686723-7-alex.bennee@linaro.org>
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
 target/s390x/kvm/kvm.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index dc67e848864..69e49b7d151 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -52,6 +52,8 @@
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "target/s390x/kvm/pv.h"
+#include "accel/accel-cpu-target.h"
+#include "accel/kvm/cpu-ops.h"
 #include CONFIG_DEVICES
 
 #define kvm_vm_check_mem_attr(s, attr) \
@@ -2655,3 +2657,26 @@ int kvm_s390_topology_set_mtcr(uint64_t attr)
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
+
+static const KVMCPUOps s390x_kvm_cpu_ops = {
+};
+
+static void kvm_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    KVMAccelCPUClass *kacc = KVM_ACCEL_CPU_CLASS(oc);
+
+    kacc->cpu_ops = &s390x_kvm_cpu_ops;
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

