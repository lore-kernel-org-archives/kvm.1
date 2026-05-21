Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988C3D79E8
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779370221; cv=pass; b=DhMq8WqMaqfGsibtWi6HkJHcuTecf3+On1nj1PLFcFP3C3VYOS47fd8e3p8HGwH18igW647Ro1XOvHRpTNGkGp4FTmidHoGka8Gel55vozbpcDUA44zXzUVmuKhgHAZ1LClYdowm4izOO/TYrbIUFMdcUgFF9dy9Ev9mqSe5bMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779370221; c=relaxed/simple;
	bh=rf2fbns6mOkK4Zz993uC2XOU6G08aILoYRXzFHnjEAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOk14B53DS/g8TnfTkON27NNiU0sKWYCH4zrTDNfPw3yaUb6jQQgTCCTC/4/lyOL2Rwm46AN1RxuAr/wMZOwZOgW2onJ9ZbxsOe1+178DbMBhN5vAtonNu7XV43ZlfIeRs9jJ6BqSzOkV5fjEROFeD0mnw6eQ2jcMvjBopx8TUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTO7YWsT; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTO7YWsT"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e61648f10so38901cf.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 06:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779370218; cv=none;
        d=google.com; s=arc-20240605;
        b=OTFpGyWxJUvBGPWCZSNQUvUBsMoPvn2sLR6MMGRtAE4hY32jPLfETwI7MMKf/0XLrX
         6kk+hbcrifF90oJQjl2EKpB5L/U781VA9zjXh3VqgC04fgtIX71juf2eQYYEBl6Iq7hJ
         ePSM2k4pkIeN3GZLLQoVVVjS7DmQPL7XOXWopHRXAr9sudon5mrFFiLYF2uUlxewvY4r
         YgRtjxMOK5UmzDZ8nqDZDAiW3RzR9tn1vEthamz03+Pe9bMWiRas3K58sV3KJTR5c+wj
         tNy++SF3JfO5UzRwBMPI73QsoKnx34ZSO6iO/OatKjKPqbjY5VLAqSuifXIHcPactrlX
         X36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iwMA7nMY573fkX+5mD/InfckLTj4HhiPS4RhTrsDllw=;
        fh=AJuBxMXzH9G26dR0xHa6Gh6L2+TS5wlkmkmHFfTiNbk=;
        b=iZNEvJbJNl7ee3Q7B2DYak9I6IuZtvFBxbH23U/exfm6DgfDT222PIjHCNY1Vx00ZP
         Q/+iqdRfHlcyPboZ2Oa5diFPF4qaFKX8Qmy9WuOx+18ac5ybARrh+ubO7ew2c1j/Qab/
         7l4hJzbykrrvsH8a6ACXOfF7eO0pDcfWSODhpTvh9an2xxylNSzaCkkcinlYhkHHiSrM
         rQfd7P57/qolR0F9LHg0iWmSQG6YxTB9B5p/R7UZY40khjFbmvTs+At8jUPOf/DUCvP6
         MC6zv/5RS/cy9cEEl8eDq2bjX4VcCm+hg87Kk7f42fbz35EWOsFy1gqhsmik5Ljsmhq7
         u1xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779370218; x=1779975018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwMA7nMY573fkX+5mD/InfckLTj4HhiPS4RhTrsDllw=;
        b=RTO7YWsTbnDeSFeAzh011MCcYOZQEReLkZZz6Tg1B8Bg5M3NYvNBJUjEu9TZpf0mkw
         y+TGvH+ZydMOZv7RSPvTR5p6jbqXeO3TzZ0g6C6E5LhZ9rKKQvi6awDHrvfR/VxVMnu5
         tiiE5K/aESAZoIdzB7NMa69VtFTyypDzLPRzclMAdtHu/m/ghPXd1kyuNjDCz2z3GR5a
         6+HV/a8IvyRxpBL5VeKwki33RaA/OrEQXWoIcTOVWKKSJGc36ZT02UePTpg3D9PEuYKv
         0D8tgIw0ZAgCloMGLbcLM3EQBir3pxHrpvlfivooDZXOyQFgQb+sw1CzOaWgCFo0+Xfo
         lwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779370218; x=1779975018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwMA7nMY573fkX+5mD/InfckLTj4HhiPS4RhTrsDllw=;
        b=jgWBJwGMoRyp1EAdnpzcRvu8aYbC5SbD1muyrsDCxVIj4h/oSttGCbzAxjE5ktlmv3
         RO98r6akmNI9m9hLTDF70ZKiwBRd1lC6fVEGHjcETn9StJvJV2/ysiUWyOT9YZlUDeBE
         NDNA+wRLA/OrsZYwyEIBdNZc9oDnQAHb8S0w/6Ju/Ye7ldhz8QiAovZidcYQBqhMKdaL
         W/hJaZtxrYg89RndpkRZkG16EcSanak9wH7FD75jvR1jXT+KoZEi0XGHA0MFjc8dUgCi
         F8jYOgyQwvNVXSYF+eY+YawZ7Fx6r2uIcKPxywj7WC7NJyPSbeSKy9yXxmBfzZPNhzzr
         MfTg==
X-Forwarded-Encrypted: i=1; AFNElJ8I6t363LcOPLMpF9cVSz5PtGfnwPY+tu/dJl5pEwinGDRnE1jCZ9/6MCLVPiDiQhvS0lY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzryek7f3hwBl634DERdXtdgQIaRFUxSmFjGbMmQ8xBV+dWDnqc
	31ysVhknVKLFaNdxv3CZm8nsBynwZtRbsOAVD6hMsu5XGHDqIxeZqWIXehWDtfCQ2mXU53+AuH6
	5zIqFByP2PZZmeZdTQc7ol88ziQkIJGrjrcSqW+rr
X-Gm-Gg: Acq92OHuQ0F5I8QB3qH2rBuaBswcuMgvYGGyWlbUY8fL5aFNijPLcg9SmiE1QcaMEru
	XWfjWskBoHr5k+Sbvsh/TD1v7pFFyZXAfWxesazxTwC/3vXiZyWJ3GpRi4we0gxfIvfdkNZ+dkc
	+ENjFsr0WyCzvIBLqYe7qVNjzNW/W+Ln8ZPtYou9JovH6sgksMuLrX1s5eyNe+Gxoy04pEgcamr
	+JuFFgMROI8xolRcd268DDpp7eH616loIb26DRsT2I0HVi+py0V3DCFaY2eeJM0qUlTl/Lg1CdU
	+SasrpqdSiBGIUuEE/9BMOsdEI0RuA==
X-Received: by 2002:a05:622a:180f:b0:4ff:bfd9:dd31 with SMTP id
 d75a77b69052e-516c52f3a46mr9684061cf.5.1779370216975; Thu, 21 May 2026
 06:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-16-91ab5a8b19a4@google.com>
 <CA+EHjTxcadguOfOo7RpJVtAzcY5JAFZTbrAT_wcN6akMi8gCUg@mail.gmail.com> <ag8BmtzxTlcuA_zy@google.com>
In-Reply-To: <ag8BmtzxTlcuA_zy@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 14:29:00 +0100
X-Gm-Features: AVHnY4LwO5a6KnCwO_nS2hLkyezQ0CT4SoGe3eTfLFP9egS879lHs2YrlxKCX6M
Message-ID: <CA+EHjTwA_qOnbKhGSDxo_nbsXRqTM1zY1Jqs1drn24PTv-fNPA@mail.gmail.com>
Subject: Re: [PATCH v6 16/43] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
To: Sean Christopherson <seanjc@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
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

On Thu, 21 May 2026 at 13:59, Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, May 21, 2026, Fuad Tabba wrote:
> > Hi Ackerley,
> >
> > On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> > <devnull+ackerleytng.google.com@kernel.org> wrote:
> > >
> > > From: Ackerley Tng <ackerleytng@google.com>
> > >
> > > __kvm_gmem_invalidate_begin() and __kvm_gmem_invalidate_end() actually do
> > > not specially handle -1ul. -1ul is used as a huge number, which legal
> > > indices do not exceed, and hence the invalidation works as expected.
> > >
> > > Since a later patch is going to make use of the exact range, calculate the
> > > size of the guest_memfd inode and use it as the end range for invalidating
> > > SPTEs.
> > >
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> >
> > Want to look at what Sashiko has to say? Seems to be a real issue:
> >
> > https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=16
> >
> > If I understand correctly, the fix should simple: use
> > check_add_overflow() to validate the offset and size parameters in
> > kvm_gmem_bind()
> >
> >    int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> >              unsigned int fd, loff_t offset)
> >    {
> >        loff_t size = slot->npages << PAGE_SHIFT;
> >    +    loff_t end;
> >        unsigned long start, end_index;
> >        struct gmem_file *f;
> > ...
> >    -    if (offset < 0 || !PAGE_ALIGNED(offset) ||
> >    -        offset + size > i_size_read(inode))
> >    +    if (offset < 0 || !PAGE_ALIGNED(offset) ||
> >    +        check_add_overflow(offset, size, &end) ||
>
> Eww, TIL I'm not a fan of check_add_overflow().  Burying an out-param in an
> if-statement is nasty.
>
> >    +        end > i_size_read(inode))
>
> This is all rather silly.  @offset and and @slot->npages are fundamentally
> unsigned values.   I don't see any reason to convert them to signed values, only
> to convert them *back* to unsigned values (when stored in start/end, because xarrays
> operate on "unsigned long" indices).
>
> i_size_read() obviously has to return a positive value, so can't we just do this?

lgtm,
/fuad

>
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index a35a55571a2d..9c6dbb54e800 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -640,9 +640,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  }
>
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                 unsigned int fd, loff_t offset)
> +                 unsigned int fd, u64 offset)
>  {
> -       loff_t size = slot->npages << PAGE_SHIFT;
> +       u64 size = slot->npages << PAGE_SHIFT;
>         unsigned long start, end;
>         struct gmem_file *f;
>         struct inode *inode;
> @@ -664,8 +664,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         inode = file_inode(file);
>
> -       if (offset < 0 || !PAGE_ALIGNED(offset) ||
> -           offset + size > i_size_read(inode))
> +       if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
>                 goto err;
>
>         filemap_invalidate_lock(inode->i_mapping);
> diff --git virt/kvm/kvm_mm.h virt/kvm/kvm_mm.h
> index 9fcc5d5b7f8d..3cb5ef86d0d9 100644
> --- virt/kvm/kvm_mm.h
> +++ virt/kvm/kvm_mm.h
> @@ -72,7 +72,7 @@ int kvm_gmem_init(struct module *module);
>  void kvm_gmem_exit(void);
>  int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
>  int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> -                 unsigned int fd, loff_t offset);
> +                 unsigned int fd, u64 offset);
>  void kvm_gmem_unbind(struct kvm_memory_slot *slot);
>  #else
>  static inline int kvm_gmem_init(struct module *module)
> @@ -80,9 +80,8 @@ static inline int kvm_gmem_init(struct module *module)
>         return 0;
>  }
>  static inline void kvm_gmem_exit(void) {};
> -static inline int kvm_gmem_bind(struct kvm *kvm,
> -                                        struct kvm_memory_slot *slot,
> -                                        unsigned int fd, loff_t offset)
> +static inline int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> +                               unsigned int fd, u64 offset)
>  {
>         WARN_ON_ONCE(1);
>         return -EIO;
>
