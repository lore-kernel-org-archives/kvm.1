Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263476;
	b=YcI/wivaib1VzsFZ9sFGF8ht5yWmZXKeoMbzQsGi/WKB13bObFqJwDO3aQlmqBwRto68
	 8N0HXjEDaEGNHs47hpJJFzgg4s0H8J14eke2ua7MhxJXRWjlann2T2LhMfqbSJJ1EZuk7
	 wZjJFJrUwFhKb7CdROrf4zxMOx10cqhfPttKP1Xx6DBlcr22eLskcJVUBc00sjQSoe7Bi
	 oGVrjQrBcUNkqGI16jK3YOFMgvtPJFvgrQAy1w44fkPXNue11bethuQz/llU1Y1e/HYIa
	 XWY38g1tjgVFm26vP8uJ6xpEsAg2+LxOr1REqIs7jjWxjTLvu0zCIK7idvjP+7DA3Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+xgS/5jGpPMPPTrDvm4re8WWZpblsiEqi8yKxKF/m60=;
	b=eyq5aGtr/cuItSriE7AM7Fn7bk1pgbH4lVJ6kViDO0Phk71LJX5j5DIHd8/dP54vdfWe
	 OCaJFYWKY7Q27J9FpCwxyZOQYVw9J6/y2KqBrp0a90/Lbe6MUy9kMITV4op0MvlOWzpgH
	 +mEJK3o4ix1smsdabZyYsb2UoyWCc0Iel929EfmFDJC+8u1yVXXrs6ybW6F2rjEkj+A0T
	 0oKkdj+wvOSAsIzIGHHYcGH4PsuT8Y0nSBswhKFPH7LmhEO5Gt4os+jnMQa7s+9rHgoRT
	 iHglR81TdQMCR81teEaWaGVV0gEHRk7DXkBmMTTONK6RA44Dnr1ah+GpDhXbueoRY3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZeGxV07N;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED35606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ED35606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZeGxV07N
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b66d1a08ccso1312594b3a.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263475; x=1794868275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xgS/5jGpPMPPTrDvm4re8WWZpblsiEqi8yKxKF/m60=;
        b=ZeGxV07NBq7SyCb8bGPX9TTTUNyO3rw7nhv761mIQNX1Fv2OyWceCjqjF17v+raw0L
         7n2AU1mAqWhBU5a55zq9IVVcZ3uwhFNrG+rbVWez+eOJFYVGflsexJiandJ0SFqOM4DW
         B7ini96xCRA02H7tQp2q+TsTHumjdWUUGcwRw0yg1uJoC5d9xTtUeCgcaIRlpueKfKED
         BhfLCNVqwWwWlE5mp1Z3P9akyvpSuBGurLg6GShCSiGHOrDWbgHBq3nCoytDLQCTc0Tq
         pKdsA+O6rE+ddb9Hf8zZBIQErnu6nia6ZKRM5phX4fSPJg/C0R7HeCbAkAyqBUVvRWNI
         E09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263475; x=1794868275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xgS/5jGpPMPPTrDvm4re8WWZpblsiEqi8yKxKF/m60=;
        b=1KZa8LGm9GTf8ZkfBLVn2e0MNDZnMxNdJTcjgQOBpZdUStIpIxrtSRQmyvBfiaLx6d
         cdKqbGLHi1G6pTV6jdkKgcr08GA2BP6JMPgD4hFo4c2/XlfqKucfAa+CCvFdcNKRDeG7
         xvHHYnzw0ti0gFYpEZQRTRGAnyKIPvEEmSdBHRvv7Hm6e6VawaadeD6qZlhJTVEFJ7sF
         DeQ2AMbmoBmQPNs6RvRhECgy5usiS62b4yiiCc2nB6UWEqDMDVJipMiSFgCMBMGRbuux
         mV8p4Qk/0hdCKMcUHgDhCIEvxQ8iWt8s4hRDLfWtneICK3pDNpGaRup/Hq0WGnoYK4vB
         b3Vw==
X-Forwarded-Encrypted: i=1; AL+hErHxcQWw6v4NLLkQiJpx/dBbP3MvoRRLuumgIU8DHXUxu208vx7QuDoAHpimTiKVCk4bYZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IMcqhm7hg+eBDGyfs85SBemR/QYy/XucKM+4kcZ1VXxdtQPLo
	zTVGwDOIADiYvWDdONKTuZ0c8tFY1sLm169FK7CRNlQyBK7YRKmDak2TpPL33CFuIOM=
X-Gm-Gg: AYBFou0XHFoA9QywaDndfJyQx6gLn4noe/smoaqphf5DJX4xJj5xB1ayN8zGUVexxq5
	snoJejmU+7oKbNuoO2jODm+QrOf9xkg8x437awzXeNkBtLQc3ZvMSlGz/w6TtJKeL8GcJsEm1m3
	ToziPGN/CFKXB+jPl6dUIOEFM+BZTnIEMTLOUqDAvhuU+ecrZjOuBas01yDPJn0gJ3hGJkbJtyq
	3LQmCoS1hoO1v4T3IJSDQsDaOvtHXlqG4FDus0LTxp3ZXS9tZkEmIeDjSqWrmUvGHTrubC6XHe7
	irMP/6P1yy5pGwhUJYt0uaxl5/RMWaBIX6KSNuowdjk3/KPBNy3/c3fY6cPRpWbBfIJG50BFpaj
	wGv0/Dbi05H8pfjjsrjIJ6dp7gK00ctSGH6y5XD8wJRIm4ttwjD7ihhfJll48mYyKDg8in3bTla
	vp+a8GJm7aTDTmZRDVWCxyo2+XVUNfTuGhVN1t3AoapKCGbi+bnL4WGczUvqahjCGVqr5dG8g/c
	McdBInKvta5yOl8NOc/+VL3Kf+e/lYRiuAW9YSGVpwtQNUvxOyA8Q6P8wojVPwQtLsYWZZW6ydG
	w4C0UoxdddDpMeQvYxuB+/wgoZuEvdzvpPB9ShzwZvuwUV5QR3+sSp8z0gRHCUTDg21SHLsMejs
	=
X-Received: by 2002:a05:6a00:3c86:b0:893:8a6:3801 with SMTP id d2e1a72fcca58-8ba867aaca6mr892139b3a.24.1794263474712;
        Mon, 09 Nov 2026 14:31:14 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:13 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 01/23] [NOT-FOR-MERGE] linux-headers: Add RME related definitions
Date: Mon,  9 Nov 2026 16:30:48 -0600
Message-ID: <20261109223110.1619504-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
2.53.0

