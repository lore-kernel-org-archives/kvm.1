Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26470330D2A
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857355; cv=pass; b=RLWaLK3qTjCwREzP2c+xMQEF4kG/COV5XBFs+xkflYY2KZnqkckwjHJ0JC2zVIPYLfv6fTVifmJcNZIcyHpIHY7bmVdLOZJKY6AUY6p9COkemew8zEr26/QuR3w8lmUqffkDTRgEMPbC/KdQzJ+CnZMbSclnshUSu28q74BYq+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857355; c=relaxed/simple;
	bh=8G3Iesv6H4uuh2/K8K/iWGA8fNXhb2ucD0ih1NRqF2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA49crWIuVJAaHCMT+1hDbCj0CTtBG5Av1iibQYMcY10eBkJn+HzkdB0VVrTREFxshcaX73KdDOg5yUPWQtlct0BaIlCfroyEO/qDV9shSVWIaA+651rCosVJiNksRiar74nYx0vUBqSFnehUHi1gr0EsUapKvz7JE7Ml4Rla8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/tHg6j+; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/tHg6j+"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5177d1ff061so115801cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781857353; cv=none;
        d=google.com; s=arc-20260327;
        b=Yhg+hAYBETk6oC8Tl/f1uej42YnHY2QQ++Rp8lyHAFyR9SNPym8MU0PgsG8KHwarkl
         383/gW16JWSsPF1P+IuKVvzBmLD7P6iwviDttFzXJES4RRSJw44wmNfU73hFHXgRBiND
         09jrdWm5iyfGLP3hfjxt/tE3s8lO9RFsWEn4HZDicFwOM8/Ye6frvg/k8aHrd2d/QqZE
         M+PzJh1r6rLhc/YvE6D+QahsvA4Me2mJ9rD+GEE03LMOpdEWzh1Z8O4XeOpBjc2N0jOI
         ScF2uhW2an7JXsTnJtew4mw/LRVmSuIPvXkxen68VPF6J+BaR4AMWmfGRjXUcF8c7gO8
         kLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WecHCv13rG5Qr395P8gqLpoRjr3ajKQ15qH0wjMFBvs=;
        fh=sO9AoZg7ERVnnJiJqOo1mOcSzy3K6kkyNYASMlEgGsA=;
        b=XsuHZabjslTHYXSA1dOL1N0BsLBv4zp52gCkAKboj8P2lMuEBAQ2ONzjaingoq55Ut
         yEPgeXkYq6s/g99wb8LSQxbAwPbReruJQaWlMFQSnjNsH27UabHV34/hS6iILn1UO8en
         FMhYY2k+6Btq6dXwRr6pKpMj/Nc8d4VDEO5o++OcPah9iUo6dUU3kNKxFL+sPCMCfU2Z
         wIkkex2UuKby+Fy1kM3a0efSwHgogwtWcMrYVM6cthTnORQwTpEU9ZL6AdQy1Os2O4+j
         iBIQRVVQJy7za6EoYPrYeVzPK4xS3WivT0xH21/H5SXL+tv8wNGsZ5M67RS4NYokB64e
         OUeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781857353; x=1782462153; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WecHCv13rG5Qr395P8gqLpoRjr3ajKQ15qH0wjMFBvs=;
        b=M/tHg6j+C6Vqmb/h1lmvTrgicl8vxiiubgA1EJ+cghpMBmPAQeFLRb4qCFDjAs5lmJ
         Z7pzAd/CL2EhpDHkaENZPa7iepzhfPWHHVx4xagYiJ+AGu/6ykTbOCZyWzum8UoUhs1t
         YS0MyqEUR4MjiRqyIFBFrGQ76ZDD4MTTCABWChiekxTXWqdfB2bAJRJtIgN34ew0SD+X
         2cF3mifgNEivRi1v5D0n76RSKqlY+iuWu02K0Nvhacpop1TvVZl75YlzAkMugSp2PQyk
         1Gd2nQhKkiHpxkfOnGZUUvyHLz5kXGhLyALD0aQxxPem3zzbBj74S/5vya2VGnip//EZ
         kHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781857353; x=1782462153;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WecHCv13rG5Qr395P8gqLpoRjr3ajKQ15qH0wjMFBvs=;
        b=iBgrW5MTkzDrpovMLK8zeu25Cv+ytx8xIMbA6zM0Zpj+ntDEDFAAmQM3DXvyJVJN0v
         FRyNokfh6U6ftOsRZv5qI4gOPlt55v3yBarSIvFgnlTZhO6L+jH0/yyOvKNtmTImEQdd
         rkmp3K9dPL8PvFcirN1jfyXb8Ct3wwEoGDdqsQb3rszVL5K2k7Ivfx3E45tD2MRLUPNh
         YOb/9lahy8G1ztdIKR3/P/+w2xIMshwRUziMF4f7PspgEw39rsrmyFKA2bZQbjW/hj+B
         LHUjRYNr03jlcL81DFw/OL8RStvumo3YEo95+zW0r2eoSVxWHmEKpDFQtCln4KBAab4y
         UnYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RX+dOZvN28752WY4KIty71WrqqFo/rlGtJ9MNIQq3DiAELQFrZY4NGQyez4EjFvGNkSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3osem2JIrdhml4UsROZeUUt3wt0dnMd1a9NWy6/FJj3TTUJM
	4mWnW6Std+6Lr5iO5K8peVa7wVBxaY8oXyc7Gvl9pJ1HsKQJjFOL4T6gnkkV5/BlB/EDmLMDtPd
	SBQifi5OFhYvKTjMZYs739vCFVMdAu0W5N9ovwT35
X-Gm-Gg: AfdE7clmiWDOW1TYSaHpqzWLX/A2RSseg7GXjGiBNh7wwWlGpVAnFpwxWITx9yqINpY
	SNkrNCAdZqwfTrEXz2eorFDsjrKMftv7MrleKYmZ0+axwHOvZsHeepznmICjNPn8EBn1KzB0bFN
	quiBy6uA3zvRCvaSSknxVXdjJz3x9DWHdc0FNmfZmkfFoHxuePGw51j4Yb1B8lI0p16xIohYBus
	ldWVaz6uNZqgq/LCzpYeTN7Y8HcfSDZvwwiDipy7uHYHjsNpdya5+LXcVsjVEfjzgcTxpQd2ubI
	3nVQ/g7g
X-Received: by 2002:a05:622a:1b1d:b0:516:3def:1cf4 with SMTP id
 d75a77b69052e-519e877e8c5mr4724561cf.1.1781857352209; Fri, 19 Jun 2026
 01:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com> <CA+EHjTw6x-mxDnJjnhE-6SV73tMrb0paKDTtOC2j6zJ1fXZDLA@mail.gmail.com>
In-Reply-To: <CA+EHjTw6x-mxDnJjnhE-6SV73tMrb0paKDTtOC2j6zJ1fXZDLA@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:21:55 +0100
X-Gm-Features: AVVi8CebV0NVi3MbMdc8DhRrav01L0h7Tt3z2YxRqWoRJXqhOu4WExRErk69dGE
Message-ID: <CA+EHjTxu32nQ+vPV7Zmcw76_-V4g2_g=P_UzRnnO2dP1PFO2ww@mail.gmail.com>
Subject: Re: [PATCH v8 08/46] KVM: Provide generic interface for checking
 memory private/shared status
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

On Fri, 19 Jun 2026 at 09:19, Fuad Tabba <tabba@google.com> wrote:
>
> On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Sean Christopherson <seanjc@google.com>
> >
> > Introduce a generic kvm_mem_is_private() interface using a static call to
> > determine if a GFN is private. This allows the implementation for checking
> > a GFN's private/shared status to be set at runtime.
> >
> > In preparation for choosing implementations between a guest_memfd lookup
> > and the existing VM attribute lookup, rename the existing
> > VM-attribute-based check to kvm_vm_mem_is_private to emphasize that it
> > looks up VM attributes.
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>
> (SoB fix plz)
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
>
> Cheers,
> /fuad
> > ---
> >  include/linux/kvm_host.h | 12 +++++++++++-
> >  virt/kvm/kvm_main.c      | 15 +++++++++++++++
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index eb26d4ea8945a..3915da2a61778 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -2546,7 +2546,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
> >  bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
> >                                          struct kvm_gfn_range *range);
> >
> > -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)

Should have read the Sashiko review first, but where is this used?
It's not used at all in this series...

/fuad

> >  {
> >         return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> >  }
> > @@ -2557,6 +2557,16 @@ static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
> >                                                   KVM_MEMORY_ATTRIBUTE_PRIVATE,
> >                                                   KVM_MEMORY_ATTRIBUTE_PRIVATE);
> >  }
> > +#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> > +
> > +#ifdef kvm_arch_has_private_mem
> > +typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
> > +DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
> > +
> > +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> > +{
> > +       return static_call(__kvm_mem_is_private)(kvm, gfn);
> > +}
> >  #else
> >  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> >  {
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 6669f1477013c..8b238e461b854 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2627,6 +2627,20 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
> >  }
> >  #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
> >
> > +#ifdef kvm_arch_has_private_mem
> > +DEFINE_STATIC_CALL_RET0(__kvm_mem_is_private, kvm_mem_is_private_t);
> > +EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
> > +
> > +static void kvm_init_memory_attributes(void)
> > +{
> > +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> > +       static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
> > +#endif
> > +}
> > +#else
> > +static void kvm_init_memory_attributes(void) { }
> > +#endif
> > +
> >  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
> >  {
> >         return __gfn_to_memslot(kvm_memslots(kvm), gfn);
> > @@ -6528,6 +6542,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
> >         kvm_preempt_ops.sched_in = kvm_sched_in;
> >         kvm_preempt_ops.sched_out = kvm_sched_out;
> >
> > +       kvm_init_memory_attributes();
> >         kvm_init_debug();
> >
> >         r = kvm_vfio_ops_init();
> >
> > --
> > 2.55.0.rc0.738.g0c8ab3ebcc-goog
> >
> >
