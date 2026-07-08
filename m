Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDEE3B27C1
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783552748; cv=none; b=AzG6iolBNTpGXh4TVQhFMWHVv6rV2xTQseY+eJq0Jopfp5vgpIBzDDbYyB4Stgri3v0eJb/ALH7FKxkMEv5oQGSHm1qhZG0EZdAdhySHGtiDyS1j2jlLG0ws8SIit7UJ/D026X7t9C6LGb907SsTzAc5zzjg/+UjZHMBDNKg8w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783552748; c=relaxed/simple;
	bh=15txIjHGpudmFhG7+GJagjUMBXbzz9ex0zDYfR201nk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxHC1AnMNhA5/zL6i7siv88K7iiQY6ZJ8/bi1/KMApJyBUGxZKMCGUzDd22Wzf3XMekwuDU3f2307wJlCAvwqUJ7Rru+xS0E7QzcK4Rh45lFWQakeBGosBilxFY3O4M2/KqX2le2JDqYufaGZFfs6HMJXZ1kWLZ2MFaSmXPE8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icZXrlKy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icZXrlKy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9fe2607511so1665906a12.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 16:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783552746; x=1784157546; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q6mpE+1DYhQST2Lq8stccPrw6SlzcA9MgaY8lZpHwgE=;
        b=icZXrlKy9jBBsVpIuvFTFKp7ljfZakwm9dim2ZaFGkBu7Fv6IpJD3AuPkaHIoFwcxN
         awBAuzWBCQg1pJotUoPahHjjlTl1kFI7w+pbsFupxExqenh0PPB2PbgFMe92jT8KBpil
         IIsD6Zy/Mj0Vf7XHmz+7+Zyk2CiJ7zXnWAUvekoHG3kNgYTh/wdb7SOaVdRiW015CPqY
         oRbNu5KWiFYlxi6e4spcRR85kZgI1Rf6AaJ9GU8sFcsF3+7r/1T0W/jVBDg1ebwdMYi2
         +WH7PxJta+pAZdmiK91XK55KHEk8X6Kluk4dRz9xXEPi5k4sHB3NlCvyLuknCHAuhhDJ
         3J8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783552746; x=1784157546;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q6mpE+1DYhQST2Lq8stccPrw6SlzcA9MgaY8lZpHwgE=;
        b=ClkTZVpiKtkYQy4w7X7yX5OCV3cmzs1kUOtvaddREHlBy4e6ajySX1GKIhdYTHMYCa
         RW8u1vbBiMgpVpAtrp2N4ggwDim/ZhqW3hKJJljI47zUGmbDoZJ1EtdjnxfQkCUv1p7g
         gksC63/w66cntVroVa5YHDnvYDFzXgYRoJAkVJqdLQUdoGYNOLlObBAXbTU2hD+d77L7
         TZ7ijPOne05H2fftxatK3LJJCEvX/yX+D8iit8WHxoPWe+xDqiKHflr6SlKtdSeYOpvd
         p2R02sxHtndBoD8rKe3PBgRUUe2mUpODlY+++ujjFVu0CrJQAZ/+LJJDGbsuLVwlRisV
         KE9A==
X-Forwarded-Encrypted: i=1; AHgh+RqHP6gMPCcOQ2ZBIUkMIdnygApbaj7CchweE1V/Rc6bJrkThdg6uW1iP1YLeP8/29ZYoHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyh5Z/lMepfNiwziT3vMhMt2V07VUaAtFPYA69Abp9aI1401si
	dNvk9ve7Paqa3m5LKIiLHGsPYsCOdpWxX3lI/q3+w5J4F4KXJK+dOPU+Si3Uvhfr+4EEFlwrhbI
	hTVYqy6es
X-Received: from pgjm22.prod.google.com ([2002:a63:fd56:0:b0:c9e:1b4c:6a93])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a96:b0:3bf:e2f1:1b12
 with SMTP id adf61e73a8af0-3c0bcbc0460mr5510827637.41.1783552745955; Wed, 08
 Jul 2026 16:19:05 -0700 (PDT)
Date: Wed, 08 Jul 2026 23:18:53 +0000
In-Reply-To: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708-igb_v3_b4-v3-0-1272650ca614@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260708-igb_v3_b4-v3-6-1272650ca614@google.com>
Subject: [PATCH v3 6/9] vfio: selftests: igb: Disable PCIe completion timeout retries
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The mix_and_match test intentionally submits TX descriptors with an
unmapped source IOVA so that the DMA read fails.  By default the 82576
re-sends the request after a PCIe completion timeout (datasheet section
8.6.1, GCR.Completion_Timeout_Resend, bit 16, initial value 1b).  On
real hardware this turns a single fault into a stream of retried reads,
keeping PCIe AER and IOMMU error handling busy and interfering with
reset recovery.

Clear GCR.Completion_Timeout_Resend during device initialization so a
failed read fails once and stays failed.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 1848be6cd46c..a7a30660b23e 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -219,6 +219,18 @@ static void igb_init(struct vfio_pci_device *device)
 		vfio_pci_config_writew(device, PCI_COMMAND, cmd_reg);
 	}
 
+	/*
+	 * Disable DMA re-send on PCIe completion timeout (82576 datasheet
+	 * section 8.6.1, GCR.Completion_Timeout_Resend, bit 16).  The
+	 * mix_and_match test intentionally submits descriptors targeting
+	 * unmapped IOVAs; with the default (set) value, the device keeps
+	 * retrying the failed read indefinitely, which keeps PCIe AER and
+	 * IOMMU error handling busy and interferes with reset recovery.
+	 */
+	ctrl = igb_read32(igb, E1000_GCR);
+	ctrl &= ~E1000_GCR_CMPL_TMOUT_RESEND;
+	igb_write32(igb, E1000_GCR, ctrl);
+
 	/* Configure PHY internal loopback for testing. */
 	igb_setup_loopback(igb);
 

-- 
2.55.0.795.g602f6c329a-goog

