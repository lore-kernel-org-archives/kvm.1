Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854832D438;
	Thu, 23 Apr 2026 14:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954435; cv=none; b=H6YaLMHpAO9bj1ZAvAhCN8cAQPVlGZBQu7b/GTQJixkGeTkK2dSf6IWMwVKyqHvpGsMmckVJMKi5rEE5FeXLlVmjS+rR+VCib1msXDBktwcnCwifSn9Eqh7wVjYLNgsqIA6VFWnAAs3xOgelYuEyYobbbrcTskhvXEplGU2UjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954435; c=relaxed/simple;
	bh=ZAmfY2GvQu1V+jZW4Q7JR569GmwjElVH8qZhAxn7gDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqu3gYBr/Fpr9ehtu395KjqUwvahC2bEANoBC3+TD5JNUJ1Hx/GokHZR+Pb52FlQH0zD09Vnd8QvUFvHJskvDg5nt0aFiB5O+XNtm8H4bKnZcPdntVOK0PtgRx0NTAvA4bcLjUOExi5ZgVJx9uKcgihHoSaptWNsb5yuXFDw+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6TbTKra; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6TbTKra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6772C2BCB5;
	Thu, 23 Apr 2026 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776954435;
	bh=ZAmfY2GvQu1V+jZW4Q7JR569GmwjElVH8qZhAxn7gDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e6TbTKraQPr2vhcn+/z0+5leztca56h0cv39qFusb+C5AJl8cN+xFr53pEzXrl7pO
	 FNmKh3LOG2clnXKHBI8F222Yio7XScD3a43RVx/n3tJ9XGzR4mjQ4TTD6iuaThzWtE
	 wpa5wS6kQJDL/h98SLKgFizRFTYVs7rKqLiAcNNRU2PO+NpiIZIVHYr6WkoFN2zom5
	 fsxXGaVcEQ74oL+gHP75vzCvYzR/5EBk9fTjttJBbr6aDmbe87Jl/CMXPDs9mGX8++
	 jswsFmZXl098tfmybnEoYEkIHe4RreFfzVUjH/4B+mLb9V37UOxx/5J2vC1g9Bt+/W
	 Tf/yzrurTzr1g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E0313F40069;
	Thu, 23 Apr 2026 10:27:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 23 Apr 2026 10:27:13 -0400
X-ME-Sender: <xms:QSzqaTPm8wdWHwg2j0DX5hhDMnOfiwy16200E9LcT2a7ngV41L6iKA>
    <xme:QSzqadN2q1OZDI4SZQ8lZ99xkTM8WvVWTyFq5CdRvHHab2n1uHXdI_G-dMBjghpeB
    hhmnZK464FHunZQ5pEnCb6KM_sOgA1LYnIzeeasj87DkJCffe4pEeQ>
X-ME-Received: <xmr:QSzqaee-p29QqJ5pFCrwyGPW8nAnHKMf6TwYv5WQJhLA-T_2pteoRNRTJaRtTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeeflecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:QSzqaScL1Sq18Ji3k7GR_C3kYOIwTh1a0PFju3Qj78BeO_ZPzl8elg>
    <xmx:QSzqaed187upZan3EjNy-LSBhaiFnb-MTjyNu9LUKy0oKQbHpoCdFg>
    <xmx:QSzqaTncyeMNfJ5ALD2DgO1g9Z-J-RxHSdEobw-ymjklGofzD8KSKg>
    <xmx:QSzqaY4AC_jLQKdRVHNzF20QADvHSu1BYwjzDWXX1FfophAEYFJl9g>
    <xmx:QSzqaTsYgpmlo_KX0645hdFuasUQnZhIXzPDXmrnjsJXqvD9u2A14MHU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Apr 2026 10:27:13 -0400 (EDT)
Date: Thu, 23 Apr 2026 15:27:11 +0100
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
Message-ID: <aeorZMvKwu8zKX5i@thinkstation>
References: <ad50rPOseVa-SP_s@thinkstation>
 <aeDoqFWPFxkkNB26@thinkstation>
 <1a499781-1115-44bc-adbf-2ac3769354ca@kernel.org>
 <aeFCuLJXT8VOkzH7@thinkstation>
 <4c635703-3d8d-4cfa-bb98-7f6f5fcbe547@kernel.org>
 <aeImfRrrvr3UoKtL@thinkstation>
 <aeTnlQUOOh-dHG8z@thinkstation>
 <34f75083-29a3-4860-8a6e-94551d37ac6a@kernel.org>
 <aed6fHLrIdahbdY3@thinkstation>
 <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77d559b-215e-460a-a268-e63b8273ef42@kernel.org>

On Wed, Apr 22, 2026 at 08:39:50PM +0200, David Hildenbrand (Arm) wrote:
> On 4/21/26 16:33, Kiryl Shutsemau wrote:
> > On Tue, Apr 21, 2026 at 03:03:56PM +0200, David Hildenbrand (Arm) wrote:
> >> On 4/19/26 16:33, Kiryl Shutsemau wrote:
> >>>
> >>> See https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git uffd/rfc-v3
> >>>

RFCv4 addresses all your feedback plus more :)

https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git uffd/rfc-v4

Still plan to post it after v7.1-rc1 (unless you want it earlier).

The patchet is pretty good shape in my eyes and will probably drop RFC
tag.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
