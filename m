Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908937DE84
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172516; cv=none; b=U1gY6ZLAtTKyOCs2uDZtc1px0l+L2HsPdqiG5WlXGug6++7/g1GC5GuMQUiMaXoY54zd7MCfu7Sx9PTHR03NFepk1Ay8xquYwiy8y1Nj+9DqdebEW0rAgKZajhNTmTEzD2yP+BT9WTg+FHBQ5dvGmrrinn0O+tAokbGWJjX1+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172516; c=relaxed/simple;
	bh=I/krK6D5LnN6MWohk+eXmjCU98F95dnlWB8t4brqKKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HxnXXUbkjdHMzrS21npSqktaApFJa5Lm1b3E2omLlIcCq+ZaBPI38pMyV274SSHB+hYBJtic5EzK7AAQJtGpj7ljOHNzGXnZomhodK7FS5oOhoR8L4G92GiMmRJZxkh8/2JsSmktC1ASwkOhO0z+hylPskOgDWOdBxTDCXOmWds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZUN70ep; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZUN70ep"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso1327371a91.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775172515; x=1775777315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHSf2FjaEa5ZnI4HKqJFpv9coUE7HqZnWwa5bp6NaFs=;
        b=cZUN70ep4xl1kelqxGpdV1YguEU6p3zdGI27GN34CubIItQZ3jchBQ06edBv0WjhQ2
         syz2ZTWjTeFFvzIL1io457LILmC5YyIMdiCaZw8cFX6q65NDlSQqcvD3lNLZzMM4Uf2a
         8ExIreq/d1PYNDjx/2zNJJqDgzbO4e6Hv/ZPSE4XGVpF7GJg5YqmYic/CfRtGpCZ4+g2
         zK/otwEWkSiOZS3mTCpMttosoMWRm7zhtWQGMvHgYUnA3gXFwrA7rEvCQdqZxxQDkymO
         2ezKSHw30gtSqtrbX4Ayl3u9olD73GHxbUEQEbDDY07DR4WwPYmG0Yul7yFPi1EbNxt8
         TuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172515; x=1775777315;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QHSf2FjaEa5ZnI4HKqJFpv9coUE7HqZnWwa5bp6NaFs=;
        b=myn7oEKQeIRhhzdMaOoMkQl3RtttQdC3CemhMIAMDvQaDQCamjdBTWSWI2SYiVF1mE
         lz/F+R72Jcd9iehPT6Wsb+ReWCO8XHb1Ticifpym4GSAartCI+7l2YoAOjUvk0jugiac
         qZsEeBHLG61JCcUuusJsJ3Igptijb7iUXZET8OTfJQjcRciWLh6MSuhM0IsCM5Ey/oiT
         4I+zvuX/Sy9SHakbOEzmMKOXDZzdSLg9iSMXSscykkMpVm43c9LshH9SJ1fv0B0/YJLe
         d3qmCTjqH+C62jLKXFXU6sSLG9+fZtnbkU2ECiOcKzAa0/wb1gQT4aeNxh/LtXi0erWR
         8byQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEnH2FCM9OSZGZvd0f+xzIZ2SqS3u9ggzHpoimEaYoqBIQG8pVrcPOC5xQgaBTTERe368=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyka3M4gogP52EDbcuYEKu0D+ACB2g/tIFJEe707pl90sfTfW+t
	buEkSMMetKiQEBDb0y2nzfvfPQJWlwaSdTYu48/GnPE2Ylj5nzXIZl+hQrlOKJy+dQBCQJXygYJ
	HeuuyRw==
X-Received: from pjzh24.prod.google.com ([2002:a17:90a:ea98:b0:35d:a9bd:1fef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1e0f:b0:35b:e4f8:7cb0
 with SMTP id 98e67ed59e1d1-35de691ad72mr639328a91.21.1775172514620; Thu, 02
 Apr 2026 16:28:34 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:28:33 -0700
In-Reply-To: <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
 <20260327201421.2824383-8-rick.p.edgecombe@intel.com> <acoUt9vy8OPU1SW9@yzhao56-desk.sh.intel.com>
 <8a107d4da92d4cf910f9a70991a0e67b42e04d4f.camel@intel.com>
 <ac3Ng7IZpzJczZ2x@yzhao56-desk.sh.intel.com> <4dfb4c106c834cd13da78872bfb262e98581fa55.camel@intel.com>
Message-ID: <ac77oSNltyE6vkVD@google.com>
Subject: Re: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present
 external PTEs
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Y Zhao <yan.y.zhao@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, Kai Huang <kai.huang@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-04-02 at 09:59 +0800, Yan Zhao wrote:
> > On Thu, Apr 02, 2026 at 07:45:54AM +0800, Edgecombe, Rick P wrote:
> > > On Mon, 2026-03-30 at 14:14 +0800, Yan Zhao wrote:
> > > > > +	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
> > > > > +
> > > > > +	/*
> > > > > +	 * Temporarily freeze the SPTE until the external PTE operation=
 has
> > > > > +	 * completed (unless the new SPTE itself will be frozen), e.g. =
so
> > > > > that
> > > > > +	 * concurrent faults don't attempt to install a child PTE in th=
e
> > > > > +	 * external page table before the parent PTE has been written, =
or
> > > > > try
> > > > > +	 * to re-install a page table before the old one was removed.
> > > > > +	 */
> > > > > +	if (is_mirror_sptep(iter->sptep))
> > > > > +		ret =3D __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
> > > > > +	else
> > > > > +		ret =3D __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
> > > > > =C2=A0=C2=A0	if (ret)
> > > > > =C2=A0=C2=A0		return ret;
> > > > > =C2=A0=20
> > > > > -	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte=
,
> > > > > -			=C2=A0=C2=A0=C2=A0 new_spte, iter->level, true);
> > > > > +	ret =3D __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spt=
e,
> > > > > +				=C2=A0=C2=A0=C2=A0 new_spte, iter->level, true);
> > > >=20
> > > > What about adding a comment for the tricky part for the mirror page=
 table:
> > > > while new_spte is set to FROZEN_SPTE in the above __tdp_mmu_set_spt=
e_atomic()
> > >=20
> > > You meant it sets iter->sptep I think.
> > >=20
> > > > for freezing the mirror page table, the original new_spte from the =
caller of
> > > > tdp_mmu_set_spte_atomic() is passed to __handle_changed_spte() in o=
rder to
> > > > properly update statistics and propagate to the external page table=
.
> > >=20
> > > new_spte was already passed in. What changed? You mean that
> > > __tdp_mmu_set_spte_atomic() sets iter->sptep and doesn't update new_s=
pte? If so
> > > I'm not sure if it threshold TDP MMU.
> >=20
> > For mirror page table, a successful path in tdp_mmu_set_spte_atomic() l=
ooks
> > like this:
> > tdp_mmu_set_spte_atomic() {
> >   __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE); =3D=3D>sets mirror=
 to frozen
> >   __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
> > 			new_spte, iter->level, true);=3D=3D>sets S-EPT to new_spte
> >   __kvm_tdp_mmu_write_spte(iter->sptep, new_spte);   =3D=3D>sets mirror=
 to new_spte
> > }
> >=20
> > So, the tricky part is that S-EPT is updated to new_spte ahead of mirro=
r EPT.
>=20
> I still don't see the point. That ordering is not new, and this patch act=
ually
> adds a bunch of comments around the operations above and below the
> __handle_changed_spte() call. If you think something is still missing may=
be you
> can suggest something.

Ya, I'm a bit confused too.  For me, the "tricky" part is understanding the=
 need
to set the mirror SPTE to FROZE_SPTE while updating the external SPTE.  Onc=
e that
is understood, I don't find passing in @new_spte to be surprising in any wa=
y.

> > > > > @@ -1373,6 +1396,9 @@ static void kvm_tdp_mmu_age_spte(struct kvm=
 *kvm,
> > > > > struct tdp_iter *iter)
> > > > > =C2=A0 {
> > > > > =C2=A0=C2=A0	u64 new_spte;
> > > > > =C2=A0=20
> > > > > +	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
> > > > > +		return;
> > > > > +
> > > > Add a comment for why mirror page table is not expected here?
> > >=20
> > > Ehh, maybe. Thinking about what to put... The warning is kind of chea=
ting a
> > > little bit on the idea of the patch: to forward all changes through l=
imited ops
> > > in a central place, such that we don't have TDX specifics encoded in =
core MMU.
> > > Trying to forward this through properly would result in more burden t=
o the TDP
> > > MMU, so that's not the right answer either.
> > >=20
> > > "Mirror TDP doesn't support PTE aging" is a pretty obvious comment. I=
'm fine
> > > just leaving it without comment, but I can add something like that. O=
r do you
> > > have another suggestion?
> > What about "External TDP doesn't support clearing PTE A/D bit"?
>=20
> It sounds too close to "TDX doesn't support..." to me. I think I'd prefer=
 to not
> add a comment unless you strongly object.

How about something like this?

	/* TODO: Add support for aging external SPTEs, if necessary. */

That makes it clear that this path is supposed to be unreachable because KV=
M doesn't
yet support aging external SPTEs, while not trying to say anything about *w=
hy*
KVM doesn't support aging external SPTEs.
