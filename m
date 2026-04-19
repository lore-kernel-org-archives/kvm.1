Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC11C3C1F
	for <kvm@vger.kernel.org>; Sun, 19 Apr 2026 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776609248; cv=none; b=t7ovKquv4fVLm2jlT4BVkaaYi5TO7RlSIgSpY0nmzvbqSzTnMzbtNVeqUf7ykhI9FXB38nnoeqJ0G0xdjT4GCXNkpk0zjrf+7glI437P0zU/2L2PdMnGFV8Rj/mIANFd7LU1DfZ5fWb/IujAYoZ5NmLUpadwtgh0gkQPcve2nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776609248; c=relaxed/simple;
	bh=xyrHX70Q1m+sOti0Gvm/ACwhuTSLW/9mrS9U1Nf2k9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNUkYEXs/7w/Zu1TRBr1Ab6fCGymUM4J/6z4CevtX6ezt+zLgJjoeuU1knEthsnJ0oEkEhYqvy7NU/cLViEFBHrFFv8oOMR+rpxpxQr4+/0vIy0VNaKCidE8u+tXAcme890JdX+pMMPaDgM5YcLnkrB9SJSEMR9hz3pfCpz6Av8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd1kZ50h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd1kZ50h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F3BC4AF09;
	Sun, 19 Apr 2026 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776609247;
	bh=xyrHX70Q1m+sOti0Gvm/ACwhuTSLW/9mrS9U1Nf2k9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd1kZ50hJX7/A2jyCWXq6YcFNQLFe2hvIWqmNU3N9hfijj50wvJSodc/5poif/bKH
	 Rv5l9p/gcgz3KzSq72j7K82T/VeQcjA87acvKd2Mxn9dyRijIRP6QmItwiJdC4c/t/
	 tHiFTQ56RzdmujzGWoLCrtwmwjzeRgHmBKXQ68SzXxYjiYogi1i/8Ea+QTBRye/h2O
	 GbK0Aq36zrbiHsIud+FU2EW1tSh87J7o8amwAbtkztODKQ44OvwrEFTlxVLX26MEjb
	 OK4Ff8AZTNs8V7MY9ofHlrU4TZIR4MNc3ew7qjk+jwZuDR4fzbjlvl184BvaiuVez7
	 iYK0bokJQllTQ==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45AC7F40068;
	Sun, 19 Apr 2026 10:34:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 19 Apr 2026 10:34:06 -0400
X-ME-Sender: <xms:3ufkabhibwJSBoppqF2Pb8ObmHfkv5_Gen9487QmJ1GpS2Y2kSNDag>
    <xme:3ufkaXT5ugzyaKGgrd5Xj28F3EtlBqc44JB_fT3GItuDbtuq8Qdm4ys4HRAyEq4Dy
    hiMdFYGxd2GrkGPDw8Bd0R1pMCl7N64G-OhKMmqqMQRw3hPL1FBxQ>
X-ME-Received: <xmr:3ufkaXQDCzXpnAYVA-WToKC7ZZLFJhgfB97QG1lbwGQ17ZkMZ8AJ1QIEsAM_sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehheeklecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:3ufkaTDpq90nRdz8qrD47__CsB4YVPIu20MV9CQqe9tvYlOAic_4fA>
    <xmx:3ufkabwVOGu9LVOovDfjmNcgym0KS9GgwnW5nmzTQXjt-yUn1gj50w>
    <xmx:3ufkaepH9zl5PRIt381RQa8fR-EPrbxi6sOQDpJklhnIAZe9LdOFiw>
    <xmx:3ufkaevgTj1J7S9XaTyA0Sfu90Qhvif0TCW6iAh5cgGN_ixj413S5g>
    <xmx:3ufkadQtuI6bYFEUM2v2bs_fnuNeQA9ruMrfuQkORBqRgiYbBj4DKKI1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Apr 2026 10:34:04 -0400 (EDT)
Date: Sun, 19 Apr 2026 15:33:58 +0100
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
Message-ID: <aeTnlQUOOh-dHG8z@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeImfRrrvr3UoKtL@thinkstation>

On Fri, Apr 17, 2026 at 01:26:34PM +0100, Kiryl Shutsemau wrote:
> > Leaving NUMA-balancing aside, a simple
> > mprotect(PROT_NONE)+mprotect(PROT_READ) would already be problematic to
> > distinguish both cases.
> 
> Hm. I didn't consider this case (miss some uffd lore). Will rework to
> reuse existing PTE bit.

See https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git uffd/rfc-v3

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
