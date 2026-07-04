Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F172749DC
	for <kvm@vger.kernel.org>; Sat,  4 Jul 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176152; cv=pass; b=KULzplij6a8u+6fvmerGXeP1ot42ZiJbT0y8+4zBQrMePLHphjkp6vg4i7Lf0VQHFcI0LcS3eYe0JweggCDAg74mMjf+ocpGL69W3VCXQrNxt7uQBlG4Qy3wMqgVaZQDXGwV+pT4ywRfNSH0st3MnzSMIV5mN+Sde+8k7Hp/ozg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176152; c=relaxed/simple;
	bh=MoaHjkaWH3mVoA4yYUij+2yJ1onRPN8dEfQ18Xxn+3Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxUXF2pnG6UMMbydcj1a/lmnoG1M34HUe4cNVCGQ1ATQQimsCEdmomUcpxHphyO9aSmc17kvw6yHzxVSNwIZM0H8oHssQLD5ODgMwcILun23q9Ed2J+gQE1f+wnFKClI/9PYsq+6PiJLmy/+9kAizvqdZNXdIpDPiB59iiZxzOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Li6WiCbN; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Li6WiCbN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cacb8416a1so10701895ad.1
        for <kvm@vger.kernel.org>; Sat, 04 Jul 2026 07:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783176150; cv=none;
        d=google.com; s=arc-20260327;
        b=Zw6sTm5EUZq5WYBwSCuJJ5LSpXsvfvqUyS+SZZlqRxhEkN6gOWMTBPM63gBuSd9fLT
         f4qdJb4EumR8yZsgGpkMq5P0xtduOygmBv5dzB2FINrG2gLuVPsQFHxTKlvdNzBApQ1y
         U2Ir1E32c8CheO6k6NmVGKhixJ04vvokewDyVLDR/ocENEBu4LOQX26Z1VGrkNlWIMNz
         NjSQS9VBuNcdnnKN3R2TA+Q/oTanxwgeasvZtE6aTbYNZ8xPK3O0t+NYEREigp8S70ja
         Gkq0WBWJbr3XTCwmltXKm83N+Ky7PBnp1j9Kc4qnsaDhZ88TlC6EhxAjolMo9lz4+vGV
         rj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3hO7xVm3JMi+xvznWIzbCWLHGJef3ve9nJtp5Srpwow=;
        fh=Ofh6FTkqJgv+T75wKonvii9XtWBPYvr9tdYfSiZSqgA=;
        b=Cl8XwVLwpyF8BLsj/iKT9Gqukk4k2rgHpiKVqpa442LHw5qIcccH87J3Qj+b6kXK24
         jPv7Ym7jwcyYnrJjACFsQIrUjfUWeWNHQvza4E6ptvq4oRIowFw+fAZN/8Z8e1TkPbuk
         cOW7EkVy1bcslRwJz+cnhfVtrlqbDjw5X3gVe5Vqi+lYK9Dz6J/ooXmkUJ54FSo1WuL2
         n0AqXGXvkPW4fYXdP2Vnub1O2O1nK2H0Co7TMykJvmF67jFvfG7WwrynOJTmBXQxPA+P
         H7ZbWz/MZh8N17Qf1fBjFlvzvqfJ9bRK9JGomZHsYDcKZDtepFmdXuxlpf4TQQtMNVHG
         KGRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783176150; x=1783780950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hO7xVm3JMi+xvznWIzbCWLHGJef3ve9nJtp5Srpwow=;
        b=Li6WiCbNOvc9ahPrkT1co3mKd7NdYhIuiCEHiqkrr/k8cpMAxKLFXx2nBwhg+newWq
         BgRhvm6Fp2FsutzhydMzHY17stSZzgLOPwc2s8UPtGFl7azqpU9RlgLUmvAoD75DkteX
         4dBHqjaWJQ/wMYvUXTRcQJwEYF5rIRuYC1XEAMzGJyZN16WjUs7t0PACfEZq9gl2QLBD
         TwaXqZKsT04cywkPNLAbTk4KhU8YJxQwZqb/BCDTHuTMVtdQFmkIjlrbO2WHzm7Yj/vu
         BMaIhx0cdlf0RaMy9vpegsR2wUdOztnJnNuB6Jlh/PzA3sPmEWx2nTDvP/3wEd1mDnLs
         5jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783176150; x=1783780950;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hO7xVm3JMi+xvznWIzbCWLHGJef3ve9nJtp5Srpwow=;
        b=bAO1twZsqGoOPOWCZMMUHcYrFjIpH5Ci0XS58ir8pgErseHhE14oMvA18O4DfRAx2X
         cZnLZpDPu0wb0pVnmMndwfgGleq1CDM1SHBbk3SUiMZpfArudeFfLShC9pGnS7wV25n8
         4oz5uKVnWW3AnvnNuUpvSIgqmIDDuTKLACtNiIfXJntvoIzqq7D9M49RKcrKivaTH0hu
         +mFBHNkfwMoGujNtm2R4jkzKVelPLkF/Nh13kTtwJkj2G90YTiomhISrXDETrPEpIDfB
         KTkZI7bHrkklmtD/Ms9gKC2dj7lLaCr35uibp94XttlQY7LuPnDdwTk+u6wZJ+2/fUf6
         K8lQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrDiNuJgK7dg+mZ/bNSccYXOYlDp1iB3JaMFIjkxIvKx4OdQThNesWyrNvc2gf4hUNC7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvAwp0kpYLWgaJqwCHXkbCclZjyy65woUJJUR+IfCMBXaBf8R
	e0VajbypYRxQYikCsZsDkOSsf/4AMDYtdHpMdaG29EgKD+zHDwoGNFaeWlGfFQtmIo16BB73bao
	64t+cwnKDBHtO6TgQPxx97HG5mthEx/P7hlLAsJHo
X-Gm-Gg: AfdE7cn5ubP9WqacqEIjH46tQz2p2Zdph7D6z9PUSIzzug/+Ua45go/r2yR+4PisJXy
	syyF8rVBM2APdLZ9heQs7H+M9xg6nTh1k2GQPvXilykqi21xVKq9hPaTCZlAPA80bhf/HahJQ1g
	8wzpxm2OtD3tNN8nEe/tlOnV9pxv3qW9S/jL/ZD7LD91lILma1RpSOzfd3CqgkPK1QgBAvGlIlW
	8UxSvgq2qofAd/AZjhcizZ41zuiumQi3oA02zxdAt4LC6uSba8JJclOiZe2DF1tueNP+oQzLTzI
	5QHx96hJgW3b5Dtp6SkqzFyn3HVSpRcpNCniuVo=
X-Received: by 2002:a17:903:b8f:b0:2c9:ed16:8d8d with SMTP id
 d9443c01a7336-2cbb9eededcmr35313175ad.38.1783176149804; Sat, 04 Jul 2026
 07:42:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:42:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:42:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-21-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-21-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 07:42:28 -0700
X-Gm-Features: AVVi8CfswepA6TmyRRV0hFxy-bS0yysLNcHLp77b3888QFULsM5J1mmJGvtogqA
Message-ID: <CAEvNRgGgTkOPWELeg5U3pjjw9NZOBQ5zswWy=MRxOXsUXXuFhQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on TDX_INTERRUPTED_RESUMABLE
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Add a helper to handle SEAMCALL return code TDX_INTERRUPTED_RESUMABLE.
>
> SEAMCALL returns TDX_INTERRUPTED_RESUMABLE to avoid stalling host for
> long time. After host has handled the interrupt, it calls the
> interrupted SEAMCALL again and TDX Module continues to execute. TDX
> Module made progress in this case and would eventually finish. An
> infinite loop in host should be safe.
>
> The helper is for SEAMCALL wrappers which output information by using
> seamcall_ret() or seamcall_saved_ret(). The 2 functions overwrite input
> arguments by outputs but much SEAMCALLs expect the same inputs to

Did you mean most instead of much?

> resume.
>
> The helper is not for special cases where the SEAMCALL expects modified
> inputs to resume. The helper is also not for SEAMCALLs with no output,
> do {...} while (r == TDX_INTERRUPTED_RESUMABLE) just works.
>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index cd0948794b6c..294f36048c03 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2084,6 +2084,29 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
>  	return page_to_phys(td->tdr_page);
>  }
>
> +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64 fn,
> +						struct tdx_module_args *args)
> +{
> +	struct tdx_module_args _args;
> +	u64 r;
> +
> +	while (1) {
> +		_args = *(args);

Is this copying meant to ensure that every retry has the same input
args? Perhaps a comment should be added so it's obvious that every retry
will have the same input, and outputs from each retry are dropped.

> +		r = sc_retry(sc_func, fn, &_args);
> +		if (r != TDX_INTERRUPTED_RESUMABLE)
> +			break;
> +
> +		cond_resched();
> +	}
> +
> +	*args = _args;
> +
> +	return r;
> +}
> +
> +#define seamcall_ret_ir_resched(fn, args)	\
> +	__seamcall_ir_resched(__seamcall_ret, fn, args)
> +
>  noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
>  {
>  	args->rcx = td->tdvpr_pa;
> --
> 2.25.1
