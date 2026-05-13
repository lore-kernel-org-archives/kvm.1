Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03644A724
	for <kvm@vger.kernel.org>; Wed, 13 May 2026 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689493; cv=pass; b=gctOH6l+5cSTxnq7GSc51a4cBh4JIueO6fbGmdEO3pRtDphgqpnicmUYpGq3fErAttnw2Ek1UGi2Ngq7V22XjBu37/DRGrm0OnO/2qCoUDStfVmYDwl7ZjmncmzQyY+kPieuK7xFXYpwswHueapDHmF/66g9Hkt53RmaBG1bMwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689493; c=relaxed/simple;
	bh=dFqjGcDESPJs1sYvvaTVqiEjpmMW73N7IioLhMndVnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1vUfKmHxI7wAkIoq1keIoOqUHpClK1z2Pyx/mVdkZe2L12Kph8G5uQPSedy/EGrOFQkrRX3/E5JC7Yor5VObrJYPTsiWz1OPMV0z+FGPdMy2nZfV0xCondJaUPUvs19MXNin5nuBFB64Jy1WQJ1vUQ3JYTI+qbcx7G3fLRTGvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJf3EkUf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mek9Z9pm; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJf3EkUf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mek9Z9pm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778689490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LFP7K7Lzf/qFmjwBHFqhDwhsq/kaKAVcEgRqthL+0Is=;
	b=IJf3EkUfuVP4EsPAtaDOgkireDU7uR4TstpDJDtLqAIjeCV3hsTLkJnWAZzSPqyCkxmaUD
	efp5MASCG2R0mob1qdxgpjp8EB5Cy1RAD+2tPEXSyLmAOtEBM4OfRdNEdVYch1lWII7yQ2
	FvLLFilFz3HDyNe+AnDPAgLbhQjmsNs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-Y7nIuPnYOmufTu_BMI19eA-1; Wed, 13 May 2026 12:24:48 -0400
X-MC-Unique: Y7nIuPnYOmufTu_BMI19eA-1
X-Mimecast-MFC-AGG-ID: Y7nIuPnYOmufTu_BMI19eA_1778689487
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a71109b94so5675161f8f.3
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 09:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778689487; cv=none;
        d=google.com; s=arc-20240605;
        b=CTRdHPsNuOpJ1ePEZ8flJLcjcOJBX7WBqrrttbHlhoy9dg/uckIgLzSRtsrztebIAP
         VzW7N67d/fzYMEE7GUJXKZwLLOj8WSuYv8iZIyidyQRjmxYqTqpxmjOS4e9rqqSuxHUN
         MmptbTgeoJmGK5HWpY1aYWxMGgvvQstUxfndbcwRKS2F+/J5w4j+Kyxn0YSxHSFpcBC/
         ICrsvbzVfhinU1zqs0kedLMGcGh0g8YjFIy7G7qCfvLMa/nKJLkgRDRi8b/ha3iUx9uz
         SRWQoobDa77B/geeJlMx9kBufjeiZ9To4IAN2hpAxNqDx0U1UHczL4PdsJH+jVshK/ri
         WoNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LFP7K7Lzf/qFmjwBHFqhDwhsq/kaKAVcEgRqthL+0Is=;
        fh=pdzhkm2ci1evDkfLEhZk910/iNMt2ojf3gohcctDSIA=;
        b=AL0xOsj8jYKvytMzoEBvAvfOylViv0HC9ppuu6DxL52aPiK816aZhLMBnslrMxg1Eu
         ZMXeBlDjJtXd+VO1vhPSiwaTvvn4EOIw3GInWbu6dsjjWytLz9obRlsY4bEsJDQrnEEJ
         SiZ6lfkH4MBmzNV36YPw8w+1gKLZqMhtxMv5G+j25Xp249Autz+bukgMDChTsZXXuM88
         63QiFEtqf4F4X65gfajVi9enJ40/mDMeDAF6TA2NtNQz1k6AvSUuAmxitHs3sw/FQS8m
         UjmNC8/ZdmUxvtimbeHdDyHrPu2fTzuId7Re7e9HHqmgmtzAar7ZbTnpivorR+1W0O/C
         rO3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778689487; x=1779294287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFP7K7Lzf/qFmjwBHFqhDwhsq/kaKAVcEgRqthL+0Is=;
        b=mek9Z9pmWWemhhRiws8b56KjPTzk/e5aY5vRWjHJ7gHJBU7hbcAtvNyMr+YWbsK7xl
         nMBoIriFopCFF9rV3KiRL7RCSMqGM1d0nxju3lTq9hvDGyfRaOtHhFRnLrhhHnJVt6xu
         XVBdXPHVtc2xhz/CJKb8+wJ7cS/Aw1CtDi5uuuQMbZhl/Ul4zRxf7wmGkFVkzLr8n9Uh
         DRTqwyLYdJ9QM2T3Bcz66QfNHiT6e4Q8hJWRKpAJzUM2UPKPXttkIVOHIoV89tK4cJLW
         YOoVtCiPLBq+RGmZ3Xxcjxo/ZWR4yN7/0MZe83frKyOb3S8eLdAXQrten/otu0KEF7fA
         AMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689487; x=1779294287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFP7K7Lzf/qFmjwBHFqhDwhsq/kaKAVcEgRqthL+0Is=;
        b=AP5kyF3qhRDEU8kAt3bHqjOGGa4YQdsPqYq2I3vPCaC5Ef0jVVjlSRT32rZAWR6seq
         yQhtu4eDrJcxcNoygD5/gc7FZzUoTBR6NqNJYD2PHPdPFLxaGIenaWxYlAgvkFJodBMb
         rchT4gZN/n+hSQzsOCRacx6+TfGE6BZiETffH434/19nrFndU8TkuOi+GTL8ZLj5EYds
         quSqRlN2q4EKMugeP9jyMwJMl+/XnIsL1VjJfwfdAj6mHOXVK1cORPB77iagINQsy/AC
         4p8VV0fZF4pb2EcGxYCW+bnzvo/rDqNLnzz3z48IpmomkLTiuRBBEAWhnKUXFJvClf6O
         +X4g==
X-Forwarded-Encrypted: i=1; AFNElJ8Yy1FlLsDRfKr8f6iJY6lIXIo7KTmIgMMm43kkrGJhBJIN7Lt1xf5CniWHyOUdBnJWyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4VGMUdFFaI3wUgHOPa1brMXtsl3MOAEVfDvKjrGIeWCDlug5
	y5Lr1xKA19Jduo6/4V2LOC+PsRUbNeVSZvK7LbgC3IM5hpFLFKRPIW0xPOFzOMt4UOl4zI7IXiQ
	egHU/DmIc2KOIJm63p57NuA1QiITlfhsZnhmxcKMkcamLJ6wlm1ku4diDpVbFYyh1s0jwYm9xLe
	vY7eLvByu2/+YEig43EWQ+qElq6WXl
X-Gm-Gg: Acq92OFSCisNN+EJqh5pPtbKrWKawVXugvQulTp/ml8xKCFs7PRRp3s7Gml6i2xvNaI
	iNhjNpsgf3BCYg9+v9ExNxwfUJvDAUPfDBpgKAFyAZ/7nNd+grKA+S+w0DCIXyPOE4PeaTWFQgp
	ho6eVn22c6l0z1aodFKeMBDOqfe7Rsw3/8ySGzu/2SSSF3RvNa2SqCUcALD8gZKDLq56g/sVkhq
	Ciq5bUf7Jefuky0ifAPphv2sZUi3ejy4b6JAWsxvxEOFYR3ZyPCEHB9iEzphh40yyu3Da20wp+t
	Qi7bYosA
X-Received: by 2002:a5d:5d0b:0:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-45c7b85de69mr5836117f8f.40.1778689486838;
        Wed, 13 May 2026 09:24:46 -0700 (PDT)
X-Received: by 2002:a5d:5d0b:0:b0:43d:7d24:b4ff with SMTP id
 ffacd0b85a97d-45c7b85de69mr5836059f8f.40.1778689486387; Wed, 13 May 2026
 09:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6856b269d2af706eae397e0cf9c1231f89d9a932.camel@infradead.org>
 <6afc4b95-3c15-4d71-877d-19b84e91ce05@redhat.com> <57bc082f4824d6114d3156744c25986effc29aca.camel@infradead.org>
 <baff82ca-6321-4b16-aa61-b2d6d60b6535@redhat.com> <86h5obya2r.wl-maz@kernel.org>
 <48b06e5655d56ff6eda30e563b34894fa0eb2f07.camel@infradead.org>
 <ba08dfe9-932b-40c3-9fdf-fc891d52e1d8@redhat.com> <d9d4471a7f5ec1e297b3ca07f42a59090aa91e15.camel@infradead.org>
In-Reply-To: <d9d4471a7f5ec1e297b3ca07f42a59090aa91e15.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 May 2026 18:24:32 +0200
X-Gm-Features: AVHnY4JneGWlgI2TZN3pA0snVaHMgFYvSCN-3eBEab4JAE5jQOEAQHtyebNrVkM
Message-ID: <CABgObfaM-JtNn2MuYXaiadQnLfAhTEaoHAcTG9=J6LkMcQCJ3A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: KVM: Document guest-visible compatibility expectations
To: David Woodhouse <dwmw2@infradead.org>
Cc: Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, kvm <kvm@vger.kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Jim Mattson <jmattson@google.com>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Raghavendra Rao Ananta <rananta@google.com>, Eric Auger <eric.auger@redhat.com>, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.linux.dev, 
	linux-kselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il mer 13 mag 2026, 15:57 David Woodhouse <dwmw2@infradead.org> ha scritto:
> > x86 doesn't do bug-for-bug compatibility, thankfully - we have quirks
> > but only 11 of them, or about one per year since we started adding them.
> >   We only add quirks, generally speaking, when 1) we change the way file
> > descriptors are initialized, 2) guests in the wild were relying on it,
> > or 3) it prevends restoring state saved from an old kernel.  Is there
> > anything else?
> >
> > https://lore.kernel.org/kvm/e03f092dfbb7d391a6bf2797ba01e122ba080bcd.camel@infradead.org/
> > is an example of a bug that "no SW can make any reasonable use of".
>
> I actually believe that the focus on ICEBP was triggered by some weird
> gaming software's anti-DRM mechanism, and that it *did* affect actual
> guests in the wild?
>
> But yeah, *fixing* it should not have any adverse effects. That's the
> key.

Yep, so "bug for bug" is not it.

> > That is *also* obviously nonsense though, isn't it (see example above)?
> > The truth is in the middle, "once it is in the architecture" is likely
> > too narrow but "once it is in a Linux release" is way too broad.
>
> How about "once it is in a Linux release and guest visible, and unless
> we *know* that changing it in either direction underneath running
> guests cannot cause problems".
>
> > And besides, both miss the point of *configurability* which is the basis of
> > it all.
>
> Hm, configurability *is* the point, I thought.

Yes, and configurability goes way beyond bugs/quirks, which are to
some extent a red herring. Configurability for example says that "KVM:
arm64: vgic: Allow userspace to set IIDR revision 1" shouldn't be
controversial at all.

> > So we have the third case, "restoring state saved from an old kernel".
> > If this case arises, I do believe that Arm will have to deal with it and
> > introduce quirks or KVM_GET/SET_REG hacks.  Maybe it hasn't happened
> > yet, lucky you.
>
> We literally have those mechanisms already.

I am not talking about guest-visible changes across save/restore here,
but rather about round-trips through userspace. For example, see the
effect of KVM_X2APIC_API_USE_32BIT_IDS on KVM_GET/SET_LAPIC: it
couldn't be made the default, because userspace expects to take old
data returned by KVM_GET_LAPIC and shove it into KVM_SET_LAPIC. Sucks
but can't be avoided.

> See commit https://git.kernel.org/torvalds/c/49a1a2c70a7f which adds a
> new guest-visible feature in revision 3, but allowed userspace to
> restore the old behaviour by setting it to revision 2. All my patch above does, is make it possible to set it to revision 1 as
> well. Because https://git.kernel.org/torvalds/c/d53c2c29ae0d previously
> changed the behaviour and bumped the default to 2 *without* allowing
> userspace to restore the prior behaviour, and we've been carrying a
> *revert* of that patch.
>
> Why would we *not* accept such a patch?

Agreed. Even ignoring your revert, there's no reason why any upgrade
past 49a1a2c70a7f has to be from after d53c2c29ae0d.

> Marc seems terribly insistent that we SHOULD NOT
> restore the behaviour that older KVM offered to guests, and we MUST
> change it unconditionally underneath running guests, making these
> registers writable on upgrade... and reverting them to read-only for
> running guests on a rollback.
>
> And there we do have a very different viewpoint.

That's the design decision I mentioned, of not starting the guest
configuration from a clean slate. I believe it complicates things
because you have to design from the beginning with the ability to
rollback to old versions and to potentially detect conflicts
introduced by the rollback. This is exactly why
KVM_X86_QUIRK_STUFF_FEATURE_MSRS was introduced: "KVM's initialization
of feature MSRs during vCPU creation results in a failed save/restore
of PERF_CAPABILITIES. If userspace configures the VM to _not_ have a
PMU, because KVM initializes the vCPU's PERF_CAPABILITIES, trying to
save/restore the non-zero value will be rejected by the destination."
(https://lkml.org/lkml/2024/8/2/1032)

For Arm, however, it may be too late to change it; if not, I'll
happily watch you argue with Marc about it. But even without that,
this doc patch (and the idea that "Where a new kernel introduces a
guest-visible change, it provides a mechanism for userspace to select
the previous behaviour") should be uncontroversial.

Paolo

