Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992B34B404;
	Thu, 30 Apr 2026 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567887; cv=none; b=seLYhTMbm7T1qlGsGs2ylShIVsqstrBBhv6DvecQ6OPKIomS/bNtOjE1dfzyWttNveOZZa3RNciO1j8Io/L8XQXnahP/uvtqO77qHM05khzIm2FqaUyFrt437AxGi550SiWhR6MyUUI7+l9V6CcjDNuZjlSIUH/P0Nw0qwUmltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567887; c=relaxed/simple;
	bh=/g7iUC9W4a+mffEw3evLoqTN1V514LaQU/s16UD5sPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZzJ3BYpuZK6HwLOfjp8wAHyWFYSqi5DaMyyCynHUyiIFuqNSldbZxJngNZU0uDys42yRELn6EbIrQIFZp4Gbd7QM+qfOP2ecf11TdTlsaYFvY7MYUdwD7SoczYZEQCITtuXNpdBodz2/qBQ59ogda+/nk6ZT86XLeodoiGsoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBPkUyvL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBPkUyvL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7C4C2BCC6;
	Thu, 30 Apr 2026 16:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777567887;
	bh=/g7iUC9W4a+mffEw3evLoqTN1V514LaQU/s16UD5sPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBPkUyvLYR756gEO2WpuJW9zXVKKNA3SRFPhNqgJFaSnVEWbwi3KrDXlwwT0KPh+k
	 o7tyQSjw2kZ1lVN3NIV+tJF2Sdxtw/F7963iCG+j67W4Eyw3qJrmbnSC4t++6DP6gj
	 W2xKsZuBKYNKG/hgkhml1CXyHADyNsH0v83vnx/BSFz5BVNwnVgMxnxdawQGjIrIRF
	 rk4DJU4nQZVoJwn0m7Zq7EsU+PxwY7xnbhSspw0S4DfZtzeen9iUsBuD4HYqPq+trR
	 IDGtWsH1wN15fhlh4stwU+V8CKqKONrEkogSOtZ16VO27MUk6YCdDfFc2Yif3UjBTp
	 wJuPBvIcUY3Zg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3BA3EF4007B;
	Thu, 30 Apr 2026 12:51:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 30 Apr 2026 12:51:26 -0400
X-ME-Sender: <xms:jojzaU-mFio1b7NAEO1SjmmVALuvKJecJDxtthHhA11m2dS3RcyuZQ>
    <xme:jojzaaVUmTThplgMRevXK_ENjGL9SWnFSahk8zrA4wjQL4iL7itwy9GLrdXhUK0uh
    Vs0g8h19xty30eOs7jZEi_wyfbgUlGIiOiqhqsDmPh86tdZlei4DQc>
X-ME-Received: <xmr:jojzafkN6JwnZ24-eM9ny6rsxX2a9snWBRih4qEUNnAj-SQms3NobFHrrPRdIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekjeekhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:jojzaYG8xNEfH5VrYQyYe3VXnfi_k3Q1yVPJ_O6RjrSWzXfBP9xJkA>
    <xmx:jojzaYR4WNsnfR3Cc5nJwWWchsmrv3qTNGN364ozZeUd4aXQZMoJBQ>
    <xmx:jojzaXQEaTRs3ODUIa8fiT_z0FgxE82Tol7wHHeOG19Z-Xo9DgweQA>
    <xmx:jojzaeervxLiCfO1LPq2TicKubhmUq3jHKqkA4Vn1u0T0u-_yt9LHw>
    <xmx:jojzaeDNWkAfBqpy4DpdvZlSxRtlbwS3CzZwWpzXDDjBiKzXmIgbPV7O>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 12:51:25 -0400 (EDT)
Date: Thu, 30 Apr 2026 17:51:24 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 09/14] mm/userfaultfd: add RWP fault delivery and expose
 UFFDIO_REGISTER_MODE_RWP
Message-ID: <afOH-MzZVT8Kuk-6@thinkstation>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-10-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114607.4068647-10-kas@kernel.org>

sashiko.dev -- https://sashiko.dev/#/patchset/20260427114607.4068647-1-kas@kernel.org -- wrote:
> Does this code lose the RWP read protection after a page is swapped out
> and back in?
> [ ... ]
> The restored PTE will be PROT_READ with the uffd bit set, instead of
> PROT_NONE. Will this silently allow subsequent read accesses to succeed
> without triggering the required RWP userfault?

The PROT_NONE restoration on swap-in is performed two commits earlier,
in patch 6/14 "mm: preserve RWP marker across PTE rewrites", which
adds to do_swap_page():

        if (pte_swp_uffd(vmf->orig_pte) && userfaultfd_rwp(vma))
                pte = pte_modify(pte, PAGE_NONE);

so a swapped-in RWP page comes back as PAGE_NONE | _PAGE_UFFD, not
PROT_READ | _PAGE_UFFD. The same patch covers unuse_pte() (the
swapoff(2) path), restore_exclusive_pte(), and the migration-entry
resolvers; each gates on userfaultfd_rwp(vma) and the swap-pte uffd
bit before re-applying PAGE_NONE.

> Can this sequence cause a state collision between RWP and NUMA-hinted
> UFFD_WP pages?
> If a VMA has both VM_UFFD_WP and VM_UFFD_RWP enabled, [ ... ]

No. VM_UFFD_WP and VM_UFFD_RWP are mutually exclusive.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
