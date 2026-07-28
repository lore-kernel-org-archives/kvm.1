Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BB63CB91F;
	Tue, 28 Jul 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262475; cv=none; b=N9xHkZF1wbetsMUKIueeLLXm7W4BkVw2YiSQ4qsdVuZUrH5yh5/sqEu3lsS2cX8yzpgkEWOHNwLsZYHWWlcwr52tHgAyHkJlkWxHFAadV3sc6dtLeUJwNgrX3Eb4xUJkBEGZIXFGg/oT34qQ03gk1z50IWFz7cOVj9fB7Y2BQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262475; c=relaxed/simple;
	bh=916/opyxeZxX+gmP0L07uptEJvwJJ4d8hlg8s7TZACg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KSJmlkvX+qsbs1nNiF9qL0Oi4f4oZ9hTVsFKTFI4+ugsSXXlkkGoO/SlIsGkTYSnmXZS1m3gCpHGoebpO8CiPi2iorlf6yzzLzvPso5eSy8diLNCQO941uIj+UFj6e2FRcv5SgFaIwvvuFViGiGzR6LqrGTkWcC3i4Ae1QENv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Oly6cZa+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XAea3dkl; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Oly6cZa+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XAea3dkl"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC93D7A0497;
	Tue, 28 Jul 2026 14:14:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 28 Jul 2026 14:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1785262470;
	 x=1785348870; bh=8zLJH7Ed6KMbWMM4V5mFAU+jdUe/wlsP4+tgJhylCug=; b=
	Oly6cZa+eZZs/53nf1eZMtyl9HE0Kj3gUNY62HpDMP4oGef+14qd/I67wYh8pEjr
	eQTdoIrLAe0n4GX07gGy5rYh56nFAMos9yLkU3k3xscOypOkMhhuPYyVkuY6P4oU
	bb4f5vY8yuxTa+PYS41TuS38LzpNTTsl0GEEF18Gul90SCQx0xn/M+UZMRb3iKss
	3xKJ/5SJtH1XyCdREBn4vN47sQXIo5ym5LreTxb80+MY/zbC6TBmxpM9SuWBjXVI
	1Dzr/jcBetYbFTqvGIJT48urCDpKrso7En28WGbTm0zJ3x0XvrChCQqxvx4GDbP4
	ayxv1+hTRfHVTM72ipNPUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785262470; x=
	1785348870; bh=8zLJH7Ed6KMbWMM4V5mFAU+jdUe/wlsP4+tgJhylCug=; b=X
	Aea3dklGkwBiTwSqYjHk4IUTxuhKehVKXcL5VhvRTOiIRQGqNntMNo+J4UdDloiS
	7WlH1hz66kCteXXkIT5Dp1Q74T8SCu19CoxisD5ARKehRSDdWDQdc6HXKWKu+/6U
	GJmeayRGycd388M9YyRkMciNGQozFPxmTyS8l6Lujr0P3HQZc/IhD27QvXVm7bfm
	C2ydWJ7eYjz/dQVBEwX3IxHdWbEg00jWOUErJCuSaSSidKGEPdv7en5bT2E4UWvC
	1kxgvNcBPP/N36oD+0Xr8xBh6r/kklcMtbiPERfoyKKlYfzaLJsAnR19v1shSV+9
	ys/hbXAGwZZUUcoKYOYng==
X-ME-Sender: <xms:hvFoanWLB0GEoZjmIx433ZDv_Et0mUNaZqQF0U0oV-086xME_4_IuQ>
    <xme:hvFoagA1_44h7VmaN9wFeSa7cWDJc5TvvUXjyLDJiTMFaVKpZ6MZpXlCyokEfNGzC
    6jI2cZAJ1rZVDLhCm7isyfaXoswc0SfLUE4HVc2j3P1HtY42zAI-g>
X-ME-Received: <xmr:hvFoakGNTtGQArcNkeWVGnwBynRyCVVO6l7UIe0reePwviiQemvnIUeRd8lihA>
X-ME-Proxy-Cause: dmFkZTGHZL1L5PAQmxx4ro8Uj6N8dH6Q1YVXZeIFVf9X46/zcFQGTWcTBoP1qzW4EQiSDw
    flEFmfHtHJ4nONGuqOM+s5rfVN9CWLhD8M7Dj9WSgbNbLsDM92BPXP4ccrl49/xQDLWxK9
    sXypKFnqZF+SgInGE3sj2cOHkTmNMcp9NgrzZjJEmJ7vfsDoyrSvLXQyDU56zxRV4KxpY1
    nKTp+tjn5o2dXY3iD7jDkKedkzXDx9eeAanhKsEEO5l6AaOQkIjxqB2WJ5VNUEvucekZF6
    BB/gyr2t8F9fVu+VYpNfcrjlgFBbxvJM4ArR0vufnxuERcVHDai5HeQiuZfhjf1cmIM8UB
    EKlWu7yKGqEoJ5wuYkt6SojGOfRjCOrUVVHTtk6BsdTpN5+TsWzjEUmb1+sWIUlTXKcpxK
    DL2qSVb2dfXV4iItTXWNdPg7cMo6gxRO0kHwK9wKoRmb0rss32YyF2ZvEd8Je2NFP9WGzZ
    7eFXve3hYuOqEyZk/gChDNhp4UfFiyE7orbQTyaR31Ow16rWKFdi3s+Si5YC1+j5QU+x9h
    +dlmfrz10SpFRunytvpBCQrQkg3YdzTdh4VKuWa2DipbRLB5WTbQRCBBgefeT7FzFjUkxU
    28qXjPDnu2JV+Z5B224Ik7EBmEkE0fKIescrWLmbFBxe2F7Z0OjMzmOeIvyg
X-ME-Proxy: <xmx:hvFoap5xEr9XSuCMeKOEAWEuZ3icUfXXBW0ZhK-9mHWgP3h9Z-iJ8w>
    <xmx:hvFoaimNPCKG28FNk2Ryub3f-DoWHBSuYUL_2_xnGjP_0x9X57zoOg>
    <xmx:hvFoas7x29qoMKs-IfO5EK8Zt_l6vjeJXaxcC57cnWpv05KX1ObtZg>
    <xmx:hvFoarTg6rTJHh53PdZloFgnmAAYpIXR0BB73vtnqgL4iaqEN6yHRA>
    <xmx:hvFoahd9Fn9MBpzRTsnWjwloHtqMApoKIHzqxpEn1eg6-EUXuWj-qMDg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 14:14:29 -0400 (EDT)
Date: Tue, 28 Jul 2026 12:14:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: Josh Hilke <jrhilke@google.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, Alex
 Williamson <alex.williamson@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v6 1/6] vfio: selftests: igb: Add driver for Intel 82576
 device
Message-ID: <20260728121427.7d70e598@shazbot.org>
In-Reply-To: <20260722-igb_v3_b4-v6-1-0be1d29918d4@google.com>
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
	<20260722-igb_v3_b4-v6-1-0be1d29918d4@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 00:15:36 +0000
Josh Hilke <jrhilke@google.com> wrote:
> +
> +static void igb_reset(struct igb *igb)
> +{
> +	igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
> +	/*
> +	 * Must wait at least 1 millisecond after setting the reset bit before
> +	 * checking if this device is ready to be used (82576 datasheet section
> +	 * 4.2.1.6.1).
> +	 */
> +	usleep(2000);
> +	VFIO_ASSERT_EQ(igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST, 0);
> +	igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
> +}

It looks like we have a regression introduced starting in v5.  This was
previously a delay loop:

	usleep(1000);
	while (igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST)
		usleep(10);

Sashiko complained[1] about it being unbounded and it was changed to
this fixed delay and assert, that probably works with QEMU, but not on
my physical NIC.

The real driver seems to wait 10-20ms and actually tests
E1000_EECD_AUTO_RD, which seems a bit more robust, so I'd suggest the
following:

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 25cac663de1d..064842b2cd59 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -191,14 +191,28 @@ static int igb_probe(struct vfio_pci_device *device)
 
 static void igb_reset(struct igb *igb)
 {
+       int retries = 20;
+
        igb_write32(igb, E1000_CTRL, igb_read32(igb, E1000_CTRL) | E1000_CTRL_RST);
        /*
         * Must wait at least 1 millisecond after setting the reset bit before
         * checking if this device is ready to be used (82576 datasheet section
-        * 4.2.1.6.1).
+        * 4.2.1.6.1).  The delay also ensures the reset has taken effect and
+        * cleared EECD.AUTO_RD before it is polled below.
+        */
+       usleep(1000);
+
+       /*
+        * Poll NVM Auto Read Done rather than CTRL.RST, matching
+        * igb_get_auto_rd_done() in the igb driver: AUTO_RD implies both that
+        * the reset completed and that the device finished re-reading its
+        * configuration from NVM, which is what actually makes it usable.
         */
-       usleep(2000);
-       VFIO_ASSERT_EQ(igb_read32(igb, E1000_CTRL) & E1000_CTRL_RST, 0);
+       while (retries-- > 0 && !(igb_read32(igb, E1000_EECD) & E1000_EECD_AUTO_RD))
+               usleep(1000);
+
+       VFIO_ASSERT_GE(retries, 0, "Device reset did not complete");
+
        igb_write32(igb, E1000_IMC, 0xFFFFFFFF);
 }
 

I get a full pass on a physical NIC with that change.  Does it still
work on QEMU?

Also...

> diff --git a/tools/testing/selftests/vfio/lib/libvfio.mk b/tools/testing/selftests/vfio/lib/libvfio.mk
> index 9f47bceed16f..1f13cca04348 100644
> --- a/tools/testing/selftests/vfio/lib/libvfio.mk
> +++ b/tools/testing/selftests/vfio/lib/libvfio.mk
> @@ -12,6 +12,7 @@ LIBVFIO_C += vfio_pci_driver.c
>  ifeq ($(ARCH:x86_64=x86),x86)
>  LIBVFIO_C += drivers/ioat/ioat.c
>  LIBVFIO_C += drivers/dsa/dsa.c
> +LIBVFIO_C += drivers/igb/igb.c
>  endif
>  
>  LIBVFIO_OUTPUT := $(OUTPUT)/libvfio
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> index 6827f4a6febe..a5d0547132c4 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_driver.c
> @@ -5,12 +5,14 @@
>  #ifdef __x86_64__
>  extern struct vfio_pci_driver_ops dsa_ops;
>  extern struct vfio_pci_driver_ops ioat_ops;
> +extern struct vfio_pci_driver_ops igb_ops;
>  #endif
>  
>  static struct vfio_pci_driver_ops *driver_ops[] = {
>  #ifdef __x86_64__
>  	&dsa_ops,
>  	&ioat_ops,
> +	&igb_ops,
>  #endif
>  };

Why are we restricting this driver to x86_64?  As a plugin device, and
especially with QEMU emulation support, this should have no
architecture restriction.  Follow the lead of nv_falcon, which is
currently in the next branch.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260710221939.CFE741F000E9@smtp.kernel.org/
