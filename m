Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930445A2A1
	for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014431; cv=pass; b=aDWHftPtxF8ci4jbMOM4Dqp8Fn0Qk523ndHL7i8EZWYfLmnZyXJgPlveqXOJKOIOSWGVPgxmVJkowUiq6HnedZQwZJnTUMAUm/ZG94qf3vTVZ1W5leHEOfDIJcpB7Pq6m0rnJnVFJf8t+J33onmIocrmYnQZii3iToSrrjin9kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014431; c=relaxed/simple;
	bh=MCaOs6wYNSB4LFrsDrFCk/QlJZrshEPv8X72I3y+9V4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfEv6SFTqlVOr59mKWeUiUwxGUDF2CnNOymUD/KKuvTK/mJ/q3Ppy2LC8FXIFOgpFgZaYlZSNFAwKDcU6RuItGgPiUDhIIWy/63iGdNRY1bG0+4PHjX16yd0nV0xRsT4vcjIJzFJWaUKFximEImY875Ox+Gl/Q9SKJUWGdShd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSlx6hcL; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSlx6hcL"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917aca1aee5so9470806d6.2
        for <kvm@vger.kernel.org>; Wed, 14 Oct 2026 14:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792014428; cv=none;
        d=google.com; s=arc-20260327;
        b=qofSD5rMBDQfRW96DzmG6UueC3z6Y09sPqbzZMOG2MvcK7I58cyKxLlH35Y+ARd+rR
         kHUyeW2sLs6Jr8Zzc3GUQuqdZBlpY/0Jf8pRvh8/fPu4XVrGcF/G2PFyxPDZC4X5yod5
         UUuL+4VNMBF5RvNUR1b6Y1v/xUAI8Hd/yP1vqJYRiXQ18U4D+zuDV5Bp02YWC0HEtDjM
         jstO7QKVQSLtRLJOw+IfhRKxWiQaFr6srdD0iDfjtB6El/iHzQwY1rwh/ufawEhVe8J2
         smLX2vBmO6EdMP9Cfu9JMJtXgaSuUyToi0ajKLg44/c1RsDKJ3efbPlye+TqNSvpw9hA
         ENLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OmdjCtO0BT/G+HosYDOiIQ+MFbY+P6PHIY8xmD++EWw=;
        fh=Y+3Wv818a4M51hFI0jGkL+NWAI3M9X7HeKtZFt37KJA=;
        b=hpVuRzJAqPgcGOACkiIXGdM70ffURbz9dCVgWw98cYgoQf84/rF3387M9SpiCqrKq0
         6g+QQfy908Wau9nEH0vexYlzRmUcv60ajUCtrLWnleGYycLkM7T2UCWnSpni4V2ZIubi
         06bgnOpM9EjzML9jJn7H8f+0PNHxDhgnEBTZR/CoQFVZ/Ec7OJCcxJMlZUXgEHg5EX9r
         +m6Viw5Er38BcVoI5eKOHBfAWXoL9iBt33peDN+ojJzzRm5iEZQcv165pODgwXgQF4uO
         zgzMhcuE82/aEtqMaynYFC5K2oGQ0ejfW0ry2OEesFX40M0bRJCtGRzPAWm1OJERjMNK
         tsBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792014428; x=1792619228; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmdjCtO0BT/G+HosYDOiIQ+MFbY+P6PHIY8xmD++EWw=;
        b=JSlx6hcLclOXuJ5rv3+BmT4OEpImG6UFCv/raPoxbZEOidM0DzSBwdQXAGriIr5Edi
         TX49nUQL9NtrVe4u+GPwa7n6xU/AhixY0AegBACIRbdRq28mgasEndHIualDvFy5LTPR
         Yd3gXeECBDYDxwABK6N/c2Y5Bd569usZ9CnVMiPRnI9BCDNLO669UbiMbWpWoG0hybMP
         Fg3j32XupqTXaDb2z4g+fRVyyR+vUo4P5ieSz11ab59S9VrUJWGyQvPd537Na+l0XY/n
         aR8oZ+YeefMeUY6gOU5UGsAW0Pf7GZUucXuC3HiPHqoHE81Qasn/aee2qAy7sGopm65T
         szew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014428; x=1792619228;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmdjCtO0BT/G+HosYDOiIQ+MFbY+P6PHIY8xmD++EWw=;
        b=VaKjzvgq+ux9zq28chx5mwCYiTomP+UGjnldum4G15Fd/AVgfliKBSBmMrc1YcQIwD
         KUhmlcwYcIRiEROhHog7XI3ggbdJLQzy4w9fBhLmiroYieTd/PAXWgPQT0Zz9Smddcec
         F7EiC7fctIQX16YYfe+5V+XC/lAMaViKyfqzxbQivrZxQZSUE7Z9UFR8NsP0Bf2xcPT5
         G7OmqpYayztvGCATxYFKioW5z3Q+Mdg9uohqtXIxRiZ/ejfkoEp5SANFVlkFR2w/OY5o
         +PhQm5hfqHLWZUVkk+WK9oUw9gkCYCuuZbitAGrnIz6HtZSl2lMtxioBqPb1E2tCnFRx
         Ei1A==
X-Forwarded-Encrypted: i=1; AKwUvBxhiWZyGq1Achk9b57qpZSqiLs7J+M+EmmG1LQb0yLm7H747mxzt8/zNbPTB9LbZ45ul80=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYm8wdz4KPFtY0HWcyacSc9elZvxLBFSxhZAzOqZv0SM5lYO+g
	CZPFJPTey6X/mrrGiyS5cHJ+1Mu2e+U1GQbndjxRufhCAGTVn5u5fVAa6z+Bhv1ixa99Tslrjmn
	yQClUlBdOAElHdcBCmLXLyPlBrP/fP5wiY8LTVUJU
X-Gm-Gg: AYBFou1rHC59BVtTdcaL/zFBuwi7vS40pLOhOsjZsg7P4mjK/NcQ9Sa+T+fRkZDILVx
	pQHzR5Kq1nsHm4QNrGYnxOWPZlF3C4ihaEum4RipFzN1wbTjqXu2UuUnK4t0Wi7n/eNLEfSXQN5
	LTHWB0Hz56mCofwR4mFHfR8l2nBiJP2rolLe6miEcS9LK84QPy5n+a8+GLkZBfRjbRPRm3HbgdU
	+x91O8JRqvxru9t4E2gWFTsYaon4jeL6zdeFBERq7yWGvutQaPEaj1wRyiW8twuougRKbd051Jg
	puzOBIFnQfKZFJEsatHtZCfutKkNZhMXOFdJ7FC0iYp3kC9c5b3qqZ6gm/0T0BZUFs5Jkm6Cg9y
	W9uGy3GsFiXw+ryAmAQeN9TrrC1Xg1v52/zsP0q5svAa8dRBHrPXN
X-Received: by 2002:a05:6214:43c1:b0:91b:8e06:73f5 with SMTP id
 6a1803df08f44-91b8e0680ffmr139578016d6.15.1792014427625; Wed, 14 Oct 2026
 14:47:07 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 14:47:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 14:47:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261014095702.39676-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com>
 <CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com> <20261014095702.39676-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 14:47:06 -0700
X-Gm-Features: AclHuK_bDoENPFsEJnePb9piUrHFuROo5b9vCnTZ7F3PMjuUH-N1Jl6pvQGbDQg
Message-ID: <CAEvNRgHtB8j6=9r=txjsKvQM0F85nRN4KW5sdnuv_-Og=cWEfg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> Ackerley Tng <ackerleytng@google.com> writes:
>
>> When the provider wants to revoke the page, the notifications/function
>> calls flow this way, the last [ENTITY] in the chain actually does the
>> zapping.
>>
>> + [PROVIDER] -> [KVM]
>> + [PROVIDER] -> [DMABUF] -> [IOMMU]
>> + [PROVIDER] -> [GUEST_MEMFD] -> [USERSPACE] (AFAICT this was not
>>   implemented in the RFC.)
>
> Thanks for going through it. I have just posted v2:
>
>   https://lore.kernel.org/all/20261014093733.90312-1-griffoul@gmail.com/
>
> It changes two of these chains. dma-buf is gone: iommufd attaches to
> the provider file itself, through a small interface in mm. And
> guest_memfd now maps the file into userspace from the provider's
> frames, so a revoke also zaps the VMM's mapping:
>
>   [PROVIDER] -> [GUEST_MEMFD] -> [KVM], [USERSPACE]
>   [PROVIDER] -> [IOMMU]
>

Thanks :)

>> IIUC guest_memfd conversions was not illustrated in the RFC: what
>> happens on a shared -> private conversion?
>
> There are none yet. Only VMs of type KVM_X86_DEFAULT_VM can use a
> provider, so all their memory is shared.
>

To borrow David's words, the part about this that makes me itch is
conversion. We have to support conversions. Even if it doesn't merge in
the first patch series, we have to have line of sight to how conversions
would work.

Conversion requests originate from the guest and then the host handles
the guest request by making calling an ioctl on guest_memfd. Hopefully
this part doesn't change with alternative provider support.

Suppose guest_memfd still gets the conversion request first, in RFCv2,
to reach all the mappings in various page tables, it would have to be

+ [GUEST_MEMFD] -> [KVM], [USERSPACE]
+ [GUEST_MEMFD] -> [PROVIDER] -> [IOMMU]

since guest_memfd must ensure no IOMMU mappings to guest private pages?
There's that extra step through the [PROVIDER]...

>> Does your provider need to know if some memory was transitioned between
>> shared/private states? The provider can be notified too, if
>> necessary. If not, then isn't guest_memfd doing all the coordination
>> better than going via the provider?
>
> Our provider does not need to know, and I agree: once there is private
> memory, guest_memfd converts the pages, so it should tell the others
> what to zap.
>
> I think the two models meet there, and the v2 cover letter now says so.
> The iommufd side of v2 does not pin and keeps no references: it asks for
> the frame behind each page, treats a page with no frame as a hole, and
> maps again on a revoke. guest_memfd can offer that for its own file:
> shared pages return their frames, private pages are holes, and
> guest_memfd revokes a range whenever it converts it, in either
> direction. That is your [GUEST_MEMFD] -> [IOMMU], and it should work for
> folio-backed guest_memfd without memfd_pin_folios() or refcounts, as
> long as guest_memfd also revokes a range before it frees its folios.
>

This part makes sense, if I'm understanding you correctly.

> The one difference is that v2 also lets iommufd map a provider file
> directly. Going through guest_memfd would add nothing without private
> memory: it would only pass each revoke on. And memory that only devices
> use, such as MMIO, does not go through guest_memfd at all. Both paths
> would use the same iommufd code.
>
>> Does the revocation model work for you? If it helps, I can rebuild the
>> sample provider to illustrate how the revocation can be done.
>
> Yes, the revocation model works for us. v2 replaces David's sample
> with one that moves, donates and makes pages read-only, and a selftest
> that checks the guest, the device and the VMM's mapping after each
> change. It may be a good base if you want to try guest_memfd as the
> provider for iommufd on top of it.
>

Thanks, I will prototype what I have in mind too to make sure things
work as I think they will :)

>> 4. [DIRECTMAP] Kernel direct map.
>
> Agreed, that is separate. The memory we have in mind is a range hidden
> from the host with memmap=, so it is not in the direct map.
>
> Thanks,
> Fred
