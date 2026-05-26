Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308293E4C95
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839702; cv=none; b=BbWa/aN+2HWagDK9eZxUWatFLGue9vB43cukr7b9LsNGCsvEd1a0+8nbIxA37nPdNt57nz93TRKSFHzeWq2+S5TZnhQ3rIHUmSQ+5gZvdqLBiyAphFW1teDHcvnrFZv+0wY3QanPzKZqpOZP0upgD2DzNQXhR8y7ulpDhyjyssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839702; c=relaxed/simple;
	bh=MqagnCXsJ8cLSH/HVOQmSJIOM/I+9myp2EmON4c5qQY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EZNA/uw5GvUji8RnUpcuwXhX0jY1OTFw/InJqWGnpDbryycJkjMeGs0mMIlxU/IqPt92ahV+s4wmmKdBvWYfhR0VsQuyeFfnlx53W8iCOA2tl6jHgWNsqUkZ3PYl8k+0/6GnyC3gxv47uRTcEkWfx4vK8pHfqGhwr715b85gtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUnohp7k; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUnohp7k"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-368ac44b26dso9845651a91.2
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839684; x=1780444484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRZoVX5mdT8hXhMzFQTThzJhZE7tF2U5Cd8ydRihcNM=;
        b=iUnohp7kjsdG+oysLkWx+5zp2tovCwSbsdWqgAB1tj1AGrs8tPgdlXPnpf4Jap76kk
         pDpIy+tI0bRprgpcz8ch6XJN7u8J3SWHu6EhuaAsuL2+Oq9czZf7uiCOVRYUKPvcQsx5
         Y8/jCZ6k0BszHJroqW1i1PzjFGMs/4lY7puN+E9/DCaWJF8uJ0vmgCGX+NlyAblMkiPO
         ksNDwNazgPThE+bU6oPNCcQmt95BvUeUh8bNnjKAyH3a/Gz95andmacZftIvTpjNn6Ny
         zZ3wsYQObPt+hPnt5WOHBy8TshVXRgUNofEBWzIpnLZQ/R6um+lRw8TGdmdo+5AObKdh
         FuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839684; x=1780444484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRZoVX5mdT8hXhMzFQTThzJhZE7tF2U5Cd8ydRihcNM=;
        b=fGZci/Gv4UGqiT6rkARNeSvd1Bw9+lPmPPiPwO9AUsO6WZS3UlvlEBLqg96t2lRaDK
         vPMe76o/jhe3Q8nNcoyxwnWnuLUb4WuqrPERdrlLuda4RgebBrbzJq//9zu7G8LLErZm
         NnYsRFcNaApYgRVecEA/LY+lCMgnxCQGbPyn1a1fkArrbMPMg9kBzsJXqWqU5wVl4fqU
         nSDPiJ+2bJoV66togeQ6fi/jBOp5YRe35Opj4Ixpqgx5QiKYWxeSLfyyPuC7WPmh4bE6
         P7z3ZA47inyfxkFKreKRf2j/i8iTmywrwctR1Z3nyXhoZnKzJvaAGL+q0EVb/a0/+thM
         /W4w==
X-Forwarded-Encrypted: i=1; AFNElJ9o2WH9zCAJtuoJML0Z+hwfbFGIGdR9JglDZy0XwHd89BFU9J6Y7Fbuic75Zb7TnXjRtLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjq08EIKtf6CwxizCrIaraSNxzLPBHZtdjEyHFyLohy13keax0
	9/lIlWFLLzdPO0Cnz3qsm2WJvvVlh/JzszdonSE+bmHr/nbYdOZzue/rdryBgc9CjGQ8trLaMww
	zKl4dNiYt
X-Received: from pjbne9.prod.google.com ([2002:a17:90b:3749:b0:369:9ea8:ea42])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3906:b0:368:b4a5:c4dd
 with SMTP id 98e67ed59e1d1-36a676f0275mr19832535a91.2.1779839683679; Tue, 26
 May 2026 16:54:43 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:10 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-4-jrhilke@google.com>
Subject: [PATCH v2 03/10] selftests/vfio: igb: Use advanced TX and RX descriptors
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

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
 .../selftests/vfio/lib/drivers/igb/igb.c      | 38 ++++++++++++++++---
 .../vfio/lib/drivers/igb/registers.h          | 21 +++++++---
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 5bbc6fca7518..c0f9cefb23e5 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -226,6 +226,17 @@ static void igb_init(struct vfio_pci_device *device)
 	igb_write32(igb, IGB_RDLEN0, RING_SIZE * sizeof(struct igb_rx_desc));
 	igb_write32(igb, IGB_RDH0, 0);
 	igb_write32(igb, IGB_RDT0, 0);
+
+	/*
+	 * Select the advanced one-buffer descriptor format.  Per 82576
+	 * datasheet section 7.1.5.2: "SRRCTL[n].DESCTYPE must be set to a
+	 * value other than 000b for the 82576 to write back the special
+	 * descriptors."  struct igb_rx_desc matches the advanced one-buffer
+	 * writeback layout (section 7.1.5.2), so polling rx.wb.status_error
+	 * requires this format.  Section 8.10.2 specifies DESCTYPE[27:25].
+	 */
+	igb_write32(igb, IGB_SRRCTL0, IGB_SRRCTL_DESCTYPE_ADV_ONEBUF);
+
 	igb_write32(igb, IGB_RXDCTL0, IGB_RXDCTL0_Q_EN);
 
 	/* Wait for TX and RX queues to be enabled */
@@ -322,12 +333,29 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 		memset(rx, 0, sizeof(struct igb_rx_desc));
 
 		rx->read.pkt_addr = dst;
-		tx->read.buffer_addr = src;
-		tx->read.cmd_type_len = (u32)size;
-		tx->read.cmd_type_len |= (u32)(IGB_TXD_CMD_EOP) << IGB_TXD_CMD_SHIFT;
+		rx->read.hdr_addr = 0;
 
-		/* Set to 0 to disable offloads and avoid needing a context descriptor */
-		tx->read.olinfo_status = 0;
+		tx->read.buffer_addr = src;
+		/*
+		 * Build an advanced data descriptor per 82576 datasheet
+		 * section 7.2.2.3.  DEXT marks the descriptor as advanced
+		 * (required by hardware); DTYP=data selects the data
+		 * descriptor; IFCS asks the MAC to append the Ethernet
+		 * FCS (without it the frame is dropped as malformed);
+		 * EOP marks end of packet.  DTALEN is the buffer length
+		 * in bits 15:0 of cmd_type_len.
+		 */
+		tx->read.cmd_type_len = (uint32_t)size |
+			IGB_ADVTXD_DTYP_DATA |
+			IGB_ADVTXD_DCMD_DEXT |
+			IGB_ADVTXD_DCMD_IFCS |
+			IGB_ADVTXD_DCMD_EOP;
+		/*
+		 * PAYLEN (section 7.2.2.3.11) is the total payload size
+		 * in olinfo_status[31:14].
+		 */
+		tx->read.olinfo_status =
+			(uint32_t)size << IGB_ADVTXD_PAYLEN_SHIFT;
 
 		igb->tx_tail = (igb->tx_tail + 1) % RING_SIZE;
 		igb->rx_tail = (igb->rx_tail + 1) % RING_SIZE;
diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
index 388862d481eb..9a8b0f830f89 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/registers.h
@@ -20,10 +20,14 @@
 #define IGB_RDBAL0 0x0C000 /* Rx Desc Base Address Low */
 #define IGB_RDBAH0 0x0C004 /* Rx Desc Base Address High */
 #define IGB_RDLEN0 0x0C008 /* Rx Desc Length */
+#define IGB_SRRCTL0 0x0C00C /* Split and Replication Receive Control Q0 */
 #define IGB_RDH0 0x0C010 /* Rx Desc Head */
 #define IGB_RDT0 0x0C018 /* Rx Desc Tail */
 #define IGB_RXDCTL0 0x0C028 /* Rx Desc Control */
 
+/* SRRCTL fields per 82576 datasheet section 8.10.2 */
+#define IGB_SRRCTL_DESCTYPE_ADV_ONEBUF (1u << 25) /* 001b: advanced one-buffer */
+
 /* Tx Ring 0 Registers */
 #define IGB_TDBAL0 0x0E000 /* Tx Desc Base Address Low */
 #define IGB_TDBAH0 0x0E004 /* Tx Desc Base Address High */
@@ -98,10 +102,17 @@
 #define IGB_GPIE_EIAME 0x10 /* Extended Interrupt Auto Mask Enable */
 #define IGB_IVAR_VALID 0x80 /* Valid bit for IVAR register */
 
-#define IGB_TXD_CMD_EOP 0x01 /* End of Packet */
-#define IGB_TXD_CMD_IFCS 0x02 /* Insert FCS */
-#define IGB_TXD_CMD_RS 0x08 /* Report Status */
-#define IGB_TXD_CMD_SHIFT 24 /* Shift for command bits in cmd_type_len */
-#define IGB_TXD_CMD_LEGACY_FORMAT (1 << 20) /* Forces legacy descriptor format in QEMU */
+/*
+ * Advanced TX Data Descriptor fields per 82576 datasheet section 7.2.2.3.
+ * The cmd_type_len word holds: DTALEN[15:0], MAC[19:18], DTYP[23:20],
+ * DCMD[31:24].  The olinfo_status word holds: STA[3:0], IDX[6:4],
+ * POPTS[13:8], PAYLEN[31:14].
+ */
+#define IGB_ADVTXD_DTYP_DATA	(0x3u << 20) /* DTYP=0011b: advanced data */
+#define IGB_ADVTXD_DCMD_EOP	(1u << 24)   /* DCMD bit 0: End of Packet */
+#define IGB_ADVTXD_DCMD_IFCS	(1u << 25)   /* DCMD bit 1: Insert FCS */
+#define IGB_ADVTXD_DCMD_RS	(1u << 27)   /* DCMD bit 3: Report Status */
+#define IGB_ADVTXD_DCMD_DEXT	(1u << 29)   /* DCMD bit 5: 1b for advanced */
+#define IGB_ADVTXD_PAYLEN_SHIFT	14           /* PAYLEN bit position */
 
 #endif /* _IGB_REGISTERS_H_ */
-- 
2.54.0.794.g4f17f83d09-goog

