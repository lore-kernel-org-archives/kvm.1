Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D42FF164;
	Thu, 14 May 2026 01:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778722297; cv=none; b=FlldXgPPzd/aSgYo51uovp5IyCxrykeTM+533Ao4Djw3Ek02a5zCV9RFuDCIaxSN7f6SWlhVP/x9DaPCyajMdNDto1zxp6VMIulg7AgAvfQvOZd5QIHKn3tuXzPQt1cQXAL/W6yAxs9R+K98yS4q72AibIAd10vnJg1c6lK8Nn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778722297; c=relaxed/simple;
	bh=Cdh+pQ8/afF+yyCKEmvTOqX7gj2JDvxII6ghktFLKBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6BrAceTbi/jTYuEC3/4X0ZAE8nFeCWFoKeDzG2fJO/5OfWVIHSTR6MtMFW+CQPGihAquyjBwBLJsTTY1ixXhJ2Az61XjOcH2bj1ZPp7QLkogt1OyUvr3tAQ/QoIAFmiZlw5FBuxf0llt2BMDvklgBVW3fYeqTbMLbTTtaQVfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJp2z/0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJp2z/0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4E2C19425;
	Thu, 14 May 2026 01:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778722297;
	bh=Cdh+pQ8/afF+yyCKEmvTOqX7gj2JDvxII6ghktFLKBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJp2z/0Yk21FpxoDDBkSAmtkfMAppohy3KdW+srzwW94GoU1vSNBd3qYf/f/eOAgW
	 8sLjnUZMX0/Dwz/YQ67WGw9ppEz1qKCiq4nP1O07QoOTtPPNdotwFe1WMTqFjuefi0
	 oQrJf+7/OF53KVqfGQ5u7J77vMVn/37M4FIy1ZByEeTtV8PT5z9JHb+Ru8mLIMI3xE
	 q5q6v2IniVL20Va2dF7TQKbdozNMOPIpK1+X4TZ/mP/TCh+IyRPz+8dbvtNBCmTR0p
	 547IwCghVQNiuuc/+U35iiM5hG7avbrl1YztJDI21ibuIjY4HBPBMJm2XAfHIVeRhJ
	 s5hcT5V1pPPEw==
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
Subject: Re: [PATCH v2 03/14] mm: rename uffd-wp PTE accessors to uffd
Date: Wed, 13 May 2026 18:31:27 -0700
Message-ID: <20260514013127.148945-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <dfda2f55e155b17535ea9fb8330d9fa9afe0c0e1.1778254670.git.kas@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  8 May 2026 16:55:15 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

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
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: SeongJae Park <sj@kernel.org>

[...]
> @@ -4934,10 +4934,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  		softleaf = softleaf_from_pte(entry);
>  		if (unlikely(softleaf_is_hwpoison(softleaf))) {
>  			if (!userfaultfd_wp(dst_vma))
> -				entry = huge_pte_clear_uffd_wp(entry);
> +				entry = huge_pte_clear_uffd(entry);
>  			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
>  		} else if (unlikely(softleaf_is_migration(softleaf))) {
> -			bool uffd_wp = pte_swp_uffd_wp(entry);
> +			bool uffd_wp = pte_swp_uffd(entry);

Just curious.  Is the variable name intentionally kept to avoid unnecessary
change?


Thanks,
SJ

[...]
