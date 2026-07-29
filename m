Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECDB453A32
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342348; cv=none; b=quNqcQEO3m+BR4y+E8iP7EY9ts5A5pJ/FzRVd2z3X2F3ertubtb+gXvbBSvtqQwdBmk9U/R+duHxWl2G0Z98GDTJ5DrwTq+9UhI6tCmUY+DF5mZzkyVu9NczDSZz1kGyQunxCn/KWixvDUJsZrxSIXBNjO+dpR5VA/ignwe7FEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342348; c=relaxed/simple;
	bh=1+R3U4GhR4LxVdqvm8mxsj7zocrKAwppHZHtKcHPL1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJr2MNy2kW9er+MgAGoYvKYSi5VKEq1fzj/UIQMIf2JoLOWAUgCBR3oVmEc0iK640JqrkzaqweAioJ2teE3mM9kHBSG+Sxhn7pEj8/dtOqe2YaZWdcCJuoHkRcqMN9g3KvU1FmbGayyKQC0tJmHq5dURe5vJVPkbgrrs0SCjBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K8eJsC3b; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K8eJsC3b"
X-Forwarded-Encrypted: i=1; AHgh+RrmdQPMVEbRFmIJ4yF42B652JSCJHHGdT+WwZfEC2H35DXNPB3JFm+2QWoq5c16sZss46A=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785342343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I7xKPnebnrnj3oQ7O4pCZSku+N29w0+f4UqiJMIJTas=;
	b=K8eJsC3bhm5ekDmTY10vtcPjRGYPIEkGW8+AVL0CvTPgegjNVmp241mDDBWpm6QeaKOGbM
	o3MNxCX2sNhEQ4XLdxvFuL633LMFazNFYpsMmNZV53WFDzGEyX81MhFw0KQ7YgKRG0Kptq
	D1QoPKTWqF/wSMEwtFZwKUOSpZkQKEY=
X-Gm-Message-State: AOJu0YxGzBA05HADLclYn58QN0FjQD4YmcyV/1KWU4fDBG7ZbCTZNug9
	f7uif+IPS2s46bHVYJZVL+eB97wU/amYTDpEtkm9Cfy6nwexLiBd/GLC6OqB/SdMGcWT3zTdQcF
	N5cZoXoNRbSEOJercHCrNz1fEDfgzqtSYPH2N8B6J
X-Received: by 2002:a05:622a:411b:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-52b350e5b35mr1825161cf.5.1785342329701; Wed, 29 Jul 2026
 09:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-hybrid-v9-0-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp> <20260720-hybrid-v9-9-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260720-hybrid-v9-9-2b713ca1b5dc@rsg.ci.i.u-tokyo.ac.jp>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 29 Jul 2026 17:24:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy1O=Hnw16vKL813sCpjBV7j61jr+BU+9G6dvVePNSwAA@mail.gmail.com>
X-Gm-Features: AUfX_myMVHKAsG5Q9-sL8f-xMHSuN9ptYr1gLGLLFeAl95SgQeRj9hCI0TZ8ETs
Message-ID: <CA+EHjTy1O=Hnw16vKL813sCpjBV7j61jr+BU+9G6dvVePNSwAA@mail.gmail.com>
Subject: Re: [PATCH v9 09/16] arm64: errata: Require Apple IMPDEF PMUv3 traps
 on all CPUs
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devel@daynix.com, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Mon, 20 Jul 2026 at 06:39, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> KVM relies on ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS as a system-wide
> precondition for PMUv3 emulation on affected Apple CPUs. A local CPU
> erratum is too weak for that: once the workaround is enabled, a late CPU
> that misses it may still be onlined.
>
> Make the workaround an all-early-CPU capability instead. The matcher is
> still local because it depends on MIDR_EL1, but the capability is only
> advertised if all early CPUs match. A late CPU that misses an advertised
> capability is therefore rejected.
>
> Although kept in the errata capability table, this capability describes
> optional trap support rather than a workaround required for safe CPU
> operation. A late CPU may therefore match it when the system does not.
> KVM treats an IMPDEF PMU as unimplemented unless the capability was
> finalized system-wide, so the additional trap support remains unused.
>
> Fixes: bed9b8ec8c71 ("KVM: arm64: Advertise PMUv3 if IMPDEF traps are present")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad



> ---
>  arch/arm64/kernel/cpu_errata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 1995e1198648..a5ae628204a1 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -1005,7 +1005,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>         {
>                 .desc = "Apple IMPDEF PMUv3 Traps",
>                 .capability = ARM64_WORKAROUND_PMUV3_IMPDEF_TRAPS,
> -               .type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
> +               .type = ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
>                 .matches = has_impdef_pmuv3,
>                 .cpu_enable = cpu_enable_impdef_pmuv3_traps,
>         },
>
> --
> 2.55.0
>
>
