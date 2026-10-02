Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A88495040
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972432; cv=none; b=UZuiUXCkXdi4XRlsF4V3mjVENqEUCOfbOI/liBGsf0Rwrc8aU2EYkJ6ErsbeqPr6qGOjGqAS8U1MDQ5NhzWHyGB6MZTEe17qvn5zumc++cOC0OcG5s/HOWh/F0UfkBfeZ6IJyLv2NCKsfTfwA43QP5/s84bkGEs7zgIvWXC1UFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972432; c=relaxed/simple;
	bh=a4NHuDefdLNEQSkdp/h9r0P0+sM8qTTZquCtVO7dFKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV9ZShcozqZ63ick7nnOn4AwqcOg02EZEIwIBlsw9vh/JbvcsswfxOG3eaaqgPIVSiFbd+f1AI1nQjKO8C9XlMGwMFN3vkSrNDjDhv0uyUNLQT8+EZ/qLuoW9xRWNScUC2zyX7k5BnVR11VehvJvurX0ZOCM8AJDIqgmCAAxHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sH3EUY3T; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sH3EUY3T"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0f64df6a6so244138a91.3
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972430; x=1791577230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iODePatmvGNDBqYJx04Bbg2cZsIs56+xqllvlfLUyUI=;
        b=sH3EUY3T7cdYYLQWRi2JQy3uYcr3xh6PsC6Civ+3IpnSuvX4zXEjnVEE5DyjVxKse0
         3QCDc7MMs/nYCuzuQaDh8gZVuzSjU1zslQ9ff1jffxavDPvf6JyLZ2pNpZDVaoeXNwSh
         gxUzyTr3Gyc7AD753RqblgtSK+ThDDrVodmK/er+ojSrml44/s0kfAZSlvc4YiCuZZkf
         vHaKr1xRRN/MvgS3m9aUXn4YJCULJNgJ9cgNXtaKWun5qCyip6AKxqvRh9qbJdVISzsv
         Tot6FEC2nrnAZqmqOqxG4A2WLzMRm9QcHrt07/Z8BN5IG8g90UuF73yLKXYmajJ9A1TL
         HtZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972430; x=1791577230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iODePatmvGNDBqYJx04Bbg2cZsIs56+xqllvlfLUyUI=;
        b=ApOadCNpt+IPxEs6MWHScLh8mywR/FPg3wzR3E0OXDwS8LZqI20+Mf3suKwQseHH5G
         fIpdwzSnm0YnqLhfQXqDWJFEVGR8m/cdj3aNzxs6Y/gdf/XZy1Ld9/yph+s3/HWafoR8
         ZYCs2TUwblJYkhNBJIsa1eFkEj2gv/isg1dvpymR/7vrGWzmCAyVTxCdfQjWGSJc8PCX
         kNpWIDT8pfa/E5hdS4ZuKXqlQfJcGvuYmsRxrfQjk2aW/sPuDCo3C/qKsweeNqMNyirj
         WQiaJtx8dE4KBuyDImnxNngAj45EVbTVV2Q98eUnzY+fXCneKBUjg2Yj9kAnh9t8avfk
         gsMA==
X-Forwarded-Encrypted: i=1; AKwUvBy923sdGQWL4m9cPw2cVw7P+Dajr6/LxeHFJkqBeeM01UDQ8EqrmuiQ61YXHs7osLO6cgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLq57ExUvEoxv/vxgapWbiXFipYzOFfehCAiWVt2485OBWA3IVA
	JHV3bl30iHHVxfxlsKqzIhHtBavpgAgsBP84swzcPj7xW4qdfw8iXhgXuZZWMH1ekI0=
X-Gm-Gg: AYBFou2Hx5mcsNnOxBbkfD0amnLyMo58BKvv/qxZwSJiiGUwI2tM+qU4tESPgUWzWL8
	K5RR4fS76UxN/GRsfFP4Nld6UAMIJTiR+18rOhHqM1p1cvgIdKetWZUtTqgu0t9f2vghAfgoTSx
	p0mmjOrB/Ygywdi+sA//3fNt2+sNqgM92M+QbZk6hhwsgbPqPybFNmzElaN7nDRVf7Qjn4XchWT
	yl6aftnD0cZuh+SM1lrsYJSICw4RxwhLxfOIiWqn2SHNGwE2zwqbeks1jIiDxu1QMbumLE9ZCzC
	BbQmjmP5XPssjmwbA5U7eBriIGoZN/UXK7cEC6RHqy6Nx9NMWGfAKZ8AEOlzsETp0m+PWfv2gTb
	EBRHUbsZ6ORP9dBxbsc8zPdmdfw4SFGBmD55prlQhjN6iyYXfFQDr0yYGQRCUELPCgvbFHS4kOG
	sBGJ7dEB3QZjK/hX9b2xg9kXzz6mtpvj63I7fNWcVhePDa6g9LCqJHOw2+qoDCMiVvQATHeSzyN
	uj9FqnxGG95wSeb77yb7849Mg==
X-Received: by 2002:a17:90b:3b41:b0:3a7:a34:6f94 with SMTP id 98e67ed59e1d1-3a70a3476c5mr1235372a91.65.1790972430400;
        Fri, 02 Oct 2026 13:20:30 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:29 -0700 (PDT)
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
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 01/22] linux-headers: Add RME related definitions
Date: Fri,  2 Oct 2026 14:20:05 -0600
Message-ID: <20261002202026.1204110-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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
 linux-headers/linux/kvm.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 7850bd464222..686c199e2558 100644
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
@@ -988,6 +993,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_ARM_RMI 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1674,4 +1680,14 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+#define KVM_ARM_RMI_POPULATE	  _IOWR(KVMIO, 0xd7, struct kvm_arm_rmi_populate)
+#define KVM_ARM_RMI_POPULATE_FLAGS_MEASURE     (1 << 0)
+struct kvm_arm_rmi_populate {
+	__u64 base;
+	__u64 size;
+	__u64 source_uaddr;
+	__u32 flags;
+	__u32 reserved;
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.43.0

