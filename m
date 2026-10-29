Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309340;
	b=rkBHJIfF5jkZQa7+eJUkcR2n6y7ZaAOjkT4H9MYwLjOlyLspEiR+z2wSt+pendse4enQ
	 aLdrQH2xYBil386fYlKzkJpi+ojsUAr0SvX1TwrLZuxeUUWOJB+a1G4IrNbLqrlvQ7apz
	 wUR+w67yZ2IywjiThp6fG0praLgdg/AqISgPhXo/8vBQ1nLqMPXYnOSyF70OEcDk5JyIi
	 9Cxk+1xj0dBNqNrboVsGlq3VTmdNFxJWi4nbKKfzVp2W4len4ZGcIQ2HKzqoC5MHzQJ0f
	 rxO/CwvhnbhGM2z/kjb/6EgrcrhQo8/LblO6ZTDglBex9NKkRJh6q/qAXpPtG8Qy0gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309340;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3InNhzFAk/sIQGpL5334b6zvDiiNMTrwmcLDlL4xDwo=;
	b=K/phschXQDf6eUccIKKbnh/pl8bij65hLow6vwNJNptBq46hkA4beZGTIaTNFmQPw/4V
	 GnGuj7OU7Jqw3roS2vjR6mKnOwzWcUTcz/5tN8MkJzioegnM2rBYh1GANCVSu4QvZucxW
	 cjByUy8i90HLe0A+rXbeBswCtk5HyX9KnvfdKLLhv+7olFuECEIKoZ28KnXstnl2wMI0o
	 ZXM7gUXyJErgyNMBcKi7YPrDUnARIBxkwBjzijggBnFKRWuCoISxgu4wEESkxh79mwWI+
	 8dUwUVKquuAk3/aDuYZWXiylnqtY1RIYKLgob6uE/JMYxo0swxb9Pcr228JHUF91zYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFEgRXzg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A44606A31C
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFEgRXzg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E1B1F031E2
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 21:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309339;
	bh=3InNhzFAk/sIQGpL5334b6zvDiiNMTrwmcLDlL4xDwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bFEgRXzgaX8mTLHSsHSHWy+7YoM8ipINAjf3VzVv13zfAe5QfaenKEgvy+MYakIMr
	 Z3fUc+eW1wYAreEtFJvcykUbhHcrT4aOzB1kxb/fSXsyngcTH85nqi0jBPdPJEqBn8
	 ugSF4A9pvO6TOMtxJvDrpgnwXkp0sMGHOUJz9qr1dc6FrLGL87EZV6teV4qM1sHxe1
	 /G9QJHx9jhpYH5TnLlDCgPhp2Cix00CCXnL60rE7fAQykwLF+YUx5hJlXklzfWp3e4
	 brx6zidwUr40G39acDF9PM1+1mH0a+le3o5tgDNyFODK2aA1j/ObG1Q1pecNlPO/ss
	 v8AiwNyetYuTg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4322d310e7so375166b.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 14:28:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNL8EF86eyO+Be9hR6mUTkikhO0ID8ptBWRqPFxaP8AQWNzPI6ZEfvgJ7WynZmbQu5NyE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6IV/zQ7SuE3yhTKhkzzoAJ6DLE9Nx40xBCQQpgk6v8V/7ph9a
	MMXQUmSn5rTgyBUVOJcKOGkVR9dF/K4/MKk0NROO3PMLnN1Am7mVatd0aXfOieKwTxBB+kIInje
	9YRK/yfCRKaRZS3lyhw414wDymQi6dkM=
X-Received: by 2002:a17:907:3da3:b0:c44:3006:5c3 with SMTP id
 a640c23a62f3a-c4ca7aa6b0amr31428466b.28.1793309338757; Thu, 29 Oct 2026
 14:28:58 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260918193937.569414-1-zide.chen@intel.com> <20260918193937.569414-6-zide.chen@intel.com>
 <20261023182743.3248481-1-jmattson@google.com> <98ed42e6-8c10-40f1-affa-2333188572bb@intel.com>
In-Reply-To: <98ed42e6-8c10-40f1-affa-2333188572bb@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 29 Oct 2026 14:28:47 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNO6X2-LDx_3n44Uc+9ODtXoH7oLvn8i5yzAa+EUy_qxg@mail.gmail.com>
X-Gm-Features: AclHuK-V706bkr2gqHt1C5l3nEIazSAWBGqnGiMXIVVXlGPTgEuq0oCxrPg13fk
Message-ID: <CAO9r8zNO6X2-LDx_3n44Uc+9ODtXoH7oLvn8i5yzAa+EUy_qxg@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: "Chen, Zide" <zide.chen@intel.com>, Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:31=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
>
>
> On 10/23/2026 1:27 PM, Jim Mattson wrote:
> > On Fri, Sep 18, 2026 at 12:39 PM Zide Chen <zide.chen@intel.com> wrote:
> >>
> >> +static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
> >> +{
> >> +    return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
> >> +}
> >
> > The SDM, volume 3, section 22.3.9.3, says:
> >
> >> IA32_PERF_GLOBAL_CTRL. EN_PERF_METRICS[48]: If this bit is set *and*
> >> fixed-function performance-monitoring counter 3 is enabled, built-in
> >> performance metrics are enabled. [emphasis mine]
> >
> > and
> >
> >> The values in MSR_PERF_METRICS are derived from fixed-function
> >> performance-monitoring counter 3.
> >
> > Hence, a dependency on fixed counter 3 belongs in this predicate.
> > Perhaps something like:
> >
> >       static inline bool kvm_pmu_has_fixed_counter(struct kvm_pmu *pmu,
> >                                                    unsigned int idx)
> >       {
> >               return idx < pmu->nr_arch_fixed_counters;
> >       }
> >
> >       static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcp=
u)
> >       {
> >               return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METR=
ICS) &&
> >                      kvm_pmu_has_fixed_counter(vcpu_to_pmu(vcpu),
> >                                                INTEL_PMC_IDX_FIXED_SLOT=
S -
> >                                                INTEL_PMC_IDX_FIXED);
> >       }
> >
> > with intel_pmu_refresh() calling kvm_vcpu_has_perf_metrics() instead of
> > testing perf_capabilities directly. (nr_arch_fixed_counters has already
> > been computed at that point; all_valid_pmc_idx has not.)
>
> Thanks for the detailed analysis. That makes total sense.
>
> Initially I didn't gate PERF_METRICS on fixed counter 3 out of concern
> about policing userspace configurations. Additionally, as in the quoted
> SDM text above, it means PERF_METRICS can't function without fixed
> counter 3, but strictly speaking, the SDM doesn't prevent other
> operations, for example, writing the METRICS_CLEAR_EN bit.
>
> But having IA32_PERF_CAPABILITIES[15] set in the absence of FC3 is not
> going to happen natively, so I think it doesn't break any rules if KVM
> chooses to gate PERF_METRICS on FC3. And as you pointed out, it's a
> simple and effective way to protect KVM invariants and migration integrit=
y.
>
> I will add the FC3 check to kvm_vcpu_has_perf_metrics().

If userspace sets IA32_PERF_CAPABILITIES[15] but not FC3 (for some
reason), I think architecturally it should still be valid to
read/write PERF_METRICS. KVM disallowing access to PERF_METRICS while
IA32_PERF_CAPABILITIES[15] is set would not be correct
architecturally, right?
