Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAF83A6B9A
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773925141; cv=none; b=uSw8xV9eXq1QPuhMdiBaUJneLgL4Z7T3ELeC+nbrBNSQABYlID0ThAmwfOL/4EL77ILCP7iD8VQmdMGtEUdT1K+C5aO/5P2FCcIoFB58nqYreGMfJ/xU+FNFfCsIUePnu/stHjVbdetFNidJDw6wRKdXs3/3ZwJUBjjAmlsV4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773925141; c=relaxed/simple;
	bh=Y9qsyfkl3sYMNjldvTWvMtzLcpWYmAQhkmy29ttSrBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaL5kKT9q5iI56l9wnfD/5RCGytCz5k/J8Ka648Cc4ThGvBOr3aICHLYAaePvO2Zx8XvXfGLM5laIKHjdzh3iGnETYL6sz7pfU4vKDpgQKl2HWQ0yh2OqPw9/aO0DP6R8GxjYsDW76n38J8ejxskLft36AOGnUCPH1BPBCjIA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpFCab4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpFCab4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87902C2BC9E;
	Thu, 19 Mar 2026 12:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773925141;
	bh=Y9qsyfkl3sYMNjldvTWvMtzLcpWYmAQhkmy29ttSrBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpFCab4FdRGsLyKzXmNyGgJ6C8ew4Kqjr/RfnafurGmCIHHQJY6jIzaxfETy26Bkc
	 4nZbmDyPHrDGqIiOish8eDjUI2vsYfmnN7Z6ng7LfdB1vLwv8BBMdk3lDF3YOEZlsQ
	 irvPOOd2QbeotnRFX9FYGCYx4EpXJwHt1Z1Y/oMR6roONaKcGYlf6wib2H0T0Dbgef
	 Wyz9YWLN46e+AuRLSt9/s33XwIS574/4T3BSzq8YhM6dVwpwLy1UY3Pu410zce49sY
	 SyVbnZWEolSvQmmG9WJSur3mGJHdcbxPYrxa5+g4C77C7C0N1O4saligQyWOML3V1e
	 fTY5liGiPBghw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 423C8F40082;
	Thu, 19 Mar 2026 08:58:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 19 Mar 2026 08:58:59 -0400
X-ME-Sender: <xms:E_O7aZVd61gAuRmejkGDiDLCjv9Xm7CAYxhbuiRBQj62IzdvqEyRmw>
    <xme:E_O7aaTC7rIp1A4vYDwXNFIx7CXR8-I8VmRHdjIFv74N2PEqOFf06rdj5TAeJ_1_9
    6-RatSWfiiNsE59JLawPyBXyu8MWkDZf4JUPjvuvw6ZKWRle7D_jxA>
X-ME-Received: <xmr:E_O7aQefr4g1a_feWZ-bJe-I_zOh9-i_YUner3mqsef9g5i9CxvDmlczHJeD6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegthhgrohdrghgrohesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdgtohgtoheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehkvhhmsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghinhgsihhnrdifuheslhhinhhu
    gidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghnrdhjrdifihhllhhirghmshesih
    hnthgvlhdrtghomhdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhi
    nhhtvghlrdgtohhmpdhrtghpthhtohepihhrrgdrfigvihhnhiesihhnthgvlhdrtghomh
    dprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:E_O7acXR6woc04DX41OVa-vtO-7jVv0XH7sHrsl-EvQiy4KE3yXjmA>
    <xmx:E_O7aWjYzc48pgwLOl1jpSld7qedhFpugIaZh7xPA93j7_Y-PucxRw>
    <xmx:E_O7aaGfN7UV5WFlg0FNCJYvRc_7XD2PMuFC_bT0xzKsmcSQn0cmzw>
    <xmx:E_O7acLBoduDr3A64QlXQ13LnALBJlyO1il7G_fRgi_WrjrIdtlsrg>
    <xmx:E_O7aSsMFFlDEZ5mNE5Q4-yGq5Z8as6Ix9znylvwJ4nB53aezuNJVqfy>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 08:58:58 -0400 (EDT)
Date: Thu, 19 Mar 2026 12:58:38 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com, 
	dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com, nik.borisov@suse.com, 
	paulmck@kernel.org, pbonzini@redhat.com, reinette.chatre@intel.com, 
	rick.p.edgecombe@intel.com, sagis@google.com, seanjc@google.com, 
	tony.lindgren@linux.intel.com, vannapurve@google.com, vishal.l.verma@intel.com, 
	yilun.xu@linux.intel.com, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 08/22] x86/virt/seamldr: Allocate and populate a
 module update request
Message-ID: <abvy8dyvtjfDqYQC@thinkstation>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-9-chao.gao@intel.com>
 <abkvOYQIi2RvEYh8@thinkstation>
 <abpnWkENgaWoofZV@intel.com>
 <abqFJZo632DAFsl_@thinkstation>
 <abukxFDD3g0sKYXP@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abukxFDD3g0sKYXP@intel.com>

On Thu, Mar 19, 2026 at 03:24:52PM +0800, Chao Gao wrote:
> On Wed, Mar 18, 2026 at 10:58:44AM +0000, Kiryl Shutsemau wrote:
> >On Wed, Mar 18, 2026 at 04:50:34PM +0800, Chao Gao wrote:
> >> >> +	ptr = sig;
> >> >> +	for (i = 0; i < sig_size / SZ_4K; i++) {
> >> >> +		/*
> >> >> +		 * Don't assume @sig is page-aligned although it is 4KB-aligned.
> >> >> +		 * Always add the in-page offset to get the physical address.
> >> >> +		 */
> >> >
> >> >I don't follow this. If @sig is 4k aligned in VA, it is page aligned.
> >> 
> >> Dan's concern was that PAGE_SIZE is not guaranteed to be 4096.
> >> 
> >> I agree that PAGE_SIZE is 4K on x86 today. But to address that concern, I saw
> >> two options:
> >> 
> >>   1. Add WARN_ON_ONCE(PAGE_SIZE != SZ_4K), or
> >>   2. Handle it as in the code above.
> >> 
> >> I didn't find existing code using option 1 in x86, so I chose option 2.
> >
> >Please, make it clear in the comment that you are talking about PAGE_SIZE != SZ_4K.
> 
> Sure. How about:
> 
> 		/*
> 		 * @sig is 4KB-aligned, but that does not imply PAGE_SIZE
> 		 * alignment when PAGE_SIZE != SZ_4K. Always include the
> 		 * in-page offset.
> 		 */

Ack.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
