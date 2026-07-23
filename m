Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AB8439012
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834415; cv=pass; b=hVInwQWoOVY22HfBGFGhmOj6heuieyh4hpq9dxev26RnPzOqIic6jXizgyuoNpY/uBjXxyYRR2cPfApYgdDSD508JSpoHz51CVU89laEka1bJ7Y32xGh6K9S143nS47kR4HxGH5hn37rqUeR+E4l+ETVOwcEI2ee9tDdZOWuWak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834415; c=relaxed/simple;
	bh=q/l0O/BH2kD7zO//Oq2YF25jne+nWVzVQJa6BGP6i58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raLlM7hMVrXQjShmDS0gV1LhTTMq2d7TqFq9KcPwkJZYpVpnTHT37rTPuaVvatibyWywDjFkXW2NsQS5UHK5LAw3E+XFzDb6QOIQdAiDKKgf2VlP+hLFSG4N42D00vtPGOMHTMmULXjFUPOGSy2wdrYoA0v1d0Udc2pL8eytUPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wm5RFSss; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wm5RFSss"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so2078a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 12:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784834410; cv=none;
        d=google.com; s=arc-20260327;
        b=OMhF1me00d2zJOu+BkECBeTBKGiIwa3fjaGETYBX4m9Gpb4TKvx1umaRKneIy8XTFN
         ziMTdRJ5oNC1HehSo4Vt98fQL/nQv2bsEgI8q2f8+eavLlj8r6jf3HwO6MonGfh+oY13
         kFCofWetD9s53ZVG/5sp4IZXTKpTCBy3GE8o7U5hAi+z3DTnX2krnibvZ0V5CuC3GvMR
         2fj1m3Kw1eWLc8icrEUWteXrTC0rQiA54k6ue/pNIEg+pf1k3ZUs39ORggAjJTjZyj5/
         QwSu+AcmiLvWl8yun1sJeB7nVmDCVKIcQOSZdRBwfyP3Yeemd3OXDBj/I9xXmOZuud98
         sQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/l0O/BH2kD7zO//Oq2YF25jne+nWVzVQJa6BGP6i58=;
        fh=izgBGDajWIRyAxvuws07HBHLfVm0xtSwTvoJQxbFRHg=;
        b=enGQ1iRxUDskuMneTToKFo5lQDiquPe9VMeENyRCk9q4Y1AlaCv5MHREc/Qa1StNbA
         NGy5wRiD93sUzmS0hhUex6WNcGy9i7YzTvWD2REoFlVtG4in6qwvHQemFK01jNVNAnkP
         aVNLf9o7hVasVOtD2IH7KCib3nBv5L/4ViG/2dqzG5wb/vxhw2P0BM2E/QrblPw1BpKa
         jNglP2jT4FE8Y85542ILUBbedK9MHfAvLq7yDjD8S0Ki7pBFrjlg3WsZoPkmd3F8Awcp
         UcscvVBZBaTVs2zePP55n55HIpuaUA/Bnvekbg4A7JbO1BpjzQrG3OBgZ6zHobVxKUaY
         mpEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784834410; x=1785439210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q/l0O/BH2kD7zO//Oq2YF25jne+nWVzVQJa6BGP6i58=;
        b=wm5RFSssomVJ6W0PnBvz7ecj6Q5ghGGwrYSZQ8TKTWbFEA+eYJClLOxAjX4agbYZ4u
         rYEIRjJktN9zt4uYfvm3oyy2lGCvsGVJxluDFD6JiSPJtnllLFQL4YwIhnIcQeOqP9c/
         S/RfDZ4h7hn7Da8UPLMwy11Aet87WqCO2gryo3JpYqQazxehYIMbFqycWViMIMQZ7uYZ
         L+a8+dF9s0LxUfsINC35jl5x1SqBibBADdgXw97LQoBsPxd2h4MgER5GVQLMF1msUtq5
         tKIqJFYqGtplDMysJyDGgRLKHTZUyS9MERrvlk86GN/k1h4q+JpM1ZA6i/ehX41Lv3Ip
         4APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834410; x=1785439210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/l0O/BH2kD7zO//Oq2YF25jne+nWVzVQJa6BGP6i58=;
        b=YTyiIGRjYV5THZaCyQzdlRzN+cmzanhql8R97JkO+IW/U7aQtRDQ1dDNkCrdWXrNIg
         Lt/+oz0myYsaLdpi0c80BLmW2y+HxgHiKshlZ9fPQjQmniknvOKK3Awsp93BYPbXgrcc
         xzm2d+FvQrq8/3ekMNfSvoczlhN7OsHnzWyIIrv2B6EunfvKGZUjYTZiITuMALNgmpBW
         IEUnLpLOMR/a7ZZtt65VqKg1EM/XEIERl4I9pVVRbJ954jg5u630chw89msem0V1PD9B
         foviQwLDmcvu7H1rVxq7OnN7Zuclo2uFHF5CCoD2/WNGbaaZoK4iI3Xe6PZyhaGyN+Q0
         0LDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpzx0ixam6ctbP9vLj5+rA06i3XC/T8rJixMAmZ1F8HCj6XcPp1k6NCVLlPviLaEsUIm5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3nfITdIfNSCsULzl2akSyZeJ3U2orAW0oq3oYgKBJyI1Ge3Tc
	QEOJjfctS0/binQS0xtvMzMhFfWc6xtdsJqC3sdDOCghL30/xY7LaLFDCIUlPeZ7J+eSAjYtkgh
	fAQgcqgF2ZddcQyHb1b4NXQPpL734eYXLmOoOx2rU
X-Gm-Gg: AR+sD1277kBZ6RbrbgWcAEn0Ta/l7BlUO7ETvnd+GKBXBXTKs0rZERcE5Jp0tZiTeHe
	DPxKRbUt9Esb5z8yXUjJTHkkmKyx4IvONl5kJOyxv2bi1UCuRySXjCIiwEViIeiCS5wEH86ot2L
	iwj43hSIVFwAJ+NlXyJVW2nL2U0BPuLpahNpv4C2AefrHYe0ac5qGGuzaHgenNSXP4QZqcKDVzO
	JMMKLuPa35tWx2c3iA77b7kxIfGcXu1Q3IBYVxpJivb6o6C0UssdTpE4FMeI467lkMNM0vu
X-Received: by 2002:a05:6402:25b:b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-69f8ef1d4cdmr5438a12.7.1784834409438; Thu, 23 Jul 2026 12:20:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-3-zide.chen@intel.com>
 <CALMp9eQoHnj2QYBtOZisjB4oTaAUeoWbk3Hoj4+CdTGD2EJB3Q@mail.gmail.com> <3a9a40e9-da98-4650-af12-6de2174c5898@intel.com>
In-Reply-To: <3a9a40e9-da98-4650-af12-6de2174c5898@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 12:19:57 -0700
X-Gm-Features: AUfX_mznmfEONRnj7IXhZDDBIkkAv8HCsiyTPt7I-h0U7Op4g2OoowtOnhWutRc
Message-ID: <CALMp9eT+KPoM-PSoBOiuRd3TTY56egPanA-tfTaWagUxUBGwGw@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] KVM: x86/pmu: Support Intel fixed counter 3 on
 mediated vPMU
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 8:36=E2=80=AFAM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
>
>
> On 7/22/2026 5:17 PM, Jim Mattson wrote:
> > Nit: Should this CPUID.0AH decoding be left to perf? Perhaps struct
> > x86_pmu_capability should include an additional field:
> > num_contiguous_counters_fixed?
>
> This is a temporary workaround that will be removed once non-contiguous
> fixed counter support is added in the vPMU v5 series:
>
> https://lore.kernel.org/kvm/20260707183405.15571-9-zide.chen@intel.com/
>
> BTW, the vPMU v5 series is based on top of this Topdown series, so it
> cannot be merged to the Sashiko branch for review. I will post a
> kvm-x86/next based v2 shortly with a new cleanup patch and minor
> changelog/comment fixes.

I am running our internal Sashiko on your vPMU v5 series now. I'll let
you know if it finds any issues.
