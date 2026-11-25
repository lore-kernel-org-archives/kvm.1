Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589806;
	b=K/e4fsS1tSi/P5y11vZNJwdJvnuRJNBRQv5VGJ5bd1OSRqBXF55kn5vRvRqYnbIx0CGh
	 z4C7rp0wqFk7i79tuAQRWlQ6BSXIVPZ+ARw5X2Sx9GgogSGWqiOzwPljr86rhJqmOl0cI
	 x5pbuNjzjvxQHLKBVZqyKR8lkGF4i0ORhC8p11NpeKkLqRVd0+4sW02nFFpPZfzXdYG+7
	 c/R5J7l8mndfLuVY8HkiToM3ixgYuzTQBpvGoHG5FG1JyaHtx7LUYkj5MHwRy61U0cD1o
	 YoRqtrYUmmKlMgnCk8IPaFfSYA0LrZcQ9/0assgvqf9laY5NNhVqz8551qnFgJhW7bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=QoytpwQW2+7nMQ4LJ/J4mzx2IC+d/7ZRY8SoLyVie08=;
	b=o1+W/M/VJGeznEwvZwCo6RPWPXWk0US3IIWfKVARC4hAmGNRTke7D0AwBt7Gxz1dsD5A
	 gC3NGdMdRVGejEY9daFCF0SOSGkCHDbR+/+NZPEJcTELsOwdYnUyKUQB5OL8hRIc1mhmY
	 dcVnCMSntgMufLTEsAnR8SxVLuI8BEvk9Uqt8eWqHvBoZKht+Pt4Fy7jtaeI5/DCcz5Au
	 YqH3iOowvg06q9MBZy7F8NcqRrFtRfLsn4ttG3w43nKbK6G4Ki1CK0sTBGQ0FaYWbeh0U
	 Lk0TJwIj5O/oMNaLVWhxke2MhhjNXBr9in2/kM2TA2KrV1j/vpPUdDb3TvsfG+yqT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Qwu4TVHn;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A029606A33A
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A029606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=Qwu4TVHn
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-492690dd5daso4061511f8f.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589803; x=1796194603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QoytpwQW2+7nMQ4LJ/J4mzx2IC+d/7ZRY8SoLyVie08=;
        b=Qwu4TVHnW5keU4MSRtovHL3kWNCRibVMHT5yd6sFTANGcYG2F4QtvKQtJk58u0+Yw+
         GIxNJ0WrtEkkB8C0DhGkPNDoddvnXaWkhAEyfpLWjA6Lu5seBZJZ9woFcCEFD9Dhrpz1
         2+8yQVao6dgIYPABEpcwn8VFa6A7M2iE96PhtMuKDKuUgyDcM+0g4tpr20TLFQU6CE+Y
         VL1h7ONRvNATfpbYeEWlgEL7xWF0d4O0km2XkfSdLjFevIBYdSfORFIIilnHhPyVCake
         iPNrytXSRzPAzRZLHcHvzauBwBEu5RXzAWCxasQm8qpGi0yysz4fgLPuKbj04m/Dm62n
         +zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589803; x=1796194603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QoytpwQW2+7nMQ4LJ/J4mzx2IC+d/7ZRY8SoLyVie08=;
        b=z8bdkGOXzYl89stxtTuGGXrc464MndDSQr207l1Fk0dNPDPWBgQ+LpJSG6TVsJVaBn
         AvzhkF7T/Ml6WoprwqBYrmJKUcxa1kg5xm2aOoxLEYwQjdvrUZen7TvBsPS5z3s8q8zv
         rQixZCQMHudlHzMU/APkdk7qARVfHJ+a35f7T0aKYMGXDtLPd3z2MXOi8AHuWK9/7C2G
         16jRTmcOY0YSvKrw+H27LxPEyFrKJGAcQEwfoFtx9jG+aObaAoxI3yQNH0tcBcjteyUn
         xgh5Ac8+RydXTDz+umJuD5Hqg6ZfG1uz0PudjV5NRqmwKMdCJ9aTz6+OFUOmcRGgtRT6
         6sKA==
X-Forwarded-Encrypted: i=1; AL+hErG9jXlSInwkbjt6Gk+xpOU+sh8U+CpfPtwPNDBAzJrdKo8tUKSiqyLiaSvDaMklYo8Kg+g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dfeOxSIoh0hO0iRwXqlKfXGmTu1//Sycog2GWd08wUXCFje4M
	RmM6aNQkiMMM3IYVdLI8Z93WbUQva+rY/ARWzJkqZjHEYVcMiSj4z8wKlsf3bewFqVk=
X-Gm-Gg: AZFdTZf58VS6j7ORlOvYQJQrwoxlLQqFlc8cXleTl4FRt0aLpDVaQshUFohsdkKmEtD
	mAJL5ezpxw7KQ/aw+HQA+BUjSxLWKle/Zvb9iK3VYIQ50PXyI5RztnEPzV/Snxf1sp54sPrF7L7
	JSwZfAE80mMX+hhV1e6JN8ga/QTNFX+Ewro5NDRV/UCdYNy7il5ErdXF/jpvq+J3YahmUuQFC81
	0nXA7DFYSiIz0h4x9S/qKDRmn1CHmMkd5Q50VWXYPTH35n6AeYsgOPSdyGMM2vcT1jouNirMtcp
	At5siurOcWVG3qMOt1cH+AnTsjpc6Mv5UfDcQd2v/3InZzC4RclvV2W0NjErgV6lVeVk4mCPWZV
	RQ+8RajvAyoVTeB/00EQpyQFmY6cOnyudB2sy8tUvk3cXe5zzrgxKtZTKVnAFNW6H+vZ8UQKVfr
	H3sAuzoHrQEwjaVwWXM0xGXWc9Hcf1/DlYVfWRIL2++H5MU2VEEcr2GFQoMatdlRtvfK3MtHGR2
	4hslAUOV3qejADm6jtSKVYisZso92yt2WmChh59FAw7b8pKgrZ8Dm9WKWKALlODzo/w3zKEODg1
	lfeEMy85/YGn6/8cIoaG3MOiiF4/O9MvUTLNn/ey
X-Received: by 2002:adf:e00a:0:20b0:490:1881:80ec with SMTP id ffacd0b85a97d-4abb3a4d2camr23594315f8f.36.1795589803330;
        Tue, 24 Nov 2026 22:56:43 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf6804sm31864281f8f.10.2026.11.24.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:42 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:18 +0300
Subject: [PATCH v2 3/8] KVM: arm64: Discard a pending SError when resetting
 a vcpu
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-double_exception-v2-3-224689d8a764@pereq.eu>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
In-Reply-To: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Christoffer Dall <c.dall@virtualopensystems.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Sebastian Ott <sebott@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>, James Morse <james.morse@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Blaudeau?= <clement@cryspen.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 Dan Carpenter <dan@pereq.eu>, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0

Resetting a vcpu with the KVM_ARM_VCPU_INIT ioctl keeps a pending
SError.  We used to rely on vcpu_reset_hcr() to clear the SError but
commit f1ff3fc5209a ("KVM: arm64: unify code to prepare traps") changed
it to only reset HCR_EL2 before the vcpu's very first KVM_RUN.

If we reboot a guest while there is a pending SError then KVM delivers
it to the freshly booted guest.

Clear HCR_EL2.VSE in kvm_reset_vcpu().

Fixes: f1ff3fc5209a ("KVM: arm64: unify code to prepare traps")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: new patch
---
 arch/arm64/kvm/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 9c1b42890c96..a5d298d5ce61 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -207,6 +207,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);
 
+	/* Discard a pending SError */
+	vcpu->arch.hcr_el2 &= ~HCR_EL2_VSE;
+
 	/*
 	 * Additional reset state handling that PSCI may have imposed on us.
 	 * Must be done after all the sys_reg reset.

-- 
2.53.0

