Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793223075;
	b=VuTtM30wJ9lHxK5W+b72a/se+NVwwpd3I5CAOA1zmvE8oHoPRIpJBK+J6lJKcnEGrxbs
	 VCvmijdfBqP/yI81Qy7cRxsNnN07PwMRfrUkuRbYiISe9Z7d9wVXDO/Zx9Ergh7ZfIdtL
	 YOmMvk/NHvZoHkbCqK+P7FLDmPdFijHhWFNXJ6SI8WRznGBJRFi7heJDpXIxFEIjXS76r
	 ivWqGV+wo90XD1xxMGG4325v9o3GcxLYEmIOOBrrRC6a9sOp98msLvj9BkQdsRvMOAf7I
	 sDU3JLQ8epLFWyJuLQJDT7au0vuOcnk5hJvn+6imc0AusdegU/ApDTfqPRPsvCNjTUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793223075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m9aGBk6K2DSuOberChSpAVT1aDTSA07rsVsWjJsLd/k=;
	b=LeFQYETTFwjW0LpPTyg8/yQj5bAsVW8+P+NEgWm/dHkWQ0GepXx6UVu4mKy1xWvvakcH
	 eGvUyPMdQcsFqsm/AezyYwBtTOpUIN5Kd5l2Dt4wBi5bOcfGTu80BXDZu10sE2r9ltcTy
	 ljOfEUyXzA7rdOpm9MAOfW5fQRQarbvwaII7P88yumcjsWXpsHoTaUFktEvELWSnrynFT
	 p5Sjg8Qt1Ws0PeITdZag6TDe+PY/mNw2kGscfX4zJLmYMb/djp+dLLGHweUKobjHg9IKc
	 JN54ln+h1hbHdm6QmUj97VTJcz7Pdk7LXEEohEw7Lm4jsKF80ad36ixvZF4oI/WF4ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KxnevNTj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C5606A31E
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 21:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C66C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KxnevNTj
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5337c7b9937so103391cf.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:31:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793223074; cv=none;
        d=google.com; s=arc-20260327;
        b=kq/ibr4WSrW0vPZ4RSjkDVwQUy/FguaJq2Wwv0RAu4UdZxBWgZAPUbr/IvLjE6QQ+F
         Gla3j39aYNV97qkOQbJRian0hjyMa0jEs67BL1NISJk9vc9fsEf4f21zKIBRBIK6a3TY
         2Z0vhli99uCySJCdHSWcuYoeOY4vb9RLmxnmey+FR80HEA/EukxABDTSTO32RYysMdPx
         5K1ZvilpU9P1cH1LII2yeAXrxXGx7pB2p/OV4K5vmrM2jDvIn6AJ7M/3tBlMvOQUwZuu
         bdi1kviRWH+h3Z7O5Rb+1vSwAMKAS17Ph61261dgxVRbxFJE5eW8A+Qim8BmkLGURO3z
         JkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m9aGBk6K2DSuOberChSpAVT1aDTSA07rsVsWjJsLd/k=;
        fh=3UcjnRkabaM4WWwILjdQx4NVwRHEvGD8sy1Te5vSgRg=;
        b=g/c8ky9zjcG20UvwqvbZPJK2seaV4Hnvzdm0dKXkLRTsMkDETlgHXOFZRFEwI4S668
         jN9KU3u4AplE+4FGCbLbqQCJeYm4y0Q+aR1au/s4+A1eMpQFtqv5c2j+QqZeOvjSHl4o
         MUm2OJVVLubgnQqNoi25NTM4SZaizkH2hVLTZL9jPI111ZdzTuAtAQCj+PSkxviM4EBc
         f+sLPdNG2E1DetmhtsWrILqRQIereayl4n49qLz1CuO3lZ1LIcPOVJrcRIax3033qMoO
         VvMz3k2DBAi+pSsXPcOvzD+ZAB6JOG5brAYqH2fDIQZVLmuiiMhtVuRIfFfDjOYwqYNo
         qOxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793223074; x=1793827874; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m9aGBk6K2DSuOberChSpAVT1aDTSA07rsVsWjJsLd/k=;
        b=KxnevNTj/Uo39hOYU9x4XfAk6dE3AJmJkt+SatwvUfWdhsIvPxmCMoRH179LZITk/y
         +Gnm/CnMBUnTzrfQvPy8Je5uu5L/mQGq8uCPvBUymwEbcYN62BnG+y384dOP9hmzd8kl
         zQ89mQhRYKiwdigwuA+X8mMaOWRROEKagXKA/xd5wmPCDwiwe1wMqwaKKjae6ah1QQbH
         5xXKLOxxg81hhfm7P2ixWeKj0WSANMeui9NFd5OD0UKuYhBewklud4dG08+bsXzLof3Q
         5TyvHb44WsN8Lf296rUvSEy7gjB382rd07fI+sxxmzeTqShvAirRs1lWx7AjhiltakCE
         UQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793223074; x=1793827874;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m9aGBk6K2DSuOberChSpAVT1aDTSA07rsVsWjJsLd/k=;
        b=kE2OhPiRVtMTxMqKj8xgIIwWOr1fVA4CQfOVLQf0Zyjd0iRIVKsFRyEyMMxh4lUNhK
         ZqWIfT1aBFW1jwVSh9DppJDHcPeD/rRkGPxEwoAuHgJixd1Fk3matYUAsFfcAy8LwE3X
         mHGY+LtyYU2k1yNao/lz0h5nA4MQwwweG94VhLAJ9wI21UY3tN4sWo88kYEqTncBPHJ5
         fNXwk+tZmswGaJYceyo6Y6GLRx+2c+HGh7+E+zzS9uCGsN5oZNInBvpH0mDJoZOw2zBO
         VlPpy1/awg8Fb0+Pv8aJX/EYUOgpiyuW2bCar5cl2HktIfSsg4DL2+Af+WIg8mR2jD4n
         rMBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrhNHF/MuHcUxkf0JufWq0Nf0mMgKBxroIx4pAa6PjWm7N9nt1ZPLZnpfUu0quwtZsbp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYI97pIwMVc/tLiRrkjokqfH+Mf42hFR3m2kh6XVCK26fjYlj8B7
	nfD/L2LgDh654PBUOngV2YNeO7ATnRO2DoAGTUDZ4Nhd2xU5ilMe/JlvY7khXCppxs0U+VagSsq
	QW4JH/kncDvmzb5z1IdA9dNPULqT3/RYNymL1WdxgOotXOaauRD/kwQaedoE=
X-Gm-Gg: AYBFou1Zw1YiqfXNe6367ENedG6L++kwUlC08Dd2b6pnf9oPrZRjCBWaG/EZkvaUHGS
	ieO30Yzo0T5ZSAP2CW+qqTBrGgaGm+qz9u8e0ZYCiga3p4BiJ3K9HHFkWfNnyM4BVnBM18VnERa
	7pyL+bwjQn5PfOsJ/fnHI2sg3e3P6KOnoxaaunihsxN2YW27D6eyKL4jb0vnxUDcq6bAMKvD1jP
	cGQUv1MeVjk6+fY88l0UWtekBLGv4NgPVU0K+PaPEOa+l/3Yp+ol2726nBt6I/IC7aQb+0sdmqe
	fACmIsT0JPY9TT40VPLGzosijO+uoyJN5MhIAJQBAgEJ9EMFEZlS4rh1pdMZZK/iXkIh3BE0e2i
	Sced1po97J27evE0/DOjp7llwcPUsjeZmVXjs
X-Received: by 2002:a05:622a:5148:b0:535:9aa3:5ebb with SMTP id
 d75a77b69052e-5414de19e54mr2522771cf.8.1793223073074; Wed, 28 Oct 2026
 14:31:13 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-14-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-14-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 14:30:57 -0700
X-Gm-Features: AclHuK8H03wGGLJIEjVfGl3dt9B41jEIn0rRjkJzd1wAnJ56AQXBqQQWHoy01b4
Message-ID: <CALMp9eQGRJXgw0xsFMt9rf4+Dmb2_WH4_LguuC2So3a=5mX+0w@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] KVM: x86/pmu: Factor out fixed counter control
 bit calculation
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
> Rename intel_pmu_enable_fixed_counter_bits() to
> intel_pmu_fixed_ctrl_bits() and have it return the computed fixed
> counter control mask instead of updating fixed_ctr_ctrl_rsvd directly.
>
> Accumulate the desired fixed counter control bits during PMU setup and
> apply them once in intel_pmu_refresh().
>
> Move the helper next to intel_pmu_set_msr() so it can also be reused
> there, which will be needed for upcoming ANYTHREAD_DEPRECATION
> emulation.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
