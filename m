Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060392FB97D
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577385; cv=none; b=io45onQHtN+Y5Xdff5fw7F7MzAekOSLPsWiMzZei7JWeZHtxrJ+zkyf8t3PQWMUs+B0XNaxQKL+u4CznAStFga3vz7tCaEHGukDm/eg8AD943suKC88My0CMqPnJ3yg8JeX3+aWGc3K+n2h1TNAbnceZz1u1L5qJMifQLfwl7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577385; c=relaxed/simple;
	bh=F74iyZp6QYl3/VXl1PBvDURlvvQTMR3GO3IRl/0a06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBfGQZzFngqE5kSWG04uLYWnSkmuccXp+cO93YLz3u+KPkaBSoWnnqKlBLpYynK+D/MVidojFdhLDFqtXvkc0KnNAjjPad8xRWYwKe3lX12m99UH0BDfjpoYeXNuDA8vnSRHWBEKAFzyEt2FH9ADhuY8zptA/hUHtOaBPomBdeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBUw8blV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBUw8blV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-385ea3ce80dso10636213a91.2
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784577383; x=1785182183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qypg8MG/GYHcwh7ZOfCoQhkX/up+rVzHDtc/xpQiT9M=;
        b=uBUw8blV2igZMlmORepLkU+kMzPSxIBhFoN3gInbTjoXjo2nCHgYwFEr3kuzG15gIB
         NVH8SR6OysIvCCTAFTemg47udxtMRJvss4TyBE2Dt8IGF9UnvcQyjN47tYzFHLVuuQt3
         1ZXGcEquekeG5nv6M23wsIfBJWLW5in+HKcVub2FtF4Q9cj6QBf7O5KBTmbWFuhW4sSo
         dUP5mbrUX6rvM2TALxAUkXjty2/QcPX2Qmyoo2Tser529pVlvtZCW4WtkFlrqjfeIylQ
         Lo8B9cnYQX7+Riqs4TVb+xJ1QQPUQdGxesSLXnXEiDVVUq6W6hBoyVpoUr4AMqJ54bqp
         ZRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577383; x=1785182183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qypg8MG/GYHcwh7ZOfCoQhkX/up+rVzHDtc/xpQiT9M=;
        b=oKY3c1AgWJuwGhjJlgCcp2/s5AyUbB8RRHf4dWPYT6AL21fkudpdRmFah67SXW9SnP
         s4nLuc5XJr3+4KKcQPL4eJvvxq2W4FgIXxHjS2onYG+RDdt1PDBoBOXf154NQyvAz/Sx
         9o4WogLrfgSy3yk++WyiW8XiuOvGs9vE+hnV/ykvx2CAIcU+6O1afMcePErJJn6A7QHj
         h/ynSsodB3n75v9ydf4lUTCLzKV1vOYDCuzwvky+uw/fbr2IrMcIlfceJsq4Bo4EtFn5
         rZFRSsdz+VpYw0CZi37BAmltSJX7UJ7aP770y0T8m6RlKlSEUW1kSAsRl81OTPm6WxGl
         i2rw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7OQgVYeDITjEzOompiYOB6ziJIOdX6Cp5lggNyOLb9ft/6FNTXZwuIAQEj/8l4RaAI/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7mXB2gcE4McXtIjxBk7gvlKnJZ/C/sswdM+vVZQjvnkebJvz
	cwHkGwQhUz8CKZr1T/Zndc/9BYTXMIgNf5SUFsnQfoxWLeFb4cNf8WxVkv63XCsaMaU=
X-Gm-Gg: AR+sD13Lz0aYF58i5Yf8IGPjV8WElWkdMA859sc6ABMtnc4RLOO81l2z9njTW9XWZCe
	VuPFDZa0LGaZi9k4JiRPbCEC9qU/ere9HuUW70cwD15/2k9rRQKyZ+wMo/VFyJ4jedJvN1V3fYm
	ga2kBb7BTjiYcAxCMti4mYRdyJVo+wlxJhRMwqqzuML58r3gZOCzXGz836V6dbO7LWsLj1dtWp1
	b0+o7UzSFZ+HGU3fhh2QLiNFSc932eWnCRIjAX58HJxSScO6iDcIJK8fXbHCjHabytIP/uJ+xa2
	xja5RSci6s2qWMooBdSgWP/hVV8KQF4qFNnt7WR9v0SgfE1Mqm5NDM6gl15jVj4ASyfZoocIyAf
	YNdHMQLrM191Uv+ShMRQTddzXZkw2vn1OKurQOfDfgbJXAf3J88tNyOu1uPW/ilX8swuL3bgRcK
	H2LLk/
X-Received: by 2002:a17:90b:1f88:b0:37f:9cdf:f0ac with SMTP id 98e67ed59e1d1-38e4b538984mr16982634a91.27.1784577383024;
        Mon, 20 Jul 2026 12:56:23 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:966a:e23:19e7:951a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9237a26asm224764a91.14.2026.07.20.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:56:22 -0700 (PDT)
Date: Mon, 20 Jul 2026 13:56:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
Message-ID: <al59Y0S_DLMbAESK@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
 <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>
 <allIviFWgoKgDob1@p14s>
 <2ad36e97-63d7-4464-b909-2a28d496e887@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ad36e97-63d7-4464-b909-2a28d496e887@redhat.com>

On Mon, Jul 20, 2026 at 04:47:53PM +1000, Gavin Shan wrote:
> On 7/17/26 7:10 AM, Mathieu Poirier wrote:
> > On Tue, Jul 14, 2026 at 08:52:43PM +1000, Gavin Shan wrote:
> > > On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > > > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > 
> > > > Add a function to register a notifier that is invoked when ROMs get
> > > > loaded into guest memory.
> > > > 
> > > > It will be used by Arm confidential guest support, in order to register
> > > > all blobs loaded into memory with KVM, so that their content is moved
> > > > into Realm state and measured into the initial VM state.
> > > > 
> > > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > ---
> > > >    hw/core/loader.c         | 15 +++++++++++++++
> > > >    include/hw/core/loader.h | 17 +++++++++++++++++
> > > >    2 files changed, 32 insertions(+)
> > > > 
> > > > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > > > index 5cbfba0a86d2..b3d769bec5cb 100644
> > > > --- a/hw/core/loader.c
> > > > +++ b/hw/core/loader.c
> > > > @@ -74,6 +74,8 @@
> > > >    #endif
> > > 
> > > The (edk2) firmware for the realm guest can be specified by the legacy
> > > '-drive if=pflash' or '-bios'. The memory region corresponding to the
> > > firmware image specified by '-bios' is recorded by the newly added notifier
> > > and populated to TF-RMM properly.
> > > 
> > > I don't see how the memory region corresponding to (edk2) firmware image
> > > specified by '-drive if=pflash' is recorded and populated to TF-RMM
> > > accordingly in this series. So I guess '-drive if=pflash' isn't supported
> > > yet?
> > 
> > Please give '-drive if=pflash' a try and let me know how you fare.  Edk2 is not
> > part of the bootstack I'm currently testing with but I know of configurations
> > where it does work.
> > 
> > I'll add it to my list of things to do if it doesn't work, though I may not
> > address it in this patchset.  We'll see how busy things get.
> > 
> 
> Ok, I don't think '-driver if=pflash' or the 'pflash0' property of the virt machine
> aren't supported any more due to [RFC v1 21/25], where the 'pflash0' property has
> been removed.
> 
>   [RFC v1 21/25] hw/arm/virt: Use RAM instead of flash for confidential guest firmware
> 
> - Tried to boot the realm guest with '-driver if=pflash' and I was told it's not supported.
> 
>   qemu-system-aarch64: -drive if=pflash,format=raw,unit=0,file=/mnt/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd,readonly=on: machine type   does not support if=pflash,bus=0,unit=0
> 
> - Tried to use 'pflash0' property, and I was told it's not supported either.
> 
>   qemu-system-aarch64: Property 'virt-11.1-machine.pflash0' not found
> 
> So the only option to specify the firmware image is '-bios', which worked for me.

Thanks for the follow-up.

> 
> Thanks,
> Gavin
> 
> 
> > > 
> > > Note that I didn't give '-drive if=pflash' a try yet.
> > > 
> > > >    static int roms_loaded;
> > > > +static NotifierList rom_loader_notifier =
> > > > +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
> > > >    /* return the size or -1 if error */
> > > >    int64_t get_image_size(const char *filename, Error **errp)
> > > > @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
> > > >        return mr;
> > > >    }
> > > > +void rom_add_load_notifier(Notifier *notifier)
> > > > +{
> > > > +    notifier_list_add(&rom_loader_notifier, notifier);
> > > > +}
> > > > +
> > > >    /* This function is specific for elf program because we don't need to allocate
> > > >     * all the rom. We just allocate the first part and the rest is just zeros. This
> > > >     * is why romsize and datasize are different. Also, this function takes its own
> > > > @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
> > > >    static void rom_reset(void *unused)
> > > >    {
> > > >        Rom *rom;
> > > > +    RomLoaderNotifyData notify;
> > > >        QTAILQ_FOREACH(rom, &roms, next) {
> > > >            if (rom->fw_file) {
> > > > @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
> > > >            address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
> > > >            trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> > > > +
> > > > +        notify = (RomLoaderNotifyData) {
> > > > +            .addr = rom->addr,
> > > > +            .len = rom->datasize,
> > > > +            .as = rom->as,
> > > > +        };
> > > > +        notifier_list_notify(&rom_loader_notifier, &notify);
> > > >        }
> > > >    }
> > > > diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> > > > index d9431e8a8d12..94cf6ad2e26b 100644
> > > > --- a/include/hw/core/loader.h
> > > > +++ b/include/hw/core/loader.h
> > > > @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
> > > >    ssize_t rom_add_vga(const char *file);
> > > >    ssize_t rom_add_option(const char *file, int32_t bootindex);
> > > > +typedef struct RomLoaderNotifyData {
> > > > +    /* Address of the blob in guest memory */
> > > > +    hwaddr addr;
> > > > +    /* Length of the blob */
> > > > +    size_t len;
> > > > +    /* Address space of the blob */
> > > > +    AddressSpace *as;
> > > > +} RomLoaderNotifyData;
> > > > +
> > > > +/**
> > > > + * rom_add_load_notifier - Add a notifier for loaded images
> > > > + *
> > > > + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
> > > > + * each blob loaded into guest memory, after the blob is loaded.
> > > > + */
> > > > +void rom_add_load_notifier(Notifier *notifier);
> > > > +
> > > >    /* This is the usual maximum in uboot, so if a uImage overflows this, it would
> > > >     * overflow on real hardware too. */
> > > >    #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
> > > 
> > > Thanks,
> > > Gavin
> > > 
> > 
> 
