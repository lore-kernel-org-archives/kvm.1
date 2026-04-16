Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E843890E9;
	Thu, 16 Apr 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776346042; cv=none; b=bakKTHfSNBIKUYjBZltM2xuKPmoRB7OrIcVgTj7BEoQwFUkkJfgYxFiM5hFUNAMbGIZRUI29QXEF9DpVLEGKctqFc72xkMzp3i/F95VW757bhz350ujyXHP7iR689M55BZxq+fKcO8/DOaABt1eScEMxkyRuDXs+5D/eA26Fegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776346042; c=relaxed/simple;
	bh=U0wkkhyzba+VOCKmZclFLbF+sxUF9Ywi5JITEPUwc7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S538/hblFJBQx8862Vve4wPDRgbFZnkwH8YRTYMypf3EjyF1xQ4aflUfm5jB8ofBRAp48cQmr7I9DolGkIRrcwo30V+W/bxI80nASLz2yugf9fc3wWOei2auDhA52CyYHf7v7rXc93WVtneKD8p7Ya/CB30fusqMbhXTxEGWStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXDzxqC0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXDzxqC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8351FC2BCAF;
	Thu, 16 Apr 2026 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776346042;
	bh=U0wkkhyzba+VOCKmZclFLbF+sxUF9Ywi5JITEPUwc7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXDzxqC0hW0ThnadfmrPp7viAciYVTS7DtQhOWv7D4kcjgU8G/0DcZQkZMjdLmZAb
	 ZtUsukwaXohNXgthC37FkuLlmRrq6mgaN9y/hm/H9bV7Iorzq93J4P3oi7KFk3iA+d
	 61Du4q0jCHJgWtAwG5JR/cxKxqb56iTljqQfTiwou+No/c2ziU/ZY1M6pcRv+iAv6P
	 hnlJAolJjEYZF8MAtJwWk75fnQ9fomG25I7xHuzZWo9ITBcjIF7umRsr3jErbNqGte
	 1gcIhVzXyV59qrdLc/dQNwuy1dTdKa5cE7MW2jgwVj79HOVGm324Ok+n7+16Zy6ebY
	 rf+ez3RsEmUOg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 85D3FF40068;
	Thu, 16 Apr 2026 09:27:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Apr 2026 09:27:20 -0400
X-ME-Sender: <xms:uOPgaSk_pM6BuGhHptX9-amFXqT0UE2TM2wzA7HHgiENOXqea5Zmew>
    <xme:uOPgadL-UqmGJ7BML7mME_r8-DxdWdy-GcSfr7AcUImmFz2ZAbB-p1Kr2eeewnuq_
    mzFtP4FTTqgSs3OlwKW2qxIGfGEAhdX0NCIBCfcYUCOhBse5YxyQbc>
X-ME-Received: <xmr:uOPgaccZcaWcEty1RZiELLMnLg0zpNfLCHITOax68C9SLv8VAEJJcHzOZapXiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeuieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuhhsrghmrgdrrghrihhfsehlihhnuhigrdguvghvpdhrtghpthhtoheprghkphhmse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghrgies
    rhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhpphhtsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihgr
    mhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:uOPgaZxt_HEBPxXdhHDBAeAtykf6aHcXL77XFB7L1kzKKuRgr8KhOg>
    <xmx:uOPgaUwdlNspXNQ2md4kX5WpB6oTKsYqkzxB6thSi84_GXxB2wXFlQ>
    <xmx:uOPgaaUER8pEqvOLKPlSpRxZjlGB5oVBs5W0IxVz9Hkw6UIM3IrlGg>
    <xmx:uOPgaUc-WsUOcgNf8whhteEVnf0B1htZu4McDmu0SLGH0dpVWJVSCw>
    <xmx:uOPgaXfCqcIf0Fbi7qdwViNxE3Nt7ki312s5joURJKDR8U_3R_9WwV3j>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 09:27:19 -0400 (EDT)
Date: Thu, 16 Apr 2026 14:27:17 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 10/12] userfaultfd: add UFFDIO_SET_MODE for runtime
 sync/async toggle
Message-ID: <aeDje8vylad8bGoj@thinkstation>
References: <20260414142354.1465950-11-kas@kernel.org>
 <20260415150900.3660575-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415150900.3660575-1-usama.arif@linux.dev>

On Wed, Apr 15, 2026 at 08:08:59AM -0700, Usama Arif wrote:
> > +	/* only toggleable features are allowed */
> > +	if ((mode.enable | mode.disable) & ~UFFD_FEATURE_TOGGLEABLE)
> > +		return -EINVAL;
> 
> The commit message states "Only async features that were enabled at
> UFFDIO_API time may be toggled."  However, the code only checks that
> the requested feature is in UFFD_FEATURE_TOGGLEABLE.
> 
> Is it intentional that a user who opened a uffd without
> UFFD_FEATURE_MINOR_ASYNC can still enable it later via
> UFFDIO_SET_MODE? 

The comment is stale. Will fix.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
