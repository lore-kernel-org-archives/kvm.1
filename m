Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FF3A6417
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552744; cv=none; b=Nh3a3NbXyIqSUbGv/VhP4GRZ6qketJB/m0WguC3eECSD9SDAXvvO4I1KpBHsM2cXEDOVz7JZIOKAIj7g1XJrgijPkW5fnJLORFTSEuEYv6vr1BBcAGuMXxN0G8iP2J3TJYcx/cI1WuOqAwedwY+OshpFOU53UPX/iANHd+iaXxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552744; c=relaxed/simple;
	bh=2tY+76ukECworN4wCu9OxDM17aGgI9A188pLFTqTnxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u0Wxn3gMjPvaNqk+mrkhRHzcCy6n7tXH3LR4iMOx3dnBrigAxoscjLrC9MFwOBQ4ZL3+HAh6MrY6QFiaYCXSGI3h2J2Zv3DG7oJbQU5LidCSKBg6iTA4EeLgs1UrG0TM3DGDznWBvsfs6gk1ijXiBZfHMXWvsBYgylMusPiByrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzP683QS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzP683QS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9667280edeso477428a12.2
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552742; x=1784157542; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W8I6UE+Eb+CqubsAJ6tNuCjG0jnUp8oSU5c+H+yk2pI=;
        b=qzP683QS0wRktcBz4c1JZH9zkv9aGMWIYcEde55I0ZUZ5qc3+x6Aaw8hq6g3Aai7o5
         kpzRfdt8e5ywVi+ZDc3yMvHpjmz00xCKnOvW/NDpgvgiOoD7PpJyYHode+DpZYXLwxO9
         qHMf9LSRqx75FPIInLcEasRvDezZlIz7qWKmj4kVS2/KrCuAli66nagNhhKyJ7jYRCAI
         lg5ro8BgUVbLcin/B/8/JImI19ZhZG/iiefKMG4cRARlXM6Mv3OnmLHqOIU0Q+muXkX5
         z5+KyAkI4Q4LFatprg1mcDo+wHppHRp4reaqd4bfSO2d/B0NmU1qHTcy4kscTGM2RwsA
         InkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552742; x=1784157542;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8I6UE+Eb+CqubsAJ6tNuCjG0jnUp8oSU5c+H+yk2pI=;
        b=G80zmFWYdJ24FI6dAPOgwEc8RbixCRLWIYXJmkwEVclL7kBvj9zI+1K8MU2Gj/1Z2w
         Kp5WI0MXAZFISIwVGiAMpo4SwslKjVanxM9/cO/5wDI1xeY1tXcs1hMqneaPiNUzCKv+
         x8Cq0YmqQiY9pKA7CGbz1DZ/S9esuhtd+Xb7Sq79bTXcPTtsOuE7k8mfzuOctHro+Yhk
         ivKJY/HnDNAGm+g2EW1aW0+rM6LU0duiQ/VZtf2MA2OiD0hfGie8XZeAfbAOWBihU4Fo
         HZEmmZPmQFdvL2wAHq5GqL94EwgyxgktIby99k9Z9i4wB+aBFUP41GJI12Zg4xBzMcNn
         oGzg==
X-Forwarded-Encrypted: i=1; AHgh+RrWpwyN0lWnlXqhfm1fjGznegcuxsuZKvOa4UoXDBCSoc9THVoN/zJmeUgo0jNh/9fKp6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtLpwCwFlwMWAhfvUAvLxh5trrpnhsKUds9PKmj/AB9Wt6X28
	Z3ugCqp5Gjs4JXOMOM4WgLt6yjkdKJz8dUiiruqJgLVu/Nzh8qvAd0YiWzNny2ZvBAjpam296dl
	UUzKJmShT
X-Received: from pfbmc20.prod.google.com ([2002:a05:6a00:7694:b0:846:3c78:e2e8])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:448b:b0:847:834d:b6a6
 with SMTP id d2e1a72fcca58-84842fff014mr4796021b3a.62.1783552742305; Wed, 08
 Jul 2026 16:19:02 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:50 +0000
In-Reply-To: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-3-1272650ca614@google.com>
Subject: [PATCH v3 3/9] vfio: selftests: igb: Use advanced TX and RX descriptors
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The submitted driver builds a partial legacy TX descriptor (just
DTALEN | CMD_EOP) and never programs SRRCTL.DESCTYPE.  QEMU's emulated
igb tolerates this by treating descriptors as advanced regardless of
DESCTYPE, but real 82576 hardware does not.

For receive, 82576 datasheet section 7.1.5.2 states: "SRRCTL[n].DESCTYPE
must be set to a value other than 000b for the 82576 to write back the
special descriptors."  struct igb_rx_desc matches the advanced
one-buffer writeback layout, so the test polls rx.wb.status_error,
which is only written in that layout.  Section 8.10.2 places DESCTYPE
in SRRCTL bits 27:25; program it with 001b (advanced one-buffer).

For transmit, datasheet section 7.2.2.3 describes the advanced data
descriptor with DEXT (DCMD bit 5) marking the descriptor as advanced,
DTYP=0011b selecting the data descriptor, IFCS (DCMD bit 1) asking the
MAC to append the Ethernet FCS (without it the frame is dropped as
malformed), EOP (DCMD bit 0) marking end of packet, and PAYLEN in
olinfo_status[31:14] carrying the total payload size.  Build this
descriptor in igb_memcpy_start().

Remove the legacy CMD macros (IGB_TXD_CMD_EOP, IGB_TXD_CMD_IFCS,
IGB_TXD_CMD_RS, IGB_TXD_CMD_SHIFT, IGB_TXD_CMD_LEGACY_FORMAT) that
become unused, and add the SRRCTL register offset, DESCTYPE encoding,
and advanced TX descriptor field macros.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 37 +++++++++++++++++++---
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 58c6aceea63a..f4f6d2ee262d 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -235,6 +235,17 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, E1000_RDLEN(0), RING_SIZE * sizeof(struct igb_rx_desc));
 	igb_write32(igb, E1000_RDH(0), 0);
 	igb_write32(igb, E1000_RDT(0), 0);
+
+	/*
+	 * Select the advanced one-buffer descriptor format.  Per 82576
+	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
+	 * value other than 000b for the 82576 to write back the special
+	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
+	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
+	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
+	 */
+	igb_write32(igb, E1000_SRRCTL(0), E1000_SRRCTL_DESCTYPE_ADV_ONEBUF);
+
 	igb_write32(igb, E1000_RXDCTL(0), E1000_RXDCTL_QUEUE_ENABLE);
 
 	/* Wait for TX and RX queues to be enabled */
@@ -330,11 +341,29 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 		memset(rx, 0, sizeof(struct igb_rx_desc));
 
 		rx->read.pkt_addr = cpu_to_le64(dst);
-		tx->read.buffer_addr = cpu_to_le64(src);
-		tx->read.cmd_type_len = cpu_to_le32((u32)size | E1000_TXD_CMD_EOP | E1000_TXD_CMD_IFCS);
+		rx->read.hdr_addr = cpu_to_le64(0);
 
-		/* Set to 0 to disable offloads and avoid needing a context descriptor */
-		tx->read.olinfo_status = cpu_to_le32(0);
+		tx->read.buffer_addr = cpu_to_le64(src);
+		/*
+		 * Build an advanced data descriptor per 82576 datasheet
+		 * section 7.2.2.3.  DEXT marks the descriptor as advanced
+		 * (required by hardware); DTYP=data selects the data
+		 * descriptor; IFCS asks the MAC to append the Ethernet
+		 * FCS (without it the frame is dropped as malformed);
+		 * EOP marks end of packet.  DTALEN is the buffer length
+		 * in bits 15:0 of cmd_type_len.
+		 */
+		tx->read.cmd_type_len = cpu_to_le32((uint32_t)size |
+			E1000_ADVTXD_DTYP_DATA |
+			E1000_ADVTXD_DCMD_DEXT |
+			E1000_ADVTXD_DCMD_IFCS |
+			E1000_ADVTXD_DCMD_EOP);
+		/*
+		 * PAYLEN (section 7.2.2.3.11) is the total payload size
+		 * in olinfo_status[31:14].
+		 */
+		tx->read.olinfo_status =
+			cpu_to_le32((uint32_t)size << E1000_ADVTXD_PAYLEN_SHIFT);
 
 		igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
 		igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;

-- 
2.55.0.795.g602f6c329a-goog

