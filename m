Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794012170;
	b=I52lqKtUvTfyPY1mifj0JePYJdtI5/kgba37rkBr1u7siGX/yCV9i4yV0p7mO2MTGpso
	 s4in6IS9m1z+lCj/zzMw9iobCe/YhZ66v2aHqYdHcLO3kG8ekgoLhQ5AdVtyaG6bbJdKA
	 AQjBDUS84bBFi913+erzYzeKNnhHXngzIQYVp9wtMTSnQ9+FIEu5C1sRFIz4pwdoyez3u
	 cHbE+xJk84raqmfSZg/NpcYTyodHxeEaHk+b9oAZWQ0GVab3cb7Ns+jrcrPGYf/wd76mp
	 jTQnPDD/sZIZFxhBhdzJRzSdI5pLgCOh7JvGGHpspxJ0rLBHurY1an9brZm7xjX9nmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rxfr2Q/cVJbpK3vZD6NPrJBBDTXMr9aYYK9hIqRSdxA=;
	b=ZUFN3DzQB5S1eZned1RBtR7owI/EsWtV2dJI3cCKfkzzy48/3O6a7K9aTBV2EeuAYwAp
	 z+sy4l4P3Z04eyb9fZPgCjRegouH14Cr48tqc/QMINFsYwfBJIjqOFOwJQtFZjiXX6Tko
	 NxzYlCAFRxyF4n5N8Smm5Ccn/ZZaLKGKFOixeITasMIytvBoS1sOWeJ+YxtlCcUxSV5FG
	 BCvaK3wrem6P4N0NJtT8s1onr60Spih6c/bNMf2aZgsJTP2ar6hEHfc0CEIK/sAuEpIkg
	 Q3XWCMtHryFKpgZe/zm7IaWe9byY9AB7nmzSA+9crVAjMq22rMk0re+GfcyDizzYDkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mKRLzxSU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D265606AF95
	for <kvm@vger.kernel.org>; Sat,  7 Nov 2026 00:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D265606AF95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mKRLzxSU
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b6966d9508so1198a12.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 16:42:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794012169; cv=none;
        d=google.com; s=arc-20260327;
        b=jefZKuuZ0bV5b2yyUjdUAo2yeIrFPadpF1bH/ufBhZbzfBPdVAksGARm1eD5Hu8wAx
         Ij/BoXj2kt5QEbZdh6abm6mTsOEhODx1w6FkkKM60XLL0XkFdX/hYZ6SPqmf/C24ipYs
         P9EHSTb4jk1rCCmBR2YFdWtjE9yUvrRVq8xD4YD4BuCPAagbmaLIRRlbCptP1MBDnSrl
         b13yr6Ofw+CIwMAoFVJWeDKwmb+/r+Jl1LkyfwoIHTL5Eri5iK3iuDtTO9oDRBa9CroK
         niyZfUX2OtkpesjgRQaKBc9RI10yuEsCutaJ9l9KkW4q3mKrotokQzBtqIOZKl16EhDu
         O6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rxfr2Q/cVJbpK3vZD6NPrJBBDTXMr9aYYK9hIqRSdxA=;
        fh=IyfsJBLQr6hJOqvm+FbXnfcf3pZxQFVyKwIMzeoTo8s=;
        b=kEBtqVBEZSfkK/Bn0j0WB34N8cwaayRpcd0xloSBpdD0EPBd9SA+CDhveuHoAw6iNX
         7JKCrXFRNTo3siiEo7V94pKfmFI2GA1ryty/1hhPVwx4OrEOTCz5N4Y3+BdqZrIkHk4D
         wtW654N4icHVe3/teK/PIAFVJzUNGjlVidFKngQG4VHjRWMr+Iq6RKVX2e6V/n7XydwF
         CPq3PqVA20bqXFiSzjAonJ5ab+vV9zFV1EjwbifbEvU0P+KvvmN3L3V4Wu5RHow9BSHq
         ptpYKd8cFHxMJEdUlbmYteHvKWkJXJ/KUaI8fO1vP006tdWcWrbmUjHlkUnZr2tHLScv
         o3Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794012169; x=1794616969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rxfr2Q/cVJbpK3vZD6NPrJBBDTXMr9aYYK9hIqRSdxA=;
        b=mKRLzxSUVgY24YecrcJ2AcvYnbBZ+zfgqgNTwySkaHLr3sYJ4KGCdAMTeX+1IgEmlj
         ORc/4Z8PHsyV1r+MO/g4w5jlgrKwVqmoESKULmRAG1LSNlbdGMjwSO3ZaBkJLvhUPl+t
         fPeZnxOIqdlwon8FgstmjvzCXVWxS+43KT3umXTqRmLFMdiQPRQfc6s/MkDZjRq98Nlb
         APdRo19ffSELwNg+MvLfyBciRveCqjdvLn/+q+U1sEj6dh3yhESLqoSixt3AxdgCyCqe
         dpPByT+bCI1MerNC2vSTejTp1knH82PA82sD22vaHD72+4LP9eD5QCIZ0rnxAKVvxhQB
         zvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012169; x=1794616969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rxfr2Q/cVJbpK3vZD6NPrJBBDTXMr9aYYK9hIqRSdxA=;
        b=2VOitHVj9LGH2E+Qi8jChrMESwquZgC/+IdX8gJCGbVvEc4RoN0vZHSN1RCk470XsN
         WS+gBpCqeyQDOZPKzUc/86x0IGqYEjZ5OnHhqFERzY/vEf7vdhyh7ko0ezf1Wj5bJB+6
         CDW2WowRLmAOdoCkRNHDPAsUIAukIlpIO/sCz8SvsBGBXae+3Rj1zYcGcaPTXY75oAfv
         0emvYc1T4pGkd+e85XOUUqlg7vZ2RTEEXb5GN6tV2cbuk6/rfrvBMn6A9Efsa/UfmQ3V
         eOpMQ7MvrajmdDiiHzKxeLFkvVcNnHiv31ZYmHj/pY32t3pLS6YnjWVQbX5rgI5U9Rky
         JHBg==
X-Forwarded-Encrypted: i=1; AL+hErFHrk/Iqe4SCFoBQMMYe5oQt6pERCi9GEMHI3QeYk4BnUVRugsCAFe9PCm3X4+HZW5GL4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ldqAZnS498noE8SFFCOT3R8ytaKJ7N+kqU4PtnMkVU/ihDKh+
	89nChnSJRwU2xmm4wo5nBrnGJDX0bLneJAI3U7rkFxjj6kF1NwXiDjZuPGVrkELqdMzQ1cmOWTA
	fYrqb1F4gltB3E0BqdlK8p+3g492MqqS+TDa5x7DM
X-Gm-Gg: AYBFou1WMKQ4Oy88TyroK8RJ7eca7enCbcrMaODz83LPySTH0LTUu/oe1yFpzH/YJS+
	TVDoXTSimEszPuOcW2ahchBiUkxrNCRllFetL2n7q7AiO/OvqaTOzJtqeY4lFRLT9pcDbV2bPw3
	c/6lnF5tOJL9fMcDgXT6W8Iy5eR3TQkwmI3djOtk3dreUcEyhng3864/XFxpYcZhW4GgxjjsBJN
	Vf22nyXsUNgAraAWCoa3evNzVJCZqkHzWbuWlg1RRml0STx1tMucD8yWNPRMDYWoTXzgZmtmdoy
	UeHNmE3HN1Y3J11W7bEnoMSQ61ZANQH/yYoN+127MPJD1TkZ0y4hn80UJvwo3qkKmzgU/yP3463
	RDG6Mu6WQ0Uf/68V6wZYRvmwEl5l9nNFMo5M783re0wG4SQaPa6s2xoVBlIZfqtaytTj16cEiOM
	j7/U0MD28wXvBtGC4iRZ4tXHbi
X-Received: by 2002:a05:6402:c549:20b0:6b1:b3bd:1576 with SMTP id
 4fb4d7f45d1cf-6b6fef69aebmr13396a12.8.1794012168067; Fri, 06 Nov 2026
 16:42:48 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-6-zide.chen@intel.com>
 <au4pSeg5AcHEbfDv@google.com>
In-Reply-To: <au4pSeg5AcHEbfDv@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 6 Nov 2026 16:42:36 -0800
X-Gm-Features: AclHuK9NRM_gDWCKM7JVrOv3NMzvD81_ZshQ0dqGboabAvUVaSpIbTnBv2z0vjM
Message-ID: <CALMp9eQZQ7-cGgmssAn5xd5hd7Yqi7fzFJVrTawJpdxZBS4Btg@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:34=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > @@ -979,8 +979,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
> >       kvm_pmu_reset(vcpu);
> >
> >       pmu->version =3D 0;
> > -     pmu->nr_arch_gp_counters =3D 0;
> > -     pmu->nr_arch_fixed_counters =3D 0;
> >       pmu->counter_bitmask[KVM_PMC_GP] =3D 0;
> >       pmu->counter_bitmask[KVM_PMC_FIXED] =3D 0;
> >       /*
> > @@ -1008,16 +1006,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
> >        * in the global controls).  Emulate that behavior when refreshin=
g the
> >        * PMU so that userspace doesn't need to manually set PERF_GLOBAL=
_CTRL.
> >        */
> > -     if (pmu->nr_arch_gp_counters &&
> > +     if (kvm_gp_pmc_mask(pmu) &&
> >           (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_p=
mu(vcpu)))
> > -             pmu->global_ctrl =3D GENMASK_ULL(pmu->nr_arch_gp_counters=
 - 1, 0);
> > +             pmu->global_ctrl =3D kvm_gp_pmc_mask(pmu);
> >
> >       if (kvm_vcpu_has_mediated_pmu(vcpu))
> >               kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
> > -
> > -     bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
> > -     bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
> > -                pmu->nr_arch_fixed_counters);
>
> I understand the vendor modules are responsible of initializing this
> now, but should we clear it before calling into the vendors like other
> fields above?

pmc_exists is zeroed further up in kvm_pmu_refresh. See patch 02/18.

[..]

> > @@ -117,7 +116,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu,=
 u32 msr)
> >               return pmu->version > 1;
> >       default:
> >               if (msr > MSR_F15H_PERF_CTR5 &&
> > -                 msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counte=
rs)
> > +                 msr < MSR_F15H_PERF_CTL0 + 2 * hweight_long(kvm_gp_pm=
c_mask(pmu)))
>
> This assumes the MSRs are contiguous, which IIUC is always true, but I
> wonder if it should also be handled since the series claims to also
> prepare for discontiguous GP counters.

Actually, since KVM_MAX_NR_AMD_GP_COUNTERS is 6 and MSR_F15H_PERF_CTR5
is MSR_F15H_PERF_CTL0 + 11, this condition is always false today,
rendering the default case dead code. What situation is this intended
to address?
