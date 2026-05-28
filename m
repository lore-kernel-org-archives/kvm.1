Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096EA255F28
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936761; cv=pass; b=gbmRSBVT+AGN3OQrzBtZUQh80OaDx6FlMXhIpBMblyoJ0wGGaqX4H/JQ07lFC/jcZXE7ffhqAKYJD4WJ4CxaMFl2bIPpNJvkieS95TBkdltSq6KTlhj3nh2EKyR91p6brfClGWfi0wZqJ7beYJjsxK8rNXVqmLYcG1Y9gjMRO08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936761; c=relaxed/simple;
	bh=0GvYWpBoqSNsknY636gqa3AxddpsKUy+pkJB+L7zUhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kqliadO7PbPBg1WqmAilf2a6yBIRvmN6OXj2yB81kpy/iPfEP6dRJ4Etq41B+KV0VUTaSf2h+24+6o8VGja3hJron5+X//I/94qLRzT5oe6NHc88bwJCEnV2VLyAzsCv1rJiOGdnSgZek5hCunsJByY+EQWwrVW4/c2z/w3XM/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA1V3vwU; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA1V3vwU"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso206403776d6.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779936759; cv=none;
        d=google.com; s=arc-20240605;
        b=Y++v/iEKUzzDTACHfCgIERm+wuSHZYKai5TEA2VDe189GaRBRbqdTeeO2pP69wD3DS
         /9AkzfweTKwQUnv2I5PlO+rbqDks2bp2Q+iDLuqzKXyH4PzfwouwFBVkv0v0ihOCcmQr
         VbliCo4rWrIbgh5ptcePbPI8AD/VUsgFWrKjODjOYBVFeUnTjkj21pmumEVeYiwnCLEv
         pBJch37+Y0+QoVITUJZ9rYHJTtgV3SU7GgZUC2QOb6oJXAN9XGy5+Z0BHP+11SaKz6ca
         4Zn4iA5w8pAjeCVREbNfszu+HB55daZJBoiJKLzhcjm7ICzvS6QdoObyMG8BELIM1Iw8
         rQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ncpu7nNEBHVUNpkul5+iZzv+fFzEM2OIPBUT50fzscw=;
        fh=9UD5HRoY708ufPRAGP16Jq0+8dKcC8crpaDRtsvoSwY=;
        b=KWSCyqXI/w62BCuYOTRmU7hWJRm0AlY3aHKYT2JpoU1SZ6iyCj1itoPqvlsyz2gN/B
         oXPcUUz+iB7bTVGs8nQIZy9Vv89BmbOfxSxGNw5FY58piqqMgDdX0x8smqOCfKFQprbt
         4XqvjRLQXKhEYEHdE9dRGNjgjxaphn3XbdL/iI/1PY+F7z8LCB9mklkZvpvDXNe8+As3
         UInFc5M1hY0qDYdoPF+sHYUOiylXcfLm0ypcjlvwZ+IPLv+l1Yh7+z73dgAC2uPtAPbz
         K2/+CbCt8v8G18KNsRAjwMj+aoMcy65w9/I5U1VPPfYaoXH4SHNhm/+6EXsSodDihV9B
         ecaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779936759; x=1780541559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ncpu7nNEBHVUNpkul5+iZzv+fFzEM2OIPBUT50fzscw=;
        b=YA1V3vwUPHb9ZxJVmRwrdhuKSz/SoeAYNbBYXDzLJkl9469LcTlZhvu5xdsM6P1RsG
         nuxSdosiGS4K6hTyEQaeQRbM7Ukg3xsJ9a4b4s3STLfGpbeNNq0vS87/8yT1gcKSWcw/
         Dt1fE6+itWDTCFajYOmU6vy4qn4N+4k4GdM5RAA4pzuFLElgw2QpSgqYEMCN+n/b7yIF
         AkUzgbop7M8fpvzLICM3HVY1f3aV2fqVhcKatCezRfFs1b4O0amgy8o4613L48BMts+6
         ittOyBES4BU04JVn9D9A7t7sdC2lGo7vzvv1OmlhHKAx3rNaQeJ8NHbE3l8ulUCYIme1
         dwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779936759; x=1780541559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ncpu7nNEBHVUNpkul5+iZzv+fFzEM2OIPBUT50fzscw=;
        b=GBgZ1Bob2E5WGCufl8ASf2mvFuvfTsokr5CRHBQmEs3clc9Fqot9fcwLP02rZU1uwS
         1bjpno0mpeD0wRlmFViYVDt9rp8VvGKAnKQBoPMMv7vwKlAPbp4inuQgRMbZdy/L4FRp
         fsaDdLwykeV+7ZG7gHwcHT7Z67LguL99D2WLysxlvJ0R327QbuHZP6T/gcfU9gYCbYdz
         4FFc+OamYyc0AgbZaveZyc990sJElJjT1bS/xlm05Ivytg4F6HCeIZRstfl0yXVZsQrx
         Z60frPXVRot9PY7cPO8bZX7kXr9zAuveKqbLTp4IuwHvr5AE4E1LuJmIq/E4TIxMAvvg
         ZF4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Xvlp8NxFdkWvij97wysIMchpAyXTM1jn2aP32CTTRj84zbCS4Gum6WtEh+zXfRyG9mHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoBnz9RqdGdYdQF+/2mt0SzEhGB9aIWRPkeueySG2/Xu7e49V
	vvcn6+iA6t3sfUycrNfNlvOoM0zNji6kyHil+P8SIe2GRyFYO7W/+BSBiQ+ExBzPRHAXGB57Crj
	ZqF+jVIiFrcuztJx5O7yOI9HfEEr6ew8=
X-Gm-Gg: Acq92OFJIZBLu4vO/qGjWk0HTzmArHd2afpAf8YxEayZKNtxfSImth9TWM/jbKSXC0l
	uF5z3KlfzN+UG8XiYj1xA52nh6SfBscYwEwFcHrlJu8OGSOV8rHDiy1egTaKSh+Lg9eR09M2o2r
	/h3tcpf3HLlMlGy7PCZ0j7ifWc/DV6L8qoTAeAlLImWV8MVF2FolJ+9khs/DYr6shSMk3GCQKZ/
	5sYvTNhnsgn/A6gVOanX+oJSwz83xpdXY+t5icIfYjcsMbM5RKzSGTaCzFq2Vn8z4YyoKneUelB
	tfj3j1oF2jyrHMQFL/+bbY90vKOzwuwYoqCTKNK172c1lXS2
X-Received: by 2002:a05:6214:1d06:b0:8c2:bbef:cccc with SMTP id
 6a1803df08f44-8cc7b674298mr421076606d6.31.1779936758957; Wed, 27 May 2026
 19:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513124846.1622462-1-ewandevelop@gmail.com>
 <20260513124846.1622462-2-ewandevelop@gmail.com> <aheLxW0meHNVhDvc@google.com>
In-Reply-To: <aheLxW0meHNVhDvc@google.com>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Thu, 28 May 2026 10:52:27 +0800
X-Gm-Features: AVHnY4LkKwp0mjUV-UBN4y5426JVxLevB8XjbJrROw4R1KX4yvHwavttsJN2MHw
Message-ID: <CAG2uPc6YKSHWgkxFNb2-AkD731rvU+w4umrKpXDApzHfjE+kFA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cobechen@zhaoxin.com, 
	tonywwang@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quick question before sending v2:

With the definitions moving to cpufeatures.h, there are two reasonable
ways to organize the series. Which would you prefer?

Option A (6 patches, split by subsystem):

[PATCH v2 1/6] x86/cpufeatures: Add Zhaoxin SM2 feature
[PATCH v2 2/6] x86/cpufeatures: Add Zhaoxin CCS (SM3 + SM4) feature
[PATCH v2 3/6] x86/cpufeatures: Add Zhaoxin RNG2 feature
[PATCH v2 4/6] x86/cpufeatures: Add Zhaoxin PHE2 feature
[PATCH v2 5/6] x86/cpufeatures: Add Zhaoxin RSA feature
[PATCH v2 6/6] KVM: x86: Advertise new Zhaoxin CPUID 0xC0000001 EDX bits

Option B (5 patches, each group end-to-end):

[PATCH v2 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
[PATCH v2 2/5] KVM: x86: Expose Zhaoxin CCS (SM3 + SM4) CPUID feature
[PATCH v2 3/5] KVM: x86: Expose Zhaoxin RNG2 CPUID feature
[PATCH v2 4/5] KVM: x86: Expose Zhaoxin PHE2 CPUID feature
[PATCH v2 5/5] KVM: x86: Expose Zhaoxin RSA CPUID feature
(each patch adds both the cpufeatures.h entry and the KVM F() use)

Either way the total diff is the same; just want to do it in the form
that's easiest to review. Any preference?

Thanks,
Ewan

On Thu, May 28, 2026 at 8:26=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, May 13, 2026, Ewan Hai wrote:
> > Advertise the Zhaoxin SM2 instruction support to guests via CPUID
> > 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).
> >
> > The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
> > elliptic-curve public-key cryptography algorithm specified in
> > GM/T 0003-2012; the hardware-level behavior is documented in the
> > Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
> > instruction multiplexes its sub-functions on the RDX[5:0] control
> > word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
> > signature verification (1.4), the three key-exchange sub-operations
> > of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
> > uses for the initiator's ephemeral key; 1.5.2 responder shared-key
> > derivation; 1.5.3 initiator shared-key derivation), and two
> > preprocess steps for identity and message hashing (1.6.1 and 1.6.2).
> >
> > The instruction is user-mode and available in all CPU modes, with no
> > associated MSR control. The SM2 and SM2_EN bits are redundant by
> > hardware design (set or cleared together) and both serve purely as
> > CPUID-level feature-presence reporting flags requiring no KVM
> > emulation. Both bits are advertised because different software may
> > probe either one when checking for SM2 availability.
> >
> > Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> > ---
> >  arch/x86/kvm/cpuid.c         | 2 ++
> >  arch/x86/kvm/reverse_cpuid.h | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> > index e69156b54cff..1eb4b88aaa80 100644
> > --- a/arch/x86/kvm/cpuid.c
> > +++ b/arch/x86/kvm/cpuid.c
> > @@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
> >               kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
> >
> >       kvm_cpu_cap_init(CPUID_C000_0001_EDX,
> > +             F(SM2),
> > +             F(SM2_EN),
> >               F(XSTORE),
> >               F(XSTORE_EN),
> >               F(XCRYPT),
> > diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.=
h
> > index 657f5f743ed9..7b55110cc046 100644
> > --- a/arch/x86/kvm/reverse_cpuid.h
> > +++ b/arch/x86/kvm/reverse_cpuid.h
> > @@ -76,6 +76,10 @@
> >  #define KVM_X86_FEATURE_TSA_SQ_NO    KVM_X86_FEATURE(CPUID_8000_0021_E=
CX, 1)
> >  #define KVM_X86_FEATURE_TSA_L1_NO    KVM_X86_FEATURE(CPUID_8000_0021_E=
CX, 2)
> >
> > +/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
> > +#define X86_FEATURE_SM2                      KVM_X86_FEATURE(CPUID_C00=
0_0001_EDX, 0)
> > +#define X86_FEATURE_SM2_EN           KVM_X86_FEATURE(CPUID_C000_0001_E=
DX, 1)
>
> Oh, just define the X86_FEATURE_xx flags in arch/x86/include/asm/cpufeatu=
res.h,
> all of word 5 is carved out for the leaf.
>
> Features are defined arch/x86/kvm/reverse_cpuid.h (versus cpufeatures.h) =
only
> when the feature is "scattered" (not guaranteed to be at its architectura=
l bit
> position) in cpufeatures.h, or is not defined at all (because the kernel =
doesn't
> use or care about the feature.
>
> The changelogs all look great!
>
