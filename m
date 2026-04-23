Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B413A872A;
	Thu, 23 Apr 2026 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967684; cv=none; b=HZAiAtQdm1vdEVoRcEincIaWdDiHJUVGQnilCrl6U95wLD+MzfYlF3Q5QIeTI2boWmQ2LuKorGbO2fg403sdLmVQaoPpQ9pBBdBFlAekdfprQyrv5T78avRavD3s+oLlZLzG26Rb/NqGE0jUBBJOFni3ez3VFqbImfKXkpx0MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967684; c=relaxed/simple;
	bh=fUtnL9qRpoANwM3bPHlOiGowL2i2i1ePLUkXdrCF8M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFPu6c5xsCy8DwPUSwj4ZAdrdcVhURfrbk4aYDh3cL5Xy0MhyAfv62y0eKc4aps9fi44QUd7Lw7hACCW9cd8Ddxu6DlZOVSUt7n1ktOnobNv7Ktga5jB8genRVOSPUHY2dOlIYMJ9HN5JXRkKIIMTbNuFYr/Cq8wf0F+37mZ/Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAP3ZIAR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAP3ZIAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55978C4AF0B;
	Thu, 23 Apr 2026 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967683;
	bh=fUtnL9qRpoANwM3bPHlOiGowL2i2i1ePLUkXdrCF8M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAP3ZIARBqueoN9RFilIOZs+UJq6a6x9Enmg84t8Usw7oQUBeSKkK4ZPIb7xzSUYu
	 oUIsnNj65y6jrspk5WdGMHIoY5kg4ytXH1NL33s66LoxvcJvd+cx8tdqpQBX93pZvp
	 LCNNdUgwNNPyVaZ4S7d232awap213vIhzXg1e+DvNFkUksTZGXboF1Xax3jdyoNbjR
	 jvLeaT5nf3App95sC5MiAbOi8IVTGruuKLoVADY3xUDaQqAWXrdU8c2Wd56lVfyWee
	 wSkDxYDdmdrZizKwNW0eqIkLU1akChNOaQts8wFZQ/SLsBX7u57LnVxkkFu7Ezv5N2
	 Fi7VP3VTfO/UA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 618A6F4006B;
	Thu, 23 Apr 2026 14:08:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 23 Apr 2026 14:08:02 -0400
X-ME-Sender: <xms:AmDqafKne51c23t3lOUfwu3m9Jat5CujNgYxp6RC3pVv8n1E5ApPhg>
    <xme:AmDqaSaPnjQM5JuaZTSQ7uK_5VTA28rKQMlnqvZXZWf--t9BbghNabwV-_s1AV9Hx
    3AREOoCahoWWPLLRniuN8x1J2BrT2C-zrldhyy7PEvNwOT2cydEMw>
X-ME-Received: <xmr:AmDqaT6shwVvN1bYvTKiFRpp--F0ku9VmqAT3BGObH8t1GaOQCMYWgum0DBytQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeffffekgeffjefgkedvjeeggedttdeljeekhffhudeiudfhiefgudeugffhheffuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghrgiesrhgvughhrghtrd
    gtohhmpdhrtghpthhtohepuggrvhhiugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehljh
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrphhptheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvsg
    grsghkrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflhgvthht
    sehorhgrtghlvgdrtghomhdprhgtphhtthhopeiiihihsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:AmDqaTJDnWhOA6Lo5VS3-3zpSTgB3bAOxPGZpGcQWjdEIwFuZdcZSQ>
    <xmx:AmDqaZY0sSALVtS7asmIB8MYX0nPAO4sjU53qds5bVXfXSrKC7Ur7w>
    <xmx:AmDqabxGOc2JRHlMYEDYv15bQ-MaKvilloF3PHIY3GW_bvq3v5r5IA>
    <xmx:AmDqaVUM8UDa_Zh5-pPT75bjmmW8iNzLWo2YmuCcUZxlgN1lsXJlKg>
    <xmx:AmDqafblfb_m5kSp-CjhTquEbv5wDlCyHGQsZxMnJDje3tAR6gHC6Kz1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 14:08:01 -0400 (EDT)
Date: Thu, 23 Apr 2026 19:08:00 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Peter Xu <peterx@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC, PATCH 00/12] userfaultfd: working set tracking for VM
 guest memory
Message-ID: <aeo5IPpQi7onyjTF@thinkstation>
References: <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
 <aeorZMvKwu8zKX5i@thinkstation>
 <aeoxnuGKO3uqS2kG@x1.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeoxnuGKO3uqS2kG@x1.local>

On Thu, Apr 23, 2026 at 10:50:06AM -0400, Peter Xu wrote:
> Hello, Kiryl,
> 
> On Thu, Apr 23, 2026 at 03:27:11PM +0100, Kiryl Shutsemau wrote:
> > The patchet is pretty good shape in my eyes and will probably drop RFC
> > tag.
> 
> I still have some high level questions not yet got answered.  Do you want
> to answer them?
> 
> https://lore.kernel.org/all/ad59TxAHNwFWH7Cc@x1.local/

Sorry, reply to this got lost in my TODO list.

> In summary, it's about:
> 
> - Whether we have explored other approaches on page hotness tracking

So, for read/write tracking we have clear_refs=1, page_idle and DAMON.
Did I miss something?

clear_refs is process-wide hammer. And you can miss a hot page if it
races with LRU rotation.

page_idle needs rmap. It will not scale.

DAMON is built around sampling. It is good for working set estimation,
but I don't think it is directly useful for eviction decision. It can
miss hot pages. LRU rotation will also loose info.

None of them gives comparable capabilities.

We also need a mechanism to atomically evict pages.

> - Whether read protection is required for an userspace swap system
>   (e.g. did you get time to have a look at umap?)

I looked at it briefly, so I can miss details.

IIUC, in absence of read tracking it doesn't collect hotness information
at all. The eviction is based on fault-in time: the oldest faulted-in
page gets evicted first. I guess it is fine if you don't care much about
refault cost. Like, if your workload fits into memory completely and
refaults are rare.

That's not my case.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
