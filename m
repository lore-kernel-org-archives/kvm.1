Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94235E943;
	Fri, 29 May 2026 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017585; cv=none; b=hnaV91vJHGg7qYQ1nhuwZpVD68CIEj1AmyagoIi/zgtBTHVkVOPVvcUBfw7XeJqJfsKQ5xuWZUj6D+ZsjiWHjTYMGZddIJvG3cLX5W8ylDYYAiGJyW+cn/sUVSH1DVgx017ut+uKe16V6XC3TEAI0TGTiYFvkO5athC3IyeE2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017585; c=relaxed/simple;
	bh=QqZIPP1awhNi55+psmU3xmLHnRyV3K0pA9xXOZ+1hdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfInKvISplF6FUnLf9t7hRClsKi+mPMSEGV0uiEsvcERINMjzyFlwnOOe7IQl2dSurGcDuRGM0IrNu4dxbZRPg2mHilrWy6cscyazt9iMy8MGrV31+XdpSVMzbN2Cc+CX2us6lOB9X+MJ/M8YA5oOgNb79eH5tjqv4kJzfWmJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLzj7OCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLzj7OCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1AE21F000E9;
	Fri, 29 May 2026 01:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780017581;
	bh=Ozq/Ru3FRyhUKHioj+TdgdTtFgDpQkgRBP9R3Cod/9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nLzj7OCGbAYQphViYclXtHITMmaEevm6G40K5z5oGF8OxchRHxEKKiPboc7ARFeiq
	 E1aWmqls8XpEIW6+93ygxdQGIXL8Q3EjpR/7xVLB710yIvO6tcTx/KKn/wAc24xA/X
	 aEq1Yv9XwNS5lbmC1lexYYQDitbtWDngkVPHuUYbjpsuscfMfP5YssJ60G/ZzVSFYv
	 GMF4sAAQO96eKev9xxg6btXLcKm8b5oGv4CzFzICSsALDvTntxaScC/kNvmBua7NUz
	 RJDFb4/OeQx7kYsv9aD/BiNTS9Ar5294YKFIq/uV+B7z4ijcE2KS6aRrt4W+WAIob2
	 zz7a/yt8o2Xyw==
From: SeongJae Park <sj@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
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
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v5 09/18] mm: add MM_CP_UFFD_RWP change_protection() flag
Date: Thu, 28 May 2026 18:19:34 -0700
Message-ID: <20260529011935.8433-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526130509.2748441-10-kirill@shutemov.name>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 May 2026 14:04:57 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> Preparatory patch. Add the change_protection() primitive that
> userfaultfd RWP will use.
> 
> An RWP-protected PTE is PAGE_NONE with the uffd PTE bit set. The
> PROT_NONE half makes the CPU fault on any access; the uffd bit
> distinguishes an RWP fault from a plain mprotect(PROT_NONE) or NUMA
> hinting fault. MM_CP_UFFD_WP and MM_CP_UFFD_RWP share the same PTE
> bit, so the two cannot be used together on the same range.
> 
> Two new change_protection() flags:
> 
>   MM_CP_UFFD_RWP            install PAGE_NONE and set the uffd bit
>   MM_CP_UFFD_RWP_RESOLVE    restore vma->vm_page_prot, clear the uffd bit
> 
> Both are wired through change_pte_range(), change_huge_pmd(), and
> hugetlb_change_protection() so anon, shmem, THP, and hugetlb all
> share the same semantics.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  include/linux/mm.h            |  5 ++++
>  include/linux/userfaultfd_k.h |  1 -
>  mm/huge_memory.c              | 30 +++++++++++++----------
>  mm/hugetlb.c                  | 25 ++++++++++++++-----
>  mm/mprotect.c                 | 46 +++++++++++++++++++++++++++--------
>  5 files changed, 77 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6499cfb61dc4..f79801816f32 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3297,6 +3297,11 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>  					    MM_CP_UFFD_WP_RESOLVE)
> +/* Whether this change is for uffd RWP */
> +#define  MM_CP_UFFD_RWP                    (1UL << 4) /* do rwp */
> +#define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* resolve rwp */
> +#define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
> +					    MM_CP_UFFD_RWP_RESOLVE)
>  
>  bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 0aef628514df..564eb2aac321 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -361,7 +361,6 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
>  	return false;
>  }
>  
> -

Nice cleanup.


Thanks,
SJ

[...]
