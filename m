Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC72EEE82
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236227; cv=none; b=nlDcAjZECrNInwBnvaon6STeQEUxiwZ1h07npclIrlu94KdS53TS16fPQhevvFLUuY4GYqnuc1m4+uzNhELhwTMcShOeZI8kqEv6QP4Zjko4PVbo729n9KnlgyORk1lYRe8Pad7UwexokBYzz9MaQUGBDroFzKHCtPfG8mk/yUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236227; c=relaxed/simple;
	bh=S5ftprqlpVhrWV2XTMbiDsDrTeUfHuo1zlG/7FU5gOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQg3d5046Bfz2AhpoZH6YEe61IatdKEU6LH34d+WGXJb3WGBHnoTq2cyDpDw6UlgpDLr1BvAZZ6RwnL/UrpTV4XBZYfKdzNzox0TA3gp1mZ9TLP1Y8yGM3MaXwYqR6XwOgDUE2jfTs7N5TH/lieTeKOIhgUfzcU4OxDgqI2VuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQdlmhw/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQdlmhw/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cacf197759so63588375ad.2
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 14:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784236226; x=1784841026; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5Ur2nukUfIP6QGhx5yPbuB/k/ylzfmbXYhSPR5nt4l8=;
        b=eQdlmhw/FqT1s/NyoXMTs0kjTTLkqpkPL2IlIgHg6jjzd3kcZuA0hqr98f7KFeUYRX
         QC/Plmft/JOVCdVOYQ/2VpNK/meWp/061qM1C078J3ILWB5pnuicOEDFWXHMQNM8oA0/
         yySnF4uyB17LY1dJS7cw/Igf8rPAht7DtDDrBSro2Qf+cm/61WDXGiYLpJFOXuR4F82d
         Ho5jA09cwFsHtYvteePtRGGcl8HM25Cu3PPJUGYHdy03Hq6pamcf2qn8lnZCLyYJRe2Q
         cUG08QvA3ZYDdeWV7a8qN61UnAp5brrCXx72XJZRI5MvO7bwHWq5h5eUIIee73b2Ww9o
         faCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784236226; x=1784841026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Ur2nukUfIP6QGhx5yPbuB/k/ylzfmbXYhSPR5nt4l8=;
        b=LyijFzDUWvpBvPq6OBmKF6bV4JSNrJ5v+j6LUShl2+aKxcs+lLlvZnMvjF+5U7UkvR
         pzq5LRL+AVcgqYzPiYlsDKpryF/SBC/+PY09hOGVTt1ihWh+peKNyeOH+6Hp5wsXTuxr
         mYt+NJDoWC4Em3x9NHfm7DZaL7RYhqIhUgOKL4BlbuS3cGZziBMVGOnRQej8vmERjnTY
         +WySG1qgmM2xwUu+S6EqicUKhisYNLlx8GYljVlQcn/W/duUG90VUPSaAvHgSvyZzMsi
         KFXK/1CSUjsX4Y1WbfIrHKWor+tKwPFhWegVmEaHwE31v+9eKTSGXdxbCcU0fktnolwZ
         wl0w==
X-Forwarded-Encrypted: i=1; AHgh+RrYvRCVKxR5xBEugJdTxOcxpHAtS18zGpv3EnaA2XMeXfwxDt98Ysnq9cutPMfi8i0k4fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqaZPUEtCG2fUNQ/TYmHau60X6EdyPpNOLFQ01oreMOw8xVkA
	9VvVY1TFmwiFuIo/r0ubsfQ58W1IbK9Ypd9vH57uFlPDQ98wXf1Dj2dwP9EMsf/dnIw=
X-Gm-Gg: AfdE7cnV35Cc7JnN1aG8ONJ0wJT1HCeOsYmg5VeC1oYBDc5FtxjZVxYDpzKYYfqd1sm
	1VaAmL+0vBEY8SnGMcv2kbKCeLEdkJDgLjSpnxDfkh0rw5Br8X6A1jI48NBvZ9/UyAJQ8J3ObZt
	nYVOxAsbCoEmxsbW7W1tOztIrtp9md+En864gQH20WmbKgSYtdgI4aFMegmjY2JCvC5o9vWCDL6
	HwSmDRCWrGgSOCTDIe0AX+Au+1Xsn2MF7ohxo0wTxT9iY6I8vyUHA3pFNJHtXm55LPoDSqUO4F1
	YInWS/UZ44ssCzVwDzxy+SUnalWloBOLyjvX6tBGnrYW5Hk79wZobZvMkE7ggz6tTTKtJ7rDuXJ
	SsRuGVWKt/2y7k3m/9ZZ1V28xzF436QstURars5YwaZZLPnkht0CvY8JU0zzwt+cVNog5CYqsn7
	XfeOolfw==
X-Received: by 2002:a17:902:e552:b0:2ca:2073:3119 with SMTP id d9443c01a7336-2cf2eb31d23mr11590055ad.32.1784236225769;
        Thu, 16 Jul 2026 14:10:25 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:bc13:5578:20b0:9bee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf101434aesm25814365ad.28.2026.07.16.14.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 14:10:25 -0700 (PDT)
Date: Thu, 16 Jul 2026 15:10:22 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
	lorenzo.pieralisi@linaro.org, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
Message-ID: <allIviFWgoKgDob1@p14s>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
 <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>

On Tue, Jul 14, 2026 at 08:52:43PM +1000, Gavin Shan wrote:
> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add a function to register a notifier that is invoked when ROMs get
> > loaded into guest memory.
> > 
> > It will be used by Arm confidential guest support, in order to register
> > all blobs loaded into memory with KVM, so that their content is moved
> > into Realm state and measured into the initial VM state.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/core/loader.c         | 15 +++++++++++++++
> >   include/hw/core/loader.h | 17 +++++++++++++++++
> >   2 files changed, 32 insertions(+)
> > 
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 5cbfba0a86d2..b3d769bec5cb 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -74,6 +74,8 @@
> >   #endif
> 
> The (edk2) firmware for the realm guest can be specified by the legacy
> '-drive if=pflash' or '-bios'. The memory region corresponding to the
> firmware image specified by '-bios' is recorded by the newly added notifier
> and populated to TF-RMM properly.
> 
> I don't see how the memory region corresponding to (edk2) firmware image
> specified by '-drive if=pflash' is recorded and populated to TF-RMM
> accordingly in this series. So I guess '-drive if=pflash' isn't supported
> yet?

Please give '-drive if=pflash' a try and let me know how you fare.  Edk2 is not
part of the bootstack I'm currently testing with but I know of configurations
where it does work.

I'll add it to my list of things to do if it doesn't work, though I may not
address it in this patchset.  We'll see how busy things get.

> 
> Note that I didn't give '-drive if=pflash' a try yet.
> 
> >   static int roms_loaded;
> > +static NotifierList rom_loader_notifier =
> > +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
> >   /* return the size or -1 if error */
> >   int64_t get_image_size(const char *filename, Error **errp)
> > @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
> >       return mr;
> >   }
> > +void rom_add_load_notifier(Notifier *notifier)
> > +{
> > +    notifier_list_add(&rom_loader_notifier, notifier);
> > +}
> > +
> >   /* This function is specific for elf program because we don't need to allocate
> >    * all the rom. We just allocate the first part and the rest is just zeros. This
> >    * is why romsize and datasize are different. Also, this function takes its own
> > @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
> >   static void rom_reset(void *unused)
> >   {
> >       Rom *rom;
> > +    RomLoaderNotifyData notify;
> >       QTAILQ_FOREACH(rom, &roms, next) {
> >           if (rom->fw_file) {
> > @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
> >           address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
> >           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> > +
> > +        notify = (RomLoaderNotifyData) {
> > +            .addr = rom->addr,
> > +            .len = rom->datasize,
> > +            .as = rom->as,
> > +        };
> > +        notifier_list_notify(&rom_loader_notifier, &notify);
> >       }
> >   }
> > diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> > index d9431e8a8d12..94cf6ad2e26b 100644
> > --- a/include/hw/core/loader.h
> > +++ b/include/hw/core/loader.h
> > @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
> >   ssize_t rom_add_vga(const char *file);
> >   ssize_t rom_add_option(const char *file, int32_t bootindex);
> > +typedef struct RomLoaderNotifyData {
> > +    /* Address of the blob in guest memory */
> > +    hwaddr addr;
> > +    /* Length of the blob */
> > +    size_t len;
> > +    /* Address space of the blob */
> > +    AddressSpace *as;
> > +} RomLoaderNotifyData;
> > +
> > +/**
> > + * rom_add_load_notifier - Add a notifier for loaded images
> > + *
> > + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
> > + * each blob loaded into guest memory, after the blob is loaded.
> > + */
> > +void rom_add_load_notifier(Notifier *notifier);
> > +
> >   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
> >    * overflow on real hardware too. */
> >   #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
> 
> Thanks,
> Gavin
> 
