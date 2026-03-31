Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E592C3251;
	Tue, 31 Mar 2026 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959515; cv=none; b=kiVOGUsGViI38+aLYK/z6tx9HA1kaxuAKoXr5p8gv9I/VFS8YUO5cFjNfK1ngqhMej8H34Qc5UmJWG0g/1KkH/8Hk3+dOTThiH1+7I+fAPFOVePQXVEhnYP4MLZqwJuiyatGP9xWihK+IWy4i/GJtTOTDPqc81Iqdh/TiJ+Q4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959515; c=relaxed/simple;
	bh=teZUV3UccgrPMbQtqYxbYpNuB9GDFPysvlry78HmRcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duWwC1ChdR9wb8jBe48PMaSYF/5xZeeMjvbw4j6W4edns4P71KwllVU5yzm0ZQj76Y8BqTa/EecMZzCmSpRouNqZDT9H7z/G1JPrSntuwzR3jFvQjOkUxo47oOzHMkdyksn3Bt0uxYyPa+nqrZS026QMXoLXrMZ2MBjPSukMDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWqsHcTX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWqsHcTX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE741C2BC9E;
	Tue, 31 Mar 2026 12:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774959515;
	bh=teZUV3UccgrPMbQtqYxbYpNuB9GDFPysvlry78HmRcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWqsHcTX6vHg8TDtr+uxhYxa4QW4o0t9/Q/jQvYYL3Z4kkMrNdxD4K9c+hcfXDuz0
	 rCLtIwuwc4yNvTVtFhUrlPAu9RhgKsZZRqrwe+I/gdCrHRWV1qmoj049Nm6n6669Yc
	 yTF4QF8itjhQo7L7Gt83e+0L+tp+dD8OtgD0weOFt0DvPjzTP18MtHOPQ/kIeAAx/5
	 F0RyQXh6ZbS1Q8vMzQdCFqQmP1seeArhaToEvY7oBiZTEXpMFFoEYJuPM77XBAsCx/
	 XYJqQPGcCM707wbzNk/hzkUqRw55adhNfl/EiBwYBaTHYVaUZ8Im7LmKF8eGDRsAPX
	 vsg1gkfXIIBuw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 16F3AF4006C;
	Tue, 31 Mar 2026 08:18:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 31 Mar 2026 08:18:34 -0400
X-ME-Sender: <xms:mrvLacfIlFoDGDTudoxyA-lIz6ngUBQ-T7DKUlPsyHR4_xWP5liKAw>
    <xme:mrvLaXh4jthjo1J5axeBYKvQ_UkFIFKrfC4XRMxKk3m7XxcZkYBMcNDTBKqZVXFJY
    cRbxINZ51US9z2JjbG4YfrKBFoxlj5I6c3-9YL7WzHz-dImdoFThwY>
X-ME-Received: <xmr:mrvLaViEVp0oBk_OXSmKLGTjMlINL85rauUiX7saascZOjZ1TjNro6HV7xJt2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    euieejieffkeehfeffffdtkeelfeelhefhfefhudehjeehvdffleeuvddufefgkeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllh
    domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdek
    geeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmh
    gvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    rhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpthhtohepvh
    hishhhrghlrdhlrdhvvghrmhgrsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgvrghn
    jhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihiht
    ohhrrdgtohhmpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:mrvLabrI7E3o_1O_lW6dMdBxpWHJQdR6f4vEPxhJiesSXUd49njkKA>
    <xmx:mrvLaTw9kuXWJUl2kMb7YsM_s5zlbPPIFny3yXZ8LYJbB3RASeYj_w>
    <xmx:mrvLaSxSj1WrF4UTxfL8_Ak6qX3zRvWHYdNc3mP6_bKFd3psuyZrqg>
    <xmx:mrvLaTabDaTsFqvXTc2LCeHpQYbYeJanqujZzeS0ewQwttCnytxOpw>
    <xmx:mrvLabmjtkyonaToYfz8NRvbsiF3BkTDUbntfQN7z1RDbiGLm7KCz7zs>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 08:18:32 -0400 (EDT)
Date: Tue, 31 Mar 2026 13:18:27 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Verma, Vishal L" <vishal.l.verma@intel.com>, 
	"seanjc@google.com" <seanjc@google.com>, "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Message-ID: <acu4raBTjdFcfVlS@thinkstation>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
 <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
 <acpiGUKS-WRmLoxp@thinkstation>
 <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def1f4395865ad0d22be245647fbb75ab8698ab8.camel@intel.com>

On Mon, Mar 30, 2026 at 07:25:22PM +0000, Edgecombe, Rick P wrote:
> > I assumed that if the SEAMCALL fails other SEAMCALLs suppose to be
> > functional. Hm?
> 
> The behavior should be that once you make this seamcall (assuming it's
> supported) that no other seamcalls can be made. They will return an
> error. Do you think something else would be better? If it's an old TDX
> module, nothing happens of course.

I guess the actual behaviour is dependant on the return code. It is
obviously going to be the case for TDX_SUCCESS. And from the discussion,
I guess that's true for TDX_SYS_BUSY and TDX_INTERRUPTED_RESUMABLE.

What about other cases? The spec draft also lists TDX_SYS_NOT_READY and
TDX_SYS_SHUTDOWN.

I wounder if it can affect the kernel. Consider the case when kexec
(crash kernel start) happens due to crash on TDX module.

Will we be able to shutdown TDX module cleanly and make kexec safe?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
