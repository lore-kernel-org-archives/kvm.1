Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337066;
	b=nr1e5BJmxGvLSxToKvOTYJcO3kRLMhBKz4hoKpqfvVOwXPOQLK62Gf5L7Bi+xlrMlunh
	 PGFemldzJIPxYR2e1BP/LryAfo5QYFkFWrst15GHJ6FtAceHPexkQiW2GPZpuFExfTa3M
	 J4WhN6qJ3UxDvoj5ngc6cOOqEKi/RQ8+RttyM3edqx6XCWz0QZqsGW0QzOGJNo0g9Pzpi
	 MRsLLbQDV8yYrnrvzqzS8n7zaRgg0Pmf1Aw43ntfZ/3ypCYZ4YzMqmmgi1ts9peE2Y9/M
	 JT+EgWeBv8k9ixf+/1EIEJytMzdVRAocuAK1BsQeXDRj8yyhgFV6ZCnw1Komn/DSsog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337066;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Scanned-By;
	bh=rlKyGDNFRRRZeLD1H+tAlDyIS2cpLbINa5wk2zLoKXo=;
	b=NxEbI+NH40P06Yi925V7gc4EZuzxQS8RauhbqSzvga2YuoKw4RxcRScfR+dcz2WYrs7S
	 TuXiF4Ck7drOwhxBHPrsHyxTjrP7tbrNuQBZK5CxsrTqaYJNq23SikGeYryvB4voGZhXV
	 Qkzq3oBJGtiiZmqEJF7DDsIPp3rVBvz5IhPcqTzdwMKvbdLG8qnsTrYCHkZ5lPIveDKMT
	 QEZFo49N+HAqX2016Xf4EwL3gp6iZEe5yJM8O8zoWqz+MP0hkPBWh59K00BzcJTlwrBAm
	 NZgqau8Xx8K8cVIovBiOXchkAWc2DLnAE73vdosV7woJ7wg/C0fbzjaFNvNRfhXqqQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJu6JLGk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD4606A320
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11FD4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJu6JLGk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794337064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlKyGDNFRRRZeLD1H+tAlDyIS2cpLbINa5wk2zLoKXo=;
	b=DJu6JLGkdFZO+Q6u2OR5EtMV+JwiulQViZryjT3QLHg2MRuJ8seXbKZkPT1S1HBU+mgsGR
	b97K3gZYhAHbfleOcn0dfjSLIws12l0QH0r5+l3nSXthaC/PhLd4qCyPPlUWymcc3Pl7Vk
	wXet4xBj7WdsBGrsw4e7Cr7KM3Uck7s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-HuHUPwHtPvOpMdkdJ1t2Ug-1; Tue,
 10 Nov 2026 13:57:41 -0500
X-MC-Unique: HuHUPwHtPvOpMdkdJ1t2Ug-1
X-Mimecast-MFC-AGG-ID: HuHUPwHtPvOpMdkdJ1t2Ug_1794337058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E003C180133D;
	Tue, 10 Nov 2026 18:57:36 +0000 (UTC)
Received: from [100.91.40.236] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E3CA19634EE;
	Tue, 10 Nov 2026 18:57:31 +0000 (UTC)
Message-ID: <6e957095-2a66-4441-88c2-8027c4a99c26@redhat.com>
Date: Tue, 10 Nov 2026 13:57:31 -0500
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
Subject: Re: [PATCH v8 1/7] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
To: Dongli Zhang <dongli.zhang@oracle.com>,
 Sandipan Das <sandipan.das@amd.com>, zhao1.liu@intel.com
Cc: pbonzini@redhat.com, mtosatti@redhat.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
 <20251230074354.88958-2-dongli.zhang@oracle.com>
 <81a1f791-37ef-4d26-bcf7-024eab4cd810@tls.msk.ru>
 <fa8b40df-a35c-4ae3-8eaa-b4b65c546a91@amd.com>
 <18ff5158-a515-4659-8388-5bcc074afb94@tls.msk.ru>
 <6ee6f858-37f6-4acb-8253-acd3cec584ad@amd.com>
 <f4a13c82-927b-465c-8ae9-9e7bb0f2e7b1@tls.msk.ru>
 <502e4c1f-3f5a-462d-87c3-076612935784@amd.com>
 <84b5b038-e32f-4765-9d23-9f6ecbf382c0@amd.com>
 <d0a22994-1a01-44c6-8a79-12470ee8dcd4@oracle.com>
Content-Language: en-US
From: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <d0a22994-1a01-44c6-8a79-12470ee8dcd4@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/6/26 8:51 PM, Dongli Zhang wrote:
> 
> 
> On Tue, Oct 6, 2026 1:41:05AM -0700, Sandipan Das wrote:
>> On 01-10-2026 16: 42, Sandipan Das wrote: > On 01-10-2026 16: 35, Michael
>> Tokarev wrote: >> On 10/1/26 13: 43, Sandipan Das wrote: >>> On 01-10-2026 15: 
>> 30, Michael Tokarev wrote: >>>> On 10/1/26 11: 54, Sandipan Das
>>
>> On 01-10-2026 16:42, Sandipan Das wrote:
>>> On 01-10-2026 16:35, Michael Tokarev wrote:
>>>> On 10/1/26 13:43, Sandipan Das wrote:
>>>>> On 01-10-2026 15:30, Michael Tokarev wrote:
>>>>>> On 10/1/26 11:54, Sandipan Das wrote:
>>>>>>> On 01-10-2026 14:02, Michael Tokarev wrote:
>>>>>> ...
>>>>>>
>>>>>>>> When booting windows11 VM with -cpu EPYC-Rome-v4 -enable-kvm, the
>>>>>>>> guest enters tight CPU loop while displaying a boot screen, before
>>>>>>>> it starts showing up the rotating circle (which shows boot progress).
>>>>>>
>>>>>>
>>>>>>> What happens if you use "-cpu EPYC-Rome-v4,+pmu"?
>>>>>>
>>>>>> With that, it boots fine, just like before this patch.
>>>>>> I checked current master too - same, +pmu fixes it.
>>>>>>
>>>>> A guest OS cannot expect a functioning PMU if the hypervisor has disabled
>>>>> it. Linux runs a basic sanity test to determine this. See:
>>>>> https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/arch/
>> x86/events/core.c*L268__;Iw!!ACWV5N9M2RV99hQ!
>> PdJ7r8w0UUuD5iOlCxu7931wevMkDprX9yCV5mkfktbFkpOobtIWrkMt0Gmb9Ztnj3iZHwTK4UQHh85raOPEmgo$ <https://urldefense.com/v3/__https://github.com/torvalds/linux/blob/master/arch/x86/events/core.c*L268__;Iw!!ACWV5N9M2RV99hQ!PdJ7r8w0UUuD5iOlCxu7931wevMkDprX9yCV5mkfktbFkpOobtIWrkMt0Gmb9Ztnj3iZHwTK4UQHh85raOPEmgo$>
>>>>
>>>> So.. what do we do with all this?  :)
>>>>
>>>> I kinda see the intention of the original change, but it results in
>>>> non-bootable systems (linux too, as I think you demonstrate above).
>>>>
>>>
>>> Because of the sanity test, Linux will boot but not register the "cpu" PMU.
>>> Perhaps others should also run a similar sanity test on PMU hardware rather
>>> than making assumptions and failing to boot.
>>
>> After looking at kvm_msr and kvm_cpuid traces, I see that Windows is indeed
>> getting #GPs upon accessing MSRs 0xc0010200 and 0xc0010201 but it is not at
>> fault here since it expects these MSRs to be available as guest CPUID
>> 0x80000001[ECX].PerfCtrExtCore is set. This feature bit should have been
>> cleared by QEMU when "pmu=off".
>>
>> It boots up when "pmu=off" is combined with "perfctr-core=off" and
>> "perfmon-v2=off". The missing pieces here are the following:
>>
>> https://lore.kernel.org/qemu-devel/20251111061532.36702-2-dongli.zhang@oracle.com/
>> https://lore.kernel.org/qemu-devel/20251111061532.36702-3-dongli.zhang@oracle.com/
>>
>> Dongli, Zhao,
>>
>> I see a discussion about compat array at
>> https://lore.kernel.org/qemu-devel/aUEXkDDOba+oZ4v+@intel.com/
>>
>> Is this ready for the two patches above to be pulled in?
>>
> 
> Thanks Sandipan for analyzing the issue!
> 
> Hi Zhao,
> 
> I noticed that the machine compat arrays are now available. Would you be able to
> send updated versions of patches 1 and 2 with the compatibility property you
> suggested?
> 

Are there any patches to test here? I'm seeing this on two different AMD
machines with libvirt cpu mode='host-model' and win11/win2022+, bisected
on fedora-45 to this exact commit. Machines are 10 years apart too so
very different vintage. host-passthrough (-cpu host) seems to work. But
virt-v2v spits out host-model by default so for me personally this is
causing some testing pain.

- Cole

