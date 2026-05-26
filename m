Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9937C3E8699
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839723; cv=none; b=A3doF8N3V99ky7amdY8Iwj5TzwrhL/Levx1r26ZrQ9OuCX/jNmCDV7ZEszOBCqbNLE2mOORadknBi60YCczoxr9BaFzuy3Ql8O5KDgktHp1xFwC421MRfMIIZV79tWZZMPNiBEDQT+Vte7UrAqdtEhk7Npwa5a+ozFEHbbhth0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839723; c=relaxed/simple;
	bh=VQh9ycIq/sQw5zQ6MT1xTqUvZGeINgII+2poi1PGM74=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pvyQsYznN1pzoJrN7vJU4h2lQrSn+wWJF4enohPqo67lgcjJzInvGu1DGxLYpMPKjB5fnIGVisBxN1URyc6yR30YAMLebEvYH5q+IJSHPobhk3MBiIz/geTMVUttg3C8J8Jka69Ac7GJSuTy4bMyicuiv19coY1tc17vvlCQPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h8UJUi0R; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8UJUi0R"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ba224c3ffdso10984935ad.0
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779839687; x=1780444487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YppsghfGH6D340aJjNneB6gAMUs9CtxpsUi5k9VDxXY=;
        b=h8UJUi0Ru/muUsLXmZ+orfDCx2wEXYvLVgp5F4nH78rTraYscxeGuDc/LLYhMdeoQm
         Zxz2cpxZx50XqqqJc53lEUTQFlUhrOFaAF/Vz/jdvAPVRZqRMocHkZroUOKTy0B5X2b4
         xSZn7g2jniog3TAfTSy9/t4q+06yv7ZeA5DXfQPGgTFA/Hc9oP8hJjukCS0CtRTN68rp
         o10anZL8TvMsvwvRYLwqoqaFjLxLguC8pnG7law1JtZZNep9MMzx7rAkC2ID/XPdXv3i
         RgGQTAzRROugsP2wTY1A3F5I0pdTOpygImG2RuF8om63tZ6VQ4GewK/7Ngf5FSGDnhLF
         8JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839687; x=1780444487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YppsghfGH6D340aJjNneB6gAMUs9CtxpsUi5k9VDxXY=;
        b=C5Z0Q9NOn54pUukEmy4tdmxO6o+AYwMI8c4ZMgATHB36FkZ16jFBXb2GvjYPgCBT+U
         qHsfnaWKvJHog/sRRONrup9hQ58/MBVXP8lBE5swGQt1hOzE9BrT6fTXAAuSfUWu7eDU
         tnA/4dHQ6OR+wjzfnRxApaJSMXNy4copn2XEmQSNQLIScmIpxD+1b1cjpIhR5LtcnvRK
         9Lftqf9ry4cIhqxi4MT6ceFXgvFZWUzg6xkkHovep50aWkH6vhumW8z12HJh7xWQBoBG
         ZQBBC+EWdyLw9D4+RmCvgNS4ht6gDUe/+hLn3ptXORvXRs+YquEqpYR03nOvqh+J5UtX
         5Jdg==
X-Forwarded-Encrypted: i=1; AFNElJ+DvIz/xgPXkI83yWFqzif33f125wJDEl3lI/ZUchsJEe1JRezWAXlC+EzmXv9yxeZpxSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymrORxAK8utAq2YpSrCw7EZb67HdUrAnJXjsrRhlDVobktgqLv
	mvagwN8SvDVUEV2WsNajIjPd/smar70jwJY0yG8PwF+dkZgmAcxKhBlbM9mlUViIWisyu91X0rt
	ufiyP/gY+
X-Received: from pgbbk8.prod.google.com ([2002:a05:6a02:288:b0:c82:cd84:79d])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:41c9:b0:2bd:5ab:af95
 with SMTP id d9443c01a7336-2beb023584amr217494565ad.0.1779839686876; Tue, 26
 May 2026 16:54:46 -0700 (PDT)
Date: Tue, 26 May 2026 23:54:12 +0000
In-Reply-To: <20260526235417.2058313-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526235417.2058313-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526235417.2058313-6-jrhilke@google.com>
Subject: [PATCH v2 05/10] selftests/vfio: igb: Extend memcpy completion
 timeout for line-rate hardware
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The submitted driver waits at most 1 ms (100 * 10 us) for the last RX
descriptor to be written back.  QEMU's emulated loopback is synchronous:
by the time igb_memcpy_wait() runs, the receive descriptors are already
written back.  Real 82576 hardware processes the descriptor ring at
line rate.

max_memcpy_size is (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE, approximately
4 MB, split into 4095 1 KB frames.  At 1 Gb/s line rate (~125 MB/s),
4 MB takes ~32 ms on the wire, plus per-frame preamble, SFD,
inter-frame gap and FCS overhead (~3%) and descriptor fetch/writeback
latency.  The 1 ms cap times out long before any valid transfer can
complete.

Wait up to ~200 ms (200 iterations * 1 ms) for descriptor writeback
before returning -ETIMEDOUT.  ~6x the line-rate floor leaves comfortable
headroom for host scheduling jitter while keeping the intentional
invalid-DMA tests (mix_and_match) so they recover quickly on real faults.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 .../testing/selftests/vfio/lib/drivers/igb/igb.c  | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index a8f2072b6820..879c21780f5b 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -403,11 +403,22 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 	prev_tail = (igb->rx_tail + RING_SIZE - 1) % RING_SIZE;
 	rx = &igb->rx_ring[prev_tail];
 
-	retries = 100;
+	/*
+	 * Real 82576 hardware processes the descriptor ring at line rate.
+	 * max_memcpy_size = (RING_SIZE - 1) * IGB_MAX_CHUNK_SIZE ~= 4 MB,
+	 * split into 4095 1 KB frames.  At 1 Gb/s (~125 MB/s) the worst
+	 * valid memcpy takes ~32 ms on the wire, plus per-frame preamble,
+	 * SFD, IFG and FCS overhead (~3%) and descriptor fetch/writeback
+	 * latency.  Wait up to ~200 ms before declaring the device hung;
+	 * ~6x the line-rate floor leaves comfortable headroom for host
+	 * scheduling jitter while keeping the intentional invalid-DMA
+	 * tests bounded.
+	 */
+	retries = 200;
 	while (retries-- > 0) {
 		if (rx->wb.status_error & 1)
 			break;
-		usleep(10);
+		usleep(1000);
 	}
 
 	igb_irq_clear(igb);
-- 
2.54.0.794.g4f17f83d09-goog

