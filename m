Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F4439F71
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737386; cv=none; b=C6DhhMTfrEdqdEYpV+4BDVDWFRhYxDY3c8GxDOuT8mDEuFV5uPhVC5XuY3fHcAczNV8MWys4ssJPmp5TO/2hvDJzDrj5vazNsbbI5W6+xacOn1b1uBGHr9cyIV2S022Uqsa0IzDlQle4WWZk0Q9pffYIGwXLClNj4vlkKBGhfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737386; c=relaxed/simple;
	bh=AJhbiUZm/1O78YEe8+J543JemHRMP9sVR8nKUhElCoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfkC/dDXP7WyLvTEng1so43bX8+h5mtoM7Ug63arbTV2KM8ScE5cQ+ytd76Ljfy5Mfn/4SZUcgVVsb1wwvtjLTNRmMi/o2kSaH3oLDqTnoZokxLNMJ9B6TkRcDqyMJdKFXAdsisvdL6LReM1Daj6KLvz1Is386BhvGUFBjV3bWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kVOhJnXq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kVOhJnXq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4450C1595;
	Wed, 22 Jul 2026 09:22:59 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6AAB3F59E;
	Wed, 22 Jul 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784737383; bh=AJhbiUZm/1O78YEe8+J543JemHRMP9sVR8nKUhElCoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVOhJnXqtHxd1rrz4ZKve/DppKGjwElepQbvbVb7fu3d0cSOqZMsxTU9VtsQmu+9o
	 oXZdpSqm82ASz1Ewo2HcYIKV+KJCbOhv8z9di/E3vQsTIzjw1nnTZ8VTjmy75ZrAxQ
	 PjCYysuK5lGRhMe4D/adx3tFUAmQq8THdhVAsVv8=
Date: Wed, 22 Jul 2026 17:23:00 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH RFC v2 13/20] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
Message-ID: <amDuZCBulu56A9uw@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-13-d9e4bad31e0a@arm.com>
 <20260722160753.C48291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722160753.C48291F000E9@smtp.kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] `effective_prot()` incorrectly stores dummy values from folded page table entries instead of ignoring them, breaking protection inheritance and silently disabling W+X security checks.
> --
> 
> --- Patch [13]: [PATCH RFC v2 13/20] x86: mm: carve out the generic compile-time folded pgtable case in effective_prot() ---
> commit 11eb6cce58717a2c22f41583089bb3b0105af585
> Author: David Hildenbrand (Arm) <david@kernel.org>
> 
> x86: mm: carve out the generic compile-time folded pgtable case in effective_prot()
> 
> This commit introduces ptdump_pt_level_first() to identify the first
> real page-table level for compile-time folded page tables. It modifies
> effective_prot() to skip updating higher_prot for folded or top-level
> entries, aiming to ignore dummy values from folded page table levels.
> 
> > diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
> > index 2afa7a23340e9..4e545988953a0 100644
> > --- a/arch/x86/mm/dump_pagetables.c
> > +++ b/arch/x86/mm/dump_pagetables.c
> [ ... ]
> > @@ -254,7 +255,7 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
> >  	pgprotval_t prot = val & PTE_FLAGS_MASK;
> >  	pgprotval_t effective;
> >  
> > -	if (level > 0) {
> > +	if (level > st->first_level) {
> >  		pgprotval_t higher_prot = st->prot_levels[level - 1];
> >  
> >  		effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
> 
> [Severity: High]
> When dealing with a folded level (where level <= st->first_level), the code
> falls through to the else branch (effective = prot). Since folded levels use
> a dummy value, prot lacks _PAGE_RW.
> 
> When the walker reaches the first real intermediate level, higher_prot reads
> this dummy value from st->prot_levels[level - 1]. Since it lacks _PAGE_RW,
> won't the bitwise AND clear the _PAGE_RW bit for all subsequent levels?
> 
> Could this cause ptdump_check_wx() to evaluate all pages as read-only and
> silently pass, hiding W+X security vulnerabilities?

This is not true. since the *real first level* will set the
st->prot_level with the proper prot and st->prot_levels[level -1] only
see the former level's one. IOW the folded entry wouldn't affect the
next level prot.

-- 
Sincerely,
Yeoreum Yun
