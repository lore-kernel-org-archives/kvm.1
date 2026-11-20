Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213291;
	b=g0PEe3nldldvrYLYvoqxIKNTmJZTR7yRA85sWTGxw7OSu5QBWln2aL/kI1FAmxA3qP6o
	 ew50qT47GClbjqL4TGKInH/CgXNVuvBnPk6ZWyiv8P9D4UsfjqQ5ZvuS50khCX9ptXBaF
	 x6NG9S86fgqx0Gr9ZdTWBnMBTD+KGQ17rR0PGjSdd4ZQhrxg6NHPwSGy0CTtHNy2XruJg
	 5KErQ/DazCz4A859MRcIIowgSjRgZPxdR3vzq5kTwIyD34jFsPT/05IWNT2nO5PFEpC1y
	 5c63d0/7JMaTpmHpj43eqnRtxXaUK9is5hC9UIC2AOPkI9dw4kaQUT/mS5uHSaJeYDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213291;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
	b=oNkCTHTj/aDtMcukuvgXwRXErS6Z2AXjTTxAt9ba83OfK7a1zgj8gzq5GHSZf0+SRESr
	 AFWiTguQX5DMlzfLWQ57BKZytl2YFcyPONMZHsZSXu2pk/ywR8q/gZQiV9JOrL+p34xzD
	 sBOVbmWHFTM0oXCbhOq0gyJ4vwEMGlZ5H8KcuDbcKq9X6WptupRwFRwPDy4htBtrPt/VC
	 oCDGmklQAQdRwnEnaLKYi5K9XKX9HKuHL+7QtVCgocH8mVeMGfGKw0E1+vg0pJGoIcPTx
	 4Do2BrwcFEmSJiX/XfZTixdE2RElB/6VuZHhZCuXwzWPy1tA11VjgJEiADQYfNPHSpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bz3wayi8;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B5606A6BE
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 22:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447B5606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bz3wayi8
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ee254f6eefso23955ad.0
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795213280; x=1795818080; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
        b=bz3wayi8B/xIUJTpaTICcqniOfrt9ZQ2O5ws4WZNSkusMBsHs2I/thNsWx6oHBiyu1
         rxmeeuu9MSwUWkBQgoh/X7UFXStSc+bSoH6Bj5SYQ9VA1XX9L7avbCiWFFo+7HW+M2Sd
         Nryp8H/8z2/IIOMnPGHIMJQpEC4+0G82NJXUtArYx8JN2s3gf0YrWXWBquUMRa1BcSGC
         x/34nNIycszYPus7tr+3O1vG9CST34P3Nz8kNYoNPrnIEHedaQywda3XpwVYpBeTlA/G
         aMQ4jpGZ/6mVs+suP/p+F9cScqj4dHUnf7nDzzZQsYwM1HDwIquA+iAeoXkj6cxlVAXo
         iZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213280; x=1795818080;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWAHn2Sutfx4jyhpprq+KziM+rM4UEONRsPYaYW8qwc=;
        b=c9FzV+nqA3M+rAK+MIABAQDLuGASJ2ZZ69h9ItNGfu4o9sOpyBUigI3Byb7ABlDY7V
         xHt0nQcfUIutEoE7ggafwwyB+EYkJcPxhmdMJnVEeiKl4fGYsymrGAw3SmHgKVW7d+Ew
         gsPnla/hvP/R0CvhDKhgx0HMO73ChgCDLvGKIPUcjkXvWfgt81h2jOHsJA9c16erj6pj
         cIpdny+5g20J2DRHbF7qIqQZxAvuJePZvAVmTc2ZBijtN/T3+Xvb2d+LsNfHCTo+n3Ij
         2jcdHE7qMhEGDqNl8VOc4ZUhSsvERzo7b1aEMrtU/aek4BomkoI7h6OlmdsXwmF0BEp4
         Ctwg==
X-Forwarded-Encrypted: i=1; AL+hErFyLTXyi38/Nh9825jyNrq/IpsY+8806owqeULEy/as2w9b7PSNlBZZsvmS3og9fT7OcXE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9IN92epKIY1+XBtsQswrMRs74PsgNs2nMCsZOCelU30Ya861Wf
	7n46rVn61njcuudsS4N97N1kB2P7GBBw/9gmnFyEyuk92tF6jKlsds7DfMousQjO3A==
X-Gm-Gg: AZFdTZfHv73E4qzvzbe2lseQBhIDgEIyYh+s3PCKTtJg16HPa/Le1Z/9tAw9SDxRsyF
	MisDyh8CPGIWPvr/7GmLz5In4fId9m09BgTmbrIJRu8OZTeABjoZM3pDMd5nibbKa3W7+myxfvw
	cVh7Y3nY3FbZcokr44JuGSeEHnzkSWXp21oPvbCetxLrKLFAGmqFMTnt4+5vHPqcGi2J88bX/uo
	e5Ta6B+ghJiz7KDfcjsEt6IO29GDdElfdrraAtdUhwDksBA4fmkNKMPGNyaFyMT9E5gSLGRMMHn
	RchxcSWOqAYfq6LP+Sb9ec6HCgcoVU/H87kADlmeH0ViPV60lq/lnRDnblNLGzldrm5jBRo1EFn
	peMh37TlT6S0OJ/+vRONiBqls0CEcxXCz6j7QAIJGUxxmvITMmzkF2is25q586DQKDXoj78fd+5
	3q1AsTHQUF6R6L8uhCcoip4Zd2D61SP7yiJHaBLel/trXpG2+Z4HrT3nn6Ahva86tvFCZMKh7k3
	/TvD9en3x/ARObbNdAJe3/1woL92q0MJ9YRQhZvLLsvc3ZfRe2dsht2uz+UlZB87Qsk/AIS9xJu
	EL6evvVVflpzDIawjSA0P52zWoeyq5hcEQrTrzTmp77ktBG+Exn8YrRS/0kTdHPnpBpoHcosTZ3
	EZMKFySOVHFLP5gt2XFBC3g==
X-Received: by 2002:a17:902:f709:b0:2e6:1735:f645 with SMTP id d9443c01a7336-2f062b91bfdmr1318055ad.4.1795213280161;
        Fri, 20 Nov 2026 14:21:20 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm5793510a91.6.2026.11.20.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:21:18 -0800 (PST)
Date: Fri, 20 Nov 2026 22:21:16 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awC5Ldqmue6DiO44@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261119143237.4bf54796@shazbot.org>

On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>On Wed, 18 Nov 2026 16:37:06 -0800
>Alex Williamson <alex@shazbot.org> wrote:
>
>> On Thu, 12 Nov 2026 23:57:00 +0000
>> Samiullah Khawaja <skhawaja@google.com> wrote:
>>
>> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> > upstream bridge before resetting the device, and skips the reset if the
>> > trylock fails.
>> >
>> > All VFs of a PF have the same upstream bridge. Take a device with two
>> > VFs, both used by one process. When the process is killed, both VFs can
>> > be released at the same time. The first one takes the bridge lock and
>> > does its FLR, the second one fails the trylock and is never reset.
>> >
>> > The bridge lock is only needed for a bus reset, which is done through
>> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> > resets the bus for it because the PF and the other VFs are on the same
>> > bus.
>> >
>> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> > method enabled for the device is a bus reset, and only lock the bridge
>> > in vfio_pci_core_disable() when it does.
>> >
>> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> > ---
>> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> > both VFs were reset in every round. I will send a VFIO selftest for this
>> > separately.
>> > ---
>> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >  include/linux/pci.h              |  1 +
>> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >

[snip]

>> > +
>> > +		if (pci_reset_fn_methods[m].reset_fn == pci_reset_bus_function ||
>> > +		    pci_reset_fn_methods[m].reset_fn == cxl_reset_bus_function)
>>
>> This looks like a maintenance nightmare.  What if instead we did
>> something like:
>>
>> bool pci_parent_bus_reset_possible(struct pci_dev *dev)
>> {
>> 	struct pci_dev *pdev;
>>
>> 	if (pci_is_root_bus(dev->bus) || dev->subordinate ||
>> 	    !dev->bus->self || dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>> 		return false;
>>
>> 	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
>> 		if (pdev != dev)
>> 			return false;
>>
>> 	return true;
>> }
>> EXPORT_SYMBOL_GPL(pci_parent_bus_reset_possible);
>>
>> static int pci_parent_bus_reset(struct pci_dev *dev, bool probe)
>> {
>> 	if (!pci_parent_bus_reset_possible(dev))
>> 		return -ENOTTY;
>>
>> 	if (probe)
>> 		return 0;
>>
>> 	return pci_bridge_secondary_bus_reset(dev->bus->self);
>> }
>>
>> Where we'd then condition acquiring the bridge lock on whether it's
>> even possible for a function scoped reset to perform a bus reset.
>>
>> It's a bit broader of a test than whether we actually have the necessary
>> methods in our reset_fn list, but since we're not locking the reset_fn
>> list between test and function-reset, it's also safer.  Thanks,
>
>After exploring Ionut's patch[1], what I propose above is probably
>wrong.  We don't have any guarantees that the sibling topology is
>static and this bus-reset-possible function presents it as immutable.
>The existing bus-reset function has the same race, but the gap is
>smaller, let's not make it bigger.
>
>There are however immutable properties we can test that cover a fair
>number of cases.  For example:
>
>bool pci_reset_function_needs_bridge_lock(struct pci_dev *dev)
>{
>	return pci_upstream_bridge(dev) &&
>		!(dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET) && !dev->is_virtfn;
>}
>EXPORT_SYMBOL_GPL(pci_reset_function_needs_bridge_lock);
>
>We should be able to use this as a condition on whether we acquire the
>bridge device lock, in pci_reset_function() and in vfio-pci code.
>Thanks,

This sounds good and it will also fix the bug that I am seeing.

The only caveat is that pci_dev_wait() might fail during VF reset and
then it might try to do a bus reset if the VF is behind a pciehp or CXL
port. I would prefer to do it only for vfio-pci code as that is where
the reset skip issue is. pci_reset_function() takes the lock and
serializes the VF reset. Are you ok with doing it just for vfio-pci?

Thanks,
Sami
