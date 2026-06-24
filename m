Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA223CF673
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323194; cv=pass; b=Fx71FAiZViIWTi6fqRupeyY037F5yVoiFC1elBQ+OPjytSg8wW7RHGC+Ru5fMey5xfASR4J48nJB4A5C3wh4I9Mw+McdcW3BbLou1T4CrghARq/s2TfyBO/w3zZdWAc19m4qNvqx3jAnlO/0HkEiZSqp9oGfkAV+9VJz9wxJcps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323194; c=relaxed/simple;
	bh=vCq390Phe629A05xURRWOGGQ0yb4i2q+x5ST7PsW5xA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6xUK4wCyJD+sr3h2Qc2Bl842DNo/eyCEBmcMooXGauFHsGmCYMxCea3fbn6BWeBQH+LVZcPiuq+zzi+LReRtDYps2MjQv+ZckY62RAiAkYvUFyA9t7JIdFJjxgdNQrUOuCWFlIm4g+apVWVA2uUzkVZaIsfVHC7W0ZGeLfFEIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9b5eeDD; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9b5eeDD"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139a71baa35so3424820c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782323191; cv=none;
        d=google.com; s=arc-20240605;
        b=JGK1rcwIasREJn9Cc37e4xj4PPJUBThr9kqnRIbBXzDxKKG2Ic0+ljAOyXU9NbzPRW
         FxHA5RyZQ3YDVsUrpdSY/q7AnHpJfjI5oTTtfSKbtjWtWWPN7VBYTD76OtgjUtwi2g90
         KQ+KrzWFXwLb5JYwvaFxPNZo9wKFahM8jTMoNSD/28euUzuK1Vwj/bceiY8q3+Alh6Vs
         7bZJV9uN/q4db27JTeC7suatTYAcQ40sMj/ZlktAbSA1tzSCdnpTqTobFSWMyzwTow1P
         QTOS69QIWW8LG6Llm9xylY0t62s3SS433RAVE53MlFe6PkH0JDc+SoQJkTpuEmismfhU
         qgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Mqx7OyqbEK6iUTPEaB+Dm1Nc+76HebeZ2yhpFRHkMNY=;
        fh=yPBWvGtRe4IZkkU7SUNbtbjoh75p7k+o/MIzOoKRdzU=;
        b=Re8uAer/2w5474co6Aa9NHv4IAi8EruRZT9m0VvDksN0HaBmRyaxqsomuYu7/kFwce
         6VYJ5x1tA7r2SHszXGbjm8BQikdp6jKSm4Tg3hWlgw2l0V+yK0yqNmDJ/Z5kVy5ZFOhU
         CradrSVTMdI6L5j04sJHbtp5McPoe3WZq2xEP2JUXQym/RFEWS5ueF1Qs0tFWFuE0HvG
         w+1kr2lbopxgEt5Ul9MbHrHYOez8MXlpJg2oCd6E3Fbn+E5elmD9T4e+H15PydNbkbXU
         eXW/mrriicR7VIYaXD83YFvRdE3OM3yiBRloWeuJmEdrBNmT2zJ/1wVRBnmT4D2r3Gwy
         0mGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782323191; x=1782927991; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mqx7OyqbEK6iUTPEaB+Dm1Nc+76HebeZ2yhpFRHkMNY=;
        b=L9b5eeDDwnekFpAvyBK91cxIbaTW5LZWaIdMHnBWiyiWfC1uR3ZU5IctyGFpkQMk+H
         1hVp6aBQlgkkyXX6Tgke0A5cNdalP1qwlNap7Jip+HN1vznw7gtfHEQ0NX7b/7ZGNO7Y
         PvaQ0KQEKWgBjlI8+RE18RGMwkSscaFcjIegUa+ZXmq9A7bvI1jPjkW5t/ZrG7hZ3Nxg
         Odh3IKWzUeXZObykhACnh2r+69172ZGMq8fikAkf84fAUcsjlYv9+IiZvGVgfdEWD9rK
         YGhRxeASD+cUG3oDeuaA7wHPeQRVx94amtcPrFQo8k6gzFXzsO7R8SoqU8Nmfuwyyyrx
         6JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782323191; x=1782927991;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mqx7OyqbEK6iUTPEaB+Dm1Nc+76HebeZ2yhpFRHkMNY=;
        b=nLkHFbW3OBK8NYHBzhfhZUd7ChX2D3N3K+urUNIC3qxCZGG8DWh0VSZg78PUfd4ViY
         AUc3rgP9iDnsPidEKOWTEF8vO3bip43tZxgNzKlkjkY3hDk/HUaxdxiUjej4/OYUP/V1
         GdvGoj2iRt7IR/6EOOHEvwyyQFCD9OlKBJLVu9bVFHzcUuUcMO3WbpyFG/cEPM51n1QG
         g1kFO9VMQu4vwbKqqU4ivdKURAro+RDGzVYH0bmwdTxJcYAuMOr9PlU1EJjVXuvTHpqG
         s+n8hfHrD/0iCpxf322ZZ7LUePyTtITdaE3ibM8BuQ7uAXoQHRfOf4I7T8JtGeHBqEe/
         NDBg==
X-Forwarded-Encrypted: i=1; AFNElJ++YCPnyxBZT2qeaxkk+YVfLe3nO5rad4+BzY2JO4uhPxg1P3Rx7ApSfiCr6DoC0IbHA3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn7qsRwvpkUPF9d0ucx6iqfejJ+KAptPl6KLx/LceVMFddL3H
	CK/BhaDZxV7W4byi4Q4I1bHFzEjOflsX2wXyr/5sXh6JofzCLGmWCXp7IhabIYLD9Oi4xtDNA31
	Mbq2VXY/abQUzA+xV1AhVBdLb3C8IeG5burGaIIux
X-Gm-Gg: AfdE7ckYOBtMYsaY+hHtk4QTzMoLmsxOb2XZysnThNDJBsGkqYbGYCRuS7p6MpwFX9C
	fEfiFQNCsHWEXn7muxrdk80cV05+PQ7NsfdhN8SjtJQl1m1dF/AENk5GG8ogotByph1zG4qLp2K
	u8N0id15WXcbHxWq5kIdkIHqzJ5vwh5tEKWEWUP8Zoe8kWihQMeeTURrtjM+/wn/Xy8I4nFSrZp
	jhHthk3kMf4CWnQEbV0yejAwW04alKztBMMkTBXleUKTFNHYIT85E9hi9ZmFWPhyfxpWon89fTY
	twkYkWhqfdZYUeEw7UIR5R14zGnt1o2XcvA9+NzRlYuPBk8WvQYjYJ3DyYs=
X-Received: by 2002:a05:7022:ec6:b0:136:c24a:7213 with SMTP id
 a92af1059eb24-139d0c1d9cbmr3442157c88.11.1782323189975; Wed, 24 Jun 2026
 10:46:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 10:46:29 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 10:46:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajneQVLriUshjFIO@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-15-9d2959357853@google.com>
 <CA+EHjTx+3U++dnhGEkwh2SO82xMugAvvJ9ee1O__sxZCKL_X5A@mail.gmail.com> <ajneQVLriUshjFIO@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 10:46:28 -0700
X-Gm-Features: AVVi8CfZZdJUtw5fyaSnXyT_Umcz85ZtFZhHHk4S7sCQCvBEuiIkAR9ZBXOQWWM
Message-ID: <CAEvNRgGX3GkazCWM=6y9YLgn=YemXuG==Oo+L58cac1Fd86_TQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/46] KVM: guest_memfd: Call arch invalidate hooks on conversion
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
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

> On Fri, Jun 19, 2026, Fuad Tabba wrote:
>> On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
>> <devnull+ackerleytng.google.com@kernel.org> wrote:
>> >
>> > From: Ackerley Tng <ackerleytng@google.com>
>> >
>> > When memory in guest_memfd is converted from private to shared, the
>> > platform-specific state associated with the guest-private pages must be
>> > invalidated or cleaned up.
>> >
>> > Iterate over the folios in the affected range and call the
>> > kvm_arch_gmem_invalidate() hook for each PFN range. This allows
>> > architectures to perform necessary teardown, such as updating hardware
>> > metadata or encryption states, before the pages are transitioned to the
>> > shared state.
>> >
>> > Invoke this helper after indicating to KVM's mmu code that an invalidation
>> > is in progress to stop in-flight page faults from succeeding.
>> >
>> > Reviewed-by: Fuad Tabba <tabba@google.com>
>> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>
>> Coming back to this after working through the arm64/pKVM side. My
>> Reviewed-by here is from the previous round and the patch hasn't
>> changed, but I missed an implication for arm64.
>>
>> kvm_arch_gmem_invalidate() is now called from two paths with the same
>> (start, end) signature: folio teardown (kvm_gmem_free_folio) and
>> private->shared conversion (here). For SNP/TDX that's fine, conversion is
>> destructive anyway. For pKVM the two need opposite content semantics:
>> conversion must preserve the page in place (same physical page, the point
>> of in-place conversion without encryption), while teardown must scrub it
>> before returning it to the host.
>>
>> The hook gets only a pfn range with no indication of which caller it's
>> serving, so arm64 can't give the two paths the behaviour they need. It
>> would help to signal intent on the conversion path: a reason/flag, a
>> separate hook, or not routing non-destructive conversion through the
>> teardown hook.
>>
>> arm64 isn't here yet, so this isn't urgent, but the hook is gaining a
>> second caller now, and it's cheaper to leave room for the distinction
>> than to change a generic contract other arches depend on later.
>
> Crud.  It may not be urgent for arm64, but it's urgent for other reasons that
> I "can't" describe in detail at the moment, and even if that weren't the case, I
> think we should clean things up now.  More below.
>
>> >  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 41 insertions(+)
>> >
>> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> > index 433f79047b9d1..3c94442bc8131 100644
>> > --- a/virt/kvm/guest_memfd.c
>> > +++ b/virt/kvm/guest_memfd.c
>> > @@ -607,6 +607,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>> >         return safe;
>> >  }
>> >
>> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
>
> Not your fault, but kvm_arch_gmem_invalidate() is badly misnamed.  It's not
> "invalidating" anything, it's much more of a "free" callback, as SNP uses it to
> put physical pages back into a shared state when a maybe-private folio is freed.
>
> As Fuad points out, (ab)using that hook for the private=>shared conversion case
> "works", but not broadly.  And it makes the bad name worse, because it's called
> from code that _is_ doing true invalidations.  For pKVM, it may not even need to
> do anything invalidation-like.
>

Thanks, I also didn't like the naming of kvm_gmem_invalidate(),
especially when conversions also calls
kvm_gmem_invalidate_{start,end}() and those do different things.

> To avoid a conflict with patches that are going to have priority over this series,
> to set the stage for arm64 support, and to avoid avoid bleeding vendor details
> into guest_memfd, as if they are core guest_memfd behavior (only SNP needs the
> "invalidation" on this specific transition), I think we should add an arch hook
> to do conversions straightaway.
>
> Unless there's a clever option I'm missing, it'll mean adding yet another
> HAVE_KVM_ARCH_GMEM_XXX flag?  Hmm, especially because IIUC, arm64/pKVM doesn't
> need a callback for this case, only the free_folio case.
>
>> > +{
>> > +       struct folio_batch fbatch;
>> > +       pgoff_t next = start;
>> > +       int i;
>> > +
>> > +       folio_batch_init(&fbatch);
>> > +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
>> > +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>> > +                       struct folio *folio = fbatch.folios[i];
>> > +                       pgoff_t start_index, end_index;
>> > +                       kvm_pfn_t start_pfn, end_pfn;
>> > +
>> > +                       start_index = max(start, folio->index);
>> > +                       end_index = min(end, folio_next_index(folio));
>> > +                       /*
>> > +                        * end_index is either in folio or points to
>> > +                        * the first page of the next folio. Hence,
>> > +                        * all pages in range [start_index, end_index)
>> > +                        * are contiguous.
>> > +                        */
>> > +                       start_pfn = folio_file_pfn(folio, start_index);
>> > +                       end_pfn = start_pfn + end_index - start_index;
>> > +
>> > +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
>> > +               }
>> > +
>> > +               folio_batch_release(&fbatch);
>> > +               cond_resched();
>> > +       }
>> > +}
>> > +#else
>> > +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
>> > +#endif
>> > +
>> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>> >                                      size_t nr_pages, uint64_t attrs,
>> >                                      pgoff_t *err_index)
>> > @@ -647,7 +683,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>> >          */
>> >
>> >         kvm_gmem_invalidate_start(inode, start, end);
>> > +
>> > +       if (!to_private)
>> > +               kvm_gmem_invalidate(inode, start, end);
>
> E.g. instead make this something like this?
>
> 	kvm_gmem_set_pfn_attributes(...)
>
> Hrm, though that wastes folio lookups in the to_private case.  So maybe just this,
> assuming pKVM doesn't need to take additional action on conversions?
>
> 	if (!to_private)
> 		kvm_gmem_make_shared(...)
>
> Actually, if we do that, then we don't need a separate arch hook, just a separate
> config.  It'll still bleed SNP details into guest_memfd, but it'll at least be
> done in a way that's more explicitly arch specific (and it's no different than
> what we already do for PREPARE...).
>

pKVM needs some arch guest_memfd lifecycle functions that

+ for conversion, doesn't do anything,
+ for teardown, resets page state (IIUC it'll be reset to
  PKVM_PAGE_OWNED (by the host))

So I think we need different functions for those two stages in the
lifecycle of a page with guest_memfd? What if we have

CONFIG_HAVE_KVM_ARCH_GMEM_SET_PFN_ATTRIBUTES, which gates

+ kvm_gmem_should_set_pfn_attributes(attributes) and
  .gmem_should_set_pfn_attributes
+ kvm_gmem_set_pfn_attributes(start_pfn, end_pfn, attributes) and
  .gmem_set_pfn_attributes

CONFIG_HAVE_KVM_ARCH_GMEM_TEARDOWN, which gates

+ kvm_gmem_teardown() and .gmem_teardown

SNP:

+ .gmem_should_set_pfn_attributes = sev_gmem_should_set_pfn_attributes,
  and sev_gmem_should_set_pfn_attributes returns !is_private
+ Rename .gmem_invalidate and sev_gmem_invalidate to *set_pfn_attributes
+ .gmem_teardown = sev_gmem_set_pfn_attributes

TDX:

+ Disable CONFIG_HAVE_KVM_ARCH_GMEM_SET_PFN_ATTRIBUTES
+ Disable CONFIG_HAVE_KVM_ARCH_GMEM_TEARDOWN

pKVM:

+ Disable CONFIG_HAVE_KVM_ARCH_GMEM_SET_PFN_ATTRIBUTES
+ .gmem_teardown = pkvm_gmem_set_pfn_attributes

Suzuki, does this work for ARM CCA?

This way,

+ The if (is_private) check doesn't leak SNP details into guest_memfd
+ .gmem_make_shared doesn't stick out without a .gmem_make_private
+ .gmem_set_pfn_attributes, .gmem_prepare and .gmem_teardown are aligned
  conceptually as lifecycle hooks

+ I think the private/shared check for prepare can also be folded into
  preparation.
    + Preparation perhaps doesn't need a should_prepare equivalent since
      there's no iteration and getting the gfn is just doing some math?
    + In another patch series?

> E.g. this?  There will still be a looming rename conflict, but that's easy enough
> to handle.
>
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index 9ce5be7843f2..8aead0abd788 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -648,8 +648,8 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>         return safe;
>  }
>
> -#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> -static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
> +#ifdef CONFIG_KVM_ARCH_GMEM_FREE_ON_SHARED_CONVERSION
> +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
>  {
>         struct folio_batch fbatch;
>         pgoff_t next = start;
> @@ -681,7 +681,7 @@ static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
>         }
>  }
>  #else
> -static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
> +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) { }
>  #endif
>
>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> @@ -729,7 +729,7 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>         kvm_gmem_invalidate_start(inode, start, end);
>
>         if (!to_private)
> -               kvm_gmem_invalidate(inode, start, end);
> +               kvm_gmem_make_shared(inode, start, end);
>
>         mas_store_prealloc(&mas, xa_mk_value(attrs));
