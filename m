Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40F3BB9EB
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792178675; cv=pass; b=QYQtTZ58Cvgp25Thpx0/KzAEM+DqucYV+NXN5e/JtbbY3myh3YC/d5TKoCsTY2emhv3wXpzsBwEsyKW0aAVu/lTNJCsgeI+WYKZPIvJtWFU5ivug3BGuU3C7tLSaG+gbnxudv5jd66XkuASFD24es/HrgO08aX4nSmEQWKoSGTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792178675; c=relaxed/simple;
	bh=d5o2v0NGUWbRJN1f/BoF/CoGKfRWIDyZQTL0ydZSSo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYytr3tbJw1BEoL/NwvbKR9Is6hGIevMihw39wGlY9WjhAz1rG3u8TcLGn1QV08SlSsY+RjJR3i28MLOQWQTpwlDFlnjR+sdoSowMdkzsD5viScTpzyUGxRx4GTm8GlC/xUmh55BjuFBr5XhpjD81j1k6Wne3IJrg9kkIyjWwOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxnpEy+w; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxnpEy+w"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so2314a12.0
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 12:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792178672; cv=none;
        d=google.com; s=arc-20260327;
        b=EdV2YfwwzxuiAA0R0N3Mbs4kq6WnzQiOANheStdqLJ6U6seKuO5GbhvOaWtdqQSbpN
         ESriIt/ResoqLEj+dJH/jttUucgKul2NpqnC6N3yzW2SrWzh83CwYxz9OsWRZYmIBsxy
         Wx7pxwf7KzRLsoNricwxk4cV5ZjoEIwX2PGaA5YfkHbPTKS6JeDJQjHY5G1StEML3DJo
         rkKS9riI2oJm5iFejclOXnanuGkmLzKuqL961iG5HGVbjBXR4+ThZwy0dWuvOJEEakHH
         me8IxyNsZmMI5tj0jz6wrx7wQw2SjFJMKtziDQ0pJtOgdW9HAJzKMaQME73omFS0EpFe
         Kv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0AUHybqnK5COco/Ujbmue1fB/qGf6BnUtW0x4jmlSGs=;
        fh=3Ty9cT/MQMBd3f7IjcbxCDCw9aToR5rTCS6xP3OwtXE=;
        b=On1LHQ6ern+zBcoriiBxJkWC4pRDkWXHx1HKPtK4uzAJnN/ybOj7njoVZMo/G6U6Pd
         +K2Na2r/5XVDHFIYSVPZhOrQ9whw4GCrlluDM2OWXAlagh/zBFlzZCYpE5jM1ejRmk9G
         /kNmvStAN6V5zY+u863iPuDPw7vQEFh08HANilY03ZAm8beXbKcKCKaNXLyugFKPsgoy
         5el56Xg7AZLeSQbrg2kIE1ewiUbQ02Z8+X0ERCbb4bffRivDmH08ExbYAHyFsBR2pK0X
         Kqm+TPqvBxD2FT22F1Chk/wKlXvtr9I87qmJ3UGverfM/ZaxT13Kh9PPtI7JCfQlouWm
         JTtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792178672; x=1792783472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0AUHybqnK5COco/Ujbmue1fB/qGf6BnUtW0x4jmlSGs=;
        b=GxnpEy+wqXUWZlSBTaXQg7FehcHHrB7eto7QrfunRv/PqUEbQZIHsBGJrPkBhv1a9p
         4+6Pqk6YQAuwzXlwVoPXwtqE/1jy2naUr/PEmcjQOfC8Q80LtIDm4bkpyA4P265r2zzb
         skvXAVStWFgEPjkwz8A51Ynpt+0lpIiz+W7Xtb5p8PC/8w4+q25fgZzkQ5TEJMBxN3lF
         cJGYwp2d6DgSL80UGMUHpIsatfSlx3yW+TP3bALW7Iw+o3Imc//cO4B8A0aVuKsufmKo
         MCCVcQ58/5GbDAeoAJaFBgCUXCm2Zofx4vLLMNxq3l7g1AMiCXvtNImaWM6CW5EnEzCQ
         FqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792178672; x=1792783472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AUHybqnK5COco/Ujbmue1fB/qGf6BnUtW0x4jmlSGs=;
        b=oXnfx3wvdHqhzc78n9oC9FfL6NtdCbpvAGmT9yM08xNnsm5FKZkU2ZOcoGzxBkIV2B
         ZbcCc0tUrGEF20jQFZZ53h48tF6CLbY57hT2d2C5A7nOJzcPKH/TVMWA2JdCJLsDqXdg
         WBagSbRayniEJd5s5aq8bL+CYsbaxA3zahomM/FmuAd+tEDIJbpphCPaeE4Tn03w9Jf/
         pxxUbYxSKKa+9QRrpzC7YgPG1swv/vtMKWjk7crfLnMKP3c3oePWMlOR51b4X8GZ6ogW
         0I5TkcazvB3mWriVBrTuxRGEWpCGOk/cZQG/rK3iQc/JYKiRol76X1MR76Am7TkMdk5E
         B+fA==
X-Forwarded-Encrypted: i=1; AKwUvBwM2STOrehINgqC/33+/fwr4Fa3tW6xoFKcwOv4hTYnCgvYkO90zTTYKjZYgirGLBnd8ZY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJJG6diGILljhET1f1RuYTP/QPsdlkkxm/BDKzLVi1LHMtzkoKi
	6zX7/NASBaiRiSmcP1cVYrGWXFNwfjHaVcGlhYDXlnLU6umLV2dMaZzI2Urf25ZXBjhcxV6q2X7
	1JunX1dJ0RpZoyrRO1QsnLk/T1lacYfRVhHeHiU7f
X-Gm-Gg: AYBFou0/3RaNTPZVRgbwzjdnMDSRNC1bsNBfRn6GfrN/y6A8qwlHekeSgGeQiKXeTY+
	PVrlpdDe0If4EG1rY9VxQkjguPOuZKe++I7DVUyHrIOgkk5nGLZR3/Z5QCRMJuBSg6TVhWYDmUN
	m+tdOSzgpnkTBbCt6+PEUJQuDvgM3TbPeVNE9xqUo0w0NQEfz9WjvV+Gk3KgTKfevA25ZUaznp2
	qfd64nHOdsnvcoE0h1u3/DbuJvEd5SleSp3rkd+AkkvK6wuJy+Ltv6JEdy9MIcTcF8RxCVii+ta
	l+vtv7XTfyI+4MauzP7xboeI0prJfw6s8IBXGd+frJieizl+8rvPDCHmQpWIfp2QyxtpPVza7B4
	X6IcYZKURZ8Zcj7MHEVB/zgLfLri0zAA2DhOx
X-Received: by 2002:a05:6402:5177:b0:6b1:bce6:1220 with SMTP id
 4fb4d7f45d1cf-6b3a8c0a97dmr6753a12.12.1792178671324; Fri, 16 Oct 2026
 12:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012233638.2546339-1-yosry@kernel.org> <20261012233638.2546339-23-yosry@kernel.org>
 <CALMp9eSv9a23si8rtWd_XGRJxVWE96aWdSzE_Ram5Bu6G_pb+w@mail.gmail.com>
 <CAO9r8zMkRADNhRCBoxKCPNM90H0uqB5Jyt7oB4RDmbhgY_UM-g@mail.gmail.com>
 <CALMp9eTM23iFdrbZE8qw9kuJ2va+Mahv5wZDmgs1TZrAREh=gw@mail.gmail.com> <CAO9r8zNFYNR904b0NahKj=vwoc1tRZdr2wwUYpTVwUdwvYAtpg@mail.gmail.com>
In-Reply-To: <CAO9r8zNFYNR904b0NahKj=vwoc1tRZdr2wwUYpTVwUdwvYAtpg@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 16 Oct 2026 12:24:19 -0700
X-Gm-Features: AclHuK_uq-6OVpi-FVRpkc7oAce-IC9tDELOgFS6cf7jgJLt2-ErHr0_9UIrtVM
Message-ID: <CALMp9eSTHi+Y+opUpu5ihH92ULKqFA2D5hucrgNgSd25NZUktA@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] KVM: nSVM: Flush the TLB if L1 changes L2's ASID
 in vmcb12
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:56=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > > > > @@ -691,23 +689,35 @@ static void nested_save_pending_event_to_vm=
cb12(struct vcpu_svm *svm,
> > > > >  static void nested_svm_entry_tlb_flush(struct kvm_vcpu *vcpu)
> > > > >  {
> > > > >         struct vcpu_svm *svm =3D to_svm(vcpu);
> > > > > +       bool new_asid =3D false;
> > > > >
> > > > >         /* Handle pending Hyper-V TLB flush requests */
> > > > >         kvm_hv_nested_transtion_tlb_flush(vcpu, npt_enabled);
> > > > >
> > > > > +       if (svm->nested.ctl.asid !=3D svm->nested.last_asid) {
> > > > > +               svm->nested.last_asid =3D svm->nested.ctl.asid;
> > > > > +               new_asid =3D true;
> > > > > +       }
> > > >
> > > > To make sure we don't miss a flush after restore, do we need to cle=
ar
> > > > last_asid in svm_set_nested_state()?
> > >
> > > In [1], we set svm->nested.vmcb02.cpu =3D -1 in svm_allocate_nested()=
,
> > > which should be called when EFER.SVME is set on restore, and should
> > > force a TLB flush on the first vCPU run. That being said, if EFER.SVM=
E
> > > was already set (not a fresh vCPU), we won't necessarily flush the
> > > TLB. KVM_SET_SREGS will _probably_ flush the TLB, but I don't think
> > > it's guaranteed.
> >
> > I'm pretty sure that restoring nested state on an existing vCPU with
> > the same asid12 and no TLB_CONTROL skips the flush.
>
> I can clear last_asid in svm_set_nested_state() to make sure we don't
> break this.
>
> >
> > > But wouldn't this also affect non-nested? Are we guaranteed to flush
> > > L1's ASID after restore?
> >
> > That may be a bug too.
>
> It's tricky. KVM_SET_SREGS will only flush (with 64-bit vCPUs) if
> CR0/CR3/CR4/EFER are changed apparently. But it's not just the TLB
> flush, the entire MMU context wouldn't be reset?
>
> I am not sure if there is a practical use case for restoring on an
> existing vCPU tho.

KVM APIs make me want to kill myself.
