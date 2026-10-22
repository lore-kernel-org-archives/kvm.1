Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651602;
	b=jYtpAwKMzHix2cbm3O38N//2yBWlQmm9UPQJdB/q4ntKPstClAt83ol3POSwrndd/l2R
	 02j+nihtwdrTRY0/bnfgY3MGiyvsqVxUbj2+wibMZJdQ1skLD/FZwD3zNXIigAzWKGDMo
	 +xvvCHSRN8EBZsUK48XAw6spXyDpUSFU5leUDtKTlOFIr/l2ebFxd58Yer60Zh3QR4Ybb
	 USwxb+Dn2Xh8Z3ZkS04aes55s5wVzWbmSF8ST+1ei4LlAqM0AUd+eBVbZVy/j4wgyLgQq
	 gxFGdn2LbHJi99OgfDbKPhxm61XU3whqk0K82mDC7aCeTq3GXrJvg2yavjweC7hy+wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6hyPiRO1YLgh5z7vpK+8rbMGtfzuaM8kNLxgiQL1q1o=;
	b=WRc7hDgUzq+LRfCOlE7Chs/ZXae7r603+G5iorDKHhIrcgmg6uBAPXAUAAGz5ToH0RPt
	 VUlYLRu/ZRRckXGfmeaLEOuslzERriH5rHBOaUuGtB5VYm27EPI3h6bBa+vF4W/xTKZBN
	 SuH+J3QX92ti9aSYEqWM1jOLJubQVE/sImC7Fxm7h6d2PYg3IYg/ZzEzqBQ5saS0lXz6l
	 eZSOqYvr3mY3oASeDGADdtR2RpcKIHZdOvl0CYlodyYTL52GXlSWqodnPGVV829ZJpzyy
	 AqUWSSwlVvLcCqhxib0TLV0lavXija2r6EkSZqKYefqTPKalrkmUIueaM+A8lvC5z2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mMySRvdX;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68208606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68208606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mMySRvdX
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48dee593f18so1173764f8f.3
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 23:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651601; x=1793256401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hyPiRO1YLgh5z7vpK+8rbMGtfzuaM8kNLxgiQL1q1o=;
        b=mMySRvdXD81ZSX+EmqQQax9e08NSFdSVvtDJrnGftqpYE6a93r82F63dH+Tkd82jBa
         GgT4Zfv95T4LDj5VnmnNA3YjHSyHe1Dis7FTnnCqLkIFJzWQ+ssLIr/8glFXUkVq8GiC
         R31Axf1dUG3ksK5Wx3Hjsi9avVUsruDwwp7gES60syWHlxFTaW3R5tP2HEVnx1VerfaH
         t67nu3Emp5dluNDA94fEcxvq40FUhc7PGWdk81mljEP9ws44z9qurveXPhSJ4hFxh4Tp
         +ISKJsbRnJ9DK9K30cf2orP0ykx7QykPP0+pb89/nF4M+fNz6ZsX80CC9opqF8AZ4McP
         trzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651601; x=1793256401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hyPiRO1YLgh5z7vpK+8rbMGtfzuaM8kNLxgiQL1q1o=;
        b=DOgNaPDXIbtZHRhFsGU+WDli8YYKGRjJH3yenhTC3uEcqBvcRgaTSqNZTMf5NZJ8J9
         sfaW0/YdgPLcqwTgB5mH+I0JpQbaCknjwgdFSHLu5KbY+lxxw/zrroAnSslaW8mYFv59
         mBAWmY8ObNZGokFb/k1DLwVwl/JrBFlgW059R8PD+QRqaumHG7HhX0L8V0gESlXhU8G1
         tiZF5yqs1BSrgTUnyaaLRU4X+52Pd1N8DtxdlINuix7yF1eC3Yn1l+wbJRYxN8rH0uJ0
         5SSYG5l9oWNihJBJ5eqPU7dHrUjpLnv8spMvCTFJXQ0CLh+HgVMRfZs9ZGAj+u5MCrGn
         AGQg==
X-Forwarded-Encrypted: i=1; AKwUvBwAX3hlf7ruGzhtaN++Q2M5WTp/HfcdWORCyhNsx8iZY0U70ALlZ5SIpz3SvouOqAVMqik=@vger.kernel.org
X-Gm-Message-State: AFq9FYLij8rn9NxFGz5rIQD02nHlRxmakQ+GBlTEKFUMPWZ6bxHSG23z
	r1PmrQOML/OIEk16T9Mwks9wrXz2jtpDB39H6MMlht6T22OK1Nlfj/d8
X-Gm-Gg: AYBFou0kCLoVtvZGeeKyCihgh4uubd7pin5ZUOumc3WRsyx2dBhrn3S6XEK9ySDLJRP
	Ey/F7DL570AqyAsLMg9zPDWuQnwXd5zP7wBwXRKAbIUTwosbAG7L8Z+x22syxANb+WiFea4F9Bl
	I73otTZk/ASk6OL0a9WcruXSYgvOYrOM/KcwVITPOxZeOUg/SBqKyJNShnUOlpTjNnOrAPIGZ1c
	RaJTcQnNZGLOA/OHZT/37nVzANdm+MX6HHG47LkR5qUDotdYoe0G+yeMzAeV9NfigQpFyN+RIPb
	TupJ56NEQCUb2GkjTzupdzAj5UORwSaLTjSJp6A3jom2ZN0oxBI4T8iLfWbBtiTaIclGW+pF1sb
	rVV1Yo3QR0yv/QjtboE/IY6U+kB9wZFKrIOFpr3M6dIRzvgwcZ/ttsL6vhrJV4jyi+uQTZdQ/tk
	V+io/o8QsOiwMkNrvIdoOvHxQhRZmiACCH55e/WftM+BDp30vw7K3aWS/bwQgoOCW7ElDdLOEIJ
	RHYo89AmSnRHECh+AUaBb3TR+LUhTJR1aYMjDOCBLWdxmz3CMdThLSfAxodUkcrtcCcrxDXR+4V
	i/VNlV/h4J6BnWjaUivb5xWbK38+ibLz1oCDDjVsBZmx/USgEKC5h0aFyaPZpnOOykScWffyrDd
	TkZ4K1+arGZCe7UIP9qEBl5D1xVPiRGqKvy46mEG+43UTluvBmcwORRgE/riVx7l6
X-Received: by 2002:a5d:64e4:0:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-48e264bd971mr9315929f8f.31.1792651600585;
        Wed, 21 Oct 2026 23:46:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cd1sm10215624f8f.22.2026.10.21.23.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 23:46:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] KVM: arm64: Preserve level IRQ re-pending
Date: Thu, 22 Oct 2026 08:46:25 +0200
Message-Id: <20261022064628.4206-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

A guest can set a level interrupt pending again while handling it. The
GIC records Active and Pending and delivers the interrupt after
deactivation. KVM instead drops the second pending state for both the
GICv2 and GICv3 backends.

The VGIC keeps software pending state outside the LR because commit
67b5b673ad4d stopped placing Pending and Active together for level
interrupts. When the LR is folded, KVM cannot distinguish the pending
state used to populate the LR from a later ISPENDR write. This series
records the later write and preserves it across deactivation. The last
patch adds a two-vCPU GICv3 selftest.

The awkward case, and the reason for the RFC, is a write from another
vCPU while the interrupt remains in an LR. KVM cannot know whether the
write preceded or followed the guest ack. This series preserves the
write. A pre-ack write can therefore cause one extra delivery, while a
post-ack write is no longer lost.

The exact alternative is to stop and synchronize the target vCPU
before applying such a write, as the active-state accessors do. Is the
conservative replay acceptable here, or should ISPENDR pay that
synchronization cost?

The issue was reproduced with Zephyr, NuttX and RT-Thread guests. On a
Raspberry Pi 400 host with a GIC-400, each GICv2 guest handled the SPI
once before the fix and twice afterwards. A direct GIC-400 register
test also delivered the interrupt twice. With a QEMU TCG GICv3 host
running KVM, the new selftest failed before the fix and passed
afterwards. Existing vgic_irq and kvm-unit-tests GIC cases passed on
both versions. Those runtime tests used 8623551a424d.

The series applies without conflicts to kvmarm/next at dd0bc00e3e92.
The modified VGIC objects pass an arm64 GCC 14 W=1 build there, and the
selftest builds natively on arm64. GICv5 does not use the LR path
changed here. I have not tested a mapped physical interrupt or VFIO.

Karl Mehltretter (3):
  KVM: arm64: vgic-v2: Don't drop pending writes to active level IRQs
  KVM: arm64: vgic-v3: Don't drop pending writes to active level IRQs
  KVM: selftests: arm64: Test pending writes to active level IRQs

 arch/arm64/kvm/vgic/vgic-mmio.c              |   9 ++
 arch/arm64/kvm/vgic/vgic-v2.c                |  13 ++-
 arch/arm64/kvm/vgic/vgic-v3.c                |  13 ++-
 include/kvm/arm_vgic.h                       |   1 +
 tools/testing/selftests/kvm/arm64/vgic_irq.c | 101 +++++++++++++++++++
 5 files changed, 131 insertions(+), 6 deletions(-)


base-commit: dd0bc00e3e9201fd49b62ff9cc07890c89003afe
-- 
2.39.5 (Apple Git-154)

