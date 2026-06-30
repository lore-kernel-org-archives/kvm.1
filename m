Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF03CF960
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 00:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782777607; cv=pass; b=qtjIpxEeBTUkzI5Zqr8pKs2X/KK+aW1cAosaWczez1aHycNAco9owOZoeQezE/rfD+MpeR520pZhjCWpPr6ajlIkc4SoF7aJZraiQ/ItldCjIlpvad32mPNCJUl6az2b4aMQfdO7cDwuBV8ghRo3lnQ7MVoZs5ua916BQmWmU/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782777607; c=relaxed/simple;
	bh=X8aSQefEVrv6GCn0252vnBuvifo0MWErWT4n24Eqnmc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkmsdAAgEN5te4xBWd4IjSl1Ql/PR/1tAnMSVgUH2rRvqSy7aIkxwaf8HQYEovnjTvHzU6mmta+ZmqCbrZUDguV7DvTMrI//7el31YqJaBexZjGEQPD3pjP+a7s/b6UKJEnXl03705wy7gFpY2JMZL7+vVMTrfbcS0cszcrsfiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5q6QN3r; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5q6QN3r"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13b24ddadedso1653373c88.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 17:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782777605; cv=none;
        d=google.com; s=arc-20260327;
        b=r9WzPhd0TxNXDDc93WrGXR17800M2eVI20yHHybs14judt5DKTY1D1xku7gDihIub1
         A/zuvBSOxIovaf7uo1W6mev05aVTa6uzSl2j3y301rl3j57E73M956nvXAiMyJTMGVoC
         pw3WtZQl3K1X0eLL0so+uo8y0znx4ZTnLtrqMIxTH+++0RdwTe5Ya40CXGvH50tp2r0e
         jNQpHa0+O3HW8Sl9782VRK/GFjUDLqdwUHe8Y1SjCU36Eh6LcAnwZcDc59IlAVNc2Db8
         mnXeOyW5CY6P3e3xHieGHT8tPJ0ojGi+HiGlmHmVfb078bR8/CgMgckAiXgZjxMS7N0W
         pXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3Mwc2B+GrmZbKKMA84UwWi98Av3FLz1fLV2iP82IJ8Y=;
        fh=ZXS8WhknoWwGfnH3ExQj4cPRSxHHHzVjWO01S8YCxYU=;
        b=SClZv2rFUrtk/BW9cW3FcJhtBolf0/xb9RzoQe5lawU1kBzJZRw0Zm46IChIKm+DzN
         bPO+EvPg+ZUl8X8PhOQR/rsc7J+JpgHx68d7PLIuUYS35F9F8rYXfrvKYqmFJk+kl4xn
         eGtphL4dyLp+XtAfOikX/49t90NaYiRW6gs8IPA14K+WgkbeLDUycmkgCzTRy7Y4B/+N
         Z1JmvIltd5fzO8GLq2fJhuqJq7Mj00U483BVqhSUA9QvwJZtZB34QZ2gSDXqhCroSInm
         D07WXv37+VBn9cHfeHTAxQy0OdMKRscFERtUvT6/6+uuA6Y1Z9FwbJtsWpRr54X0Ldn1
         qVGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782777605; x=1783382405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Mwc2B+GrmZbKKMA84UwWi98Av3FLz1fLV2iP82IJ8Y=;
        b=s5q6QN3rvUS/un7j4m49b8eex/0MzWdYDvvBFqlzMT5zXf9+JoapLlSv6Q9Aj53pPo
         qtsEEC4FjIiEjjr8seiqnlFBebNOcSZWnX+Kvm4r9N9BF9JriYzxKsxw4B4pDulU1pNA
         xg2sh6boWsxU3mExxpoTasHC70uRtsAkWBd4tlmVduDolHT+LEqXierRHuGRGf8XdPvG
         SnD3OaOw9k855iE7QJt9M4RcakCnoDt61mw/8Ku0qsHLZb9cGdCvUox63W6Ctq84dOu9
         d6lvYW1AV8fpCHPCR4NzI7vscjiIIEverqDdJ8HLFnBHteYZ1cB5iLpfzbJy88GejvkU
         hcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782777605; x=1783382405;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Mwc2B+GrmZbKKMA84UwWi98Av3FLz1fLV2iP82IJ8Y=;
        b=Q7IW1q5o0Ju2yXuqiWaaBl2ljuA6EajqNyAEWdy7CS6DvcKmS1XEfkMUeJQ/W/YFMG
         qDozcb5jZYBgZXJmxaadQzPqJ1crHTLXs3f7lrXvDyd0ueOHhFOQ0O5JGq2N8QWZRm5s
         l4pn2GWyNbfpkeJ7FPfqrqwldfqfpXJS5V5gSSJcMkRZkdL1Fmq/psPinKYCL9C2/N13
         833QLffygalqhMuqsnhH4DVGhC2s2CiSVHVv85zZHSRFhfWzF+iohrMH6gHC1BxVpoUR
         WXXXSl1HUKW+weed4RdV3bF2BgaIfmtUmC90jNPXBg45uU0caWEDh064H5IAfwhZ3HcB
         OxNA==
X-Forwarded-Encrypted: i=1; AFNElJ9UMExEwY2pfHJVE+5rD6fdGmgFbaQvBdySJN/Ed+DF5WO/ugaerkitH7/nJ9/SchhEkzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRDgPi3sG63PrH4fiZcNxAW3GdpDTNtYI6ao+cpQJXWvWoxmfJ
	AyAwXKDQkhlOtwzUOsreIyfus/bSuXwV0LsiqvfLwYireNb5ToFxmK9U4pbkEOgQX4xeg28HP39
	lVCzp7k2RIA5mK8EaWVFWAPhZ1jllL7p0qhzIqrS/
X-Gm-Gg: AfdE7cm86lqXPHTl5Bghlqj+noCPHFzGcQHTiZdD0Yp3F/ukW38FzTyPnuloi5zlYB/
	j9iKa0mMnGbxERDoY7wRIZM1yP7W+fYXddydG2TGdx88GD//eVhiggP7nE7htu16+Lb5H0I413H
	j8xih1pKI1OEQ0zjt7/zOUqom+XZ6rhrh3I4M3PbDz6wL01yJbhE0+p5lg0j1kDyV2m0FNqUvqW
	/t0Ps7YWxSEte/IeEfSw3CkisW/TR4rjULtT54r6ctu9t5C3CcZARwUPa9ZAxBTgUEKLYQDPsTC
	OGsdSp77b9xvnkM0/gM3YEDh9zx4wF9/uN/QvVS0tIk4hXsUm/QoOjUJAzM=
X-Received: by 2002:a05:7022:ec2:b0:136:90d9:f1e8 with SMTP id
 a92af1059eb24-13b2a17959bmr913860c88.21.1782777603660; Mon, 29 Jun 2026
 17:00:03 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 17:00:02 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 17:00:02 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <akI9m02jgKAdi4gX@yzhao56-desk.sh.intel.com>
References: <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com> <ajnf5Z9nWZxoLS4x@google.com>
 <ajoWngKaZ+wfIyR+@yzhao56-desk.sh.intel.com> <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com>
 <ajxasFBzp_9KnQLq@google.com> <CAEvNRgG1nHipzw4=eBgwhvyXi8xYo7FQD_sy9Ax6FDf7YDu3Og@mail.gmail.com>
 <ajyRg3BwGu5dCfOn@yzhao56-desk.sh.intel.com> <CAEvNRgH5KOHoemnC9QOn_oK97=KeAH1XuX3ps36-pJ0Fn0aBHQ@mail.gmail.com>
 <aj3TGLGWT1kMFIVH@yzhao56-desk.sh.intel.com> <CAEvNRgHb6WmOha6Pct_Tn8Ucuov95L=fj5=2R9gcHfx=b2V_+A@mail.gmail.com>
 <akI9m02jgKAdi4gX@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 17:00:02 -0700
X-Gm-Features: AVVi8CcXidUq51ARrlQptDvdo-c9HLMRl0FHaHd_Iqaf0XwSp1zGW8A5Ct6_--0
Message-ID: <CAEvNRgHO3T6pKDP7ye-RdqbGhAzVC7a=8uBUyaPxwbSuj9khqA@mail.gmail.com>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Fri, Jun 26, 2026 at 08:28:32AM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>
>> > On Thu, Jun 25, 2026 at 05:07:23PM -0700, Ackerley Tng wrote:
>> >> Yan Zhao <yan.y.zhao@intel.com> writes:
>> >>
>> >> > On Wed, Jun 24, 2026 at 04:00:32PM -0700, Ackerley Tng wrote:
>> >> >> Sean Christopherson <seanjc@google.com> writes:
>> >> >>
>> >> >> > On Tue, Jun 23, 2026, Yan Zhao wrote:
>> >> >> >> On Tue, Jun 23, 2026 at 01:16:14PM +0800, Yan Zhao wrote:
>> >> >> >> > On Mon, Jun 22, 2026 at 06:22:45PM -0700, Sean Christopherson wrote:
>> >> >> >> > > On Mon, Jun 22, 2026, Yan Zhao wrote:
>> >> >> >> > > > On Thu, Jun 18, 2026 at 05:32:00PM -0700, Ackerley Tng via B4 Relay wrote:
>> >> >> >> > > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> >> >> >> > > > > index ffe9d0db58c59..56d10333c61a7 100644
>> >> >> >> > > > > --- a/arch/x86/kvm/vmx/tdx.c
>> >> >> >> > > > > +++ b/arch/x86/kvm/vmx/tdx.c
>> >> >> >> > > > > @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
>> >> >> >> > > > >  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
>> >> >> >> > > > >  		return -EIO;
>> >> >> >> > > > >
>> >> >> >> > > > > -	if (!src_page)
>> >> >> >> > > > > -		return -EOPNOTSUPP;
>> >> >> >> > > > > +	if (!src_page) {
>> >> >> >> > > > > +		if (!gmem_in_place_conversion)
>> >> >> >> > > > When userspace turns on gmem_in_place_conversion while creating guest_memfd
>> >> >> >> > > > without the MMAP flag, the absence of src_page should still be treated as an
>> >> >> >> > > > error.
>> >> >> >> > >
>> >> >> >> > > Why MMAP?
>> >> >> >> > Hmm, I was showing a scenario that in-place conversion couldn't occur.
>> >> >> >> > I didn't mean that with the MMAP flag, mmap() and user write must occur.
>> >> >> >> >
>> >> >> >> > > Shouldn't this be a general "if (!src_page && !up-to-date)"?  Just
>> >> >> >> > > because userspace _can_ mmap() the memory doesn't mean userspace _has_ mmap()'d
>> >> >> >> > > and written memory.  And when write() lands, MMAP wouldn't be necessary to
>> >> >> >> > > initialize the memory.
>> >> >> >> > Do you mean using up-to-date flag as below?
>> >> >> >
>> >> >> > Yes?  I didn't actually look at the implementation details.
>> >> >> >
>> >> >> >> > if (!src_page) {
>> >> >> >> > 	src_page = pfn_to_page(pfn);
>> >> >> >> > 	if (!folio_test_uptodate(page_folio(src_page)))
>> >> >> >> > 		return -EOPNOTSUPP;
>> >> >> >> > }
>> >> >>
>> >> >> Yan is right that with the earlier patch "Zero page while getting pfn",
>> >> >> folio_test_uptodate() here will always return true.
>> >> >>
>> >> >> Actually, this is an alternative fix for the issue Sashiko pointed out
>> >> >> on v7 where userspace can do a populate() (either TDX or SNP) without
>> >> >> first allocating the page, with src_address == NULL, and leak
>> >> >> uninitialized memory into the guest.
>> >> >>
>> >> >> Advantage of using the uptodate check in populate: if the host never
>> >> >> allocates the page, populate doesn't incur zeroing before writing the
>> >> >> page anyway in populate().
>> >> >>
>> >> >> Disadvantage: Both TDX and SNP will have to implement this uptodate
>> >> >> check. guest_memfd can't check centrally because for SNP, for a
>> >> >> PAGE_TYPE_ZERO, !src_page should be allowed with a !uptodate page since
>> >> >> firmware will zero and there's no leakage of uninitialized host memory?
>> >> > Another disadvantage: the uptodate flag is per-folio. What if the folio
>> >> > is only partially initialized by the userspace especially after huge page is
>> >> > supported?
>> >> >
>> >>
>> >> Good point on huge pages!
>> >>
>> >> The uptodate flag on the folio in guest_memfd means "this folio has been
>> >> written to". As of now (before patch at [1]), this happens when
>> >>
>> >> + folio is zeroed on first use by userspace
>> >> + folio is zeroed on first use of the guest
>> >> + folio is populated
>> >>
>> >> When huge pages are supported, the folio can't partially be initialized?
>> >>
>> >> On allocation, if any part is shared, we split the page. The parts are
>> >> separate folios that have their own uptodate flags.
>> >>
>> >> On splitting, if the huge page is uptodate, the split pages will also be
>> >> uptodate. If the huge page is not uptodate, the split pages won't be
>> >> uptodate, but that's ok since they will be marked uptodate on first use.
>> >>
>> >> On merging, the non-uptodate parts have to be zeroed and then marked
>> > If that's true, it would be good.
>> >
>> >> uptodate. Any parts that are in use would have been marked uptodate
>> >> already, so there's no overwriting data that is in use. I'll need to
>> >> think more about when it's safe to zero.
>> >>
>> >> I'm still on the fence between the two options
>> >>
>> >> 1. Using uptodate check in populate to reject src_pages that have never
>> >>    been written to or
>> >> 2. Always zero before populate
>> > 2 does not work?
>> > The flow is
>> > 1. mmap gmem_fd, make GFN shared, and write initial content.
>> > 2. convert GFN to private
>> > 3. invoke ioctl to trigger populate.
>> >
>>
>> This flow is correct, is what users of in-place conversion should do.
>>
>> "Always" is the wrong word, I should have said "zero if not uptodate
>> before populate", as in, with patch at [1].
>>
>> By doing the zeroing in __kvm_gmem_get_pfn instead, by the time populate
>> gets the pfn, the page would be zeroed, either because userspace faulted
>> it in, and the zeroing happened in kvm_gmem_fault_user_mapping(), or if
>> userspace never faulted it in, the zeroing would happen because
>> populate() allocated the page.
>
> I see.
>
>> >> but whether the uptodate flag is per-folio or not doesn't affect these
>> >> two options in terms of fixing the leak of uninitialized host memory,
>> >> right?
>> > yes, provided "On merging, the non-uptodate parts have to be zeroed and then
>> > marked uptodate".
>> >
>>
>> Thank you so much for bringing this up, I hadn't considered this
>> before. I'll do that when I get to guest_memfd hugepage restructuring.
>>
>> >> >
>> >> >> >> Another concern with this fix is that:
>> >> >> >> commit "KVM: guest_memfd: Zero page while getting pfn" [1] always marks the
>> >> >> >> folio uptodate before reaching post_populate().
>> >> >> >>
>> >> >> >> [1] https://lore.kernel.org/all/20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com/
>> >> >> >>
>> >> >> >> > One concern is that TDX now does not much care about the up-to-date flag since
>> >> >> >> > TDX doesn't rely on the flag to clear pages on conversions.
>> >> >> >> > I'm not sure if the flag can be reliably checked in this case. e.g.,
>> >> >> >> > now the whole folio is marked up-to-date even if only part of it is faulted by
>> >> >> >> > user access.
>> >> >> >> > Ensuring that the up-to-date flag works correctly with huge page support seems
>> >> >> >> > to have more effort than introducing a dedicated flag for TDX.
>> >> >> >> >
>> >> >> >> > > > Additionally, to properly enable in-place copying for the TDX initial memory
>> >> >> >> > > > region, userspace must not only specify source_addr to NULL, but also follow
>> >> >> >> > > > a specific sequence (where steps 1/2/3/7 are required only for in-place copy):
>> >> >> >> > > > 1. create guest_memfd with MMAP flag
>> >> >> >> > > > 2. mmap the guest_memfd.
>> >> >> >> > > > 3. convert the initial memory range to shared.
>> >> >> >> > > > 4. copy initial content to the source page.
>> >> >> >> > > > 5. convert the initial memory range to private
>> >> >> >> > > > 6. invoke ioctl KVM_TDX_INIT_MEM_REGION.
>> >> >> >> > > > 7. do not unmap the source backend.
>> >> >> >> > > >
>> >> >> >> > > > So, would it be reasonable to introduce a dedicated flag that allows userspace
>> >> >> >> > > > to explicitly opt into the in-place copy functionality? e.g.,
>> >> >> >> > >
>> >> >> >> > > Why?  It's userspace's responsibility to get the above right.  If userspace fails
>> >> >> >> > > to provide a src_page when it doesn't want in-place copy, that's a userspace bug.
>> >> >>
>> >> >> Yan, is your concern that userspace forgot to update the code and
>> >> >> forgets to provide a src_page, and if we keep the "Zero page while
>> >> > Yes. Previously, it would be rejected after GUP fails.
>> >> >
>> >>
>> >> I see, didn't realize previously it would be rejected because GUP
>> >> fails. GUP failed because it wasn't faulted into the host?
>> > GUP fails if 0 is not a valid user address.
>> > But GUP would not fail if 0 is a valid address. e.g., in below scenario:
>> >
>> > #include <sys/mman.h>
>> > #include <stdio.h>
>> > int main(void)
>> > {
>> >         void *p=mmap((void*)0,4096,PROT_READ|PROT_WRITE, MAP_FIXED|MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
>> >         if (p==MAP_FAILED) {
>> >                 perror("mmap");
>> >                 return 1;
>> >         }
>> >         *(char*)0='Y';
>> >         printf("addr0=%p val=%c\n",p,*(char*)0);
>> >         return 0;
>> > }
>> >
>> >
>> >> That's kind of orthogonal, I don't think GUP fail leading to rejecting
>> >> populate was meant to help userspace catch these issues. GUP would also
>> >> fail if the user did mmap(), write to it, unmap using
>> >> madvise(MADV_DONTNEED), then forget and pass 0 as src_address.
>> > The original uAPI did not explicitly define 0 as an invalid uaddr. Whether 0 was
>> > rejected depended on whether the user mmap()'d address 0. If 0 was a valid
>> > mapping, populate() could proceed.
>> >
>> > commit 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating
>> > guest memory") changed the behavior though. It would return -EOPNOTSUPP for a 0
>> > uaddr.
>> >
>>
>> I see, I only looked at this after commit 2a62345b3052.
>>
>> > But if a user configures 0 uaddr as valid, writes to it, and then passes 0 as
>> > source_addr(not from gmem), I'm not sure if it's good for the kernel to silently
>> > treat 0 uaddr as an identifier for in-place copy from the private PFN in gmem.
>> >
>>
>> I'd say the original uAPI perhaps just didn't document 0 as an
>> unsupported uaddr. Given that commit 2a62345b3052 already merged, uAPI
>> was perhaps accidentally changed and no customer complained, I think we
>> can move forward with 0 as an invalid src_address? I wouldn't think
>> anyone relies on 0 intentionally being a valid address.
>>
>> I could document that, if it helps?
> What about just documenting that 0 is an unsupported uaddr which will be
> re-purposed as an indicator to use the target pfn as the source, regardless of
> whether gmem_in_place_conversion is true? i.e.,
>
> if (!src_page)
> 	src_page = pfn_to_page(pfn);
>
> I don't get why the two scenarios should be treated differently:
> 1. gmem_in_place_conversion==true, shared memory is not from gmem
> 2. gmem_in_place_conversion==false, shared memory is not from gmem
>
> In both case, a 0 uaddr could be mapped to a valid page not from gmem.

This is true, but this check isn't about whether the page is from gmem.

> So why not update the uAPI to handle both cases consistently? :)
>

Wait, but before this series, if region.src_address = 0, src_page = NULL
and that's not supported so it returns -EOPNOTSUPP.

If that's dropped, then suddenly if region.src_address = 0 and
!gmem_in_place_conversion, tdx_gmem_post_populate() will now load the
memory (zeroed) after [1] into the guest? I don't think we want to
change that behavior.

I could document that 0 is an unsupported uaddr only for TDX, and only
when gmem_in_place_conversion = false.

Since it is unsupported only when gmem_in_place_conversion = false, the
check two lines marked with <<==== can't go away?

	if (!src_page) {
		if (!gmem_in_place_conversion)  <<====
			return -EOPNOTSUPP;     <<====

		src_page = pfn_to_page(pfn);
	}

Also, for SNP, src_address == 0 is permitted (and desired, I believe, to
avoid a pointless kernel memcpy) if the type of population is
KVM_SEV_SNP_PAGE_TYPE_ZERO.

>> >> >> getting pfn" patch, ends up with the guest silently having a zero page?
>> >> >> I think that would be found quite early in userspace VMM testing...
>>
>> [...snip...]
>>
