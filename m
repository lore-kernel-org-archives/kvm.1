Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544643876A7;
	Fri,  1 May 2026 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777632099; cv=none; b=auqWdufsJnFL6f9sN8oWVWp4FX/o4C4704UZCLTJsHp+3zK+Zr0DwFHsCKL9llBWMYHBFf1TqmHmQ87kmJjnbFVraHqwuuSTbShMyGwR4EoIcOswfEJoi8j1f4abejYDiA498SsmLuSk791f4Epu4LJehznGFqp/5crphyr6ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777632099; c=relaxed/simple;
	bh=zG0cdIpqGrSUk2e0Yn+pCtQM9mDMXSK9RTMePPjgQUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTN7yyNq7GKOMMrqY3umF+i9tcA0PmVEe9ofM7uTj5DODLXQAeNFTVy7BDCl5tHEpcoqnwGlaZIdZDHl4GgpsBtO6SHxVSFdApqLJSjPQGUG80jiV4ohc3Pw5fBHagn/ye1q0L+mSG9rrxJQEQKKnxnfrkWTwEECY1vy44AQJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnB+pKBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnB+pKBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D2BC2BCB4;
	Fri,  1 May 2026 10:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777632099;
	bh=zG0cdIpqGrSUk2e0Yn+pCtQM9mDMXSK9RTMePPjgQUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnB+pKBTokhVGJuDJN9IgXLZgBgg09jlvv+bsR8hb6uaLf76tr1KzLGxF+/GCSjer
	 2D29vaBf9nQwROhDNX09xqsVTwnY38mZWOBahE6sDiR1q1InE2UBpe/bJ0qI8QrWUi
	 41KOmOihS6O8kPOKwaDpPLDgE9fGMbPVIHg6C9MxxkiGD9PsWJEL9Mynz66m10hsli
	 Da9EFM9UpZt99E+QDYiGt+TI2FDKwEOt+O4By6AqpRzfafAxV3jo16bjoH+4keL715
	 1R3PEuepwz08c5hRNIkpZ1jo/FALM44qjuIK6cvqKUcfciKbO3xD9zUa9VoWdPcK0O
	 MgrWMIx1lrlqQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7C44BF40068;
	Fri,  1 May 2026 06:41:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 01 May 2026 06:41:37 -0400
X-ME-Sender: <xms:YYP0aZN06RmVqMUSnMjk7NRoE7xJNkvoT7DHftyfyVzRQ5vc7zcfVA>
    <xme:YYP0aZk_XNWfWQrpYD8zDV4kSMkoFuykiICxx3sdSflnWtTyGL9dCF4becjLPW69h
    g3ot1Z0qmhp8T0w1d4S0G5oxfzqD7ixkSXaFDDmS1Z0tbPSO0ZAdjs>
X-ME-Received: <xmr:YYP0ad1P7V8V5tSdLF7sI6CDaKilTeyvZidMwGpgYy-DrwFh2zPHB-Ju9b9bdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekleellecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:YYP0aZWiZApYblD-N6cQEHz6QtqrsEqvEOw2unL5khPHcR3R_53ctQ>
    <xmx:YYP0aQhnkxK9GE-6qcefPj6VSn2jPsN6XkBEDVzgR1KvO6IY3-Lctw>
    <xmx:YYP0aagqewTE3OQZ9zFGq1-wp4dXwGODRGx6helK13TyuhnSYzuPew>
    <xmx:YYP0aQuovEgr2tAjxRgxYFOgURqX6Gnvhm80YLa-0SD51FJpInh4fQ>
    <xmx:YYP0aTSByjDZzE51VF-0XGGywziZbAzVBNk7pTuSOdNzpDuXYM2Gxc5j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 06:41:35 -0400 (EDT)
Date: Fri, 1 May 2026 11:41:30 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 10/14] mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking
Message-ID: <afSC1NHWzrtA-vmA@thinkstation>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-11-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114607.4068647-11-kas@kernel.org>

sashiko.dev -- https://sashiko.dev/#/patchset/20260427114607.4068647-1-kas@kernel.org -- wrote:
> commit 6d6b8f986b2959f8ae0932deccc5afa4ec485813
> Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Subject: mm/pagemap: add PAGE_IS_ACCESSED for RWP tracking
[ ... ]
> Does this new PAGE_IS_ACCESSED tracking correctly support the atomic
> read-and-reset workflow (PM_SCAN_WP_MATCHING) for RWP VMAs?
[ ... ]
> Since WP and RWP are mutually exclusive per VMA, userfaultfd_wp_async() and
> userfaultfd_wp_use_markers() will return false for RWP VMAs, causing
> pagemap_scan_test_walk() to return 1 and skip the VMA.
[ ... ]
> Because these loops hardcode a check against PAGE_IS_WRITTEN, and RWP VMAs
> now populate PAGE_IS_ACCESSED instead, this check will always evaluate to
> true for RWP. As a result, it looks like make_uffd_wp_pte() and
> make_uffd_wp_pmd() will be silently skipped, preventing the atomic
> reset of the tracking bits.
> Would it make sense to update both the wp_allowed check and the hardcoded
> PAGE_IS_WRITTEN checks to accommodate PAGE_IS_ACCESSED for RWP VMAs?

PM_SCAN_WP_MATCHING is the atomic read-and-reset flavour and is
implemented for the WP marker only.

The silent-skip on PM_SCAN_WP_MATCHING + RWP VMA is not intended
Will fold this fixup

        if (userfaultfd_rwp(vma) && (p->arg.flags & PM_SCAN_WP_MATCHING))
                return -EINVAL;

We can add similar operation for RWP later if there's a use-case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
