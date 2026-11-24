Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557643;
	b=NPC5B4Od+QDB1RT52dj4NjQlhNPOiaoqwheL08LCEqaX1Eb/epSKaO54SfJ/mv1EnrHU
	 QWVpqy+6xrwjNtq5reUrDg/ccRHOHuQZDlVyEwWEifwzsqN7gs2P8kEYcwyoLoqbtQ5gw
	 Y5shshfGYaKvMsSW6i5r/e2jBoC24Th1RhrPLZh6GZgwpQZFVNRtDMg5Xt8jjEsbYcYeN
	 DwkL7KWDdl3041J13YD/KczI7qadZ3B4M9VvlhVvm9qnh1gInd6/WliXLuBvqazLaB3ub
	 lYRjP9md/NtYDgqIQJtwuBwCXruxkD6LzmlsWehOtK1flxFknr/Qs25mFysKNnf0SWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
	b=XWWeN4fm5J12AOs8WcFE8EXn8gWw26b9jYuvy/yGA9N+4JryxPUx+SIlIYcwsXhgYrbD
	 FzNhEykTc0oGovck/S5Y+mWsO0vNPWnp6LWngHdnfiDthyEdC42RIcfSO0E6aY4OlvfTP
	 USp8SG3kSzusSdTwS/2QYi6OZlrXWt70JHQvBYX291P6np0ckQUw9t2xgJorWwUIE9iXu
	 loesYUcC3iTpQmzMl8VnoUtbNVyGusj1XjZ1HxPqtaYl+FS58Vywy81FDjn0/e4EUdAmA
	 Y0syilmRJXPOcXO8oQNYo7qQNe4iyNAq2fCWt7EtSYsorz+kaaKJ/8NGIzocH5h+rmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jZnFtPjb;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CA606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 22:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 367CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jZnFtPjb
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ee254f6eefso237565ad.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795557642; x=1796162442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
        b=jZnFtPjb03VDAoy7LgZlrMly7UoHS6SmHa4pTOwxJ22Wn9lf2V/KFWZjrC56OoBeyA
         vM7mopWtpOTgWrDW2uhp2OLm2tY9AnxSywh3Y1/6xNEepHMzUQTNGt1E6oe79iGkp6kA
         6kxrVK8IWLGGnKpdI0M60ms4CmD2DkdiwiXmajVjsKbFtElFTVmMd5FGuhaeogK8vmOb
         yMMBwYE+WEwrtMakOg0tcnwv7AdXU8qpGR6n3Rcx2MecqDqgQ1i/wjJON1sPGZjxJWO0
         0/z5cXeMQ98bnRA42PAIXEZ6m3EcmPoCTVTfgR8vVMX2YEvZe450aguqz0eTSmgC9/s9
         VW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795557642; x=1796162442;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EA7eHt/O0bYrcpIzHzTDx2hG19gCRJEI4TFAz5QRzRs=;
        b=DX/FDIWEIilCVkd4pnP+PGdTNSXimxvFDdrimuyjlmPrrhOzYsXb0D8lkzOnqdmitW
         iqFvRj1pC6OqYwznpN3rN0Isr1UNz5ej6yLUeQSE9XS+yInBQp+8iNzVpQMS9EgMe3Ny
         UpZZZuVBw/710OUlUKAHguRXMgX7CTLLEwKQTfAi1DDsNpf5qiPlhpRE09WWiPYP/wfK
         HaqP2qHJxUqEaRdEoi5/G4JLVj26NitCxJcw+FzqoSt5C9rNbBOn/L4bZGfvPjMk9wbm
         QogG8AHy+UuvnNNfdFOOFxiJ4UOUW7c4H59oXJfZdfh9JmdCecf6PR5gzsp6ILPDYb20
         bUjQ==
X-Forwarded-Encrypted: i=1; AL+hErHW00R1e42cQeUFszFvCpKKmppGcsZFeuJt5LioID/SSSoMJ6AH09ZMGh5sx/qMzBhCO14=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jMakbb2hDlBwMNh9LEx0qTnGT68MJr5tXZ4LKW4z9KIqp7jUe
	mFtaY3xJk42hZ+w/WYTEZWvJj3IZ7GpHV2NVCzE/4F7hUOsl3stjP4zwHwaKndPpaA==
X-Gm-Gg: AZFdTZcS2u88B0kqDP+hBfRYUhRHhyGTw4eO4PoRZWUjVRabyChKWmHDfKBO5Iq8zsl
	EthH7dcGUi98S3Ip7i58VpEEoaxmqZn+NrJNnPbHXeOZKgoE6+FjucnQApJ/KvQxQ2tznQMOLWp
	pwaXBl12lbZw5P0lck+6sYBp/qo6Pz3WE7p9MG6MRm+GkL0dQZYezdiybfRsHSG3CZH6UcF3771
	ZQvvDz7IyOaFtrqWe0j41Dlf4s1mBIC9lhNGx8Tlbb9+87eIcDV5AHlzr+wXrjxzpBFacUIDHhz
	szU9SW+t+0XUVkiwNKgfRqPie7wCIE+7ep4apWDbm9NklAURAKvCApqgAedlHGpYQSCdhtJQL9K
	SLdZvItcPdAWasz3oMq7XtkYDW25FsC0RfOThLNCPE1viLUuxz03khO8Q4YG7qmEW8xIQF6lFc/
	Lj9FOMuwzVb8F2I4gsOFusr3OQIAh+tZyhykLthOkvT3PJC/snisXim8VEsg+hJh6WPcYq2Hjeu
	FJBL2urIdKGqbamfKIT+JiZjOX+obwCs2sRl1YS2FQo4m5i4wekPMLe6M/Sh7MSyc9Takios81G
	4YZteH10IZ7febDMivh1/t6UTOn0CQIphQufizQTVbIPyMnuVNUNQ1K0H4Ps2uOa6VVvIdiQrR7
	x1c99Ap8DzylsdP/OuZCDPYbifpurteRxWYeDOvdw1Bw=
X-Received: by 2002:a17:903:1444:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2f0665697d7mr10304545ad.9.1795557641889;
        Tue, 24 Nov 2026 14:00:41 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm24132763a91.4.2026.11.24.14.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:00:41 -0800 (PST)
Date: Tue, 24 Nov 2026 22:00:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Anthony Pighin <anthony.pighin@nokia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, kvm@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: Only lock the upstream bridge if the reset may
 need it
Message-ID: <awYIlvOacAWrT99b@google.com>
References: <20261112235700.2029562-1-skhawaja@google.com>
 <20261118163706.7138d246@shazbot.org>
 <20261119143237.4bf54796@shazbot.org>
 <awC5Ldqmue6DiO44@google.com>
 <20261124084852.661dd7c1@shazbot.org>
 <awXedVCoT7M79Rk5@google.com>
 <20261124145743.6c253bd2@shazbot.org>
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
In-Reply-To: <20261124145743.6c253bd2@shazbot.org>

On Tue, Nov 24, 2026 at 02:57:43PM -0700, Alex Williamson wrote:
>On Tue, 24 Nov 2026 21:04:57 +0000
>Samiullah Khawaja <skhawaja@google.com> wrote:
>
>> On Tue, Nov 24, 2026 at 08:48:52AM -0700, Alex Williamson wrote:
>> >On Fri, 20 Nov 2026 22:21:16 +0000
>> >Samiullah Khawaja <skhawaja@google.com> wrote:
>> >
>> >> On Thu, Nov 19, 2026 at 02:32:37PM -0800, Alex Williamson wrote:
>> >> >On Wed, 18 Nov 2026 16:37:06 -0800
>> >> >Alex Williamson <alex@shazbot.org> wrote:
>> >> >
>> >> >> On Thu, 12 Nov 2026 23:57:00 +0000
>> >> >> Samiullah Khawaja <skhawaja@google.com> wrote:
>> >> >>
>> >> >> > Commit 962ae6892d8b ("vfio/pci: Lock upstream bridge for
>> >> >> > vfio_pci_core_disable()") makes vfio_pci_core_disable() trylock the
>> >> >> > upstream bridge before resetting the device, and skips the reset if the
>> >> >> > trylock fails.
>> >> >> >
>> >> >> > All VFs of a PF have the same upstream bridge. Take a device with two
>> >> >> > VFs, both used by one process. When the process is killed, both VFs can
>> >> >> > be released at the same time. The first one takes the bridge lock and
>> >> >> > does its FLR, the second one fails the trylock and is never reset.
>> >> >> >
>> >> >> > The bridge lock is only needed for a bus reset, which is done through
>> >> >> > the bridge. A VF is reset with FLR, and pci_parent_bus_reset() never
>> >> >> > resets the bus for it because the PF and the other VFs are on the same
>> >> >> > bus.
>> >> >> >
>> >> >> > Add pci_reset_needs_bridge_lock(), which returns true if any reset
>> >> >> > method enabled for the device is a bus reset, and only lock the bridge
>> >> >> > in vfio_pci_core_disable() when it does.
>> >> >> >
>> >> >> > Fixes: 962ae6892d8b ("vfio/pci: Lock upstream bridge for vfio_pci_core_disable()")
>> >> >> > Cc: stable@vger.kernel.org
>> >> >> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> >> >> > ---
>> >> >> > Tested in QEMU with an igb PF behind a PCIe root port, bound to vfio-pci
>> >> >> > with two VFs. Both VFs are opened through VFIO and then closed from two
>> >> >> > threads at the same time, counting FLRs with a kprobe on pcie_flr().
>> >> >> > Without this patch one VF missed its FLR in 50 of 50 rounds, with it
>> >> >> > both VFs were reset in every round. I will send a VFIO selftest for this
>> >> >> > separately.
>> >> >> > ---
>> >> >> >  drivers/pci/pci.c                | 28 ++++++++++++++++++++++++++++
>> >> >> >  drivers/vfio/pci/vfio_pci_core.c |  3 ++-
>> >> >> >  include/linux/pci.h              |  1 +
>> >> >> >  3 files changed, 31 insertions(+), 1 deletion(-)
>> >> >> >
>> >>

[snip]

>> >I think the test I'm proposing precludes a bus reset, ie. there is no
>> >upstream bridge, the device flags prevent it, or we're provided with a
>> >VF.  It's only those cases where we can't do a bus reset anyway, that
>> >we can skip the bridge device lock.  I think that means it's useful in
>> >PCI-core as well as vfio-pci.  Did I miss something?
>>
>> Yes, the slot reset probe doesn't account for the VFs and will allow
>> reset of the slot when hotplug is enabled.
>>
>> I think that is probably a fix that needs to be done orthogonal to this.
>> I will send a v2 of this by doing the needs_bridge_lock() as you
>> mentioned above.
>
>Yes, there might be a latent bug in the slot reset path.  I know s390
>has some weird per-VF slot reset, but they set the per_func_slot flag.
>The test in pci_dev_reset_slot_function() probably needs to account for
>both VFs and multifunction devices as:
>
>	((dev->multifunction || dev->is_virtfn) &&
>	 !dev->slot->per_func_slot)

Yes, that is exactly the fix I am thinking about. Let me send this one
also separately.
>
>As you suggest though, that's a separate fix.  Thanks,
>
>Alex
