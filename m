Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1953D646A
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109021; cv=none; b=WeyyrnCQoKpZejzBOdqEjOua0eTTwXoYfViPDbXTYNFLgPCZIzh/9BWf2Uaf+gOLg8K1z6nYAqw2+9WVyGURhjONhUbHRHcVw2ieuib5F6i4OtfiZQwHAPJ7pEeLftckcQoW2KPXetoVtoR/PTE03zUMVr9AU1oYZKdehhyNxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109021; c=relaxed/simple;
	bh=T6VtFxXHRKl0kyStfDGKQfjExmlyrvxWmXQsDCQktZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqyMcR9lXumyatoCh9kWi7Mixn54JOgJ5aGsbKoWyUUfUw2w47hTHpRXzLlWdnaHoY9AaB/2CK4p1xK6ZWmzm9yGcWVSXwEsuoUwi8IvMsLkVOk1dC4to9OqYU6xP24gOy92+RPXIQ5yOURZlHOr4D++6uyYO/TYL+lERE4XfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3I+5OIw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3I+5OIw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba0714574fso11435815ad.2
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779109019; x=1779713819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEvRUNdUmhBQ0s2ZG+DQWv0U3vfaEq9qsJLKNdQLrRk=;
        b=T3I+5OIwDGZHiVqHOAf/leqbKWQMWJyCGWJfkp2c7/EUmsQrB/3TwWR1EuLuQXRAb8
         yuT83qLiE3MyZMtudlcyYF9cxn8O3cif1dPSG+ogpWK35oFEnltlrogf73U6vmtDczTB
         vbFlyt8i9amj+JveQxYvnfBdR9DDiPfP9TVPPb4ajv4asl/PwCbyeduxICgIsohtWBDT
         70XWEf31mta28hpgdICgRO9g4Gh7mwj1jCedKbxarPe1XARQ+XnrWQZqGqFjU0EB/c6u
         /JwMafoBKhWucki00lAR05PVsBqeZqzhFSBd2iUogT57E1Gkx4yHYsPcwpSJKzNyjtse
         05ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109019; x=1779713819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEvRUNdUmhBQ0s2ZG+DQWv0U3vfaEq9qsJLKNdQLrRk=;
        b=ss25gVVfXWdi3OkBnwTzAvB9iZJOncqMXZp9QCimzZ89Zj4adk5o2CQDENw2d8wn0H
         V9j6hZkeKdKFl4SwC4IFm1YdOceTIm+K5p76DmPc+fi1oKhP2jNzZltrN8HbRmoF2NRd
         mxXVwUdchQ7XPife6sxxyp1Iw4mNb8fgrjY5eawK998f88ADbUlOFb4yc3nWw9JZoNV6
         9DbKzwVGFLMTHIDTnx7t6S4yoGugJO3Lkj9iIdCoYZZVaE1VwA8ZC8vBRlDxvc08bZX8
         9hGBQ9vWxx0zm2X+PvEkmXMFFZQHdt+e3qZxg3/ko9BUM05L3HILyGE73pB4XsR7+N4w
         DnSw==
X-Forwarded-Encrypted: i=1; AFNElJ/34vEwpHBQgjtDpVGPMjPJ8Z8DY8U5nKoEj6GIQVo1wD5HCg1V81LhxKqeZmbKf+vInEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4v9vJqWCUv1td9aetPdCxAj/MOQF9rAQOLCgIQlP19xmzv0c
	vFKFomnCUEldDag105a8o9Oig5p6mieKJrtMes+HkosCxlVVRAVHyR81gq0EmF0y
X-Gm-Gg: Acq92OHa+h69iOcf1GLiiCSbUDETuvz/UbbQqAOGPEtNNJ1UnVrnzmiFhz1wKUeAC1u
	Fw98/BttRTLS2VDwL3TQsDp1VfoP5nZ9FIHOPSMUayRsR3ij7BEKJQTVL7K+tXESvQx55FlvJNm
	tp5T7ir0iU+l0sjo7OCN76mNL4SFjoOH3yoWExuQ0gLur53d3kSop9Z00//Ugf5bDr1fmrTcomh
	eE5Ikieu3vlBZHjO5yp7ef4wHfO/L0JfGaGILxils55f7TdL4BcrnKiBgI3gLOK0YGmjJb/drqU
	SUha8BR3RzEIOLnf2Ox4T5zY3lv/R5Fd3/MgfNG33cYRqxQUiHwEVFjLc9VAlBk8QL70NYV0icU
	SY7poQ+J9NVE1eTsV//9nOOzIkN48kR+yeHYVLK9BHXfX7AdECsAo1zcR4vzGIYiD6m7in7klGx
	J3F1gshvnw+vQgK0OQfCjdhD0rdDrcjT1IxyGCEQ==
X-Received: by 2002:a17:902:ebc3:b0:2b0:6e6a:8504 with SMTP id d9443c01a7336-2bd7e973c40mr165865855ad.27.1779109019087;
        Mon, 18 May 2026 05:56:59 -0700 (PDT)
Received: from [10.4.95.45] ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5fb35sm147385985ad.12.2026.05.18.05.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 05:56:58 -0700 (PDT)
Message-ID: <ccae4c1b-719c-4bbd-9f2c-251364fa4fb3@gmail.com>
Date: Mon, 18 May 2026 20:56:51 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: irqchip: KVM: Reduce allocation overhead in
 kvm_set_irq_routing()
To: Sean Christopherson <seanjc@google.com>,
 Yanfei Xu <yanfei.xu@bytedance.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, caixiangfeng@bytedance.com,
 fangying.tommy@bytedance.com, isyanfei.xu@gmail.com
References: <20251226062741.4014391-1-yanfei.xu@bytedance.com>
 <agdrZMRR7oDKZNDK@google.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <agdrZMRR7oDKZNDK@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sean,

thanks for your review!

On 2026/5/16 02:52, Sean Christopherson wrote:
> On Fri, Dec 26, 2025, Yanfei Xu wrote:
>> In guests with many VFIO devices and MSI-X vectors, kvm_set_irq_routing()
>> becomes a high-overhead operation. Each invocation walks the entire IRQ
>> routing table and reallocates/frees every routing entry.
>>
>> As the routing table grows on each call, entry allocation and freeing
>> dominate the execution time of this function. In scenarios such as VM
>> live migration or live upgrade, this behavior can introduce unnecessary
>> downtime.
>>
>> Allocate memory for all routing entries in one shot using kcalloc(),
>> allowing them to be freed together with a single kfree() call.
>>
>> Example: On a VM with 120 vCPUs and 15 VFIO devices (virtio-net), the
>> total number of calls to kzalloc and kfree is over 20000. With this
>> change, it is reduced to around 30.
> ...
>
>> @@ -186,6 +175,12 @@ int kvm_set_irq_routing(struct kvm *kvm,
>>   	new = kzalloc(struct_size(new, map, nr_rt_entries), GFP_KERNEL_ACCOUNT);
>>   	if (!new)
>>   		return -ENOMEM;
>> +	e = kcalloc(nr, sizeof(*e), GFP_KERNEL_ACCOUNT);
> This needs to be a kv flavor of allocation, or maybe even just a "straight to
> vmalloc'd" allocation.  With 20000+ allocations, that means an order-BIG allocations.
> So kvzalloc_obj() or kvmalloc_objs()?

Agreed, will switch to kvzalloc_objs in v3

>
> And if we're going to allocate one massive array, then we definitely should get
> rid of:
>
> 	/*
> 	 * Array indexed by gsi. Each entry contains list of irq chips
> 	 * the gsi is connected to.
> 	 */
> 	struct hlist_head map[];
>
> and kvm_kernel_irq_routing_entry.list.  It'd be easier and faster to have
> setup_routing_entry() simply iterate over the array.

if we get rid of these, we need to add a new field to record the offset 
of entries
belonging to the same GSI. Compared to the hlist-based lookup, I am not sure
this would yield a clear gain. Seems hlist feels more straightforward?

>
> Something we should look at (on top of this), is caching the previous routing
> table.  I.e. instead of freeing the old table, keep it around, and try to reuse
> the old table on the next update.  That would allow eliding the alloc+free
> entirely when userspace is changing routing, but not adding or removing entries.

In our live-upgrade scenario, userspace incrementally adds entries via a 
large
number of KVM_SET_GSI_ROUTING ioctls, so the cost is dominated by the
cumulative overhead across tens of thousands of alloc/free pairs.

Per my observation, the per-call alloc/free overhead is fine; it's the 
cumulative
cost that hurts.

Thanks,
Yanfei

>
