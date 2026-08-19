Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300323E9C32
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787179387; cv=none; b=LctAaD43M3WvjMaXlf4VFMW236wCdXh5pwScmDnRh02tmKaP4Ut3rYpQ711gEvsP5MQefOvM+PHHGToZIDsi0cxhQj+LiKXi3FhWaMMGw6TFNcM2YE51wuT+wkvdfZwH+I8XDHOvvuEFF5KCfsnOyPEIi382Hg392ZNoPGMwui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787179387; c=relaxed/simple;
	bh=2UF/dpEtNwUpXIy2/lsLjKtKkOc89V1LHpzMmRW/PXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D11vtEeNP3IXioFfNhg7EsHOvJdSY881m3h67ziLI6yx9KIHQ7pIYkoxHEvyihOYqTKBKzfewu95dkgLjS7dfBrmWxDXbBF1mcEK/vxBtW46mqS5BDpnGng0S6tyHf9S1fQXMJSdb2Qm2LwQ7mzkPSy+o7BdHRwrET06qjIfeyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiRnFXjl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiRnFXjl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47db714766aso258363f8f.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 15:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787179383; x=1787784183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3M8fODVTfcIR6x1BvOAoZIGong7qKVQ1WDu7Gk51RQs=;
        b=IiRnFXjlT192IJiaPsi5tX4fJIV/6L+/EPA9rxNKGssq2Fn90xYVETYiSjlnejToBX
         1Jt0I06KbYthVi2fyC9cDrqHz0Df/XXRU9+3kEhqRnykbwLsZxAgsvpK6Tp/ojR+63gL
         yWVvJPVmos3AFpQAPOX23NNUjMfh9SEUDuG/XHHj5wc5AH8C26k/sP56kY7PxsZmruhe
         MeF2aZ7QT11Sk0Mq9K49V+RxVX6dlLfFxo5lB+RqUdHu2pEGoTS6frCFA27pZHipDNvu
         E3JAs3n5tsL02KrKwvNBxLJDIvhXwzXd0U1mfU9AyhptLAkcFncozyXFo17/BqsvMQZd
         t+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787179383; x=1787784183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3M8fODVTfcIR6x1BvOAoZIGong7qKVQ1WDu7Gk51RQs=;
        b=b7+IqdCiRC+Pn8G6DcC1SBf+PdzuliPPv1JqDmfUXhdl0FzOvpJ3DdYYRHQO+EIuxl
         8RFT0DMEi9dTdojwiDDYjqOJgwFuP/KePyRGxdbNObU4DMHsaaXXYgpRLUct8r11t0SO
         v9VBEVBZuK0dvGm4fXpl0dbMiWXxrin/yuD7OXNJl/Yqno2dQ02u8SxpYgb6bovd6CV0
         Ge5UDdglfAO38mEtosHii9ABYnwrKwNcXGxVJYxOC+xwNmyFQctUIz6RpDPXtB1hfJ4q
         MPdrYsGrHKVXJJuHJOGiKMNQF6oGXGDBXrkiqlj9evqgLCoBWEh/sfXTEAqeWcDlAYGG
         Sg+A==
X-Forwarded-Encrypted: i=1; AHgh+RrPflbbozI9rAaY7s/ZQr27/QMSoLi2xzKskOeP28qdoMoXoRLZl7eupaAnxLbCBqVvKuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK/V9FsyM7suhzDRnOT2iHonKLSHk7B3BfmrvzAkg0cZIpBrPX
	CXjVAjiYrcGJOF41MAyNqiu//4b2hBEFdc9rHofFRnyQbl3E7c63hfio
X-Gm-Gg: AR+sD13VvwyjKdMk43ZwLSb6EQig9M7yZQ+zGKlFR4VhJkm8nJpaLOCb2z+BE71mzmB
	7kAmXibFUx9DS9aM11+A5iO3EP4JP48e9jLgaI32nsp/Wjdono+vrY5sYb96JIWruxbOYzL+9qD
	4XGIIU5YTvzCqv5In44TTVtoNKZrB7dfCKsX+mqRVPWgMwgOVKnyzrZZJ0HL7O5q4n3NSE5Dz6P
	PPLZ9Mw0LIzkSuR7uZcflxT+TU/KrdYE6MNuysiMWLXh+tKeSMdBXlcn0AuqT54zdVRTR6D7cV5
	R6Pp+HqS5HdZg0PLGgmfJ7Xhu5InLg9bIGr458tw0jatjMAkahooyF1Y4fQAVKmc88rRqHhC7eG
	WQ3W+tW5qHZT+BRDUp579tlfXK6JqRi58BeUeg8CgZBnsBrHeCvulzDud1O1WcXBU7HE+So+Dno
	bV68QZaXfrnf8zX8w9LbSgYoSOHn4Drx2GALbq4mYpqn/qA1uYVFuG5gOsFwHFMbDdBFwRWS4iQ
	q49HHnXAIfVOLoC7EUKugXVAE+hIYKATi7ux8aK5HGTaod87G/dX9QN0ih1Um1IJU1SB+ioihrY
	K9oXQNRC3boAs55VirfH8b/kHRwMvBJ0jeyBPN150hcaKH82EImuHEDSXaDL+XI1alo=
X-Received: by 2002:a05:600c:4309:b0:499:60e5:248a with SMTP id 5b1f17b1804b1-499b06ea247mr24837485e9.4.1787179383250;
        Wed, 19 Aug 2026 15:43:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae9e-1d01-58d3-443d-4fa6-01cd.310.pool.telefonica.de. [2a02:3100:ae9e:1d01:58d3:443d:4fa6:1cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e61sm8553317f8f.13.2026.08.19.15.43.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 15:43:02 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Christoffer Dall <christoffer.dall@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/5] KVM: arm64: vgic-v3: Reset assignments after failed region setup
Date: Thu, 20 Aug 2026 00:42:26 +0200
Message-Id: <20260819224229.82948-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260819224229.82948-1-kmehltretter@gmail.com>
References: <20260819224229.82948-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A REDIST_REGION write can fail after redistributors from earlier regions
have been registered. The rollback removes their iodevs from the MMIO bus
but leaves rdreg and base_addr set. It also leaves free_index unchanged. A
retry sees base_addr set and skips registration, leaving the redistributors
absent from the MMIO bus.

Make redistributor unregistration clear the cached assignment and return
the region slot. The failing vCPU already unassigns itself, so the existing
rollback resets the vCPUs processed before the failure. A retry can then
assign and register all redistributors again.

Fixes: c011f4ea106b ("KVM: arm/arm64: Check vcpu redist base before registering an iodev")
Suggested-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 arch/arm64/kvm/vgic/vgic-mmio-v3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index c75caadbd1d3..331d203acb43 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -852,6 +852,7 @@ void vgic_unregister_redist_iodev(struct kvm_vcpu *vcpu)
 	struct vgic_io_device *rd_dev = &vcpu->arch.vgic_cpu.rd_iodev;
 
 	kvm_io_bus_unregister_dev(vcpu->kvm, KVM_MMIO_BUS, &rd_dev->dev);
+	vgic_unassign_redist_iodev(vcpu);
 }
 
 static int vgic_register_all_redist_iodevs(struct kvm *kvm)
@@ -869,7 +870,7 @@ static int vgic_register_all_redist_iodevs(struct kvm *kvm)
 	}
 
 	if (ret) {
-		/* The current c failed, so iterate over the previous ones. */
+		/* The failing vCPU has no assignment to undo. */
 		int i;
 
 		for (i = 0; i < c; i++) {
-- 
2.39.5 (Apple Git-154)
