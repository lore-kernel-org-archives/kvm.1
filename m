Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034190;
	b=mBOZ4JwXhmoLF4qlrXx4QyZ0AaqdeZjAqJPec3ICvXZEXPbhlhOF3XKmkC8m1EfgjYJ4
	 eMc+jsve03YwJcml09A9onwJzkmXNGox9xRzb3fj5U1NuIZiQhOq3NHdm1MFOedRvVxYY
	 8UB0Gdtv+kYA9IdiFvK8feA66P1sfDbdY3ItTPHgYlzSGyHd/yVrYVOZ3ko14e/Z5yp0R
	 VkANg3gLYWVsTDjskTsKUZroWN9jjtyoFY1cRRQXG4XYFmuItRPeVKfa7nB9ia0o+5Hf2
	 RN/8vzjUJnZmd7hO49qSxKsQMozHOalMxbmLITPGJVTRQT3m3LeqYV5ILAAf3X0/rKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=7xlWmwrLiTN9oWrbWWc4bJ9ER2WNpvMfBsQ0dHA4HLk=;
	b=a4HTwQGvzi+/p+ps2PK5CKEGUj09qQ2gkWpfVZ2gYONwsT5FZauFAfL+5AdrfBrjsVnx
	 yyrUhIhSddGpBmgWCexDYCHpiU4DDwaCdkUnF3R7tRy1C6cm5flkBX9HwlcEqTOlEjBS/
	 9rEvMb4VAKCfQYxP5tJ3OGkCmii/SANh3WggJMvRyJOLh3MtN4BbcWtwoc3yzQ4tTLWTo
	 A5HO963j5u30dIQR0HpeYqFqGl3SArH9QejaM1IZetrlaVCfliTOBfbJcmCwwBoM8mqXd
	 vS1Gjs8grwZfDsnGnfuHWUZHdwl6oKoi4zY8ok75hu8G+8UDkzRK45LIvkrHZw5pLJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FV7UdWLa;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331860A3814
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 20:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C331860A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FV7UdWLa
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-574f8578e48so1508513b6e.2
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795034189; x=1795638989; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xlWmwrLiTN9oWrbWWc4bJ9ER2WNpvMfBsQ0dHA4HLk=;
        b=FV7UdWLaf240FsTMl26jhmqRWWzmP0NMj+LS0a9o7myvwKstfwaeO+Ufh29us4wafV
         +fRyfZ+zcin46W4jRbsJM0F1I26wVwcnhc3oXjmNucJXG27V24tAY9MRL1p7v+gXIR+7
         3tZ9q41K7yzzZeFO7kOkefrjF8V/mGOiMcCFB6Et9SPkEjoW0Ylwi89p/takEZvOpnrP
         bIstiwKuD1g+agJK69XKDTSmj/k/OFd5E4L9CzQOj+Qmof40lN1qUuRqPX359PjrcUGi
         94HmRwOJym1ztes/cTSq8b/UKruvHFN2ntB/PULSV8YBc2eUo7FK3Wuzq/9sXCoLIiQf
         dNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795034189; x=1795638989;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xlWmwrLiTN9oWrbWWc4bJ9ER2WNpvMfBsQ0dHA4HLk=;
        b=yrVZ99NgXb9M2o3m9KT/eNHufY6+AwtWgo+hL8QwCQlBjDZ/mu6nEmEVjwpFWFi2uN
         IiZlCpdRfpZxAPKwRrFOOsBq19We/QvF//6pAQeBC7Ii47XXuTjugph5dF9Uoi+3+cbY
         9SsRfyE9Hw27eF6V+t3xEe7/BM7DGARR+CpqzQQISbAEvMJ2b22ZxA7yzwklfjinINqp
         wgjBzhJknAQGgI8oX7dVP9MwJ3hsPrr+1MLPRPDXOtAGedKX3TKEa2t3GPsk0Rp/j3g6
         QzpH/Ns/7AEQCd78V9AhntLMJo62/zzSN5ThH2gY3YJdVvEwsqsSKkLWUal+odIukSVu
         lXzA==
X-Forwarded-Encrypted: i=1; AL+hErEiSTRTn12AUewltYxZZlO2Vo77/fxmZK+FhUP0R5ed6PM7lTDLtO3T4aUAlIC3T09UUYg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZL+T29/vpW+C9bfrrbkSUW6q8fmsHBVaMVg/l3IJUUR64M5nh
	D+0l5QVVj1ZKRQccuL4RIK/Wy2aKpsVMxtAUnczYhXMwUjheXiK0gB6JxdtUglhO9P/VqYvaufZ
	IASrqlwFsxmrDgjqI7hpuUJqsLQ==
X-Received: from iobn34-n2.prod.google.com ([2002:a05:6602:c6e2:20b0:9c4:bd6e:a838])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1927:b0:4af:5d69:1cb4 with SMTP id 5614622812f47-5773cd2176emr4714167b6e.15.1795034188500;
 Wed, 18 Nov 2026 12:36:28 -0800 (PST)
Date: Wed, 18 Nov 2026 20:36:25 +0000
In-Reply-To: <20261118203625.743428-1-coltonlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261118203625.743428-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261118203625.743428-3-coltonlewis@google.com>
Subject: [PATCH v3 2/2] KVM: arm64: selftests: Verify HCR_EL2.NV1 is RES0 when
 E2H0 is NI_NV1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

In a VHE-only EL2 guest (KVM_ARM_VCPU_HAS_EL2 without
KVM_ARM_VCPU_HAS_EL2_E2H0), KVM advertises ID_AA64MMFR4_EL1.E2H0 as
NI_NV1, making HCR_EL2.E2H RES1 and HCR_EL2.NV1 RES0.

Extend hello_el2 to attempt clearing HCR_EL2.E2H and setting HCR_EL2.NV1
from userspace via KVM_SET_ONE_REG, verifying that HCR_EL2.E2H remains
RES1 and HCR_EL2.NV1 is masked to RES0. Add a comment explaining why the
check is performed from userspace rather than inside the guest.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/arm64/hello_el2.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kvm/arm64/hello_el2.c b/tools/testing/selftests/kvm/arm64/hello_el2.c
index bbe6862c6ab16..3bd3596f5fb1e 100644
--- a/tools/testing/selftests/kvm/arm64/hello_el2.c
+++ b/tools/testing/selftests/kvm/arm64/hello_el2.c
@@ -45,6 +45,7 @@ int main(void)
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	struct ucall uc;
+	u64 hcr;
 
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_ARM_EL2));
 
@@ -66,6 +67,20 @@ int main(void)
 		TEST_FAIL("Unhandled ucall: %ld\n", uc.cmd);
 	}
 
+	/*
+	 * Verify RES0/RES1 enforcement from userspace rather than inside
+	 * the guest. From the guest's perspective RESx bits may be
+	 * stateful (reading back as written) even though their value is
+	 * ignored, whereas KVM_SET_ONE_REG applies the effective masks
+	 * directly.
+	 */
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

