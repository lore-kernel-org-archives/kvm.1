Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBB333440
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157678; cv=none; b=Kl19Rm3OyyYyczlLn/EbtTg5npzYODyTv6iaxFjHP5SGtxs844vSQXiFzgAP+dtbLMxAHBEChBsH5KqGbmqB+C+QG8cVGtSe7+1KDINP2KQvnRc64zOMGflYMZ6WFBxHSlQOAUcAQyNTjBXOVeK3iYkLXKiUwYac8tzLvY1MHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157678; c=relaxed/simple;
	bh=d6Bx6z0kjINY02UntVtqVAcq8ELwfMQHdiXruOuuW1M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SZPPOS2lwoZ7PtDRf0xa1y9UDfl1KAqJhfZpd00OuDTCxYHX8Slcr7M1lFpOr4INT6RrRUj8TW8359ilUh99tU+RWFRKC8Xqrbzda6yVcyZwzNrMPcV7Nr8c1CX3gWNqodjhxK7DjbUhN4NpAcWUBlMY7tqmoqeSzqHDip0y/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vIFxfKlR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vIFxfKlR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358f058973fso1272680a91.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775157675; x=1775762475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpZ+jaTue40+NnSqiLxYhKjKCZkNo+tQ9jXsjdMCoA0=;
        b=vIFxfKlR+oUD8zxylkckDF3vJibGc14S56oCNcK/qjIAzvFpNd0Z4ls9IqcKK5NB7G
         PG3vRD8wdC8hF5buCONFa5qjR21b8zZ0g26XBZI+8ibyrZBGdz6PP30PBQHtJO1xuLSz
         JbEY30kjkqOZVgMqJJxe1co5VDDs5jDx/opQumnWRhBXaXkG9a8UElWubWohAvlHR+bO
         1oU/CrKRDWXvMHpwWl/N2Q4fQyREoENcHOoxUZTNwRuymmFS0I0YYhrU1hSEkqPLC+WF
         WuGGiSjUU7yzPXcHL1hXkBDDH61CRmDKFncY6rBqZd/yI1qMLCYKb6wURYTGC9u+ywVK
         S2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775157675; x=1775762475;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FpZ+jaTue40+NnSqiLxYhKjKCZkNo+tQ9jXsjdMCoA0=;
        b=bjswIKf/uefKGTzAo8aBGOMeiojbAxE4rekdBozhHyNudLC2UDYPZ/Ofca0r8p6ZbR
         7/MValMfmheHGP1sep8Fm143ojXthQu1Uz+Uq2Ki/0Y7UP9C6OLdNkSgRmVv98I4FzDt
         /oqQ1phhmIWjxdMLnlzGrL2qiUbsSgS3uwDhUYL4fxNhrGXFe1Va8yoiviSfQwBlsinX
         e6Wdwn44au0SquRcGF0Rii/1pTi4aYdq36JidvZo3rreemmuhY6xCueElz7DfyuLNScv
         d66LDDF5P8bZk8Q5+YftPGxau8crwAlBcZAkkNlR3XSTy2Y/6NbcztwVB/KxlIkACDmJ
         hKtg==
X-Forwarded-Encrypted: i=1; AJvYcCXngBNGGgkF6r/iZ7XtFaKHo2/clb1cr3zeCOYQPuwXG1VGEqmi2Pfugw5tI4j65Jx4dy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIprg23jk2/DJhB9NSGdMMWon7ISpkMWBTQfIL0p6fcoJKEnXP
	JPlaUwHzq/hLjOBjTpzgc4sOohaP5HCLe2+/ReWDXKFwukU8asMFV0ztCrkfgrZkmBwdAGPckjQ
	qmRMAuQ==
X-Received: from pjbie2.prod.google.com ([2002:a17:90b:4002:b0:35c:e7f:6503])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:1681:b0:35d:8ea1:62c3
 with SMTP id 98e67ed59e1d1-35de67d6654mr83988a91.3.1775157675290; Thu, 02 Apr
 2026 12:21:15 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:21:13 -0700
In-Reply-To: <ac3BFyNs78NFBd00@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-7-rick.p.edgecombe@intel.com> <acoDhjbA0xIycCJH@yzhao56-desk.sh.intel.com>
 <3a046909b0e295d810ab9a7bf6a35980a9c708ab.camel@intel.com> <ac3BFyNs78NFBd00@yzhao56-desk.sh.intel.com>
Message-ID: <ac7BqcqSp8VBmGAi@google.com>
Subject: Re: [PATCH 06/17] KVM: x86/tdp_mmu: Morph the !is_frozen_spte() check
 into a KVM_MMU_WARN_ON()
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Kai Huang <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026, Yan Zhao wrote:
> On Wed, Apr 01, 2026 at 12:37:51AM +0800, Edgecombe, Rick P wrote:
> > On Mon, 2026-03-30 at 13:00 +0800, Yan Zhao wrote:
> >=20
> > Yep on the typos.=20
> >=20
> > > > --- a/arch/x86/kvm/mmu/tdp_mmu.c
> > > > +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> > > > @@ -656,7 +656,13 @@ static inline int __must_check
> > > > __tdp_mmu_set_spte_atomic(struct kvm *kvm,
> > > > =C2=A0=C2=A0	 */
> > > > =C2=A0=C2=A0	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter-
> > > > >old_spte));
> > > > =C2=A0=20
> > > > -	if (is_mirror_sptep(iter->sptep) &&
> > > > !is_frozen_spte(new_spte)) {
> > > > +	/*
> > > > +	 * FROZEN_SPTE is a temporary state and should never be
> > > > set via higher
> > > > +	 * level helpers.
> > > > +	 */
> > > > +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> > > Why is KVM_MMU_WARN_ON() used here for new_spte while WARN_ON_ONCE()
> > > is used
> > > above for old_spte?
> >=20
> > For the KVM_MMU_WARN_ON() it was Sean's suggestion.
> >=20
> > https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
> >=20
> > It allows for compiling it out, so probably a better choice. So I see
> > the options are leave them different or opportunistically convert the
> > other one to KVM_MMU_WARN_ON(). Thoughts?
> I see there are mixed WARN_ON_ONCE() and KVM_MMU_WARN_ON() calls in mmu.c=
 and
> tdp_mmu.c. I'm not sure if there's a rule for which one to use.

KVM_MMU_WARN_ON() is intended to be used only when having a WARN_ON_ONCE() =
enabled
in production environments isn't worth the cost of the code.  E.g. if the c=
ode in
question is a low level helper that used "everywhere" and in super hot path=
s, or
in extremely paranoid sanity checks where the platform is beyond hosed if t=
he
sanity check fails.

The other thing with KVM_MMU_WARN_ON() is that it doesn't evaluate the expr=
ession
when CONFIG_KVM_PROVE_MMU=3Dn, i.e. can't be used in if-statements (the onl=
y case
where it's used in an if-statement is wrapped with a CONFIG_KVM_PROVE_MMU #=
ifdef).

For infrequently used and/or slow paths, and for cases where KVM needs to t=
ake
action no matter what, WARN_ON_ONCE() is preferred because if something goe=
s
sideways, we'll get a helpful splat even in production.

> Is it necessary to evaluate them all and have a separate patch to convert
> WARN_ON_ONCE() to KVM_MMU_WARN_ON()?

Nope.  We could probably convert a few select ones if there's good reason t=
o do
so, but we definitely don't want to do a bulk conversion.
