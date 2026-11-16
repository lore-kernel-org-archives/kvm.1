Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859462;
	b=GqZ3EunFgtk2+LgH3XKI7r4y2pDjdneUi5ne80HHXyYyU8KzZaT6u7+7JCv/7C/Cd5o5
	 IrQQQM37U4BM3ElDzOOAF/bld6ZA9ZToCqDGw+iN18i6aBeP+7dFvpyrADeOY5pWpKGFB
	 QL/OVSlogeQTSzI68uV7hRhqVEHoUH6kgYQOkQNfFD07MlhfAIZX5DrMqtnbO/KuiF6Oa
	 wT4oyJlWQ0DXN5KVQmGM6JhnfvQ7ECBEGGs4q0B7PsgUQ3hHHoxLSjfumZfVrQ5YeiNaZ
	 PU/6BjXgqVVKlGdrHq7DE4jxmG/pWqGStrTK/sPEgalRLrav4Jzfkbcr/lKu/fDvhYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=nMypBwJnR0vpA1cBr9OnEsaSU+Ny4MYTCLPv64i3c3A=;
	b=1xreoDMAK8dlsOshX+2ifOHBesmdQq0y4dTH7JrMG46pPQCKoq+F07ZAEqVRBLfA2UrA
	 B5LpWTXzbK4cybDeeFL+1IMc7DG+8ybDrAq7KjkA4iRbXamqRz4Irk5EZaLrnSn5pIjPq
	 w6gaES+5NtsAE5IFAl4OccP50qR96kQUZkLxzvPSQT8XcuJpAEeuP8s172LnechKGPWZH
	 9H7u4rPItLtdfrAltNucRIW7fYBJj8488mz47WuRrs5DHdX5XbQaFduuugLIanmR2LJoh
	 yXq/H8o7nzVpdCr9LQXFrnUf99Lm9L1zXXHkwTLyYV5iI8SW2O1nr3h4TtKvB4hcGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kPIYM3ie;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45C606A338
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 20:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F45C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kPIYM3ie
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c55ba309c2so4637843b6e.1
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794859462; x=1795464262; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMypBwJnR0vpA1cBr9OnEsaSU+Ny4MYTCLPv64i3c3A=;
        b=kPIYM3ieVnPcw6Zy3QQxDbKyzlwO/aI32pyV8OzJIWUJRhrHVXATZCnq5Tq2ejeruB
         yCnJqDJPh7dP8t0/aIlXnbSOZYtUZTgSudlZi4DYSuS5+TDlfHPyHvmh6Sj78VnIoy22
         y1Fjs808mkk1cYkQCHqZ8t0IYYQgvMiF/h6MI/5txVIgF9h9jmWaeiWekDlh4LEeWBvC
         nwhEV70jEz1dVR4ikuXtjY45COOXGL1Vo8E6z+mjZio6v6C86hDGZSMHj2IpTI9+Fv1k
         0B+8jO3Bnil0kBzZH6o3RG4JxhC6pDl0ER3T+AzWqcUQs5rnVPCxZ4iCOnAGf2hgaFK+
         rqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859462; x=1795464262;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nMypBwJnR0vpA1cBr9OnEsaSU+Ny4MYTCLPv64i3c3A=;
        b=G2jCt18X8X8dTRHsjDnF+ZyEaU6ZrlxPHajUSjwEax/dD+WQnZwpmRfDzr5MhbTrHl
         4yD+85NbL6cwzfFx6WHBHkfstPSs1V2WJqa78anIysvpApIWfMDh9X1kfRdNtait1O2y
         XGyRdG726P3ibxhKVCiISvjctV1wR7InQV1tev5LGFFABMvb2o9aCRx9qIIJwe7Qqhmn
         aUB5eadx8D2B7+bjYhn3BydwpZ7i74yHMh3xT0qe2gTMhfkCGeb6nRkT08voWWZO+ao1
         ICQH+79yxaqOddvbgAwpHJsdjFQGW3k7xDaZ0jjihmJ0Ns4aAmEuoorKStBYiyWRDWo/
         bFfQ==
X-Forwarded-Encrypted: i=1; AL+hErHvy918dBOV1Oo97mtV2cgIRLcGVc6nZnpUc+z5vY5bCjrtSjvVcC6GUQ4dX3rYOFc9QT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+EWKf7HBKB/fBHEdsEz3j7g/bIVZ1DU9Q2lZFkPW6OkNFHmR+Z
	YjT60tqzGUp6ELi5ZhtKdGqkdAY8XkXRzL5MiapLdHXuG4vG23z/ehnvYhQrZCJQJ4+hSrGwKGw
	Q6+N1gWf7Zky3sJkCgibtzCeTXQ==
X-Received: from ioo28-n1.prod.google.com ([2002:a05:6602:865c:10b0:9c7:7732:c3c1])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2383:b0:568:e5e:8058 with SMTP id 5614622812f47-56e6378f81fmr10829049b6e.19.1794859461431;
 Mon, 16 Nov 2026 12:04:21 -0800 (PST)
Date: Mon, 16 Nov 2026 20:04:18 +0000
In-Reply-To: <20261116200418.3535619-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116200418.3535619-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261116200418.3535619-3-coltonlewis@google.com>
Subject: [PATCH v1 2/2] KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when
 E2H0 is NI_NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

In a VHE-only EL2 guest (KVM_ARM_VCPU_HAS_EL2 without
KVM_ARM_VCPU_HAS_EL2_E2H0), KVM advertises ID_AA64MMFR4_EL1.E2H0 as
NI_NV1, making HCR_EL2.E2H RES1 and HCR_EL2.NV1 RES0.

Extend hello_el2 to attempt clearing HCR_EL2.E2H and setting HCR_EL2.NV1
both from guest EL2 (across a trapped ID register exit) and from
userspace via KVM_SET_ONE_REG, verifying that HCR_EL2.E2H remains RES1
and HCR_EL2.NV1 is masked to RES0.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/arm64/hello_el2.c | 34 ++++++++++++++++---
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/arm64/hello_el2.c b/tools/testing/selftests/kvm/arm64/hello_el2.c
index bbe6862c6ab16..46b0f63e199f0 100644
--- a/tools/testing/selftests/kvm/arm64/hello_el2.c
+++ b/tools/testing/selftests/kvm/arm64/hello_el2.c
@@ -13,13 +13,29 @@
 
 static void guest_code(void)
 {
-	u64 mmfr0 = read_sysreg_s(SYS_ID_AA64MMFR0_EL1);
-	u64 mmfr1 = read_sysreg_s(SYS_ID_AA64MMFR1_EL1);
-	u64 mmfr4 = read_sysreg_s(SYS_ID_AA64MMFR4_EL1);
-	u8 e2h0 = SYS_FIELD_GET(ID_AA64MMFR4_EL1, E2H0, mmfr4);
+	u64 mmfr0, mmfr1, mmfr4, hcr;
+	u8 e2h0;
 
 	GUEST_ASSERT_EQ(get_current_el(), 2);
-	GUEST_ASSERT(read_sysreg(hcr_el2) & HCR_EL2_E2H);
+
+	hcr = read_sysreg(hcr_el2);
+	GUEST_ASSERT(hcr & HCR_EL2_E2H);
+
+	/*
+	 * Attempt to clear HCR_EL2.E2H (RES1) and set HCR_EL2.NV1 (RES0).
+	 * KVM sanitises VNCR-backed HCR_EL2 across exits such as the
+	 * trapped ID register reads below.
+	 */
+	write_sysreg((hcr & ~HCR_EL2_E2H) | HCR_EL2_NV1, hcr_el2);
+
+	mmfr0 = read_sysreg_s(SYS_ID_AA64MMFR0_EL1);
+	mmfr1 = read_sysreg_s(SYS_ID_AA64MMFR1_EL1);
+	mmfr4 = read_sysreg_s(SYS_ID_AA64MMFR4_EL1);
+	e2h0 = SYS_FIELD_GET(ID_AA64MMFR4_EL1, E2H0, mmfr4);
+
+	hcr = read_sysreg(hcr_el2);
+	GUEST_ASSERT(hcr & HCR_EL2_E2H);
+	GUEST_ASSERT(!(hcr & HCR_EL2_NV1));
 	GUEST_ASSERT_EQ(SYS_FIELD_GET(ID_AA64MMFR1_EL1, VH, mmfr1),
 			ID_AA64MMFR1_EL1_VH_IMP);
 
@@ -45,6 +61,7 @@ int main(void)
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
+	u64 hcr;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
 
@@ -66,6 +83,13 @@ int main(void)
 		TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
 	}
 
+	hcr = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2));
+	vcpu_set_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2),
+		     (hcr & ~HCR_EL2_E2H) | HCR_EL2_NV1);
+	hcr = vcpu_get_reg(vcpu, KVM_ARM64_SYS_REG(SYS_HCR_EL2));
+	TEST_ASSERT(hcr & HCR_EL2_E2H, "HCR_EL2.E2H should be RES1");
+	TEST_ASSERT(!(hcr & HCR_EL2_NV1), "HCR_EL2.NV1 should be RES0");
+
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.56.1.750.gf70dc682cf-goog

