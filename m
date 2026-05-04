Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88592E040D;
	Mon,  4 May 2026 07:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881126; cv=none; b=Ko+yPOO4uP0G0zNecjFdqvCwy8EIVvYuzMPLL+U/DlKdl7blVSh/u8N6W5TDpU3liC21B+SC9WeXLX3X3NR2LvRX9aUHERh/Km9BwlsrRdfDw0qwuAplYqXygeR3dOmTFGuDzNkhN2xuX0c0+4XZpttAf7P3XAhFCQGrSbl3cKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881126; c=relaxed/simple;
	bh=JAZP0VOjK8IWWwLxaA6mVGJfOv+HCV3E8PZjNZL9e48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a//kQXOxK7X2UR7cWSKDu5iG7iJdGnbjO+BuhPMDl6VI2XoCURaNUDScukAxzUOwvgeNMZH88/h4WWVnQwy9k8TEjqEB3Yc0pO4WOI8a6ssivIUYBoBrEx5mB47hU16riaJamD4dxcHME9uX7jErvx9CufrNotVFy5MIbH4xz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0Ior458; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0Ior458"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACBAC2BCB8;
	Mon,  4 May 2026 07:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777881126;
	bh=JAZP0VOjK8IWWwLxaA6mVGJfOv+HCV3E8PZjNZL9e48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0Ior458+826MxxYajg8HR0bjSFxuUwS3Nf9kiAi2a/JGmfCYN8qf+G+Vry8JIdR1
	 Jx5fSuZJjo1zQEJ7jHvSGj61vq15Ouq92kAYbbiXnslEXWhuLH2f+Ui8aVdYs6P56n
	 J2Tpp7AHZzHec8lj0hq6Ej4EQ8h9DIAc4VHpYvf3vHx7z6GDYaYTZ5qWTTZRXcgKYs
	 b9pL50XSXLOBzxEtOs4rtAFI+TK2wM6NgPhaEkt4pp6HAcXhrPEuasbZ86sFD6b45F
	 kio9wDn04LWHISRVcqC2GICZIn+agnQpZ2kX9lY2s+edyQqCwDgWzbqg0jQC4PGpA4
	 amMFHz69ELOQA==
Date: Mon, 4 May 2026 09:51:54 +0200
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
Subject: Re: [PATCH 02/14] mm: rename uffd-wp PTE bit macros to uffd
Message-ID: <afhQGs1Y4vwtRVEH@kernel.org>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-3-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427114607.4068647-3-kas@kernel.org>

On Mon, Apr 27, 2026 at 12:45:50PM +0100, Kiryl Shutsemau (Meta) wrote:
> The uffd-wp PTE bit is about to gain a second consumer: userfaultfd
> RWP will use the same bit to mark access-tracking PTEs, distinct
> from mprotect(PROT_NONE) or NUMA-hinting PTEs. WP vs RWP semantics
> come from the VMA flag; the bit is just "uffd has claimed this
> entry." Drop the "_wp" suffix from the arch-private bit macros so
> they reflect that.
> 
>   x86:   _PAGE_BIT_UFFD_WP  -> _PAGE_BIT_UFFD
>          _PAGE_UFFD_WP      -> _PAGE_UFFD
>          _PAGE_SWP_UFFD_WP  -> _PAGE_SWP_UFFD
>   arm64: PTE_UFFD_WP        -> PTE_UFFD
>          PTE_SWP_UFFD_WP    -> PTE_SWP_UFFD
>   riscv: _PAGE_UFFD_WP      -> _PAGE_UFFD
>          _PAGE_SWP_UFFD_WP  -> _PAGE_SWP_UFFD
> 
> Pure mechanical rename — no behavior change.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm64/include/asm/pgtable-prot.h |  8 ++++----
>  arch/arm64/include/asm/pgtable.h      | 12 ++++++------
>  arch/riscv/include/asm/pgtable-bits.h | 12 ++++++------
>  arch/riscv/include/asm/pgtable.h      | 14 +++++++-------
>  arch/x86/include/asm/pgtable.h        | 24 ++++++++++++------------
>  arch/x86/include/asm/pgtable_types.h  | 16 ++++++++--------
>  6 files changed, 43 insertions(+), 43 deletions(-)

-- 
Sincerely yours,
Mike.
