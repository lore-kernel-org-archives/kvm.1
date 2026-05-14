Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A9330641
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774678; cv=pass; b=iO6Ym1JRycHWZzBQQWo0NjiLQXAwiQ3+7efHRUJfB1HMRxR4pljx9gtR2rhBSJw19M+OwVesvM5vaDY/jsjZwILGJh85kxiKQeOGZNo+O73fZM4DMKHaWFX31B2H9MbQaxsYALKJv31bKGr0s4cJtLQfj7SqPs8d8tjV0mALxjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774678; c=relaxed/simple;
	bh=sx52AyJnY1OVLerkE3KiVZvVcpVdOYqnxKFUmPOQzRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeckcTTkG/Qw3EEbYQ5yTGBBGleTs5iplOKznhgFMmr+GsqJUwJAV1R1SJIzy1UkePXUkL7cr/y4WA61wegJLgeDu/TDxC3uobn48Czdj6Gk6uvvL851+Zxt2WTvZtrnG/ZpVYEtAi8/WBW+11+aEp0t30FQnizFCtkyiMFTc08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IltI95Oz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uHHQhqWE; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IltI95Oz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uHHQhqWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778774676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OBah0jy5o5mrbpPMeJLCxWqRe1WMJyikYeHwAnfQGw=;
	b=IltI95Oz3/WaY7kgcXNHkkx4ad3Ok2sVEyQnuxviJ7UNEyOLlM6v9+rBNHOEUGqpEhXXW4
	2mNHb+8PdgSNdyTuDkf0m72rzbekHqdTWnJoQSHSXRxq6te7Wen+i9SmCvcagYgw9SAwCt
	Ho/r0mOuUbcOSfQ7JzLl4keVLKC+NIw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-XFSTe0G4PaC_cUonRS-Ulw-1; Thu, 14 May 2026 12:04:35 -0400
X-MC-Unique: XFSTe0G4PaC_cUonRS-Ulw-1
X-Mimecast-MFC-AGG-ID: XFSTe0G4PaC_cUonRS-Ulw_1778774674
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44696b11265so9134764f8f.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 09:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778774674; cv=none;
        d=google.com; s=arc-20240605;
        b=hUyS7gl0yIfj/a6X0ILQ8BGy57HjJvBm35nKBsJab4rQ0nrId1zlxgB1VKMVJXYs/O
         vLynLiv2qtZR9kbPZU/xIe2u3vSovQ3iR6xl9NwLJxk4t4ZFrwufNLNpLz76HJS0fLgY
         tPrvlBxksBx6/NXZiPtOqt1VXAQbnsgaj/fUGEWhrIXTebHF9mQPFlukZYHnzSXahD/4
         YPyB5YDpR5UguFO/4Qt7Ylf0OG04UTWpJmLLwwzB1JlvgXmAsyQ3OT9DEvkOYAi/I8xe
         6O2j+lvFYBkfWiZMz0nb9QkjcR9TR1dLJ6i7TKWJt168Sm4ywv+FLGhXwJR4Nr9Ygsnq
         3RWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6OBah0jy5o5mrbpPMeJLCxWqRe1WMJyikYeHwAnfQGw=;
        fh=FzgTtF0W0CFsarF1W8P7Mi6gBWpVREW/n+Y75SYkpog=;
        b=B637HjKfhEehnftc/7BxeV9ztS5x9xLvCmCEap3JYRa0BjdN4u0XrXQtqgHWUJbfQQ
         IsmBhamLE8fJr6pU3WDCifgOAXizL2lFAGtnL01SKiNKnTkOReE3lvf+mgiwMKolLX8+
         8zYcQrJynjn69IOXMMYqpVLINgx7vy8I5PtsfHBTaVow06+HrtsJin37lcAAxKLwt72t
         tMFXxO39pcwWv6rbnTbQZ1SnEnszZsChyKMHwDchAiZupNgP77iq4mgdYwW3I9up8uzN
         svIHJ4Fy0ivqidOoQf02w4ai6GR17SInJcfmt2irdelF1wOy+V6K6cS1xP+NV5y+zbfx
         OLIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778774674; x=1779379474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OBah0jy5o5mrbpPMeJLCxWqRe1WMJyikYeHwAnfQGw=;
        b=uHHQhqWEbmXgyd3mCftEYo+hrCP/oYpivI64web9AebRWllQ4q3eipWya/JYYDYOF7
         yb7V7Zh4ZFqrVPfzVxNBuoIfRF/kxrslPQt4qIkNTC3pdubY9iLEWO+apjWmDf1p0lcx
         azx+A7Z5a3Krj7Aow3vrPkqSjc/pFpvmhRQ6soeHC/PRVMc+yrk0FbfajH50vtoGiXVH
         ikUfw5Q3Hz/xqkdjJ+PazYqYMHWL2KyrBsPGDOrSstufh7fA2Vho7KsWam/R46MgKVQb
         cT6FlZyjsEYd4QQEfAgvUTwm1D+/pZoknOVuVEY/eYPKTq+laZiYpNGyDzb05IIAHK4O
         mOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778774674; x=1779379474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6OBah0jy5o5mrbpPMeJLCxWqRe1WMJyikYeHwAnfQGw=;
        b=nPS8MX+i7AwcRtkYTzj1hjloV+yynfml/6E7+bQ94fuiY4kJFjCos7j+Ezjj5Ed6RG
         qROLn57nBeP6O1sphy8ZvpDv38PUyTlhRZLVsW0tfPtFIdXPVOaz0bClfjlooliWKoZI
         d5H3tnukAnaL/T9cqQTEQxfd0z5oxW9/9/qU9oxhFXGcGyhSTysTQOj1kzoIBlqVahFf
         3csHudBUon66/yBCmMJPgJq1x1J+tQAX1ZrwtYYE5YIhOPYS3YguA1ZjGDzGF/BL1Gx/
         Kz0aLhoMMdLvz2DCw66j11pzwSSHOO0itLwaClADrE76QKH6dSMktMcaiI6+p2JcN2DG
         UX4A==
X-Forwarded-Encrypted: i=1; AFNElJ8mL71YVuSmT8X9O4zEf54TvbxvTyiC23fBY0RJx8iaHtzTbIaBmr3xK+WvSl2CjzSl3kY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbfYgRrtl4RpMzpSh96olMSVeTVf482fopiG529zfI/IRf0UA3
	QUsA5IF1oEhXF1rBTi2GJt3gC5p+Rdl0r3xZVtjiFbTC+HNEo6/SBhMSeL1m0hYJTeqVmD0TsNm
	kRgsVONnNDqIRJsEDc7dr7/ZgKpRFUaOZnFZinsnQ0kwAUie++Im/zS/HTGQ3Cfoe2YQ5Jt1YKO
	mYdrglcihal9Yi+fa80e4eYkXOyKo8
X-Gm-Gg: Acq92OG8qXruWir9aO+ySM6s13Kq+J+22A9Ap9dKiJWAHrhYCW+25pgiv3xWhPoPRY1
	tGThD6hZKbwjSk4KKC4UX20UkaoWyYMzgiJlbPVgLUkK8RRak9iLnJ9sqoSoxdQAJu3IRr1F0or
	TVcK6r12DVG7cNyUO4bZWxJfG0z94JzJoMPnpdL0ilTIFMxj1avUuMs1vYrLw/iU9vWsBByWk10
	jjwC7jvqt0+B2LE11U27IhTqIq3XYrYuqKZcwSqWRBN5chjfA9IRzUBz5X1cLLDpHb4VU01gPBH
	Vtxi
X-Received: by 2002:a05:6000:2c05:b0:449:c5e2:a8b7 with SMTP id ffacd0b85a97d-45c5a77ee62mr13428812f8f.30.1778774673428;
        Thu, 14 May 2026 09:04:33 -0700 (PDT)
X-Received: by 2002:a05:6000:2c05:b0:449:c5e2:a8b7 with SMTP id
 ffacd0b85a97d-45c5a77ee62mr13428739f8f.30.1778774672941; Thu, 14 May 2026
 09:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
 <20260512011502.53072-7-chang.seok.bae@intel.com> <6adbdfb5-c4fa-455b-b427-2f8350bc9c2e@intel.com>
In-Reply-To: <6adbdfb5-c4fa-455b-b427-2f8350bc9c2e@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 14 May 2026 18:04:21 +0200
X-Gm-Features: AVHnY4KQzbqEQMfQSHVgV33mWFuZmjs42GOHff7YBk5ZCMWXyt-SyCHgPWSqG2Y
Message-ID: <CABgObfZmFLDZPLEeLW5=yk8oyO8ibXr48JSVXaF7cKfz2SQw4A@mail.gmail.com>
Subject: Re: [PATCH v4 06/21] x86/fpu: Ignore APX when copying from/to guest FPU
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 9:11=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/11/26 18:14, Chang S. Bae wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> >
> > KVM will store APX extended GPRs directly in the regs[] field of struct
> > kvm_vcpu.  This is done to make accessors more uniform between GPRs and
> > EGPRs, and partly because x86 maintainers expressed the desire to compi=
le
> > Linux with APX enabled sooner or later; accessing guest EGPRs from KVM'=
s
> > C code would get in the way.
> >
> > Therefore, let KVM handle the APX feature on its own when executing
> > ioctls to get and set the virtual machine's XSAVE state.
>
> I'm sure this works.
>
> But it does look a bit hacky to me. I just despise adding new special
> cases to the XSAVE code when we don't _have_ to.
>
> Couldn't we, for instance, just let the APX registers use the "fpu"
> ABIs? PKRU is weird too, but it still gets to use those ABIs.

For PKRU it makes sense because it is not kept in the FPU even for the
non-guest case. This is not the case for EGPRs, but I guess it would
be the same if the kernel was compiled with APX? If the kernel entry
code would have to stash r16-r31 from userspace before entering C
code, then we can add similar "unsigned long *egprs" arguments to
copy_uabi_from_kernel_to_xstate, copy_uabi_to_xstate, and likewise in
the other direction.

The problem in doing so is that these are just plans; if the idea of
compiling the kernel with APX doesn't materialize, all this copying
code would just sit there in arch/x86/fpu, adding extra complexity
solely for KVM.  Maybe we can add a comment like

/*
 * Since the sigframe case can copy the EGPRs from the FPU,
 * copying the registers in and out of struct kvm_vcpu is left
 * to KVM code. If EGPRs are ever moved to struct thread_struct,
 * they should be handled in the same way as PKRU is.
 */

to clarify the reason for this choice?

Separately, it's possible to avoid hardcoding APX by passing a mask
argument to fpu_copy_uabi_to_guest_fpstate and
fpu_copy_guest_fpstate_to_uabi. KVM can then pass
~(u64)XFEATURE_MASK_APX.

Paolo

