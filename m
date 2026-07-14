Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE8363086
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026377; cv=none; b=MNGayFgySK+KaCg9XssYNmtNiggMh43+i4bc4MiiCG12AFYD8GzIelker6biUu98zBf48LmeWMyXOL/3gtFCr1y2uOLz2AYPci0bfUKsnSesxgE3KLJt8FdV83Hc1jKiGvX0FnRV2QZTD5+5QySOSKx69v7NYvReSB+iSKnjjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026377; c=relaxed/simple;
	bh=u7bWfG8vhcznS53PVIVp55bhbq+A7H1ht4zWTX5JP90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k75BvhMcLR0Bm06YP4E3mxYj8UH/l9plJvcQ7WQ03/4zabaAhQzST+ZHSFAzH5Kj3CWgCHyPSauMXFafPWIfEI+RSACU5CXXN3eaS0I1zrGNYc8uprh8CWFk9CM57CE126pqyDE/7cRgUZ12lin4XM5PuNEZDs3zqQ9YnR3IRMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcWa2vmo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtjhGbrA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcWa2vmo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtjhGbrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784026375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a2PTzILu9qclnqywy4EwJ0RRR+3PTplTn770qnj4URY=;
	b=LcWa2vmoxBXx7EZBX2LmnWXH1hU7E5lK5BTEZ9jyhYUGu2KosiJQNwY03hL4VVsziSDGfW
	WB/ktdsih1/NkPWrg04fw+ClgOTTjrpsqeRAyT5gu2nMyWTqOa33OWRoMMdW5w+tEex0qc
	Gte2qZGJ1EByXPa5tYIoFpm/0LakuIY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-D6Los4ARO7SbGLvW8LwCIw-1; Tue, 14 Jul 2026 06:52:53 -0400
X-MC-Unique: D6Los4ARO7SbGLvW8LwCIw-1
X-Mimecast-MFC-AGG-ID: D6Los4ARO7SbGLvW8LwCIw_1784026373
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38c7e26ecabso948043a91.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 03:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784026373; x=1784631173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2PTzILu9qclnqywy4EwJ0RRR+3PTplTn770qnj4URY=;
        b=QtjhGbrA09stS3Z+1XPJNckLf44J6zIyUUKNIF87y9V5XF77hDeww4ArJcfBTg4D/N
         FqnpEKdc/yRBlp33GMeGwM7oG6bgQPTD705U7CfTMyEa86TFVLmt8PGu3IeuuCwhBlmQ
         AoiYAjUGjpWjPxitT7rxFbSwVlACjM8BZI+tMoPhDPcC6yrY29myyygpZLCsOG2Cegss
         BGUnSbjvenuIlsoCVYbCq1/0JCHMvbAGQWRl5NrvI8w46GYAEeK/n91pg1ixCSdqMhb3
         1GHAD93gdKHBHnz1W6WHT9eJKpILi9NLO8t1JNgfjXwVGxteDSs9IOYMlxxO/+4GEQJC
         oAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784026373; x=1784631173;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a2PTzILu9qclnqywy4EwJ0RRR+3PTplTn770qnj4URY=;
        b=MYlF8sMi2Dim89+Ri1HElXSmPC7pEUaTAbF6WBk187pGu0xFkuaxMvcdmtUSGM0AB9
         ldsZGX07zTz9RU8zthyBBiiYEdTAd7k6Fw5sAqrO/5RSnKEqG9a2B+qCpsGMiZH41XqD
         ETews7hW8DD34mox6hfytRckJUzRqpadAbY2COIZifknpQWihlkpBKqMFiVcR1W2iQiw
         Cr9KKb5MHf6J5pipRdriaAz6FMFZFArXojgfUOmPH0moQLWjI8zdTqfeX0lOcBCxbSVY
         Pcqp2Pk2K9IZjcCDTjImyC5sjhvlxZHX0lQWOMQQV6NDos9dpsTXfnBogt0tytFJluKv
         Ra3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp8OBFiPQsBnhlHZ1uQ/iyDh6D2Y5Pri7boZp4zySOz535EtrljQaIj83EcXnt0bXB1T4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YytNle7STLD+n2/+E+0hTYvFmMwbvQsA2C2/3fB2FhYkcy6PJj3
	XWONo3ETFEPUPk1u+S3SrliO+Xvyu8z/7KnDOcp6tneCrvG3B36QZhD/H9mFXT12nnB4cndTaao
	VN8oY6pmB8iX3p17wZPcqjTpRPcvcXfVo5XxFNjv90bP8qDH87bOfC6I/Hda1bw==
X-Gm-Gg: AfdE7cllEwEHXuZ+5MBdf039DS+dLyOkTBTmM2x570iEJmVuLaqWroyCm1CmojQAwHb
	ZMHZ+5ryr4zWTpc7BePavzwNBOohljL6cqsVNiSaEsZQY36Lzr4aRXdlGtxjmOIORb7cOnUfOTz
	nDmgscck71NJAaszmKVpEC5V1XJckM0VoRFI1ZuuhPzTv8GWmu6Wbi83FIJsW2QITNPk8L9o3du
	fNLOC/R7LeXcU310o1ulcS6A8/+gPM9kW29hJ/9oeh5JQo0AknfFYn+Q/HsD/SwLbuO1w78LA7P
	L08XHdnKftqgegmr9JiF+uyM2dgygjsMmCwYjrD/Hrekfyd7KNRKF1jDyreDcAR41pvhi7+C3FU
	ZCB0pzgJLB55WM0Lav3qhreE5OpIRs3kK/T/PEC/nWAZSIGhQsLw2Qg==
X-Received: by 2002:a17:90b:3e44:b0:38e:21da:9257 with SMTP id 98e67ed59e1d1-38e21da9302mr743569a91.37.1784026372676;
        Tue, 14 Jul 2026 03:52:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3e44:b0:38e:21da:9257 with SMTP id 98e67ed59e1d1-38e21da9302mr743524a91.37.1784026372146;
        Tue, 14 Jul 2026 03:52:52 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cf625sm1297479a91.7.2026.07.14.03.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 03:52:51 -0700 (PDT)
Message-ID: <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com>
Date: Tue, 14 Jul 2026 20:52:43 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-11-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a function to register a notifier that is invoked when ROMs get
> loaded into guest memory.
> 
> It will be used by Arm confidential guest support, in order to register
> all blobs loaded into memory with KVM, so that their content is moved
> into Realm state and measured into the initial VM state.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/core/loader.c         | 15 +++++++++++++++
>   include/hw/core/loader.h | 17 +++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86d2..b3d769bec5cb 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -74,6 +74,8 @@
>   #endif
>   

The (edk2) firmware for the realm guest can be specified by the legacy
'-drive if=pflash' or '-bios'. The memory region corresponding to the
firmware image specified by '-bios' is recorded by the newly added notifier
and populated to TF-RMM properly.

I don't see how the memory region corresponding to (edk2) firmware image
specified by '-drive if=pflash' is recorded and populated to TF-RMM
accordingly in this series. So I guess '-drive if=pflash' isn't supported
yet?

Note that I didn't give '-drive if=pflash' a try yet.

>   static int roms_loaded;
> +static NotifierList rom_loader_notifier =
> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>   
>   /* return the size or -1 if error */
>   int64_t get_image_size(const char *filename, Error **errp)
> @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>       return mr;
>   }
>   
> +void rom_add_load_notifier(Notifier *notifier)
> +{
> +    notifier_list_add(&rom_loader_notifier, notifier);
> +}
> +
>   /* This function is specific for elf program because we don't need to allocate
>    * all the rom. We just allocate the first part and the rest is just zeros. This
>    * is why romsize and datasize are different. Also, this function takes its own
> @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>   static void rom_reset(void *unused)
>   {
>       Rom *rom;
> +    RomLoaderNotifyData notify;
>   
>       QTAILQ_FOREACH(rom, &roms, next) {
>           if (rom->fw_file) {
> @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
>           address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
>   
>           trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
> +
> +        notify = (RomLoaderNotifyData) {
> +            .addr = rom->addr,
> +            .len = rom->datasize,
> +            .as = rom->as,
> +        };
> +        notifier_list_notify(&rom_loader_notifier, &notify);
>       }
>   }
>   
> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> index d9431e8a8d12..94cf6ad2e26b 100644
> --- a/include/hw/core/loader.h
> +++ b/include/hw/core/loader.h
> @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
>   ssize_t rom_add_vga(const char *file);
>   ssize_t rom_add_option(const char *file, int32_t bootindex);
>   
> +typedef struct RomLoaderNotifyData {
> +    /* Address of the blob in guest memory */
> +    hwaddr addr;
> +    /* Length of the blob */
> +    size_t len;
> +    /* Address space of the blob */
> +    AddressSpace *as;
> +} RomLoaderNotifyData;
> +
> +/**
> + * rom_add_load_notifier - Add a notifier for loaded images
> + *
> + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
> + * each blob loaded into guest memory, after the blob is loaded.
> + */
> +void rom_add_load_notifier(Notifier *notifier);
> +
>   /* This is the usual maximum in uboot, so if a uImage overflows this, it would
>    * overflow on real hardware too. */
>   #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)

Thanks,
Gavin

