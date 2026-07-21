Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780DA3988F9
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647531; cv=none; b=Iiyf1swlY/Ucb4lw/PUumnKaZPbH8WAAWzkYDC8gNdj8Mm/fwBVwdcJEi7puzXQtcByWKWKRnrTJimO/XUou/FF5/GSWSVL93d5hwqfijaYIYrWpdiuuCvoPK8aVQP004ew39jjt0dWcgeduK6M9NFCjUL+PAX29PP5UpcUWy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647531; c=relaxed/simple;
	bh=LU9gG3PmbvdZfsDsznLIo1us9Wl560qv18j2nDfmVWg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sAwBlpzpx9tpSx2WjKvkA3oZQrDJCC+CqugGKuaUHDs+seL3R7hgMvS3u5JyL+Vj8AeCGOb4LeXjiSQqPn7wOfo6V2zivedNjXHzBUjdX7u673Zw2/HwNIiz22QzeOgh8utq/THF97O+YuwHK0xuT3cpYsSbQ3Dz7LefaH6c1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zs/GR0/n; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zs/GR0/n"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cce870a060so198808715ad.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784647530; x=1785252330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nq19FZvYNuRfUo9QHl9C1qUxb08K/NCJCa94f7ffXg8=;
        b=Zs/GR0/nV62B/S3sApPULF3Gb8jsEY/5/XjDxofKee49JVfDeSHoojPvkQQbleyLkP
         nmFUhdra+X24J9G9dRXNz1bdUehQTahj94W8e3dQgFQm5QATPYyXC7Z9aFHrgr34XVvQ
         eVm96vClTddNLOSYI+3ruCrFVQLJYY+sbPpPaFn+zquGeFUSmwi90lriXJymwmM13lUw
         iVidnDC9d/lLX7lv1TMcrCdfbDPdlWjFmaCJCYh2352JkNOc+KK3wVv9cGcH5282Ijjf
         933B5f+3+u0lj5svAJ06UIgO838CevgRBPaJnEi+i6Vl2gt/zsIaTMor60D0IySuN3YZ
         K6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784647530; x=1785252330;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nq19FZvYNuRfUo9QHl9C1qUxb08K/NCJCa94f7ffXg8=;
        b=AEo5kBgCWLkowRNebI44kanbHHDKa1mzNXuU/R00tiuMeJbdTTUYWVAP5siemrhzpB
         0YOoxKpQpmstO00m1ucf7A00NTIzMtW0LzDxedN2tJTgz74yoVdvgxDvpWriUzsAkTod
         rvZ2/OA6gLCiRnkhRppvMAJWYmiMeiBtZntReTiaEHXrwrGJ5AgqquJBpSTUERbetxf5
         ugpmyn7TSMi0UzmjHrI+1eSUzabExaoz1dg7ggbcprwr0rOWnUBGiSbqdfY0j56jTxoT
         P/R/MTDzDNk8sDGi/BAviy2vhueCO0Z5nfEq60n27hP8XFZT7XJmVxCMe1HrH2NUoSEA
         JLBg==
X-Forwarded-Encrypted: i=1; AHgh+RpSDqCpxF+Msl5rYeCAn8XYtagJhx2afX1GOUKNreEuqS8FHRlCRSwlxngYg/na9HhXfh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Gf0Cb26UemOhW6CSbXW0r1fxzqkv8H4T2G2UyWD5xdu88fLY
	+cFmiOG5Ge2dnMGN3oqSyo77/mHIrH+GSFh5jQMfN8F9uv1z3erXdU8Da2DG5VfAq9F/3E2pXOF
	C+/Y1LQ==
X-Received: from pjbhg21.prod.google.com ([2002:a17:90b:3015:b0:380:ce47:d7c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c86:b0:387:e0bb:57f8
 with SMTP id 98e67ed59e1d1-38e4b59cd34mr21681973a91.41.1784647498202; Tue, 21
 Jul 2026 08:24:58 -0700 (PDT)
Date: Tue, 21 Jul 2026 08:24:57 -0700
In-Reply-To: <20260721104819.B5A101F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721102827.313208-1-pbonzini@redhat.com> <20260721104819.B5A101F00A3E@smtp.kernel.org>
Message-ID: <al-PSX0sOPdYdvIg@google.com>
Subject: Re: [PATCH] KVM: nVMX: Hide shadow VMCS right after VMCLEAR
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index 6137e5307d0f6..d63cfdc1740e1 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> [ ... ]
> > @@ -350,9 +351,15 @@ static void free_nested(struct kvm_vcpu *vcpu)
> >  	vmx->nested.current_vmptr =3D INVALID_GPA;
> >  	if (enable_shadow_vmcs) {
> >  		vmx_disable_shadow_vmcs(vmx);
> > -		vmcs_clear(vmx->vmcs01.shadow_vmcs);
> > -		free_vmcs(vmx->vmcs01.shadow_vmcs);
> > +
> > +		/*
> > +		 * Keep the pointer visible until after VMCLEAR, so migration
> > +		 * can clear an active shadow VMCS on the old CPU.
> > +		 */
> > +		shadow_vmcs =3D vmx->vmcs01.shadow_vmcs;
> > +		vmcs_clear(shadow_vmcs);
> >  		vmx->vmcs01.shadow_vmcs =3D NULL;
>=20
> [Severity: High]
> Does this sequence need a compiler barrier (such as barrier() or WRITE_ON=
CE())
> to prevent the compiler from hoisting the NULL assignment above vmcs_clea=
r()?
>=20
> Because vmcs_clear() relies on an inline assembly block without a "memory=
"
> clobber and has no direct data dependency with vmx->vmcs01.shadow_vmcs, t=
he
> compiler could legally reorder the store.=20
>=20
> If a preemption occurs right between the hoisted assignment and the VMCLE=
AR,
> and the vCPU migrates, vcpu_load() on the new CPU would IPI the old CPU t=
o
> clear the loaded VMCS. The old CPU would see the NULL pointer and skip
> flushing, potentially leaving an active pointer to freed memory in its
> hardware cache.

FWIW, I had a pretty strong preference for Paolo's off-list suggestion of
explicitly disabling preemption, even before seeing Sashiko's response.  Ev=
ery
other path the VMCLEARs the shadow VMCS runs with preemption disabled, IMO =
it's
more intuitive to follow suit here.  And even with the comment, it took a g=
ood
5-10 minutes of staring to understand what exactly is going wrong, though t=
hat's
probably a me problem.

> > +		free_vmcs(shadow_vmcs);
> >  	}
> >  	kfree(vmx->nested.cached_vmcs12);
> >  	vmx->nested.cached_vmcs12 =3D NULL;
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721102827.31=
3208-1-pbonzini@redhat.com?part=3D1
