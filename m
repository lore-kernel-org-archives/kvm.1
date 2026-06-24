Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94071288C30
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 23:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342038; cv=pass; b=YLzBv3uzx7fZ5yEo+5rdS2AdhMGveXIMVPNQPSFcrFTkaMVyFFtiXvxpnuK+RE5o8gc85rg3zR+dXlIVdJgtip51etNJqmGM718KJn9xApoae1PlRZUkJ8lVPTpQzJONN6B1hKSdoMhTV0dUwqi1/cy68e4vInahWAqWPmyPf3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342038; c=relaxed/simple;
	bh=IqPLVwsO0D0MZhplC6ajaXmgltfNbyg+xs7Qj1el6YM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P30eIaEEJR9OJS44puu/XlJE7U7tG4hRE0SlByNjoxnP2tpDyLte3594lR+1Gn5FFZcbAns5mFOpM7bIwWJ/oNG4PfMYPedJ/bM5z2tZn4Kk6Jy7HFU7B4QOl7O/oh4cEho77LWQloDeFlO4eze0mFYGHbvgpo7i+5uFxDc8JVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2EC3qjj; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2EC3qjj"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-139a5f4ca15so1825052c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 16:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782342035; cv=none;
        d=google.com; s=arc-20260327;
        b=NIWpXIqn+HiNT1ORw9nMRVkLJOzt+WUyX2oXxtm+QIPl7NYhI4t5XOGevWMihrt7ot
         cZDQirjN6Ta6J74FdPsVy1s1qBsoRC8NeiJHpLX3+S/NzjPPmdQGAVakKKOoclRPJvqc
         /Q3UR5GsbUJAlUyRafjTFW5aPjpRPD6JSmWa3kvyU2m72TY/mAC90GBhBYAV3LrZ1SHz
         vpu9YPR6Hqid5EiMbH07e/d6C02KKYI2T3qWc7MD0pkA4EkLF44u2HdQZYgp45rh/9nU
         f/MPfpXRpXPc0m89Ms/R1/hYtW7gB4DjQ24KBdq1Cy3+Rv6cdb3aazE+/vmmgd2fXGsY
         CAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uiDSxDdQCuoFNlxYLhHEIwl1aJFHoLPbVFXDv4LT02c=;
        fh=+tdIj+wAefPMPTSBwIfEWCxhLyvhDg/OASCvuJ/zOQc=;
        b=cQo33FoXCr6cktcVtOoM/qBVEWoYf1GitZDpdPMXK5PDNP8+uH0W7EROWJUodfcXgX
         6ZAuPNc6+smLgW3EjGGIu9W6xdd+NN0IQjKHRvz0WcAzar5edSMOUmzR/K0cH4agGvy2
         Nd182egkI4lJigg3uZSao7kzM8+7xI5R+lEOIBhv75jSlju2WILk1tEEu8FKsmfOAMOW
         VSE/1zBG8lq2BV0XOig/T0enZjQWK2h9EeX+oWGIvDeTd0yMYzUjxygQaSxnGHaFhYrL
         miL7349ABxNTAH8c8SXNR2MIkiC14tkrP4/qO70Pd8VEYLfiwEv4v5ov4yaNhUqAyMeq
         o4ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782342035; x=1782946835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uiDSxDdQCuoFNlxYLhHEIwl1aJFHoLPbVFXDv4LT02c=;
        b=c2EC3qjj7Ho+XyzOWWSriQVBShOkmXct1jUKlwr5G0BN3dk1Nrg+m9xF8EW9ds1mHO
         POmbN5gIAuSj8Dzj68e5V9/j83y6e6bXak2hEblXC06jGjbR+eP/5H4RVH2KIwxUPpEQ
         U2yt89KIDqQOmIu53mbOOiudxfdAEDIjginbIvBHO2hiX8RqK3LzguzR9nqrX4QO+UHU
         k6Mq5fmnoNklvcg4CNb9LY3bOHv83j63fPjrOG7psVBxYYm5IvR+KJNk+idTznszqznx
         46BgvajMCK4dIt/ugI2f/DhtSLxEG6r5fn2uCscS8vKrAQT+lKOASUIUR6pE5C+ndo31
         elpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782342035; x=1782946835;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uiDSxDdQCuoFNlxYLhHEIwl1aJFHoLPbVFXDv4LT02c=;
        b=LErQdwW1sDvNbpgtt4HtgtaZAKxi+Pm8i/VSlZ8Rb6BmT3LbicFbHDHnD66yvcyFJm
         1SwiXiTek7/yqN+VxlVocXI1lv3h+ocN4rKSbWUD9tr5M/8kxyWj7Y4ARTSX2eW+pHgJ
         rnMkVfrFYaAtWYOkr6qhRlTVvnRwfIXX16tF7XlFQBlJHiEybeEr60s19BNb2Wd9UqDk
         dwF5oDV1KgvT0Z5u47bqB2XROlxq/OWlIAuSRSUCFu7HS6mLpEYzQgfB0vsKxx8/GP4H
         TlBPwnLXbFsboqe/F0pWjnAcc7SNeAdw/upHbmoSKUoX1A9TO+DLl+x3BUkfHLodMJQx
         nDxg==
X-Forwarded-Encrypted: i=1; AFNElJ/l5hyxXhaWbR9w5tXjpwcL377w7JkmMIQe6OV0s41YFQCmOpn2oNC59rxW8cEhPhasdSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfJStjAjlfxJHafvDP6PaWOAaN3rgLuar6v3xDa8T0q4v+1FT
	sixywUnl6MMW00nOj6iWfI2QCJb/SqFvtmAj0zBIZm5UUhApojM39MAkIVmvDFiYw+HchunEFgq
	sZJCXQflrpV16t5OsZacxtj3R1fFKG6cqItDzK2fS
X-Gm-Gg: AfdE7ckgxB5x74UUjblp32Jes3EDjGt3YvwrsC9MN0eZ07SjkLV9y0rcKat7+pZY12/
	CTQHowYVPPhEhI8ut9rT4dKtIl6SP3Hyk01Vf9Ehc5X9FyjIdvMdU4TGQ2j7q/Km3Qp9OBgvbBj
	k7lH6CPFDNdgJdeA3m96edFZt3+CH0wev/HNZTnI0wV5skF7sdhOQHfGiAVJPYI6sQ/ffbKzZjA
	Tr2J4MuTvoRd5ub9cr3mjrvDPi+NB+3e2Sa2afe+MJav7kMIR0VOBD+ERmOJqsLnWpMSlJ7ddly
	lzcbN3ZRTtOjt2NJTANt0kLiQs3G+vfuWHnEOcwVUHtlTSVak9JaJnwxB4UCbXWhrIof/Q==
X-Received: by 2002:a05:7022:160a:b0:139:cf4f:3b80 with SMTP id
 a92af1059eb24-139dbb1250dmr40215c88.34.1782342033417; Wed, 24 Jun 2026
 16:00:33 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 16:00:32 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 16:00:32 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajxasFBzp_9KnQLq@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com>
 <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com> <ajnf5Z9nWZxoLS4x@google.com>
 <ajoWngKaZ+wfIyR+@yzhao56-desk.sh.intel.com> <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com>
 <ajxasFBzp_9KnQLq@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 16:00:32 -0700
X-Gm-Features: AVVi8Cd6MsvMJuk5LYLyYsxDOenZ5WDyms3uLYv9lo6HnpeNhZqAtHcdl1tcM3o
Message-ID: <CAEvNRgG1nHipzw4=eBgwhvyXi8xYo7FQD_sy9Ax6FDf7YDu3Og@mail.gmail.com>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
To: Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Jun 23, 2026, Yan Zhao wrote:
>> On Tue, Jun 23, 2026 at 01:16:14PM +0800, Yan Zhao wrote:
>> > On Mon, Jun 22, 2026 at 06:22:45PM -0700, Sean Christopherson wrote:
>> > > On Mon, Jun 22, 2026, Yan Zhao wrote:
>> > > > On Thu, Jun 18, 2026 at 05:32:00PM -0700, Ackerley Tng via B4 Relay wrote:
>> > > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> > > > > index ffe9d0db58c59..56d10333c61a7 100644
>> > > > > --- a/arch/x86/kvm/vmx/tdx.c
>> > > > > +++ b/arch/x86/kvm/vmx/tdx.c
>> > > > > @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>> > > > >  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>> > > > >  		return -EIO;
>> > > > >
>> > > > > -	if (!src_page)
>> > > > > -		return -EOPNOTSUPP;
>> > > > > +	if (!src_page) {
>> > > > > +		if (!gmem_in_place_conversion)
>> > > > When userspace turns on gmem_in_place_conversion while creating guest_memfd
>> > > > without the MMAP flag, the absence of src_page should still be treated as an
>> > > > error.
>> > >
>> > > Why MMAP?
>> > Hmm, I was showing a scenario that in-place conversion couldn't occur.
>> > I didn't mean that with the MMAP flag, mmap() and user write must occur.
>> >
>> > > Shouldn't this be a general "if (!src_page && !up-to-date)"?  Just
>> > > because userspace _can_ mmap() the memory doesn't mean userspace _has_ mmap()'d
>> > > and written memory.  And when write() lands, MMAP wouldn't be necessary to
>> > > initialize the memory.
>> > Do you mean using up-to-date flag as below?
>
> Yes?  I didn't actually look at the implementation details.
>
>> > if (!src_page) {
>> > 	src_page = pfn_to_page(pfn);
>> > 	if (!folio_test_uptodate(page_folio(src_page)))
>> > 		return -EOPNOTSUPP;
>> > }

Yan is right that with the earlier patch "Zero page while getting pfn",
folio_test_uptodate() here will always return true.

Actually, this is an alternative fix for the issue Sashiko pointed out
on v7 where userspace can do a populate() (either TDX or SNP) without
first allocating the page, with src_address == NULL, and leak
uninitialized memory into the guest.

Advantage of using the uptodate check in populate: if the host never
allocates the page, populate doesn't incur zeroing before writing the
page anyway in populate().

Disadvantage: Both TDX and SNP will have to implement this uptodate
check. guest_memfd can't check centrally because for SNP, for a
PAGE_TYPE_ZERO, !src_page should be allowed with a !uptodate page since
firmware will zero and there's no leakage of uninitialized host memory?

>>
>> Another concern with this fix is that:
>> commit "KVM: guest_memfd: Zero page while getting pfn" [1] always marks the
>> folio uptodate before reaching post_populate().
>>
>> [1] https://lore.kernel.org/all/20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com/
>>
>> > One concern is that TDX now does not much care about the up-to-date flag since
>> > TDX doesn't rely on the flag to clear pages on conversions.
>> > I'm not sure if the flag can be reliably checked in this case. e.g.,
>> > now the whole folio is marked up-to-date even if only part of it is faulted by
>> > user access.
>> > Ensuring that the up-to-date flag works correctly with huge page support seems
>> > to have more effort than introducing a dedicated flag for TDX.
>> >
>> > > > Additionally, to properly enable in-place copying for the TDX initial memory
>> > > > region, userspace must not only specify source_addr to NULL, but also follow
>> > > > a specific sequence (where steps 1/2/3/7 are required only for in-place copy):
>> > > > 1. create guest_memfd with MMAP flag
>> > > > 2. mmap the guest_memfd.
>> > > > 3. convert the initial memory range to shared.
>> > > > 4. copy initial content to the source page.
>> > > > 5. convert the initial memory range to private
>> > > > 6. invoke ioctl KVM_TDX_INIT_MEM_REGION.
>> > > > 7. do not unmap the source backend.
>> > > >
>> > > > So, would it be reasonable to introduce a dedicated flag that allows userspace
>> > > > to explicitly opt into the in-place copy functionality? e.g.,
>> > >
>> > > Why?  It's userspace's responsibility to get the above right.  If userspace fails
>> > > to provide a src_page when it doesn't want in-place copy, that's a userspace bug.

Yan, is your concern that userspace forgot to update the code and
forgets to provide a src_page, and if we keep the "Zero page while
getting pfn" patch, ends up with the guest silently having a zero page?
I think that would be found quite early in userspace VMM testing...

>> > I mean if userspace specifies a NULL source_addr by mistake, it's better for
>> > kernel to detect this mistake, similar to how it validates whether source_addr
>> > is PAGE_ALIGNED.
>
> The alignment case is different.  If userspace provides an unaligned value, KVM
> *can't* do what userspace is asking because hardware and thus KVM only supports
> converting on page boundaries.
>
> For a NULL source, KVM can still do what userspace is asking.  Rejecting userspace's
> request would then be making assumptions about what userspace wants.
>

Also, +1 on this, what if userspace, knowing that pages are zeroed on
allocation, actually wants to rely on that to get a zero page in the guest?

>> > Since userspace already needs to perform additional steps to enable in-place
>> > copy, specifying a dedicated flag to indicate that the NULL source_addr is
>> > intentional seems like a reasonable burden.
>
> I don't see how it adds any value.  I wouldn't be at all surprised if most VMMs
> just wen up with code that does:
>
> 	if (in-place) {
> 		src = NULL;
> 		flags |= KVM_TDX_IN_PLACE_COPY_INITIAL_MEMORY_REGION;
> 	}
