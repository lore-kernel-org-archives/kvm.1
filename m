Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B928175A81
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674920; cv=none; b=AZSxGXn6FdbFTPwj8FCvAQkfAJgTfqXPhsDeq3HF4aGreknjks0tvkXYfVxzbY3B8RSN3AODoICU8viHyz7Pj/EJ4wrzdgMdzwGJIgppcY76I+DEdS+Df9Hwqr6a6nCJ2y1ewXEVWXwP3+Boz6DTJBEHN8t0Zx4Uf/8xAo4hQ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674920; c=relaxed/simple;
	bh=3Cr1A2POjnzCcB+br8SYLnQSxPktoAwhRXdyXXPM+u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtETZUPmzhUZwmpZFBy3IBiqMLiognqDOiepk101IYYdB+QKQUg1q3EYSLCjbd1eqC4SLPr9SLkfzWk3j3mv2qLCo89TsnAUTN7k1l3GndlD9O2UIrQOL2oHQIqYLsCypXwz8PXtlBIoWhHkj73eq7CjMHgy/b6PUwG0oXKVhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IDed4SxW; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IDed4SxW"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so7594542a91.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784674919; x=1785279719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0aWumlEryAynaem4cRcgrK4xla2uDWMaLo/YhEcBEUA=;
        b=IDed4SxWCLZqmn/TSrpuwNbKh+HjxKUkvypBwndDYPp/fjg1RiEmaMd2aIMf5u92G+
         Q6Hro1edyv67bT669kKYkhhMAOqGL1jeMdd9NxVg43NEJJQugNREmMEzOujWBXpxy6HA
         hmN7pOnF2goqqitaNdnCab1zzXxl6BFinI1eByakTjNGygx2CVb8sNjAj09aaU/cZimu
         sn9CIRCqy6EHQSlgI1T0Xw/BJcR57ZOHz4DGY6AQVMj6FLS9qXwy8mGrXrHukKfLPB5C
         0r49nkMtNrj1oRp+Bd8C9odWBGmekuPWzc3v4hSBtJFVE2xrLavUcthk47Ty0g8XNKcc
         bSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674919; x=1785279719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aWumlEryAynaem4cRcgrK4xla2uDWMaLo/YhEcBEUA=;
        b=T4dsxxi64qqSBjEzPJEaAKA32XMmgRLxgaOWk7JaAVvWAStP1usH4R2keOMOazw4Jq
         U3VWqCG6o5NbyQfH08Zpy+fhzKf+lfiURmvnxl8P5GH5VdxsuBlpcAzNqN2+HUcneoJL
         uN6wSTPvpHk01P5KIaVKms6d5ypOMmb1+mP8nJmvwdQto1A4yrMh8jzmzENVGjebAE97
         QZA+CqNB7CH99/aX/dleJXBHEFcL4etU5DOVFZtigY//r/4dLtjoMY04oDt3rqxH8oUZ
         k74CGZ7URWcv3T3aw2Dprw4DIRWgxL9nD0LjLP7rBovVWHMeIe7u49njD/GXqZW70kvB
         hTFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoQqWgbuJZqOU+0igtcfcd53fxVAt7qxaPi+ktF0wjzUK4H796zNUoQv7opX0lucCtulU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCG3KnE5l1sMJSLXpAFz1Ru4R/NKWkAK6rRr1wbGMUr6VpvfXv
	j8DXufuxNxVtSBiFaFUeqwd0R+1hYv0w51XRo90oLGN+ZTyiinFITn5M6BnbWtJA1g==
X-Gm-Gg: AR+sD11RsGC2OFrCy1gvK3UQKyk4CkcT34+1gr7Fyy6f434h/PtJT9Ke5UuNSA8m+Ry
	JffziKFpcPJyIelB8j1BKF88UkDOX+coCnY6iWJel6O7Us7A1hOTqFmIA4vJdZtZbIJQxtzzRWs
	BTidOxWUwmNvjtpo4wm2+CIONmvOa9URnUI1nnbFAFYaG5drSz+Rr/ZmmQ8frl/PBQfuS3wyQiY
	1OQ46jDO7l7+/yGM5OB6mS1nWWcgf7gEITizCHESqUvirdU5IGCgLz8I9/HJOvAEpb+maDRiJXP
	U7xOkeBmOzBb4IEH1TBjY71LBbzOvm+Ni4IYaImQlhphkQeF1bJvIp+BPToFc1b3Y8C0sRGNNlN
	9nV5marUUA/9T6AqHaSIYNAJ6cSaarhSSqO3U51t5dvHSHgbDg9DyRld615lf+oqzTGvrtrG04o
	Suwc4GywAe17t41zXVDQEIvhidbYn26h84M1ozRFGk
X-Received: by 2002:a17:90b:4cc3:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-38e4b43ce07mr21638970a91.17.1784674918093;
        Tue, 21 Jul 2026 16:01:58 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea78479b9sm52577a91.1.2026.07.21.16.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:01:57 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:01:54 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v5 0/5] vfio: selftests: Add driver for Intel Ethernet
 Gigabit Controller (IGB)
Message-ID: <al_6YkXnE_vpapNR@google.com>
References: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-igb_v3_b4-v5-0-91503eddb98b@google.com>

On 2026-07-14 08:57 PM, Josh Hilke wrote:

> Changes in v5:
> - Restructured the series from 9 to 5 code patches by folding advanced descriptor
>   support, MSI-X routing configuration, extended memcpy completion timeout, and
>   PCIe completion timeout retry disable directly into the initial driver patch.
>   This ensures a clean, fully-functional baseline driver from PATCH 01 and avoids
>   intermediate legacy descriptor, timeout, and bus-spamming bugs.
> - Reordered igb_remove() to reset the device before disabling MSI-X.
> - Switched igb_irq_clear() to write-to-clear as required by the datasheet when
>   EIAC is programmed.
> - Refactored hardware reset logic into igb_reset() helper with proper sleep
>   (1ms mandated by datasheet section 4.2.1.6.1) and poll-assertion.
> - Simplified reset completion check to usleep + assertion instead of retry loop.
> - Allowed arbitrary loopback test data by enabling Multicast Promiscuous (MPE)
>   and Broadcast Accept (BAM) modes.
> - Fixed igb_send_msi() to use MSIX_VECTOR_MASK instead of magic number.
> - Link to v4: https://lore.kernel.org/r/20260710-igb_v3_b4-v4-0-56e7e2576cc1@google.com
> 
> ---
> Alex Williamson (4):
>       vfio: selftests: igb: Use PHY internal loopback on 82576
>       vfio: selftests: Add helpers to re-enable interrupts
>       vfio: selftests: igb: Factor hardware programming into igb_hw_init()
>       vfio: selftests: igb: Recover after DMA-read faults
> 
> Josh Hilke (1):
>       vfio: selftests: igb: Add driver for Intel 82576 device

This looks good. Let's just fix that reset logic to avoid a magic number
sleep and then I think this is good to go.

I'm super happy we are adding this driver. It's going to make doing VFIO
testing (especially for Live Update) a lot easier by enabling us to
use the driver framework in QEMU VMs. Thanks Josh and Alex!

>  .../selftests/vfio/lib/drivers/igb/e1000_82575.h   |   1 +
>  .../selftests/vfio/lib/drivers/igb/e1000_defines.h |   1 +
>  .../selftests/vfio/lib/drivers/igb/e1000_regs.h    |   1 +
>  tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 564 +++++++++++++++++++++
>  .../vfio/lib/include/libvfio/vfio_pci_device.h     |  14 +
>  tools/testing/selftests/vfio/lib/libvfio.mk        |   1 +
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c |  22 +
>  tools/testing/selftests/vfio/lib/vfio_pci_driver.c |   2 +
>  8 files changed, 606 insertions(+)
> ---
> base-commit: de61419bb27f985cb878b19942a55b026c9c865a
> change-id: 20260707-igb_v3_b4-49194c14373c
> 
> Best regards,
> -- 
> Josh Hilke <jrhilke@google.com>
> 
