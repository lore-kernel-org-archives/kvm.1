Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD303AD514
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552746; cv=none; b=osLz7VCOGuZ+sFFDB7eAhWds2OKVuroLaVdQ+8gDTzjsskxt1v9J0N220kvpb1wEL1YEJH+vZU3huNNMw8Mm69QsYlX9rM+bt3UmCAGxpwwTjNi80XaTHpE5xqw1QfaYq0LB+2sY1y/OQwmEpUjk97SyNxAzL0EuQxzI0rPaTs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552746; c=relaxed/simple;
	bh=Asrc2jqLWZ8McUsNCl8V+brf3DaScqJp6GiYRksFOaI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KR28GzuMmc+tAqwT9UkN0RYVvvjx7TafVxk36PsfNBV6Iw2xKHYUaOpnmscF/lbDrcUg6/SDRP5u3DAyS1jSKczCfBguQruo/FSvztT6ROlydwhcL+1WcsPC/UnC/rydtezUKnQ2z02+e8+WRIFWndxaBRPIcIW6Fo/CQLu1qjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjwnSatQ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjwnSatQ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a298cd62so1223550a12.0
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552744; x=1784157544; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jpna3TQ6YosBT2JOPlPkJdlqdBE0UdDtIn99NEOpE50=;
        b=EjwnSatQHkj2A7sy+jEbTM/pC08a2pWtAdU7a3iEi75NS63Gh41T2Lj0GaIjBZfosW
         hFLWBNv00ChPHNrZIzhRGT0RVnaysdI3+ND++yLHlNncUSktqkcyrJk7uB8uFTSs4egE
         0c7dLgK30S0Elp9LcDF8OnbEZcyhRlLYjyqunuH6a5pkLFsaazJsEVqbuVFEHrUyIOQR
         dxGZwS+rg7UvbUTZX2lXJ2xqbvf3ORjlg3X9s/cXOONzBt7TQFCI+3MwnZcdHFYC5o9f
         xvzw6W1dLNbyOWdMlN1vbWHvoMTafHhzOf7jqHU44Yi6ZAXLDo4dgOG2M1TfiG/HZ0Xt
         G7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552744; x=1784157544;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jpna3TQ6YosBT2JOPlPkJdlqdBE0UdDtIn99NEOpE50=;
        b=WGmSx+1RueWJIhg1Ss+cbIzdOUlH78Q/O2xaPXIQJRL/p+ZIPBjqZdV7DJjZuwX6cn
         QpzmlUrL98PrWNs9c21F8VjHAeC8lxhWC8VxDYUjIb+Bcj4Z+XtrgasS4uhVmNwtXyvu
         TluT8XD8ghpjrQjsBmbKAHxGd21MtA2Ww/is3PwMseh9WnbK8QdIDjPPWRkunu9xBtfv
         Gk/u1IADp+O5jZO0lK+TTB6BzHMSwas6ss56BsN1OZDCz78tVPMKnMEojDtQpjx7pnfE
         ZRd5bXWN6bsZhPgGIhNhN56C9KEZteMnSeLyRZVxohJCspwPv4L6HKSw8EGj9teepAjC
         o5ng==
X-Forwarded-Encrypted: i=1; AHgh+RqjJug/Qam93pa3MhyAyRN1hmlu1Kt9z28ZFUrzTGSoC7H4E2PKjGgoeNuZjQODpaou09g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7RZzP2RdvYlwSHnlDiRIvtUbLdaKvvkixAt388WItRJwanl3
	hsS4tp9m15lr+iWtyIRr7RwNP7PA4ksZCcz0q9FVDn50VEIclvL/6RedPv7R5J/PzL0mAOKeuae
	9hN59uhkh
X-Received: from pgjf11.prod.google.com ([2002:a63:dc4b:0:b0:c9a:53ea:434a])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a394:b0:3bf:6c04:a812
 with SMTP id adf61e73a8af0-3c0bd159be5mr6111912637.51.1783552744017; Wed, 08
 Jul 2026 16:19:04 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:52 +0000
In-Reply-To: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-5-1272650ca614@google.com>
Subject: [PATCH v3 5/9] vfio: selftests: igb: Extend memcpy completion timeout
 for line-rate hardware
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

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
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 637d05e872de..1848be6cd46c 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -412,12 +412,23 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
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
 		status = le32_to_cpu(READ_ONCE(rx->wb.status_error));
 		if (status & 1)
 			break;
-		usleep(10);
+		usleep(1000);
 	}
 
 	igb_irq_clear(igb);

-- 
2.55.0.795.g602f6c329a-goog

