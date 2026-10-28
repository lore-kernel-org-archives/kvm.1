Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214187;
	b=S+5D9hqU9g7DgKYN3fRPguqqP+k3g9w0wMWiQCS7C/ul70VPRSGaQ20InJkDspDzW+vI
	 KXx8+AeL8q/pRoaTzlHkCoqM73O+fWaPmQ1Lz7yl8B4rfAQ4NMlZ710fBKZ1rHI7ruQ3l
	 OuRb/TRnJl3W2KTHFFPxyp77wBjTvFWiApDEVFUZdSTQyCCMHXfWS3/6LIDMpdpEuCiFp
	 yrNg494Yczhp3r1f/3s6yIs4oZAnu/eRl82A5Q52SrQ0UWUvmJrmdSSjb0aKljhrsCGsV
	 YvL0llnZGTSWd4GD/634S+ZiTJhsXtlnsAxFf4GJ/VIZK/SvCp7Qxx1kG0V3+gqgaXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=RloCiG6ktfajfft7oZXWWlUR2yO2W/arq16CEWx06hk=;
	b=hxeKCCE8BO2+EG6U/YU0LhfZaIoyByKueTJ13ieFjORBDCsFSBFfCwtUhhQ54wGSSH5a
	 8CFCtfLSPPdQ/4NdoTipRUY4/+mNftUC4GqHehlq284akMttEWhLosK/ylcllNjrQJzBI
	 Ez7mFeIbQJlXfBVAYZABiz1nftbSR73ogE+yBgP71e3Er4z7z4KMXxOHKRsAEUCQLqLgZ
	 EV+407NQEydBat+f6mCzlAXtWooI/qndI3xOLrvVUuGhM/DCPjJJ4Okj84GYbFdkjFql7
	 Ad5n4DLWgFV9qkDSzVLiRxO6PAdEJ3Uc4ZjF0NDYzdGG9siePoU//2+e/Xz6RoqLJWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jzH4kia2;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF660A3809
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82DF660A3809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jzH4kia2
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2e95f8543c9so10025985ad.3
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793214187; x=1793818987; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RloCiG6ktfajfft7oZXWWlUR2yO2W/arq16CEWx06hk=;
        b=jzH4kia2yfr+yDj533Sy1CVo5oa3Snw3/kZKq+TA4XhD5kt7pldlMsWeTQ4KVx7ejN
         TRW33zJGMnikyEo6KpCgTjRSveMnJdDy4cTdCYVS0XvWWMQEtXtWWUBOYD9r7m5KlE4/
         6a5zVFGT3nMx0Ldnw48TJaSYVRCv0n2Y379J0cBvTj8GLHS+HID7guUQmbT0rh/6Euuv
         QgYZKBM00ohhrMhckJvzpFs3QgEWPsIz3o39+ONWhEoCeFxINcRozL9VPC24L4CsTn9F
         +1GJOiq5584WhDCQBB9uEeTB5wvjACeZ9Rt9VJ3yegkAssNd8Qt+QW+jCZ0uLZLdrBQg
         82+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214187; x=1793818987;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RloCiG6ktfajfft7oZXWWlUR2yO2W/arq16CEWx06hk=;
        b=iEOwE++E9yD8TZS8H7kSAH9OiHZMTcatsjzO5sktQFXoYWjma8DJo+DAvipAXgqj33
         tftRAU/d71khzXEsYB1STT28UdtiN7dwtgDDzUE5JJzGmzlLexWchLctb+z8IGZ4Yy7W
         lM452PYXKaWmF8QOb7HzcN2WUS7ODbzzWOjHlBwCRsUFvIoNz9GBywjVnYdjrJaXYEIh
         /0cCRTCFbTmADk25BpTWMfk97MR+iWeAqObl0C6gPNLDjDXahHmBOdgUipbkwr3m1UZI
         8K+su4UicTtZGMO1isvm2s0lNbNGBpW9AbGG6ZsACARp0qOS1W/ZfkdaKpLVC3QHPXQT
         BwMg==
X-Forwarded-Encrypted: i=1; AKwUvBxujck5O0GqeCueYjkjaVbBWrSQCEaxcH/vsO4ahggyIjfORWTlTCNJQc6PNF80lbuwYes=@vger.kernel.org
X-Gm-Message-State: AFq9FYIpEeuAok/rWXrU+SvFV++mIIygXALh2Owm4VnRha6p66ockG6r
	Sx072I/pKYcqACCkDrkFsodp7hHygB2undx/HOU3rt9VIvrJXfGfDgVlWLUinXuwk7oVFYh9koO
	5Ilywhw==
X-Received: from plma18.prod.google.com ([2002:a17:902:7d92:b0:2e9:73da:58d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d504:b0:2e8:3d48:4d92
 with SMTP id d9443c01a7336-2eb003bf1dfmr27738995ad.33.1793214186739; Wed, 28
 Oct 2026 12:03:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 28 Oct 2026 12:02:56 -0700
In-Reply-To: <20261028190259.1819571-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261028190259.1819571-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.0.313.g2479322e68-goog
Message-ID: <20261028190259.1819571-5-seanjc@google.com>
Subject: [PATCH 4/7] KVM: MIPS: Rework kvm_arch_vcpu_should_kick() to use
 standard implementation
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework MIPS' kvm_arch_vcpu_should_kick() to use the "standard" arch
implementation so that the arch hook can be dropped (MIPS is the only
arch other than PPC that implements a non-standard hook, and PPC uses the
recently added @force param when invoking __kvm_vcpu_kick() instead of
relying on kvm_arch_vcpu_should_kick()).

Convert MIPS to the standard implementation even though the code should be
unreachable (neither kvm_vcpu_kick() nor kvm_make_request_and_kick() are
used by MIPS or common KVM), so that there is a bisection point if the
code is somehow reachable.

No functional change intended (because the code is currently unreachable).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/mips/kvm/mips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index a53abbba43ea..c37e212bc0a3 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -122,7 +122,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
-	return 1;
+	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
 }
 
 int kvm_arch_enable_virtualization_cpu(void)
-- 
2.56.0.313.g2479322e68-goog

