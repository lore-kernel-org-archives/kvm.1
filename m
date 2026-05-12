Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39CD385D6E;
	Tue, 12 May 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607716; cv=none; b=ZHkndqTjo+0LHpISWls1La2TXp3/2Iu1AHhjDBNM631IZorfTOGpOhOOPoYEIz/LBqq7yDqAQqmxiVuLFMmtM4WdUD9/e30C1o+Gq0NFWfCgqhhN4/wfIp5/HWvPadh8tblB3rHkzJec7A4omm+32eG9KzuLy6ePs4o5+hxdVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607716; c=relaxed/simple;
	bh=gjIHcTn2SNVbfTdFwDqfeJDol/cMiaN3wAL/qdYHzDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgwhPmlrsZDB4pj+/aPmTg2MOgXeA1d2lX3WS7xFGAggfaki66g5MK+vWhHpAsjZA77cZPXg/ErmJMjeVbkQ8f7LJ2Ra/A59mYSv4f0+VI0mUlxBgJ9nXu7nwVSG6wqeI1nMincuHIJZsaJZm5b+LIavaJWiB2rYkTXacWlVqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9oJ3s7+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9oJ3s7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8B2C2BCB0;
	Tue, 12 May 2026 17:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778607716;
	bh=gjIHcTn2SNVbfTdFwDqfeJDol/cMiaN3wAL/qdYHzDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9oJ3s7+soX7DYUyP0ESJXspaTPr/B47iWffX9FN8OBabt/l9iSOyTpR9uJ9+XaNS
	 IlnC7UL1NcTV73iIbeiayXFZP3AjjaJnWQWjduFuRpElSp6QJmlTtANDaATUIxQiB5
	 xWl1vUW+5u820yiGZaCnwMNgiuTXNYg7Y77csk35pMuVxlBq4F3NBCu5jUT5PQeCYq
	 0nxM2HF9q1cW5tjceh+u7lxbOzzlQ6JcSV8pTf6VJHKI7wFB9/5qmQ0Tw5uAvpDbE2
	 cOraQLUE0qHVrlC/IM9838zgCjXQj00KtdwWOTmeSaXrIrq6CBfbGyXWua3l0J8Xno
	 fCg7HUOF45JKg==
Date: Tue, 12 May 2026 20:41:45 +0300
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
Subject: Re: [PATCH v2 10/14] mm/pagemap: add PAGE_IS_ACCESSED for RWP
 tracking
Message-ID: <agNmWUl-_6HE2yPh@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <c076bf8d482e80512b0b1db0e107ef0c822c5ddf.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c076bf8d482e80512b0b1db0e107ef0c822c5ddf.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:22PM +0100, Kiryl Shutsemau (Meta) wrote:
> PAGEMAP_SCAN already reports PAGE_IS_WRITTEN from the inverted uffd
> PTE bit, targeting the UFFDIO_WRITEPROTECT workflow. UFFDIO_RWPROTECT
> reuses the same PTE bit as a marker for read-write protection, but
> "has been written" and "has been accessed" are distinct semantic
> signals — they happen to share one PTE bit today only because the two
> implementations share infrastructure.
> 
> Give RWP its own pagemap category so the UAPI does not conflate them:
> 
>   PAGE_IS_WRITTEN   reported on VM_UFFD_WP VMAs,  !pte_uffd(pte)
>   PAGE_IS_ACCESSED  reported on VM_UFFD_RWP VMAs, !pte_uffd(pte)
> 
> Both still read the same PTE bit today, but each is scoped to the VMA
> whose registered mode makes the bit meaningful. If a future
> implementation moves RWP to a separate PTE bit, only PAGE_IS_ACCESSED
> switches over.
> 
> This is a UAPI narrowing. Outside VM_UFFD_WP VMAs the uffd bit is
> always clear, so PAGEMAP_SCAN used to flag PAGE_IS_WRITTEN on every
> present PTE there — a meaningless duplicate of PAGE_IS_PRESENT. Now
> PAGE_IS_WRITTEN fires only inside VM_UFFD_WP VMAs.
> 
> pagemap_hugetlb_category() now takes the vma like its PTE/PMD peers.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  Documentation/admin-guide/mm/pagemap.rst | 13 ++++-
>  fs/proc/task_mmu.c                       | 73 ++++++++++++++++++------
>  include/uapi/linux/fs.h                  |  1 +
>  tools/include/uapi/linux/fs.h            |  1 +
>  4 files changed, 67 insertions(+), 21 deletions(-)

-- 
Sincerely yours,
Mike.
