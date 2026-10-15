Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22058E2BD
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 20:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792096313; cv=none; b=MZ46RrVK5RPXd/vKxdfiTolUm7RouyGc6k3sqKwzSNF/ReSkMplrIlnjyphuQ0tGw9+j105rg6cJxDHL2QpULegvSFRay+9kmPqjZ6h+EDi7FxjuF5svrsX9tOHICQS80CHv5bYSFX/ZHd6y9OsHwhMb+rppZjRfKJjyB7eurjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792096313; c=relaxed/simple;
	bh=bAnwWxa+AQY7w8FEC+1xd9F3EwGqq8JtbbcyWegp4Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIlhjuW2Snnot08MNuz+aN+xoWQOAxlaEJKHHmDMYheCyokqoOoTEWYAtP0AWZFZp+m3mJSOK9t40W17swd9LOK1UAaBzrqYCAo6VRthFvUTYahLKhWhA7+hvhZ3xLT3RF++wV13pzzSzqvS4MrwgIuYGOMRAe2EEEhKAKN8SHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q3JavMDJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3JavMDJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8875d220446so3066474b3a.3
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792096307; x=1792701107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NAEDuPRm7VuyIEB7+bHe35wWBeKMJ9cvJsYHTvEIilg=;
        b=q3JavMDJThIupJ1ibOkVmpt7+LVYy7W9UWMGr0l7iKsgfEgzIcIaCoFSH9vtFt0iBY
         I1mR4EeTmn7s0g9vglF0b5M5lFxfQ7ZFK3HqK1MiI1n/GZOH2gwslRUCjiWJpco06zI2
         WnRXK0Gjv4f423dCxqiNrR8ngrjPPI72CKhzUolu9C+yA08M1pQuy3qYHrJrbBMrQVK5
         kCwaJKqHZCLy7U6wRykbLvpAsCxkGfJrVaiYaujO3T8alAgB0nfdgHQa5xoyVaLuagOR
         NY3c3Zwrj0GvQmRYIpOJfaSzabQ/LDKnANg+vY4nsiBtZiBM5Eeea/G7N+mcgsfukkBc
         s5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792096307; x=1792701107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NAEDuPRm7VuyIEB7+bHe35wWBeKMJ9cvJsYHTvEIilg=;
        b=VHL3lMAAxgGA63aR8Q2ypmqR9SVDQtsLKUtu38sf2nfG8LqwsQcGUNfJxk6xG65eWT
         illJ6q7KQykC0gvXdBskWWw0giYs0OFjFexY9RdsqRJNe60fzh3XxClcZJS3VeZLd0jS
         tn3U51DcpEMX9ma1DfPgDvaDDKHdFJJFb4by/tVZLidSfzysAXD4oH1MY4eps4HJXrI/
         iG+UuzOsNghvnUPABh81+jzWIQ1DTfAH3cRkJroqScY/HtyXl9aO5N8H/TATQiObMmRC
         rB/hqRg6MdHuqDw6BDae4wdBzukKLUsPTleamhVuy2Bi/VWH2cGntdIQzgMKjYYBZRX7
         ATtQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3JCjJALg/9dI5PfI1/fr/BHM/kF4ngKj2uRfwxV126U3G1zU2QVznQ0ksqySD/pLvJSo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIA0q1sLPNRyQhZkV/T5uRoJ8qwkLmCuRktJv1orYSzdk/rSldi
	0xfbtUzm5ibwoQCNZmRPr+/bv1iaAtODz6kEgd/n5uPx7Wx1pTZugYnMPsoVRHhw8xU=
X-Gm-Gg: AYBFou0Z8DWzZVKwcqQNeXVyPuKKcFdLcvRYHWfBvze2g22KYTCIu8VR18psXsnkiuy
	KyynckX90Im0Or/yEow+Z0uwKTJ8vZSHAbqIx1IdZYAMmgP2aPNHEjR67NAHKJmucaZfVC4sOxS
	IoqMASjDWxNCnbkXYuK7YGn5p2mh5Mye9MRoEHcn8iWlq7FyWsub+9af0CgteELnIxJIsJekezH
	aIEsZuImLjTXK0bxAkIy+aO+4YyFtWY3aggTqVv5uk3AneNkako5j3PuqFgmM/La3g9oSm9oBvY
	q2ZtT3UNBGe01fPgGDDhUDL3DLvt4fWd2abpFrmZyIFhOYB3vvFQoCA6H4zGW9Y5jw0ZWdQQrqb
	mCtunSMRhTh/g9YjQXXCN0K36blb+s9t28YGkAg/FUh/YrX1RB7fbYeZrMPE/RJPFR5B8o0cXxK
	X1oWdXAv7qLGVtxMNWdHdPlL/LxAXGZIIiK7IsJyMKXGfNmMJWSPDMUesaB1P6+4ayGWksQ/Hej
	g==
X-Received: by 2002:a05:6a21:4598:b0:3dd:a197:cf2a with SMTP id adf61e73a8af0-3e16bf4c2b2mr16280104637.78.1792096307215;
        Thu, 15 Oct 2026 13:31:47 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:48ff:8de9:17ca:1542])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f56c8bc14sm123063b3a.17.2026.10.15.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:31:46 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:31:42 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
	mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
	eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
	enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [RFC v4 09/24] hw/core/loader: Add a ROM loader notifier
Message-ID: <atE4LncFX15FdVvO@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-10-mathieu.poirier@linaro.org>
 <ad73d89f-6615-49c1-a35e-3f01e7305744@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad73d89f-6615-49c1-a35e-3f01e7305744@redhat.com>

On Fri, Oct 02, 2026 at 11:15:08AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
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
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   hw/core/loader.c         | 15 +++++++++++++++
> >   include/hw/core/loader.h | 17 +++++++++++++++++
> >   2 files changed, 32 insertions(+)
> > 
> > diff --git a/hw/core/loader.c b/hw/core/loader.c
> > index 5cbfba0a86d2..388f10e828db 100644
> > --- a/hw/core/loader.c
> > +++ b/hw/core/loader.c
> > @@ -74,6 +74,8 @@
> >   #endif
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
> > +            .data = rom->data,
> > +        };
> > +        notifier_list_notify(&rom_loader_notifier, &notify);
> >       }
> >   }
> > diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> > index d9431e8a8d12..fdfddfa7443e 100644
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
> > +    /* Blog data */
>           ^^^^
> I guess it would be 'Blob'.
> 
> > +    uint8_t *data;
> > +} RomLoaderNotifyData;
> > +
> 
> There are enough space at the tail of field declaration lines, where the
> comments can be put:
> 
> typedef struct RomLoaderNotifyData {
>     hwaddr  addr;   /* Address of the blob in guest memory */
>     size_t  len;    /* Length of the blob */
>     uint8_t *data;  /* Blob data */
> } RomLoaderNotifyData;
>

Fixed
 
> 
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
