Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CB35675F
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 13:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455341; cv=none; b=eHSxMhXtABM8a+osyKZc+eDft8LUAAVYUFMTj9Iuc2JS8ewVDdQ+31U9G1V6LbuI0SlOIMxEiAj8jg82jRPGQ9d3qAc+U08ueP/5mX9ILjXtaPPhFHuB7TgTnySdCO60v1wRSWPST9nWFRs84l8Fd54D7mfxJIAVEgMxS87F6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455341; c=relaxed/simple;
	bh=Nnkh6cEEv9vtxmnrirlQm5frPTNIjN27Iy7obA4FAzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8J8U9C5k74kwVk6bcHVmcJqB04F5WFvRqdzD933SXrLFe+2suBnqdbITzuQTlz7Izaw4mHvNq/MkMCZ+N/Qwy5jgnLOV8POQqavCw2UC7ioFo9TkXj3VXLU6kJ+uLppGvPaAQZj4dbiQ/kqY2gGNw8OxpPoX7wTeFPM8ENdEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CkNMB2u7; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CkNMB2u7"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babc42244aso172495245ad.3
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779455339; x=1780060139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWpFds4KLS7xuznWHwB8ePqzzdmaeh02IGD1amL7VKc=;
        b=CkNMB2u77fbFNZvUlG9oIRu7fzdzwvrzm2ioJUFXb+v3VwVG9Q7Gcu3wBa040lGszd
         OnHyxx5Dl5+zv4Hr4sbLpuzu0S9ddO9O520XbbHz/vWz9Ik2VZXmowi7Mm8Nby0QBVfm
         w61MOZy6YwHWYdpXyu8vBWHtJrSt6HtXmk9e0xdOEJwIv5XlTQCOzDcU9RNKg941iV/0
         CwSjpoYW+T7lvY5/0zAealgdYEM3DC3U+HCaIZydESOpNgqe1W6QLJQ3/F7gmc3/6gDS
         cCd14Eid5hvpwrQXe7NHPKIPrVac9dp4HOxo2FtO5e0V1A0DutWwXDqg/mWoT3GruToz
         2Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455339; x=1780060139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWpFds4KLS7xuznWHwB8ePqzzdmaeh02IGD1amL7VKc=;
        b=lFKT73x4doQPb/s+EM8vt2xnv79osZ5ig7xyOaBi00wQb1KhZMp2KH/Gj4Eh2RECu7
         vme+yEtVsQ+zJZwWg9Ymmhl5I0jW64uXElbOko6MRBHtusBfBVQWt7F+3DSgEDj9Zc2O
         jQOyXaMjF7aYOvjUS3GxPExDmg3CmdzaZrAcLdHU58zdkvhgnv4dD3qeIURtoVgl0nmu
         iQzsW7O7NwRWZRMwuLZWuFojkoGfxYAtiYa7dN2DSgqwYHK63ZA1yK9bE5EI/fujpfPT
         urUp/o9sDFIvUiuk4QQsd/B/0bJf9uJaPlb5GhnLDD0ibZuoCpUZGkRzIzcLBdU9BB3n
         HP+g==
X-Forwarded-Encrypted: i=1; AFNElJ8U+jJGbnx7oqoZpKq9yOMhTgfhmM2PX2PFrC1gpecJx++cK1x2P1HtQ8YH7VK2/y2EELY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywiZjH4SQEFfpXMdqlzDuyW+1+xMGYRRt9n+zYEmObODCjtKyt
	XEte0431OQcPkqYnzqGu9vWl52WaSMWoUYzrdWz+zWX1KHLUMmkoE7tddeWlTakkXfaKXz6LcqX
	31XAn/A==
X-Received: from pllk9.prod.google.com ([2002:a17:902:7609:b0:2b4:5bcc:fc4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1246:b0:2bc:90b6:3e6f
 with SMTP id d9443c01a7336-2beb0347191mr37692105ad.4.1779455338970; Fri, 22
 May 2026 06:08:58 -0700 (PDT)
Date: Fri, 22 May 2026 06:08:58 -0700
In-Reply-To: <CAEvNRgFB8ydih9JTmsH06H32j38tH-iViZqN_eZ_gQAmXpw+Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-21-91ab5a8b19a4@google.com>
 <CA+EHjTwrygfMrZZSw4y7-ry8fidW2x0C7iuF2Q=dnPNHUmNtUg@mail.gmail.com>
 <ag8G7Wq5PbEdKloG@google.com> <CAEvNRgFB8ydih9JTmsH06H32j38tH-iViZqN_eZ_gQAmXpw+Dw@mail.gmail.com>
Message-ID: <ahBVajalNaHkNYdV@google.com>
Subject: Re: [PATCH v6 21/43] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Fuad Tabba <tabba@google.com>, aik@amd.com, andrew.jones@linux.dev, 
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
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Thu, May 21, 2026, Fuad Tabba wrote:
> >> Hi,
> >>
> >> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> > diff --git include/linux/kvm_host.h include/linux/kvm_host.h
> > index 61a3430957f2..b83cda2870ba 100644
> > --- include/linux/kvm_host.h
> > +++ include/linux/kvm_host.h
> > @@ -2596,7 +2596,8 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
> >  typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >                                     struct page *page, void *opaque);
> >
> > -long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
> > +long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
> > +                      long npages, bool writable,
> 
> What do you think of need_writable_src instead of just writable for the
> variable name?

How about "may_write_src" or "may_writeback_src"?

> >                        kvm_gmem_populate_cb post_populate, void *opaque);
> >  #endif
> >
> > diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> > index a35a55571a2d..6553d4e032ce 100644
> > --- virt/kvm/guest_memfd.c
> > +++ virt/kvm/guest_memfd.c
> > @@ -858,7 +858,8 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
> >         return ret;
> >  }
> >
> > -long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
> > +long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
> > +                      long npages, bool writable,
> >                        kvm_gmem_populate_cb post_populate, void *opaque)
> >  {
> >         struct kvm_memory_slot *slot;
> > @@ -892,8 +893,9 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
> >
> >                 if (src) {
> >                         unsigned long uaddr = (unsigned long)src + i * PAGE_SIZE;
> > +                       unsigned int flags = writable ? FOLL_WRITE : 0;
> 
> How about using FOLL_WRITE | FOLL_NOFAULT so if it weren't writable to
> start with, don't CoW, just error out?

Eh, I don't see any value in value in erroring out if userspace is doing something
unusual.  If breaking CoW was actually problematic somehow, then sure.  But AFAICT
it's overall harmless.

> Like you said above the CPUID page provided as src_page would have been
> written to before, so it should have been mapped as writable.
