Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876460;
	b=2xK4dWYLCUzts3z38T0KDikIa0DZ/KiC1fzc1XvAgPp+VLYj39AEgirowgjmznSMVvA4
	 OTsPl18m6GMIVPCy+XEJLVTlou8uI64CoDW424gPT/ID0z7Ob9QjVQdIYZ+HjnD2c4yW0
	 8RBDnRXodW3VH9mvhUNXx8Xskw8ONBGw9lbLsf531UhM752bvAOI7B+dJwc0QlQ7qgr4G
	 +8e9sDEKjZslOFWM8ExrY3LGFx8OEKHZ+YRCGEwAq16Mtxmfffz5NXHhcf5cdJX/17FXE
	 We3l7rvfrkfDGzqkDulJUBMx5ssfmjf7elQPBDAueuJvTg2KHUdeewvsePih0qQGRWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876460;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hu/VCXv0pK0QVa21PPH8FfuyU2lKhIQq9BLyUFz++I8=;
	b=T+0zF+lFRp9v6YQ+kqZWkg4O3/hXhoVRMzwfcjLUONXKR6sOiPGoeJmEZT5xXkbTGv36
	 vu45pEWcjPBIW/XZwt7clVmGdTHAboaNZuSAQKg4QAhIJbCr4YOpaCKNT13JGPtzKo1//
	 cIWbmBXA7fZP4KP6WwoOTyve6L0XprbqMi/sjLK4F5MW70Y6HF7we9bndxINVq5+5OQn/
	 R7ui8F6QEQBQgIe5uIWfnrWCE7ZRxDFpIogcUvOCHJDa4RJEbKed28n0x2no47lJQXlNa
	 qiuU+ne3sSX4my8Pugz7aN5wcYcceZQEEytXdKhKp3fkwmZzS5HmjeEWTWilfhDz6Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pYFNCO5R;
	arc=none smtp.remote-ip=91.218.175.173
Received: from mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53C606A326
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 11:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A53C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pYFNCO5R
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oNPULxolfeqGA8zrrmcWP4Y839okpyulp0cDosAwCuY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793876456; v=1; x=1794481256;
 b=pYFNCO5ReUUb9bCeJh5k8Bha0VGFUNkzsI6W94p8DZtvb3jItrNzFYdis6QmrRZeXTPxBVVA
 rv5NwalCekzo2akHMoO+hdQMpOMI6rA72isnBFz6bY8Wg0eTBLFOqdE4Bbypt4xiEedTIMt7j2J
 4RabLKy843sMm9ww4zCMmWGc=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a394ecf1d1f2d65a;
	Thu, 05 Nov 2026 11:00:56 +0000
X-Mizu-Trace-ID: a394ecf1d1f2d65a
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Oliver Upton <oupton@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	Yuchao Zhang <ndaugoing@gmail.com>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] KVM: arm64: vgic: Drop stale LPI pending state
Date: Thu,  5 Nov 2026 11:00:47 +0000
Message-ID: <20261105110050.1244525-1-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
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

Hi folks,

The GIC just keeps on giving. Three follow-ups to my LPI fixes for
redistributors with LPIs disabled [1], to fix pre-existing bugs Sashiko
found.

The first drops the pending state of every LPI targeting a
redistributor when the guest disables its LPIs, not just of those on
the AP list, so a re-enable with GICR_PENDBASER.PTZ set doesn't bring
any of them back. Linux never sets PTZ.

The second stops the pending-table save from writing to the table of a
redistributor while its LPIs are disabled.

The third stops KVM reading the pending table when mapping an LPI, so
that mapping a discarded LPI's INTID again doesn't make it pending a
second time. A Linux guest can hit that after its VMM pauses and
resumes it. It also drops the copy that patch 2 of [1] takes, which is
why it comes after the second. An LPI mapped after its redistributor
enabled LPIs no longer takes a bit the guest wrote into the table
before the enable. Keeping that needs a per-redistributor record of
the pending state of unmapped INTIDs. I can add it on top if you think
it's worth it.

A pending LPI that MOVI moves onto a redistributor with LPIs disabled,
or that a device signals there through a translation cached before the
move, can still be taken once after a PTZ-set enable. The architecture
lets KVM drop it, but that's pending state moved or raised onto a
redistributor with LPIs disabled, not state the guest gave up. I've
left it alone, but can fix it on top if you think it's worth it.

Reproducers for all three fail on kvmarm/fixes and pass with the
series. I'll fold them into vgic_lpi_stress separately.

Based on kvmarm/fixes (181a701fc14d3), which has [1].

Cheers,
/fuad

[1] https://lore.kernel.org/all/20261026092802.2636798-1-fuad.tabba@linux.dev/

Fuad Tabba (3):
  KVM: arm64: vgic: Drop the pending state of all LPIs when disabling
    LPIs
  KVM: arm64: vgic-v3: Don't save pending tables with LPIs disabled
  KVM: arm64: vgic-its: Don't read the pending table when mapping an LPI

 .../virt/kvm/devices/arm-vgic-v3.rst          |  1 +
 arch/arm64/kvm/vgic/vgic-its.c                | 33 ++++++++----
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            | 13 ++---
 arch/arm64/kvm/vgic/vgic-v3.c                 | 50 ++-----------------
 arch/arm64/kvm/vgic/vgic.c                    | 16 +++++-
 arch/arm64/kvm/vgic/vgic.h                    |  1 -
 6 files changed, 49 insertions(+), 65 deletions(-)


base-commit: 181a701fc14d3d468c603b5ecfb9f12115c5fb72
-- 
2.47.3

