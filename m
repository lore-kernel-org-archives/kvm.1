Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A1524F
	for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101477; cv=pass; b=sKkmfesiu+23XADS2ZVKx6rDPORYJg6vatL6Dr/cyGjWo1xLiFDDHDnflU/+7e/XJ1zrSGY1l4t97ymQjVGtfLtUV7j/OU4YrobeC5Ga22FATDsxiiDSn51M3aBmormAFBoUPCXw19huakcSxz5h7aTsaWfAqvHDydMCi76Hnxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101477; c=relaxed/simple;
	bh=C1fYXsLFGUi2NURKFZP3YgVQbafBtBcelyYEEG/2ZaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxD93V2xGZGG8ocRjL+Ey+opn/yNDHwRWmxmDC7RWHCUT++OIPKIU69sNTxyTQ7gOYTgzRchUqp1l4XRQQQb8JT/6Y9I4SwM+/j+EKnCrksSPclJVWWkwfNObtfm+s0ddtMXsW0bei2Ey71kksfAhaCht5BzIe6km+39UyZxRh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7yyIZ8c; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7yyIZ8c"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caed617615so20716555ad.3
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 14:31:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785101475; cv=none;
        d=google.com; s=arc-20260327;
        b=QlThcxPYKmU8eriV62hOl04sWJBDoknyYRzj5P2E2VRIQgyGUQ6AXr/KiayzU728T/
         bm53bMqdCOqI58j1MGGOq+j2dvfo+RTySNN2hyScqoQAsm8q8tRHjBt6bf2WzaERZ/9c
         drH/c1tZVv1wMh+hkVVu6oAbi4n7cain0EbKKKYbAX1xaPA4HNFPlhY1Bb4knEyn6HC2
         eAnfNNgcP/drq6WGK1PhqpPwbW6M0F8qQJNbiP0c1iq9WbMoBaOjGX+Bo0nFsGwUbjLI
         bxKnWQaA+zF5iW2Kdvq/EtcFizj3suhzg8BeHRmV+h86wOlNdJyOEhn/18cN19yT7R7F
         ocwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R7qaGZSvdihZrgM4SUJ25Sx6UHgPhBZkB8GlT3x0MAE=;
        fh=0xkVNT0/LgNDoqh9DhISmh7oJ8bX6DZGiPWrL+M192g=;
        b=NleXLbnYIBefvnbeaAHJrlf6m4wBF/o+VAUa36ccnyJAtA/VxCRTXQXuZOdKGs1IqX
         JJx4tT2cVZTAJtPftXz1e83xY5kNgtxEv50njzXssEofcOtVYd+CeqpMQnd25r6zIRjp
         QLqv6bsWS76LzSdgUIsURqf0E77aavMYNAAQsVgaVdnJf1A+5VlQiBwfR/+BKEYMjNDA
         l+lVZttZVjedgAQFGlD+wNIei4qBG7RtwO/wZHsIxkE8CvAt8DSwNoyybkz6+gV1Mf0e
         wn4UP1lwBZAXhUD6poM6qVOZpoiviA3JJV6mxGYN8mFuJj1nYZK4pA7vL6g8hXGr+Akw
         ECGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785101475; x=1785706275; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R7qaGZSvdihZrgM4SUJ25Sx6UHgPhBZkB8GlT3x0MAE=;
        b=j7yyIZ8cqn4zsnv4S16md6he5+m+Ee59X0+YxcT0lSQmqbwtyqVsRkrS7kado8WIKP
         fi9sldn7+/NDqsq68expHHdQcvDx+JeXhTIdJR4gRtnFV7mWt9BCs4cVyP3k23jR+yWJ
         gao+xbqdW3TZf9auRX+UF98a/Yvfzt9UAJE0k2YSWfXDlmYun8Py8ZfXVsYQ9Pou8w2U
         dwf3G0yYPn9PAE+8bhkMaB2MAANIRJpP9Od4DkT1FBtNC3rMMRMnSCQLdbbBFYc3MNLv
         n9qZzSI3eZkRN5DUd4FuSYHxZiycjYyULvF61Jp5F+daA2xVriJxgeb8lZ72KDvAsYtI
         i7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785101475; x=1785706275;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R7qaGZSvdihZrgM4SUJ25Sx6UHgPhBZkB8GlT3x0MAE=;
        b=VoogDghzLQ3sYfk6TG6PXfXJpEtH96UZOw4qD3c5F2KDh1Gm0dfl2GB7kGnIG/tVH7
         hc2D+W4+FvExPXChNEIeyfdb0Krcd+s0G9Ki9qQRlSDjKM37lgjiXY1ekyNGDD7PX28s
         z44thPYg2Y7F+8aKzWBOfimF7aLHONNgy4QOXm84vIYYuOCsZQ4+b4hddUvMWbMRSf7N
         VxaBjKiVUXXSbMiw9tNvfWRmf0MqNKqo/1aeFd5tGG1NEDRca9asuvTq9aCEvKftvORI
         t/vxX3VwwgEBYabuDPSDmxhBVIvUbGy/EUzP/m7q3E4IEXHNplR2RT+s/Rq8aGYpqYCl
         DDbg==
X-Forwarded-Encrypted: i=1; AHgh+Ro52/yz8WxUlycl+KM3g5WvURs0UvxQuho6FKrT621R9o86og7lvDi4dWlBRAqJBlFu1xE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMukBtV7aQLzgf3S+gajr+PJs7gi86jFgyU3xDozPnSw1VUWQ
	U+7VKNOriKEQK/HuIgkLWob2DHCfEUvB/MazUzs7IKWu3bNOxqNZCYZrdJTtutXrzou3nDqvaf6
	WbIwa7URUMIioll3YpQEUolvl8d2enlQ=
X-Gm-Gg: AR+sD12qGiPVRuFSxjd7bc8LznGFb2ZjEY49kvfDGR8PGQ+ofRZnj1lf2UR1xhd69Er
	E48ZgT2Gf2fPJjlnVgs70SAbD2M4qC6cj50j4dP/5wk7E8cvB9y4Bd3Rno+5AwHq3iUFsaqFFrF
	/B8YkgZPBjCA8gy/BOr2IDjiFeQVJ94XJ9YDoh0I3hbvy8s2FWzhhgIRUJBakquOzO98j+1NkpE
	Ul30Ak7xKXLQfFOrmrvX0524nhGptpOxergDtXbRrIyzXT2PHjCfnkjLQ==
X-Received: by 2002:a17:902:f607:b0:2c9:cf62:6f61 with SMTP id
 d9443c01a7336-2cfde7bcf89mr54155365ad.17.1785101475164; Sun, 26 Jul 2026
 14:31:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520111325.693807-1-aha310510@gmail.com> <aj2hi-NcqUUCaoQF@google.com>
In-Reply-To: <aj2hi-NcqUUCaoQF@google.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Mon, 27 Jul 2026 06:31:03 +0900
X-Gm-Features: AUfX_mx4dqFJoKph6GXLV44e8FOcx17a047VZ7atvrWp9YpcuSQalFGzreBO1AA
Message-ID: <CAO9qdTH7LCO-N9brn95fq49muA5Ud=kixJUYC4pwDJ9eL-qE7A@mail.gmail.com>
Subject: Re: [PATCH] KVM: pfncache: track HVA invalidations for HVA-based caches
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Paul Durrant <pdurrant@amazon.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, May 20, 2026, Jeongjun Park wrote:
> > HVA-based gfn_to_pfn caches are not necessarily backed by a KVM memslot.
> > When an MMU notifier invalidation targets such an HVA, KVM's global
[....]
> >
> > Reported-by: syzbot+0948c82180d475ad24e2@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/6a0c5f2c.a00a0220.2c7954.0000.GAE@google.com
>
> Given that there's no reproducer, how did you test this?
>

For some unknown reason, repro was not generated in syzbot, so I analyzed
the KASAN logs separately to predict a sequence similar to the race
sequence you suggested, and then wrote the repro code myself to test it.

> > Fixes: b9220d32799a ("KVM: x86/xen: allow shared_info to be mapped by fixed HVA")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > ---
> >  include/linux/kvm_types.h |  1 +
> >  virt/kvm/pfncache.c       | 42 ++++++++++++++++++++++++++++++++-------
> >  2 files changed, 36 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
> > index a568d8e6f4e8..ff3b8aa73561 100644
[....]
> >                       /*
> > @@ -45,9 +62,11 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
> >                        */
> >
> >                       write_lock_irq(&gpc->lock);
> > -                     if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
>
> Unless I'm forgetting/missing something, it should be impossible for gpc->pfn to
> be garbage if gpc->valid is true.  As a follow-up patch, turn that into a
> WARN_ON_ONCE()?  Assuming I'm not missing something...
>

I agree. As far as I know, if gpc->valid is true, !is_error_noslot_pfn()
cannot be false. Since this check exists in the existing code, I
considered keeping it in gpc_hva_is_valid(), but the method you suggested
seems more accurate, so I think it would be better to just remove
!is_error_noslot_pfn().

> > -                         gpc->uhva >= start && gpc->uhva < end)
> > +                     if (gpc_should_invalidate(gpc, start, end)) {
> > +                             if (kvm_gpc_is_hva_active(gpc))
[....]
>
> Oh!  But we can simply piggyback mn_invalidate_lock and use a per-VM GPC sequence
> counter, then the end() path doesn't need to re-walk GPCs.  That will regress
> GPCs in the presense of unrelated mmu_notifier events, but we already know that's
> a lurking problem, and we know how to fix it[*] (I think).
>
> There's a "sleeping while atomic" problem that will occur on RT if/when GPCs take
> mn_invalidate_lock when refreshing the PFN, thanks to IRQs being disabled, but
> that's not a problem until we implement the range-based optimization, because
> until then, the reader side can be lockless.
>
> [*] https://lore.kernel.org/all/Zw8DINUkJJKDByXE@google.com
>
> Not yet tested, and I think I'd want to land this at the same time as the
> range-based optimzation, to avoid regressing "normal" GPC usage (only AWS uses
> the HVA-based Xen API, so getting a fix to LTS kernels isn't a priority, AFAIK),
> but this?
>

The approach you suggested seems most appropriate for resolving this bug.
Of course, as you mentioned, modifying it this way would cause a regress
when unrelated mmu_notifier events occur; however, since resolving this
issue would likely require a significant number of patches, this method
appears more suitable for the time being.

I'll send a v2 patch reflecting these changes soon.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 0bdfa3699352..d07e3cbff983 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -854,6 +854,8 @@ struct kvm {
>         gfn_t mmu_invalidate_range_start;
>         gfn_t mmu_invalidate_range_end;
>
> +       unsigned long gpc_invalidate_seq;
[....]

Regards,
Jeongjun Park
