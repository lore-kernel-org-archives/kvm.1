Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325F3D88FE
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782008; cv=none; b=QlJn7KLm+l8K4A/0JY7uXBm9TUawlcxS/4T4IWENPZnbOdxKTjDJO72cXz7fIjc3iECs5SqjHJZAVwSwflnYV3SyV9C7YcEnv5YS8CmKUxfO+mBMX18FHV+nuMbiRNCQJxbDKuK0njGzgd7Cz7iK/VaT/MAGWKV2ZHJB8cm6L7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782008; c=relaxed/simple;
	bh=zQMA8ZaCRC9pUhrioQYCLGa4/ChgjG5W1LG+7FgiXS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSVbgJOC5adJdkmaLpMXcb+LZO1dQpCsTEObXtQIxREMmsn0ih6LSA0Q927uIt81NgbAQd+QOv0tkklCuiRGcyF7wmoJj+lRp1sK97xiVav2NK897z+mqxx0Q0sxMJR2ckbFNPdpGtXetby8fvveZZysqmtr66LMvQYLlJDTQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBw3CZJ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBw3CZJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A03C2BCB0;
	Tue, 21 Apr 2026 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782007;
	bh=zQMA8ZaCRC9pUhrioQYCLGa4/ChgjG5W1LG+7FgiXS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBw3CZJ2jjMPXi+oGb1oxww1zSljMOab5cMh2QBn/OvjGjK8oUFmhWXHecmHZwXdk
	 b6FspRgXSJPJDHbS1o0k5I1nPymXrewV5P1loj172UP8ZgwOmBEJHURsW7ZrNqAjZn
	 ygqDmeXcbqSks0LDgTOGHjXaBoX3Z5q8d4oKC1uO4BO4V25Hh706p0s5EvtSF1bLJ8
	 u1+sdjK7LQD1eNZo0hXxz3j4KIJYinbErFA16OrSpXSY/69HXymaInsjjdnwAMOZlm
	 62qvT+Rv5fFiTPxqB0Li4nvilTFFHwmWaJbn4ETR6O4U3c77fyVY//XrZGPaTYYtca
	 HwxdVIlYeS6yg==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05683F4006A;
	Tue, 21 Apr 2026 10:33:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Apr 2026 10:33:26 -0400
X-ME-Sender: <xms:tYrnacf678S-ceViOiSMjkY3s80ZkugIXXiThfAcuxqUphjjI5gKig>
    <xme:tYrnadcx7ZWg7gVaHASteTcu6Vm83Ht38vk8DaSqNVi9_02dG0sq95AnhN3qj8JWo
    Qsd64yJDtgPEp3ptIgSMLQDnXkhlfHuTUCRze49KK39oHHWd9DsJb8>
X-ME-Received: <xmr:tYrnaZv3WZMspFXT2eiPG4GC-YuMKhY4VVQOSoT8VhsP8vg06gyaZlQaox76kA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeffffekgeffjefgkedvjeeggedttdeljeekhffhudeiudfhiefgudeugffhheffuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepphgvthgvrhigsehrvgguhhgrthdrtghomhdprhgtphhtthhopehljh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsg
    grsghkrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthht
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:tYrnacvnmNqHUpGJg1CNVnosaalW4m7puqzxSiFVCC4_T8mpVgFTHg>
    <xmx:tYrnabu_wyk-9u1jKaGBdqCDt8MyzdAhnzGTXjs78MhqGXI2dpo4bA>
    <xmx:tYrnaX3DPa-P4JEXju_5YuH4gQAYH-wno0g4b9bTgd3qnl2yRO3XfA>
    <xmx:tYrnaYKQ2-TfwFOAPlXXEDSGenclMP-T1YDyi12mtsDVb-EH296OGA>
    <xmx:tornaR-blBwoPKu9KjJs_32lHsU9xbT903gKlvjt6R3uYrSKtqwiVQMq>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 10:33:23 -0400 (EDT)
Date: Tue, 21 Apr 2026 15:33:18 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aed6fHLrIdahbdY3@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>

On Tue, Apr 21, 2026 at 03:03:56PM +0200, David Hildenbrand (Arm) wrote:
> On 4/19/26 16:33, Kiryl Shutsemau wrote:
> > On Fri, Apr 17, 2026 at 01:26:34PM +0100, Kiryl Shutsemau wrote:
> >>> Leaving NUMA-balancing aside, a simple
> >>> mprotect(PROT_NONE)+mprotect(PROT_READ) would already be problematic to
> >>> distinguish both cases.
> >>
> >> Hm. I didn't consider this case (miss some uffd lore). Will rework to
> >> reuse existing PTE bit.
> > 
> > See https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git uffd/rfc-v3
> > 
> 
> Quick feedback from skimming over it:
> 
> 
> 1) ARCH_SUPPORTS_PROT_NONE needs some thought, because I am pretty sure all 
> architectures support something like mprotect(PROT_NONE), and the config
> option might be misleading.
> 
> So you very likely want to express different semantics here. You want to
> know whether pte_protnone()/pmd_protnone() works.

We do support mprotect(PROT_NONE) everywhere, but we don't always have a
way to distinguish such entries from others without VMA in hands. Like,
there are other PTEs that don't have present bit set. In my and NUMA
balancing context we cannot rely on VMA, because we want to install
PAGE_NONE entires into accessible VMA.

So we need two things; pte/pmd_protnone() checks and PAGE_NONE itself.
The first to test PTE for PAGE_NONE, the second for pte/pmd_modify() to
make the entry protnone.

Currently, generic code only use this functionality for NUMA balancing
and gated by NUMA balancing config option. So I moved it under separate
config option.

Do you want it to be named differently?

> 2) The other stuff is really just an extension of existing WP handling.
> I suspect we want to have some reasonable cleanups to not end up in
> common code with
> 
> @@ -1841,7 +1841,7 @@ static void copy_huge_non_present_pmd(
>  	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>  	mm_inc_nr_ptes(dst_mm);
>  	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> -	if (!userfaultfd_wp(dst_vma))
> +	if (!userfaultfd_wp(dst_vma) && !userfaultfd_rwp(dst_vma))
>  		pmd = pmd_swp_clear_uffd_wp(pmd);
>  	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
> 
> All the uffd handling should be better isolated (i.e., a single vma check?),
> and likely the uffd bit should be abstracted away from being called "wp" to
> something more generic.
> 
> Maybe it's simply a "uffd" flag which's semantics depend
> on the vma flags.
> 
> Maybe something like:
> 
> @@ -1841,7 +1841,7 @@ static void copy_huge_non_present_pmd(
>  	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>  	mm_inc_nr_ptes(dst_mm);
>  	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> 	if (!userfaultfd_uses_pte_bit(dst_vma))
>  		pmd = pmd_swp_clear_uffd(pmd);
>  	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
> 
> Not sure, needs another thought. But I think there are some decent
> cleanups to be had.

That's fair. Maybe userfaultfd_protected() name is better for the VMA
check?

And about UFFD_WP bit name. Maybe we can just drop _WP: _PAGE_UFFD_WP ->
_PAGE_UFFD, pte_uffd_wp() -> pte_uffd()?

But it is a lot of changes. Can I do the bit rename as a follow up
patchset?

> 3) Some other stuff needs a second thought, like
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 8e7dc2c6ee738..08fc18f1290d4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -695,7 +695,8 @@ static inline bool can_follow_write_pmd(pmd_t pmd, struct page *page,
>  	/* ... and a write-fault isn't required for other reasons. */
>  	if (pmd_needs_soft_dirty_wp(vma, pmd))
>  		return false;
> -	return !userfaultfd_huge_pmd_wp(vma, pmd);
> +	return !userfaultfd_huge_pmd_wp(vma, pmd) &&
> +	       !userfaultfd_huge_pmd_rwp(vma, pmd);
>  }
> 
> How can a pte be writable and prot_none at the same time? Maybe just confused AI
> output that you should carefully double check before sending that out officially.

Note that this path is for !pmd_write() case to begin with. It serves
FOLL_FORCE case. I believe this check is correct: we don't want to allow
to write to such pages even with FOLL_FORCE.

But looking around, I missed gup_can_follow_protnone() modification. It
has to return false for RWP.

> 4) How do we want to handle PM_UFFD_WP?
> 
> We are pretty much out of flags soon. Overloading PM_UFFD_WP means that we will not
> be able to easily support using a separate bit.
> 
> But our internal design will not easily allow that either, and I am not really
> sure we want to go down that path any time soon.
> 
> Maybe we could document this for now as "In WP VMAs, indicated WP PTEs.
> Otherwise, in RWP VMAs, indicates RWP.". Whenever we would allow both at the
> same time, we could change the semantics. User space would fail to create one
> with both protection types for now either way.

Yeah. I think about doing documentation-only update for PM_UFFD_WP for
now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
