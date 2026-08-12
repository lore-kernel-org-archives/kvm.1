Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5216427FB7
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530939; cv=none; b=Uz5jFFUz5610/W/1VouKBcgJ4me+YXNfelcdj7ICpslRpEfO/k6svrUtHLRczDb8mXP1/Pk6ED0E7qhwwnCRQMuQHsWIAnDy2K+jHiCOqxPr4O8X7COV10UVgbpl4tlYM5XT9oeuZYaii8I/zgr/UhJRy8bFzoM8Svk/HyQalzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530939; c=relaxed/simple;
	bh=hmvnV8jq2VlO5D8E3BC6mggbg+vlcmzLS90IWfplZ1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVeO/inCQLC9HZqTAotH7nzRLX3fK0yAol4aExTrHeNpPE19Hib8B11RJaRSYtnS9n/zMvznfexRi5mduIR9bNeX/IK7BNaXUEAohlT15asghmUtPPmO0Jxzf/YoNS3DjStM359rLrn23iejrIgXmOUmI9nj9rYU9ttv+jfoh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNmFuvFC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ae1G8Bhp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNmFuvFC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ae1G8Bhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786530931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nFHBCckinCTeWhtqGBwRJEbOqSgiMtmkEGgpj2JEUY=;
	b=eNmFuvFC+X440R8GJiYIaIwoyRWEx+4gMuQt0tlhUHWKCiQjylUqg7XmxlTGWzNcxo0yO+
	Rk/IkzwtI0u8dkZk+QdnCbVwi9L/B5p+AqatL8tMQp08BjkqM+SCMb70TO7+PEGPJ9Xv73
	kOfxW4R85B/RgUVsK0EsqmamJLUYYJQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-TGTWmkdvPp2n-BRY_kIlOw-1; Wed, 12 Aug 2026 06:35:23 -0400
X-MC-Unique: TGTWmkdvPp2n-BRY_kIlOw-1
X-Mimecast-MFC-AGG-ID: TGTWmkdvPp2n-BRY_kIlOw_1786530919
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so1269694a91.1
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786530919; x=1787135719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0nFHBCckinCTeWhtqGBwRJEbOqSgiMtmkEGgpj2JEUY=;
        b=ae1G8BhpwsiCCiZ6RRgPZGZbXU8kVqEHbb+SGYoORREHzeml6AE+bQs26xmIj4NRq1
         HEvaz1E+NFI3/vqIuMI3pMi1hd2h+ra84rMd/iTQ94FvUkyBSpEwcsiNNbJaOhyrkUeF
         Ieq42/REMJqagVUEghtMDwJbaWAi19ePZcJzFLuissU0tdW7S2Qf44Z1CIItZsux2Apl
         u733ZV1hz8OY3Iw9GBsoIpyc/9F/Z64sq2rme+QWiTcebi1NcQ7cDCDfgtcEyBVX5YmQ
         Uf13lGj5iDYVlmmwYubALYsDo6Z+WvyXJWI8TgbKwe9CJfVlLoD1jyZwlUtFQbw2w595
         uUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786530919; x=1787135719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0nFHBCckinCTeWhtqGBwRJEbOqSgiMtmkEGgpj2JEUY=;
        b=Il/IwTHGj7TH7eO30J8HnByCCK9XSHKn9pKscjU7i+mxpxellKLGdBYC/TIFhFFtaz
         7hLxHzQfhjNPqQpIDnHv5eGvUTPKaky65o0IYKZg3R7dzDkXHdBTyZElW2uoBpI6s4mJ
         ip7glmgP0LZDRcAMEkmROzH+SrXrLWQNN2l73toIQ2sz2mJYeORWwVXLJJfteokJporL
         jW0waObQxqghY0P3nWz1DlmphaxBuGc0eBjfSiNE7orAUWGqifHss1TDbpXTfq9xBtb5
         jF5//cGYJOspEgsRwYrt9A1hwyP/D+fSFd6EZGi1CuWa0Eo5RElfQVHpQ74hGPROh63G
         ZF4g==
X-Forwarded-Encrypted: i=1; AHgh+RqXTUDRqHstYzNCAAp3Wg3EKnyRQ3gz6YLcqoJPEhLasVvyJJQ652soBfcbeVhtWuevoU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjidu1tJAHdbU6hm+psVjCOGADYz98ZI8q79IaBUND6zboOk9h
	ONJBjBDCw+Q/uWtuPBac8nO+DFfKrOOnlXV+fGV8jqaGX2wcMPFYlhDl5CprlKUYbsBl/jbFvF5
	0l23xiG9c08Di7a5oGLuFSz7qHCnTxwpmDBWuU3kVGYE4wT609CvEhw==
X-Gm-Gg: AR+sD13gBlWyAXEVeemq9Elg1V4oovgSG17CBmmv+Ogisix/IijoC4wL6NGp8N8AQxl
	GQ+dtfO2Luq328P7EQvtoIoovkRvkw7ndpmMQl2rxfOfsxtJpABNQ/Sgu4IM+anxZJMxAoASL0f
	93o2JFpUoAYH3gNT6+esdK97YjOaMhlxkLivYWN0OWvNPtJDMw3zCJC4siSmXfcZEeep9hUyR1P
	/myxteTnabIv8lSZdvOIaiSjONs8C40NwUWiy4A3APC0/eyVjrdFu5qfDMrstlVdXXobGiLJ5JA
	WC0S43jgvQxOE9D1643VZ0s3hjTSfJ1MxsXDECU9+OQZdY3Deh77LrfdjHA/Tq0WYkA14JqMQdt
	nGN75RxgqgiFyuFU4RKkjfgszHJ/VxDcPOvtWg9rifHo=
X-Received: by 2002:a17:90b:35cc:b0:38f:5828:a40c with SMTP id 98e67ed59e1d1-3930151d000mr4704145a91.10.1786530918652;
        Wed, 12 Aug 2026 03:35:18 -0700 (PDT)
X-Received: by 2002:a17:90b:35cc:b0:38f:5828:a40c with SMTP id 98e67ed59e1d1-3930151d000mr4704090a91.10.1786530918167;
        Wed, 12 Aug 2026 03:35:18 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au. [175.34.8.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d1e8csm3212165a91.5.2026.08.12.03.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 03:35:17 -0700 (PDT)
Message-ID: <ad7d1093-685d-4c11-807d-929d16271cdb@redhat.com>
Date: Wed, 12 Aug 2026 20:35:05 +1000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/45] arm64: Support for Arm CCA in KVM
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Alper Gun <alpergun@google.com>
Cc: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Zenghui Yu <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve
 <vannapurve@google.com>, WeiLin.Chang@arm.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Javier.AlmansaSobrino@arm.com
References: <20260803134403.80630-1-steven.price@arm.com>
 <42170467-fe36-4382-867f-49bdc6a7bc9a@arm.com>
 <d0ffbcb5-0cca-4d1e-9788-6b430345fa9b@redhat.com>
 <5e86232a-89ed-40ff-89e2-9e48fbf9554e@arm.com>
 <e2894206-7470-4606-b9ac-eedc8d2bdaf3@redhat.com>
 <CABpDEukGY+ctSi6wHAaC7o4pGmastX_Y18K2_VYDhNME7TF+wQ@mail.gmail.com>
 <f5d47f5f-5869-4e3a-a176-4fd632567975@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <f5d47f5f-5869-4e3a-a176-4fd632567975@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alper and Suzuki,

On 8/12/26 4:04 PM, Suzuki K Poulose wrote:
> Hi Alper, Gavin
> 
> On 12/08/2026 04:25, Alper Gun wrote:
>> On Tue, Aug 11, 2026 at 8:08 PM Gavin Shan <gshan@redhat.com> wrote:
>>> As the following calltrace indicates, -EAGAIN is returned from tf-rmm::update_ripas()
>>> because true is returned from s2tte_drain_pending() for the S2TTE corresponding to
>>> IPA 0x80000000. Linux host received error (RMI_ERROR_RTT, level=3) in ripas_change().
>>> Upon this specific error and the IPA range [0x80000000 0x90000000], find_map_level()
>>> returns level of 2, and realm_create_rtt_levels() returns 0 without populating any
>>> RTTs. After that, rmi_rtt_set_ripas() is re-executed and the above loop starts over
>>> again.
>>>
>>>     Linux host
>>>     ==========
>>>     kvm_arch_vcpu_ioctl_run                     // cca/host-v16
>>>       check_vcpu_requests
>>>         kvm_check_request
>>>           kvm_rec_handle_request
>>>             kvm_complete_ripas_change
>>>               realm_set_ipa_state
>>>                 ripas_change
>>>                   rmi_rtt_set_ripas
>>>                     SMC_RMI_RTT_SET_RIPAS
>>>
>>>     TF-RMM
>>>     ======
>>>     SMC_RMI_RTT_SET_RIPAS                      // tf-rmm/topics/rmm-v2.0-poc_3
>>>       smc_rtt_set_ripas
>>>         s2tt_walk_lock_unlock
>>>         rtt_set_ripas_range
>>>           update_ripas
>>>             s2tte_drain_pending                // true, returns -EAGAIN
>>>
>>> The problem is the pending-bit for RTE corresponding IPA address 0x80000000 isn't cleared
>>> when SMC_RMI_RTT_SET_RIPAS is invoked. I didn't figure out how this bit is set and why
>>> it's not cleared in time.
> 
> Thanks for the details.
> 
>>>
>>
>> Hi Gavin, Suzuki,
>>
>> I think I ran into a similar issue on rmm-v2.0-poc_3 last week.
>> This looks like a potential RMM bug: could bit 32 be part of the physical
>> Address (if PA >= 4 GiB)?
>>
>> It seems s2tte_drain_pending() in lib/s2tt/src/s2tt.c checks bit 32 without
>> checking whether the descriptor is valid or invalid.
>>
>> In my testing, guarding the drain checks with a check for S2TTE_INVALID seemed
>> to resolve the boot hang:
>> --- a/lib/s2tt/src/s2tt.c
>> +++ b/lib/s2tt/src/s2tt.c
>> @@ -1701,6 +1701,10 @@ unsigned long
>> s2tte_clear_drain_pending(unsigned long s2tte)
>>
>>   bool s2tte_drain_pending(unsigned long s2tte)
>>   {
>> + if ((s2tte & S2TT_DESC_VALID_MASK) != S2TTE_INVALID) {
>> + return false;
> 
> We should use also consider cases where the entry is INVALID, but
> has HIPAS=ASSIGNED/ASSIGNED_DEV to make it tighter. So, I think
> it is better to use :
> 
> s2tte_is_unassigned() or in the library stick to :
> 
> if (!s2tte_has_hipas(s2tte, S2TTE_INVALID_HIPAS_UNASSIGNED))
>      return false;
> 
> May be we should assert this and make the caller responsible for
> checking the bit. I will leave it to the tf-RMM team to fix.
> 
> But for now, please use the above fix.
> 

Both worked for me. With the extra check in place, the realm guest can boot
up successfully.

FYI, The below additional checks in s2tte_tlbi_pending() and s2tte_drain_handle()
aren't needed because they're always guarded by s2tte_drain_pending() in all
calling sites.

Thanks,
Gavin


> Cheers
> Suzuki
> 
> 
>> + }
>> +
>>    return (s2tte & S2TTE_SW_DRAIN_PENDING_BIT) != 0UL;
>>   }
>>
>> @@ -1730,11 +1734,19 @@ unsigned long
>> s2tte_clear_tlbi_pending(unsigned long s2tte)
>>
>>   bool s2tte_tlbi_pending(unsigned long s2tte)
>>   {
>> + if ((s2tte & S2TT_DESC_VALID_MASK) != S2TTE_INVALID) {
>> + return false;
>> + }
>> +
>>    return (s2tte & S2TTE_SW_TLBI_PENDING_BIT) != 0UL;
>>   }
>>
>>   unsigned int s2tte_drain_handle(unsigned long s2tte)
>>   {
>> + if ((s2tte & S2TT_DESC_VALID_MASK) != S2TTE_INVALID) {
>> + return 0U;
>> + }
>> +
>>    return (unsigned int)EXTRACT(S2TTE_SW_HANDLE, s2tte);
>>   }
>>
> 
> 
> 
> 
>> Sharing in case it helps.
>> Thanks,
>> Alper
> 

