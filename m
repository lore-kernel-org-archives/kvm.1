Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CAB3F787E
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300681; cv=none; b=Gds1JJmeaxUKmwIEO6S78Y1sswc3aCOVoUFGDQ/UIVOQsRz5Px5JKWmvuVr1rf4d74BxlLAdLsXnD2zJM915raGmZDp8XOu+gbCKzoZ8ktJ4oxSfWhTN339hfLSvAV4iqNIf4ovnyemp0znsK13nykXqsOdf+pDWSS+JYKHLtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300681; c=relaxed/simple;
	bh=F9EAa2fqZKdVWRREy2SptPZ4rR4Fj77slKy/QCP2Jng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GEmBJckvh9JVyuHWnmzs1XAurWmkkwiv9ZcxQAyOJdHXNIsglNFHYfgXK1y0gwaFk9cCVFurATbZvCM3SPmxnNW5ugV/W90ZAuVYh5203vGMz8wveZxK4knkEhpDaKtywlKFBM11J/nTdf+DKBEH8lyonMEKwpjipWBOeebkXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNt9/q6u; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNt9/q6u"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8354503d9acso6937809b3a.1
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779300680; x=1779905480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ral3wdnykP2fUONSZPffUp/laMD2JLc4A4V5t1qiuyw=;
        b=DNt9/q6uzYbgW+Q9wdHIN7wQu3+JzFofSXz7TCA7nHMlx+8xSt2VkXQAOtmy3wmgi7
         38qgEE5Xwj4/vQaWrRUN+BhtTZm8mmLR1RQ407ybsQBSTENN2/QJE7u306zffmDaKKeS
         bFlJ4RCoUxbOwsgHIg5kSMd1nhPBsZ9+YZAjYP31ZRmkkAnH1Q5lrq7GUAfauoikCd20
         QhTIrdsA9gd3HNA6BNRf6rPlYBdBO+2n8XahdRmklolpnyH0dGkuChL83wgRdFp+7Wt7
         Wb4PNd4YUZ4a794cKXI1o3ro2K6rSKegLbirwmaHTlTdlOtHWKgz3tvsRoocwcshJUZ0
         GGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300680; x=1779905480;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ral3wdnykP2fUONSZPffUp/laMD2JLc4A4V5t1qiuyw=;
        b=bh0y4M6JzvJewTXMXjZ/AQM6GmKkcttIOk2jF6qnWY9mBy2zw0Usdr8jMv/3hpouoC
         29ngavIQf6rjXLEhmmfOAiIEqEbo+UmLZ0kEaKSIUvvy0nYVXLR1aI7I5oA3NyhIMig9
         oeKrsdE6rQNsl2s0UVi9XcIJiOdIDF5VUMtb54VUfS/pX5EeG1TaQBBg0DNi29kzWOMK
         5j29zf8er4MJ5toOyHY0QKZRquZwiOUiRZTRlA1GYx8DMyXZ9mNbCIO7C/bztt0VVbf2
         XFd+e9e8PmtXi2ieSXRQK5plri1fF8sTSwuUOZVd0MblFQPxhY6sPvAEo3ly2MZMD6eH
         ZzTg==
X-Forwarded-Encrypted: i=1; AFNElJ+uEU9EKgv2h7HgiGRkPrFKveP0Jbr+sQfgbDY4+MAbQFAnKJT5kAYdFcUO4Mm4WZ1NPR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsd6wZds/jx4Ik8tkYwtXr73wkPVQ4nmCdpPy/Uz7hdNbEEy4i
	N7WO1a29bT5/8nY/hibfl8TxZG03rr/QRVfUVCy7eA00wk9sHPov9ouHRDtnadd82Xm4dNWM6iu
	spADM4A==
X-Received: from pfbby10.prod.google.com ([2002:a05:6a00:400a:b0:837:b0a7:c3ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca4:b0:838:127d:a161
 with SMTP id d2e1a72fcca58-83f33b328femr23678520b3a.18.1779300679491; Wed, 20
 May 2026 11:11:19 -0700 (PDT)
Date: Wed, 20 May 2026 11:11:18 -0700
In-Reply-To: <4a918cb38dccd4ef7a2d84d16f5044472d069f7c.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-16-seanjc@google.com>
 <074e209fe4c78a735868099f13d76b9dde2c88e3.camel@intel.com>
 <agx77QB3UVmJr5xP@google.com> <729c4191d16e4c768c231ffb9bb8420306039210.camel@intel.com>
 <ag0NlJ2FEIL7GJIj@google.com> <4a918cb38dccd4ef7a2d84d16f5044472d069f7c.camel@intel.com>
Message-ID: <ag35RgwowvR9Q4hA@google.com>
Subject: Re: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, "paul@xen.org" <paul@xen.org>, 
	"yosry@kernel.org" <yosry@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026, Kai Huang wrote:
> On Tue, 2026-05-19 at 18:25 -0700, Sean Christopherson wrote:
> > On Wed, May 20, 2026, Kai Huang wrote:
> > > I am not sure whether there's a mandatory requirement that "struct kv=
m_arch" and
> > > "struct kvm_vcpu_arch" must be fully embedded, and it would be kinda =
painful to
> > > covert to a pointer (e.g., there's kvm_x86_ops::vm_size), but perhaps=
 that is
> > > also an option to consider?
> >=20
> > The idea I had in the past, and where I was going with things before s3=
90's love
> > for arm64 came along, was to add a kvm_arch.h in arch/<arch>/kvm, and h=
ave virt/kvm
> > include _that_ instead of kvm_host.h. =C2=A0
> >=20
>=20
> Not sure whether there's other code doing so? :-)
>=20
> > That way we don't need to make any fundamental
> > changes to structures, but we can still significantly cut down on what'=
s exposed
> > via kvm_host.h. =C2=A0
> >=20
>=20
> Yeah.
>=20
> I saw below from you in [1]:
>=20
>   --
>   We've explore several alternatives to the #ifdef __KVM__ approach, and
>   they all sucked, hard.  What I really wanted (and still want) to do, is=
 to
>   bury the bulk of kvm_host.h (and other KVM headers) in virt/kvm, but ev=
ery
>   attempt to do that ended in flames.  Even with the __KVM__ guards in pl=
ace,
>   each architecture's kvm_host.h is too intertwined with the common kvm_h=
ost.h,
>   and trying to extract small-ish pieces just doesn't work (each patch
>   inevitably snowballed into a gigantic beast).
>=20
>   The other idea we considered (which I thought of, and feel dirty for ev=
en
>   proposing it internally), is to move all headers under virt/kvm, add
>   virt/kvm/include to the global header path, and then have KVM x86 omit
>   virt/kvm/include when configured to hide KVM internals.  I hate this id=
ea
>   because it sets a bad precedent, and requires a lot of file movement
>   without providing any benefit to other architectures.  E.g. I hope that
>   guarding KVM internals with #ifdef __KVM__ will allow us to slowly clea=
n
>   things up so that some day KVM only exposes a handful of APIs to the re=
st
>   of the kernel (probably a pipe dream).
>   --
>=20
> I haven't looked into details of your #ifdef __KVM__ approach yet, but se=
ems you
> don't quite like moving KVM internal staff to virt/kvm/include/ ?

Not for arch code, which is the trickiest bit to handle.

> But if we want to hide KVM internal structures, I don't see any other opt=
ions
> except virt/kvm/include/ is the place to go?

arch/$(ARCH)/kvm/kvm_arch.h is the obvious approach.  Code in virt/kvm can =
reach
arch/$(ARCH)/kvm, we just need to add it to the include path.  That's why I=
 was
working on unifying the include definitions.

> Btw, have you considered reverting the inclusion of "strut kvm" and "stru=
ct
> kvm_arch" (and the vcpu structure), i.e., to make "struct kvm_arch" inclu=
de
> "struct kvm"?  I don't have any clue of whether it is feasible or how muc=
h
> effort it needs, though -- it's just something came to mind when replying=
.
>=20
> [1]: https://lore.kernel.org/all/20230916003118.2540661-1-seanjc@google.c=
om/
>=20
> > At some point I'll try to take another look; it's really the
> > s390+arm64 combo that's problematic :-/
>=20
> If you want, I can take a look.  I think I'll have bandwidth in near feat=
ure.
>=20
> Given you have tried multiple times so I am not sure what I can achieve, =
though.

Consolidating includes and creating arch/$(ARCH)/kvm/kvm_arch.h should be m=
ore
doable, what has failed spectacularly over and over is effectively trying t=
o hide
most of asm/kvm_host.h, which sounds *really* stupid when I phrase it that =
way :-)

> Anyway, seems "allow loading a new (or old) KVM module without needing to
> rebuild and reboot the entire kernel" is a good reason to do this.

Note, we've scrapped upstreaming multi-KVM, and I don't see it ever getting=
 accepted
upstream, as live update is far superior, e.g. isn't limited to just KVM, d=
oesn't
have the same orchestration or testing problems, etc.

And FWIW, today, you _can_ reload a new (or old) KVM module without rebuild=
ing
the kernel or rebooting the host, it's just that you can't modify certain s=
tructures.
