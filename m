Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921206;
	b=ojTOZYbxLDRS9SqDHZamuS0UeabVSI6v9MWpOuFZ8N7doQQUCHXmDI+H2zh/842D0uig
	 AWw+OvN9viddtVSvVqEbZz5/wBf09kLp1tEYJS/U5v0tW4BmmNOlx92pCUZZ9aiOynyWk
	 FusNxYvSVFjcYYzqnWpzEs6uGDbTvCaQi9o+noEhFUUZ71LHGnI1gjxdEfxuSbRbDMJOE
	 qX0WSogu8dGWo0Fip8De5wc1+9DzgFleWCdq57RUE/MoXnKd1C0q5IysHqK8DTGEEe25C
	 VMTPQvtCsX+n3JogJOqZndiH19KjMm5ks2wwcH7g2OyAAO2fw+m4AhwYRyUItuQXckg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921206;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zs1gBpLlBJQJQ4QsuHo/kh0DAnV2azdLI6aE2HoNP18=;
	b=z0d2den2MX8wvgS93PdnqZcoJB9zKMt7bY9eRi/L6RYlzuee/jSuhFCstiiP4uc3eM3b
	 UgKfI60Kp1buWdNEVQ75B1xIGXXCpcAdjeFCPbzTcmC6uxZ375Nk648gyeXbxElhRHJuH
	 MeYAjtapBzXxYHrDCNYGljOr3XSIWEzMeJ9yUh0qRUjAFibJzIJCpaUDrzqpw21BZnw6K
	 qPexyChdQuJxM90k6kumd/4eYirMC64GeKPymtuv31rEIK01WXXSeTlVub6+URJAUjXXR
	 2B8oKBg9kzcONdCaa/sY+zgiYAe5FznTL+II7ymzSmz8WvA0+bBEe8f1yycz1//xJyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDeyxXKS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2F606A31C;
	Tue, 17 Nov 2026 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDeyxXKS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC081F000C4;
	Tue, 17 Nov 2026 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921206;
	bh=zs1gBpLlBJQJQ4QsuHo/kh0DAnV2azdLI6aE2HoNP18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mDeyxXKSfsP8V86bwwY97CatYMYW0DqD/RTamw+h5+5FuzTY6MTNPYq7wtfYoTeyK
	 E0rsY3EETecgg8OoC16QWX2AbpellNCWgBEOpgo/q70WnO9Vi8b7jRI0rW4C9VI0Cr
	 uJ/dTS943YC3kU0TVTPL+CX49iTpIZBysZPMYEhcppHsuDIzaZFMen1nbBQ/IRJXUn
	 oNcyhMclCYZPCNlY2GHy4Ds6oDOiRzHHKXp7XrGgH58VW9ycyUQ9pOqgaYzafLdqK+
	 jkO1WMc7feKiHL4HfEPuuC4BW4q4HsswXUVBiErlU6smaTxW8laKDneyx3nKF6tOxd
	 hPVIVU9k3lYyA==
Date: Tue, 17 Nov 2026 13:13:21 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 2/2] KVM: Skip gfn-based MMU notifier invalidations
 for guest_memfd-only memslots
Message-ID: <avxSfTKuCc1vpe2B@gremlin>
References: <20261117011513.39419-1-seanjc@google.com>
 <20261117011513.39419-3-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117011513.39419-3-seanjc@google.com>

On Mon, Nov 16, 2026 at 05:15:13PM -0800, Sean Christopherson wrote:
> From: Alexandru Elisei <alexandru.elisei@arm.com>
>
> Don't invalidate gmem-only memslots when responding to MMU notifier
> invalidations, as the entire point of gmem-only memslots is so that KVM
> doesn't need a VMA to install mappings into KVM's MMU.  Specifically,
> page faults are resolved by going straight to guest_memfd, using the gfn
> and the associated memslot's gmem.file.  I.e. whether or not userspace
> happens to have valid mappings to the same gmem instance is irrelevant,
> as are any invalidations for those mappings.
>
> Note!  The exception is KVM's gfn_to_pfn_cache implementation which isn't
> yet wired up to pull pfns directly from guest_memfd, i.e. still relies on
> userspace mappings/VMAs and thus need to be invalidated, e.g. to ensure KVM
> doesn't retain a kernel mapping+pointer to PRIVATE memory.  However, as of
> commit da260bcb56fe ("KVM: pfncache: use a dedicated invalidation sequence
> for cache refresh"), GPC invalidation no longer relies on memslot lookups,
> because GPCs also support HVA-based mappings.  I.e. KVM *must* be able to
> detect and handle relevant MMU notifier invalidations even if there is *no*
> memslot whatsoever.
>
> In addition to the obvious performance benefits, avoiding unnecessary and
> spurious SPTE zaps and TLB flushes will allow KVM to support features like
> ARM's Statistical Profiling Extension (SPE)[1] and x86's Secure AVIC[2],
> both of which rely on the pages *never* being unmapped from the stage-2
> page tables.
>
> Link: https://lore.kernel.org/all/20260903160623.315525-1-alexandru.elisei@arm.com [1]
> Link: https://lore.kernel.org/all/cover.1783490022.git.naveen@kernel.org [2]
> Cc: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Cc: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> [sean: rewrite changelog to capture the new gpc behavior]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM, thanks Alex and Sean! :)

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  virt/kvm/kvm_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 9938b753948c..f0d95e8c37f4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -601,6 +601,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
>  			unsigned long hva_start, hva_end;
>
>  			slot = container_of(node, struct kvm_memory_slot, hva_node[slots->node_idx]);
> +
> +			if (kvm_slot_has_gmem(slot) && kvm_memslot_is_gmem_only(slot))
> +				continue;
> +
>  			hva_start = max_t(unsigned long, range->start, slot->userspace_addr);
>  			hva_end = min_t(unsigned long, range->end,
>  					slot->userspace_addr + (slot->npages << PAGE_SHIFT));
> --
> 2.56.1.703.gf848ed807c-goog
>

--
Cheers, Lorenzo
