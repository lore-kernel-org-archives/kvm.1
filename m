Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CB196C7C
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777607554; cv=pass; b=CfMpqAYmERlbXq9dW+PZ5yHVBxnqpLI9hz9sV9Y/zVs/ylRJnNcMjY0SxaSkPLZQBTzEInqT4042GcVEy7WIN54x7iXt7/u56XZ5Gt3eKsPL2Qq4aRsXa3nRT2KcSqJLxOjeaP9RimaSSVDozb2oMmVpaNBckJnAb6c7HGvWTaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777607554; c=relaxed/simple;
	bh=4fw+NIcj/46mN95AKGmI5DZT22Zy3WMU82DBXlkDd6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hflXuBPmuJGKT4jyRlq4/J2JOZDJEtepbnQ/bICnUTDwMnPf/I6eDbDrZ5HNBaRhEgV28kia7Gj5DHxB1RD2mvcdpNbBQS43+K2HA3EU46E9dt8aE2D/GxlSlp425mIxorMsRFQh0p7kKF9T3dNJwNVB1JsNFMzPsflEOqLcrJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHLViRgo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=leiXWyTE; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHLViRgo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="leiXWyTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777607552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e69doH1FMBtpw6egk27Mx01FNROxweK/4j6n5Nbbzh8=;
	b=XHLViRgooUBHJzQvvwty5kQ0pBRNMR3mSpoDpgR2cA7Pa8p37BAWwXlZ6GihFLB7XuANxQ
	5o+C7afY7I3dUR6ykCMy2raG4c+KogRGtuT4dVtxYYiuUjsg5E6N5hv9+JN15qBBXBhQbe
	j1Z8ULWRDiXLqVrmRkWbIaopDqOhxPw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-aRdTGRSdMdKD375KZijjSQ-1; Thu, 30 Apr 2026 23:52:31 -0400
X-MC-Unique: aRdTGRSdMdKD375KZijjSQ-1
X-Mimecast-MFC-AGG-ID: aRdTGRSdMdKD375KZijjSQ_1777607550
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7757463eso1669329f8f.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777607550; cv=none;
        d=google.com; s=arc-20240605;
        b=cSvVQX3efLuUjgLXuiPNGJRn5nS2GHs4t75LmokFKAJX8EbcFPxr92+9DRwSFA32py
         OU1RwjdjkBgFUWZ4rHnKjbnpdNPyK698bxklKSW0NmU5cdqGLP76zcqIm7Faq0qBYlYW
         +RJ81Rcr0qKUJkHbTKLTWA1ZqMNqW7vBDwI3KZUkXZJx/0dJY4THDbaQJUUhENfCVT3v
         m7AmpOVssaY1dbswtYjzlo8f+6zrlGDBQL9+0vd08qWuPUABDRaszJ70Of2Ws3IGPy3R
         cATSXFrW0QGxRUKvgWnwTilZFJvASkEi+60WMY1shUStuZiuFNAJadY4TtVfOjKTI97b
         yIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e69doH1FMBtpw6egk27Mx01FNROxweK/4j6n5Nbbzh8=;
        fh=e/lXFV3H5/ATa0pvQ91lHG12XEUOEs2/FgI1DzkexfE=;
        b=QVqG017tMpTcNJYtkWGqjPSxWA1Xi2ykz0Xe0s8l3voRKJfQ63sKQf5yuWnlVy9WBP
         i0VFgQLl3P6+hkbcR6waN3r3TH24cdwYdQWab9bmllkpSkPmrvO1mhOV8KzoyqsjhO1A
         24/0iS1aGIQ0V0UbB/FK+Ieam3rnRlSqFakFG27KiB/HFj+kdiTj879EJcGaqnf8sWEU
         9Pp1FXZmd4gxPUcvt+3aUGv+JpvteH94kIoHOpVV1tA8BSwQQr04aH8JLHeOLRX3sx6z
         93DYemPYLbsvFFcCuQ1ageFM/MvaRrpLUY82vWVPUFJ0kubsdX0VdugLaDHUS79J6vDR
         RTKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777607550; x=1778212350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e69doH1FMBtpw6egk27Mx01FNROxweK/4j6n5Nbbzh8=;
        b=leiXWyTETdCXnQHXT/UYixuYY6IGhhE6iOEbpz8GG4Diz47vyGHEW9rTa9Fvo5HjG5
         cZGUKhytFySHbdoMcUHkaxHx5T2/AEh8usvI0UCOQux/Y3XLz1zr77G6vvI4GTtSUD7D
         wxEc29DouYdYfD22BWOg/Ur1cOnZg3aWC7WCCsCfnlSawDuqV0CF285qY9DhGEsgYz2a
         Qx4kPTjp8QSJN0FldiQzXRKluExVRGVrMdxNL212WZIDL2b5RT0EDoDERmLXMRzvBlk2
         Uxoqttl/A0olDyxOgdkpSqoJAl6ZUye2biXurDOxUusIf7VvaD/dcdMZ/tz6BjgWZlQz
         Z7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777607550; x=1778212350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e69doH1FMBtpw6egk27Mx01FNROxweK/4j6n5Nbbzh8=;
        b=Q9aEwtEXjca6TVU6+oHW7PcI+9nzuZDTvbMN77fuxvC2GCg/7Ru3vwE+49l34Xy3z1
         dcsZXY/U3SUuM9Wcd1lrtryYarI6sIcc4okxpClnTFRqWiee6kMbknUDtPjyUg3+gwOS
         /xv4x7ie4oOR57bOV+KH6xOQdAefoqFxwi0G9FrYlhIT9oacJwyYdPGQKDb4M8MNSLj8
         xfAVNQMfQYT9TufhFDbDzUCoSA/sAioVe5Z0m86PBiZXN3EGc/iaM+Dyc37CREYiAoJ3
         3pU3xfP2ZHfseW6vb3ydyA3GqGYHd1z8SKS+rfA6K4er9Jd6YLKdaPf3/avJXZajhqX5
         Wyvw==
X-Forwarded-Encrypted: i=1; AFNElJ9j3xM9cGLCEf2BYUJj7tGk583OzC6R/T3z3ZZq6FHRxU6eUjgl4rbz53QZvpSEw+5vGm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYWZu7EGHC2Pq7IbKLGE+oCH0o/C+7cI5YVAvtfU0Wl5P8Rvg
	IbOIaMtY04VPY0CL/Sz+tgsz5e0sJkjQp7WpsJGz5X6SIe2pjd3EoRuZXUD6zC+pPyQrUapcnNU
	ud4kNONxbqv/WD6aRi4UPY3G69TCFDu0bwYQdVA9dwGYd+Y5hGrcrWY4zzjHQKj93vTte9PFkpG
	WOQdJSve/7ZSMzudxqIwIXsp9TRosU
X-Gm-Gg: AeBDietDGJt8J6VohsT1n/8wZtNBVuR1UOKM+n7c8a5qUc6Fa3FMeZfox+/5Wz7EYwu
	z0ZjRtRu81CwamBYjT+oUJ+pXELLMvjPyPeI3SsW0DjRu/vSH66axWZeJ5qP+OgTxUlslASykEK
	J7/s96ewRuJm8h+yRMgYhJbWuiJWEP+hGoqwjQJMQCYyoYu32NDeLUsa3QlrlDOPW3NN3bkJ3tq
	HqJD0kSLhQW/PnMI0tord80M0iWlyIdpNsGEImg2hOwMzls8TYWu1NmbOxtdmSH1KPEU8BkrmGd
	P6GMGbM7v83BUyc=
X-Received: by 2002:a05:6000:41db:b0:441:1cfb:2024 with SMTP id ffacd0b85a97d-44951014699mr7843971f8f.26.1777607550008;
        Thu, 30 Apr 2026 20:52:30 -0700 (PDT)
X-Received: by 2002:a05:6000:41db:b0:441:1cfb:2024 with SMTP id
 ffacd0b85a97d-44951014699mr7843949f8f.26.1777607549669; Thu, 30 Apr 2026
 20:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430150747.76749-1-pbonzini@redhat.com> <20260430150747.76749-11-pbonzini@redhat.com>
 <afOkj-ngsW0udc7p@google.com>
In-Reply-To: <afOkj-ngsW0udc7p@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 1 May 2026 05:52:17 +0200
X-Gm-Features: AVHnY4Kb0rYfNZhkaRJHU7q-AWOsW8A5bDfqdV3AeE6Jlec9nxstK5bgSHKFuog
Message-ID: <CABgObfbVJkK_sTvWWXa3T0d=XPeeWoGBBjQtvtegTEs=zEJFSw@mail.gmail.com>
Subject: Re: [PATCH 10/28] KVM: x86/mmu: pass PFERR_GUEST_PAGE/FINAL_MASK to kvm_translate_gpa
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, d.riley@proxmox.com, 
	jon@nutanix.com, Kevin Cheng <chengkev@google.com>, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:51=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +Kevin and Yosry
>
> On Thu, Apr 30, 2026, Paolo Bonzini wrote:
> >  static bool mmio_info_in_cache(struct kvm_vcpu *vcpu, u64 addr, bool d=
irect)
> > diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_t=
mpl.h
> > index fb1b5d8b23e5..567f8b77ffe0 100644
> > --- a/arch/x86/kvm/mmu/paging_tmpl.h
> > +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> > @@ -376,7 +376,8 @@ static int FNAME(walk_addr_generic)(struct guest_wa=
lker *walker,
> >               walker->pte_gpa[walker->level - 1] =3D pte_gpa;
> >
> >               real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(tabl=
e_gfn),
> > -                                          nested_access, &walker->faul=
t);
> > +                                          nested_access | PFERR_GUEST_=
PAGE_MASK,
> > +                                          &walker->fault);
> >
> >               /*
> >                * FIXME: This can happen if emulation (for of an INS/OUT=
S
> > @@ -444,7 +445,9 @@ static int FNAME(walk_addr_generic)(struct guest_wa=
lker *walker,
> >               gfn +=3D pse36_gfn_delta(pte);
> >  #endif
> >
> > -     real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn), access=
, &walker->fault);
> > +     real_gpa =3D kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
> > +                                  access | PFERR_GUEST_FINAL_MASK,
> > +                                  &walker->fault);
>
> Mostly a note to myself, we should make sure to land Kevin's fixes for sy=
nthesizing
> the #NPF error code and EPT exit qualification in the same kernel (which =
I fully
> plan on doing).  I'm just happy we all came up with the same annotations =
:-)

Yes, passing down the exit qualification was yucky. I'll check what
needs to be done in Kevin's patches to support advanced EPT violation
info.

Paolo

>
> https://lore.kernel.org/all/20260313071033.4153209-3-chengkev@google.com
>

