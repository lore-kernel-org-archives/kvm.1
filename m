Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921079;
	b=Pb/LiK/uNWMkQCy9kbe4d18vVeGWnXALj3iAjWN5oRfbKa4P3rQbszbFWr2XSLbhAFT+
	 Tn9Aff/7tBRDkSGx94EDOHTJ47C/w5WdNr3J7grApy7563E3R/BmBk87jOIPIcDwQqmvw
	 IIK6R9x4heDps0PYUtzc2Ke1eKIaeiq8S3vbSfLTEGyxQ/PGbrcygRDCafyrsj4vLgns7
	 p/K7F+uNN9nB86rc5R+opYTtyCPFoS677j182oPqyRWJ1kOR9klPtHJ/48VVdEhawC3bl
	 IBS+/sTeA3bq323FUgAIK30zStXItaOmq+GMe5scvlokTYHdMYvUjAR4//b3n16LxGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921079;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6n2douVgcE4vANCNGbrlWLWJHzybROhZeQr26v8BZtw=;
	b=Dm/mqJvbX+UT7aajg9HpHhdqSDwdDHcmzpXncMGHAUH6/OQuPW94L6ygFHZCARZlcDDP
	 6wTAuqZv1I0vNPmBQ4ocFULobhfyV6IF0maytlYrKlZj1eWuPQI3X4LzeI5b/oiyvqUNg
	 ovmqyuXwKuUezCrqgpYIqXHLdo0dgawxmcgGLbfDUuyX82JYjjvud0eaLjiaj6stW5P71
	 NKGbGN/B/adQbGE0dxP28Y+E9KnqII/SUCujF+qKWmDCWV7e+EyJzRAU5JlVP1MuYKria
	 mL8BYBLANvO8ky/4pblpGEI3+0fANSaolp/YRSMDpxT4blowBspILgqQ47hX97ZRplw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYQIsXtV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3009606A31C;
	Tue, 17 Nov 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYQIsXtV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612831F000C4;
	Tue, 17 Nov 2026 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921079;
	bh=6n2douVgcE4vANCNGbrlWLWJHzybROhZeQr26v8BZtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BYQIsXtVevlFl8WCQNTTn97LeHyd6IFu5K4u0/lyAkgwNk5tZyhG0rcdbNovyyMfE
	 f2YRzPQrlYyN9139S2zbp1h8RI/BsakRwtcdgqWgRbCdtTOXQ2iPoDvKk4Ils5RHJP
	 xVQr7kNYNOsQtdACQyZJM3I8kTGGfD+vL9GSKv6ZRMT7wwKXVwnV0PYFXFKGaCxTkj
	 xt66cPBauCsxQW70LwVrWdB8O6aYLY63GCpuKta638c/PE196O5nxExYfruOX13ESd
	 6Tx39YxsEwGBRnBZk9w4HjDC3rn3LWCGmLNiCvd+rzjbar7dNP6nneG4YpFtRNTeZb
	 qT9EwvnBRO+VA==
Date: Tue, 17 Nov 2026 13:11:14 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko Bot <sashiko-bot@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Subject: Re: [PATCH v4 1/2] KVM: Disallow prefetching PFNs (for SPTEs) via
 VMAs for gmem-only memslots
Message-ID: <avxSaMHas9hwZH1I@gremlin>
References: <20261117011513.39419-1-seanjc@google.com>
 <20261117011513.39419-2-seanjc@google.com>
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
In-Reply-To: <20261117011513.39419-2-seanjc@google.com>

On Mon, Nov 16, 2026 at 05:15:12PM -0800, Sean Christopherson wrote:
> Disallow prefetching SPTEs via fast GUP, i.e. by VMA lookup, for gmem-only
> memslots as the whole point of gmem-only memslots is that KVM MMUs should
> get PFNs *only* via the direct guest_memfd interface.  More importantly,
> this will allow skipping/ignoring/eliding mmu_notifier invalidations for
> gmem-only memslots, since it will be impossible for KVM MMUs to have any
> mappings based on the to-be-invalidated VMA (as is intended).
>
> Fixes: 576d035e2aef ("KVM: guest_memfd: Track guest_memfd mmap support in memslot")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-213282@kernel.org
> Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Closes: https://lore.kernel.org/all/avdAIMDfgL_wy1rx@gremlin
> Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

LGTM, thanks! :)

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  virt/kvm/kvm_main.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cf4cb586f140..9938b753948c 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
>  	unsigned long addr;
>  	gfn_t entry = 0;
>
> +	if (kvm_memslot_is_gmem_only(slot))
> +		return -EINVAL;
> +
>  	addr = gfn_to_hva_many(slot, gfn, &entry);
>  	if (kvm_is_error_hva(addr))
>  		return -1;
> --
> 2.56.1.703.gf848ed807c-goog
>

--
Cheers, Lorenzo
