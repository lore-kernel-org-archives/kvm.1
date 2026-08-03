Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E11414DC9;
	Mon,  3 Aug 2026 15:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770288; cv=none; b=M3S5kVjfrrlyde7o0AIzUnwT7YplVGHdkoclsJTOJtnYGzQ8hVc2e8K+PlqngY7Sj5JdZ2I1fsG4GKTxc1drz1Tsz1AYrzlGC2NpuQHQy/S3QGq3xZa4jpbty5vydJFNEoqrTcsf5SEX0uapz7KZ0vuBUKquAC4tuIOSx6D4WSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770288; c=relaxed/simple;
	bh=2g+SNEeTnek6IbpK0I/48mxGwhxbIZV8V+RfVNSddK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvkEynTmWh/gNviZXYnRDhcn8MFButAvkGbJIbPhq2OFJZOoKBwJO2MG+x1k2+LzsHaColc57MDjWy3N2ZycJMbHcD1Gj44AkCUV5dNQ1Oll/vhqCiPb5zkKhkHUm1RZN30zb7ZgCvfAtemReCTv2ok2SaUpybDPOU6eTo2HHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVC83b50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVC83b50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370291F000E9;
	Mon,  3 Aug 2026 15:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770286;
	bh=IBs90xPnuu0V4vajTYaXqT/VGt0KiwQg3a93xm5Yebg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FVC83b50kI9fTgdOqjSt0kDMiYCj/7+sPjR1D4ltQlsM5JqgXGLHiqA+sTdxfUykW
	 utGrVdpgSobAFwfjuGjPOa6a8rKOJBlYKACGKVb7ZvKG3ktxfJbmL6WTpUdLX9H9b4
	 /oBX76rNcPEsARP31BVj2gDbh2fYzgX2OB4VQMTUwjitUnWdO36LRb94iB2kWEwwJ8
	 1n8ysI1hdpKmjOkXc73kYthtoJ12Qaq/4U82hqEzXXFgumMGTeHlLokAKPRherE8Uk
	 wP30lvOKLLiDtINvFwaDBGm9GzOJv6p1xJE9eJj85Zh5T59JVzMQqO4HjkFeCyg7mu
	 SFAeUbpvmF0nw==
Message-ID: <f556ae97-efaf-4e7e-b4f0-0f90087c8555@kernel.org>
Date: Mon, 3 Aug 2026 17:18:02 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/3] mm, drm: ensure .fault() does not have to be
 followed by .pfn_mkwrite() for write faults
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Michal Hocko <mhocko@suse.com>,
 Sergio Lopez <slp@redhat.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, bcm-kernel-feedback-list@broadcom.com,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <20260731164341.1109827-1-pbonzini@redhat.com>
 <8d94897f-0f56-4ecf-bcc8-50bffd6750b2@kernel.org>
 <58fc5ce1-b6f5-48df-bd3b-054443c60cdf@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <58fc5ce1-b6f5-48df-bd3b-054443c60cdf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/3/26 16:19, Paolo Bonzini wrote:
> On 8/3/26 13:54, David Hildenbrand (Arm) wrote:
>> On 7/31/26 18:43, Paolo Bonzini wrote:
>>> Warning - DRM parts (i.e. most of the patches) untested; I have Cc'd
>>> the reporter to help with testing these patches.
>>>
>>> Right now, users of .pfn_mkwrite() have no way to create a PTE
>>> that has gone through maybe_mkwrite().  Because vma_set_page_prot()
>>> will have cleared the writable PTE bit, users of fixup_user_fault()
>>> will see a read-only PTE and have no clue that the page needs
>>> a *second* fault to reach its final status.
>>>
>>> Handling this in fixup_user_fault() is problematic: the information
>>> about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
>>> which is an opaque pgprot_t, therefore only follow_pfnmap_start()
>>> knows how to retrieve it.
>>
>> How is mprotect() supposed to work in that case?
> 
> Hi David,

Hi!

> 
> not sure what you are worried about specifically, but fixup_user_fault() catches !VM_WRITE VMAs and returns early (see vma_permits_fault()).

That part is clear, I was wondering about the following:

mprotect(PROT_READ)

followed by

mprotect(PROT_READ | PROT_WRITE)

You'd similarly end up without the writable bit in the PTE, and apparently there is not really a way
to recover from this.

Maybe that's just ok (just sounded odd :) ).

> 
> Also, do_wp_page() has the comment:
> 
>         /*
>          * Shared mapping: we are guaranteed to have VM_WRITE and
>          * FAULT_FLAG_WRITE set at this point.
>          */
> 
> before the call to wp_pfn_shared() which is where .pfn_mkwrite() is called.
> 
> Let me know if this was not what you were asking.
> 
> Thanks for the review of patch 1---I mentioned here in the cover letter that the name was temporary and I'll take your suggestion.  I can either use EXPORT_SYMBOL_GPL or switch to inlines, but not
> both because the existing functions like vmf_insert_pfn_prot() need to stay non-GPL-only.
> 
> Anyhow, now that the series has a Tested-by I'll clean up everything, and repost later this week.

Thanks!

-- 
Cheers,

David
