Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B513AC0CD
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784530088; cv=none; b=Rz7ar3sgndVVjHCLHu10YoXrTksjWeYxl6VUihlvtVGBKTR3ncTqbOcwvw9P71C1oX7E+9z4GckxmQg3QpPrBOpB4bOTQ2chowqoMb3r/p83GD0lmALkJOCuo0leb3ITL4TANgKVtvM3ydY1aItWPdruDTEQ8xSy4vq3LusM1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784530088; c=relaxed/simple;
	bh=6rHmY8WpNMTQcF+jbOCsMK+flJn82FGkW0JJdB/pKlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1Fc3lj9+OWTHqHEjcdca9B0243fhd303YSZXaZWlf2VBRxmFuGovy2MHyh8w8c+f3FjgRInXzP8ZgHs26mw2b6JIIVnydNtdZ9sn8KqchHclKQYk4Dyv8kKG60NoFYA781Ti6gj6GuSfgU8lYMhrZd0t7mgu5NCIR5R0U/JNCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUACdewz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pBJe2lwC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUACdewz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pBJe2lwC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784530086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PO8Fm4mt0VLaoOLS1XjuTB7cdvLtsrhFUoulsYxdlGw=;
	b=eUACdewzxB3ruN+wFywgs1f/lytgu9+rnfRxg6Hf+bM1Xj93OY4ngUB7wz4tdGcyJuD54u
	WKNZhmG3QeW4ypOM4/YnaloR9hydB9ikIuuqQkoD5pFzQPX3tXbsstItxILurM71FBBnLu
	WlAJ7F1lPlx5fHFGtxmPplAmCiuBQh0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-oHNwOU8DN9-hH5fKkuuMeA-1; Mon, 20 Jul 2026 02:48:04 -0400
X-MC-Unique: oHNwOU8DN9-hH5fKkuuMeA-1
X-Mimecast-MFC-AGG-ID: oHNwOU8DN9-hH5fKkuuMeA_1784530083
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so7787159b3a.1
        for <kvm@vger.kernel.org>; Sun, 19 Jul 2026 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784530083; x=1785134883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PO8Fm4mt0VLaoOLS1XjuTB7cdvLtsrhFUoulsYxdlGw=;
        b=pBJe2lwCtPr++KXKA3EMB6mAtV3t0mUjknXnDEU3qCrBKu7hGaU9i6BLIxtKPLDkD0
         suLY9Iai0ok4N9gleB44otu3KZyg3kOJ4XM5ow7KGkVT28Vu2v7dnXJi/FIyz/bcmGW4
         FWX4wgyLpJG1hg8UFXGFt4uCDhUkHRvtDx1QPu4Y8MGkHVjbIACeuNWAP1Mmv5vzmOap
         bWNWYA31y6Rq09IWZBzDh2p/65No+xLD0vrnCswUuYlN/UQvF05hr5Wx3Z++iXRU4VLX
         kfH3rnlYkJkjYlRbk9rbUP/K/PzIOuSd6Qeutf9/bQ5i9ew3dGq2/EGzM13h2lvSBY/Z
         f6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784530083; x=1785134883;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PO8Fm4mt0VLaoOLS1XjuTB7cdvLtsrhFUoulsYxdlGw=;
        b=b5Y9tgtW+hEsn2X1J7ff5MIbENvGUVOBFb1IAe1ooM+HR05U4Gc0qZTkT3jjHmeepn
         AZ2PLTzC3CJbwrwwWxS0f6VpWxRxlBaICHnMXvRWCD6+q3Jn58Emuyoet18wjsQvdV8P
         wnay0xnVD6f03a8HdZSdGx7Pq8XJuQ0ynz8MdBqEv78oCsc4F8w9j+JTiXr7vc6ks+u8
         bLoFSumPTJlt2qVofnIqjH0hD9UX6PLLqtGo81Jh92aJGIJPuipavUzVdFXLLkbBLdrf
         rQLNvrXjM62h1G9XlCqxuYEyzjAPWFDXT54xA+Qe5Q1xidNfPGDe0Gy3Z4ng0MDGpnBT
         kejA==
X-Forwarded-Encrypted: i=1; AHgh+Rru4lxGOCoIq5YeWKNJ9bvan59E+V5l9A+Vajck6E8aHCyGjNYnguXKlEfFQqDamRg/8Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUJ2WsyfqK+3nrLQU7Xv4uyhPPfxVmTVn2xhu57KtBNaP7jlN
	1qUrMfufPjx2Tt9IqWf8oLVLyCcKzuA+3Bk10zSwxbT+GBOKwob46RrVaE2jTAMoXWIKGzYFXhy
	/vANUH6MvgxBsNzGoJpXemWIqkqh3HCttFa1sO27d3kaMrN5sVRnvRA==
X-Gm-Gg: AfdE7cmpGdPd2p2gNstuZ97xgqglk0JeHFSzFJaOvJqjmwVVnenEnOJ4Qx6Dc6MVv9q
	OSKGuR2CdUZbFIsY1vWOLm1JSu67Mx1EiU8Y6/mpHPMzoffnUXMV/P1+zhqRqyoljt8tkTPSONl
	K3RAifDkbMky3bWOBqlsWOXlVE6Zj/Yor3WHHI80R1adVpt9nYSQX6mIxMKOR2+nQHo3Za7qzFf
	H2GvKDQYPa64jIt1m1O62VjczOwZi7hgiw2KPQYwKMT0TaYVy2s4uHULXLyK3AQg/UmojT2U1QF
	4FTVJDVaWB/xnYciHsCEGtjiwQ5jYQj89r8M0001Q2TvUx6PqjswZECrGac3/9v/JDkbNmfYsw+
	ZhPSoSL+onioicVrFW9BdblMlGQEXth/J03f9qH3ZfAE=
X-Received: by 2002:a05:6a00:391d:b0:848:65fa:542 with SMTP id d2e1a72fcca58-84c29494771mr11796844b3a.53.1784530083142;
        Sun, 19 Jul 2026 23:48:03 -0700 (PDT)
X-Received: by 2002:a05:6a00:391d:b0:848:65fa:542 with SMTP id d2e1a72fcca58-84c29494771mr11796824b3a.53.1784530082638;
        Sun, 19 Jul 2026 23:48:02 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc7adasm5227178b3a.19.2026.07.19.23.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2026 23:48:01 -0700 (PDT)
Message-ID: <2ad36e97-63d7-4464-b909-2a28d496e887@redhat.com>
Date: Mon, 20 Jul 2026 16:47:53 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 10/25] hw/core/loader: Add a ROM loader notifier
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, jpb@kernel.org, lorenzo.pieralisi@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-11-mathieu.poirier@linaro.org>
 <47136344-8e15-498a-a4fb-0dbbb0c71861@redhat.com> <allIviFWgoKgDob1@p14s>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <allIviFWgoKgDob1@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/26 7:10 AM, Mathieu Poirier wrote:
> On Tue, Jul 14, 2026 at 08:52:43PM +1000, Gavin Shan wrote:
>> On 7/8/26 8:42 AM, Mathieu Poirier wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> Add a function to register a notifier that is invoked when ROMs get
>>> loaded into guest memory.
>>>
>>> It will be used by Arm confidential guest support, in order to register
>>> all blobs loaded into memory with KVM, so that their content is moved
>>> into Realm state and measured into the initial VM state.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    hw/core/loader.c         | 15 +++++++++++++++
>>>    include/hw/core/loader.h | 17 +++++++++++++++++
>>>    2 files changed, 32 insertions(+)
>>>
>>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>>> index 5cbfba0a86d2..b3d769bec5cb 100644
>>> --- a/hw/core/loader.c
>>> +++ b/hw/core/loader.c
>>> @@ -74,6 +74,8 @@
>>>    #endif
>>
>> The (edk2) firmware for the realm guest can be specified by the legacy
>> '-drive if=pflash' or '-bios'. The memory region corresponding to the
>> firmware image specified by '-bios' is recorded by the newly added notifier
>> and populated to TF-RMM properly.
>>
>> I don't see how the memory region corresponding to (edk2) firmware image
>> specified by '-drive if=pflash' is recorded and populated to TF-RMM
>> accordingly in this series. So I guess '-drive if=pflash' isn't supported
>> yet?
> 
> Please give '-drive if=pflash' a try and let me know how you fare.  Edk2 is not
> part of the bootstack I'm currently testing with but I know of configurations
> where it does work.
> 
> I'll add it to my list of things to do if it doesn't work, though I may not
> address it in this patchset.  We'll see how busy things get.
> 

Ok, I don't think '-driver if=pflash' or the 'pflash0' property of the virt machine
aren't supported any more due to [RFC v1 21/25], where the 'pflash0' property has
been removed.

   [RFC v1 21/25] hw/arm/virt: Use RAM instead of flash for confidential guest firmware

- Tried to boot the realm guest with '-driver if=pflash' and I was told it's not supported.

   qemu-system-aarch64: -drive if=pflash,format=raw,unit=0,file=/mnt/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd,readonly=on: machine type   does not support if=pflash,bus=0,unit=0

- Tried to use 'pflash0' property, and I was told it's not supported either.

   qemu-system-aarch64: Property 'virt-11.1-machine.pflash0' not found

So the only option to specify the firmware image is '-bios', which worked for me.

Thanks,
Gavin


>>
>> Note that I didn't give '-drive if=pflash' a try yet.
>>
>>>    static int roms_loaded;
>>> +static NotifierList rom_loader_notifier =
>>> +    NOTIFIER_LIST_INITIALIZER(rom_loader_notifier);
>>>    /* return the size or -1 if error */
>>>    int64_t get_image_size(const char *filename, Error **errp)
>>> @@ -1201,6 +1203,11 @@ MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
>>>        return mr;
>>>    }
>>> +void rom_add_load_notifier(Notifier *notifier)
>>> +{
>>> +    notifier_list_add(&rom_loader_notifier, notifier);
>>> +}
>>> +
>>>    /* This function is specific for elf program because we don't need to allocate
>>>     * all the rom. We just allocate the first part and the rest is just zeros. This
>>>     * is why romsize and datasize are different. Also, this function takes its own
>>> @@ -1242,6 +1249,7 @@ ssize_t rom_add_option(const char *file, int32_t bootindex)
>>>    static void rom_reset(void *unused)
>>>    {
>>>        Rom *rom;
>>> +    RomLoaderNotifyData notify;
>>>        QTAILQ_FOREACH(rom, &roms, next) {
>>>            if (rom->fw_file) {
>>> @@ -1290,6 +1298,13 @@ static void rom_reset(void *unused)
>>>            address_space_flush_icache_range(rom->as, rom->addr, rom->datasize);
>>>            trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
>>> +
>>> +        notify = (RomLoaderNotifyData) {
>>> +            .addr = rom->addr,
>>> +            .len = rom->datasize,
>>> +            .as = rom->as,
>>> +        };
>>> +        notifier_list_notify(&rom_loader_notifier, &notify);
>>>        }
>>>    }
>>> diff --git a/include/hw/core/loader.h b/include/hw/core/loader.h
>>> index d9431e8a8d12..94cf6ad2e26b 100644
>>> --- a/include/hw/core/loader.h
>>> +++ b/include/hw/core/loader.h
>>> @@ -342,6 +342,23 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
>>>    ssize_t rom_add_vga(const char *file);
>>>    ssize_t rom_add_option(const char *file, int32_t bootindex);
>>> +typedef struct RomLoaderNotifyData {
>>> +    /* Address of the blob in guest memory */
>>> +    hwaddr addr;
>>> +    /* Length of the blob */
>>> +    size_t len;
>>> +    /* Address space of the blob */
>>> +    AddressSpace *as;
>>> +} RomLoaderNotifyData;
>>> +
>>> +/**
>>> + * rom_add_load_notifier - Add a notifier for loaded images
>>> + *
>>> + * Add a notifier that will be invoked with a RomLoaderNotifyData structure for
>>> + * each blob loaded into guest memory, after the blob is loaded.
>>> + */
>>> +void rom_add_load_notifier(Notifier *notifier);
>>> +
>>>    /* This is the usual maximum in uboot, so if a uImage overflows this, it would
>>>     * overflow on real hardware too. */
>>>    #define UBOOT_MAX_DECOMPRESSED_BYTES (64 << 20)
>>
>> Thanks,
>> Gavin
>>
> 

