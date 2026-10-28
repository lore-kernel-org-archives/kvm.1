Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209064;
	b=2DFUGUP2ZRY+MBp7/iwmw+LeDrCrCSoYVgfIFnBPcAJcOgpcP63xP5e4pn5/5/qisdnx
	 zuxtEYQum9Q+N9jUoWc4/roq/FH7L1qxHEa7b4/AbB0XK0R2lbNAi96Bw9ccrq33JKzqN
	 PUvglKi2Mf0bxtW1D8OyyIyc2n+93ARgfm3/RSUt5wZMSCKXjRgdSsUrhFVCWidN5v9L2
	 nY8/oRzzNYVpGZ1e/4e6LHsmSAiBDBVmArQif54QwZ6sQmVjDzsUPz1gyVmm083iaThgO
	 x1a2iF6fQEpxc3BHpoEA+ChXXeH7Og6TaYU3ZzvFzWbjhF7E97YAA1fs8g/oc0+Gk0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209064;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cYvri/TspkG2tYIL/heVQtQQlYpPDPdribSzkNzfhow=;
	b=Jl42EE4qApMQ0IPz+FLc5GIN57OR0wvh841+CcJO8gURp1pLr1Cx8e0pfwr4Hi5r47xQ
	 +Oa4cPkFugVoeBhvh6znX5ASX9N18rEw6zSK4PPCTokTbFEwj+Jtw/TLy7U8BsF2x4J+w
	 kASjspk4NoXsZTzUWCshtSd47EhspmVfKcUuEwry99EQakpi9XG/39fBB1FOrq+voySUk
	 2a3TR/fznHTqpvNLSYfqNJu+WHnA2+7RH1Knmu8jxF6iVDzt2A7huEKeZTFJpYYJeZwJj
	 CY33T7lLdJXU86/cXLDyW072fupgASJVrE9i211546jU8x10MIlsyJt+8kVZnByxgDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="K8iv/qok";
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379B60A3836
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 17:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0379B60A3836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K8iv/qok
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a030e0f9c1so1362900b3a.2
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793209058; x=1793813858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYvri/TspkG2tYIL/heVQtQQlYpPDPdribSzkNzfhow=;
        b=K8iv/qokqLcqmosxHF8uwyg869NLyQAd2klYldeDFNTuErcIAIQklXhEcLDF3cAFSI
         yiamH0AHc0D8T+jPua1OXBPPjJ8rzTy8CxbuXwNti5LTXVHl6Hr8K4IGLsk7BSlZ3TVZ
         A90BKQAghjbUvuHXi4wJvbSTb9OJ/JLoa4T8bGmpazXopDRJW3JwXhKtXAACo2EB4caC
         kZ1uw1E2R3+oii9u3oirvbMDSJHMayzSztPbr76VU/enXTOyKVT7Je9j8qnvdVDiY1UG
         9hEJ2CnnUzP2n4djSjMJ7Z4jlp7nylVquRfCQJDXLWs7SROf6w6abh+nUUSG0aw3gClN
         oU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793209058; x=1793813858;
        h=content-transfer-encoding:content-type:to:from:subject:message-id
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cYvri/TspkG2tYIL/heVQtQQlYpPDPdribSzkNzfhow=;
        b=sRDPhKCx8hlIU6KEmGry0vb24oeBexk4p1hAZOesrNt4dQC0VHW9/8PUbTa/XT8+nb
         53d3iPder8Lhhyqi7JyvM1Dn7yBNShNFmEINVrgDXmnYcM51PHYlXvgvYq0Q+lA6liW7
         XJoedJwTzgGvVPXJ9F8PMJSacOs6dcKY8ugLYaLGqou5iDf0n4l+okoaYrhwWqorYhCw
         ZHAJNo8/iWvvpYVB4lP5PwsTqPUpdyyPf+CtPKntC7nBE13cUDNIsEpX+hR/GzV/EbH3
         v/T3gWQS7GerNbhCsQkyGAySnlOBlfqahD+QROQ+ryWiZ5ET/AJqgQIq6vQx3uPjLgD3
         9LQQ==
X-Forwarded-Encrypted: i=1; AKwUvBw41qOf3tChTl9u6YaYWAt8mE2rnLQfpu7bZqi13KqI3qW3i7Q9B4bqFkJ2hhItb6FAnJU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKep28ZWChIgwWTmR3fUE2FDvGG6P+HP7+heBZ1d7W2SY+mdRh
	TZ95JsrgFvRRM5fLdR2wX1h556buAMjXnCxW7FeJMqPoGwJixy2xPsHHNTAjxYnmJMQTkoSSJWq
	jlKRBAw==
X-Received: from pfbfj6.prod.google.com ([2002:a05:6a00:3a06:b0:89d:3267:4348])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2386:b0:892:a8f1:c53d
 with SMTP id d2e1a72fcca58-8a6e6ff38aamr2448185b3a.22.1793209058009; Wed, 28
 Oct 2026 10:37:38 -0700 (PDT)
Date: Wed, 28 Oct 2026 10:37:37 -0700
In-Reply-To: <20261027124140.upuow4a3kv6kssvn@m.mifar.in>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026102314-CVE-2026-99082-e5b1@gregkh> <20261027124140.upuow4a3kv6kssvn@m.mifar.in>
Message-ID: <auIy4UZMGxLhBCAn@google.com>
Subject: Re: [REGRESSION] KVM: x86: OVMF boot hang with SMM enabled after
 commit b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO cache")
From: Sean Christopherson <seanjc@google.com>
To: Sami Farin <lkml20261027@mifar.in>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org, kimjw04271234@gmail.com, 
	pbonzini@redhat.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026, Sami Farin wrote:
> On Fri, Oct 23, 2026 at 14:45:15 +0200, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> >=20
> > Description
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > In the Linux kernel, the following vulnerability has been resolved:
> >=20
> > KVM: x86: Use active memslots for the per-vCPU MMIO cache
>=20
> Hi all,
>=20
> (Disclaimer: I am an end user, not a kernel developer. I used an LLM to h=
elp
> triage and trace the issue, but the findings, traces, and tests below are=
 verified.)
>=20
> I hit a guest boot hang after updating my host from 6.18.57 to 6.18.58 (F=
edora 44).
> Windows 11 guests using OVMF with Secure Boot and SMM (-machine q35,smm=
=3Don) hang
> indefinitely at the TianoCore splash screen, pegging the host vCPU core a=
t 100%.
>=20
> The issue bisects/points directly to commit b3e6212dea2e ("KVM: x86: Use =
active
> memslots for the per-vCPU MMIO cache"), which was backported into 6.18.58=
 and is
> also present in 7.3-rc kvm/queue.

...

> ########### patch 1
>     The proper upstream fix requires tagging the per-vCPU MMIO cache with=
 the address space ID (as_id) alongside the generation counter.
>     The Flaw in Commit b3e6212dea2e:
>     The commit attempted to fix stale MMIO cache validation in SMM by che=
cking kvm_vcpu_memslots(vcpu)->generation. However, its commit message reli=
ed on an incorrect assumption:
>         "Memslot generations are unique across address spaces, so the gen=
eration also distinguishes the normal and SMM views."
>     In KVM, each address space maintains an independent struct kvm_memslo=
ts with its own generation counter initialized to 0. They are not unique ac=
ross address spaces. During early VM boot, address space 0 (Normal) and add=
ress space 1 (SMM) frequently have identical generation numbers.
>     Because struct kvm_vcpu_arch only stores a single GVA, GFN, and gener=
ation counter without an address space identifier:
>         An MMIO access cached in SMM (e.g., GFN 0xFED40000 with gen =3D 4=
) matches in normal mode where gen is also 4.

Hmm, this isn't adding up for me.  It should be impossible for the generati=
on to
be '4' for SMM, because SMM is supposed to use odd-numbered generations.  F=
rom
kvm_swap_active_memslots():

	/*
	 * Generations must be unique even across address spaces.  We do not need
	 * a global counter for that, instead the generation space is evenly split
	 * across address spaces.  For example, with two address spaces, address
	 * space 0 will use generations 0, 2, 4, ... while address space 1 will
	 * use generations 1, 3, 5, ...
	 */
	gen +=3D kvm_arch_nr_memslot_as_ids(kvm);=20

So while both of the suggested fixes seem reasonable, they _should_ be unne=
cessary.

Paolo, at PUCK I verbally said we could go with the one-line fix, but I'd p=
refer
to hold off until we can figure out why the generations collide in the firs=
t place.
