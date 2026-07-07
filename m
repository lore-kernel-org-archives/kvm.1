Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B593D75A4
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464193; cv=none; b=QlhL5/9hrDxwICwrTSdLoJ7pCsE6m2YgtyWSA9G+4Q3tFq8+JOierLgay3LMQtBiS4EhfnIpiGzVFy2uKgfL47QjMAHPhtUhXgT4/UVgcP3a9qQz2RsRz7NtvtrRBYpM/rgxGF7Xkj6tWQbNuYwOrpXfTKoYExE/fAeelwOa/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464193; c=relaxed/simple;
	bh=zdo2FSNaa6GkSlArryovoyDKM7Qh9SnEPuHj9pTH8Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NounRN7+mY2uJa1sR2X7YHbol+tFs5VsV2Rcyy6XRF1z5gPaGgW6vFwjNqdnQI8fwPkPyxWjqQ9ywgmvyCEY18aS1ejlzC0ZrF7IfWTSoOwZFiBjh7McO7FzXeX4OyYx8sTyqtF4VxQ9I6+9BYOZoZEgi3pb1wO4fiksXiHRlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5LxBuwH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5LxBuwH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cac59f8b64so1078295ad.0
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464191; x=1784068991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F62mc8Tl1Cc4gPDKV45QBXhrquRdA4ftBDpPYYJztPY=;
        b=a5LxBuwHfM2W726rGCKrcDUAb+4L6DJnt/fiqo+xr2+ToL1KgmcErtrBagaYCTuIu8
         Tgdk8NxCFdBup9Z0zBv65eu59osbuYtPSAQ7i+l5R//NdElCYdLnFiJpaSh+buH9JGj4
         a2typMqgqaC/N0fj55WhKEpT/E3wpfRvhfY9hau+gR5Ea5qzvuF2NMKJ4PAoprZNwtQ6
         CDosAa7Y+jfBSOXoar9ivOnEY6vYng1P3puYlBcF+f9OMyJsUAGGG+UDw5XyvbMuMTjn
         pMcefL6vuIpVcpfXS1BtKsHn/mA+B3Z455qVqGx7rUGeLgTSI0a56wDUGzsPOVfJHCeh
         zyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464191; x=1784068991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F62mc8Tl1Cc4gPDKV45QBXhrquRdA4ftBDpPYYJztPY=;
        b=W/cC52bJj18oNnc2vl9JSz3NNcl+hzg0O2cKvRpZdk/DjT2EmB3xM+pSwHIFkSYOly
         pwXX4eMl0cbZ2NlcB138wKsHOQvkk8nA96Tll2nGa7IX/baowMmIbgyGOCHVS9y2xyiR
         fRT0NG1mF893z9B82E/ZaERr9K3UABIJls05uu20VxVq5iZ3yknZGRVOIItunKo8NS54
         bnPa5mNUGAvNDpe6zdd9Rrkd/B3R/o6Jsu+O9maE5MaOznkvthQ+wdY5DyzmNLEy3uf0
         uZHn9fSji+zwNo9AAptV93Z0e/Sxv6GDkYJZ9clFrmQ9D1QI3nD8pEUjMDcQDkJCG4Ad
         bhSQ==
X-Forwarded-Encrypted: i=1; AHgh+Roy9HS0rVdeBRgWBK3frhQPphisbgywMJpYq8Dc+J5QakY+ORd3+yOa+KXis2Q2u2dAeYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eMduNZ3rVA4kKg0tna5/q96HcYQ4wS8GPDyq37lt7DhzobVh
	5PihLlHsq1y2DKf5AyD4/uy01/L270aVMZQ2bkOKHh71IXAWEaMfTXtSmCUlmBBJ63g=
X-Gm-Gg: AfdE7cnuWvij9NSDbCsXeCsjTnKCDA5/ySiS1Oif47J1iAXHPo5LgeX4AJlZxXv27cX
	b5w5JUldXJXgyP6zSrYlAEV3wTsmw5dZfTO3242dCdz/ZmUogeCBIw6rqWFc/ScKc6I+SKPlzJD
	UUGLGR86zGjB64qh5ypOs0RRnyoY5CtCsjCcSSwRN17fMCmbianhYsZ58FmaVrI7qMigt6xSF0M
	QzmnIVVEyFRCa14MUPXt5a/JhgcbZVdlLaS+J9cTeLvGi1h4NnSL5x/4wR/WFeTfYoKNsN9dNsF
	TotObsJJi1swr/+LNvJAH18+BBzVz75wy4u2I6DwPcXYL7V5fH9lUC26lwgkrtLL92r8JL439uP
	n42TeEnCg01yqZG0qkWO2t6kUA4RHTme8qRu6+gJBK7NrcZ6qTxyD//uJ8f/yC1ENqbhwP/8pt6
	jUpmUgqisGzJN7dPadohAiXCWQ2D972MU8lVt8gOM=
X-Received: by 2002:a17:903:3c2e:b0:2c9:97a8:afe8 with SMTP id d9443c01a7336-2ccbf087de6mr67975145ad.43.1783464191172;
        Tue, 07 Jul 2026 15:43:11 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:10 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 01/25] linux-headers: Add RME related definitions
Date: Tue,  7 Jul 2026 16:42:42 -0600
Message-ID: <20260707224306.1202330-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
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
 linux-headers/linux/kvm.h     | 21 +++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

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
index 50e87ed72c20..dae6e5ba8457 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -685,11 +685,21 @@ struct kvm_enable_cap {
 #define KVM_S390_SIE_PAGE_OFFSET 1
 
 /*
- * On arm64, machine type can be used to request the physical
- * address size for the VM. Bits[7-0] are reserved for the guest
- * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
- * value 0 implies the default IPA size, 40bits.
+ * On arm64, machine type can be used to request both the machine type and
+ * the physical address size for the VM.
+ *
+ * Bits[31-30] are reserved for the ARM specific machine type.
+ *
+ * Bits[7-0] are reserved for the guest PA size shift (i.e, log2(PA_Size)).
+ * For backward compatibility, value 0 implies the default IPA size, 40bits.
  */
+#define KVM_VM_TYPE_ARM_SHIFT		30
+#define KVM_VM_TYPE_ARM_MASK		(0x3ULL << KVM_VM_TYPE_ARM_SHIFT)
+#define KVM_VM_TYPE_ARM(_type)		\
+	(((_type) << KVM_VM_TYPE_ARM_SHIFT) & KVM_VM_TYPE_ARM_MASK)
+#define KVM_VM_TYPE_ARM_NORMAL		KVM_VM_TYPE_ARM(0)
+#define KVM_VM_TYPE_ARM_REALM		KVM_VM_TYPE_ARM(1)
+
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
@@ -719,6 +729,8 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+
 /*
  * Extension capability list.
  */
@@ -985,6 +997,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_ARM_RMI 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0

