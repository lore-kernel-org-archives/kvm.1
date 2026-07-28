Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6394734C0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266797; cv=none; b=GJwd407Xj/rjfRh7ciw0z4aAPzL7UISEbbqyQ6IWOBAiDf4kz8En49VH5HauZBYxlDVmChf9yoAbFiYRa9vfCNrNalwDvZ0V3aA5Xu6e0/b7ss9xv5eb395Rdifb5x48+QwymqvZOkzELJl4hW6R9A1aeB9rNFz8c9X3fCi0nnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266797; c=relaxed/simple;
	bh=eP00Yni5ZlykP8CSavhpj6+O+6eKOHvcTh3XDTqmwyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrTPCNHDL0loUC8Ar8XzW6lojqIDs9+uPLrU998hZc5ZnXVZOTGSBO8oVtfGGDV4Fh1Nq+3cchtCF4LJETNGPz0Ranw0Rdu2wy56kgdsILfqqQJlDqr8eYCpvIB0VhAnJUBp/Ayo3e5twgr6Cz4Gv+YFhpQ0mXJ/Mfe8CpquUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Km8K36Xw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Km8K36Xw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so246206a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266796; x=1785871596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nymk/KlJTSOeG9pOLHjAQMrrwDf8dwvKcqF44jXbkLg=;
        b=Km8K36XwJ8i4AM6hl6zDLv4BYb9WbNzHnVDgH1otaSBkAKOpdZwTtn4eLz50SxUGRG
         W1UkAvdYgx21vZrbjir5B1IgXv+cBaio3fHtE5TruMEqQF7EU1d2RAkCsz8Xt5BNR1S3
         K1mCs0rwTpqEDFdaDK/5eHcSsYmJCpzDDLNuA0Epi0v8RssV1wr0SgrzRiMFvlWyPd6F
         JkKMagoQDiQPMlw3AALUAJs4ZO4dnKDDAqUcnZ6X/1tt+G8WqtIWIhu/6lmlxPFAf3Bo
         jXCFboFTGkOmP6jK9RT1uQb+S+cfGT+dvVDiFcovrIHlMs/ivxm88NraKg4cHNPct71d
         8LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266796; x=1785871596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nymk/KlJTSOeG9pOLHjAQMrrwDf8dwvKcqF44jXbkLg=;
        b=VKJ+NASWI0D0dUuYpe82h5B85QDIT3u1OLRTjWPVjS1LJtNB68BHvF7/wbfVqryZIn
         I4iDsUdWRH11aPZJEzuZpC7c+E13DrF3yJzV8kV3vi3GHp3C20anU2j44jATl7mnz5kh
         2z4DpBwjphjpMON0l0If5p2A4TYU22b/dUmfJfzP1z43SaXzRDG2zjS2dmUCkXt96kX/
         FFZXgCazItIg2EHddT+FJugV8rPH8R3rWN2rAqSj4Vkk8IUso1oMaKZy0HpWl1DPyvMB
         SJXKTjks0YMZXUfQUVg9/yWDbkd9aM7Mtywaf9a56venHntoUYsod6oGxOsy4NRO0+i4
         6gKA==
X-Forwarded-Encrypted: i=1; AHgh+Rpj4vVIUV0n5/bI3mJ1NXorjtSHHXURUhdmvOdZpPvQ0uRZ9+mZhg3jb+cm6gvkTBXeiIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNDEEiEuKg0nzI9LlMSZxGpXmvTZ6jOHi47mL1Tg1sNI2R1mz1
	3j7XX121/9lAQ1Thflz3gWgTcfgeFnWsCCdS42D7TQasT41Y0RXpCamBl2Re7YQCr5Q=
X-Gm-Gg: AR+sD10i4r6GDVHqaQIbN1mAAhNrUnfe/UvDvj+kgx2tGW9cthA2fiARIu4T+6w8IVH
	ma3RVVc5ytaYTWH7tMRbB6ojkjeXTILGge62cUVTTge+Vd5ivTL4jqyi47wj/bcZQ6MeliU5DP2
	CSMe6dQI6xQAvNhgVVY464VmgNzgtnVp0p6rQ0u79D93MHpE1YiUYnNWRCmDirvB52xxAoB0VkU
	OwPx5qXmR5VvwAzW9BvZD0rKl4lS7Ov7p/gKVqJfon/C5fSgZtS0OAr93w4s2r2iHFbyqb+MkCe
	rfLUAz+39TD7iSlA5tqm356QZ1PPoaQpviNeku9ssUi/Zd5XoOOzp1Mj6f9p0Q10ATopEKcXGH/
	W0mkTXEmek4MtfuB7MC71rHwpRNVz5140L+sQtth/WA7AFzBiZ9pf2fCa5bocjfsufKgxx7nZDT
	SSbUFTU0oNQBEGNJw6BPy1WiE1frtuahEB/UXTp23O2QWH9vYwHQBKe+L5WkwwtUs5W32gbMCmW
	BTszT8VAotOig4=
X-Received: by 2002:a17:90a:d88d:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-38f6a30eb9emr4333942a91.9.1785266795564;
        Tue, 28 Jul 2026 12:26:35 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:26:35 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 01/24] linux-headers: Add RME related definitions
Date: Tue, 28 Jul 2026 13:26:07 -0600
Message-ID: <20260728192630.240375-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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
index dd52e2a65bfd..cdd5ad11f85a 100644
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
@@ -986,6 +993,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
+#define KVM_CAP_ARM_RMI 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.43.0

