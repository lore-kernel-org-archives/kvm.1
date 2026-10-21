Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585509;
	b=uwEzzz/KfsEwnXD2HJhYcRBJCKZZNThvMVSLZmI0vUv8jaj9L5yTniorYIvbXwaj+L65
	 PIOd/2flJFH4RJjHAWx4c8ZSeVvt/kNviWLgWTkBADL/uzpXZ86Na4VrCd4zn5OHpEicO
	 rrtnot9ee0KCDD05dCBzEu/oQsog9cqALmuulNfKoL+lQmeFrjr1Vt6AhJhX8v94g2SPi
	 2YlV1foOS8UcnNp2qIS9N6qbp2//RE1mxsRjLhU6eBbMDnFtI8OeG7Y3h/IV/N1oSWZJZ
	 Aw/hhGYOQc91/NNeiY8ZJcBMD9kYBbxf8hhQjayR8PNF8nQTC61dYSbWBO+HtxkgvYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585509;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
	b=0M8OWdpF03yffSXG11VrwPEdhM2Z7p1cGF3oLVdBQU7xH30xLJ8E4CuVPbHd3PrOThVP
	 eqafKUEuwroIiORmixd9ukcjTH5l5yK6mVTVr69wcASosfejVmNJssr0V8fZyhOqFJucy
	 rpKknvu2hKkIRIr8sVeqehMa51EX6VVaDnPE2abfR4PC+DSSUAWFg0YzdWLHYSChtMK1T
	 Kviz6niEJ/jd8y5O/zu2STqltlO3NzdUeZmfwPKV7Zm8dRVbKbmzoch/55OiK6LWpK0Rt
	 b0sqXz2xwkiOhCM2lPlIQph4cE7QMAIHQfqpVft8+GVwyGKmY5cFVM6H2idKwXrl2Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OvoQ4m2l;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KlKZRHql;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B1606A319
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 12:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB5B1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OvoQ4m2l;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KlKZRHql
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792585507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
	b=OvoQ4m2lCHeN5GMjW7Rtm1DsXgbnd7aIVosTSvbAbe5vx/inPZQdrcmDEGu7nzoRd9mxZb
	2zow/1f7hc6WBSHIdupX6ED5fqSc4RKuGt8zMIZpjYV1Z8BqXVGp45utP/TWQ8ufSBGFff
	1b+DjVpItPiQOhSNkWLp0iswppPsB2c=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ibMn_esRNCOGnLVEAieijw-1; Wed, 21 Oct 2026 12:25:06 +0000
X-MC-Unique: ibMn_esRNCOGnLVEAieijw-1
X-Mimecast-MFC-AGG-ID: ibMn_esRNCOGnLVEAieijw_1792585505
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9995cea88so7247225ad.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792585505; x=1793190305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
        b=KlKZRHqlh6p15wLJQRJDJjHsXiICiAEZPGKm7/YK3i6GCdRXwVp2HppLgkpLth6QqP
         gXsMref9vE2GjcnsO5IFGD6NqqvuAB/8XyqN7cb3OBQJYuDvUX1nBMHJuQTJCtXKNFu5
         62vu7+mtFkflvHGElJKx5WiWO6OR9MoFy1WemdYBEi/yc4F2IvxZtyL37kY6noeEkSTS
         QUtNQt1CHDZX6uCHJTcX5QoocgBPKHndzKyn8CTTCLFjHPY2Imew4wUzQ8ij8EPa1TS7
         /5ubXKYOU7j0VaJRWXZOwq/87w19/gj3PcjxrKCNwwCZpYzMsf+Nmxl+6XqzCgmNLfD6
         KkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792585505; x=1793190305;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjooxX8trLUdWh2b/jQFqAnjIlmbplRrLhuuOCg7DJU=;
        b=WmilcUaktBZj8/ncz6jcQU5txPXWzuR6QHGaiBynlx11bSImwwAV8WmlPkGnJCGBHH
         7Ya0GT9m8XOPsTpESEQQbg/w/ALEUI2cJlaiqGzVPDL+KT9xrl9jNBmihHb/jA0SCpYm
         xLVN0Z7J1eL+mPpeJTg6Ua1JVsjU8QJf1i1JNmUlzDYbMYurb7AOsAxAyV+vMASHjEHM
         1BPuDRhDm8QMDUq+Q8eXwH4Kcd0MlnUXtHw4LaG+DLMZCAxIdxkh0EZ7LZ9V8qL5bBdD
         Sy9CK5IbsS1bsYQY6ghnhq1jUpWUq9rbGScJ4P+/30RQeyhdwnYNdPxzhvZbQjfM3NdJ
         34mw==
X-Forwarded-Encrypted: i=1; AKwUvBwcZ6pAtTLjHut44ck63Bne0ul93++y19jXYlw0DOW4HqQT9ITxd/+r2tYfvb7ei7bVdOg=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0Z+vWfPE3Ug2LmSEkq+QaY4Sl9h4TINrp7eyFSZ7eTReC6MNP
	nKd97QBZFC+Jq3fjvY1BcLX8x4YMlJMAwuPMdLGi3QVk3Fg6gOTNiMG+MJ6Wd0/RVGuOYWJtd7o
	Pyoi4VSsGtycQekfz9bjDmV6QDp5nBuy3D+VWmm0/fio/YRDNNpeDiA==
X-Gm-Gg: AYBFou2CKlOgaX5dUYood1PF4o+u/l11AsBxUNGpCt1EJ+ulzjfGLYALv6c0Iez2zbZ
	PyMoMY/3tlheWbD/8D2hCE+avTXHSjO1nVd8D4mriNcqgeBNYK0xAjucnKv1GgSeSKHyaNQFpRv
	G/X59g3G6Vk8I36ql5RqlLbQFBC2cYPlj5tCgJeLM9YVi5p+h+Z9d0v6L3Koen104qYrtx2RmZ5
	W2rrQNhYEcpNN1WBSleMrpKLSC+jlsB5GUDIB5SqVDRP8GoKiqc8TjbcYwBlJ5cGl3J9DOBInIX
	ehOsfUceahHBqnqyF97VROtZWwPN8Cqj1A7oTlUm11zs+NRYZ50i+XUp8st4njP6eQtKQLnrazC
	6MIZwb4RV6p3O9QTXp0Axbr9rPeg1uNXXO2T2BMsclw==
X-Received: by 2002:a17:903:388d:b0:2e5:467a:7a6b with SMTP id d9443c01a7336-2ea43d3a195mr15032325ad.10.1792585505251;
        Wed, 21 Oct 2026 05:25:05 -0700 (PDT)
X-Received: by 2002:a17:903:388d:b0:2e5:467a:7a6b with SMTP id d9443c01a7336-2ea43d3a195mr15032085ad.10.1792585504565;
        Wed, 21 Oct 2026 05:25:04 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4536ddsm10640795ad.43.2026.10.21.05.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 05:25:02 -0700 (PDT)
Message-ID: <27fe3ba8-c8c8-4d5c-9d57-3cfb67142ac1@redhat.com>
Date: Wed, 21 Oct 2026 22:24:56 +1000
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
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <atiKJ8-PyIHSRTKy@red-moon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 7:47 PM, Lorenzo Pieralisi wrote:
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
> It will always have to be qemu_real_host_page_size(), KVM configures it
> that way.
> 
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
> 
> Getting back to this because it is important. Can you define "safe" here ?
> 
> I think it is VMM's role to load with the required alignment and make
> sure it does not double populate (that is anyway prevented by KVM), what was
> your concern here to make sure we are in agreement ?
> 

For example, there are two regions are populated: [0 4KB] and [4KB 64KB] on a 64KB
host. With the alignment considered, we're populating [0 64KB] for region [0 4KB],
and [0 64KB] for [4KB 64KB]. [0 64KB] are populated for twice. Is this allowed by
TF-RMM? If it's allowed by TF-RMM, the data populated in the first time is overwritten
by the second population.

Thanks,
Gavin

> Thanks,
> Lorenzo
> 
>> I guess we probably just reject unaligned regions if they're not expected.
>>
>> Even if the unaligned regions are allowed, they seem not well handled.
>>
>> - @aligned_size is still 64KB instead of the 128KB ?
>> - In "memcpy(buffer, region->data, region->size);", the blob data would be copied to
>>    [4KB, 4KB+64KB]. However, we're copying the data to [0 64KB] now.
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
>> Thanks,
>> Gavin
>>
> 

