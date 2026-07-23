Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640AB3E9C26
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843613; cv=pass; b=g300TLdvHf4axRAi9HgjyOQWR5z3VhZYNFbu+/Ia+0P1yQebUNyyVDoHGLAJu93Z5r5+iHePJ8fiGLFgx0zLAzpMGeykSSZ6sf5H525QLzitOKIk4/9kiaWB7cun3xHqguOFjSOnVZ3XA0ABmnMO1BkBqOWjGMnI1QoZeZbS3YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843613; c=relaxed/simple;
	bh=BaYqCoWyHDJ6DZ1+k06CHB4d+Fgb7MTCffOYMdshlrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE8eAFLZgqkJZpGwjBEXf6xxPDKcI4TyIxQEbQtk+xha71/Pmq7gXfmlLRr2uLvlKj+kZ1nlwT8UbzW7GTwvpmPedYYy9oa+TQrmrp0j/44QeZyiG2NP9PPpgPTPJwgQXPkA7AqFGNo4mOk5zi+aoRk438ZYpTaJ0qmU9WISxxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LipB20Dg; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LipB20Dg"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1616a12.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784843609; cv=none;
        d=google.com; s=arc-20260327;
        b=sL4AwR9oMSq1bLaViQlUMPHhlvvQ3myJvUyO41qa0X8jN6I6chHdSUalFy9zF/va4G
         Md6YP8QIhzNVF7T1pz7bJWShSLlVpuZxcD0azMoIlySIJzIVFT4M2pkBjvwHGIBmTYMc
         +bsdmnvUKdtHXFjbGhUklWuFKyn6p8atki5awQ9B/ooOVFGn1pr/UJRtdT+HjuLpZClN
         VQF/FPAJsDcnLd07rwO783t5u6DCxDoq6aiKxGfHsXdCxyf5SGae8AUh0lDiyU7OQAeU
         YRC5sQvUpupq9wT0FC+SGVg/HEiaMLCiq1VwQZzlG+pf6U5uua8H9yyRA313L5We0Vv/
         qPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+xnErT78irrgz+3o42DnVWGqp1+cITiDWoyZppM1CCY=;
        fh=GbjSIhz9vLe9tyjT74z9uqFi7sesnjXCcJL5c2KqwqI=;
        b=aGVv4FdPF/4JS4khg3aR7MSETIF+l6TVswNve2VOrmrWU2I+TOlRsGGtAU09vm8SUz
         KOFG6UcSAYvjE8rX1LVWh6mcJF4UzeDsDh+7OtfHyBA1Zj3uqo260PgRjvidDmrnPG7y
         XDvKz1GFXNXoKMIDRv0Qnz02Osm/9R0XDLqzk9PnMf0NuRjyfi6FLqkS5izlMJ8b27y6
         XCp/+ARwk3S3e53YMHan6X5axEMnP1HFgx/lnWO1fMccGKNxLBEQ2h60KveDp9uqKamb
         KGl4RpR8PDFMIcbuYnfQsud1xauav8boyAES0g7rMuHF/cC0LkHYlNu1UY09x9DWS8VO
         k3CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784843609; x=1785448409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+xnErT78irrgz+3o42DnVWGqp1+cITiDWoyZppM1CCY=;
        b=LipB20DgKp/KV+PKTVtOpvGtAUzo0S+YmH4BoGwBDAWugtHuRG1wGtD6cITj5WjBMs
         4kX9hvRjpJGeoQUJqJ+3+oQFIMnEyzJSIpbnkMKWk4qjJHX3kyUuIqGDCfBe70/78ucB
         oj4mfyeZpi52CLaEzTUATP/IX9NfA2RTSOJ5iXrkuEM7wxhM5gKkZkKTYJghMk8PwKOY
         q7RjpgODRwjcNOlBLHgIiJIfa1prxj71YZKigCTMZj16wQZBAMkol07k/05s+GVtywUA
         3p5f55O7RzCp5c/C2vYAz7Q9I127ES+H68EJPtYFxvtHYuajnh2hAg58eLepDW9sxEt0
         R++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843609; x=1785448409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xnErT78irrgz+3o42DnVWGqp1+cITiDWoyZppM1CCY=;
        b=rJNOJmPn5Llc4XPeWnJfsAt/tu0112yJV+4E/+ejVKjHV/CbRJ74L2sQ0NGO7g9e8m
         HWPQolShuGtuvjxPRwiWK2PotPoUaZEj/+OdqbXjkfxMEwuTCzhGe8v8xuJH3JEbljnM
         PkDsAodij2stt9ROPZ/SwgAl1+JTRYhq4uhbptxqUu6wu0qn+ClnNXPN4izQ9e+30TOU
         gnqhq1JICRULtGfWcpCxaaLrJFPwdxKwglIP+1ERIuWMmYMhB8/DW+nGDvOCyB/+2Yr3
         RUakleJuAxHzjg/UgMu/0/R3KOj50YIdsa8FJBQBNj04CPz2JVWBTLV7nz/MsT+zJA8r
         PScA==
X-Forwarded-Encrypted: i=1; AHgh+RpPP0ghL33BFVfg/6jAiqNtcV84LLUjy6Hhz2EXCRCmhZ6ZbqkPl0QzWCq9iT9AW1SZBX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nRHU9upHJmk3sk2NY+rfeaN2ow5cQf1K6hvBVW47Ufsw1PLA
	9H5RxBY/dF7Zr1n8cdcmfrRJ+ioZ0GAz2M8Q+mmxxEkKylmbrH0hInAA8pwZkcYKtl12RmBpU58
	Hz+l2YjpZe5ZQEYH4yXhPK5TtaRnxPn8Rd2DUFk3odMrWdLCNPItb/anh7AI=
X-Gm-Gg: AR+sD12FnKD+LPWAgAoqkKZtAO42MTlgAorMeJx/F49i/7IzaVDxgJnI4qfsOIgtB/V
	mgVC2vTgHJq72JDT9+jRaNE2/Uw/MV7FvLtXkoHiTb+rMDFhE6pDmiUvonAgmgWgUTIVuwBPyJp
	sWi5mAnW2W7Dgql4GRaqqahBQISRFSB3J2o4SJQCDOyWgPaCFl1DjxNfnxx70AsfUOPTNjc5H9X
	soFAo5YWimteI9N4khjA9QDMIy+FqRhKFFMDILuOfjzjLrqLMJCDYfNkN4ANQ==
X-Received: by 2002:aa7:d91a:0:b0:697:df76:63f8 with SMTP id
 4fb4d7f45d1cf-69f92740f4bmr7337a12.3.1784843608311; Thu, 23 Jul 2026 14:53:28
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-15-zide.chen@intel.com>
In-Reply-To: <20260707183405.15571-15-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 14:53:15 -0700
X-Gm-Features: AUfX_mwLj-yTP_SDRmnMyZVR6h3z_rPLkKkd9GaIFUk__kr1aDcsFCEv3UnRb50
Message-ID: <CALMp9eRWo+FA-qGiB3Bf-UQOK7hV4-pN62SjFgR5JYLkaMEcmQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:44=E2=80=AFAM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> KVM currently caps the guest PerfMon version at 2 for all Intel
> platforms. Now that KVM emulates the basic architectural PMU features
> introduced in PerfMon versions 3 through 5, raise the guest PerfMon
> version to 5.  Features that require additional emulation support, e.g.
> architectural LBR will be enabled separately.
>
> When enable_mediated_pmu is disabled or in the non-Intel paths, KVM
> retains the existing cap of version 2.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/pmu.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 7d58f7a2a2db..83332e8ed1e0 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -176,7 +176,18 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu=
_ops)
>         }
>
>         memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
> -       kvm_pmu_cap.version =3D min(kvm_pmu_cap.version, 2);
> +
> +       /*
> +        * AnyThread counting is not supported by KVM due to cross-VM
> +        * information leakage concerns on SMT cores. Therefore, AnyThrea=
d
> +        * remains unavailable for PerfMon v3/v4 guests, where AnyThread
> +        * deprecation is not enumerated.
> +        */
> +       if (is_intel && enable_mediated_pmu)
> +               kvm_pmu_cap.version =3D min(kvm_pmu_cap.version, 5);

Our internal Sashiko says:

Does raising the version cap here expose guests with PMU versions 3 or 4 to
a #GP-induced panic when they attempt to use the AnyThread feature?
Since AnyThread is architecturally valid in PMU v3 and v4, a guest kernel
detecting version 3 or 4 will enable AnyThread support. When the guest
writes to MSR_P6_EVNTSELx with the AnyThread bit (bit 21) set, KVM
intercepts it.
Looking at arch/x86/kvm/vmx/pmu_intel.c:intel_pmu_refresh(), KVM includes
the AnyThread bit in pmu->eventsel_rsvd, only clearing it for version >=3D =
5:
    if (pmu->version >=3D 5 && edx.split.anythread_deprecated)
        pmu->eventsel_rsvd &=3D ~ARCH_PERFMON_EVENTSEL_ANY;
Then, in intel_pmu_set_msr(), KVM injects a #GP because the eventsel_rsvd
check triggers before any silent discard logic:
    if (data & eventsel_rsvd)
        return 1;
Because the guest Linux kernel wrmsr path might lack exception handling for
this MSR write, could this injected #GP cause an unhandled kernel exception
and an immediate guest kernel panic?
