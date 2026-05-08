Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D9833B6D5;
	Fri,  8 May 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778284334; cv=none; b=NeFGzJT+1U247Dm5m6fnbs+01nKRxSfokQ5x8strwebWhOmij5qeW5I5xZaWlmV9G5W3IE0dE2yD+09CoYwp8nR40ua0FcgKs1BimfIWxWVFRkmEfrfD383GBXh0p+M+HnPVow7fsKTWZBPYs8AGeLPaVexWoY4BWIFmhul2r7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778284334; c=relaxed/simple;
	bh=2A7cLXV+8i/TgBjrSYIiWz4AFId2IjKQBmgGj/uotSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mATXEtUfHPF7tU061QeAueyUV0Iv1QDCag6xWnYOmUkeJllFnq0puLyILC1Kwck2UvmIOYb0zJ9mGKeKeWu6hReSN2+z3HAs3Zy15bWrf1PhSRFj/BgztIHqU9Cqvwmenb5CdkTGaFzcdOB/GqwAhHXT1UDvQaG0PejsKI7/JGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzlh+gEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzlh+gEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A102BC2BCB0;
	Fri,  8 May 2026 23:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778284334;
	bh=2A7cLXV+8i/TgBjrSYIiWz4AFId2IjKQBmgGj/uotSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wzlh+gEPH02pq0GYd3kbFX5f87tKrnkHWpp98MiqGJXFfMQfV/FVfxGStq2n1Icxh
	 at3XXnt4W0X5Z3BEVyZ+zNybdHl56jsrlVGD7IISRFDxSOnOK9tylItg4LH/Dwj+JN
	 zM8zb1dNuY8edXE0P73MWuuL4CLFssFVFp1U4Sg8OXxbrCtiB/PrKmvvzNLjDYkYw4
	 5zbeCegoitDyNyLbDmk3XOZkd/N+64K6CRKjLX6xsQPRTQq6n7Z4X4PogvYYrswWtq
	 73U0PUOs0+g4mN0Bd/S/Qg9eEYGHWSjQbpbYkwx8aZUufBfSBBbnWnnukD3AisI5Nl
	 so3vCz59vsOgQ==
From: SeongJae Park <sj@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 02/14] mm: rename uffd-wp PTE bit macros to uffd
Date: Fri,  8 May 2026 16:52:05 -0700
Message-ID: <20260508235206.83633-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4ff3508b951ec4879177dd079003c3fa3af0a444.1778254670.git.kas@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  8 May 2026 16:55:14 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

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
> Pure mechanical rename -- no behavior change.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
