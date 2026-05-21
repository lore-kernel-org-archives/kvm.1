Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298E3E275F
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371288; cv=pass; b=II0XWP4fgWjEHo8LV58kOtINC1cwBStbHc6A9zEJPC/3iJyKvxw2VpDV2vjaRo+81p7BQXL0t4wS54VBfSE5iRgAxeY9+y67RMTnWQaLcxIvbCAL3scvqEHdqhMqoLU1SKMV0SJnk2SHMcMnazSUH2NDhcRl6UwPkeqxE6S8uyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371288; c=relaxed/simple;
	bh=SchiGOmf2MVWPKiRNrNhUxoPmvVzWaDRWZ8BJ0appKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HlLnI4dfF2FQQZKTA/sfP5A3INmmJz94PVP02aR/R+YbQDCNZ5Qv95sbjUznKxuLdIb5qmE0Mx+Sl/FH+ILATza9wb2CTyF5xAfSILBk98Kn7Bxsr8djA6xuc9ylLqTxWOWAT6OJYKberaEXF2tXfUjwBmEx0/KQwymDvVOKD5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTsJMzuu; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTsJMzuu"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-515548f390fso761cf.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 06:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779371286; cv=none;
        d=google.com; s=arc-20240605;
        b=InHnt4En8C+kT5z5Be/rh2sHBVxV9Jxi4fnHP7HCkLo/QDiagtorg7nvtkUC5FQF19
         MCKYrYfcvAy528fItaKWM8Q52kPf65GddpKuE4r0lthX8b4te8wDrk4h5WYH1jdGliRO
         ghVzI8POi3yzeOKr5LCaFDVFpB9iiOVd+2Y5Z9t3ANEDBtnhpikNnabXeZz3Yr+qZrg0
         irTusPeMeUd1g7zWrH8u0Rw2tELQtSvnzaNCSPSU5zRs8T3LsLjQ61JDiF8hQUQoBIZV
         8AlW0372Dz7o825mLRxClcB3thxJCa60itn/WvBUSl6IYaBucwBIEFCQKubUdaQKSE+a
         adRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x8ZLZpFna8QE3sntZWYFYWQfy/d2E0NvjrGgGfpza44=;
        fh=TNFVwCeWvKmO/IukMBMkTILw71vXMrnZdxMlzZehqUg=;
        b=KyLYWyqCK3M4tC0Y5zrkYX8ud7LybUyALEgcitHPTGSvYEHAGlEj58xgik1TrKnLI1
         u11k6jJaoJd5O4LX2MOZV9do/6+mUSralkmx26CiTW6mNCNJgE6taMOIoVFFnIQ492VY
         UEzasPhz4iJukjTQNuBMry2kxRGrnYP+AzwlbrfRiD0Ia2W7fDm5CKAR3kuWjFB813iZ
         S3nTZLPbGpkaxmnB/mc6/zwdjPjP+O0zpUiF1cR9a5BzmK9fKqhKHq93wQQu1eL5Dco3
         /GrgYJaQg9F4Pg21W+gU3RxhulUTFAMvMA4EqLmrH2dm2tU6V+r5UgElCThVW597f5Vr
         g3ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779371286; x=1779976086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x8ZLZpFna8QE3sntZWYFYWQfy/d2E0NvjrGgGfpza44=;
        b=UTsJMzuuHQAqtOdq93EIUbXnw+JhRe8m1vhFuoOsBToOUX6nVXAS+E4mUdvspMZmvZ
         v2IUecR8Ff72x7kIEd3f1N9oRZc1OU6wiUnSc2M/r0UlLVWIyCs6SlJPVvacNa/DPYlp
         zur6ES0u5kPlCA/+V3eeGpxaV9ufHXL9x+2rqpfX+PTd6ZC6qGYI2Ah+7MztTQtkP+9r
         MhDnssl/F0HHZrAwFFu28ie/T5HNAaNupoUw9neYgsxmyvfQyCaxzcPhx4KkyJBoID1s
         U3zIoTAmCu6hO4BkzrsnUYKmExrgd+apa9X+hXWVXehX3Nzb3gKFl5AAmWZjfhIlleGk
         sDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779371286; x=1779976086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8ZLZpFna8QE3sntZWYFYWQfy/d2E0NvjrGgGfpza44=;
        b=jjGkzByTKKmtcuLZ+o0XH1A1aVMVhU9WBiraRIPEqVrvNTFBIvwK6brDsxSiffJz4r
         Q+wE/u4On1krde+ZpNmXLjKb6YOLGBrDmgAjWtvoLmXeOJnhpHSl8dMtn6RzJyyP5ugC
         jz8Veefky6MtBbN8K7CP50pKrXKvOZcyExruRf/YmElErbdFEKOJYQ9qzWUx9bIHRhp5
         HWoXON5RCVMZbnyg0k3x4Cig9gPbxRKtmPQsnv0kukjYql8nOZ8lzDblOiKnla+wL2Ru
         5YfpmBS0svCOCTt0SUUJupAWGOxsKB7Pyk5lK4kngGmf9c8xyBLNl/YgUJagPalpjUZe
         EJwg==
X-Forwarded-Encrypted: i=1; AFNElJ/nwcVfyaeDiH50hquQGCPtIsenlpD53szM4VqBacQym3TgvooEsDIMwUt5ld4D3HKEIvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBVosC5bhjSwbnYR3KzzJ0HkuogHqFUid6jnz2WC+KCfr+NxhC
	DcChkBjqUc59JK/05HF0Zvb/PRnzoeytwxnoyc2RMXmj/IbUGIx/tC+VqzdkcccBuoiNpwe6dcG
	C5elLQzErXXewRRvQNuzS8W2A/yrVw0UMCVFZHuqi
X-Gm-Gg: Acq92OHroPrzw7zgAVOAw5z7Np04HWJZrdPxs1YGfJvVn5qlfnmCtDX95hDbzq+2Tp8
	lTgok/lbhRrpTNmDL9fvvak7iiNexZAsT+9AIA9gued+CO7HU0gZc0PToBBvAAIbXpLZa/DAWw3
	ZmIlamXWiLZYGWzk2jcCcrgau8hh4z6Touid2xeRqP8SpxKuILY5oLxkei6Jh5JZietdgU4IGdX
	ulAr/NNyLIG5h1+GO/32/recPNC9Lz4+GZ5QahvELh7t8ZYDcSHSF0yEU6I+QNlMVOaTuRa+EhV
	smB2vAFFSOFEBL44ouQ=
X-Received: by 2002:a05:622a:9005:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-516c53118ecmr8206941cf.1.1779371285395; Thu, 21 May 2026
 06:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com>
 <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com>
 <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
 <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com> <ag8JIlHjohAOC3-g@google.com>
In-Reply-To: <ag8JIlHjohAOC3-g@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 14:48:00 +0100
X-Gm-Features: AVHnY4IjTx7kpi4F7EdVLun66lc7vUTNuuJ9Vgrkm1t1onCQ9N7OW44CxOISbbA
Message-ID: <CA+EHjTyF19FPod10EEm3pMaPvsAR6HUXOhtC83qSSqxQ2g1s2Q@mail.gmail.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 14:31, Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, May 21, 2026, Fuad Tabba wrote:
> > On Wed, 20 May 2026 at 22:44, Ackerley Tng <ackerleytng@google.com> wrote:
> > >
> > > Fuad Tabba <tabba@google.com> writes:
> > >
> > > >
> > > > [...snip...]
> > > >
> > > >> +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> > > >> +{
> > > >> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> > > >> +       struct inode *inode;
> > > >> +
> > > >> +       /*
> > > >> +        * If this gfn has no associated memslot, there's no chance of the gfn
> > > >> +        * being backed by private memory, since guest_memfd must be used for
> > > >> +        * private memory, and guest_memfd must be associated with some memslot.
> > > >> +        */
> > > >> +       if (!slot)
> > > >> +               return 0;
> > > >> +
> > > >> +       CLASS(gmem_get_file, file)(slot);
> > > >> +       if (!file)
> > > >> +               return 0;
> > > >> +
> > > >> +       inode = file_inode(file);
> > > >> +
> > > >> +       /*
> > > >> +        * Rely on the maple tree's internal RCU lock to ensure a
> > > >> +        * stable result. This result can become stale as soon as the
> > > >> +        * lock is dropped, so the caller _must_ still protect
> > > >> +        * consumption of private vs. shared by checking
> > > >> +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
> > > >> +        * against ongoing attribute updates.
> > > >> +        */
> > > >> +       return kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
> > > >> +}
> > > >
> > > > Doesn't this imply that all consumers of kvm_mem_is_private() should
> > > > validate the result using mmu_lock and the invalidation sequence?
> > >
> > > Let me know how I can improve the comment.
> >
> > Given Sean's context, the comment is good I think. I would quibble
> > with the the "_must_ still protect" phrasing being a bit too strict.
> >
> > Maybe just soften it slightly to acknowledge the exception? Something like:
> >
> >   * lock is dropped, so callers that require a strict result _must_ protect
> >   * consumption of private vs. shared by checking mmu_invalidate_retry_gfn()
> >   * under mmu_lock to serialize against ongoing attribute updates. Callers
> >   * doing lockless reads must be able to tolerate a stale result.
> >
> > That aligns the comment with how KVM is actually using it today. That
> > said, this is nitpicking. Feel free to use or ignore.
>
> Hmm, I wonder if we can figure out a way to consolidate some documentation,
> because this is _exactly_ the same pattern that x86's host_pfn_mapping_level()
> deals with (see its big comment below).
>
> There's also the stale comment in kvm_invalidate_memslot(), which, stating the
> obvious, speaks to the memslot+SRCU side of things.
>
> Maybe it makes sense to to find a central location for one giant comment about
> how how MMU notifier events and memslot+SRCU protections work?  And then refer
> to that in paths where some asset needs to be tied into MMU notifiers and/or
> memslots+SRCU?
>
> [*] https://lore.kernel.org/all/agcbWe8s9lmPuJwG@google.com

This would fix a few related issues at once. sgtm
/fuad


/fuad

>
> /*
>  * Lookup the mapping level for @gfn in the current mm.
>  *
>  * WARNING!  Use of host_pfn_mapping_level() requires the caller and the end
>  * consumer to be tied into KVM's handlers for MMU notifier events!
>  *
>  * There are several ways to safely use this helper:
>  *
>  * - Check mmu_invalidate_retry_gfn() after grabbing the mapping level, before
>  *   consuming it.  In this case, mmu_lock doesn't need to be held during the
>  *   lookup, but it does need to be held while checking the MMU notifier.
>  *
>  * - Hold mmu_lock AND ensure there is no in-progress MMU notifier invalidation
>  *   event for the hva.  This can be done by explicit checking the MMU notifier
>  *   or by ensuring that KVM already has a valid mapping that covers the hva.
>  *
>  * - Do not use the result to install new mappings, e.g. use the host mapping
>  *   level only to decide whether or not to zap an entry.  In this case, it's
>  *   not required to hold mmu_lock (though it's highly likely the caller will
>  *   want to hold mmu_lock anyways, e.g. to modify SPTEs).
>  *
>  * Note!  The lookup can still race with modifications to host page tables, but
>  * the above "rules" ensure KVM will not _consume_ the result of the walk if a
>  * race with the primary MMU occurs.
>  */
