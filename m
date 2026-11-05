Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876465;
	b=nepUbod1YHf6/BWNIMtDWibH3zrO2qMfA/wmjJmVXYZghZHiwDEFbiwbCJKlMtsbRHjb
	 /IWLacPXpFybhQsuUyK5x3Bvc04xIhg2HHy92FGmcu9PUt8gKUHhCXbfvxLLtLXaNn5iH
	 3QyEJ4s2TU6EW36AkoO5pBw/xXF8sKEsctz18JplqZkHSV5TLOW1BUvZd7zcXxMxu0VmY
	 qLsdJhCjE49FZAS6Fr3IITy2eTw/ziNIVd4oSd/dhGwjgknOI/r5dIm7tH3I+l7TpRSRP
	 rqXzYCpUxx0SpecG+zSjjrqxqjQeLaqQc8teUvAOMJDB+KrATsioH6PDeGMCxELuLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876465;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Zth+ioNeco6Y26/nGtuUwgodoU7stROkCOLzqhbMwj8=;
	b=SZDo0hlPlkRAPyPWchllxhS6rDA9PFaqHndi8LpOwBDQBsWnRxSQ4llQ2WkA8eh0YV0B
	 OXdINcTZI/ggh1D5X9eL6w6vjLt2eHHToVfR0km1rjBT0cRZdeHUYMEgW+EykNXjPkyO4
	 lfkghNhEK1/v+eF1/WruLEq5s8EQX8edtEN8hb+yoDR+Q7wML4+eFI51tCg30OBLlMJw/
	 y7keeESd91ON+rPQvB5RYG+OuDaiuNYLXz3tSEcIS0HqIgLWwYiox7LQWZIfePstEIsGO
	 gZ7Md3GIYC9ufWa8yIc6mI22gys6iIjdB0viNtj57YCVwh4giPKWJ8QBNFtl2HUag9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bkbXfAYz;
	arc=none smtp.remote-ip=91.218.175.185
Received: from mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E8606A330
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 11:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C38E8606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bkbXfAYz
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=etVrSQDuUpX2EwqNodnkS74XlA/kEpDepAAYv3ksNZ0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793876462; v=1; x=1794481262;
 b=bkbXfAYzV5yJpZWt0hYSc5BCd/jJ1UJOzPAfuYCIm9gOLGemof5NbmkoLWEfULSDiYg8qqQ2
 ES+eFkpjeK0cQ+m0M5LUeufY2I+2gHNigXmfJntkxIji9JNGA/SnbR4CnG47ICmt1SaFkvW9LIe
 TwLIuyz53DGOrTapy7aH4Hz0=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 82aeebc9bf92e3fc;
	Thu, 05 Nov 2026 11:01:02 +0000
X-Mizu-Trace-ID: 82aeebc9bf92e3fc
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
Subject: [PATCH 2/3] KVM: arm64: vgic-v3: Don't save pending tables with LPIs disabled
Date: Thu,  5 Nov 2026 11:00:49 +0000
Message-ID: <20261105110050.1244525-3-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105110050.1244525-1-fuad.tabba@linux.dev>
References: <20261105110050.1244525-1-fuad.tabba@linux.dev>
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

KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES writes each LPI's pending state
into its redistributor's pending table, clearing the bit of an LPI that
isn't pending. However, once a redistributor has LPIs disabled and RWP
reads 0, "there are no further accesses by the GIC to the LPI Pending
table" (IHI 0069H.b, 5.1.2) until enabling LPIs reads it. A bit the
guest sets there is cleared by the next save, which QEMU runs whenever
it stops the VM, and the guest never takes the LPI.

Skip the LPIs of a redistributor with LPIs disabled, and document it.
On GICv4.1 this drops the state of a forwarded vLPI there, which the
disable is allowed to lose: "There is no guarantee that clearing
GICR_CTLR.EnableLPIs causes the LPI Pending table to be updated in
memory" (5.1.2).

Fixes: 280771252c1ba ("KVM: arm64: vgic-v3: KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/virt/kvm/devices/arm-vgic-v3.rst | 1 +
 arch/arm64/kvm/vgic/vgic-v3.c                  | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/devices/arm-vgic-v3.rst b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
index 5395ee66fc324..c878d3f728858 100644
--- a/Documentation/virt/kvm/devices/arm-vgic-v3.rst
+++ b/Documentation/virt/kvm/devices/arm-vgic-v3.rst
@@ -308,6 +308,7 @@ Groups:
       save all LPI pending bits into guest RAM pending tables.
 
       The first kB of the pending table is not altered by this operation.
+      Neither is the pending table of a redistributor with LPIs disabled.
 
   Errors:
 
diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 65b77fb35be37..9bbf11ddba92e 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -625,7 +625,9 @@ int vgic_v3_save_pending_tables(struct kvm *kvm)
 			continue;
 
 		vcpu = irq->target_vcpu;
-		if (!vcpu)
+
+		/* While LPIs are disabled, the pending table is the guest's. */
+		if (!vcpu || !vgic_lpis_enabled(vcpu))
 			goto put_irq;
 
 		pendbase = GICR_PENDBASER_ADDRESS(vcpu->arch.vgic_cpu.pendbaser);
-- 
2.47.3

