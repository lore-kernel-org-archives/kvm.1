Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4981032A3FD
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773248032; cv=pass; b=jzQh/6xR76B3rLW1FUNj+6CqWYX+7v4UhiqSrYPvbzuMsiT6WH+Kt6s8p0/Ft6R2TYzIB0Q3uxc2hAaAGI+dy/v7z6j9qbNnGJtO3TLZ3ECHLtDaHJskWEFL0SXxABHDfHnAuYvjMlnPm573HeejcTn5BV3LaaT9+Jk7cTJJ94E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773248032; c=relaxed/simple;
	bh=VvpqnR3wUSSH16tTVi6dlcFDyUG5FgFSGstFAfteAKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcQil3gOzVj91Xy0hxnQ0bsF1mC8ek5iOSglos03b7WMtx5OwiexBePf46nESgDUCegKDhJR8wJ89Hc95YjDW44yYKPoadmTGiNSh4QNyPDPK8TzPux7m3JwE99sOpygs5fMhtWoqDmBF+jB3pdokQrkbF3YyMazmCaJPV0mVKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VNAUMuqy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5psMziM; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNAUMuqy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5psMziM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773248030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
	b=VNAUMuqykAN6mKkdhUQZrzLi7e4+7e8juURrcAJJgdCMmxjiaxkzqcfXpvoHlzTQ9kHs5B
	WLVLP0kDM0yFx4kCy9i7AwYhTnmyI2b7czpWl/ZEuPY78sHotY4eWBzFZD/1qxbZ7AISwn
	fXP99stZ4PzqZ7bOGgLGYdtDLvzZ7P4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-GVPwb7cxN82fQqVzHiEXJw-1; Wed, 11 Mar 2026 12:53:49 -0400
X-MC-Unique: GVPwb7cxN82fQqVzHiEXJw-1
X-Mimecast-MFC-AGG-ID: GVPwb7cxN82fQqVzHiEXJw_1773248028
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485390246c8so964745e9.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 09:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773248028; cv=none;
        d=google.com; s=arc-20240605;
        b=LzkNXAqFqz4K3+cj7kaDjjuPkPjO3axKfH3ZdSOHfZpGbSPMSD46PiEkpJD3CjPTbm
         PMbby8vdtAkYzF5WxLf6kGLvAfjhw3CioKfau8nE3Q/t5UxG9g1edK8eZYKrukP8QdRE
         5rmnMQ7t9HP4Uap614gVziHN17ZKkuzg3P8pcYRepyYn51/5dT2Uc8lgwCHcKigd3+Hx
         7tkQ22dPSw7XjPARwSq73p0cVKq5VO+At5QeJxEIzPlXCvlUXmfA2pX2mdQZ+0z1WJHY
         DcXrY85mxGUMkrLQymAb5h3wvGn5CNki5FJr3lzHSuzN2ulUKGMxXDepq7sQDlPJCfwC
         G3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
        fh=VIOSmbtQBJpOtqRvlvfHDObvfY8ahyp2mbxmGshThU8=;
        b=AJk4vw812kubTBZ8APmyl1kRPsdNCgPraF2nBj+LgygDL9F7HZNw51rVycIxntaGsH
         dE4z1WkXRwuqQmmkZj+j7ZYXGVaPVAZuazcC9Cnzu9V8nunAcBJB7yaXG0lTnezcyOyj
         /pTSDpammS0xfr2O8tYC5vRrSdmsbbUMGPvgvgDxBNv2k9a5h/ARguwX0Z7qcXszbdEv
         JSRhmAZOqagHFTW8rhkoAOC8DmvCDuDFwVesHDwe6xFa3hokitIE9OMo03vUoiNxE0gF
         P/KmYhU78vT50fmsb9u+Wd/P7IhiRbQRa+XSs4N49kY4JCqchMnQlPTZgVIcCQ5lQPAr
         qPlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773248028; x=1773852828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
        b=K5psMziMnsNsBll+US0sqolkkJSP8B7siT/wXm2/Y+4/05IQIJVXNXyP8AWJUAYYOK
         6w5FTaaNCb/K3CIP9tw4IESQqYiBtAC+ygr/bwOIrEfe2PVzP7aiDQr/0xSyW61LQfVl
         rSpypyePeAijJvcPdqxw3OctsvZmpaQoE29wpReCNkOvD8EH5o3R04ef1yP8Gve5s5U6
         lzNk7NnKkjwXC8fobCkx+tGt+SbuZqWkdqm8BHenwMFgrO+wKIkdvgvMNig9/iVQUeBt
         +e/0iQlicEtLEr8sLVLUydLrr6eEm+XgybgUCfOFfAl8oWOyT0ju2NsZ70kscFALu1X/
         ZDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773248028; x=1773852828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6ouqFOpofiRNlkZSgBBuN2FHJVkzx00Pt6fyeGhUD8=;
        b=warxqLgfQ6+Y1UjkfxqZ32QtgzcOeUwOJoS5R3LDyw8cSbVpwyZhVfHEvaZ3CuB7GG
         m+BkggCfs1R56qcUtMoaGeo7P2YLYIVzoSQ2W6zfMdPdcKzO9s4oxXPPqIQCwxFuOVu6
         dh3jpybVVKs4eZa+7fJg+5jNJ1MHpABGtpauPVAjOikHzfcvzwFmhKE7Sh4H51saNkcq
         GdYj55ASZbdGeaZOQXO921T1NGiIY1wd/HDEkV/HGwR/l6NTNBiYoeGeNG/RKTAGYLLW
         Frv4TXbtxPCjkFP10dGJ2HJQz9C1dAddMBnPA9UWXNxY892dNB+vyC5ZxEPwmdTfAhRJ
         m2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn8Wd7NVURSUSnw6yRARS9lig/VmQSnHQibqyi02CHYYAAjYsYn6KPWWRrmUSYnSJg590=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PCvLNpZju4UeA/QwbIBVAdM7J8PibBEX7hPegU5daxi7N1o9
	GB1YWnU1Ug5o1HlOG88g90IMnbUWnXehVoSRJuiTqeTNzhGPUJwY8pBWCEtVrGU63ebknsPp1ih
	mVe9uPzdmmF3cw1UbY9H9bR4474WfUiE9JVsQbjN/U/SMp1Y9nDh14wu4UmsGKadE51UcG8IDqz
	oMqEGm2Vl6P3W8nftZntAttvYP24zJ
X-Gm-Gg: ATEYQzwhM9MKNMCUXMCV/VvlfjdgBuYnX3C0b54zdHqsxmx+7fr/DMZalX/7oJ077IB
	l+7XpQF4x9EwBKAyhKaCJpHgL7MzWuCzTgC+NzpaNZIz3v1Ey1Rz5tEbdR8Bz/MqE9kJ2LF1Nln
	zpfM34eO43MOEF71ZG3efq4t+ArsVWpj6xVHoSZXOdYEwSRB3zAd3ctdJ0EJtYYtTNeTnTpyEWI
	WVXLye+mpj98DjHIxDSQpAM7b44zy5giCalBVo6miRhJo4F27C9gyH1hxDCT+L0jpKusd49Ewpu
	Y8B69vk=
X-Received: by 2002:a5d:64c4:0:b0:439:ac98:751a with SMTP id ffacd0b85a97d-439f8222f77mr6548996f8f.34.1773248027858;
        Wed, 11 Mar 2026 09:53:47 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:439:ac98:751a with SMTP id
 ffacd0b85a97d-439f8222f77mr6548943f8f.34.1773248027390; Wed, 11 Mar 2026
 09:53:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
 <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com> <abCRA_B2kHp6T7Zn@google.com>
In-Reply-To: <abCRA_B2kHp6T7Zn@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 17:53:35 +0100
X-Gm-Features: AaiRm50TIIp3y6fvJJ__bDA_OJxo0z7OHXqTxBoJsDcFI0RUbVklP5XL8G89zrI
Message-ID: <CABgObfbkkFA3akgEdwFZ0YHsKUKJNUUPujBQrBbHhCNtpW_8+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Xinyang Ge <xinyang@anthropic.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il mar 10 mar 2026, 22:45 Sean Christopherson <seanjc@google.com> ha scritto:
>
> On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
> > >  arch/x86/kvm/svm/svm.c    |  4 ++++
> > >  arch/x86/kvm/svm/svm.h    |  1 +
> > >  3 files changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > > index 7b61124051a7..de9906adb73b 100644
> > > --- a/arch/x86/kvm/svm/nested.c
> > > +++ b/arch/x86/kvm/svm/nested.c
> > > @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
> > >         return __nested_vmcb_check_controls(vcpu, ctl);
> > >  }
> > >
> > > +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > > +{
> > > +       if (!nested_vmcb_check_save(vcpu) ||
> > > +           !nested_vmcb_check_controls(vcpu))
> > > +               return -EINVAL;
> > > +
> > > +       return 0;
> > > +}
> >
> > Nit: if we make this a boolean we could just do:
> >
> > bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > {
> >        return nested_vmcb_check_save(vcpu) && nested_vmcb_check_controls(vcpu);
>
> I don't care one way or the other for this particular patch, but once the dust
> settles on nSVM (assuming it ever does) I do think we should align the "nested
> check" return types across nVMX and nSVM (which is likely why Paolo ended up with
> the above; I requested using -EINVAL for the nVMXx) patch.

I was indeed aiming for more similar code between the two. The last
few nSVM shakedowns prior to Yosry's (nested_run_pending/live
migration, vmcb01/02 split) already took some inspiration from nVMX
code and naming, so most of the low hanging fruit is gone and I didn't
want to actually make things worse...

Paolo


> My fairly strong preference is to use 0/-errno as "return -EINVAL" is more
> obviously an error than "return true".  But we can bikeshed later :-)
>

