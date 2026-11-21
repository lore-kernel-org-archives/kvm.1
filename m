Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293973;
	b=aRRVRIvfHMsc9KQNx40bvxCGFff2dlKKWbV7BeyzlNJ7v/Tr+KWXTUKMDCLY+NodkmqT
	 PhrEE18lwTlAPS4y9osNzLzWx9Qwv2boPVZcIv/rl2UwKRDArRFcriXrdcjJgRjZdjCgJ
	 kvOV6Pl8tohMpZsm7w3oaMUf8dbD/ix8/CMu0RjKUKefwHGCQVPEEkdRB5e8SNyVXTXLj
	 eFTJqeOUYrvtcueiWVmY5ItrzsOBDMl9Ck23XEfWqE2du7g/Tpb0/K3WApBBHXviUz93V
	 ABmJCGbWqsKWLKHzGPkmcwNFgVkV5JUpoirksV6va0hzRfezu0silVbbUniXexsvUog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
	b=c8Bx6ivHtKiDD3vG3ZtQETr8ANbK6XqOAZn3a+hlg85ZJFbX1TfgnVtl+GdLZeNbqePb
	 scFNPoRCtXR1Th/VzhfCuaHnGZOgNkUhdWjfvxTzrXwY6V0SCUoYH34wi0EBpFuy9o/bw
	 U73d6cLn5Lhm0YFQffk2G3rOka2uh0mAXnv4qLlThYCTupcZ2c9wx3EWF+GHupKsE6NEz
	 N4srHweTncJkQByoomw79zav87ZQOvg7+mQKfKjLfLIN1ilkGV46J6faP88uUKEB+01zq
	 LmtZS1KBbuqfCTFxXJ7j2QnlJWJE2SteH+iKmxUAMS7AG56t1yRXkHblwkLKpLyvGOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bDxoDuF/";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F5606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 20:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 266F5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bDxoDuF/
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4b467581b98so18773885e9.0
        for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795293971; x=1795898771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
        b=bDxoDuF/TNuE0QPVD3HoUpk7igtlTF7aoLO70tJbpRbnkpZqbh9YA4+ZJS7+9M4uxM
         oVipd+R4Zcbe2N+ru45RwOPhIhOTKm2mE41iP/I4rgqTeJ8uJtDIhTw4udWuiBfx4L8I
         9iHg5s5uh+crKurWI1Sy6sayuLlSnyJcIWQ0ROFSB0Vnj3GNA9e2GPu7zlMtqd+b+Ipm
         xpZLeLru1/me2ZSxajG8xdMTQ5xnro7gV8bz1Qkwju3rTbe8xFHCVJafNRowNWJNUd5G
         VGGlWRjJIyPLjumhel1Db6/qxa3aP3Xq6phxrcLuMRPwwSe07cwEdVBGLGkoPn929jSL
         8h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795293971; x=1795898771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cw4bVM/elmiYBT/hpISiGamNAca35rw9WaolQpyJgc=;
        b=O5QyOsp1SgL2vn026s00nC3Kao3c8rVPSTByBCfzP9OqU67IhPNtB6g2MjyYfkFUVQ
         rtJt7y3VT82JbWJsHWbFlyh9pZ9yyRSqSk8UrwW+CO48ohfnud5SVb4jmvpXpy1ArEEK
         cxe8ASUDf7zNiiaQVIr3+4SjA7jpRFpuWAhNNwx16B9eLObNlcJmrpLa0fhCdDUzad5F
         ThpOIS56cXaafPDpZOIm6A9CIlg4vMM7Z/4e38iYmH9J13WcpOSLGVSkfLDVbeh846yj
         Nbx81rMfZ53HCuNnNjNQcW7L9PUc7fm6ShUF6tz8SpLGtZlU0/oPBsIPw/AHPNl9pz9u
         u6qA==
X-Forwarded-Encrypted: i=1; AL+hErFucUdwumyM7yovwly7rR3DTgOww7fFFEm848x7rJ4vcVIlwlUDtC0Uw+8Ez1l8WXcRONc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8T7us7T3BYqLx6Z5HgPSfJqxCOEYhsasZjRSpMAJ6wYFyCjR4M
	7OSmRT0m2CeIZR1S3j/I+4qxRPEjCjSmMKb3ln5JjJ2f4KRmcQXLrLFW
X-Gm-Gg: AZFdTZcoUbLx5hKNGd+XXsxDZO8EyhsJoU2bpgVh/Kdhefgqxo66k3Va16feQdJEEMu
	WbcQj5lkkwLUKRlBowE9nTPJalAoJpIOOKqA6lWOkQWKaVdKWMGZOEX8wvSr4sT/rRw4ezBRkv/
	WhoriLEb8eUR2EQpPeegLvmgXRyJmAK8OVQOfS2XMiM8j/mio/k1nrWCEeD8Z1QbKo7wOo5+2qU
	5ejY76bP579gpxNrK134abDCUuNvCqr4tesOBStOM1xHzsSWkB7Lr/jhH6aHaT9cmlTsQ1nJ3vh
	3e1NAu5Kx94RvBQqJ7JEhrE0VsvWNjOvlMvjWMZ+aD23d9mQZ5nbpk3pQhzLQf9E2irowrmA1uV
	0sjxtJE9MgGBEJA4m/8F/HazJufZDEKw0nNgL1TH2lsKiUapv40/0ljUbE8XN3iw0V2XisQUntj
	TVwXlp/LoZgzLPwdY9q9x222RkwuNG0rlJXAfTJBghp+ZgpgalS58XqTQkSENS46pCQh5arbo3q
	1mKVExHsGPbN3LEfHXM1igQ1y8gEN6yCRfsHLuuNhtcIe4X614XDERRe2eMomcgt7jfSS8QhZPv
	0QM0lNR6dWVRS3it6cSQz7q/qXkk5LO1i6fch63N8Wr9e37z86OVXLtceixkr8Hlx/bE5Y/10Ja
	fT3ukpHjfmFLl9dJhG3IOTqA=
X-Received: by 2002:a05:600c:190d:b0:4ba:2bfc:c8b5 with SMTP id 5b1f17b1804b1-4bb888267aemr149715085e9.10.1795293971472;
        Sat, 21 Nov 2026 12:46:11 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.59.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm180652385e9.12.2026.11.21.12.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 12:46:11 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Eric Auger <eric.auger@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC PATCH v2 1/3] target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
Date: Sun, 22 Nov 2026 01:45:59 +0500
Message-ID: <20261121204601.741616-2-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121095636.289814-1-haseebashraf091@gmail.com>
 <20261121204601.741616-1-haseebashraf091@gmail.com>
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

