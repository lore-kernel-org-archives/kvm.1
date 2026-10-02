Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E2328B7F
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903720; cv=none; b=bZBrDiPCAZxCRGMxBzMIp30dXYpgqjMlgDN1rLq9DdSB4dNOkmDYvYsWFuAQyncxkk5T78o8crJmcCL5QjmQ9G54rsHsKQhi1JMjp3VVmLlGruvEirtNJHUksQvXPuWt1CgmMg/mjgu+WjLAvMMzRv2vcdizyFsiyK12oDGa3Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903720; c=relaxed/simple;
	bh=3d1lPp6DfvifIHl8iEUjOphEjL0OoInAdTKTi6c95+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4/8Lxow0gYTzI6MwgVIe7NUjrK3t45h1MhAyx+bSZlDxlWGxNmkaLzknkUB7BZ2ibTKUPra0muDrLD6h3c8Fph5kkJuYbgxexCVYkq3WKC4jSuy4HrG+4NuhRjOM/if3UMTMPtcAxraRvfxWOr9yghjJEakrjOwsdFsClSPyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACH22cZ9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrEXvUvx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACH22cZ9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrEXvUvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790903717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47kV0KPyHe1GkaaHQZyr7eIJ1DCCCT2lh5D1q3j8m6g=;
	b=ACH22cZ9iwhY/91c1hX51rnGNjKL5R+BSiGkEWBU/x0E/ungzQHsS6RYyMeKCS+rAG8jSX
	llHSTPCDg8Ng9BuGLrrbo7daA31LV8gNNqsYofG20RUXfQDcTZlNosUcfyDjrJ9TxekmMv
	JXq+v1TeSaDSCqr5DUX7M7cXnSAjDCU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-WJYgv8K0NtSi3fhsI-U98g-1; Thu, 01 Oct 2026 21:15:15 -0400
X-MC-Unique: WJYgv8K0NtSi3fhsI-U98g-1
X-Mimecast-MFC-AGG-ID: WJYgv8K0NtSi3fhsI-U98g_1790903715
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88b59692e0dso82289b3a.3
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790903715; x=1791508515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47kV0KPyHe1GkaaHQZyr7eIJ1DCCCT2lh5D1q3j8m6g=;
        b=DrEXvUvxGI7yIQZNR+4b/5wlbzms5NkKckWcz0kpgMwiiRdvetloCt4JflM7+GQ3PP
         p7fFAo3TK3bR4yB3f7Rog3FeHjbtnD/wYbDWTsVpc25ZxwScyW9m/lgJvyiYMCznCuDi
         FgrjuKITj/CAaFn0PgGbTlmpqNgt+IgSN9VmXMcn35nhTFTGYcjv4oUL0x2c/BLLqXEt
         KpwLkDph4iBw6mN1OiJJbJyX7msf+tprGBiKc3eF0fXWSkOPvLEfMk6+pgTdvRTs+yRq
         rWXuu2CtAcE4y8vmNpOclNxJGJQssS0QBaRT3wJGb/zFPL0mn173MB9MWB7qBMzC3QnS
         M3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790903715; x=1791508515;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47kV0KPyHe1GkaaHQZyr7eIJ1DCCCT2lh5D1q3j8m6g=;
        b=nRjm5FlEWs35bebHzQVdyh4n4Ls8mSkEodYzgv2/fChtEFWEqjFUKcrlMHw/NKN2I7
         qLkRVaViADlylsLFoJ+VOPpc9glUaWX5nbO8nH5HHPx7swYb5OH9zUsyWT62Rur7HKRn
         tw4Wmtgwj5FA78MPoYACMLoiXuT7K86W5w62P/u8dAcAKsQ7Gz2ZM/MtDhAkE2TE2jav
         eE8We9U0jr3JE5SdXB6cFEcn7V1fL8rMgGvkuaAYCHh2UNI3H1Hr2ROzZJ1sOnw1daDS
         tHSOOVCNVGRh31L9CB0kcvJbhOBRswFKIQgQ7ZVUU0WQ4IGPSOdC6G4bxQfFPzFZ3MLY
         ykfg==
X-Forwarded-Encrypted: i=1; AKwUvByv7ECmPpAYEUsLfn4giRIFrVPKDIqom9PT5ltHfWCYQSp92nbAfXKuosUBp/di9Yk3XCM=@vger.kernel.org
X-Gm-Message-State: AFuF++nIoKchfeUO2xZnxVUn7xw5fXh8ffS2FzqOUAs57vxyngr/kUqj
	En5X7o6fSJThFLxTmwAPmxH1cgd5ThZ+4zGlOSwYo8fLxFY0rDAhghw4GRxH0N3zUDmzOT3mhlB
	fAhVamTBGJVx33gF/sXtCDfEGeLS+fA2XlJMQDAOk1bdIJLqAXHK3Sg==
X-Gm-Gg: AYBFou105MGciXpbyC9XSx0SKKOQ0lGjNeqwbeRaJ0ER5070DDNny5O3uepdvXRZsoc
	c0+7OvoDRkdGIZKOB/5oqpjSxCFe5lx0pQsRRJd8ivLo6e/xJccbmEGi9J5rhl50t1QH9t0GHAY
	odtVuGdAzv1AuhXVIy19L96ZJHIKBsHFjeyuUr3GZM3EfvEaPUDgfyQ1fqLpJjKiZ9IVginJGhf
	ZieBwXP1/gAqUH5HV0xeu3esi1ZY1NSJtPkesK9242tHxWWnBVY7n0fHHOC5WmSHVL4JHFBZmcc
	5kFSbYHC+9TJk4LCZNPKupRWm0LcMxvUxMmUhBEWf5WyPfB9GuTpb+CogFgYL2U+DvFtrTqLGgF
	oXmIu30VtJNsXo3a3fGZVYp1raN9VdoeBQz1Z+ZD6hQ==
X-Received: by 2002:a05:6a00:a12:b0:880:5a44:9367 with SMTP id d2e1a72fcca58-88af58d5270mr977463b3a.30.1790903714546;
        Thu, 01 Oct 2026 18:15:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:a12:b0:880:5a44:9367 with SMTP id d2e1a72fcca58-88af58d5270mr977430b3a.30.1790903714012;
        Thu, 01 Oct 2026 18:15:14 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0bfc3dcbsm285307b3a.24.2026.10.01.18.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 18:15:13 -0700 (PDT)
Message-ID: <ad73d89f-6615-49c1-a35e-3f01e7305744@redhat.com>
Date: Fri, 2 Oct 2026 11:15:08 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 09/24] hw/core/loader: Add a ROM loader notifier
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-10-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-10-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
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
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/core/loader.c         | 15 +++++++++++++++
>   include/hw/core/loader.h | 17 +++++++++++++++++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 5cbfba0a86d2..388f10e828db 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -74,6 +74,8 @@
>   #endif
>   
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
> +            .data = rom->data,
> +        };
> +        notifier_list_notify(&rom_loader_notifier, &notify);
>       }
>   }
>   
> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
> index d9431e8a8d12..fdfddfa7443e 100644
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
> +    /* Blog data */
           ^^^^
I guess it would be 'Blob'.

> +    uint8_t *data;
> +} RomLoaderNotifyData;
> +

There are enough space at the tail of field declaration lines, where the
comments can be put:

typedef struct RomLoaderNotifyData {
     hwaddr  addr;   /* Address of the blob in guest memory */
     size_t  len;    /* Length of the blob */
     uint8_t *data;  /* Blob data */
} RomLoaderNotifyData;


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

