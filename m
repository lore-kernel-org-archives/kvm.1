Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792711848;
	b=bbKo5RXXH4bi7xFST1zBfw8AR/9tsOuqX3srxc4PU6aaRz4HZkISB+rT79J94uLwf5cI
	 hJlu4jADCNaQ+3ahSjfLaRI335ETOYJLTAx+sdqu9YtccalewNxKpqIcNA99dHdL/3W+N
	 QQkwB5rExhwVKhDGk0oswW1vDS8LQDCP31zvt2DIqg6SKCFjEgq65c/WMDTNDcOUBqcQE
	 m1F4otQPKSU00eNSUQnSM/PYITD9q5eeAf8d1684BZk/KlxurZErXkXpFTgqh+221FlEe
	 OyR0QXNPQa5pA/JT43dQYWzLx+C5NNHRc5uOVl3AKtYepIqZgLZioSLQ/K2KVmttafQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711848;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
	b=fLbF98yfOWYnr5ZZ1FZMtXvfSzMuORR0A2BlrZVxF85/yP8Ev5PReZNzniBlHQ6FmGkS
	 6PuwhE3MaVJ9UeMhwPprzceoWokBVA6GRNzyke7ANStO76svs8ZZ6h9tffCuAi1KcC0+4
	 38flgYeDKoCLArl+R0Q8QSOKKSqmvMykGmlQKQPkNP5oRatm4IgKzdOg5YYZx9VxX1pCi
	 K2ber5m5WL+SFRXMfix6aATuJ1Z5HkC1sZUgF5h88TfMpOT1NIzSjBqGBA+Yt9zPrKfPS
	 KrxJFA71MqwdLgAwWhkd+CCqdg0DM7H3jvr43UkOcN4jsMyMllbh89W4cpUpPr4Fz6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn3u8vwu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QnafxEw7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A2606A31E
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 23:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D63A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jn3u8vwu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=QnafxEw7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792711846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
	b=Jn3u8vwu/5GDV5GZjmQO1Sty/hZgv470TM9L0VKIh8ekRScc1c9smM5UWFFSrWrcUa8WpL
	mwVVw2Ez2Yr5KP1Lx1LjiSxjaxNGl3f8LXzNBbt9jT+7FoXR6OxFZezvOdR5v0XFg5wbLx
	TN9RUIajoJdJ6aRbIdhf8f9xNQoTLco=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-myYs2ildPqeLOEyPvY4fhQ-1; Thu, 22 Oct 2026 19:30:45 -0400
X-MC-Unique: myYs2ildPqeLOEyPvY4fhQ-1
X-Mimecast-MFC-AGG-ID: myYs2ildPqeLOEyPvY4fhQ_1792711844
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3adbc9a47fbso289317a91.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792711844; x=1793316644; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
        b=QnafxEw7NVialrYYViXPVsH2mbMqjKi62ERjhUMZOLnNc7ErqMpUjNP7h9LL2U7u6A
         fhKcFUkyRKU5Wl4ASf4LGXKdJv+LLPdgSsoGsGxG36xEEs48/hI6I5XqTWIxzeqF5wLf
         iVSIsmz4WKqVeTARgZfwefgeGcT/6AZU2HjgZjojEub2fPG+x74aRhXA3gVZf2hpLx6i
         nTA/cV/iXC6QJlCXe3oDIIlZfRlBVQWdP9MJUCAiGn3+DVhcQztUAPdwdxNE48eLhHMh
         EX4v3BBNBvgjNuIyCWSddRyJ8qzMzfdEV6DvtEv703KCScsc3PqNSRyJOUu4y3hMMIur
         jDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792711844; x=1793316644;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MOgyq+Ja3mR+Ufhj4i5OdqknV4ad6wdPSZHg41lniQQ=;
        b=KNVAUkMGFbFwFBfM2ubTC43ip0aGHuW4Sfj/vwTttHVgsueexCx39d6K2LFTmxT3gL
         GKVuuXtTzrKaaYq9pue0fmyGx5H5JVv0Np9KKUEnf8j8sLBEsaK4klLkuIAK/JcXiC94
         sgti482F6w0u3HFcOMdSTy/2E9tQQw4pWSAgCAERNuNmn1bO6v+/xFz2YFHASrJAvfyk
         0ZCVHfcwHgb6M6b/fF7/GtifxD+EvDcdS68tVkMDIvYO7wAXwkTXy9pwKaAaCQz4ZLiG
         AA/aC3XI3nwY5SKobpOCKQpph5TaR6HAdAKx8M3ctk7Dg1h8t4yauj/I+W+FFrHPr49H
         F6MQ==
X-Forwarded-Encrypted: i=1; AKwUvBxE5njKM3JtsxdOgTL+ptFWLG7elmMkJWPLGO9T9/rqMZy7rpGllX68fQIzJNLpDfUDo9Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmUd29YO+gR95VklYLPvAGHyQ1xNxznW6egVUdfUYXLTQc51xA
	OyiO4NwVy2t5mZ/jWIh5wn1d0AaZN/YHPjFOAdlQKrhHYlREnyHDOANJGgvHBuDqXnfEv5bjp9Q
	T00+2Ev7MiwRdhsKD0yUFZhUMzwCIB2Ntum3bDHZkQxj+8cEe+y1+4Q==
X-Gm-Gg: AYBFou1wy3bC+OD7St84MeQRFZyE/l3ZGgtDbLLISEZEBTDnngeWog+ph1pfk4XrTaI
	eVoT6PuG/mcRActh/c3dzPTbu7x4QDONqopa5NOq7KQ2s3VyyKiiZ2pGxKmxu6nZ1dE4O7pfExZ
	RjMelXwUHSh3og2QPhzafyQfksU3fS3cJOMgb0UaZuQFtMQZ0mXlHwC1fXBCYkF3PGajvBe/nnf
	zpbOTNqZUKGinulcO0hcoY+xX3U+Msfdd8UacQzf3Mkwzj5mjKyrl8tTcD4VrWoaGpJhbs8ZKHP
	nKWla8Uv4l/HlI+sLHC7YXxWSccVu04wKX51ES8Vu6gIz6R0DIxeDnHip/jGPiO4msdQGeq+bvB
	UM1AfzSB89X1VxFb13Ga2zWQo1kE36UgFjmlpczR86Q==
X-Received: by 2002:a17:90a:a793:b0:3ac:b3f9:70cb with SMTP id 98e67ed59e1d1-3adce7cab7amr185971a91.57.1792711844125;
        Thu, 22 Oct 2026 16:30:44 -0700 (PDT)
X-Received: by 2002:a17:90a:a793:b0:3ac:b3f9:70cb with SMTP id 98e67ed59e1d1-3adce7cab7amr185948a91.57.1792711843565;
        Thu, 22 Oct 2026 16:30:43 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcdb06b91sm325014a91.2.2026.10.22.16.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 16:30:42 -0700 (PDT)
Message-ID: <ff029f82-07e2-469b-a758-6d27212a9227@redhat.com>
Date: Fri, 23 Oct 2026 09:30:36 +1000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com> <atiKJ8-PyIHSRTKy@red-moon>
 <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com> <atoe77pJ119cDcSF@red-moon>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atoe77pJ119cDcSF@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 12:34 AM, Lorenzo Pieralisi wrote:
> On Wed, Oct 21, 2026 at 10:24:56PM +1000, Gavin Shan wrote:
>> On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
>>> On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
>>>> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
>>>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>>
>>>>> Once the Realm descriptor has been created, tell KVM to transfer runtime
>>>>> images (kernel, DT, and rootfs) from guest memory to Realm memory.
>>>>>
>>>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> ---
>>>>>     target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 76 insertions(+)
>>>>>
>>>>> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
>>>>> index 9985f5daba89..c082a5d8f3d1 100644
>>>>> --- a/target/arm/kvm-rme.c
>>>>> +++ b/target/arm/kvm-rme.c
>>>>> @@ -15,6 +15,7 @@
>>>>>     #include "migration/blocker.h"
>>>>>     #include "qapi/error.h"
>>>>>     #include "qemu/error-report.h"
>>>>> +#include "qemu/memalign.h"
>>>>>     #include "qom/object_interfaces.h"
>>>>>     #include "system/confidential-guest-support.h"
>>>>>     #include "system/kvm.h"
>>>>> @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>>>>>     static RmeGuest *rme_guest;
>>>>> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
>>>>> +                              Error **errp)
>>>>> +{
>>>>> +    int ret;
>>>>> +    void *buffer;
>>>>> +    hwaddr size = region->size;
>>>>> +    hwaddr base = region->base;
>>>>> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
>>>>> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
>>>>> +    struct kvm_arm_rmi_populate populate_args;
>>>>> +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
>>>>
>>>> s/qemu_real_host_page_size()/RME_PAGE_SIZE
>>>
>>> It will always have to be qemu_real_host_page_size(), KVM configures it
>>> that way.
>>>
>>>>> +
>>>>> +    if (!region->data) {
>>>>> +        return -ENODEV;
>>>>> +    }
>>>>> +
>>>>> +    ret = kvm_set_memory_attributes_private(start, end - start);
>>>>> +    if (ret) {
>>>>> +        error_report("RME: failed to configure initial"
>>>>> +                     "private guest memory");
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /* Allocate page-aligned memory */
>>>>> +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
>>>>> +
>>>>> +    if (!buffer) {
>>>>> +        return -ENOMEM;
>>>>> +    }
>>>>> +
>>>>> +    memset(buffer, 0, aligned_size);
>>>>> +    memcpy(buffer, region->data, region->size);
>>>>> +
>>>>> +    populate_args = (struct kvm_arm_rmi_populate) {
>>>>> +        .base = start,
>>>>> +        .size = end - start,
>>>>> +        .source_uaddr = (uintptr_t)buffer,
>>>>> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
>>>>> +    };
>>>>> +
>>>>> +    while (populate_args.size > 0) {
>>>>> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
>>>>> +        if (ret) {
>>>>> +            error_setg_errno(errp, -ret,
>>>>> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>>>>> +                start, end);
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    qemu_vfree(buffer);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>
>>>> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
>>>> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
>>>> is 64KB. The question is how do we know the added regions due to the alignment
>>>> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
>>>
>>> Getting back to this because it is important. Can you define "safe" here ?
>>>
>>> I think it is VMM's role to load with the required alignment and make
>>> sure it does not double populate (that is anyway prevented by KVM), what was
>>> your concern here to make sure we are in agreement ?
>>>
>>
>> For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
>> host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
>> and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
>> TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
>> by the second population.
> 
> It is not allowed by the RMM and it is a VMM bug that we have to prevent.
> 

Ok, thanks for your confirm. It's why I asked if we ever see an unaligned
Rom region. If all Rom regions are aligned to host page size, then we needn't
to handle the unaligned Rom regions in rme_populate_range(). Otherwise, we
need come up with a solution to address the issue.

The solution would be to generate a temporary region list based on the existing
Rom region list. For each region in the temporary list, its start/size are well
aligned to host page size, and the temporary buffer is allocated, and the data
is properly copied over from the original Rom region. The population is done
based on the temporary list. For example, we need to have [0 64kb], [128kb 192kb]
regions in the temporary list if we have Rom region [0 1kb], [4kb 5kb] [16kb 17kb],
[132kb 133kb], [136kb 140kb]. The host page size is assumed to be 64kb in the example.

    [0 64kb] covers [0 1kb], [4kb 5kb] [16kb 17kb]
    [128kb 192kb] covers [132kb 133kb], [136kb 140kb]

Thanks,
Gavin

> Thanks,
> Lorenzo
> 
>> Thanks,
>> Gavin
>>
>>> Thanks,
>>> Lorenzo
>>>
>>>> I guess we probably just reject unaligned regions if they're not expected.
>>>>
>>>> Even if the unaligned regions are allowed, they seem not well handled.
>>>>
>>>> - @aligned_size is still 64KB instead of the 128KB ?
>>>> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>>>>     [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
>>>>
>>>>> +static void rme_populate_ram_region(gpointer data, gpointer err)
>>>>> +{
>>>>> +    Error **errp = err;
>>>>> +    const RmeRamRegion *region = data;
>>>>> +
>>>>> +    if (*errp) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>> +    rme_populate_range(region, /* measure */ true, errp);
>>>>> +}
>>>>> +
>>>>>     static void rme_vm_state_change(void *opaque, bool running, RunState state)
>>>>>     {
>>>>> +    Error *errp = NULL;
>>>>> +
>>>>>         if (!running) {
>>>>>             return;
>>>>>         }
>>>>> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
>>>>> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
>>>>> +    if (errp) {
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>>>         kvm_mark_guest_state_protected();
>>>>>     }
>>>>
>>>> Thanks,
>>>> Gavin
>>>>
>>>
>>
> 

