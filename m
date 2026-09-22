Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F51386562
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100545; cv=pass; b=RlBo9+36W4OS9gszQ7xF2rR+ZznfOOVmCVEliJGGzWQZdG216AuMPoKPTImGmL+qcnfj2RM/Mbq3wvwy5C0EZ1gc/AeT0LJwTIvuFht55J5wCiokLgCPRl9TZiHkJFHeOU+0E9TA5XiJCZNG2FkuE/JREDFHyaTeJkY0VakrBBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100545; c=relaxed/simple;
	bh=YagOku/D0v5zlu5wCXTkSz9AI7E9UaI6TwljGPvDzgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7pz72LPp3ixRpNKAvcqwxJRgF2KeJfZGy2XCmQND8XQRW1NN701nrw3djHiosEQinW1B/Y8HB4HgpOUozPpd0GI+7UWoMhJmkqsiCfDVfTy9a7NSUyAlL+m+wjP91yTIQvfWN7VVo9m8RAc9R04TJEJAmITBErnutQL0QSCMwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hotekprI; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hotekprI"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6aa13d8d9d0so1393a12.0
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 11:09:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790100541; cv=none;
        d=google.com; s=arc-20260327;
        b=DvmyE5Y2tKcBYZp/EPCafqwwlsBS94cHY/6QWid4uKfSqxNIWR1nFmJthBj+rTRXVd
         c3zzW4zK9TBStoR1noFbo4UHVVlxEPDCnSacJjMPDxnYJeGf20P32yHbNFi6TGip32Ga
         1b67a1DztibAaHoX1WT0N+wkwgDYTLX+TcaBHjRLdUSdPv0mnq9EsP4RTMJRG+qoey7n
         hF+Y/aUq37EoLtfEAVoalTaBMZhJNcLCil7UpZzvJDCpaX8QqzflcFKajBofWnMQuv1u
         jVUscQiCcfoJmLJIaX3ArFVjVh8TfsXsau9ic6EDdWTZf8u6nAsjy0Sr0ssQCyPO1Ig9
         8EbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8UYeuyjCv3q5EPl5dH/d4cKtOpUQwBBX7CUP3vxOjWA=;
        fh=BbyrbEzCvfxSG27K/yyZpJaxgoHKTOXWgciLwTTcnBU=;
        b=qbreVMjY/t/yutdU76eQhOUSbWeUIVnBKW38dzPjq2OK7O1kTQ//PPBZP3zxdmbKC8
         U+hCAOr1aSGR5kihpZpNx6xlb0I/TaWHCkF7IxCta0/ImCzmh1aQQP6dX14uLAgjTxyC
         N1O2qKFZdl9fNq2hV7lh3TI8DghTAU1keAFp2LS+9Sfn/mML2AUzWm+jriA2H8dIbO12
         iIrd2kBkLthD/eHW5RCn5Po8vVSD3Xgjcbrw/fNSRE542O+ekqgr9h/SLJhJ9ExNJKG+
         R0xhyV9NbqLeu/XAC+d/W7qG6Mv4MBydgrwOwPKc6maevMewrN+NRcBm2eObxOyGZHVW
         MTsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100541; x=1790705341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8UYeuyjCv3q5EPl5dH/d4cKtOpUQwBBX7CUP3vxOjWA=;
        b=hotekprIye1KaxbcJCfKaWAw1Ii88ry5PO5Ln1HvewIpktO+Vq9to96BEtFx4qf2Ky
         SF5RjFPIGMTDHS9Mw/9GovCb+93HcKT0WJiF2XP7u2F4ge6yHs+KKtQu7btZXgnrTsTm
         Ob9eU2EjUoqjprFZNX/+MFTVGaUkLHKJEcMvUrxq7HPFoInjFbW1IwuTMbNmVzbe6rpv
         34NsVwHxcHQaRS2EQ6Rv0VJWkCoPj3zOvxQYKmsZCBqaSKSEHcVor7Av/0eLWCPVqLBH
         JsSTEEUAwLz5nZnAguERPMAnr35U2lgG2GvVIyDhDmNIoqnh5mWsASt2uIjm8fAmEjgu
         R4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100541; x=1790705341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8UYeuyjCv3q5EPl5dH/d4cKtOpUQwBBX7CUP3vxOjWA=;
        b=IKbRFQCfgcXf/03obbn6g/f010K9gwSmx5gomFiy9ZBDouEP/uIhTe7yzYWpSKhEEm
         NGIBBEmdW4iCOCBTwgpNrmSsPo4tHtSnUkHV3iNiWoyflmgWRC87jmJBTMil7YOWhvh3
         5YqP6iES2OL03np7qhdJZpneHpGsUjLt93DI+JnOsWuP6dUK3vhmtEFK1bvNFEYZ3Ccc
         wyO32rGddsWxMSJotCIYJv6Sa0gQUtNSNMUryquLNsgx3B02X4pGbDVxlCMMgKLHXQAy
         Ss6Xzoq6wLpnDzHDRdUM4b6KJ/Hsr6deTDtTsgzJfPH2tz6GCLTZhE9p2PjgNtdDi3v5
         4FXw==
X-Forwarded-Encrypted: i=1; AKwUvBwFX1e9RVCg27MaSvWnjKrqwJ22KATaXNU3P9vQDwI8XcfGxEE0vB+Q5WnAIXJL2IfHXIs=@vger.kernel.org
X-Gm-Message-State: AFuF++mhtUyh9s77JyMS3NrDnlmR3AdQdc0AgA9BpLy2zk0+Tt527WPT
	iMWQHhrzhi2Tzog3bNGGmcvaCW49Qek9UYR4So0fTH624b4EGNgZee5z8CUM5JoOTeTvTTcTcx8
	sF0UhyqOutDJvoSwMFY9br4PIKC+yYuYRItNzMC/k
X-Gm-Gg: AYBFou0YMAqOmLV0zuz4lUNUT1a1djDJziGrZJg4fflRieYJPVNlWftgk8YrZdXSVnD
	yK1JWekwJ56R3ivCDhTxmEYnGSM7qFmP7sLAyazNsL4xXS8eMd500Lu1HXzK4Cv9+Y6CT7XD5BO
	vweQKm+jdxcZMlHTZ0fd1EeUrDsRbNk5RDo0F+GvIPkdP9zWE1KgiL4iEJurloaGHJ8mDYa6ivG
	NiQQj0KbbX8N1hKCgPjS2Vb+OvyHLgGWoyqx8dIvBMOEuniZxco0sQtTW5SbxRtI4Irb0tmni40
	02O7HqgIuHH0//TBYBUruJX2PKzPDRcKs+uQG3kIwvj6ef+x12zgiSA=
X-Received: by 2002:a05:6402:642:b0:6a6:f2a5:1b4f with SMTP id
 4fb4d7f45d1cf-6aab3b1d94cmr4826a12.4.1790100540996; Tue, 22 Sep 2026 11:09:00
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
 <arKJQwAPvApkeESD@google.com> <CALMp9eQboC6DTQfa3N58XCfOLf-qwJ2L7dC5vtqDerHG80eZLg@mail.gmail.com>
 <arKQJJJB8HMK0B1G@google.com> <CALMp9eQi0gm7ojijfKDZz9oZh+BK13qUkJOFrCmxjJTr5sx3Lg@mail.gmail.com>
 <arLAtdMP7LV0r-D9@google.com>
In-Reply-To: <arLAtdMP7LV0r-D9@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 22 Sep 2026 11:08:48 -0700
X-Gm-Features: AclHuK9p9bMGa6p8o9NcyNWNOvoonpnh0HTAaFWp_AwSDuvBs2kVHxxarQtOg4U
Message-ID: <CALMp9eThtND2KddrmySqViNsLyisdd6_ZH01s9jrA9K-_yQzXg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
To: Sean Christopherson <seanjc@google.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:53=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Tue, Sep 22, 2026, Jim Mattson wrote:
> > On Tue, Sep 22, 2026 at 7:26=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Tue, Sep 22, 2026, Jim Mattson wrote:
> > > > On Tue, Sep 22, 2026 at 6:57=E2=80=AFAM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > > Gah, I hate the negative "feature" bits, I've gotten completely t=
urned around
> > > > > multiple times trying to sort through this.
> > > >
> > > > Me too!
> > > >
> > > > > IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE_M=
BZ=3D0, but userspace
> > > > > configured guest CPUID.EFER_LMSLE_MBZ=3D1?  If so, then Sashiko i=
s right, it needs to
> > > > > be declared with EMULATED_F().  I would even argue that technical=
ly this isn't a KVM
> > > > > bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPPOR=
TED_CPUID on such
> > > > > hosts.
> >
> > > > I'm trying to make it possible to run a Rome vCPU on Milan or later=
.
> > > >
> > > > SInce this is a negative feature bit, it must be retained if the ho=
st
> > > > reports it. That blocks running a Rome vCPU on Milan or later.
> > > > However, a defeatured Rome (which reports LMSLE_MBZ as 1) can be ru=
n
> > >
> > > So, a partially defeatured Rome?  Because it sounds like the CPU repo=
rts LMSLE_MBZ=3D1,
> > > but then still allows setting EFER.LMSLE=3D1?
> >
> > No; it should not allow setting EFER.LMSLE=3D1. That will fail on later
> > platforms and would block live migration from Rome to later platforms.
>
> Oh, drat, I misread the "Rome vCPU" vs. "defeatured Rome" paragraph.  You=
 want to
> be able to migrate a vCPU with guest.CPUID.LMSLE_MBZ=3D1 between a non-de=
featured,
> vanilla Rome and Milan+ (or a defeatured Rome).  Correct?
>
> If so, then Sashiko is right, the flag needs to be EMULATED_F() so that K=
VM will
> advertise EFER_LMSLE_MBZ to userspace on the vanilla Rome host, and also =
do the
> right thing when guest.CPUID.EFER_LMSLE_MBZ=3D0.

No; that's wrong. KVM_GET_SUPPORTED_CPUID should continue to report
EferLmsleUnsupported=3D0 on Rome. Otherwise, we break backwards
compatibility for userspace that simply transfers
KVM_GET_SUPPORTED_CPUID to KVM_SET_CPUID[2] or userspace that just
doesn't know anything about EferLmsleUnsupported. The "default" for
Rome and older platforms should still be to claim support for
EFER.LMSLE, even though that has always been a lie.

> If not correct, then I'm even more confused, because ignoring clear_cpuid=
,
> guest_cpu_cap_has() will only ever return true if boot_cpu_has() also ret=
urns
> true, in which case KVM *will* reject the value because EFER_LMSLE will n=
ot be
> listed as a supported EFER bit.
>
>                 if (!boot_cpu_has(X86_FEATURE_EFER_LMSLE_MBZ))
>                         kvm_caps.supported_efer_bits |=3D EFER_LMSLE;
>
> > I want KVM to abide by the guest CPUID bit and disallow setting
> > EFER.LMSLE even on hardware that allows it.
>
> Right, and that requires declaring EFER_LMSLE_MBZ with EMULATED_F().

I think you and Sashiko are both wrong. PASSTHROUGH_F() is correct for this=
 bit.

I think I need to report EferLmsleUnsupported=3D1 in
KVM_GET_EMULATED_CPUID, so that userspace knows it can opt-in if it
wants to.
