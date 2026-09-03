Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0C5013D7
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464195; cv=none; b=VAY2C7M9WLBZMIY/DT2A7w5+VIEvmBPA9s5DGeOIAdkSSaq5fW49xivqJl0CUpJV4rR1ma2w4cuUajJzg9zAhqYczNz+X6dxoDj55pXLS0AEJUx89SYTRN8G9Sj+/9UsQbDPwy5l83o+I/ed14a8z+40LkORqCpQbhMVhoRapiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464195; c=relaxed/simple;
	bh=BRoRWEhXUgzPgicYuDmge42AL5dwyMSdJiI0W6YqzWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPGg284Mzos4jcDkdKv1DXD+A87o2IpQcO3aH5kTlZ/gsvND1+sp38jgAxeoiQj/HcrJiB6fGE8niS/I/qGZiWRBeAZzpr3JfmJ/hEVHDEGcvTvsN+mY9yvIw2upZdOQCPmd11NWIjiktREGj0E2eIeFZTG4jzffI4JpVRG3NIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JDs0LFlL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JDs0LFlL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so177048a91.0
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464175; x=1789068975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f32IWeVjFPoScpLFlx02pOBXGIUqQvqEdKcNhwp+k0w=;
        b=JDs0LFlLexP+V9wVDFh2cK5ssNntcrsJyEf1zH6gsdylEqibbWec2nC/rNsF4GlCxv
         3CSKHN3R5rS0IMilBOhPG/wxSIPlQ35Qc7wOMxFo9K7w1011tJaCKHi7nZeSRm71Xf9N
         3APhzFV56voBBtgnyuirC+06lE41/fR2ZSq09y0lyIGOqJrhjUWTz7HxZfRiul8rsKtp
         tFadU+AzDh6slLhk7+WLnkCI3R6W80hEWsUbd1UoK0POh9QHuEsndBTYI3Ar1d0QIAHM
         TEvwR+QP5MWkaBnBtme+pZ8vVJBzXqV1Cy1KnqN7KLQs1V5jeBCZS2Metg8KJhgMc6nf
         VEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464175; x=1789068975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f32IWeVjFPoScpLFlx02pOBXGIUqQvqEdKcNhwp+k0w=;
        b=KVt1qeqF7/SXvO7YWgZEu578AdxhfCw/BQtwxU+LNUmG6C3SW2SSqj/y6AJuELqYgW
         avOKe+d7NgcdPybNBTlrP8UBBv45og4YuP2zjztNnkKsncdFpungyio3IGfgFtPdivg2
         /oDJgxmTPnYptT1gjFuW694U1ih8GGdtb2QwAMWUmxvLbtlGJFPF73EvacL5ruBeYvaD
         0K1vU7jU99sfFJ48V8RbSEIOb19XAfs/DyIjXZifGT+CZnji+hNMNh/9+nV6BH8jCc/h
         DUe+TzKrXci1W1JOzNL7TQMCYi3L7giJMx1zTE5hwtHpSJAgh89vrjqAEIDLhdXg+ICh
         YkQA==
X-Forwarded-Encrypted: i=1; AKwUvByLgm9GWwO0GZLWxaTOW6ibo8AXU5Hd9B5dViYwCvs/J0BFloHIdmad0jzwdXKN5r5udWI=@vger.kernel.org
X-Gm-Message-State: AFuF++m/oiRt+nmCWyieSXVvCeZcb27/HeMAiVzZR1EX3Z4WeiKj+0Co
	k6N9cL2bF6sXyV+88qLvrKHfh+4xuBm0jE1enNZBhUWbYKxGPvM9qEtMZeQ4sV80XCvFUJF+T6D
	e5j4A
X-Gm-Gg: AYBFou0Nd5Vs0MO0XeFB9ijfSwujDEwd40JH3cqQ4ax+ImhPTn2zcII8Qzr6MTehHUa
	IM/ijsJviQy3kfp+eZ7kKNGCqQvs3HiJlZScVwdpEUnkYkyTO4q2wgU/Qrgmc1ajGRkw033A2l7
	Nnh2hivzg970ssRLZzTS4MS6fZLstP7NHQ7R9e3fsmc4zWsnW1FWazzw/lqCWKOdW/HAbj8JN4n
	KhId0I2HGT0diqIgPznizYdUKbUN1UMskt7mHlBKFQlPOKkOOA6zrkO6yg26D5Vm7owzfn2XmAU
	cS8Z0haJDppaQYV5sSf2OFEuMWYSaXElyjvIRSLcYhXQhluJQwAHzojSUuLyCd7npz2rYYNhV1J
	jncdGxxy/dpvJva0dp96ezhFg9xKE+zaHQE6xCUPc1uyk7/DW9OxMYOkPMkpSYWYF5Bi0YNu8B0
	mhEkO3SRnDvx1VyUWDUCt4HmxAvxe89GjeOWWbfkfYjiIXGGMxrSDLNRSAkzQKmpGEwgtgrDOP7
	f1NGH8a2BnHqvstXBSWCk5duQ==
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-39b25eeeef9mr1274489a91.0.1788464175209;
        Thu, 03 Sep 2026 12:36:15 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:14 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 01/24] linux-headers: Add RME related definitions
Date: Thu,  3 Sep 2026 13:35:48 -0600
Message-ID: <20260903193611.1058589-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

This is a temporary patch intended for testing purposes only. It provides
definitions related to supporting Realms by the QEMU-VMM.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 linux-headers/asm-arm64/kvm.h |  9 +++++++++
 linux-headers/linux/kvm.h     | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6aefe7973814..4c08631ec7d2 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -208,6 +208,15 @@ struct kvm_arm_counter_offset {
 	__u64 reserved;
 };
 
+#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
+struct kvm_arm_rmi_populate {
+	__u64 base;
+	__u64 size;
+	__u64 source_uaddr;
+	__u32 flags;
+	__u32 reserved;
+};
+
 #define KVM_ARM_TAGS_TO_GUEST		0
 #define KVM_ARM_TAGS_FROM_GUEST		1
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 29f81c05aca2..8b7627f11447 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -689,14 +689,19 @@ struct kvm_enable_cap {
  * address size for the VM. Bits[7-0] are reserved for the guest
  * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
  * value 0 implies the default IPA size, 40bits.
+ *
+ * Bits[30-31] are reserved for the VM type
  */
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 
+#define KVM_VM_TYPE_ARM_NORMAL		0
+#define KVM_VM_TYPE_ARM_REALM		(1UL << 30)
 #define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
 #define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
-					 KVM_VM_TYPE_ARM_PROTECTED)
+					 KVM_VM_TYPE_ARM_PROTECTED | \
+					 KVM_VM_TYPE_ARM_REALM)
 
 /*
  * ioctls for /dev/kvm fds:
@@ -719,6 +724,8 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+
 /*
  * Extension capability list.
  */
@@ -988,6 +995,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 251
+#define KVM_CAP_ARM_RMI 252
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0

