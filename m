Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1FC3612D1
	for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932166; cv=none; b=jz/XvIoJdRh07KkY4QvQ6fUn4UH54vBu87zZuXFK0bJ/hXjNgT/L5rFqpoPlhAXZzuo5pf2nbYojEnM3CzbQkJWOeiyMEqYuEH6cDxk6WM8ZTR7F25lTDaqgYxC2+s2mlMZGeb/X2xD4ST+EPaEWzcRLjTryO8MpgyEB2aVsqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932166; c=relaxed/simple;
	bh=/FKHSebDh4uM8KRSgCLBh88kF8WNt9KU+H2XJiq5McI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VEZCJDDI2ggT6+OLB66Ene5ABTZYcGi1dzf4XYWYnwgMIjAXrAqzIZ9y3mxEOXgacFk16KdQX+zr5fRu8l8UFOf1EzS1nDjBuTaoPmIrwuBuAetoTcDSArQiiZIsF5VvCe17IFtu06L9CdKDzi7yT9542ISMrWk8gShTe+l1X7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gzNg/tko; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gzNg/tko"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34ab459c051so11292213a91.0
        for <kvm@vger.kernel.org>; Tue, 20 Jan 2026 10:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932164; x=1769536964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+J1fLKCCQrvMP0lE2vmpjO31unfE9EFowcfvxhsZP60=;
        b=gzNg/tkozXjXjM21iTaqMyS1inEAMBTDabPCBqA8EH32SNLfodWw2mbABqKLi5qDxN
         Jr9a8Xsv4p3rxd4OmlaaWVCHfxxeGFVKDEIv/Qsz4WzSofWfRGzU97ucz9kIyBKZeWHg
         fiDYl+ch1vXH79EIC/1YX9tSNEz5ktQdBtTKJY2fVphgiU6B6FZjBT5Fz0P7tkqb55M8
         Psp3pU2qFfz2z4szXVorFVuCIIkBgRWCBiv7QR/xPQi+hXJnPj/WDYvsEBEjG10zEFLF
         jAE9cpK09vHrW1zL/B8Z+igGidB1Bja654vdnVPJTRIDDTJi7gvSWqiJ+jwGkRcTpL5k
         QnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932164; x=1769536964;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+J1fLKCCQrvMP0lE2vmpjO31unfE9EFowcfvxhsZP60=;
        b=IA+WgSAaEiDNnYVywrHDmdWUWprdK+8okECYE6qa6hbLbrLsXTW7v0kjGKZWek6bBg
         8KjKLKXE6AeHxk5Uqe2NUkTZblF3gihb2YPuelRWjMQd1neqoa+Z5PqJOwJOIZcbhens
         QqsKXk5MYlzZyDLGZjWwx2uU7Wnt0/YpvtimcUHf1WKNTT9/9xsp0cIn/9cWK/+wT4ip
         dl9ecv4iKT+stzeSCR9TYbSEBq+XS5hGhlrCgiHLtg67oFd27No3Ag+CiHNajhbpJVNv
         pqb9PQtg7QonVp+XDIgOn45QfnC1CapcfdFqv00qboiURyGg3ja8BHkuJr05ZcgxGjEf
         wy1w==
X-Forwarded-Encrypted: i=1; AJvYcCX+h3BFfQsHYyKksmcsOW1aDwaqlcFfyNQS65q1pPCK0ONLO/Zha4SbA26J3H1bHU1kdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCjcyHpuSzKltlAoyCpCvz0sIXlFkntgRewax0/a+yF7B+bID
	zwsHy9fU9Xk8U/+rTDgtP3eRV1IovkN1dg1M1xiL25rdOfJ41Z2KU8ty1il0siiVMkBjGssmR0R
	kJnRQLA==
X-Received: from plru11.prod.google.com ([2002:a17:902:b28b:b0:2a0:7fa1:b964])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f87:b0:2a7:63dd:3496
 with SMTP id d9443c01a7336-2a763dd379fmr24866415ad.46.1768932163760; Tue, 20
 Jan 2026 10:02:43 -0800 (PST)
Date: Tue, 20 Jan 2026 10:02:41 -0800
In-Reply-To: <CAGtprH9OWFJc=_T=rChSjhJ3utPNcV_L_+-zq5uqtmXm-ffgNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260106101646.24809-1-yan.y.zhao@intel.com> <20260106102136.25108-1-yan.y.zhao@intel.com>
 <2906b4d3b789985917a063d095c4063ee6ab7b72.camel@intel.com>
 <aWrMIeCw2eaTbK5Z@google.com> <CAGtprH9OWFJc=_T=rChSjhJ3utPNcV_L_+-zq5uqtmXm-ffgNQ@mail.gmail.com>
Message-ID: <aW_DQafZNMQN5-gS@google.com>
Subject: Re: [PATCH v3 11/24] KVM: x86/mmu: Introduce kvm_split_cross_boundary_leafs()
From: Sean Christopherson <seanjc@google.com>
To: Vishal Annapurve <vannapurve@google.com>
Cc: Kai Huang <kai.huang@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Yan Y Zhao <yan.y.zhao@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Fan Du <fan.du@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"vbabka@suse.cz" <vbabka@suse.cz>, "tabba@google.com" <tabba@google.com>, "david@kernel.org" <david@kernel.org>, 
	"kas@kernel.org" <kas@kernel.org>, "michael.roth@amd.com" <michael.roth@amd.com>, Ira Weiny <ira.weiny@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao P Peng <chao.p.peng@intel.com>, 
	"francescolavra.fl@gmail.com" <francescolavra.fl@gmail.com>, "sagis@google.com" <sagis@google.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Jun Miao <jun.miao@intel.com>, 
	"jgross@suse.com" <jgross@suse.com>, "pgonda@google.com" <pgonda@google.com>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026, Vishal Annapurve wrote:
> On Fri, Jan 16, 2026 at 3:39=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, Jan 15, 2026, Kai Huang wrote:
> > > static int __kvm_tdp_mmu_split_huge_pages(struct kvm *kvm,
> > >                                         struct kvm_gfn_range *range,
> > >                                         int target_level,
> > >                                         bool shared,
> > >                                         bool cross_boundary_only)
> > > {
> > >       ...
> > > }
> > >
> > > And by using this helper, I found the name of the two wrapper functio=
ns
> > > are not ideal:
> > >
> > > kvm_tdp_mmu_try_split_huge_pages() is only for log dirty, and it shou=
ld
> > > not be reachable for TD (VM with mirrored PT).  But currently it uses
> > > KVM_VALID_ROOTS for root filter thus mirrored PT is also included.  I
> > > think it's better to rename it, e.g., at least with "log_dirty" in th=
e
> > > name so it's more clear this function is only for dealing log dirty (=
at
> > > least currently).  We can also add a WARN() if it's called for VM wit=
h
> > > mirrored PT but it's a different topic.
> > >
> > > kvm_tdp_mmu_gfn_range_split_cross_boundary_leafs() doesn't have
> > > "huge_pages", which isn't consistent with the other.  And it is a bit
> > > long.  If we don't have "gfn_range" in __kvm_tdp_mmu_split_huge_pages=
(),
> > > then I think we can remove "gfn_range" from
> > > kvm_tdp_mmu_gfn_range_split_cross_boundary_leafs() too to make it sho=
rter.
> > >
> > > So how about:
> > >
> > > Rename kvm_tdp_mmu_try_split_huge_pages() to
> > > kvm_tdp_mmu_split_huge_pages_log_dirty(), and rename
> > > kvm_tdp_mmu_gfn_range_split_cross_boundary_leafs() to
> > > kvm_tdp_mmu_split_huge_pages_cross_boundary()
> > >
> > > ?
> >
> > I find the "cross_boundary" termininology extremely confusing.  I also =
dislike
> > the concept itself, in the sense that it shoves a weird, specific conce=
pt into
> > the guts of the TDP MMU.
> >
> > The other wart is that it's inefficient when punching a large hole.  E.=
g. say
> > there's a 16TiB guest_memfd instance (no idea if that's even possible),=
 and then
> > userpace punches a 12TiB hole.  Walking all ~12TiB just to _maybe_ spli=
t the head
> > and tail pages is asinine.
> >
> > And once kvm_arch_pre_set_memory_attributes() is dropped, I'm pretty su=
re the
> > _only_ usage is for guest_memfd PUNCH_HOLE, because unless I'm misreadi=
ng the
> > code, the usage in tdx_honor_guest_accept_level() is superfluous and co=
nfusing.
> >
> > For the EPT violation case, the guest is accepting a page.  Just split =
to the
> > guest's accepted level, I don't see any reason to make things more comp=
licated
> > than that.
> >
> > And then for the PUNCH_HOLE case, do the math to determine which, if an=
y, head
> > and tail pages need to be split, and use the existing APIs to make that=
 happen.
>=20
> Just a note: Through guest_memfd upstream syncs, we agreed that
> guest_memfd will only allow the punch_hole operation for huge page
> size-aligned ranges for hugetlb and thp backing. i.e. the PUNCH_HOLE
> operation doesn't need to split any EPT mappings for foreseeable
> future.

Oh!  Right, forgot about that.  It's the conversion path that we need to so=
rt out,
not PUNCH_HOLE.  Thanks for the reminder!
