Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ACE46D089
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651078; cv=none; b=M1QFqeZdg7/QA+ImAKnh4nh0kmMFHhjPy3X8AMO7WXEV1GthIfHTSFIv0Cxh5/h8bJG2FPsUQZuCBzPWFecYBvKy1UaJ+03z1RLSsbuFOk/4zDP9Zv6nu7/QVviYhHvx0CxPqjaFZR85IeacoKIXeToMKIJgfwokXPXVRH3jT9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651078; c=relaxed/simple;
	bh=TYfAP+74vBCCsUigVTnbhVOVRcXjnW07JswAkwGJyO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uLWIXt5YtcL/hWBevmqRfM7qXBxR0bnu/zjy+fjDUynGo3ozII26CIHRINKzytQAkN96mU1oT6oaQ1o18FTSuKXQ5aCK0NY4ycz8iDrNPprGMbWhSrddTvENRhQlfuCkLkXAgNwx8IIUBihMn+16BYKniwVFxB2I/2kpzUDXNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQouBLpv; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQouBLpv"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so8123613a91.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784651076; x=1785255876; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtVmVSG4I9ujaLUGsuyEZa4EPlkpbcYcGKU3Nmqu/GA=;
        b=AQouBLpvaF5gYYr2vFFNw4ze13s3N/MrKV36JtuZ1ADUja9MeNOGqBVh0ptYi5TqCj
         IyGFyvfh1/3aL+W+vCC+GlrUot/9MdJ9DHkHXfh2ilgR+b07ZPMCg7pjX6DS+5jxQKaB
         ypCXhB5HtI1X0RGI2V2dfut0bCN/z6iBctebrilEozK7r5KVGY9zS63FnIIM5Fvie0hV
         LDqQo0yFjJseJ65nOKwPlAhN5LdSt6ay++AkEm2Ej7hoOlsyefCrWAueoiXPq0iHC1RM
         s6Erymm25WWUVViaQ/yjb6oCiLMMulCbH9G7ajqzhnE964VTCLuVEdcCGAz8XS1VA6V+
         ReDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784651076; x=1785255876;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtVmVSG4I9ujaLUGsuyEZa4EPlkpbcYcGKU3Nmqu/GA=;
        b=aYk/pzcGmyW2bfgYwFZFX1swuZOLnmFhrgBB+/8vla2/Lj4Wmc745f0LKnIhk5ciIl
         UetstRAmDbKPMcz7EeAigthTIDS/nu+AJZ+H2O9maI02so+mBCTgkJMmFOBnjWWVIMTL
         1P/ftUfj1C4/ss4lkKGEciaJFn1rFMqoRdh/b8NzMg2wnBI8T+FwbMoADMcQGwCPd+k6
         0qUF6Qdw/lP+9iWeLURuSu13jLckp6NQAjwTigRKFPx+jvBP/lJ4QhhGXGcfhVLggDSx
         sbSCpL83dw2mseT+q7G+t5GlhMhgHM5cfg40O4GpbTPeatGS25C/sieEmF1/4ShkP+6Z
         Q6VQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgqmCJCAKHIggDd5mY4kgaPiNf/h0PV2U8u4hXNUayVsrIIleBSb5/YLfrXD4SEYCD0Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCJTd2u6L4Y03A+bLjv+DD1RkLIQ1xFso2R9eVSY4/v0rnkul
	+/m2rLWwhWgq3HQShFPrlVY2KkaqItHIKJt8CDKtHqZWTb2n10VaIU0Cv/qwNRaMRbQaLfDLHPo
	bhIBv2Q==
X-Received: from pjee4.prod.google.com ([2002:a17:90b:5784:b0:384:e0b1:c3e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d4c:b0:388:cf45:d72c
 with SMTP id 98e67ed59e1d1-38e4b431200mr21621811a91.15.1784651076185; Tue, 21
 Jul 2026 09:24:36 -0700 (PDT)
Date: Tue, 21 Jul 2026 09:24:35 -0700
In-Reply-To: <36036850-2d73-4c0f-84bc-64ba542ba425@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714231015.3337831-1-seanjc@google.com> <20260714231015.3337831-8-seanjc@google.com>
 <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com> <CAEvNRgGz_Qm1z+e-7Rh2OZ1bfjVBMEB91-Ki+3Vi3mBf5uMdiQ@mail.gmail.com>
 <36036850-2d73-4c0f-84bc-64ba542ba425@intel.com>
Message-ID: <al-dQ1EBD272HY4a@google.com>
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Xiaoyao Li wrote:
> On 7/17/2026 5:42 AM, Ackerley Tng wrote:
> > Xiaoyao Li <xiaoyao.li@intel.com> writes:
> > @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
> > kvm_memory_slot *slot,
> >   		folio_mark_uptodate(folio);
> >   	}
> > 
> > -	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> > +	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> > 
> >   	folio_unlock(folio);
> > 
> > I'll move just this renaming to [1] like you suggested.
> > 
> > I think it's okay to continue to always call prepare_folio(), and within
> > the prepare_folio() function, only do conversion when the CONVERT CONFIG
> > is defined.
> 
> I don't think so.
> 
> This patch not only renames kvm_arch_gmem_prepare() to
> kvm_arch_gmem_convert(), but also adds one more parameter
> 
>   'bool to_private'
> 
> and hardcodes the new parameter to true. This mean the arch callback will
> convert the folio to private unconditionally in kvm_prepare_folio() when
> CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT is enabled.
> 
> Note the CONFIG is not a per-VM thing but a build time thing. The
> unconditionally-converting-to-private semantic can also be applied to
> gmem-only memslot for non-Coco VMs whenever the HAVE_KVM_ARCH_GMEM_CONVERT
> is enabled when building the kernel.
> 
> Though the code won't do anything for gmem-only memslot for non-Coco VMs,
> the literal semantic of the function and parameter is wrong.

Agreed.  How about I add a patch to guard the call with:

	if (kvm_arch_has_private_mem(kvm) &&
	    !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
		r = kvm_gmem_make_private(kvm, slot, gfn, folio);

which is semantically correct pre-in-place conversion.  And then when in-place
conversion comes along, that will get switched to:

	if (kvm_gmem_is_private_mem(inode, index))
		r = kvm_gmem_make_private(kvm, slot, gfn, folio);

Which IMO yields a very clean and intuitive diff.

Actually, even better would be to insert a patch to provide kvm_gmem_is_private_mem()
and kvm_gmem_is_shared_mem() as part of this prep, and pull in "KVM: guest_memfd:
Only prepare folios for private pages" with a massaged shortlog+changelog.

I.e. have this at the end of this prep work:

static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
{
	return kvm_arch_has_private_mem(kvm) && 
	       !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
}

static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
{
	return !kvm_gmem_is_private_mem(inode, index);
}

	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
		return VM_FAULT_SIGBUS;

	if (kvm_gmem_is_private_mem(inode, index))
		r = kvm_gmem_make_private(kvm, slot, gfn, folio);

	
And then "KVM: guest_memfd: Introduce per-gmem attributes, use to guard user mappings"
isn't changing the semantics of the callers, it's only changing the internal
plumbing for PRIVATE vs. SHARED.
