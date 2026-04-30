Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3612337BAC;
	Thu, 30 Apr 2026 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567597; cv=none; b=Ey47GvXFNSu7kteCxQrz/zmDvxl8m8Nm4q5XWWAXIxkMXZQQSWCzgYMvrv8uRFiERfThOA2NcasZMVZFQOkRw18y/wcvEy1D2GnNpwCw5gnRGaTMwTC0+eKcybVepUvc3AquuimbXhVWFvM2Kn7ohvKiFL8uwQnGwq4ACU7JeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567597; c=relaxed/simple;
	bh=ee0AbLojRbTTk/miCV2NuwgchMwICYZkqYau2Z3hA7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH1BDmzbUFVlVAsCziorxLC9Z6z/ovK233EGanziO2TgphDGL5tzKWzB7oMPFkqbucJ1AtsZwy6z7IEWodDf/GKNY8VRVv+vF/Mv7Q91M24iVQtTKIqmelS4Uicy6k1hIdr9mhTb1kdY9ZUyk4934GqjPaLQCa3HNh6jKa1S4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azAn6L1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azAn6L1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68914C2BCB9;
	Thu, 30 Apr 2026 16:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567597;
	bh=ee0AbLojRbTTk/miCV2NuwgchMwICYZkqYau2Z3hA7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azAn6L1iUdNMjBR/nMIlbjAMC4T4JXjm7euIYiwupXzXoD+p1UNnLQNbMY1iTrwCi
	 8ncpAGo7ngDftJtz7P+7whwhqBWoVOPN0330D/MK7mBuNLKVHHYy2XEUXdHFdsvYK8
	 v4MDa+x41RTR1f8gD/Ek31EjHbpMxrZ67Uyhr+Ls1KVgkZApqXjIaMSyiIleLjWBFW
	 7G6C5GoFa8segxTvPDZ9gVgulrNqld/RlCKpEYEsG84SFXui/KGD4CzFuRieNjtxmf
	 CwvwWHhAtcCAFhUfgSS+LsyyPZwaIT0bF3YdjoxfINm61a+xBlcKdB+NIs9t+3lmcZ
	 U1wpLgZxH11Mw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8CE60F40077;
	Thu, 30 Apr 2026 12:46:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 12:46:35 -0400
X-ME-Sender: <xms:a4fzaWklB9_qC6ARRffXuIBykWYfDNpBWB3fZyj2yFXZKsD5w0WKvw>
    <xme:a4fzaW0J6kMcpeUnOR_wb2xTZPR0ddfgFIUxa7coSpDbpL9vOXPUU3nGscfC07Qk_
    N7V6BuUcusAas1CICjzyU8iJhMDwg3xadNrMCfDQz45gL05OrAKxDA_>
X-ME-Received: <xmr:a4fzaeUEdxxbXZ98DK2422jJN2fe9u35X_xQE4nMH_I65X6jpxM7Q4VdIz-8dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepmfhirhihlhcuufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgv
    lhdrohhrgheqnecuggftrfgrthhtvghrnhepgeetuedtjefhkeeuiefgudduvdfgvdeiue
    eigeehheehudetuedtkeelhfeihedunecuffhomhgrihhnpehsrghshhhikhhordguvghv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepgeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhurhgvnhgssehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehvsggrsghkrgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthho
    peiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:a4fzaRgje0pyPF-196nDwMNf8dKZ9M9H61cAp_VFpcLcb_uXRA2FAg>
    <xmx:a4fzaXid3EPkfHefSAQvckbjL8Ngf61M6-lAbLdnTtuA6NiY3fpbAA>
    <xmx:a4fzaZtqIQoDsK3NsnRf-iEfXV8pb6souY1mdAsGlNpdaFR40wh11A>
    <xmx:a4fzaYS4PkzLN0qQ-4h4H5r_ieEp4AgsYp4HOdrc-kV8a8n122OuzA>
    <xmx:a4fzaSFiq6my_hQpDiVOm03e_ObELM4NCxk0EBP113QEDhqtXVlYOe2r>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 12:46:34 -0400 (EDT)
Date: Thu, 30 Apr 2026 17:46:33 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 08/14] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Message-ID: <afOGUZ7iX11MGhli@thinkstation>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-9-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114607.4068647-9-kas@kernel.org>

sashiko.dev -- https://sashiko.dev/#/patchset/20260427114607.4068647-1-kas@kernel.org -- wrote:
> +    if (enable_rwp)
> +        mm_cp_flags = MM_CP_UFFD_RWP;
> +    else
> +        mm_cp_flags = MM_CP_UFFD_RWP_RESOLVE | MM_CP_TRY_CHANGE_WRITABLE;
>
> Does this unconditionally apply MM_CP_TRY_CHANGE_WRITABLE to the entire range?

Confirmed bug. RWP registration does not require VM_WRITE, so

  mmap(PROT_READ)
  UFFDIO_REGISTER(MODE_RWP)
  UFFDIO_RWPROTECT(<range>, disable)

trips WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)) inside
maybe_change_pte_writable() on resolve.

The flag belongs inside the iteration, gated on
vma_wants_manual_pte_write_upgrade(vma), matching mwriteprotect_range()
(mm/userfaultfd.c:1003) and userfaultfd_clear_vma() (mm/userfaultfd.c:2182):

        for_each_vma_range(vmi, dst_vma, end) {
                unsigned long vma_start = max(dst_vma->vm_start, start);
                unsigned long vma_end = min(dst_vma->vm_end, end);
                unsigned int flags = mm_cp_flags;

                if (!enable_rwp && vma_wants_manual_pte_write_upgrade(dst_vma))
                        flags |= MM_CP_TRY_CHANGE_WRITABLE;

                change_protection(&tlb, dst_vma, vma_start, vma_end, flags);
        }

Will fold for v2.

> Since change_protection() walks and modifies page tables here, does this
> need to call vma_start_write(vma) first?

No.

This is the same locking pattern as the pre-existing uffd_wp_range() call
that the hunk replaces -- mmap_write_lock without vma_start_write(), which
remains safe for the same reasons:

  - mmap_write_lock excludes anything taking mmap_read_lock, including
    MADV_DONTNEED and the other PTE-page-freeing paths (try_to_free_pte()
    runs under mmap_read_lock + per-VMA locking, never standalone).

  - The remaining concurrent reader is the per-VMA-locked page fault
    (lock_vma_under_rcu()), which walks PTEs under the PTE lock.
    change_protection() also takes the PTE lock when updating, so the
    two serialise. A fault that observes a transient pre-resolve PTE
    just produces a normal fault delivery and resolves correctly.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
