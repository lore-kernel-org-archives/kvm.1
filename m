Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589799;
	b=GUbP3cZ1U4h8RoJCn/2LZuAUHfZiN55GNntPwNM/qmzQNrhcgh58vbZAwz7ZACZzENdp
	 Ixv0ghV4G/FpmwF2FaljG2AMwQzuTV32WwfPKJ6CWrdG668MCS5LohgFFRIXVcM0aYG1E
	 BCxeggtVYjXlH8H18VS9bbk5FSB5iLtgnbH1+GANUhMyBxFuMLkZ1oqmdDhJt0aDGweok
	 TEvpT+UlDaUIiOGJuHyZ+Hvk8dpUkooItsW55OV+d3Su9ZUSJramKgYnHlDJDAJYSVjLW
	 XINg7DJBj1rqKmeUjPrfbaUkt5+ZGQjVCHAKR1H6XVA/xsRSlUVjdFDvUjKT8s2fhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=4BneDH3BrmldgDuSfaRvWpkmdpUNgHqyqEERpyedMrs=;
	b=aDoPHA+qY5s5CxChYgEsfN/MpRuLuQYV61gpiGtEOIGQ1QJvxzpX+2Tg1ALBfBRfC2C0
	 5Qhn4zu5zz30w+eVO2x88MVfHiSCtdWgcPNtQP5hRhqzAmG61pjsqPjXDHpLH8ragaBrE
	 7mdkZkuAii2+kslkzrl3bOjvSYsFVgL1+Th+z31IHDbDBuC6oYnqpr0/zYwVucpiKkViZ
	 Q5fMcWNzElO/tr4bgA9oCRh3265Dn4GULq7epwqDkdmOMH+FUuPg1qE7Oc8P2G7Pq1B9G
	 8RQsAMSOFPH9fkMvzj2NYoII7V7DxLbEIKiBhYWlsmnYdye3BEnv+NQqWEz+ouvrkew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b="XBUlah9/";
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD6606A338
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFD6606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=XBUlah9/
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso4714680f8f.2
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589797; x=1796194597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4BneDH3BrmldgDuSfaRvWpkmdpUNgHqyqEERpyedMrs=;
        b=XBUlah9/GQf7hrF7Fc0I5v9Mld1l9uEgPBgSa5e60UnZPTMgSRfXCaR0GlgV8QtsEW
         1l0+3I4zvi7ugP9docqB6bogu8Gcz+3Anw3I1KziFN/T4+OhQcLzpOcC81HZwvgt9xBs
         LDr9jUk3cEoqQp7xe+AX5X8HwkkU4Zdh9NNYJIhlYeA4H7NYoc1BWGCT8QlfWStrsSk0
         1KW71nEYkMXf/XZcyuNB+X6qqw6vtzX9DhNm0kca1awI9gioFCYhsw+fJWlOY24Y5ZPf
         hr8GNgaiWxmZtStudQtaUeDZkWOWNpxD2oUuH01qEMF9GH9qzlW0HWGQyLgAbUPMG086
         Gqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589797; x=1796194597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4BneDH3BrmldgDuSfaRvWpkmdpUNgHqyqEERpyedMrs=;
        b=1QO4/WgRJcNtomCTcpPdcGZEtQ/KpYu7prNnkG23uvS/LGxjIwh/iTuJnvUqAc0GcC
         nYSW7iK5/6psEccOcOlPGT0iHUF9oeZghf5mtQFIzSTv+bzHdsBB46LaMt1cxYdYQyQl
         an+9QH893PwpUPcSMlZUP0ArzouXYXJSD0ilnBLgmR0ERz10jWMjufXp85JwQY4XU9SX
         PyXyADi/NCEpckZnBjH4HmkyeqjiF2svZClJvfWJx7K4OZ56M7gV1iJYqEGB1SRlOyC4
         gthpfaOXRvU5M98CXoJ1XdrOCB34a8JYFLTzI24HGuXe6GYVPVte1l7b29VJQQGy+O4s
         OHJA==
X-Forwarded-Encrypted: i=1; AL+hErEifwXoCefZ5KFwZxeAoh4Vc9Urv3wLGtg99K/HG9/SSH54KFhsQ3dDUFDIQn1g/UIc7x0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UXlQYcPpE4eUqPDUQ6RC2XviBVk9UwiHIXRABNvGEDZWT5IVt
	UFOTuErVJkXwwLMRRiKbq2a24EYfqc02OyWYLoA+rh4xZtqHKvIFWH5Q2A2p/5svlUA=
X-Gm-Gg: AZFdTZeBMyRIPSVxQSlEgjhhGUFUoIQqGzEtM4KJudCcHCZ0NLYV6cChCsIW32ofMU1
	wIpIrFTiXhDxGHkyZdxSStw4CjICR1DCtoIlfsfKSFxLrJXpFudvdBY79QmnFZE+SKtl26Nu4CH
	T2zDZJtgFhLrO4nnZsN42BOxT1KrpR5q2FmtIdikWhCubOMqHwxtnynIT+/RiprazOunAnMgZfq
	qf455LA03hUO1RPMT5/mCEmTArIAjF4BT0dwfF8QZgI+fd3EgBiMtJmYBMNnOSAF20oNVkLqZJk
	xv0E11uIE+I3hxdbqU1if+BrCbwrSaEKIoVzvqfSRt3BLZYnJ6CzIPqFTsyegyKe4tca5qIo17/
	d4BQIcadZqcqop7Zbhmjjpoxfy/uvKeSx91cJb/2A95ZplCt+FJHIozOhAC9bN1xTSmKRXdjicU
	R2tDa10aJOdQjBhyjDT9GPdsPyIO8+apoIzPQxj1P63NJfuz3pwkHerlM9lBoaeTJbu7o7vFwYb
	TKT2jVyy63CihN0BFfQ6j6QE1zmPAWN4QJT8tjUI2yP/dAt6kbL9nlf+Hbi0rv7dqtu1K0d8aKB
	Kbv/N0aeLt/dWgbeqVg=
X-Received: by 2002:adf:ee47:0:b0:4aa:5396:a792 with SMTP id ffacd0b85a97d-4abb514608bmr25076345f8f.23.1795589796866;
        Tue, 24 Nov 2026 22:56:36 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm36981016f8f.24.2026.11.24.22.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:36 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:16 +0300
Subject: [PATCH v2 1/8] KVM: arm64: Drop an incomplete MMIO access when
 resetting a vcpu
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
Message-Id: <20261125-double_exception-v2-1-224689d8a764@pereq.eu>
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

When a vcpu exits to userspace for an MMIO access, the next KVM_RUN
completes it.  So for a read, the next run increments the PC counter
and copies data from userspace to the destination vcpu register.

A reset should cancel the MMIO read/write access.  Otherwise the next
run will copy memory from userspace to the vcpu and increment the PC
which skips the first instruction.

Clear vcpu->mmio_needed in kvm_reset_vcpu().

Fixes: 45e96ea6b369 ("KVM: ARM: Handle I/O aborts")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
v2: new patch
---
 arch/arm64/kvm/reset.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 10eb7249aa9e..26081d273408 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -199,6 +199,7 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Reset core registers */
 	kvm_reset_vcpu_core(vcpu);
+	vcpu->mmio_needed = false;
 
 	/* Reset system registers */
 	kvm_reset_sys_regs(vcpu);

-- 
2.53.0

