Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163688;
	b=pXQ9a7k/GtS++7Kef4p9d8mGgyYaqtqYvI7acYewy/GxNmwUYBkCcyJpiZ9BzwnfUpLk
	 uaA7eJatrYLW68PUEnDVeMHAXEG39jEZFCAqBdtPjbV4qg1cXyMZwnCuVtnsCROoVkXex
	 N/fy4UkAPYILSR8Woh79mcPj7JQamqz3x4jGkJaqXrHsQ3vFyVMTlYVt8G0+ZAY6+mCXI
	 oohI5O8V2C8ZieLycL30NxmdEgCd6zrYVHgWyrcaajw5Cm1FePz8+jiwAy5g6hxJzs8B3
	 f/5lInpBF+jDkYMr3u5FaLT6ptV5TKSn+w4osAClobzlZdvplohyHYIfgaJAYJ/ZzOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MsI8OZZh9dKz1v392dtfILjaERE3/nyinId1eBUI+OM=;
	b=k2Aa2T5tRJ4IJFTwXucmoE2PhJSeGNbEsMczslx51lAYj4evCV1Eyy1yqYXQaV+lYIU0
	 RvRssgEM7yJfvzouV/ILKX7MWJOE6Bj+iyBA78J7qBFit0EpAfCmUAHe4jOfDOLClcdwA
	 st89VFq9ff4K3T+OCAO+UvS/hOpHqtAgk9Ge0ic3o46LFUk+TxxqDZHVmzpoJP3U6gwf5
	 zWv8OEVVKrpPkfNPNF6hpMC/HmBdoErXQ1H6VtKs+MPR5nrz4IJLHLsaMzQ232MSvOSf3
	 N/mHyAv+qOGQ0J6fB026ZvcCDeIcyEEN+jpEIkGVyP9FIKH1Ah6s5awVgATr/2ubsXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YrwKb5+;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAF60A261F
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 05:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00EAF60A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0YrwKb5+
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so3990035e9.0
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163686; x=1793768486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsI8OZZh9dKz1v392dtfILjaERE3/nyinId1eBUI+OM=;
        b=0YrwKb5+jvPDDNM7+U5lrwnlzNjBYxvjeWxJHiksh0eQmBD4YSGwJSD7epdsbzMUHV
         VLYQBWcOsXd2QguIaPDq5LO2SUKHPS5If5gH0xbgAGqerx3VN6jvYyXkBT6EOrZmaAK1
         RspwV8mGvhNGZ4ZMMu2VfNRhzA41fVOoYFST7Gka4vceEHb4gVduEGHPKUVeStk/IwiW
         Pdh+inWUtIbg9cAO8EnAOI8lsYG5/BtV212TMf7Ek9ZRxyUe/KjD5iVF38uKM0K2Sgq7
         ed+UYJ9hB9lwPeEsOyIHk5bJk1kxggD324tx50rEm5GZC40xUc152Y/yUfC23nouTQMB
         geKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163686; x=1793768486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsI8OZZh9dKz1v392dtfILjaERE3/nyinId1eBUI+OM=;
        b=AF4xXmVkzXOjhngD0blUKegzZDNlRK9I8pb2InetkbMHkXgROgt5tfW2qWMHNxKe/K
         3eMjmRntPIOqZ7nMkfLVMY8+Afw9AK7r/GXvNIWBS948qaOfvcHAulBZvhHNXfuFZzUV
         0Q/ISUuSmGU3Daunb/jQI7fuUJfWrU+VtK9EzvsBYpZnKxGHmNt473llXdRp8scj7DGd
         x15rjvst8ac3nvyRTT0vNBSoW1ik/DeAM5iZK4/v/MUzEtnVpaT5/JwsQj2Hr/Xgc19t
         XWNa8z6eWc72txOmQdrPMiL/79XSC1xr9MgzxTLmvd4i9wNUUO8eWjn7krNs4Hc+6Va5
         zUTQ==
X-Forwarded-Encrypted: i=1; AKwUvByj6F/diwGVdppPdrn8/MvcsBsdgdgJhe3TKUr9QV0rj7M8IqgRs3wqlc0gMX7Rgz0LCAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxXvMhAaw3BeOA7aeZIYx6Xlw78l3IpACeAAMFQp8W/JTKwrnQ
	tjf7pvXxie5xRLpbsyJYGeeakRf/WetVPXe1vyAe+NBfOM6hoTWnb6Rr
X-Gm-Gg: AYBFou3gzQrILeHo1PSbGJvPD4J+j+tIbia5i9qYA3YC4ntnQ9Y2Kitu5fANXFZmWuz
	x7F7z8qODUH74wAbNfRmq0exPwBNM0yOxFKFeQZq9OD0zu7twpP0AGUtBY6V5tkCLquegGndw0l
	udIWoOCg1/E1KnpuHJPCgpact/7vbvTNDrMh/JCTqkOgXBWgM8qBwxQqSFTGS1s4LLPtA3T82bl
	jvyKlD9sL4CBYTJn3cO5iS8/sjmLUQUuZ3ZVLjGw5QqqEOn9ah1ygimVmdYdkb1eGTOmayww1Q2
	CuLzhARS/sjV64JdiDA80HIgyx8ip7jyiviJoKnKoksrhKKSXTBm3WApUC79547r676LRY30WjE
	HMD21UKJ1MAOz191C1fAKhWaQ/T8Ov4Tdu2Bwh7+CEiuol4an+/ZT7Gw4LWAh8B33mZ9BbKiQKM
	idvRtRt3n+3h1rpl/vTOPChxJzAIL9miKaRbcxONc6Sx50KjuSBf3rrp+5088Awl9ckkc7iJGxF
	Ntz5rwIhdL+DLLGbTmd7Lae93MoN+3lUEdQCyMJBYd5tE9fx3ZNM37aGxdpbxedMTGqlErF+kql
	a1B5K/zC9A2XyMDaIR6zfBVqG5qpAfQiP+SBgw5Qg67NMXJEiiuvtWb20HGgNyx2kgIfYTVRIYj
	VtBYCtbw7D1iU2aJmf0KNU+AbU8BqtE1Sdl7oBIgVxCs64yS+ING1tBSkcmh2xhoyzo61kzv1+j
	c/F+vAAgC5w+pnD3kHJBkBJG1+yl0hw9xEODHhuw==
X-Received: by 2002:a05:600c:c117:b0:4a2:cbe:beac with SMTP id 5b1f17b1804b1-4a9672f814emr15602045e9.23.1793163686125;
        Tue, 27 Oct 2026 22:01:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a45b-7d01-5035-b393-698f-53f0.310.pool.telefonica.de. [2a02:3100:a45b:7d01:5035:b393:698f:53f0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94eb8a60fsm13523365e9.3.2026.10.27.22.01.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 22:01:25 -0700 (PDT)
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
Subject: [PATCH v2 0/3] KVM: arm64: Preserve level IRQ re-pending
Date: Wed, 28 Oct 2026 06:01:10 +0100
Message-Id: <20261028050113.10046-1-kmehltretter@gmail.com>
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
state used to populate the LR from a later ISPENDR write.

Synchronize the target vCPU's LRs in vgic_mmio_write_spending() with
vgic_access_active_prepare() and vgic_access_active_finish() under
config_lock before setting pending_latch, as suggested by Oliver Upton.
When a vCPU writes its own GICR_ISPENDR0, this synchronization is a
no-op. For shared interrupts or remote redistributor writes, stopping
the guest folds any prior ack from the target vCPU's LRs before the
new pending state is recorded. In the v2 and v3 fold paths, clear
pending_latch when an LR populated for an inactive interrupt no longer
reports a pending state, and preserve a latch written while the
interrupt was active.

The last patch adds a two-vCPU GICv3 selftest covering same-vCPU and
cross-vCPU re-pending while active, as well as a cross-vCPU ISPENDR
write before the ack.

The issue was reproduced with Zephyr, NuttX and RT-Thread test harnesses
that configure an unused SPI as level-sensitive, pend it via
GICD_ISPENDR, and re-pend it once from the ISR before deactivation. On a
Raspberry Pi 400 host with a GIC-400, each GICv2 guest handled the SPI
once on the baseline and twice with the RFC fix. A native RT-Thread run
on the same GIC-400 also delivered the re-pended interrupt.

The v2 change was A/B tested with RT-Thread's direct and mailbox-pic
reproducers on Linux/KVM hosts running under QEMU TCG with GICv2 and
GICv3. The baseline lost the second event and v2 delivered it. The new
GICv3 selftest also passes in that setup. I do not have a physical GICv3
host, so the GICv3 testing is emulated.

Changes in v2:
- Synchronize target vCPU LRs in vgic_mmio_write_spending() via
  vgic_access_active_prepare() and vgic_access_active_finish() under
  config_lock instead of tracking on-LR writes with a separate
  latch_written flag (Oliver Upton).
- Extend the selftest to verify that a cross-vCPU GICD_ISPENDR write
  before the ack merges with the initial pending state without causing
  a second delivery.
- Drop RFC prefix.
- Link to v1: https://lore.kernel.org/r/20261022064628.4206-1-kmehltretter@gmail.com

Karl Mehltretter (3):
  KVM: arm64: vgic-v2: Don't drop pending writes to active level IRQs
  KVM: arm64: vgic-v3: Don't drop pending writes to active level IRQs
  KVM: selftests: arm64: Test pending writes to active level IRQs

 arch/arm64/kvm/vgic/vgic-mmio.c              |  76 +++++-----
 arch/arm64/kvm/vgic/vgic-v2.c                |  10 +-
 arch/arm64/kvm/vgic/vgic-v3.c                |  10 +-
 tools/testing/selftests/kvm/arm64/vgic_irq.c | 140 +++++++++++++++++++
 4 files changed, 197 insertions(+), 39 deletions(-)


base-commit: dd0bc00e3e9201fd49b62ff9cc07890c89003afe
-- 
2.39.5 (Apple Git-154)

