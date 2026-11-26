Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670875;
	b=DSc5/lUTj89VyTuGoLRyoNySke4jt4W5VrBGksPEYn+BHSCPpvrRYHNlGwiE3yKlb0yl
	 6NZw/5PwWESNPlFrq+WCFvM7qXuc1kc+JgnJq7ZqcPgzqZEjGlWP+cUqwYaGNRFxPnL3M
	 4t10m2yQizagXgs5HXmaQVY3L710H+uYI5O6TAKu1Xe0flJPrLmAZIJ5jRydmeWb6jX7G
	 0goMbgjlAR2RIHts+Tj16wBpgW4+VT8mY1H0JgTupGmJwSOPcdECCQDIYTFFLQfeg0gkp
	 yDot0lSfHqBkapKQh2rUsFYVzlTMSTKqzJRW6GLWEDB3Ob08FJKW4jArl1zy8CQ+FpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
	b=4MmqWIOKtn5vz1cE/lMVMQDGy7m9HF0lvLliCG49zhITTsfCCDYQdq7NWhaENemWGCQB
	 QigJ2D8Rn8t4rvAYfvyjRG4Ma7nHnSHEKQu9OxJWd1aezRua0MR9OH90NEt5V2lu/BnKH
	 Kn8fUcx8DN0rAODRc0Cs69NQ5m+T7Njw4jyNnNfzhSWtejtBVrViHKCG2cnAiRyKt8hJA
	 YwBYqiwaFv2Su/EnvsweMW9eMwjgjAbRgBd9vcNWYVPwRUjZyP535WFrBADrF7feAXedP
	 skcJuY6FzRNCnoUhcrO/7FuR3Wa7UIW6xJPBcpFMI/vVwW3m+z91Og76cA/WoXaGm6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vuRwpViQ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7C606A321
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 05:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DD7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vuRwpViQ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso46739945e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795670874; x=1796275674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
        b=vuRwpViQtCG8FgkOSYQ0Lo+mIx/58TdrkUeVA0inOM7ioQzAK3Lgq3nDF9Th8GzLw8
         lryC+IrR/0s23vUs2f5u+I59mwUsWy6h3EjQiMXbQKUNtADo+GONiJx5+7vxtlX+7LpR
         Q5+t69oRH4oH4XlWD7y7QhS2jiaD8Di9/8IM1jVo3gh9UJhdVjxWHnPb+fc64bBSHpWM
         LyWvYUJnlnW+Hc4ZUyj4yduGq5I5a0D0n1oEJOZS8wXxZLRPGW/t0ETUpsZGaz++BeyM
         swLwspDI1pnVsjp89Tei9xYecmNgQGCgAt5P21/DPAKH3ofETpOUFFY0NodJE4TGoEa9
         eXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670874; x=1796275674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
        b=Bq6zJ6G2TPJljutHj4R3CNekcnC3JVf/La+OpYQj3/z6U4usC0D3zZaWrZ4kuGvIIF
         rq46/uMVQLnIkkBRHQKEEMMf7A9qnNiTegeHF6RA6PACVsXztwHRj8n/SYGDJabHD8nO
         m8UL1fzu/oOCSZ/swDcGPeurgHJaPgUxD2I97DZOjLhUz0y91GlhtQozSZpBMDxDNu3w
         bZAap3j2AWNMV9HBRL49A1Een6ui0xupZPBmHRJmxw+Hjpe09gCb/+mEoNU/kSl/XEH1
         cL1va7cxV7lrlNvZKBLJZaR4TrrMOR5c3vPChI1WRMwjpr6LgHhFLpihvIaf/t9kjfZI
         e8mA==
X-Forwarded-Encrypted: i=1; AL+hErHNni6ajcjATrXWi1TkkZnFa7aDW+MLrIzP8ukGUFRpgsmd3UTWy9k4eAaJw1zqulk2l0Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s5alyxm8ZQ6KzYhM9uZ472ictE9jaOOtNaGpIXHHJshUBPYcu
	rzVojovVyEISpEijUInLJmeZVr6nZhxOtE4SvKJz5jPHMohqYK27RxKR
X-Gm-Gg: AZFdTZfaDNe0Yhg2p+vLN4P7I07D9rQ131IvnFehgOIFhWM9hcQOjqKfPEdgak2u9LM
	3Kd5hsumdIaQFDz260FSaav0zo0PIhCnTryTX2w1/8yrf6fqiFBwGEcIl+milZertBKKfb835Fj
	gY1bHMz0eyQNBmYMSLVynzitZrFbDmvHo62YH2iO5zinj08ZQYKClGFtLjBN5jCoI3OQqoLwC3G
	VexUcc9jXFDGKNkdj62GKtP+b9m72KLgTo/w3fjT4kfOQgvs5aoEPgSj0B6EUPoDsUnLwaMs9Gx
	uPuCdxkF7RJ7QGYh598xGUxhTmJYLr3ZPASDZu8Cif5I+9nTy2g0hbDwg7MuDR7wj7HzE9oC3GY
	HzTpgYe/DJLZwzHmB5Vp//VLiKn7eIEhNj5WSq9dfsAGsrTyo8hYxuY7c03JbMd8FC2GCGlQYrw
	1Z/hWq0nSoDIKpcAxJjy2MqT/ynfbh9uAAcn14zteeaxd3ptoHvcSrpYUQ2YDgc2QPiuQr+oOd7
	oV2X9/uu4tlFsjgj0KYzoszF72eR87AIflW44Ar1qkGD7qcydqiyAXHYB2602UhRKNBEdez5vJ8
	4W+9yBBgs/xUvVaKDsnz1c2z5DpBpto6wgiTAOEEgWnAz5xcvMsx1aPObJ8k3y3rZwm4nQvFsZq
	afLjiR8gNGSHjtl02EJKPkVtt
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb887c34f1mr406326865e9.2.1795670873743;
        Wed, 25 Nov 2026 21:27:53 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:27:53 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v3 1/3] target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
Date: Thu, 26 Nov 2026 10:27:39 +0500
Message-ID: <20261126052741.90607-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126052741.90607-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
 <20261126052741.90607-1-haseebashraf091@gmail.com>
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

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Add a helper reporting whether KVM can limit a nested guest to an
nVHE-only EL2 (HCR_EL2.E2H RES0) through the
KVM_ARM_VCPU_HAS_EL2_E2H0 vCPU feature.  KVM advertises this with
KVM_CAP_ARM_EL2_E2H0.

The next patch uses it to let the user select an nVHE-only EL2.

Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
---
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      |  5 +++++
 target/arm/kvm_arm.h  | 13 +++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index c9387f5c8c..88e35909c4 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -42,6 +42,11 @@ bool kvm_arm_el2_supported(void)
     return false;
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 36a5faf537..8ef5597c68 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2178,6 +2178,11 @@ bool kvm_arm_el2_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2);
 }
 
+bool kvm_arm_el2_e2h0_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL2_E2H0);
+}
+
 bool kvm_arm_mte_supported(void)
 {
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 2e7e02e4a4..0916a5fdb4 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,6 +200,14 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+
+/**
+ * kvm_arm_el2_e2h0_supported:
+ *
+ * Returns true if KVM can limit EL2 to nVHE (HCR_EL2.E2H RES0) through
+ * KVM_ARM_VCPU_HAS_EL2_E2H0, and false otherwise.
+ */
+bool kvm_arm_el2_e2h0_supported(void);
 #else
 
 static inline bool kvm_arm_aarch32_supported(void)
@@ -216,6 +224,11 @@ static inline bool kvm_arm_el2_supported(void)
 {
     return false;
 }
+
+static inline bool kvm_arm_el2_e2h0_supported(void)
+{
+    return false;
+}
 #endif
 
 /**
-- 
2.34.1

