Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CB41D625
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424278; cv=pass; b=roaoLMSWm+TfaSm7YoeYjdFrGgJolFgMLZz/o/l2cm2ofPw8Cjwrb7sYVtAjneHXfADyM/x46sJz0fiZVynk/C9kjsxaJt2rveTqzI1T8BZzS5+24TDe9hD+SU6s8m7bCl9EAjfzyGZ1RyforSLmCDFx2n0Kx5QTzEeBeqfLlTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424278; c=relaxed/simple;
	bh=TYwPQNi616Ht6EnhXotucKjWKhKV3WV0va9YgVj9JpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSsuphEPJpXzYw3jM9/n2m/OREqJ2PQC0vv3YsGR5Axoa+2+YB+G74BKQsxGLw2RBbsRr/3HXMmnQ3iWodsyTRtQdrc0AhOC1SMnMIWRPIbTc3VpE1XxerorDAhYZlLb48eYpqiK4zvMDlbw+2akgrwZfvkgzah5MLNoAuaeRYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVg0emLi; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVg0emLi"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso11075a12.1
        for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 08:11:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785424274; cv=none;
        d=google.com; s=arc-20260327;
        b=YIiT9aqIC9K77VPyXBh9VkAKRdskVoT4ySK9Vu+r3Rto0Ty/8X9m8JtO3PTgPMV8Qx
         nyzQA4Xm3wC4FI7bkhEcnSKryTwf5CeuzRe2rl4eBWRnm4wTvk73436B0WIzZbeGdzbd
         BOFS1RdRtZqZ+GOv/+NQ9yJ4qsCu1RN8M6zWvCRfpv918hRrQU9qpcaFZbpw9a6KrRIo
         dyxF/xymNGOczNN1OaMpyPjCb67lf3wAmpu7Fw1vjXDZ4VhiPZzPVxdMkPcOnt5iJAbd
         63ZX6tw5aa+rCnXfj+nXBLmGbP7EPDNFENNwSWiVVjy+fzQ9mickLGaajm8jTT4NtWOj
         aRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SboWQ72T51GHkLy8sQvnDNewZTpfZMXhh69mNGfsiCA=;
        fh=yFuzF1KS2tAyY0tV8q2Ag/aud7bFHCMH6weVDl6zJ2Q=;
        b=UU54W4YWZr05Epg4AKcDr3Dg1NxTU0X/S1refL8xQrDtHuV0eN4yk/ui6vXbavA+Es
         BaUk2bsvOsUOgY6vvnWP3Rq5VLHfyxr3lJc2eAuUfuQgoTIFjzZNZ0XzW8t/8AyG/ACW
         rUjrOQi2fkMR0A/JlAN87EnqT6P15ACwYshYSNsCZ8ykyCdfEgB6Jd10Htb+hvjsd3qt
         xIHFfv/DVZRCrWB0261zIBa/75io5r+Hr74PhLznUXNSEI3PMgNbNVfZsKOQX+KnSt/S
         S5xeMF5lXJ6oC/rZyQ9FeH4ak69XcjLhw4KlShNYgh+vygr5gAsGVnk7cnsiE3Wvpm3r
         GP3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785424274; x=1786029074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SboWQ72T51GHkLy8sQvnDNewZTpfZMXhh69mNGfsiCA=;
        b=HVg0emLipxjFr/A8Mzpeq2IgUbtgwbDO4g0SAYQf4UGr4CLABJoywSB7h+O692DFgw
         vR02YkSR7bsBac4s0gb1fVpf9vjRmbGOKztJKy27vfroBNAswa9V9tCUlcsjrJ7a6Kon
         WMfzgYZmwAseh6vmzXzWrggUFPlgoamRaDkqyWHFXXdJs85yAMkICahriCR+wZmoSdKS
         TqRERJgnn/ghdhHSW7+zpdIHEDfiFm5SUbSEOLOoYZQJWTP/d39MAD+AbqKIKomYHWVe
         Q4VFjlGXNN1g6K9X/sSAkTBIfZf1LvzvBppDMp6rPLzoarhWE0n6YiA3PnRmNnd4NnvI
         OBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785424274; x=1786029074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SboWQ72T51GHkLy8sQvnDNewZTpfZMXhh69mNGfsiCA=;
        b=aKV00R5PbG9pqQVZvH+oSzCXcMs7h7Clf8FPyzbdwq2EGdJc0cgn0+hHFMspmcwuip
         gWZUS6SMFNFoMKplQ8vrUY/mTsSW88RPfR6hQg8gK0H2o3q31dRx4/POL04jg1i4rV7T
         UNlZj6vWj2IKxVL8sxd1M+Eklvv4i+PkB207iBNlJEQkZdazV7mJw6CXm4KBtt7vt6Wk
         IP0QPnCSeXDJLTNd0wQL3DgtTMYMehVgVovM46+reOR/lvcxK+uavB3/Sz+XeuyOrJaG
         0pa2wOMz0niXLve3J/eQkBCjm/noBpoYLX33JLs0W/65HlaKgGCsrNe6VBXNalnVfO4y
         scDw==
X-Forwarded-Encrypted: i=1; AHgh+RoZDhfFFdbC/769VJGkMDOon2qqjHALDnIOmRxdQXeuYUxZOglBsQACU5/o1uVYi4ZT7j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxbtklKX+4294jNq6qcOJMJ9yGJ/QCgQ07BLt/7/MsW0rbY6v
	+fcF+TuiT45gxe42sW9X9jD1JGDdk/tK8KiZkbM98ie/7Pgz0ZW4jt/kSuFHARaAgkHYJUaHL1+
	DcRodP1BqTh3NNXAJoSCmyZ5/Q54EMu20lVHJStZWEc81xiFjJIzM75X5
X-Gm-Gg: AR+sD13pp84fBFsF5y4Hx6Kl8FA1Tj3B0Du4QtjOOpDvXsebokgy2DOnVVMBVWjnRAC
	l9INJDpNX9AUE5wPF5q++8caPIaAI9V6GpNFXqi6c0u23PMtEoqV5g8WG60NOs9WVLLE4LAJfVx
	C9z90DOKqQY6tYOPGWeRud+ur2MpSccIQE/3+jRYU1JG92MYsdDgQhneiX5K2abJEu5Ircpho+8
	yX1TIaar69+4oYCp1DyO3j+P9YkRhLPOjI0YcmnRq8kLTOZWC0rtm73o7tdNc+FngCRO7ql8VRn
	MB663RHsaakhXj7cbRRhGCWrc1orYKrMWdmr7JqV43vg
X-Received: by 2002:a05:6402:a290:10b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-6a09163f6admr8068a12.8.1785424274146; Thu, 30 Jul 2026 08:11:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727192131.582105-1-zide.chen@intel.com> <20260727192131.582105-8-zide.chen@intel.com>
 <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
In-Reply-To: <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 30 Jul 2026 08:11:01 -0700
X-Gm-Features: AUfX_my7hvh7eN7Tdqkj7xMf4Pos19sXiaxq6cDy6rYdwsNY3PP1ALNWMCuBQik
Message-ID: <CALMp9eTgxvqMYMr4+mGS0BwAE++Z0KW+Sb22r1QFwR-TdkUZMQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to known CPUs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 7:51=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 7/28/2026 3:21 AM, Zide Chen wrote:
> > RDPMC type encodings are vendor-defined and could theoretically be
> > extended on future CPUs. An unknown RDPMC type could leak host
> > PMU information to the guest through RDPMC passthrough.
> >
> > Rather than assuming future CPUs are safe, explicitly permit only
> > reviewed CPU models and require RDPMC interception everywhere else.
> > This ensures RDPMC passthrough is enabled only on CPUs whose RDPMC
> > encodings are audited and supported by KVM.
> >
> > Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Suggested-by: Jim Mattson <jmattson@google.com>
> > Signed-off-by: Zide Chen <zide.chen@intel.com>
> > ---
> > v7: new patch.
> > ---
> >  arch/x86/kvm/pmu.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index 51c6d00a485f..092809bd757d 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] =
=3D {
> >       {}
> >  };
> >
> > +/*
> > + * CPUs whose RDPMC encodings have been audited for KVM RDPMC
> > + * passthrough support.
> > + */
> > +static const struct x86_cpu_id kvm_rdpmc_known_cpus[] =3D {
> > +     X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
> > +     X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
> > +     X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> > +     X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
> > +     X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> > +     X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
> > +     X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
> > +     {}
> > +};
> > +
> >  /* NOTE:
> >   * - Each perf counter is defined as "struct kvm_pmc";
> >   * - There are two types of perf counters: general purpose (gp) and fi=
xed.
> > @@ -807,6 +822,20 @@ bool kvm_need_perf_global_ctrl_intercept(struct kv=
m_vcpu *vcpu)
> >  }
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
> >
> > +static bool kvm_rdpmc_encoding_supported(void)
> > +{
> > +     /* KVM understands all RDPMC encodings prior to PMU v6. */
> > +     if (kvm_host_pmu.version < 6)
>
> I'm not sure if this works for AMD platforms. Jim said current AMD
> platforms already have security holes and I believe the PMU version of AM=
D
> platforms are less than 6.

Let's not be pejorative! I said that AMD's RDPMC allows access to
counters that KVM does not (yet) virtualize, such as the data fabric
and L3 counters. The APM, volume 3, indicates that up to 28 counters
are supported today. KVM only virtualizes 6.

> Need AMD guys to confirm. @Sandipan, @Manali.
