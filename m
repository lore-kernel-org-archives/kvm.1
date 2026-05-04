Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775512AD16;
	Mon,  4 May 2026 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881586; cv=none; b=c7wEptD6wbTAOlKCDQ2+NY35zyh9pd/5lt1Cys4HyOA6PtjEkUuZFhX6ONZmAqj7cEeR6R7537gUAYAkCwb5mgEJGqXfRoyINiIKhEwf+vK0PwWS0aoSAiS+4YYmeMWvBq1neHtxHwaZp8iJbcPLBX7SAz/4CgFRLKzHIDnpwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881586; c=relaxed/simple;
	bh=Z0FyTKWUyHMmgU1F1HDPTlLvaTh3LvI2R4javIhne/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3WZhjzxYV5R8vN7PmlrVotv3gaRcBes4fAYRPfMFJgsaqYr/2jOYxQfq/6xp0j5++nGNRMMWPHGgPISZbEOMgEFEoUXnmw007I2EcLkc42L3kcP6x63gw1pj4na/TGN4TxJEvjuh7tnGEqeVEwCSgUZSiIugQCql+CJ6gzxnH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp0I8n21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp0I8n21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E5C2BCB8;
	Mon,  4 May 2026 07:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777881586;
	bh=Z0FyTKWUyHMmgU1F1HDPTlLvaTh3LvI2R4javIhne/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xp0I8n21lr/oh/1fyZjtCkraLJGJfkjbkamlq8icE+MNyykgTJm8mK+cCtsG9Su31
	 IViW5lB/u491Dwd9UKoLItqOts9bb6WPZiBaU5iYUt9GM/pzIUVM/LKy1qhY0Qk4ql
	 NjrmnqCF0tcZewXQenlKO9rbPWp/hz0JwbRnvR3Hld4yuKTmzTvLfzbsq6U0//I1KJ
	 Eh7jhQCsOwYfCsb8rLFpnQu+VHhIHUPz5hVPXpNSXi0VjZLBOKtHBAFVHYKeXdxoPg
	 dzU7ijHO8/ZH2GCO0gLWnU/O7U+Cu682DdgAbvCSPM+Eb/XUbP5RSLtcc0VnOwr3pE
	 FgRwhLWt7Kp0w==
Date: Mon, 4 May 2026 09:59:37 +0200
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
Subject: Re: [PATCH 03/14] mm: rename uffd-wp PTE accessors to uffd
Message-ID: <afhR6VvypoFQqDzL@kernel.org>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-4-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114607.4068647-4-kas@kernel.org>

On Mon, Apr 27, 2026 at 12:45:51PM +0100, Kiryl Shutsemau (Meta) wrote:
> Userfaultfd RWP will reuse the uffd-wp PTE bit to mark access-tracking
> PTEs, alongside the write-protected ones it already marks. The bit's
> meaning now depends on the VMA flag (WP or RWP), not on its name.
> 
> Rename the kernel-internal names that describe the bit:
> 
>   - pte/pmd/huge_pte accessors (and swap variants)
>   - pgtable_supports_uffd() capability query
>   - SCAN_PTE_UFFD khugepaged enum
> 
> The ftrace string emitted by mm_khugepaged_scan_pmd for this enum is
> kept as "pte_uffd_wp" so existing trace-based tooling keeps matching.
> 
> Pure mechanical rename -- no behavior change.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.
