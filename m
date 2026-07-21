Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CA38910F
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 18:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659933; cv=none; b=XlPolh7kD1YeOdVL/f/l6G/aOhVrpUmC9FRkw8Whr0PvV06wLdSWIOybfuiekwaOt3rQ1A3MuuRn6MJN95B7FbUmeYTG3Bo8pCyq+T5HsSCHdHQdgJV3shicPiAuxH3aeR/dgYyam8npxQPbUYyWFRY4evcPbh2yhcMCJ1RAXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659933; c=relaxed/simple;
	bh=L0qB3IFmnDfyTis92ihHfuGUKra0om9ZS5RHMRyKwo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dRTXge2cx1gFJoeQ5w80l3du/d1yTg+AyPEsTa09yEEfpgQsIQ+9jIIBBXuZmu8G0XopcTgxWOkVIhGo5pmq9m0OyWkVtZvTSpFDoQmz4AxLnsTwkVTSXhNLbuVeSlVHuC4SeouIL3tiujNrLg0+KFIrs95aS1co4Io0RQbJC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S8FvNfNy; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S8FvNfNy"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c856470fe9fso6851743a12.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784659931; x=1785264731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hf5aaU24ifgPTG58w53ijqOW3Lbc06evOzBclrAYeGo=;
        b=S8FvNfNycrnF4tFt0Ulj/fXeUxfmm8JorBhcOT0Tk2CC4d38fQopdNaIHxQZJ2Mw9z
         Mc7AyyY49eFHIw6xw+dTiD5fJn7PnhiioSp0O41Nga7N7JGVb8aYAPtO0TwZdPqjpK1N
         VVEyhbFjxloVbqJuqdmUBkkvBz6YpCdWfgFpS2SuPUduQtOmGP+kfmbBbExaMrFWCTuT
         T3+G6senRSExHVoyEzsvoZzO6NutGm4Lp2fEmUp2zeryOC0zoLsUitnFtsLtcfwqLpMG
         CB6I6WrZmxZUsmad3I8VP/2F5bNx5mYn0vZFPt32Be9qXQKXqpHnsMdWv2Cw50Vwr3rv
         0z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784659931; x=1785264731;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hf5aaU24ifgPTG58w53ijqOW3Lbc06evOzBclrAYeGo=;
        b=G8ib53csEonQDKO8iqWHRiGCLc0L2NzAMix/SidWhHbqHt0vBHtjRYIc9fbc7a1oKp
         aOAwZtLqJ07wZ0YTplgspO+vsflwNyzanU10QXWY/2fNT8ExiTe/6kOJPEoGJ60zBLjz
         LM0f9EcxX9ESwCViFVZ8hwGIWLULwTV2PFZwfrKV4G83LSKQ4x6D4+orzuBV1Hj/VpmA
         dqjraOum7rrq3sB3WX3Ic8PLdVvZN2mYW8FdRjUfT4Asl7M+rNrzq+Z7AZXG9Qv/7b+f
         dNGg3SooiEWsG+51muVNnDFVX8+BoKXAYz46GYxV183WPxy+ljtQ9Wxh+xLjbJg4AXV9
         u1QQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGMP1GTuqhwhCxFGKrTTwTk4aL083zjXPk8cv8Pmsj7u4Ow8ByutVgX5RVHO/8RuMss3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6AIysmm3Byx14AD9iAmKZc4rmv6oiMKgX3w5mx7tV8vPEIm4
	yfMfwLwhOj4l7QOE3jleR6D/DQQZutWkWGLi3ZDDwcxK4g5QOrBEBRn3E8k1+0lBwC6OUzizeeG
	hxgVZsQ==
X-Received: from pfbml22.prod.google.com ([2002:a05:6a00:3d96:b0:84c:2e88:693d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84a:b0:848:53c7:b927
 with SMTP id d2e1a72fcca58-84c294d0c5fmr20734642b3a.76.1784659930711; Tue, 21
 Jul 2026 11:52:10 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:52:10 -0700
In-Reply-To: <CALMp9eRqaxhmADqOOWW9h4yctg5MxfU9AdL5C8MpFNzKJm-Big@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120050720.931449-1-zhao1.liu@intel.com> <20251120050720.931449-3-zhao1.liu@intel.com>
 <aXO1_kmDSu_H1BoL@google.com> <aXXLZ9nCzTmeaSS0@intel.com> <CALMp9eRqaxhmADqOOWW9h4yctg5MxfU9AdL5C8MpFNzKJm-Big@mail.gmail.com>
Message-ID: <al-_2k1Zuw6N4cvj@google.com>
Subject: Re: [PATCH 2/4] KVM: x86: Advertise AMX CPUIDs in subleaf 0x1E.0x1 to userspace
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026, Jim Mattson wrote:
> On Sat, Jan 24, 2026 at 11:25=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> w=
rote:
> >
> > > Unless someone feels *very* strongly about the "mirror" terminology, =
I'm going to
> > > use ALIAS instead of MIRROR when applying, to match KVM's existing te=
rminology for
> > > the 8000_0001.EDX =3D> 1.EDX aliases.
> > >
> > > /*
> > >  * Intel-defined sub-features, CPUID level 0x0000001E:1 (EAX).  Note,=
 several
> > >  * of the bits are aliases to features of the same name that are enum=
erated via
> > >  * various CPUID.0x7 sub-leafs.
> > >  */
> > > #define X86_FEATURE_AMX_INT8_ALIAS    KVM_X86_FEATURE(CPUID_1E_1_EAX,=
 0)
> > > #define X86_FEATURE_AMX_BF16_ALIAS    KVM_X86_FEATURE(CPUID_1E_1_EAX,=
 1)
> > > #define X86_FEATURE_AMX_COMPLEX_ALIAS KVM_X86_FEATURE(CPUID_1E_1_EAX,=
 2)
> > > #define X86_FEATURE_AMX_FP16_ALIAS    KVM_X86_FEATURE(CPUID_1E_1_EAX,=
 3)
> >
> > LGTM, yes, ALIAS sounds better than MIRROR.
>=20
> Our friendly AI reviewer asks: given that these are aliases, shouldn't
> they be hidden from the guest if the features they alias to are hidden
> (e.g. clearcpuid=3Damx_int8).

Eh, clearcpuid taints the kernel and is quite firmly "experts only" functio=
nality.
And practically speaking, clearing things like amx_int8 can't work because =
it won't
hide the feature from host userspace doing raw CPUID.
