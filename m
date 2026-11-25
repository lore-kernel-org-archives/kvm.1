Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589802;
	b=r/Xqiv3MDvhn41C3zIYnivHFmEmnT8t8dr336BdeALTyLVqtz00/6TgpqeQB/VHOtWme
	 pV++IyZhdsI9Q9Bnqr2IsyQ3209Cced+cZpADvEn+XYiG8xQBe+oE0/HRzdHLC81gwKn2
	 LJ38106NErsPbVfy+N6CWaLO+KQrNtUeA/Z1rWpTXNCS01OWAoKDxwIyESmWlTRtqx4YA
	 nX3z1cFdeBtd2BqBHiNKPDi735pSf08Xbr7hI6RM+v6bBJjiWoi9uevvf5ve2B786Vx1E
	 8NOz2k0fX8uVNLKRjV8X/RgKtPk2mrWAQZGtlzT3KNEfUXa+/toeBtd1stqlkt1nA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=CO0vZwWHnFlrPlO9I1IjS868FeGKeBrErc/5Mvm8QC0=;
	b=qnOiM08+P2pCYa6r4yF0oNWl82zH4vGhCOZTnATlyTmKPGFhzt5mG64jLbfSc4fgxya4
	 +TNXXI9rMigdcMt5msoUrts9TMHMdB0I49YIb6qiVGXP6+YFvu/wQ7FS45BWYMDi0eeD3
	 zWgFf6DIe2Lt7m+5ugKvykoW9HQytyoiUqtQKU1ZR/Q7NGBlT105gU+LjRXAfGSzQu2zT
	 KjN8RzFgLBQ4IHoYAlzR5W3hxj5x5HSmyTR45ckHTIdYZVkZFFBun6Gfb90H/eUS32sbP
	 Kf5kedaKMD4accrphVd5B46L398e5JeK+5TFQUexLIr9r6gn0p2HXNZCwqf80lxQbtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b="W5U/UJS+";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976E8606A33F
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976E8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=W5U/UJS+
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a9be758734so3345466f8f.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589800; x=1796194600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CO0vZwWHnFlrPlO9I1IjS868FeGKeBrErc/5Mvm8QC0=;
        b=W5U/UJS+7cfwYVajRpOi1u5K/6enm8FRZrPwbeutwCW4xLqgOknI08L1TNMXxVbepI
         NbhoW10qnRAA/6YxRG/xf6WHlyq7lrXl4tlqcWW0vl9JbeyAU2F3GWUmBIkHyfAcr10H
         NiOhpglsfS50EIaUgLY5CoBeg1lqXcUUYcunr3nxmU049foJ0lSaknlm87DL8j1jE5b3
         2JPHzJSOzbE2aOUFuJXAtR6mCyIxkqZoZ8ub7iJ4GUNATeuKGpJQLio5moQvND/BkYL+
         uaZjEirGchKB3KaH91m02dg/WQmcrzfDBlVIBBWz7JVCKI6AkOhDFcWe2HjWBUSP+4nQ
         E2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589800; x=1796194600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CO0vZwWHnFlrPlO9I1IjS868FeGKeBrErc/5Mvm8QC0=;
        b=u6QT3MCv57W7x0j3BTdbacORQQlAwd37CznSV5YG2gspFHgUGn5aOUzvnZkXPPDzpz
         suMt3glm6SrPBAllwHOSHZ6ic/Cc9lttAQ2Sz9pbp6KmgHEtQTjzmN/qz+3TnH/qAKVJ
         y+OAjRAIYHw5Di6XV78E4uNS8pq1r/YxyCMlTB+LnE95QGVD+SwboH7iKWSVaDR8AGFy
         rU5x64M45brt0KWkoOEeM1sNaGKN1R5IkbE4yjYdvnLQe2ptF2qeH67HZqq82dFIaUX4
         v3agTm5WVRRs+WNAJgH3RoQsO2wH/81YxlcAieAUeFWLE68JzeWLkT70CFYKkpYXcCNO
         HfGQ==
X-Forwarded-Encrypted: i=1; AL+hErF6/s80oZDZY+fB1XdVl4cEAFB8KhFSp9rMdDFm/NY/xfnOzYrk/vwAZtDbpkUKccVBkHU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w9m+6zJgvB+t7jIsytvukx/iQ6ug+c0mDpjPwYbRB+8aBJVHR
	95d+2u9zF3tTec8F7PR7VAUrmS6k3mm57eTeL5aXncw8bFSZFUW72oohSYL/cPFSP7g=
X-Gm-Gg: AZFdTZd+7eM07Zn/P40qJj41epWWGYgwm+XjrKgofq0bpr7Y+G6obLDKtQ4O3/asX5h
	HiyvPcXkd1aP3nOixiOMfhQY81aJmjy+iEiSXZO96+OiC5/Mg34M0voPyS06HOWvmFaAxwpu2e7
	T0E8Yk/YVaJcT7hXcIYeQ/cvYwzPpJYVggf5alYFTcVaNVUZ8WTYnmQM49jei+0teKp5bdhLfNP
	IDnfqgVVP9IGU0Yer7NtYDCHGmP06e8uhOLPU0nDHl4tOCk2csx5Z6CvMxLfRN705UJ1bsr+Hu5
	XQSQNDOU06yqYmje1VHjeJYwBDKuuyjFlMYKu5Pn66TBEJqB5yPMPO1kodvmXt8ZI4pztKK77hE
	0n209+q6ZqBrb48L3C/q3vriypjs/p592axCZyiGG2V139CXQZjMOmsaNjwvRRLCtclxE9gt+s1
	b9y4pgzov3gTdA5EYL7ibxQ15H5S2JXC2ZXYeX78a8YyH4TfvqKSPP0U4aLrjEV+MEaRvTbrXqL
	D4FlaMI9XeIKaHayW0dndMzaFQiMvE1UZ8pu9vMGu3c03xc/9FcTq7WGwDeY7f7JSE9hfIxIdz7
	79iaqHreGnaMOE2RaNo=
X-Received: by 2002:a05:6000:25ca:b0:4ac:7595:6f67 with SMTP id ffacd0b85a97d-4ac7595721cmr27351070f8f.40.1795589799898;
        Tue, 24 Nov 2026 22:56:39 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm32730554f8f.28.2026.11.24.22.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:39 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Date: Wed, 25 Nov 2026 09:56:17 +0300
Subject: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1 when
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
Message-Id: <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
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

Resetting a vcpu keeps the old values of SP_EL1, ELR_EL1 and SPSR_EL1.
Commit e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
changed the reset to only clear the general purpose registers, SP, PC
and PSTATE, and later commits moved these three registers to the system
register array without a reset value.  Commit 85d703746154 ("KVM: arm64:
Fully zero the vcpu state on reset") fixed the FP registers and the
32-bit SPSRs the same commit missed, but not these three.

The impact is that the guest that boots next can read the previous
kernel's stack pointer and exception return address.  KVM_GET_ONE_REG
also returns the old values to userspace, and a rebooted VM doesn't
start in the same state as a new one.

Zero them in kvm_reset_vcpu().

Fixes: e47c2055c68e ("KVM: arm64: Make struct kvm_regs userspace-only")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
 arch/arm64/kvm/reset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 26081d273408..9c1b42890c96 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -199,6 +199,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 
 	/* Reset core registers */
 	kvm_reset_vcpu_core(vcpu);
+	__vcpu_assign_sys_reg(vcpu, SP_EL1, 0);
+	__vcpu_assign_sys_reg(vcpu, ELR_EL1, 0);
+	__vcpu_assign_sys_reg(vcpu, SPSR_EL1, 0);
 	vcpu->mmio_needed = false;
 
 	/* Reset system registers */

-- 
2.53.0

