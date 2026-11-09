Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794247648;
	b=bEyrqFJWMmHgi1bGk7QU6uuea8Twbp2PPD4b2HfvedxJBdRnX3EC6zDbtvyl/HZUihVa
	 u5xZO/cTgyb8SPb9WypPB2DM/9m3w5XBelMLCNfbC+R7Ev5RbRaoiA/AlnKVXeCNqZ/zV
	 Bh7/CeUiqqpfYP4X7zSh1hQlWPPXaCmfz10melgZtsT3F4l4zk6a6fqrqaQOc894ypkrz
	 WYA5qJca/8zU+Jd0z1jGXT5AJFPZkuJo/UysGrdO46qLqwCoztFUCQJ05swc8S+ecZpOM
	 Tkmy8M48RQj1rm1i565IvGbdewJZ86BhpBum34QEPPtT7fjP2JHghuFn5JV6i7r30Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794247648;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=chIFJGd9aGjFqIdLQJRseW64QE/SzhDO/ltYFKnzUGM=;
	b=mUOnLjPMY48h8aMrQlGY4nW0XAPRrfwO5rpbZhNdAmjyBYZSFVk3rDYy8fbtZc8M4ZY9
	 ZVyftvbRW7iL/vs1mHOBouR1nzYEeC/8BD7JcHcSa2w72E+ed6Ru1dAB95uRMarpoJfEV
	 0M9EqiL87cJ+pbD15C5nGvj9P02sxiblihoWli4qqpEGaqMF4Y7pshvz5SJEy9yuwQSwE
	 yf5sA0Hop6iig4bwHhwkqa7vonnmwNx1bGxkLA/7MOqTNTZIi1JQK8CxcAn1/J8+AjV28
	 obhQuwshDL0TQblhCwbWU2rKGtJx+nX2Nfs6AE9GzzkPJU1sXAFt/wZcJktjMIbR1ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS0xFi5F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC377606A332
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eS0xFi5F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD901F008BF
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794247647;
	bh=chIFJGd9aGjFqIdLQJRseW64QE/SzhDO/ltYFKnzUGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eS0xFi5FxEskiC1znACA7+hIu3LnDW7B/+c3J/y6hk8vRCBQny/oqvRWbbRb0GHXt
	 GHEGAUOvu4IDBTWOvc0dnIaOEr0AES2ERrqoO4uOQnORQTJd2IlFJ0DZ5+VMxK+fEF
	 Aov4dm0JNFNyBGGJOz5r0bFuYUF+35ReNfK8lFGIsCzxdvOiy/GCv+B2j4dWPVY+dA
	 d9Fba507gRyl2DY5baaHj57+7UPNKe+En4z28TePU/DJiYyUj/z0Wg9U6BaUSG38ap
	 d9ILmaKXnuQc+w/+OoghM8MAh+APWPxi/0zzc2NAKOWJUpm3dHSZaoLvvZBm0Kelsj
	 5GY+QfR2ez4DA==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d7d591607so176862366b.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 10:07:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFed+15XbyB+tiF6lJPtuXQ9OT4ktTAyXrBTxfJeJ+01ItRUUuxujtBDZP1D2jbyoOkajE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4mz8Mbfz5jyWJOvWcR+q8v13PmNU/GMwCQIrccMJxeEBvI0SF
	I9Ie9CgzOp3nW8EX/tjyAE7RMDPGz0O3G5WyNlc+K4Qncmy7PqnXTPECCMJJd3+uUwSZLya2nX2
	qMyCTqtT15JrtqEJvhj9O194najlViHo=
X-Received: by 2002:a17:907:c1a:b0:c3f:e414:d35a with SMTP id
 a640c23a62f3a-c504955f03emr11473366b.26.1794247646237; Mon, 09 Nov 2026
 10:07:26 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-5-zide.chen@intel.com>
 <au4kyULjUYdqbfIq@google.com> <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com> <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
In-Reply-To: <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 9 Nov 2026 10:07:14 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
X-Gm-Features: AclHuK8___5umqnpPhXfPUyV53ks38eOF5SSE51KrETciHe4B3EcpzDOnG_Gs_I
Message-ID: <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

> >>>> +/*
> >>>> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
> >>>> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
> >>>> + * so iteration up to KVM's maximum counter count is safe.
> >>>> + */
> >>>> +#define kvm_for_each_gp_counter(i, mask)    \
> >>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> >>>> +
> >>>> +#define kvm_for_each_fixed_counter(i, mask) \
> >>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> >>>
> >>> These are not used in this patch, are they?
> >>>
> >>> They should probably be introduced when they are used. Also, do we
> >>> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
> >>> yes, maybe we should pass in the pmu here instead?
> >>
> >> The intent was to group all bitmap accessor helpers together in this
> >> patch for easier review so that the big patch 5/18 could be kept to
> >> mostly mechanical replacements.
> >>
> >> But if you prefer introducing them on first use, I'll move their
> >> definitions to patch 5.
> >
> > Yeah I think it's clearer to see what their definitions are with their usage.
>
> OK, then I can move these two macros to the next patch.
> >>
> >> Regarding passing 'pmu' directly, I initially implemented it in this
> >> way, but I can't recall why I discarded it. I will take another look.
> >
> > Thanks.
>
> How about these? With them, we can remove the {gp,fixed}_mask variables
> that you pointed out in your review of 5/18. The APIs are more
> complicated, but the caller code is much cleaner.

I don't understand why we can't keep the macros as-is, but just move the
calls to kvm_gp_pmc_mask() and kvm_fixed_pmc_mask() inside the macros?


>
> static inline unsigned int __kvm_find_next_counter(struct kvm_pmu *pmu,
>                                              unsigned int base,
>                                              unsigned int max,
>                                              unsigned int prev)
> {
>         return find_next_bit(pmu->pmc_exists, base + max, base + prev) -
> base;
> }
>
> #define __kvm_for_each_counter(i, pmu, base, max)                       \
>         for ((i) = __kvm_find_next_counter((pmu), (base), (max), 0);
>      \
>              (i) < (max);                                               \
>              (i) = __kvm_find_next_counter((pmu), (base), (max), (i) + 1))
>
> /*
>  * Iterate over all general-purpose or fixed counters supported by @pmu.
>  */
> #define kvm_for_each_gp_counter(i, pmu) \
>         __kvm_for_each_counter(i, pmu, 0, KVM_MAX_NR_GP_COUNTERS)
>
> #define kvm_for_each_fixed_counter(i, pmu) \
>         __kvm_for_each_counter(i, pmu, KVM_FIXED_PMC_BASE_IDX,
> KVM_MAX_NR_FIXED_COUNTERS)
