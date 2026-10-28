Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793197976;
	b=LZhuknaIchVVpOqe/Mq4tRDbUHJmDQCneAoh3QVcGvp+CR+lY4LM8fDf4DDbyMylKqW4
	 n/wQ3WBo6gcjbdz5m4FnVET5DHeptJsUZsOgpTjec4ORGkRzSrRUM3AYfYGUwfewOgBa5
	 HOnW108CF4q45OKTPkNJl8I1NqmEN/Jep+BcKTVZEzc/E88niJLzbMNNeAuA8e5FDmeZP
	 oCRTv8LpNv/XVEmQiacDkNTO+UZqqeUmkv+0favUsw7EZXtJ9vymZ/se3i1norMMoW/5c
	 gHRzs36d0OQOxuhRYmaA3OwuNjLT5Zsps90e8gjC8dcOVV4PlSErRNQzkjwMR9SIoMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yx+5R/vIWc879ffCmh+IwgIrqvOvc4BaxTNXJTSV5Fw=;
	b=HH+VmyUPN7qfCrGDjMAA9OP2b0GVENkKXlDsF28luryx5GJPw4aJHMTwwnEEaNTNSMsz
	 igqfKWPZphSmKXXOMe7t8a4K5631XsvqMFiI6RoWKd1OuAqdfQjM4AEOlHISx30NgkkNp
	 5FWOXMALjytc6atJpdkAMGPnlSYYtF1zmpLXe/3POprkfU1bkDBnJr89uvghYAm8zSL4r
	 d312Wnaepc25COYfYU78wTd442mx+O2DU/QpE+ZYnuSVcdcY7UQ4AsBeT1lmVaVquCTSj
	 pHHord7dmhopw6yCohAVh5ipMFQ5D+cHucmcAs5pqj25C9LBF1UUkSdXZ+KZP4BFsdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L6UNNPxY;
	arc=fail smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC775606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 14:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC775606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L6UNNPxY
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso14141a12.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793197974; cv=none;
        d=google.com; s=arc-20260327;
        b=phnRImsZvegKGspgf5TateSOKpfjuwFIcJTCVUjev081DuerZ/1h2ynpeFS0tySR/x
         8MTRSD7DGJKs3Q13jYX9r1kaWeY3lDF/4rAhgQuj1LyYxnOWncah9sWtv+AExbGrqvrN
         JOcmtN5ENYwgn25R4sW6PsAnZ27yMSDzzmOA2ekMsuN8RQMWCURC7wiIXkSyYpVsnN7x
         1b2i5iOK1aMDSYBopJTwxSQ6qDdvYdNEEkz8Bkc0k5mPQlhyGtK8DPGZG7TDeesPDzmP
         Wc+/XIg+bllnpPvXa9Xowuzt4Gjaiav3u3lB54NUaAIoHOXzKnaHyfHaEA+dqUbgxAzS
         Ndow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yx+5R/vIWc879ffCmh+IwgIrqvOvc4BaxTNXJTSV5Fw=;
        fh=8Rf2FacPlrcEAAzXUzclHny8COdATX2YIt8xzaFrzg4=;
        b=r49I74cNYSYqCrwkYwKEiIN3DCmiWehoJSWuS1x/1Ngwz8gi8gGnofkqHfpR6ldxOu
         26dnpFY0AY1EIc+rxalPeCM/4364EjLDBTlbNgKN4NcKlIlGXkAGX17eJBayRHFfmeAL
         iW22wVVkRakYp8uqEINQKKrKbHt4pF2nIlrvxDv8vjQFUJ6QIecNaMzpABJqGiZo47nZ
         KRa9nCxKXfHUFyqMoA/PkJJj4jIgkrnbBTJiw39KXYRSSfz9fz6D5jMxPGvSwPLhvFih
         iXWrj0+phFajKN0xjjUFIjC+7/lkkhIPdox9HRcT9PEtAHx8sLHwcnFbzANgWj4DcKaz
         oxzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793197974; x=1793802774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yx+5R/vIWc879ffCmh+IwgIrqvOvc4BaxTNXJTSV5Fw=;
        b=L6UNNPxY3OmY+7xadndWEjftwLGw4TwEcjEokthroIC7FNqwiexSIF6WbsCJTD4fDM
         KPge6ZhY8x5JT7H2CTE+kn2ZOfOgX3NZFw4rW2Rbm2ezPHu84/qmOTNX+pUtWNLZuydp
         y47GjNaMDCtjPzyYoTHm6e1lhOutvxo7i2wQYssLo61Cbbkrmrh2lj5DpxcBsLVlnsYB
         gnl+54f9LpHOOfOyvVtN39ICEipYGE9iGR5rfjVGmkgzp8Szz9/9I0pBhZkNujXBbkvT
         huYEktZxbWZzURW5jQSB7ma63LfMb/TWHRNAOjoeKtbnVIEc1XdJGB5/IgHilGAzysfX
         mkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197974; x=1793802774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yx+5R/vIWc879ffCmh+IwgIrqvOvc4BaxTNXJTSV5Fw=;
        b=2DaMImme3+yurJvcnUpY/g36aHc7VwGaLSgwDQ/UBdWxUDnAbLq1j7crzU4A5Gyzci
         gMPoALsX84ZytXte3akQlpfFUL/kAN1TN/5XgktN4G3oB0ncnqOaDIFsDE+A3PEaToNl
         4NXqAnXue+4+YF0ynw2E/b1kC3cUXm69VT69ksBPzO/IZd/2tQw3ddOYwzl43XtMuUeg
         DrCSEhQmPee+lNa8bsNty9kLCLmTk96lah1wjKHAVfhtyU1YBUlI45x7Spnptr3Yy4oo
         ZAwenTcUDmmrZdmvtQ2BgFYwZhsexp2LueKPrcWgulT0FEz69vEWyU+H8nnixuvo5piZ
         5hJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzZWnViHtOPTP0QbpNebcDGDN+l4CHAyuKWWATvzPsQvCFJ4AChBejDTSvQZuOm8pA4/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJqwfepnL+940/ryW9QLkklLLxrcVkhGUXpDqDJIrq5nePDmiao
	vB+t/wyFxvwRUGI0O4F6SiEilX1wBczVzlNs2mQylt4Uq0RfT62mnFSIWgbWR9gj4bizV7Z7G2f
	nvrKMYY7L8L3e0aUChY6NwaexZ0+SsLPAhV4jjz01
X-Gm-Gg: AYBFou2ifWv5b04F2vWq/N+NkdkiD4xqWF8YMh3aPQ/8PW2d14X1pzIX9hicz0xR3BG
	LS+NlAhdDvXufbeHyBF/QoGBJm3W/WSeaBozWgS3020zdB/Z/E2yq8sElmkWW59d22Ky5NHUczb
	m70g4mSZdu9mCpAOPbER2JTGro36XGr3vs/+FU3dzEA6GYAI9v+W1q7nVWpq/JokES+uRpwAgcD
	FtS6AXhr3kPm8ilD0UZNCGE7ZULWPplILRzt3iZJwGqz9eZfTF8c5DPZvj3FA43LzHk1A4DlLg8
	n1cTWLTzsYtiA20MtFyyTiSvxrDPL5CwINXIXfaAPr5fJ/am3EbuBTYLtkq0pmv5AabqwwgSM8j
	5O56x/xGexJk+IB/xOvH8CFKAg7YO954XZts4
X-Received: by 2002:a05:6402:15ca:b0:6b4:9221:8932 with SMTP id
 4fb4d7f45d1cf-6b49bf30d9emr71736a12.10.1793197973522; Wed, 28 Oct 2026
 07:32:53 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-6-zide.chen@intel.com>
In-Reply-To: <20260827223755.143247-6-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 07:32:27 -0700
X-Gm-Features: AclHuK_RSPZVdobAgjy_ogxXxziGOOIGg8mnY5uas-cfdvtLM2keEY9JFCCzDL4
Message-ID: <CALMp9eQ4uBX69=jZSx83t1xeO-3Jd0qsLOV=9ok+qGB+UnfRSg@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] KVM: x86/pmu: Add PMC bitmap accessor helpers
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
> pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
> may include non-contiguous GP or fixed counters.
>
> pmu->pmc_exists already holds a bitmap indicating both fixed and
> general-purpose counters, and loops over valid counters can be done via
> pmu->pmc_exists alone. Extend it to a union so that the u64 alias is
> available for convenient mask arithmetic operations.
>
> Add the necessary helpers to prepare for bitmap-based PMC counter
> implementation.
>
> No functional change intended.
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Rename kvm_{gp,fixed}_pmc_supported() to kvm_is_{gp,fixed}_pmc_supporte=
d()
>   and simplify them by removing the temporary bitmap. (Sean)
> - Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter()
>   and kvm_for_each_fixed_counter(). (Sean)
> ---
>  arch/x86/include/asm/kvm_host.h |  5 +++-
>  arch/x86/kvm/pmu.h              | 53 +++++++++++++++++++++++++++++----
>  2 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 90d80483df7f..49a8a2e9cee0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -594,7 +594,10 @@ struct kvm_pmu {
>                 DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>                 atomic64_t __reprogram_pmi;
>         };
> -       DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> +       union {
> +               DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> +               u64 pmc_exists64;
> +       };

Is it worth adding:

BUILD_BUG_ON(sizeof(pmu->pmc_exists) !=3D sizeof(pmu->pmc_exists64));

Either way,

Reviewed-by: Jim Mattson <jmattson@google.com>
