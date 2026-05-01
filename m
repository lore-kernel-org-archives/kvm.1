Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928A3314BF;
	Fri,  1 May 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641132; cv=none; b=uFjpUdDgFQfDRy5utcFb6Vd41Fg48NRqDDDaYFKb1cMyvf2kWUbVNBksUW/OGTZwPrbycSya+kupBvZzR97+XULxamvZYjOeiBJdavzEXjwNhw3+c878jacKO4clspJbcO5+2WN/Dm3Sz3/gLKr2exLscAriXiXb04zAWndDnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641132; c=relaxed/simple;
	bh=rPY6kpU0k2x/r+Y5vurIQbKrBbLh1ktKKLy++xxDRJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwsEV3F/mZ8XcZOjDj/g8aUfrirsuCjg/TznWBkL4MaiAijc3u/avv0cmcvjgfDdXiPyhybRJe7HoLBMUpSXeqItF5vFqEgNazzKrSEnyGaqz1joIVHLQooM6rUMk9pdzCQpU6c0zAVhmo+0T+8Mpxyit0jDkmNroXipi0t49u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHOZWyfp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHOZWyfp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2431C2BCB8;
	Fri,  1 May 2026 13:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777641131;
	bh=rPY6kpU0k2x/r+Y5vurIQbKrBbLh1ktKKLy++xxDRJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHOZWyfp/mCR6Px6qXMz9bAhRrRNKNfaUrZLr92WGzjhU5+ZD1HguQ9Y3zf/HM2CF
	 ING0+AfXfn4kDPc5x2uBTNvI7zCbPfMuKpXbYAAi8OEzsl2QVVIMv+isnIlWUg+HW/
	 xM6JTb0dcYH2RKUDP49boYGZDv7s2GZFK8LGyFIzn02ETafhtg6uI2N6+M3EIf/xI2
	 BE6Jzgy/GAbwfChY5kjJoV3STuzVSX0a4+cK7PkhgRPIYcC217OaSRl87qAJLW2e9b
	 Eo3cgSsQdRWPfvn75RbdCGpts/o6G00Qy1sSFFfhfMVqEEjyvnl4CMhoQ4Darvr1Sb
	 tELR0d3vPlwEA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id DAB1EF4007E;
	Fri,  1 May 2026 09:12:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 01 May 2026 09:12:09 -0400
X-ME-Sender: <xms:qab0aZZ4lmLNO5LE8pviXf6YBxnkbKewj-zXCrnavZJbivsPPh6_BA>
    <xme:qab0aZbhJsDTscqH55SYr_OEFAwzsgNjg7sBPCrdUYW-66rhcJAAMeTZbxEEhGJKj
    Hmt6Egs2mZe8Q_M1jOAVb0eQiM7QKHFLTfa8h7WPEyyvnetTmzZgl8H>
X-ME-Received: <xmr:qab0aVrkX4Bbo0Q6l--ODLheZLKc2hOtjBXU1_HfQMhjypegpMpmi1QJbluuUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeltddvlecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:qab0aellQYNT_R3fN52NGkYyZEn9mCcboTG8efe4UUa4xZvIjmghYQ>
    <xmx:qab0aXXW-mbF5hvwEoNxPCMKoYDCFHu3nt6c2smZz8Vk1gQK780nrQ>
    <xmx:qab0aVT8bhREa829ct_FBCqcDdAvlwJ95mcAgBiFkHkE-FJLxXvqbQ>
    <xmx:qab0aUn6vSQB25ybLkc5R3M2QJMF_5HgjWaudrlMGx7p-UFnWnJSjw>
    <xmx:qab0aQJhjaQAJXOfWCBO_ZYZ2jbBsI4emal1EOnO7LoIoTINtPTJhE9Z>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 May 2026 09:12:09 -0400 (EDT)
Date: Fri, 1 May 2026 14:12:08 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org
Cc: ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 12/14] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Message-ID: <afSmJ4LLuLJWdI4A@thinkstation>
References: <20260427114607.4068647-1-kas@kernel.org>
 <20260427114607.4068647-13-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114607.4068647-13-kas@kernel.org>

sashiko.dev -- https://sashiko.dev/#/patchset/20260427114607.4068647-1-kas@kernel.org -- wrote:
> Since ctx->mm can be an external mm_struct, is it possible for the target
> process to have encountered an OOM-reap or a failed dup_mmap() and be
> marked MMF_UNSTABLE?
> If so, should there be a call to check_stable_address_space(mm) after
> acquiring the mmap lock to avoid iterating over a maple tree that might
> contain XA_ZERO_ENTRY markers?

This is the same pattern as userfaultfd_register() and
userfaultfd_unregister(), which acquire mmap_write_lock(mm) after a
successful mmget_not_zero() and walk the VMA tree without
check_stable_address_space().

The OOM reaper takes mmap_read_lock, so it is excluded once we hold the
write lock; failed dup_mmap() unwinds its partial tree before returning.

> The commit message notes that fdinfo reads ctx->features with READ_ONCE to
> avoid seeing a mid-RMW intermediate value. Are there other lockless readers
> of ctx->features that also need this annotation?
[ ... ]
> Could executing UFFDIO_SET_MODE concurrently with these paths cause a data
> race on ctx->features?

Confirmed. userfaultfd_is_initialized() is reached from
userfaultfd_poll(), userfaultfd_read_iter(), and userfaultfd_ioctl()
with no mm lock held, so SET_MODE's mmap_write_lock + vma_start_write()
drain does not exclude them. The INITIALIZED bit is never modified by
SET_MODE so the value is functionally stable, but READ_ONCE pairing is
still the right thing for KCSAN.

Will fold into 12/14 a small helper plus conversions:

        static unsigned int userfaultfd_features(struct userfaultfd_ctx *ctx)
        {
                return READ_ONCE(ctx->features);
        }

with userfaultfd_is_initialized(), userfaultfd_wp_async_ctx(),
userfaultfd_rwp_async_ctx(), userfaultfd_wp_unpopulated(), and the
fdinfo printer reading through the helper. Hot-path reads inside
handle_userfault() and friends stay plain -- they run under the
per-VMA lock or mmap_read_lock that SET_MODE drains before the RMW.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
