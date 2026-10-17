Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5C035F162
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 01:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199222; cv=none; b=H8ucl+UH7kmkPythCRgx5/oq0XZYO6yJcr5UAhCHwXzI3AozMi0eKpdOrmyhiSfJdQI9OO/Wa8WENGWirfWgTl5ev7SUyffII4hZ1RzcUk4N5oat8BaySLTdKst5Da939yjaYb9hn7xIpYvHEe0fkP8C6V2NUuXBwfo0Ybr/Bts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199222; c=relaxed/simple;
	bh=/ZjPq+cti5YaIzsHHdhw07J1mVt7BOVBGvgk2koE3Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYzooBVjOWdXlBxR/7UcjMwm05tN6MMyx1rujMwpTZT7q4OLNNWxiWwxpeB+CxA5lH8MrihZ00f0xkCgkKePpo84R4o69yK9Z8cly5mZEOF8US39dNl/M9Kgg7IfshTdbbxelABoXNBb9IdnuKEWxsG25qfNCTPawekfexXEPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+rMANDm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=teQbKfHE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+rMANDm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="teQbKfHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792199219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vVmZ5kkrfr2JMM5xTb3EDhNT9+b+mkLGuq3qOJQaFk=;
	b=W+rMANDmIFAAix2vUZPOlQfFClXvF8uaRZWH1fmc5QttDnUeV/FmME4mzdxP3PzR+rkyAw
	bKuhSOxv5E2skgXax66KsC1N6IlgftKGp/LU6DADymWWqCFlGiRRBP4WzlCp/2/nW9DNKb
	VsSwA3BQ4kEyn1qj1RaufoecgSiqCuw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-efgl4REWNjKmqwLW6zishg-1; Sat, 17 Oct 2026 01:06:58 +0000
X-MC-Unique: efgl4REWNjKmqwLW6zishg-1
X-Mimecast-MFC-AGG-ID: efgl4REWNjKmqwLW6zishg_1792199217
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de4e72b33so626109a91.2
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 18:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792199217; x=1792804017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+vVmZ5kkrfr2JMM5xTb3EDhNT9+b+mkLGuq3qOJQaFk=;
        b=teQbKfHE8YqFZ7N9EyE+p/d0BO4qPIhfCZxWxAyPjuPEvxXA2cA/n7761cEACPX9Jy
         L0qSmNuCQUCHDumwvl8mFa5yWJGKQ2dKp5QuNsISKmGHtfG6BWT5xxwPtk5xy4TXHA1/
         zEgsOjUDRYPf1jJNtp5pd3PeyH4f5jOk261cxiBSTq4kUXGn2PSqJstxphhBZPBsRFDh
         KrQ2xY9S5zz2SS+zyO/imN/VvOfdf14AvOrvZmCLJKMP0uBzBx4X8Vg3ZwqZuulKqPlD
         dA7nCsmLSj/4xlufHFYS05yI82LYCBKm3AbQAN6ZRRhZ2GmGJvwWDFYC3Hq/hUSUAe9A
         13hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792199217; x=1792804017;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vVmZ5kkrfr2JMM5xTb3EDhNT9+b+mkLGuq3qOJQaFk=;
        b=2SBccQP2/v5QOVKABENbluzYAiHRz3AxOMnVlaHFxkPPwJW9FjJ4y2p1rLu4LVWaz6
         W4yK1SPtCRFSLC1n4PayKueQrmS9t7wv6uMWFqUBXidb47cjcd4qARQNzf3IPxHT0Rcu
         8P++Kb4zNWLzzNV+AQ8oFffkbvLE+P8GO4MKrRZ+/Rcsn/dP6kDj2km6/hG6xr7Qu+B1
         ywOyWcppd33ZW8YHm8T/4XdW7f92qTUtbcYfjhtvTfUpp1qp6jvyB+ua5aD8yddfse8q
         qaoR5YQxtF75UDTOAGPHgVZqn1suvzSRnnPQq47WnLptITTZRFvFYVYkyDEJ8jRtD7uQ
         RSNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxqISBeqZgSxDkggvGUVxPAqY54wZ5b9H/zkoT9ysB6Ym22uZ7XbNI8t5iK3uG424N/XaA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS72nQulPzbd5FEmQAUh+WPEZh8QuwYU6+uI2e0RkgLx0UOnms
	zmiIvUXrkL9dTmN/SN1B9sPWi36he+p4Ewma/zW0K4aTVzVABttI68HdG6N4COfAA0XCRUBefaU
	SNLFEjOxNWGAfIEQrH297gUC0X/nzuD/s/HJ91TX2yMHg8dQsrNPVVw==
X-Gm-Gg: AYBFou3Yc52x5z8qcrwHuktp5gopV2P1Fp5zpRbUOiPRm7mpBrCM8JZlutTAYcJTTF1
	u+pjc/C0rN46TyEnZ7qM4/5CEX0/fwxzmTvdsX90EDy8EG/vtNIQbV9VJWI2IKjeL37gmC6Dwj9
	rgoe+sR6lAf0XQ73WBNi3MSaqllS2qoIb++Ls2oOyhxo83+6uThUykdYmpl2ky62s2mkHYcVch4
	fKVre3r38jjyBEgGyVMLoaBLcD0vm6zZlxpls0jqQUrWTJGSrjzXaXHZjqDvl+eMBz/mO7zHAs7
	yCaY9hPO3DyYzqvJr6zkim0QnVT1qjN95n4++nLIV2WEXef639Y1iXvCTdH9cHnwI5jKnJGPJFP
	lyKnwce/Rnr1FQJSiu+V8ObPD7G0YABZwbia7fdQAIg==
X-Received: by 2002:a17:90a:e7c9:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3aceeb95e4cmr1332790a91.18.1792199216811;
        Fri, 16 Oct 2026 18:06:56 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c9:b0:3a4:ca46:8d44 with SMTP id 98e67ed59e1d1-3aceeb95e4cmr1332766a91.18.1792199216281;
        Fri, 16 Oct 2026 18:06:56 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm6669073a91.0.2026.10.16.18.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 18:06:55 -0700 (PDT)
Message-ID: <cbdab55e-8556-454d-ad66-37f035b57906@redhat.com>
Date: Sat, 17 Oct 2026 11:06:49 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 11/24] target/arm/kvm-rme: Populate Realm with runtime
 images
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-12-mathieu.poirier@linaro.org>
 <3257a387-490f-44bb-bd44-dbe06036fd52@redhat.com> <atKEWmnXA-Gu1Y9T@p14s>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atKEWmnXA-Gu1Y9T@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/26 6:08 AM, Mathieu Poirier wrote:
> On Fri, Oct 02, 2026 at 01:45:40PM +1000, Gavin Shan wrote:
>> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
>>> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>
>>> Once the Realm descriptor has been created, tell KVM to transfer runtime
>>> images (kernel, DT, and rootfs) from guest memory to Realm memory.
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> ---
>>>    target/arm/kvm-rme.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 76 insertions(+)
>>>
>>> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
>>> index 9985f5daba89..c082a5d8f3d1 100644
>>> --- a/target/arm/kvm-rme.c
>>> +++ b/target/arm/kvm-rme.c
>>> @@ -15,6 +15,7 @@
>>>    #include "migration/blocker.h"
>>>    #include "qapi/error.h"
>>>    #include "qemu/error-report.h"
>>> +#include "qemu/memalign.h"
>>>    #include "qom/object_interfaces.h"
>>>    #include "system/confidential-guest-support.h"
>>>    #include "system/kvm.h"
>>> @@ -43,12 +44,87 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>>>    static RmeGuest *rme_guest;
>>> +static int rme_populate_range(const RmeRamRegion *region, bool measure,
>>> +                              Error **errp)
>>> +{
>>> +    int ret;
>>> +    void *buffer;
>>> +    hwaddr size = region->size;
>>> +    hwaddr base = region->base;
>>> +    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
>>> +    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
>>> +    struct kvm_arm_rmi_populate populate_args;
>>> +    size_t aligned_size = ROUND_UP(region->size, qemu_real_host_page_size());
>>
>> s/qemu_real_host_page_size()/RME_PAGE_SIZE
> 
> I refactored this function in V5 [1], along with the above declarations.
> 
> [1]. https://lore.kernel.org/kvm/20261002202026.1204110-10-mathieu.poirier@linaro.org/
> 
>>
>>> +
>>> +    if (!region->data) {
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    ret = kvm_set_memory_attributes_private(start, end - start);
>>> +    if (ret) {
>>> +        error_report("RME: failed to configure initial"
>>> +                     "private guest memory");
>>> +        return ret;
>>> +    }
>>> +
>>> +    /* Allocate page-aligned memory */
>>> +    buffer = qemu_memalign(qemu_real_host_page_size(), aligned_size);
>>> +
>>> +    if (!buffer) {
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    memset(buffer, 0, aligned_size);
>>> +    memcpy(buffer, region->data, region->size);
>>> +
>>> +    populate_args = (struct kvm_arm_rmi_populate) {
>>> +        .base = start,
>>> +        .size = end - start,
>>> +        .source_uaddr = (uintptr_t)buffer,
>>> +        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
>>> +    };
>>> +
>>> +    while (populate_args.size > 0) {
>>> +        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
>>> +        if (ret) {
>>> +            error_setg_errno(errp, -ret,
>>> +                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
>>> +                start, end);
>>> +            break;
>>> +        }
>>> +    }
>>> +
>>> +    qemu_vfree(buffer);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>
>> I doubt that the unaligned regions (RmeRamRegion) are allowed. For example,
>> the region [4KB 64KB+4KB] is turned to the aligned range [0 128KB] when RME_PAGE_SIZE
>> is 64KB. The question is how do we know the added regions due to the alignment
>> ([0 4KB] and [64KB+4KB 128KB]) are safe for kvm_vm_ioctl(KVM_ARM_RMI_POPULATE).
>> I guess we probably just reject unaligned regions if they're not expected.
> 
> To make sure I understand your point, please expand on what would be an
> unaligned regions.  In your example, [0 128KB] is aligned on 64KB boundries.
> 
>>
>> Even if the unaligned regions are allowed, they seem not well handled.
>>
>> - @aligned_size is still 64KB instead of the 128KB ?
> 
> I'm confused.  ROUND_UP(64KB+4KB, 64KB) would be 128KB.  What am I missing?
> 

ROUND_UP(64KB+4KB, 64KB) corresponds to ROUND_UP(size+base, 64KB) for local
variable @end instead of @aligned_size. @aligned_size is calculated as
ROUND_UP(64KB, 64KB) and the output is still 64KB.

>> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>>    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
> 
> I agree with you.  That part was refactored in V5 [1]:
> 
>          memcpy(buffer + (base - start), region->data, region->size);
> 
>>
>>> +static void rme_populate_ram_region(gpointer data, gpointer err)
>>> +{
>>> +    Error **errp = err;
>>> +    const RmeRamRegion *region = data;
>>> +
>>> +    if (*errp) {
>>> +        return;
>>> +    }
>>> +
>>> +    rme_populate_range(region, /* measure */ true, errp);
>>> +}
>>> +
>>>    static void rme_vm_state_change(void *opaque, bool running, RunState state)
>>>    {
>>> +    Error *errp = NULL;
>>> +
>>>        if (!running) {
>>>            return;
>>>        }
>>> +    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
>>> +    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
>>> +    if (errp) {
>>> +        return;
>>> +    }
>>> +
>>>        kvm_mark_guest_state_protected();
>>>    }
>>

Thanks,
Gavin

