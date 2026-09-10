Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1CA5616A5
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069261; cv=none; b=UmV3xZ1y/1N4IPJ/eFUAfL1tr/Vc+JkWyz6AiAfc4qlXBGjj93av7dDKG3POXCIGqhdaKsHhoS5jOuydlxPBgDtBslgSWQ4NnGzRQbivapWO3SWqft5sphu1yrHtFogF7EaGBqbTD2hCiE/R35lPyirffFtV+6IhBfjGoPrIP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069261; c=relaxed/simple;
	bh=sWES5GzN2OM+Ii15B8E62bMhDC2BenzHZ4gqkrhblUU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=geut9Z/nZ/jozh0Y4MlrUrrBWSEs5Kvz3jyTBCVXQgjYIJDMlnpHXPqaERpIrQll20JdpSFX6Lx0Gmmqi2xHKxB6bNSlbJlSEQmNMOIHEV/PfXaj2Am1qp1CvCNZFOMzrfLvhy61X0TbFCkGiIt6ZLzvYXvh9wG6KsMwGR1orSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ig5j8fpW; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ig5j8fpW"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so221834a12.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789069259; x=1789674059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wTqHNT7a66b+hUhj9EbNAk2o66nIbGOCLKCO5Ek1p00=;
        b=Ig5j8fpW4slpLX1HsmiTPBLuHggBH9GVjTn7y+FTRtQ+TYN8LQ6EJpix1cOLgc7XvB
         rLd9+Mw460JO1JEvRH/F8lZVnuXv1TaEsvEwtQvs2ePzHUf85CSLa8LlB8dqsT70OfDh
         nkP2BNmmbhIK//fZeOIgnojJ2yBMmiywIZvTv4cmbe8bxJlWO+vu9pAiskPzC9y3ZBdd
         JPRB7X2Nojb0M1x7hN6qU+7u3hDH5obWLNaS0si/t+5PJ/ZROTtb5JYMrajblUPqnX1O
         jXsl6GxijU8Wq07MMxqfIzf4Mx5MbOUQhnza8VcmQJ0stiV18eXTA06na/0NW31w7/BQ
         4zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789069259; x=1789674059;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wTqHNT7a66b+hUhj9EbNAk2o66nIbGOCLKCO5Ek1p00=;
        b=EXvBB7pjOAcR1uVJ/SD14yY8aLjoeWmrWWJqmmJvRbrH5rmy1sGIGRMfZXnsb4814m
         O1fWdd1zeqKAZxDOf8Nrv/xrZf1JWv2VW8J4tiVEkPS0ReQTYiBwYf4oiS29C/kqsdoi
         r2HpfbfyHd1M7sgca4L+XH86uL5vcoseqE6VASyysYSlbFlsD1I8ze4PiNdzJad3lZIV
         6YMP7T+hp7qPcpd3OvMhTuP4ECYMnoaDqygqZ5Mw8WLEnRU4vWNtxcU8ietQfM8Dq0Q7
         RuH93J+R/SLSSyQqAcyzifFUmdygUwYcrdeSqjoCMm0UY1GrUBcw2V/7dAUUBOofl5cW
         ziGA==
X-Forwarded-Encrypted: i=1; AKwUvBzKlXzlIVmp8Ygg1DXRYZ7a0RHIMeErq/moFGFOK63qXMqbCOvVHWZH49Jy31GosqXeM4A=@vger.kernel.org
X-Gm-Message-State: AFuF++m2nQWyMF38mRTc9o0q4DliJdzwoiA6aU7+FsuOpo9bSFBz9oLH
	kF3ufVdiH4LCOYxjDmz0X0KysRap1JjStlY9Lzx3kzRNZu1GpuC9Pdm30chZKFrMBYeJpLwf+Fm
	dDBol5A==
X-Received: from pgbcf1.prod.google.com ([2002:a05:6a02:841:b0:cc4:bd4b:9195])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3947:b0:3d3:b00a:7082
 with SMTP id adf61e73a8af0-3daed42b98emr813754637.28.1789069258885; Thu, 10
 Sep 2026 12:40:58 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:40:58 -0700
In-Reply-To: <aqMBidJ_96qroogH@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260908132838.2116068-1-jmattson@google.com> <CADrL8HW3Q=8eBf-=h6BAPdUN_X1Z_-KG=i5a5rA2kF+V4JURww@mail.gmail.com>
 <CALMp9eRJXozpUpdOhqDCWn7VbqHb9G9hn4aZnxS_fef4ad1yTg@mail.gmail.com>
 <aqGsukcRG6khmxpt@google.com> <CADrL8HWRjzzs7YmNkGDYQWDnygw=OcdgqCWCOfdt9af0-XwvVw@mail.gmail.com>
 <aqMBidJ_96qroogH@google.com>
Message-ID: <aqMHygGz8CBJjRF8@google.com>
Subject: Re: [PATCH] KVM: nVMX: Don't flush shadow VMCS12 to guest memory
 during vCPU teardown
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026, Sean Christopherson wrote:
> On Thu, Sep 10, 2026, James Houghton wrote:
> > On Wed, Sep 9, 2026 at 12:00=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > If the above works for PPC, then KVM can nuke memslots before calling=
 into
> > > kvm_arch_destroy_vm().  x86's asinine memslot deletion in kvm_arch_de=
stroy_vm()
> > > needs to be addressed, but that code exists purely to do vm_munmap(),=
 and can
> > > and should be moved to kvm_arch_free_memslot().
> > >
> > > All that said, I'm not sure this aggressive fix is the right thing to=
 send to
> > > stable@.  For that, James' suggestion of hardening KVM's usage of
> > > __copy_{to,from}_user() seems like the best blend of being comprehens=
ive without
> > > being overly invasive/risky.
> >=20
> > This seems kind of nightmareish to backport; there are a lot of
> > copy_*_user() callsites that will need updating. Maybe I have a
> > different idea of the diff you're suggesting.
>=20
> Nah, it's not many, because it's only the __copy_{to,from}_user{,inatomic=
}() usage
> that needs handling.  Everything else is strictly scoped to an ioctl, whe=
re (a)
> current->mm can't be NULL and (b) KVM doesn't make any assumption about t=
he address
> space.
>=20
> At a glance, it's 11 total: 5 in virt/kvm, 4 in vmx.c, and 2 in PPC's boo=
k3s_64_mmu_radix.c.
> Well, plus 4 more to also harden {,__}kvm_{get,put}_guest().
>=20
> And even if that number were doubled or tripled, the backports would stil=
l be
> relatively easy.  The overwhelming majority won't conflict, and the few t=
hat do
> should be trivial to resolve (more than likely, simply drop the change).

To clarify: my goal isn't to harden literally every uaccess in KVM, just th=
ose
that have a dependency on memslots, i.e. are accessing guest memory.  Those=
 also
happen to be the ones that are often buried deep in KVM, in widely-used API=
s.
