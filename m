Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198960;
	b=PE+zy68TkeYxcWGcmw7wxInWXVU6S3FK/BJxn4JRBhNyM2SPUL4bZBm/xgQss37dx3ba
	 pDNKOJjVcJAh03YJywpj9fl/GGih88Evm0mVUQt3/MQELz/gYjFEh8l3BxokyvrP+sqVn
	 AWv41j6zOGnDb6EUBYl3rmFTyseN7SlcV+ETOcMXIVIoF2lwTsXnwX5V+nJuP1dp3laZ+
	 Sinq1cGPXpRYOmETO8foiTtK/4xGIyiU7LbF91w4qK9UcXq69NHPZQtSGzzE9yn2Jg8Ob
	 wor070FinINv3Ghx0c/IhH/70c43ucambsnkRwnsIAl8QB8iXacP8VTYKs9FuEwHC1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=utCPzy+tkw4ynkgJD1keEVLYIPaT4gQebzETd+jl33s=;
	b=pD4O5VY33YxtGSXYDEXCGOopo4U8L5m/mHdBCWEW0uCFThAwi72HAPad/Mqa8WYSv935
	 Oe64XcaaD03pkLA8E+UPAZY+N8ObHREoPwTu6Yfg9CZQe3v7HR/uz8TkZGURnuhHCqNyY
	 9JA0d6Sy1NFn9MU0rDOwOA8bAQPIdYOsyL03EwLAEBMXFy6XTg6VaHNO0Vo8E4EmiQ9wS
	 bvE2yaW5waipjQucT+37hmEdY+8rOrSk0ucBzwpO/o6WRWuSjd1GTYtrRnPqJ7He1Usto
	 /EvtfehqnrBnA+zocppeUjI0IkANjNfJYI/FwdI3EFNDpFAvASvgXaa7affcCy/c2Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNBIc4c8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C79606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C79606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dNBIc4c8
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso14377a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793198958; cv=none;
        d=google.com; s=arc-20260327;
        b=RY+IL2otDBSc96YWrJPWreYKkbgJKvWL3sGqOPNAuSKJ0LspVzHpnrOX91NcYAZfxZ
         gP6JrvH5qERBjLDiDGDNZva4bymbPXvGyfe4R9/4U3HxxPh+j/sboGRv4v7PlunaB0jh
         lw38wLUyvZUUj2OoCYQALyZmsh2+uYYy/eeD/IuyQUPYcqgqRJo38P+lyK59dofFCOoo
         cuvO8kR3ZBAJdhkmIelrEulVF/SmYY4sY6Wx28naHB8vO1BpGf8jd+zSQ5RzlYZksRwr
         KSs66rIZE9ehWFiQO47wCHDlFamGalJ56Jg5Tyq1cSIqouxygiFDKWlFnIj54TsIASwt
         fSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=utCPzy+tkw4ynkgJD1keEVLYIPaT4gQebzETd+jl33s=;
        fh=Pk21R3Ac8VZBPhvQqfd0XN/VeeokVZyd95aS6OOkkiA=;
        b=d8VvJpgJd+Bi1LAglF9cM+iw3YMtbjatvPzq0sa3gpEvLqNL+ulJHmtRClDsAgtRyo
         A8VuGTdV29msN0ZnfQyzxa/iljHfkN6oiyJI1x8xaJHX6fKrPBx1zdRIH7xlk43MKc7W
         bqAibpDndsgAG2WZfogCSUcEp2ytpmbAREQj5E1TKarpmcNvdXwmc2+RLs53GHVv6Eok
         Q1QqIFvJhA250oZjVEt2UGhMMo7qbrMnw6Gmm6DLqOtDGhNF1LB2d+nPpbRMsD6Ttd4b
         W38yiVmFSvvUpSjI6UeuNBvefBfz8IXNZCR/WxMjBNC3MH7sxDc6ou+TBRM6QVD5cCyK
         eMxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793198958; x=1793803758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=utCPzy+tkw4ynkgJD1keEVLYIPaT4gQebzETd+jl33s=;
        b=dNBIc4c8fsaG0NVOcYeVV2p4ae5N3eN0y3Klumt9jGzf2fRoQqNuMgVR7v5vG+18iz
         OgkRyhT3pdiFYLqoEijj1DM/rb6zHktERZR0l0kxhHB+y0T1hcnMmnDNIK/iF+Z6EH5a
         3KsIke5A0JpLMlsQY8fa2Wsge38S87XWFubshExtqt/IDdvjojOLYE5QjCeYn5RRG6/m
         zHtdIcQ+Fl3DSySlAMGGCre2EYpcEajV80n6lvlDNaPTba/3f1Mdj05qoxCf2f6F0HRG
         xgXYbbQGX/+5FrsHZrR5JoKCYQLgl9I9ktaswOMBwcm2W7fbp/HfbEjoUjOILu0GNw/v
         xzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793198958; x=1793803758;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utCPzy+tkw4ynkgJD1keEVLYIPaT4gQebzETd+jl33s=;
        b=WN0G8OEIUDC6UuqBATyw3t8axijNlG94me1nnxAMAdpkucNt+YCLL2ImCYKBr+7qtB
         fAdacMLeJW6nXe/ZiFMn3ppr7Ntzw8xuL4xH0ZRyVw9aDkZoex2Sr8jjEuDuk3fc3lrR
         xY0/fy8vXTBcKigG7yi3RiW2UfV17z3KPbnBbV4ntvxmebq+Dp1CWso5MHD+s22KAmKv
         LYMMqora7YwkpbGb5vCVt0LX8DYlmAjBgMpx35oLR2mvbbia2pcY9cmDr6Svp0Q13F0v
         y81W18SBqDm0USNzBXQGmzh4mBhQMkobZsWeWkkjwaudzHe3XE3whYFSRCBJ6QRhWbVN
         jZJA==
X-Forwarded-Encrypted: i=1; AKwUvBx/0q7Rp0BX8zcz+9B+K3+GZl0BaSopPTyXdwtN5KkbSdIAA3JQUq/Y/OV62qo1ic41FCY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1ZoJb0F9kZrsPwth0K0qfob6DnID05p3zTkPAyQJxB9Y/T1bu
	3n0Ek6WGnlS5E9aNZ7k0meBXKNJ/zF5toT+dzKvPtnwA8GcwDeYZnEspOtNg5wiYDczAwX4ei0M
	yBQZgAEaZheVqfnD/BJj55B+J0HJyNjyle6vAvZlP
X-Gm-Gg: AYBFou0lHxq7CpT4JgqmJRUkt9GVqb95Lrgea2DkEIm72i27xoXIe+QeBZkJ+aH7/LG
	a+R0jbdoSrpEXZhrrlJPSI4cwFtwgXPsYECz7g7BeWQ/ibtEUtYMwCCLJCBfxmX2s4a/+BpBmW/
	1LjZAUewWoPpsaQ44+6JOTlWri8Zp42F5TXoG3jumxysjtu25qpOfJU1aPVdL9iabSy7sdAAgTd
	7mkXNxFyri3jDhL4dXbKrkxHUUHHOVr+Z9nJ/kIMjypu6Ydooh0jQKUb2CvSmxZuhQbJjb2F1oZ
	Q+Tulom+wWheWDouw813xLtvtXrJ/VKnYMrh0UxTbbKyZ+PvWMIQthPTCDzWzIDl32mM2iCHRFS
	dv9beZUQLR3Wowj0lhK82MUysTrf4GB3sUxVCQA==
X-Received: by 2002:a05:6402:c502:10b0:6b1:aa31:a627 with SMTP id
 4fb4d7f45d1cf-6b4994b7ce3mr82073a12.4.1793198957960; Wed, 28 Oct 2026
 07:49:17 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-7-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-7-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 07:49:03 -0700
X-Gm-Features: AclHuK8n77ASv0YtAhp7uY-rKpDmMZOITBWFwgXV3mX-mvm_sx5SsIOEQuKTOts
Message-ID: <CALMp9eQ2D2BjX8ZNqRuNp9h46Rw-_7pJD=50JAXbNHf5KEVj2A@mail.gmail.com>
Subject: Re: [PATCH v2 06/16] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 3:48=E2=80=AFPM Zide Chen <zide.chen@intel.com> wro=
te:
>
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> This is a preparatory step toward fully bitmap-based PMU capability
> handling. Later patches switch KVM's view of host PMU capabilities from
> counter counts to counter bitmaps.
>
> Populate and use pmc_exists directly when walking guest-visible PMCs,
> instead of relying on pmu->nr_arch_{gp,fixed}_counters as intermediate
> state.
>
> Iterate counters via the newly added pmc_exists based helpers, and
> remove the now-redundant nr_arch_{gp,fixed}_counters fields from struct
> kvm_pmu.
>
> Note: {vmx,svm}_recalc_pmu_msr_intercepts() may leave stale intercepts
> on GP MSRs after CPUID narrowing. This corner case is resolved by the
> following patch: "KVM: x86/pmu: Switch to bitmask-based KVM PMU
> capabilities".

Are you saying that you are deliberately breaking bisection?!? Shame on you=
!

> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Fix AMD legacy PMU MSR intercept handling for guest PMU
>   narrowing reconfiguration by adding for_each_clear_bit_from().
> - Re-word the stale interception changelog part.
> ---
[ ... ]
> -       for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++)
> +       kvm_for_each_fixed_counter(i, fixed_mask)
>                 vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 =
+ i,
>                                           MSR_TYPE_RW, intercept);
>         for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)

Doesn't this potentially leave stale intercepts on FC MSRs after CPUID
narrowing as well?
