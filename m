Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E80373C17
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775531321; cv=pass; b=cODJFoDArkI8wtfc9WWRCVctqcTI3oXZ5BPK4lT7ZH2XyK98gYnRp9gSj50LwONjwP4W6W3hf8Eq02yuWMZIsCwfPNG3ilRHUg4KYcx+j4aLCEQDAtUjsII0I50/OIrX9APOeb4jnguSUZTAPpO+DL3t7GoDyf6QJ6K2eQOry54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775531321; c=relaxed/simple;
	bh=k52uxGJG3jRTUKdJZJj0k217ALr5NF1LnUBSdh34lh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8YcTvluelVNmN5EmbZyvZJzB6k+XV7PiIECFZNAHV9clPsZ20ZZQ22lnSGH/pa7M1SFpZpBWA0M0BWHLuwK1uQH4X/ovljOQHQPqRGkL595GlBEdxsvyQHCGOtteUqGApBntvni8/3I0CnPWksEg7mS7RQckem2+s45RYHyaqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gkdqWtke; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gkdqWtke"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so32124a12.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 20:08:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775531317; cv=none;
        d=google.com; s=arc-20240605;
        b=JZDQFrQCnxzt9Yx1yAMVTZ1LpN4Jeos532ZjJ/VNZnY6Jg97GK+aKl/zjQc9uaribT
         jvghNtb86jDVgZjQliQtJXIiVCKS4MoPNNe4ZAROKGXK/hzps61M+bpOw9AjUEfJfwyv
         t6ZKrXLbOQoInTvlJmp4tCED2dCROjynZUjmNzBRaHgvnuFl9wGum66E6G6Tjs0cQECa
         ie6DVZB62enEaFK38citHineTBl/1XSWe9ti36rfwz3jzFZMwYtVTwlGd//MnZeAlpyB
         naIenHHL3wF0hE6HXsY18zx4kuNQx9hK/Jywwf7KSpAVOBTCDszsF2duWKWXfLJJba23
         ORHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Os2DnFhuf2hlJiSlOQD5vo78MAgCiDjrBPYSDLDhp6o=;
        fh=0zWokR3vH2Vg5SDExij9e97JpbEFAp5PN+0jdq38N1s=;
        b=V1PNZcKSIYf4V/AR0P3GEDmAK+NrmeuPv3/zI87xlS8ak0bY2sF/jaW5BmhGOHIhnO
         qQCRB8hclhU29r6BOP13qUGhx7K94deaBqJ14GpGKxGBP5sg8FGeE3kgF2EvaOg2VkXN
         OjsgErVvRlsFYyI2wQghYqGdK1fUwFGbXbuUS6hWSXocr9Haln3QdcOlZtipGgsmCgJD
         MjflP9KRkDSz+cGyq9+Q63bvpGTer9mxGxIkGgDyRNo0RKJy83kl/cbL5qbE4Hsts4qI
         kMMR+JjWVyF60L5KJzOYU3IxDu1si48PnQ0v7Cre1VdlRJQprQHN/h5YvvYuKgS0marl
         DGDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775531317; x=1776136117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os2DnFhuf2hlJiSlOQD5vo78MAgCiDjrBPYSDLDhp6o=;
        b=gkdqWtkeZupAx8Wfx1zdXj7Twpm3QiWAKkmFepsNiMS0sIpSVZTFd0MUuPYvjQ1alQ
         Uoty1iuKRPTCuYaURxQaIHjxXFfiretka8cU20deZoWcZ2XnkjlMXxA7hFTnVKa/XX9Y
         j8fEIPwfjXLjDSPWLALa3FDt4bf1KsxprgBIi6ALxRda0b5oJEPUg62Qnl+i/pUwl87W
         pWVC7vMc7/21ShYHhjw3LVESGgmmsEiKjs2fMyaZMtkJ6lNg1YrO6jtdI79PLA6ix7MQ
         DNf8CLjo7uFya9yi7vv5M18uqS8FQceRg3QiSpoMeSCSK/nC8qmjwGWrXDQpDbTufgRi
         75Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775531317; x=1776136117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Os2DnFhuf2hlJiSlOQD5vo78MAgCiDjrBPYSDLDhp6o=;
        b=WNearwIc8ZwwADsFuIWrugEbc3SmNlrAdxbB6QViplvMbRNe0N3Lr+PxA0o6Xyuii5
         b69b4XECTXQqaqBGPvVckmop/XAK1bdBadUaj0zRxt7o1gwn0R4yepdH6szgaZnxYknV
         j1DcNB9S5KSRxYg61zUdz9EAe6hpGGUXsRU8/rxCe8P0N7DIQTs1sxsVn1xt4rm23/da
         xEVTqhqhnDTl3J75Py85IIi0BL8xjfa6uJ69ex5sazT9sunpsse/xVtnMhPgGPH7uKZ5
         LP9qKkyO1TiaAo2fG57tzUj4NbKxNpudS70M6w+tHF+M5nhKVfKf9S8Wj6ndmhhZ1UGH
         56DQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+hJ4c+6UaLtINHTDe6toQvNMOBTZdPWgStwXWD/0kazsGDIOXUSPJx9x02xJbw8OSO0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVdvR4Lw7qryjXOrP9exBr5YsHvqD+8/PpdhOSKvCe2XJ5z933
	hX3I/jYEDwn6wtxD3GeAVM0yAR/wmfItQfjDqkvonRmCajtBuN24H3zW64zF/CLAe0440dJ0orQ
	aFerVE+8mSv9k1KHdIiGOqwxoy0BFLPzaTV4H945I
X-Gm-Gg: AeBDievbNZn1hgxQPZiKncm5cwHcw/j8k7hkj2iU+c5pYjnQ4OFrKnJSr8wdP2g+V9L
	AZaqjNRQtG7VPGxeSySx9nISJAMfoOsifEv/BoYJjkdvynuxUIVeVWQ5fRUgSigunPqxUwYggPA
	12iWzZc9grjoRz+L7Cw4B08IPvCES53SwODl4whna+iHsUz7Z4V6QISsR/TlFIalmrAvP/VoXSb
	yY/JXl5B2waF/Chji7zqHuJsFjKJ/yzLjYtRUxAPivAKdmmGf88ehVkdsEEp5z0Uf/PWtyR3GES
	QwEisVt6Z1vfEUfMmg==
X-Received: by 2002:aa7:d44a:0:b0:66b:860f:3799 with SMTP id
 4fb4d7f45d1cf-66e43f30587mr117520a12.9.1775531317160; Mon, 06 Apr 2026
 20:08:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com> <20260327234023.2659476-9-jmattson@google.com>
 <adRGLPrmBpX-3DdX@google.com>
In-Reply-To: <adRGLPrmBpX-3DdX@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Apr 2026 20:08:24 -0700
X-Gm-Features: AQROBzC8X9Gxsb_fQZyGU7iYS90MtfxxpD0EqXLCCJdCUeZKGIMxWSh5vBrbGnc
Message-ID: <CALMp9eQsd0fRuDE_R57Mn6-N6jCtbmoPAh7Y7CBdMEZJaNSUGQ@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] KVM: x86: nSVM: Save/restore gPAT with KVM_{GET,SET}_NESTED_STATE
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 4:47=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Mar 27, 2026, Jim Mattson wrote:
> > @@ -1918,6 +1921,7 @@ static int svm_set_nested_state(struct kvm_vcpu *=
vcpu,
> >       struct vmcb_save_area_cached save_cached;
> >       struct vmcb_ctrl_area_cached ctl_cached;
> >       unsigned long cr0;
> > +     bool use_separate_l2_pat;
>
> Land this above "cr0" to preserve the inverted fir tree.
>
> >       int ret;
> >
> >       BUILD_BUG_ON(sizeof(struct vmcb_control_area) + sizeof(struct vmc=
b_save_area) >
> > @@ -1993,6 +1997,18 @@ static int svm_set_nested_state(struct kvm_vcpu =
*vcpu,
> >           !nested_vmcb_check_save(vcpu, &save_cached, false))
> >               goto out_free;
> >
> > +     /*
> > +      * Validate gPAT when the shared PAT quirk is disabled (i.e. L2
> > +      * has its own gPAT). This is done separately from the
> > +      * vmcb_save_area_cached validation above, because gPAT is L2
> > +      * state, but the vmcb_save_area_cached is populated with L1 stat=
e.
> > +      */
> > +     use_separate_l2_pat =3D
> > +             (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP) &&
> > +             !kvm_check_has_quirk(vcpu->kvm,
> > +                                  KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT)=
;
>
> I vote for either:
>
>         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP=
) &&
>                               !kvm_check_has_quirk(vcpu->kvm,
>                                                    KVM_X86_QUIRK_NESTED_S=
VM_SHARED_PAT);
>
LOL! Aren't you the one who keeps complaining that my indentation
doesn't line up? Are you schizophrenic?

> or
>
>         use_separate_l2_pat =3D (ctl_cached.misc_ctl & SVM_MISC_ENABLE_NP=
);
>         if (kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_NESTED_SVM_SHARE=
D_PAT))
>                 use_separate_l2_pat =3D false;

Wow. I really have no idea how to predict what you're going to want
the code to look like. How is this better than the original?!?

>
> > +     if (use_separate_l2_pat && !kvm_pat_valid(kvm_state->hdr.svm.gpat=
))
> > +             goto out_free;
> >
> >       /*
> >        * All checks done, we can enter guest mode. Userspace provides
> > @@ -2017,6 +2033,10 @@ static int svm_set_nested_state(struct kvm_vcpu =
*vcpu,
> >       nested_copy_vmcb_control_to_cache(svm, ctl);
> >
> >       svm_switch_vmcb(svm, &svm->nested.vmcb02);
> > +
> > +     if (use_separate_l2_pat)
> > +             vmcb_set_gpat(svm->vmcb, kvm_state->hdr.svm.gpat);
> > +
> >       nested_vmcb02_prepare_control(svm);
> >
> >       /*
> > --
> > 2.53.0.1018.g2bb0e51243-goog
> >
