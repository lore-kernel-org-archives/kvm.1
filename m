Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589796;
	b=HywVIzwolGFnYbCl1AirCRgwf5dMzQXpCaXJM8s+0Ge5SvHUqclekr8U946lQfIn4fwY
	 YLPWLCq6Uigq+KUSQMArvqbE3RJewawTPrrKvZyGiqKHmYMXQFta8Vu22tqbSDC+AdN+H
	 ONvkpMwlmHSIXnSNuVh5nlOz+YlUpaYHgV0+n724EYDCpVV/FThxwIqAz/t106lHcAU8n
	 mW9FOmqXczfJsl8Z2cBIRGxgzls7MkiTWW3/b+hgYAF7UJfr0WwWYmNBFsLNuvl9k3lSG
	 DF1PUXzRHvl0xMyEnPVDr2qgbMyZd9K94M1/lN6jDHCm7MnqkJuuLzYgHiaWQjAaF8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=WQnd85yPB60bhdolGWcMJlVAtTrb9nbyVFLWQL59DRE=;
	b=BVaeEz6rLYAZiPB867yvjpuUjTHUtGHqJ8SzQm0ZHsDXL1uw3M3vKc5+c9Rr8hZpxwlU
	 pcyuq6eKDGBiOeoOJpC37hT46Ro+5C79CjfLwYseGKgj7k0XRlispKJSmQ9V9uKpuC3LN
	 4fJ+cT6ESof3NQHB9Bryz52N189f9MOjd4YaMGhF2lun/wqpmbtWJzhLAdsQJBlzHDou2
	 Ku89XH0TURt8I7sFTrtpPkJzqmZ1v0UmdaTTvHFReGXbPQHQyNaOOPL/c4kGEtqd+U8dG
	 jxVN3LAU4kjyPv2TFSzvG7kijfbwoZ6s7l/lrXn20je5lXXmjs6zIreF1fhvvZR1Pcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=M9cXuD2e;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC93606A327
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC93606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=M9cXuD2e
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso52615235e9.1
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795589794; x=1796194594; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WQnd85yPB60bhdolGWcMJlVAtTrb9nbyVFLWQL59DRE=;
        b=M9cXuD2e16YtiBuyCgCK5y4vErgs+z6SK5xnJwotqHno/AfUjPvKbgA19vHhFIlzm0
         CoEgT1A1ucZpKSv83wPyzLCRMhmNSvnKKvLHje7W1IoId+eGvlOXWNcO/LuWFJSF2oQ/
         3C1NHvYuzPb+9ZNPKRv/I9o4XlU42ogdA1sK8XIhFWrOmE7p5Gs0FNva2+CPFg57IuDv
         zx2vKk3GUUYuZdj0g/LoIuZqsT0GpUzoCR9yIk6Bu1330PrnaKiKdtIOC4AR7Lp/Pc8y
         r42fLnp1w0W87Wg4Mfbm3N8nf1eI221hr99iwK46F0BG2rXdWB5Pf02hDOFpZDgRXHaw
         lEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589794; x=1796194594;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WQnd85yPB60bhdolGWcMJlVAtTrb9nbyVFLWQL59DRE=;
        b=KZQHFTP+zghNYXg1gktTCWg0DyL2ErFAtVE4BjqFFofh3zUdHMpxGzvGNb0pnM6/HD
         JkS9YpRDjiHy+/ZfwUrZcQXStWy65fD6bUeaBeR+Ler1FigcB7MwS3/M5Va4KhPBJ+62
         IqThU9h0H0kUYpqIfAZia4DPeNiY/sTq9SizeN2XADpKZnOy/IZEVs9rNYvU3t2Gg7E5
         /HIxvgMCMePZz/kysJT9xbkNuuFH+OVwIyfY+U2Lldj7J8qin0rUEjY8IqnBO/0JbD8W
         JgeiYiOMpwdwYrK4FWn80ttTyzcJGHwnUIZ4imm0J6pN/3CCMok6AZhBog/mCPgmQf/T
         x7gw==
X-Forwarded-Encrypted: i=1; AL+hErFttZUlvanROZZF9tS4cWChXN1s8B+Y6MfEKf9DjfOimIHQK0/wuB/a6MaccR3mm07uwUU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uzwsvAPnn2A2Pl22f9J5yZAnhAUwFI/V78jsz/hZzaCwHL5Mt
	SrtiJ9ZWr16VSH39V6jh6eqkTuvvJZgJClfhzvr2hx1C+D0EdrDwaAst1GM2A6tcWwY=
X-Gm-Gg: AZFdTZephQ5aQnHoaep8UraZXRQB8rAPowZ4+JLZLVqxYxt/++MMNfU7gQx6+TkaA9p
	Z7v9L7nmDQxt44JGGRrcRyO+28gglIN6Ug/LFOJ1f9doBzDRBAnJvWwmzQObydTFFXxfy1vaFAR
	rE6ev7H6hgDu5uWHUrf3o34epoLZ/GXWvpQz3b/T26W5V0V643GFwfXj/jFrk064OUsqrgp8yZv
	BFLzkHhJ4Tw/XKQj7XdIh+YGD8NjVCa76uRf6mRnyWiMEntfF/Xd2FlriDNe2qCotMAl0DiKntJ
	VCGgzH/BaVM9pCq3u6cST3wT2F/EAnHldkzuj8CVIjrPdICGRqONLK9SyYUxhU+2l0gCAM5SJDc
	jkcvn+YVg4P22OY8iO9kWeTa/iDDlwnAHUG3C5IvNXgzFK3WPwymBrJUSYTefJ/e5RNYodEu7sw
	JrqNZKdlcnqRFFK4Y4z5nMMS4UElqU37iB14mwtbVqIRzqfWdFOHl3wiO2SWmY7NaH+cpK32cKf
	ma6481oJNv2ZndZtR2Y6ic5WQrlZCri3PDzEj3jWbKxUi4HhAUaC6tDT5Gc5pckOV0x3agmgTzT
	QeG+sBgtGyqlMEEYjCS1
X-Received: by 2002:a05:600c:530e:b0:4ba:eb:eb9b with SMTP id 5b1f17b1804b1-4bb8880aba2mr330852995e9.8.1795589793909;
        Tue, 24 Nov 2026 22:56:33 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b8429sm777474785e9.14.2026.11.24.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:56:33 -0800 (PST)
From: Dan Carpenter <dan@pereq.eu>
Subject: [PATCH v2 0/8] KVM: arm64: Fix kvm_reset_vcpu() and SError
 handling for nested virt
Date: Wed, 25 Nov 2026 09:56:15 +0300
Message-Id: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WOQQ6CMBBFr0K6toYZxKAr72GIaaej1BiKLRAM4
 e62GFcs/8z7L38Wgb3lIM7ZLDyPNljXxoC7TFCj2gdLa2IWmOMRAHNp3KBffOOJuOsjLFVxMEQ
 lAkAlYq3zfLfTqrzWvxwG/WTqkycRWgWW2quWmnTaGNM/cY0NvfOfddsIyfefUWxnjCBBkqlQl
 yeFBZpLx57fex5EvSzLFySRl6jpAAAA
X-Change-ID: 20261120-double_exception-a34dcc521118
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
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0

Our formal proof work at Pereq found a way to trigger a WARN() by
injecting two SErrors.  Then Sashiko found several related bugs
and testing uncovered a few more.   The original patch is the same,
it's just that I have added others as well.

I have included a selftest for kvm_reset_vcpu().  I have a selftest
for SError as well but I have a question about that so I'm going to
send it seperately later.

Signed-off-by: Dan Carpenter <dan@pereq.eu>
---
Changes in v2:
- All the patches before [PATCH 7/8] are new to fix other related bugs
- Link to v1: https://patch.msgid.link/20261123-double_exception-v1-1-cd82b59a232d@pereq.eu

To: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
To: Joey Gouly <joey.gouly@arm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Zenghui Yu <yuzenghui@huawei.com>
To: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
To: Christoffer Dall <c.dall@virtualopensystems.com>
To: Rusty Russell <rusty@rustcorp.com.au>
To: Marcelo Tosatti <mtosatti@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
To: James Morse <james.morse@arm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Sean Christopherson <seanjc@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Karthik Bhargavan <karthik@pereq.eu>
Cc: Clément Blaudeau <clement@cryspen.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org

---
Dan Carpenter (8):
      KVM: arm64: Drop an incomplete MMIO access when resetting a vcpu
      KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1 when resetting a vcpu
      KVM: arm64: Discard a pending SError when resetting a vcpu
      KVM: arm64: nv: Discard nested SError in kvm_reset_vcpu()
      KVM: arm64: nv: Replace a pending SError when injecting a new one
      KVM: arm64: nv: Don't deliver a pending SError to the wrong guest
      KVM: arm64: nv: Re-inject a stored SError after the exit is handled
      KVM: arm64: selftests: Test that a vcpu reset clears the vcpu's state

 arch/arm64/include/asm/kvm_emulate.h           |   1 +
 arch/arm64/kvm/arm.c                           |   1 +
 arch/arm64/kvm/emulate-nested.c                |  14 ++
 arch/arm64/kvm/inject_fault.c                  |  10 ++
 arch/arm64/kvm/nested.c                        |  16 +-
 arch/arm64/kvm/reset.c                         |   8 +
 tools/testing/selftests/kvm/Makefile.kvm       |   1 +
 tools/testing/selftests/kvm/arm64/vcpu_reset.c | 210 +++++++++++++++++++++++++
 8 files changed, 251 insertions(+), 10 deletions(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20261120-double_exception-a34dcc521118

Best regards,
--  
Dan Carpenter <dan@pereq.eu>

