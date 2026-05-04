Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6D3064B5;
	Mon,  4 May 2026 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880934; cv=none; b=EdRS9emvfYdmInBw60HaQe5kF2CBqDrwYAXQcpTB73ANUMqS/QjwQ4sG9RjjXZVQTIHWicTkr2wMxguuB+UAc3nnDmCqyHV16FWxTi/frkjlKVFODYbgyQ8jumLno7sogEKFz+u5ecLJYD69mIx+2QsiejZ/3VGIR9uezPVTMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880934; c=relaxed/simple;
	bh=hvT42DeLxt0G1flXefxTAisAOAsIFUCaS+f6nn9KqVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU7++EDQ4jI11Ti8OA9nkSv669BWjvGPI2diX1DzJK6a6fTc8pgcGZM4WwIHBDOjmXq6OYcC/Xk2t25K0hC39MkQ1+fu7i4bM+FCgyALX4xpJpgravm9/mpRIgqIfWsMAgTGbopyH4FSxYoByEUEpJawY6Uhjli5BxZRxKcfRhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdrspOkK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdrspOkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF6EC2BCB8;
	Mon,  4 May 2026 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777880934;
	bh=hvT42DeLxt0G1flXefxTAisAOAsIFUCaS+f6nn9KqVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TdrspOkKI/X8T3QdrKzyX8KNipEz9X3bOSmaWdacC5A1e017WryZgJC9Z4MD+4VhD
	 066QFiGfp6MoC0ZlBy9OeqKoQrG0Zt2vWMiZxQI1zdJSEjCdAx0R1MspDyjrW0iJ78
	 QE0WmKsnN5Gv6gf0oOns5WDSRRV6LWU+66Yqrv3urH11sjUTLaHBgsTVRX2BU9/Q0J
	 JFE1z7/h7+/QliIq4ZH23DknBot/9Ou3dFU0R7h/IcbRLjPxwxUhLaNSV2B0cqM4rv
	 PhN/ADH/AsvT9vrkKyt0Rsrci0onnGkmQL5OsNE3jssqyE2miF+a2VzLugfhB2pJPG
	 lA/51IkPNVp4Q==
Date: Mon, 4 May 2026 09:48:41 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org,
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
	jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
	usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 01/14] mm: decouple protnone helpers from
 CONFIG_NUMA_BALANCING
Message-ID: <afhPWW52f2PtrjXj@kernel.org>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-2-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427114607.4068647-2-kas@kernel.org>

On Mon, Apr 27, 2026 at 12:45:49PM +0100, Kiryl Shutsemau (Meta) wrote:
> pte_protnone() and pmd_protnone() detect present-but-inaccessible page
> table entries. This capability is useful beyond NUMA balancing — for
> example, userfaultfd working set tracking uses protnone PTEs to track
> page access without unmapping pages.
> 
> Introduce CONFIG_ARCH_HAS_PTE_PROTNONE to decouple the protnone PTE
> infrastructure from CONFIG_NUMA_BALANCING. The six architectures that
> support protnone PTEs (x86_64, arm64, powerpc, s390, riscv, loongarch)
> now select this option, and CONFIG_NUMA_BALANCING depends on it.
> 
> No functional change — the same set of architectures continues to have
> working protnone support, but the infrastructure is now available
> independently of NUMA balancing.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

With a small nit below

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm64/Kconfig                           |  1 +
>  arch/arm64/include/asm/pgtable.h             |  7 ++-----
>  arch/loongarch/Kconfig                       |  1 +
>  arch/loongarch/include/asm/pgtable.h         |  4 ++--
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  8 +++----
>  arch/powerpc/platforms/Kconfig.cputype       |  1 +
>  arch/riscv/Kconfig                           |  1 +
>  arch/riscv/include/asm/pgtable.h             |  7 ++-----
>  arch/s390/Kconfig                            |  1 +
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/Kconfig                             |  1 +
>  arch/x86/include/asm/pgtable.h               |  8 ++-----
>  include/linux/pgtable.h                      | 22 +++++++++-----------
>  init/Kconfig                                 |  8 +++++++
>  mm/debug_vm_pgtable.c                        |  4 ++--
>  15 files changed, 40 insertions(+), 38 deletions(-)
> 
> @@ -2052,18 +2052,12 @@ static inline int pud_trans_unstable(pud_t *pud)
>  	return 0;
>  }
>  
> -#ifndef CONFIG_NUMA_BALANCING
> +#ifndef CONFIG_ARCH_HAS_PTE_PROTNONE
>  /*
> - * In an inaccessible (PROT_NONE) VMA, pte_protnone() may indicate "yes". It is
> - * perfectly valid to indicate "no" in that case, which is why our default
> - * implementation defaults to "always no".
> - *
> - * In an accessible VMA, however, pte_protnone() reliably indicates PROT_NONE
> - * page protection due to NUMA hinting. NUMA hinting faults only apply in
> - * accessible VMAs.
> - *
> - * So, to reliably identify PROT_NONE PTEs that require a NUMA hinting fault,
> - * looking at the VMA accessibility is sufficient.

I think it's better to rephrase the original comment so that it'll actually
describe what pte_protnone() means rather than remove it altogether.

> + * Stubs for architectures that do not support present-but-inaccessible
> + * (PROT_NONE) page table entries. Generic code may still reference
> + * PAGE_NONE from paths that fold to dead code on these arches; the
> + * BUILD_BUG() fallback fires only if such a reference is actually live.
>   */
>  static inline int pte_protnone(pte_t pte)
>  {
> @@ -2074,7 +2068,11 @@ static inline int pmd_protnone(pmd_t pmd)
>  {
>  	return 0;
>  }
> -#endif /* CONFIG_NUMA_BALANCING */
> +
> +#ifndef PAGE_NONE
> +#define PAGE_NONE ({ BUILD_BUG(); (pgprot_t){0}; })
> +#endif
> +#endif /* CONFIG_ARCH_HAS_PTE_PROTNONE */
>  
>  #endif /* CONFIG_MMU */

-- 
Sincerely yours,
Mike.
