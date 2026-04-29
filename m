Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6523750B9
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457726; cv=none; b=dLWTSfHHfYaAUjTf2YWvPi0eOqBQGEXeNBrtpnj6FAlpjIy//0ayynkLL1PdQjJaxkzk9dXyDFrx8ZnGWDAYt2alHQ+Ky0Ah5XMT2oQ1Tl9CaS1k78eVPxu7YIR7nTkqtv22YjuDha7rBXkgidr8OymfdC7ConhPKhh7cfMpfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457726; c=relaxed/simple;
	bh=hQug3qkwF07/UwbNYXE2gQIGd7kBMCi2EgqyXQ+NWKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5+AUHFHqj81X9WDx2lJbR4lFe4eIrfgghkFhoyFTDkbXhADzaxmiDNXtR8Z3tKIgaC4VA2RCfskYBNtmrXvh5mg9n8WVl3cflNLXwKRAeoVgfUbalxrZ8AnGp0ZBB3PP0xqvGoRcQG+1CoFtnu3n7u4YmPhRmoFuX/PPFO5ysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kX0/Nff3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kX0/Nff3"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 63SIj9oP2319541
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:15:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ly8JAFvIw75h5tYXkVpwyGwZpL0+gkqQbMxNXD6jLUY=; b=kX0/Nff3iVch
	xvLKyaXFI4CdPx/BZom54wnHCQLL56keHS+vRQXeJnb8NRRAjyb2tk19UKjkRg/K
	eFu8yrKmg3nux7wJkEGSXyHlsyziMeYkgyfLc2eX4eYCNxTq6uoONVU2iIN8GU8/
	hIv9Y+iVJooSxr/jlAiuPz9SckHVNeIyeU8QkRO3FPTrJIsVF4b5hr43EeQZYwCU
	mwVSVhGgjWeD1desHOxSWbybytc3WEvUh3x2KGoS/PVuCtMxE6O4RqsQupBZbV//
	nV+Mt5gcDtVfXJaL5Njl6xr5nCMpDvPdOYGWPQZUCrgiK9eTA6b2KbLY4mvogRxW
	Y/wp9O8qjg==
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	by m0089730.ppops.net (PPS) with ESMTPS id 4drs3s9esk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:15:23 -0700 (PDT)
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837b6f6b93so135264375e9.3
        for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 03:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457722; x=1778062522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ly8JAFvIw75h5tYXkVpwyGwZpL0+gkqQbMxNXD6jLUY=;
        b=T11biOxQy57XhHnm/PwZ0LOMC5MhHd12/MoVI2SgkWVP+pJfRNWCkNnviVC4E3hMVP
         MwQ7MnDAEzBkLe8NeLSxMzMRuky44yjpVmhdXCNZMzVhcziIPVYgJjXwFvKhAkb+tpyq
         /PqNItiedbJnYC9uAXMN0wbbnC8HKARp8zqKJQtbd3EcR3hpn3Zsgad+WIjUwyBNzio3
         dir8pdM7WwTBoSiW0+3RQhYpePIXXQKixJ7GgTHEDYonyAga6EWpZvKlypdYy47mK8Bs
         A6VSCDOS7B7k9/sIigL0Pt1EgyLtIK2NzS7D70MOheXSr8CEYS0qW7N+22eVFZr0K6QR
         z7RA==
X-Forwarded-Encrypted: i=1; AFNElJ/4onSeZXtgMOWp0XoY/YZ+1w+6l+mw2Xu81IaR2lgzPBvC/8PbjzL7/VjzJNiiqbpc+HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT/+2s2kZQyCnaU4UiOpVgWssqYrwUvtRQeBSplLkpng4Cb6m9
	aRUBTMOU9WpBhf32GrpVCB4RuNFqEbfGxS3M+K4VqP6HZstOezEQYWXW3hAcWryW+OgVA2YgJKJ
	wa13zQ4wT5ZC3hj0efxCFdRmGR19QbxCHg2D7fiOYtki5j9KszAfI
X-Gm-Gg: AeBDievcCvHjOUXmB4ThiJGrjaHABVRUgi0YG3pbcqWE2nHj5Mx8JD9BaLpKuff0CkO
	kXDYreocUy1Nw98sq3zjWTr6GVIbGmShgXcVe2wV/wVCo264r8SAm46PmsgKO3yAZGnTki0x4lY
	TcvXQef5vbCnHa49DV6PuUl4CfjV27hOEBQ3p7BzBsjAxpH0mYeaO8dWnbaQiY4ncev3EDakKvL
	tc++xHg6Ukd/aIk0b2HkygoaQd6Jx4z8FQAiS+S96ypNDPBjolOKetgfSrf3GmmnBZPGhiNXJcH
	eNT9uczjsdAasPbq3nN75xh9ZHJsqr0pa4HqyDG2Z+anmpO3F1Ym1Tj6rzM2DL6QfikqtP+nJYT
	rL5tBTLxfGly2i/GWVWWHke0OZSxC9bpcevtohdMVegAfgDFjKmJUNO5lEaahD49UWkP++nX9/g
	==
X-Received: by 2002:a05:600c:3e19:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a77b12a61mr119915995e9.14.1777457722281;
        Wed, 29 Apr 2026 03:15:22 -0700 (PDT)
X-Received: by 2002:a05:600c:3e19:b0:48a:569c:abab with SMTP id 5b1f17b1804b1-48a77b12a61mr119914095e9.14.1777457721719;
        Wed, 29 Apr 2026 03:15:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:18:b9f9:127f:ecc1? ([2620:10d:c092:500::4:fbdf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b7ca5fe6sm5126538f8f.32.2026.04.29.03.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 03:15:20 -0700 (PDT)
Message-ID: <bac93215-c781-42ef-b5e4-3d5d71dc5503@meta.com>
Date: Wed, 29 Apr 2026 11:15:17 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] vfio/pci: Set up bar resources and maps in
 vfio_pci_core_enable()
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-2-mattev@meta.com>
 <20260423153053.6833135e@shazbot.org>
 <729d6593-f88b-42bf-b3a0-8c364d9ca5b4@meta.com>
 <20260424112007.592fd6c0@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260424112007.592fd6c0@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cVsQth2ChQD1pwyH_by5igY90LO7043G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEwMyBTYWx0ZWRfX46HcLxkDDVkA
 UoQC7lp8WWWEYjcAvUWofblKu1uy+WfyowKrFgAkN73+cIQ4FQVrggTqmPLi4G+bN7sdJiidyQV
 z7Ca6ICwhEtiRYJyRfYNdm9H6UvAXQUFzEaCRXMtXa0N5+5EMGYLNJanlY2GBP1zQDNH1SBLNgu
 Q2NLwm1kMZCmZGpVDYyMlKHAN4S740ovAv8Ox0OcL/ODSmlF419jPMDv3MZzXODdbD/VAeduP3+
 76EHpcDe/ROXX4nfqy+dFHk63LMPL9f6LPUGf9lhHDQQ7YxY6XKCNDfKNdCoom1u7O6e9NcgpMm
 CbmanKvUfHvJ+jeUvinpEg4rI4mSgQfPAmf/QR7LUkeRKUwzzfu/cwTXVV+usWEegualcg+syyZ
 r/mPCQHDJ0RflxxvQrXfHwmUd97ZdeMJs6vB8jQqB18aAZVCCVP9ujYykwlb65uCIEmhvuovRAj
 BevZCRuAvj6Al0K2d4g==
X-Authority-Analysis: v=2.4 cv=DdonbPtW c=1 sm=1 tr=0 ts=69f1da3b cx=c_pps
 a=IwH782EDBk/vqbJ9rM8UFw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8 a=OKIG4whRnQEbbrv9YZ8A:9
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: cVsQth2ChQD1pwyH_by5igY90LO7043G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01

Hi Alex,

On 24/04/2026 18:20, Alex Williamson wrote:
> 
> On Fri, 24 Apr 2026 16:15:06 +0100
> Matt Evans <mattev@meta.com> wrote:
>> On 23/04/2026 22:30, Alex Williamson wrote:
>>> On Thu, 23 Apr 2026 11:25:07 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>> +
>>>> +		if (pci_resource_len(pdev, i) == 0)
>>>> +			continue;
>>>> +
>>>> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>>>> +		if (ret) {
>>>> +			pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
>>>> +			continue;
>>>> +		}
>>>> +		vdev->have_bar_resource[bar] = true;
>>>> +
>>>> +		io = pci_iomap(pdev, bar, 0);
>>>> +		if (io)
>>>> +			vdev->barmap[bar] = io;
>>>> +		else
>>>> +			pci_warn(vdev->pdev, "Failed to iomap region %d\n", bar);
>>>> +	}
>>>> +}
>>>
>>> I see you making the point in the cover letter about the resource
>>> request vs the iomap resource, but we currently handle these together.
>>> If either fails, setup barmap fails and the path returns error.  I
>>> don't see any justification for now allowing the request resource to
>>> succeed but the iomap fails.
>>
>> The primary effect was to let consumers see -EBUSY for a resource
>> reservation failure or -ENOMEM for an iomap failure (whether through
>> this patch's vfio_pci_core_setup_barmap() or the next patch's helpers),
>> and that keeps the error signatures identical.
>>
>> A weak secondary effect was that a BAR that gets resource but fails for
>> whatever reason to iomap it can still be used by most clients (assuming
>> the general usage is to mmap).  The system's pretty sick if this is the
>> case, so as I say it's weak.
> 
> Right, I don't see that's really a necessary add at this point.  In
> fact while we expect users to access through the mmap when available,
> we don't actually have a way to specify that mmap works w/o read/write,
> which is effectively what this proposes is a valid state.
> 
>>
>> OK, if you prefer the combined approach and don't feel the subsequent
>> single-semantic check helpers (need mapping, need resource) are clearer
>> to read then I'll recombine them, though:
>>
>>    - If vfio_pci_core_map_bars() just sets barmap[n] iff both resource
>> acquisition and iomap succeed, then a later check can only return one
>> error from either cause.  I'll go with -ENOMEM unless you prefer -EBUSY.
>>    Using something else can again make userspace see previously-unseen
>> error values.
>>
>>    - IMHO vfio_pci_core_setup_barmap() should still be renamed (in a 2nd
>> patch) since it doesn't do any setting up anymore.  Cosmetic, but
>> cleaner to parse when the callers use vfio_pci_core_check_barmap_valid() no?
> 
> I'm not sure how important it is to preserve the identical errno, but
> we can actually do that too.  Make the enable time "setup" function
> store the ERR_PTR in the barmap and change the current callers from
> "setup" to "get-iomap", where get-iomap is a __must_check return that
> callers test against IS_ERR_OR_NULL().

I like that!  (My mental model of ERR_PTR was one of function return 
values and must admit it didn't occur to me to stash one longer-term in 
barmap.)

> Or maybe better, collapse NULL into -ENODEV so callers only test
> IS_ERR().
> 
> There's even one user in vfio_pci_bar_rw() where this provides a minor
> simplification.  Likely the others are just wrapping the get-iomap call
> in the ERR/NULL test to get the equivalent behavior.  Thoughts?  Thanks,

Just implemented a vfio_pci_core_get_iomap() and I think it's a lot 
nicer.  I also prefer the helper returning the BAR map pointer rather 
than the open-coded vdev->barmap[]s.  I've moved the helper [back] to a 
header, since the additional index checks will then fold out at compile 
time in some cases.

Thanks much for the suggestion, posting a v3 shortly.


Matt
