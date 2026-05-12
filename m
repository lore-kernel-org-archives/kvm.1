Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12626FC5;
	Tue, 12 May 2026 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609528; cv=none; b=GyN8t8FRngLb8JMefGWO/IqNnlPgsRL2T6RT/YzJ4e4yddCOe5Acs4L6FZnvXF6jKwGN4dLXdl94LM/JRGH8K04ROtG9Tc/XyD/t89A3dsMMpgP+4YEhU0ly1MdOnQmICcU3sUa+HzxjVZN1dFSD/cqd7GaWqFiOPX/jUYWKK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609528; c=relaxed/simple;
	bh=Tav04tYNGpLRuW3FuZzh0z5AH7SKPdJxNU7pq9Nvsqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGM14iurA+nfUP1VE25h6q/g65GSsvb4e/il9JKl/jEh9m6QE5qD8LFmSPw76vpdBo7YHflg+pHKIwPL8RiM52LWgR1cI8c9TwKO0er/A+3dUeQgV52amyECtTPxu7h13ouydi6W9m+d0fDg/IZaAtWrNqFw6YuHkb+YfaZ2wTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAD/Vfth; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAD/Vfth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE923C2BCB0;
	Tue, 12 May 2026 18:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609528;
	bh=Tav04tYNGpLRuW3FuZzh0z5AH7SKPdJxNU7pq9Nvsqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SAD/VfthTEM5OhJ5Be3jlSsW1RggYEqzlvT658DwOHjZSe+6wKiOsCPxUsj7kTOCJ
	 KKhiawiX8vXx4V2Rtm3GHd/dqAzI5GHL6CIrMCWKIoFnooNZGDl4zWpbRLZoSKSUkF
	 N0S861bSfOP84WiZwOh0t2teptBA7WyvhTf6c/t0ZJlMxfaJNCZWiAgTKnbf/I37Lc
	 HfRIIvfsWseBeVaZxoPlgQJ5XOvhvTVgd4RSTAy21FdTDg0nrV8uTaMyQZArInyS3g
	 0pW9GLSQjKxWBZGzVTy2RQoBztzaRL61wgt6oTc+nPmriRvGo9VBfZ2lMA88cBOwKL
	 M3Pa/EAJN9ECQ==
Date: Tue, 12 May 2026 21:11:58 +0300
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
Subject: Re: [PATCH v2 12/14] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Message-ID: <agNtbg6wv_kjQlb7@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <e8f142c530b715c6d45475230c4e35a1cfd8dbd4.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f142c530b715c6d45475230c4e35a1cfd8dbd4.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:24PM +0100, Kiryl Shutsemau (Meta) wrote:
> Add an ioctl to toggle async mode at runtime without re-registering
> the userfaultfd. This allows a VMM to switch between sync and async
> RWP modes on-the-fly -- for example, starting in async mode for
> working set scanning, then switching to sync mode to intercept faults
> during page eviction.
> 
> UFFDIO_SET_MODE takes an enable/disable bitmask of UFFD_FEATURE_*
> flags. Only UFFD_FEATURE_RWP_ASYNC is toggleable today; the ioctl
> rejects any other bit with -EINVAL. Enabling RWP_ASYNC also requires
> RWP to have been negotiated at UFFDIO_API time, mirroring the
> UFFDIO_API invariant.
> 
> Fault-path readers of ctx->features run under mmap_read_lock or a
> per-VMA lock; the RMW takes mmap_write_lock and calls
> vma_start_write() on every UFFD-armed VMA, so those readers are fully
> excluded. userfaultfd_show_fdinfo(), however, reads ctx->features
> without any lock, so the RMW is written as a single WRITE_ONCE and
> fdinfo reads it with READ_ONCE. That keeps the lockless observer from
> seeing a mid-RMW intermediate and removes the audit burden when new
> toggleable bits are added later.
> 
> When switching to async, pending sync waiters are woken so they retry
> and auto-resolve under the new mode.
> 
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  fs/userfaultfd.c                 | 150 +++++++++++++++++++++++++------
>  include/uapi/linux/userfaultfd.h |  14 +++
>  2 files changed, 136 insertions(+), 28 deletions(-)

-- 
Sincerely yours,
Mike.
