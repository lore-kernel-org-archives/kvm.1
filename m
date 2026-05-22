Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF746357D00;
	Fri, 22 May 2026 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466975; cv=none; b=okhAldVJCFhuQPhmIkFIeu12Zzadpw7SMOWMbLv/sWwjRYlor82lcxiEgsbp2CqAqSVu/e5KMQd0rwNkUrrKXIyAkknqRik1/A3KuXluy/BMhll0tuS3avpTnwu1Wh21JJdS5JkJV3YHVyRRhKE+VLpOxZ4vvS5rLXfj/0BkL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466975; c=relaxed/simple;
	bh=k5IIM/WuvVoj26e6a9CXnFnmxNMSYOY0Hr0TpIGocQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgloOIEBYddlBhzCy4rTjSjEjWxuo5YPnlWbBTc+mlDejDBA5E3hnUJA96EBVe+mBA8Q4WJipomxbYU9SgJhHQPl24y8WwAD3PHHAiPagDq9tTV4pmJ4+HTlrveDAF97YAWIWS+qq6mUXdD1ZgXHOnKeXS+WLRuCw69r8gOl0J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9ncAiIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9ncAiIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9271F00ADE;
	Fri, 22 May 2026 16:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779466974;
	bh=HXtVzRGfukj3ds6TKFAVxguxeD4B59V0+qCrjbHjkwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9ncAiIaKkIC41jHjldHTO64mB4wI8c0GQBAUaZ7pbkUURnbbZBFBMJvt8Aci8BGT
	 Nck4lSReIKDoa2M8c0zNRn8JDeGkDupbehwyEjZlz1RON7jXut8ZMMwlTjZrdnxJoE
	 vuzFL4xnuVKrUa+vIiC7rT9KHELE2x4jU3DS5dSSAn/mnfHiq8fgQINjfpHzMq7FHI
	 kHcmVoz1KVJpCzB3FpeYPHOlyYlEJv229WHmBTuErNcaTjsHonwGwE+k7aITxD3cqZ
	 vSgMSZJQZL4NarZCrLXAzcNr6W+5SUKt+/AyZdSp8sWPGjaGlFG8Gh0iCR+LJLarHW
	 rU0ij2TTeE4Mw==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9FE30F40069;
	Fri, 22 May 2026 12:22:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 22 May 2026 12:22:53 -0400
X-ME-Sender: <xms:3YIQardEGQLOXFYBnvSEETcGGZVXgEZW45Y5IxLqjXXPmZ3VT7eEDg>
    <xme:3YIQajhQLEBqcpNcIWu3gmlGGEH2Q-ylCLZfDODkoEB4gyCiypDHv5JoHR0-69TbK
    qOqMGoZfCcl1LxCmjBpJMtdn6zcbODvBPvuhb7u6Fo30xOp7Ertcv0>
X-ME-Received: <xmr:3YIQajPVY8PZPAj7DCZIF5qneg40bxfQPZGwqZ_MstdGaLOvGh5PVGXa67nS_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepfedtpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepthhglh
    igsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhh
    grnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtth
    hopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthho
    pehsrghthhihrghnrghrrgihrghnrghnrdhkuhhpphhushifrghmhieslhhinhhugidrih
    hnthgvlhdrtghomh
X-ME-Proxy: <xmx:3YIQap6uPiHgStdN6slLX3-6-wsZcJ-ZlBtbsEa5JMihJGDPMr0osA>
    <xmx:3YIQalVqyxMmX-hg356lqe_kxv-FN5yQC_0lqRuy_kXk-0d-G38EVA>
    <xmx:3YIQajFUUBtqxeNhQl_IWtAGMvThboSss_-8rn1l9s2iHjCsu7mDXg>
    <xmx:3YIQatf0ePI3bhJ-yeUkFvxe2eX-lLA7HR6vw692U5etBhhmTqQVcA>
    <xmx:3YIQallRHrCZuIyJDyJEBn-s6N882ow7iGqKd8wAmEHNL1CbJYwXwz_r>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 12:22:52 -0400 (EDT)
Date: Fri, 22 May 2026 17:22:51 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
Message-ID: <ahCCYYA-pfJC-QUu@thinkstation>
References: <20260428125632.129770-1-kas@kernel.org>
 <20260428125632.129770-3-kas@kernel.org>
 <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com>

On Tue, May 12, 2026 at 06:14:13PM -0700, Dave Hansen wrote:
> On 4/28/26 05:56, Kiryl Shutsemau (Meta) wrote:
> > +	if (size == 4)
> > +		regs->ax = 0;
> > +	else
> > +		regs->ax &= ~mask;
> 
> I haven't thought about this _that_ much, but this feels wrong. Why is
> is 4 so special cased?
> 
> Also, what _are_ the limits on the registers that 'in' can be used on?
> 
> RAX - n/a, no 64-bit I/O
> EAX - size=4
> AX  - size=2
> AH  - n/a no encoding for inb
> AL  - size=1
> 
> I'd find this much easier to grasp if there was a nice table of what the
> registers, sizes, and masks ended up being usable. As usual, x86 is
> "fun" here.

How about this for the comment:

        /*
         * IN writes the result into a sub-register of RAX. Only the
         * 32-bit form zero-extends; the smaller forms leave the upper
         * bits untouched:
         *
         *   insn  dest  size  bits written     bits preserved
         *   inb   AL    1     RAX[ 7: 0]       RAX[63: 8]
         *   inw   AX    2     RAX[15: 0]       RAX[63:16]
         *   inl   EAX   4     RAX[63: 0]       (none, zero-extended)
         *
         * 'mask' only covers the low 'size' bytes, which is exactly
         * the range affected for size 1 and 2. For size 4 the write
         * also clears RAX[63:32], so widen the clear-mask.
         */

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
