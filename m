Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6003BB139
	for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081012; cv=pass; b=F82GGE28o9ILfgAG+00/fPXdlxsUWz/CucK34CAvnx6c3YVTACw9XYBGoYkVgxJ/gPAj1YQtw+jk3XEYdfRnVtaa+GDjtoA24+HXomo7hGtrkaz+oE4wCJYWZQ9ZiEEbGtuJI6p+EgJbl8qI66jiMkCGjz1RLKhxBuYaCxc/Ghw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081012; c=relaxed/simple;
	bh=fwqaXddFfzDaa59dX04PdbthmTsWFxVG37Kq9r4fErc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMdCYHR9UL8EDSnxH4gqZQl4af8RfuZRNxNDpKtYpZF5Vj6NKnVY9sDYPG7fwjNRdjnpsZ3GiMdYC73Bce72Is5W9yF7pPymDSDpDmL/w3muzgzvY+jYGOKMOHnbKtXcllW2b1lruH1WEwDl15de0KruJ5nn8pywYc6FYialtpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L492wOyl; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L492wOyl"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so6201a12.1
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 08:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785081009; cv=none;
        d=google.com; s=arc-20260327;
        b=gsLq95+nI0EMVwScF8k4wAn8r2um1kz2e2wbJO81ujQyxfpxHQK2nUzD/Mlvar4WbO
         BFxcFRSS005n6FPixjpQqoah1+dYqXPyXVZyU77jtXt84aPqqTB+YCFTvcgYK83z1DAQ
         FFrCOiRDofFQqvNnVBtWDPt0tQ/zFPEqf2kQOu7/quUYdpwkxiBhOt4B7NDz33WombBv
         1Ha7NHe+WXTHyrsiFk0dUlradgFGoLL6uvt4sUoxbxw25nEeAEKyCCxnGQQkOf8ZJEvB
         LzYq5GYLw8efNOe5/oirmSJTVWKg/vXUp6dk2QsrEkA36NKAY09bDjVzpBCRci+Xc5GV
         40Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WGK+a49LrgP6TayOL1R8ZxA+4Adtde1sOvgZdiu3Rk=;
        fh=YPmiW02JnqNv/CMJAqkx79R10ynW5SeE1xfuMMwxgPM=;
        b=sSqNAQ8naXh9dmN4fYj3fJhgMa1BkZSJ1xJbqwwXJdhuu6Sr2NBZDu4EBKqXeQL4vv
         ADkCoK3lKWhA+M2f+YN5iOJ5yrYUI6/SINa0CEVWB5ntekXp8V9efRSIqbvJgju0OMgO
         OoBjezgVljDn92M17AsN8XTHzGSpG7pIE1nzzO4/IRueI3TW+lyeD7EsrWXE/G+dfH2W
         ofTXjxeGtxUoTllPN5kVqOoUQQSleerz4UVchlF5TwxCNEyiFGj0xMJ8iJL4rmFfd8Hc
         9zAShqotEMfle5b/BTSZ2xAScy2n1KX6a4e5vb1ncKcpB37T5gCUUnhUivc7p1/tu+N9
         LUkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785081009; x=1785685809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3WGK+a49LrgP6TayOL1R8ZxA+4Adtde1sOvgZdiu3Rk=;
        b=L492wOyllxb5XUpRugcnuKvD3KgqL/l5PkkLhnevSfSxPeOT8oHgRuJlOAEZIbp51d
         GF62mLUcHbl/G+VXYn5PmTeCVaMOaXcPddXm+oc874qYAKCcYSk+zuLRwkM56OgnkNQH
         QeLQXjhmeOa/12w1qzzLNENVZZsOxQF6PzWVx0KmNk6pu1BgMlJknxJBoyOdmSCCQILS
         FXwt1YCF/C7DB8fjmn6BdKYP1FkoBcD5cx2fv814LgZT1MUsQODHAXSp8JVdAToLo3W2
         mlT1HNqivhf3PWLYcrNDyfiGpwYOPH3baMMkO4x2ccZnYHL4b3uJy6NUBtVfzq4kAeoR
         W+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785081009; x=1785685809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3WGK+a49LrgP6TayOL1R8ZxA+4Adtde1sOvgZdiu3Rk=;
        b=lleYfA45HBkULnsbhBZR5y/UPXhAGru+fEcckpEJzX2YxwB1TCsoT+Fm3G4WizK/Pw
         KEc/Hr+50YIWuU942VTnM/PU4xsv8gdHchEcTJOWenwKD9Vif9lvB3lpB2hKNw4j5YSk
         CYgFnP/N/6vb76ZGslbDtzxXtrBd+hfMktFtUdeXJVQdpUOI/eeCeYK0WiX4SGN4H9Po
         vva9dY4n7Ifdf0ZdZprVW1FoqLT5aCv0vXwgQ3VRPlCOhw4yL9+PkRK6BF3d5LhS51V5
         P+7/60Km03C8TYTKENbzuddRtggtMCl/rPhl1XWyoNwSLplPSD6xregJqJbb2Rlqssp0
         j0VQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlgT/C/SenDXuIHvO7MqP5RgYBQZW/mfracE1DpnVawsR0e6R/1x6gidox+wVKytO/1EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7zTzGWY4cX/RF7dThFt1Muao8tuJ4wmtDewperdBSvq6H8O1
	b6vua/fBe3coRj/go71ksnU33MUB47RyfY33+5U4fAea9V3fTeJEiIze1pr3fLWO9OcGZ67aJC4
	oW+S2r6zdA1GaeO73PwuW6J/JruAVEpHyNqFAUVlL
X-Gm-Gg: AR+sD13fNpzPx67yRTW2VFmQ7xSvDwpexhZWZOS0naGM3jP60y2Ww5jALMxdcNnm7po
	qsOT63ar1w8Aq/YhSrW/OsAjoGAEdiCr7BiVtEUtdfw+21VX7n92wJ/qmglAWj+3wMPpI4W8jSL
	6Uaqfe1E7FgRJcm0Ypz1uJgdICSAW/yVxoG2ybOT0bLjQEgT8ARlvyUI8V4heM/99BsRaIRmSIk
	3wkwLI/kX9Fayct6avbyJVQnl0dXiTqx44Di5qn5fW/uMbJV3LYzj5yVqf+5zzPIbi06drb
X-Received: by 2002:a05:6402:404f:10b0:69f:2c93:b7cc with SMTP id
 4fb4d7f45d1cf-69fbf2e10cbmr41695a12.9.1785081008916; Sun, 26 Jul 2026
 08:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-6-zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-6-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Sun, 26 Jul 2026 08:49:56 -0700
X-Gm-Features: AUfX_myvy8bJu1T17aLa-MpG9HY22Cq_6KV1dHwgg7ExXOxvyl9lSYa6fm1bmnI
Message-ID: <CALMp9eTy+aO9LE7UrbgxSqbwUq=NKXVEhTNmmAA5mtnqHevepA@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
> built-in support for Topdown Microarchitecture Analysis (TMA) L1
> metrics via the IA32_PERF_METRICS MSR.
>
> Expose this capability only when mediated vPMU is enabled, as emulating
> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>
> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>
> Save and restore this MSR on host/guest PMU context switches so that
> host PMU activity does not clobber the guest value, and guest state
> is not leaked into the host.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v5:
> - Remove host_initiated check in set/get MSR handlers.
> v4:
> - Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
>   host_initiated. (Sashiko)
> - Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
> - Remove the redundant !! in vcpu_has_perf_metrics().
> v3:
> - Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
> - Add comments to explain why we don't validate writes on PERF_METRICS.
> ---
>  arch/x86/include/asm/kvm_host.h   |  1 +
>  arch/x86/include/asm/msr-index.h  |  1 +
>  arch/x86/include/asm/perf_event.h |  1 +
>  arch/x86/kvm/msrs.c               |  6 +++++-
>  arch/x86/kvm/pmu.h                |  5 +++++
>  arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c            |  7 +++++++
>  7 files changed, 51 insertions(+), 1 deletion(-)
>
> ...
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b736b9ff965b..21eb4b339fa6 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4273,6 +4273,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct k=
vm_vcpu *vcpu)
>                                   MSR_TYPE_RW, intercept);
>         vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>                                   MSR_TYPE_RW, intercept);
> +
> +       intercept =3D !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcp=
u);
> +       vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
> +                                 MSR_TYPE_RW, intercept);
>  }

Should we also update nested_vmx_merge_pmu_msr_bitmaps()?
