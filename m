Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E73BD64D;
	Fri, 17 Apr 2026 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423728; cv=none; b=FBpMdAI7ABuJAWmszNigXvpwy3GVpQepPZk4yFflTe5AdtiDYtvCbVgBXnJpn4hZRUpSnrZ/Gf01O54Qi71DI30VmIVrAmxy2b06BdcLnKAuT6YdECYWB4rBHk9C0TuDbct+Uoz+AgMdUiWEgr6tVagnFL2x1lL0iNijkV6THCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423728; c=relaxed/simple;
	bh=RD2xZwSAN34oyYE/yDIGZVsjk5tGByOG6NLgb3CiwHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiXr840+RzSY1oUbX/A+YTnJCFy5E8Rxv7WaUuCopOjNepXZAD5VQ4AOV2JAJr9XTjGxrL2Vb8EvmLYX1y3FPagiiq59EyP8+zTosfl9iLqdPRR1nJquwYbJBw5bBDN8B5BdIKigspYKr+Qghjwe9+WcAOGsOgO7DHjYeJs7lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrzOjV3p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrzOjV3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEFEC2BCB0;
	Fri, 17 Apr 2026 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776423727;
	bh=RD2xZwSAN34oyYE/yDIGZVsjk5tGByOG6NLgb3CiwHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrzOjV3poiBb1puu52YyXIKRuGOwWvMNH9wuAYttnOKLdq0iFSKLcw2Ru4KWcX9vz
	 p/aUAfW1sWP5GzD/1FyALBZ64HgTdT4xFvsqEljUHZqFlMDE6Y3N2X3ecOZi4rjW2T
	 0Tg+PnV6v9Y2r6uVkbFpcyKOt1tqV5H3SYTHCcnPHiBYX2sC4OvhgRMnfciVop1cjl
	 W+AUIqNg7QU45cczLLvAqBxyhEDiY9E/OuJQoqai19M+HpKVsWM6V2NQm7PlntGNlu
	 ytQf3jXSUzIIxSLHU7JHlx4pHs9hSOkfZ7PcCCkqXJLGCwsW5e3v3yl2VTMB/6uCiJ
	 Z/hmg3JWUXMJA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF459F40074;
	Fri, 17 Apr 2026 07:02:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 17 Apr 2026 07:02:06 -0400
X-ME-Sender: <xms:LRPiaQD7NRvGGI6zwWqzkuIbrKsRzf-riMi_XbJTYBdcYHVyNaaDaA>
    <xme:LRPiaRyAeti_Nx7WMC2nyqRdLHucqwGwqgBvI96JHtvWZw-dYwsufYFiBcs8agnlz
    NFFvhdfNeliG6XayXvOLLUBrFLPDX8b6qyelMiONaD3RmAgAvIeWMU>
X-ME-Received: <xmr:LRPiafxIctvuPPL4kUIE5vLvCvDfLr-fwC-PRCBXJl82QU03-Yghbw0l963gWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeuieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehpvghtvghrgiesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    iihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:LRPiaRi0fIkRM59izX5QU3KhLf-I2qFhnfNUUanzQTESqVyBPDMQ5Q>
    <xmx:LRPiaYTqSmfQGtkH14z0Zke6oAao0cPgvjOpMpAUIfuEbDocN2CNGg>
    <xmx:LRPiaRKRhxGYIoazpX2flDljP6wGD5IHG2pMs9gPtbrajG2PFYxgPg>
    <xmx:LRPiafP2V8jRpG8pwLTsPptBNucRmn9aWSqe6bAgCCIWzWvoCgXaSg>
    <xmx:LRPiaTy_wSrxI2_acJSkBmHrnbs1hKulga3OLYTuQdfyRegVlTApXBIW>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 07:02:05 -0400 (EDT)
Date: Fri, 17 Apr 2026 12:02:03 +0100
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
Message-ID: <aeITClDuFStd7BAB@thinkstation>
References: <20260414142354.1465950-1-kas@kernel.org>
 <55019037-4f1c-4d9c-83ee-3a844d8f3d5e@kernel.org>
 <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeFCuLJXT8VOkzH7@thinkstation>

On Thu, Apr 16, 2026 at 09:25:25PM +0100, Kiryl Shutsemau wrote:
> > b) obviously means that we cannot use uffd-wp and uffd-rwp at the same
> > time in the same uffd area. I guess that should be acceptable for the
> > use cases we you should have in mind?
> 
> I took a different path: I still use PROT_NONE PTEs, so it cannot
> co-exist with NUMA balancing [fully], but WP + RWP should be fine. I
> need to add a test for this.

WP + RWP works. Test case added.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
