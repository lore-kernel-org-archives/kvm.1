Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF203A3E94
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741938; cv=pass; b=NHy2daee0Eb3j6SC069jcujryrETIrjJFLFO1qMuFZsfUOF7kTwZerRj0keXztxPVt7k4HHcTRU5bv5Hh6bLVvTGhJOk+FsQAxkVrBeGp3hmWua4OYutRoBY9qTX4vFZzpVyCYanbEK8LP6KCJ6lw78OEdeVgX2F8vghAehirUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741938; c=relaxed/simple;
	bh=J4i3wtHxahDiOu5s3zupX1as1n1/0uNulN0Lv4BybjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mk9LegxVSRHrn902sVl06izVr4BpmGOlmNKpTcgN6tAUstM4VAp5LwU85DpbvsVPV1teovJ+Yp5wva526Jci/Unzw+U2jFjHngaPY8Hetg3jwgck9s/PrM2RjVEtRaZVdYHU/O14NDr6C+yxqnTXaFX1wYjAfbfVoEQsUH8TG+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjWEjAE4; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjWEjAE4"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8eea23d01f7so1046074485a.0
        for <kvm@vger.kernel.org>; Wed, 13 May 2026 23:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778741934; cv=none;
        d=google.com; s=arc-20240605;
        b=hp/JnAZa5DokxzP2EnFf7eK6EmPiHhLTZFYF9xzDfE2NsQBLcd5XK/RfwRKboTckLv
         LxDt8scbE1pk3A/eYseI1SWxiu985l49g/pP5tz4+2ScWqFEn/403ihdEEARkgXgsH/7
         XfVNJVCn9HFXD8LdhZn4/hKx9VoP24QQiSJOnn/EQTommInJzIC5UjyWpUR6e5Ju9+SY
         OJYcBto0FaEsCcplppBZQpmvmOJqg5Op8h3kGmOwu1qL8HZmxl3GS5pKTeis2NP7W7m2
         U1Gjh4uZ7xDI6I9lwb2hQOfAtcEDL3kywqvf17BLpcR6r186wacGRBlBUqHS0SR2gUHv
         yhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JHYzSsNBByGQCwBGnngE3iu6DftvoIfFbEItKZNL1TU=;
        fh=2lWV0jG6OrJAeYhBAaxYcJHy6bigkwM4knvibPxllCE=;
        b=FC67MatlzzQANRRZtLujy5TJd1aFC66PVIxjg7hu7Q3nKpAwJ3v+VLUbCHrC5IiuHd
         ZlcdH8gmykFQKXmbLdVg0/MAwchaimZoPrRC3PT6qP0bgcfuS5cWbls/T1WTTXUOFMjS
         RX73DtF6OeCgxBb8YNxhF0RGVwQxB3+vF52hlhDJyRXrgHkeyC3jdN0Jloph59tlS1Bt
         EOjkKL358S7X2yu9iiXLsU2ZA57CNxTqEERSrdhjXm+nU4lYBJuJuNmWLTb2Yv3HdT3f
         87zEYzfSOjYP0WI4s43lcj0aNwvhhjQpEttxShSD/kguWPSPHMfyAy7IEx67GWFWVibH
         N7Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778741934; x=1779346734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHYzSsNBByGQCwBGnngE3iu6DftvoIfFbEItKZNL1TU=;
        b=pjWEjAE4vEzZXS3S0+RQ2bH+KD8D4iaFSvi8kUF/TBTjcOQvStaVVj+R8MjxjMbRue
         6tEmGVFsv83akoCDK/0QOI6n45CwEXgN7MfP5eaiN/mBWQDT8Knz1Z0j9VSvhEK2JPfk
         azV2LaehddFjfOY3bWojzOGe8IXZno6PqsHb14LcWCqfZ/B/vkPqEh1qOQMxL59P6t6+
         BikhqA+ddg0Oy3dn9uiCKlmhxEKxJooQ7FF6mvzHWrRexB6BtrpsHNUCYN9rD4BwRzrG
         1RSp4xMgqbpzhvqv3gG7Vdwbe0ipb0qJWm3l00g7a2HKdkLBUC+4+Dh8A7aVJHaPCBTa
         sOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741934; x=1779346734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JHYzSsNBByGQCwBGnngE3iu6DftvoIfFbEItKZNL1TU=;
        b=df0Wgz203sblkfvBMVy0G95ThYgYFS0UpZReT7BKowXzkqmbaHI3M+cmArljPJj6U1
         y1Nv0act7z3Bcj/yN1TXECYs2LEWUZUqnuBajbr4SsgrmfZaAkbLJVTAfk/T8gaVO1V9
         YxZnF1seINr11BHyIY/KGsu3GPmTbtVNuBFOaaAmTEbnWt1A0CTIam8OfYF9jD/P+e51
         0IaBnd5VQfrca7M7UAXa+ASfUA8EHjNOQAL6o/i7g5dCIx0Pjwa+xHUx1cUScQ8ndlMG
         CHB8UPJU8slDT6E2P2U2UqMptWQPbinuT89i23rH4JB0vLJkM9VaK6lsZkH00NJlxL6k
         1riA==
X-Forwarded-Encrypted: i=1; AFNElJ+lj31+uGH1l7Y0pgFIsxmlJVFO/DW7ZbhwE9Tc6f+MoNJVx2FuPAPaf1guI2LTlK0zMnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbW3KZIt1NoZ+F1xqupLGH25y26hPSXnn7B8f8ofF8FeJqDl+I
	gKN5RDikIZMnnivoH9LbtJBrG9Xmdh2dPjdSlB6r++53qqG03kxsDMhyYfXPizLmJwTldfk4Tdh
	LpMlxQHx78tdgihQRFLY3xH7xLQp7dafJJ76OsrrQ+g==
X-Gm-Gg: Acq92OEKS00yd0LL4Q9eJ2bKNcgscTXerFn8SnmgfAN36JMP5DKVeW0HdZ69RDs38sW
	+SvBWEUFWnOCVmvCrEfnlGv6mJNVn+izeCrQVwlKmhFQfMZg1J+U2HUTvjiuMc2RwKZ+RX2hcal
	b/fDWx5IxbSn+0uiuRZMjYmxADq2G3ywrN+0JIddiyfsyhxMgmkFQ+jn+w3jFrAJg17SwIK2cE6
	pWW++mws4g92MfKBqHJfP7fJH06dKtadxCAW4UbEo93PsDeYW2Ia1wC6JCPoLyOWOOZlgoK3fvC
	wCW7cIwF
X-Received: by 2002:a05:620a:2a0b:b0:8cd:b52c:598f with SMTP id
 af79cd13be357-90f8b2d97femr1009512685a.59.1778741934576; Wed, 13 May 2026
 23:58:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513093633.1608334-1-ewandevelop@gmail.com>
 <20260513093633.1608334-2-ewandevelop@gmail.com> <2e73a7c5-82db-463f-9665-94280402913a@linux.intel.com>
 <CAG2uPc7T5Tkn5RSLzrfJLEZoh0EYJvdJZkmgJNFbe4NPu0UqMA@mail.gmail.com> <e8cbb899-efba-4996-9f51-7f025450c272@linux.intel.com>
In-Reply-To: <e8cbb899-efba-4996-9f51-7f025450c272@linux.intel.com>
From: Ewan Hai <ewandevelop@gmail.com>
Date: Thu, 14 May 2026 14:58:43 +0800
X-Gm-Features: AVHnY4K8u1k45RsFEdsas_zi2dHPKymR8BAWkTEaB0iOuhu6IY9LeV-dFmBwwEM
Message-ID: <CAG2uPc5eHztQM+HSSf1uPo_jKWQxk+wSogrWbTdFqFOyujznXw@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: Expose Zhaoxin SM2 CPUID feature
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, cobechen@zhaoxin.com, 
	tonywwang@zhaoxin.com, AlanSong@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:49=E2=80=AFPM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 5/14/2026 10:31 AM, Ewan Hai wrote:
> > Binbin Wu <binbin.wu@linux.intel.com> =E4=BA=8E2026=E5=B9=B45=E6=9C=881=
3=E6=97=A5=E5=91=A8=E4=B8=89 18:36=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >>
> >>
> >> On 5/13/2026 5:36 PM, Ewan Hai wrote:
> >>> Advertise the Zhaoxin SM2 instruction support to guests via CPUID
> >>> 0xC0000001 EDX bits 0 (SM2) and 1 (SM2_EN).
> >>>
> >>> The SM2 instruction (encoding F2 0F A6 C0) implements the SM2
> >>> elliptic-curve public-key cryptography algorithm specified in
> >>> GM/T 0003-2012; the hardware-level behavior is documented in the
> >>> Zhaoxin GMI Instruction Set Reference, chapter 1 ("SM2"). The
> >>> instruction multiplexes its sub-functions on the RDX[5:0] control
> >>> word: encryption (subsection 1.1), decryption (1.2), signing (1.3),
> >>> signature verification (1.4), the three key-exchange sub-operations
> >>> of section 1.5 (1.5.1 SM2 key-pair generation, which the spec also
> >>> uses for the initiator's ephemeral key; 1.5.2 responder shared-key
> >>> derivation; 1.5.3 initiator shared-key derivation), and two
> >>> preprocess steps for identity and message hashing (1.6.1 and 1.6.2).
> >>>
> >>> The instruction is user-mode and available in all CPU modes, with no
> >>> associated MSR control. The SM2 and SM2_EN bits are redundant by
> >>> hardware design (set or cleared together) and both serve purely as
> >>> CPUID-level feature-presence reporting flags requiring no KVM
> >>> emulation. Both bits are advertised because different software may
> >>> probe either one when checking for SM2 availability.
> >>>
> >>> Signed-off-by: Ewan Hai <ewandevelop@gmail.com>
> >>> ---
> >>>  arch/x86/kvm/cpuid.c         | 2 ++
> >>>  arch/x86/kvm/reverse_cpuid.h | 4 ++++
> >>>  2 files changed, 6 insertions(+)
> >>>
> >>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> >>> index e69156b54cff..1eb4b88aaa80 100644
> >>> --- a/arch/x86/kvm/cpuid.c
> >>> +++ b/arch/x86/kvm/cpuid.c
> >>> @@ -1272,6 +1272,8 @@ void kvm_initialize_cpu_caps(void)
> >>>               kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
> >>>
> >>>       kvm_cpu_cap_init(CPUID_C000_0001_EDX,
> >>> +             F(SM2),
> >>> +             F(SM2_EN),
> >>>               F(XSTORE),
> >>>               F(XSTORE_EN),
> >>>               F(XCRYPT),
> >>> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpui=
d.h
> >>> index 657f5f743ed9..7b55110cc046 100644
> >>> --- a/arch/x86/kvm/reverse_cpuid.h
> >>> +++ b/arch/x86/kvm/reverse_cpuid.h
> >>> @@ -76,6 +76,10 @@
> >>>  #define KVM_X86_FEATURE_TSA_SQ_NO    KVM_X86_FEATURE(CPUID_8000_0021=
_ECX, 1)
> >>>  #define KVM_X86_FEATURE_TSA_L1_NO    KVM_X86_FEATURE(CPUID_8000_0021=
_ECX, 2)
> >>>
> >>> +/* Zhaoxin/Centaur sub-features, CPUID level 0xC0000001 (EDX) */
> >>> +#define X86_FEATURE_SM2                      KVM_X86_FEATURE(CPUID_C=
000_0001_EDX, 0)
> >>> +#define X86_FEATURE_SM2_EN           KVM_X86_FEATURE(CPUID_C000_0001=
_EDX, 1)
> >>
> >> Are these new bits really KVM-only feature bits?
> >>
> >> KVM_X86_FEATURE() is used for the features either scattered by cpufeat=
ures.h
> >> or features that are 100% KVM-only.
> >>
> >> Kernel already has a feature word CPUID_C000_0001_EDX defined for
> >> CPUID 0xC0000001 (EDX). I think these new feature bits should be put t=
ogether
> >> with the existing ones (i.e. X86_FEATURE_XSTORE, ..., X86_FEATURE_PMM_=
EN) in
> >> cpufeatures.h.
> >>
> >> Same for the other patches.
> >>
> >
> > Thanks for the review.
> >
> > Some history that might help. We tried the cpufeatures.h approach
> > back in April 2023:
> >
> > https://lore.kernel.org/all/20230414095334.8743-1-TonyWWang-oc@zhaoxin.=
com/
> >
> > That didn't go in. The pushback then was that cpufeatures.h
> > additions should come with an in-kernel user of the feature, not
> > just to expose a bit. Nothing under drivers/crypto/ or lib/crypto/
> > calls these instructions, and we don't have a kernel user lined up.
> > They're unprivileged, and the practical pattern is host/guest user
> > space probing CPUID directly and calling them inline. OpenSSL's
> > PadLock engine does exactly this today for XCRYPT/XSHA, and the new
> > bits would be used the same way.
> >
> > That's why we ended up in reverse_cpuid.h, reading "no in-kernel
> > consumer" as the line between the two headers.
> >
> > If the rule has shifted and you'd rather see these in cpufeatures.h
> > next to the existing word-5 entries, we can respin as v2.
>
> Sorry, I missed the info that these are only used in user mode.
> Please ignore my previous comments.
>
No worries.

One quick clarification in case it trips up other reviewers: these
aren't user-mode only. They're unprivileged, so ring 0 can execute
them too. There's just no in-tree kernel code that does, and in
practice user space is where they actually get used.

> >
> >>
> >>> +
> >>>  struct cpuid_reg {
> >>>       u32 function;
> >>>       u32 index;
> >>
> >
>
