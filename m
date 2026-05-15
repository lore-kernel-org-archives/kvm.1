Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF7F146A66;
	Fri, 15 May 2026 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804986; cv=none; b=iG6a92+0caHoV4Rq/C9OZ1NIjAGJP0A1LGMhEGdoT4d16uxOCJwOjv9j5OLlAv1m+WLzBDlrBqF3ak0yu4T023JQybBej03YSqKUwJnh5gBM/BdmhSYJK+1Dh3rutW2A4cNgw/DoSaqmIsvLFG2QiWJpEJ/FbRSaDh+nIl3rws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804986; c=relaxed/simple;
	bh=WbNqRyYAf+hkaZF5dLnG9kBdPrq6Jxs4l7qPgnpKjmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzF9RQ1LdgMR8xKidvIkCNpTzxJe4LhPzky15PASbxTmCjDuKGsrL2PpP0fjC6x8LQf/qNG0x7HVgpLjxn6B1jcijwdyYAJ8JFEx51gPiVxe4MO1O/ejv6PHRFx3UuGXwnmILqTkXA9pRPbOV4RgglfLDx7v/x4DL1HpyV+m0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVYp41fA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVYp41fA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824BCC2BCB3;
	Fri, 15 May 2026 00:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804985;
	bh=WbNqRyYAf+hkaZF5dLnG9kBdPrq6Jxs4l7qPgnpKjmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVYp41fAvhbcH6lzP0iL6HNSyElsHkR/Q+lCcK30GKR9H+vj/MFLMhVAd1v3csNBH
	 kCRRLysqV5YMJFMOV6lswhv3RvvBpMfR2bkseMs7x1fgO80AOzV7wFLKTSA3jxdTG7
	 4zuPMR9SAUtFtCXPf5J6eezX1IAiSYrGOKubXJhq23H6MzYOcCZNlpFyZEyFR9HoKP
	 SAFAOfpvqHOAVV5BcpOkfaMeaiZGEvbuoDtViEk8oIkwPs+H3BHTg7rUVyKBjchDro
	 vUntATzUUqvhc7aImuP5dFv32fo4BeHGidQoMpsgDOJmfeL1HQEENTFp7xigaOgRd5
	 16CGzJTwhE2yg==
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
Subject: Re: [PATCH v2 04/14] mm: add VM_UFFD_RWP VMA flag
Date: Thu, 14 May 2026 17:29:31 -0700
Message-ID: <20260515002932.124892-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b47d8d5681fd8730f6090ebfdb72f219a8edef1e.1778254670.git.kas@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  8 May 2026 16:55:16 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> Preparatory patch for userfaultfd read-write protection (RWP). RWP
> extends userfaultfd protection from plain write-protection (WP) to
> full read-write protection: accesses to an RWP-protected range --
> reads as well as writes -- trap through userfaultfd.
> 
> RWP marks ranges by combining PAGE_NONE with the uffd PTE bit, so
> the flag is only meaningful when both primitives exist. A new
> CONFIG_USERFAULTFD_RWP Kconfig symbol auto-selects when CONFIG_64BIT,
> CONFIG_ARCH_HAS_PTE_PROTNONE, and CONFIG_HAVE_ARCH_USERFAULTFD_WP
> are all set; call sites that gate on the flag depend on the symbol.
> Elsewhere VM_UFFD_RWP aliases VM_NONE and every downstream check
> folds to dead code.
> 
> Nothing sets the flag yet.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6

A silly but loud thought.  Would it make more sense to put Signed-off-by: after
Assisted-by: ?

> ---
>  Documentation/filesystems/proc.rst |  1 +
>  fs/proc/task_mmu.c                 |  3 +++
>  include/linux/mm.h                 | 28 +++++++++++++++++----------
>  include/linux/userfaultfd_k.h      | 31 +++++++++++++++++++++++++-----
>  include/trace/events/mmflags.h     |  7 +++++++
>  mm/Kconfig                         |  9 +++++++++
>  6 files changed, 64 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index db6167befb7b..db28207c5290 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -607,6 +607,7 @@ encoded manner. The codes are the following:
>      um    userfaultfd missing tracking
>      uw    userfaultfd wr-protect tracking
>      ui    userfaultfd minor fault
> +    ur    userfaultfd read-write-protect tracking

Yet another silly but loud thought.  My first feeling on this was that this
reads like 'u'serfaultfd 'r'ead-protect.  And was further thinking 'uf' for
just 'u'seffaultfd 'f'ault or 'up' for 'u'serfault-'p'rotect might make sense.
But ended up thinking this is too trivial and ain't really matter.

[...]
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e8bf1e9e6ad9..ccf534a8cbc9 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1347,6 +1347,15 @@ config HAVE_ARCH_USERFAULTFD_MINOR
>  	help
>  	  Arch has userfaultfd minor fault support
>  
> +config USERFAULTFD_RWP
> +	def_bool y
> +	depends on 64BIT && ARCH_HAS_PTE_PROTNONE && HAVE_ARCH_USERFAULTFD_WP
> +	help
> +	  Userfaultfd read-write protection (UFFDIO_RWPROTECT) delivers a

Seems UFFDIO_RWPROTECT will be introduced later.  Would it make more sense to
add this config together with the patch?

> +	  userfaultfd notification on every access -- read or write -- to a
> +	  protected range, letting userspace observe the working set of a
> +	  process.
> +
>  menuconfig USERFAULTFD
>  	bool "Enable userfaultfd() system call"
>  	depends on MMU
> -- 
> 2.51.2
> 
> 

None of my comments is a blocker.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ
