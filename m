Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A976226ED46
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695269; cv=none; b=FWeumtWk+NAfxK/OnEnCqM2lhqeAdqnAZBHP1kfsEKVc5vikuldi1WseH0vjQDQEFXGDYmP2S3xEb3DtPvy5SHngFQZaV7isK+8+TbXsEwSFM/uPt1Y4mU7UyEFKNbxuFNil496XbX5DszwoShTOvMWAn+IKctckur75Vj6Yx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695269; c=relaxed/simple;
	bh=Lb8rC44mMEmUTtxKus6lAMG1uklYTfLCqVxp5jiH8XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFkzPKYp7SSoGsO6x87rbOVlQuxhAO/qEvLP0PxJiygnSeh6AzX6cp4ahRIxWRb5b00WeOX4FR4/EL2YKZaYkjMkf9Z0ItvtAaqmltV7YaKze30c0AM22vLgzRhDyuA1fUUQyIM7c4/e+MsB8BFAjQ+nskx7oI1i9CcPj7PkhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DaizXVui; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaizXVui"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so395555a91.2
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695267; x=1788300067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ndrOCsdwllHKG3R8sNfPufN5ST5eyC5FSUsoL8k0SoY=;
        b=DaizXVui/wk+UQ72U5sUJrCmh5J3KPqS7t54vKXk70Bx1gh1go8aIwAy7+TNGVN9WV
         8OacYUjc4I5GvGNanjHtfi/SzWxWyf/fRh3c7/zA8NczTUlKmkWMO1ECMKFL1s2I/R13
         hN7RMdkDQswLNaHRG8omi1Y3CesHZCH+WuCv+y0Ui6UXF/H0oBoXoucZF/D1+eGqUFls
         RnmVpNFy/QrzsYOGN7AlY88yTHr6fVsSBINW68zqjTHJk0Al2irL9rdOqdSMHatCMGYw
         nwlS2kK6XBSA74cz+/PTn8ALmjLDcvP/q+ersPKdJmT+Uq3wHnphguCK9NP+OCtU+7ro
         naQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695267; x=1788300067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ndrOCsdwllHKG3R8sNfPufN5ST5eyC5FSUsoL8k0SoY=;
        b=lGoJldrZ1b5uLc84k+gLizk9o/MUa7DvJyvtC7AsuXdLn2sM5LMI+Kgva3xfbKlON5
         XE6s5L9FkDviPemDwbyVxErfvg2LDxMsHCpz5dHC3E/GjDh5MB21pAN/a7sGV3Y/9hkr
         fGykqBI/zibP5lZNnr2119yBlSXE+nVx3yM040++xCI/z4XQ1MkdTqvXtZDjLBdi28Ep
         dUQoG4tJMUO17HJNM/RhhEbz87s49esezL4X8ttungq1QdtCYNGZp22PmLZhCVONQfP0
         Slk0ml2Zu69iwc7m/WddTTu//vCF0STJeKZq45LNQz7TL/ig+ax5cjnqE8W0WaBxqePk
         Ztlw==
X-Forwarded-Encrypted: i=1; AHgh+Rq45MInFpRmmeERB7SOj+tQGM9Ohbxm4fy/wTM9ZR52EwKkyadR7wu1MYe74ss3wpemvWw=@vger.kernel.org
X-Gm-Message-State: AFuF++lnsr5zf3RbbVOi9X8iVfUYOSxC47lv+BpGNriyAIr3UPDp/gDz
	6Yv3VK8ysLEdFfQL5/FCJBcMBe2OwYFJf4V29I7vZwrKJ26KcCNEQg7OEPUvP7YF+gI=
X-Gm-Gg: AR+sD11UrVrLD9KqzKUJqGBzDX1GTkAGgKKx+LB02JrDSuLvAK+bpD1CZti+IdV/R/I
	dm9k01Q7bQ1F65T7JuGuM79ukqu1IkTTPPaM4GkVx6gvy536FVyQfMjS790ULR8yKvneAsbsJCG
	PE3d3bzMEmZPeVZHhYRNCIZX6Dg8rmvhbZ4CJN0lBBAgV53guA6CSEb3OVheAYbiDlC1jmvnlVW
	WqsXwipG6fL+ArwB3GjjYrCbTyeCNquJhS31lHWhk1hhNvoNJQDSkFcaQ63+tsLx/fVi1CGYdbC
	MtrI+Cs9zQcWebeHOSokz79zNS3i7Gido+9mMAHHUp1EuRulQYbrl5KzORFyEWj6oBwB/iSZFku
	H06C12rIwRgEUDt25bvgdl0sjBP2HARYHaOrka/MDOYUz0Cnt3Y4h4OThu+GxP6GssNXPZazxrK
	mJEAL8Q6gK5tPZkbBH9jnBev+8A3UaHYTxW8YLdzru3TgULb3GHVtc8qerctpiiwUK7bhjdhVLD
	f85nX25qRv8dyY=
X-Received: by 2002:a17:90b:4a87:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-3966d18f5a4mr4066265a91.4.1787695266606;
        Tue, 25 Aug 2026 15:01:06 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:06 -0700 (PDT)
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
Subject: [RFC v3 01/24] linux-headers: Add RME related definitions
Date: Tue, 25 Aug 2026 16:00:38 -0600
Message-ID: <20260825220101.3443954-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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
 linux-headers/linux/kvm.h     | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

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
index c1baca430277..cd09c7a4a60f 100644
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
@@ -985,7 +992,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
-#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 249
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 250
+#define KVM_CAP_ARM_RMI 251
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0

