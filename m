Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857283EDE4A;
	Tue, 12 May 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609160; cv=none; b=ZA0a+WTWMffYefekgKvcXSdCNbb/rRoZKS+LeRYYRIqErqPe4fgZ8FSqBBYeZ1evv/3Jn5zbrUMWOyRLH5DuDt9YsNHYWdrA5dSyeV/5M8TUbo5OO0cmToD5OII2oQ5XKHQ1Rsm3udgedRx5j8ImXYeyfDUI/rKMi8492TYA0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609160; c=relaxed/simple;
	bh=AYu98W2noPGRCAXmjPXNfD4nbNYQUNSkC3qget5y6aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaP/KNKu6V26vz+t1aC+B6gqHGrE11LUuxDsi2LR5Mu9x89xYptF4MBG1qtYNjNR/egN+yKZRG2JoeKOmC7CQFSBFnm8u6XroxOUH3FB7jg+zId5lxzwfs6hkvJD5y+0hwUIqsjLiCKOlbz8YzjUMnW3Y3SG4UZa0Hsf51ITvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2hOsi3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2hOsi3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1B2C2BCB0;
	Tue, 12 May 2026 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609160;
	bh=AYu98W2noPGRCAXmjPXNfD4nbNYQUNSkC3qget5y6aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2hOsi3q4965f7axog9kWMtNo0/m+PWVhj0F4F7Uasmfkhj891Xl17nrDooQtvb2Z
	 UV71TvtXUrVJHe98zWTjvueoEwao2vuZvuw03uwWIgtXjQR4gHoyuI14DMx0M2ZC9J
	 h2V1tuyqApv45WHiQ2P9ow2rELQ05Bs0eSdAZuvQg587efpiPHqMmmkUXFwRcxfYYp
	 oyoFO5nAFOJdQr3XO2ghNQsWl4Qu9S8v9nnM9kIaZFCkGKRBnn/P0CtSLal4n1zO56
	 zRYnmM0m+SReIJSpESAz5KORlu2zmbD6ppHNcz8SJoZ2bTBlff1kpqetZa2vkMjXvO
	 LWCUubSAx5Dkg==
Date: Tue, 12 May 2026 21:05:49 +0300
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
Subject: Re: [PATCH v2 11/14] userfaultfd: add UFFD_FEATURE_RWP_ASYNC for
 async fault resolution
Message-ID: <agNr_cS0DygX9ksq@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <65492c7b535080c7e85e90cb7ca962a52871e8b9.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65492c7b535080c7e85e90cb7ca962a52871e8b9.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:23PM +0100, Kiryl Shutsemau (Meta) wrote:
> Sync RWP delivers a message and blocks the faulting thread until the
> handler resolves the fault. For working-set tracking the VMM does not
> need the message: it just needs to know, at scan time, which pages
> were touched. Async RWP serves that use case — the kernel restores
> access in-place and the faulting thread continues without blocking.
> 
> The VMM reconstructs the access pattern after the fact via
> PAGEMAP_SCAN: pages whose uffd bit is still set (inverted
> PAGE_IS_ACCESSED) were not re-accessed since the last RWP cycle.
> 
> Worth calling out: async resolution upgrades writable private anon
> PTEs via pte_mkwrite() when can_change_pte_writable() allows, mirroring
> do_numa_page(). Without it, every re-access of an RWP'd writable page
> would COW-fault a second time.
> 
> UFFD_FEATURE_RWP_ASYNC requires UFFD_FEATURE_RWP.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c                 | 19 ++++++++++++++++++-
>  include/linux/userfaultfd_k.h    |  6 ++++++
>  include/uapi/linux/userfaultfd.h | 11 ++++++++++-
>  mm/huge_memory.c                 | 25 ++++++++++++++++++++++++-
>  mm/hugetlb.c                     | 32 +++++++++++++++++++++++++++++++-
>  mm/memory.c                      | 27 +++++++++++++++++++++++++--
>  6 files changed, 114 insertions(+), 6 deletions(-)

-- 
Sincerely yours,
Mike.
