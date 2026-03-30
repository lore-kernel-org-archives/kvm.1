Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B79382F01;
	Mon, 30 Mar 2026 12:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873798; cv=none; b=lnnS9vOzgJIuiHPYXcpuLE23LkkCPcf/YanbY1XsFAWjan+7PSQfqkHvRsakdM3trG0ahH7EvEFvm3Mh9nUrwNsWVbgmMQ3vjEwbxgBKgEapei4HLLf4F4KWqQaAyZXDZIx4YHNHN6nE+HBYfpriTVj+uPyXmGSmL3k/3oNiidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873798; c=relaxed/simple;
	bh=YI9ngTKL0hM0XLThFYbjiFmYCp4kFJt7PwEH2IVxP80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2sAZq6otDQnpSWktgtB0SJmWdrkCVOvtxn09/dEn4OGl6kkIQUWF1EptZdYg3Ui+2OlRDakyhnyWdh0jSS3T+/ObiWTwBfRFwfjWCCAym4bg37/tXt1tIKoFnr4jcPEgWe/nvk7Ufr79DzQKxoI6Y4J/ZQRLxDMCaZhrGjl99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld2s6wKW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld2s6wKW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA46C4CEF7;
	Mon, 30 Mar 2026 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774873798;
	bh=YI9ngTKL0hM0XLThFYbjiFmYCp4kFJt7PwEH2IVxP80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ld2s6wKW+G0Zy3B92sSrulA+nNI4FzEuK2pDw5S76M8aKf/gRWR1KqqamUaYRanut
	 MUFGzsy6/UE4o/H7RM1THcNedg1b5VODp2RyLFw24z1sWWUa+eOMMu0glGlcGoAOPI
	 o+KZPxl//12SVhqsytZoUXXFwQvmc1atH1/DyU/I/8eozh4pknlDk6KYaxKDxm00cp
	 rjyvRdF3fHialfAsb/XgAHkkPgXLz0BvB8xD5GiKHK3eyD31FTlpEocqTlaNuVY7H+
	 7IsxGgCrjh/Cew2qi8vbUXqFSq94h6yz4BVkbo6XeiS6u8vBYjSnYd2JME3nQrdQ3h
	 hkTHEG3KDbJEg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 42AE3F40068;
	Mon, 30 Mar 2026 08:29:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 30 Mar 2026 08:29:57 -0400
X-ME-Sender: <xms:xWzKacsnxPy-4lpQzn63jTqrVryceyzkT17tf7-Sw1e24ltX7xqoQw>
    <xme:xWzKaSyFx4VaPaYJmU2xFaAslXajQ-ZvHG56a8-f4Sy6I_h4kd71VQAQMcfx03mv5
    5umTOpaZtnX56OkAdLQ7VavotAvgCS3vEsZ-an_kOZFhzmgC3BdBw>
X-ME-Received: <xmr:xWzKafyk-m2DFVKeNjRrRLdDwG7TEmj3ycWPoM-Z_7eRB2Pcx6cseeGOoi2pmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpefhvdetgeehjeeugfejudehveeltdfhleettdfgvdfhudekvdeltdevudeihfei
    heenucffohhmrghinhepmhgvmhdrphgrghgvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieduudeivdeiheehqddvkeeggeegjedvkedqkhgrsheppehkvg
    hrnhgvlhdrohhrghesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihgtkhdrphdrvggughgvtghomh
    gsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    grvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehm
    rghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmpdhrtghpthhtohephh
    hprgesiiihthhorhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-ME-Proxy: <xmx:xWzKaY4GUugIx7YUMTpnQCdApdGV8XrFga9MRfHAk7PilZev779xog>
    <xmx:xWzKaYAIqm88zSs1LSD9oB3WKmQL8_onzxZBBrOH9aJVs06aL3tgAQ>
    <xmx:xWzKaSD2_9zIWUQ80ZKlBD3nD897rHyh3suKSg0Gbs7LOAVHMmOSQA>
    <xmx:xWzKaRqiQD99_24aWSfRdbKMglD-WT9I0rCeP71hG1feUgmLNx06gA>
    <xmx:xWzKac1q0Uti6lWT3EV7XhimSrpZ1CCfbyQOXYNZ5-fXKYV1emBAnB9L>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 08:29:55 -0400 (EDT)
Date: Mon, 30 Mar 2026 12:29:52 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "Qiang, Chenyi" <chenyi.qiang@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/tdx: Accept hotplugged memory before online
Message-ID: <acprNlPP7J_ttMrz@thinkstation>
References: <20260324-tdx-hotplug-fixes-v1-0-8f29f2c17278@redhat.com>
 <20260324-tdx-hotplug-fixes-v1-2-8f29f2c17278@redhat.com>
 <56190adc345148396ba6b3e52672e662145f7dc7.camel@intel.com>
 <CAMxuvaytU-pM+rviUbNGWMhvbAYutwvaSXW_O=sn+QfOzF35Xw@mail.gmail.com>
 <7802b50589c80a7276a50cc473c1aa579750a30c.camel@intel.com>
 <CABgObfZ7_w8Q-dW=Sd4YA3P==BuN1edPv7Ty4EpPyU8ctW6RLg@mail.gmail.com>
 <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <424048885a01dcb6a7ef0256f0dc8a9adb546f22.camel@intel.com>

On Thu, Mar 26, 2026 at 08:40:06PM +0000, Edgecombe, Rick P wrote:
> Hi Paolo!
> 
> On Thu, 2026-03-26 at 19:25 +0100, Paolo Bonzini wrote:
> > > Another option could be to perform a TDG.MEM.PAGE.RELEASE TDCALL from
> > > the guest when it unplugs the memory, to put it in an unaccepted state.
> > > This would be more robust to buggy VMM behavior. But working around
> > > buggy VM behavior would need a high bar.
> > 
> > Wouldn't it actually be a very low bar? Just from these two paragraphs
> > of yours, it's clear that the line between buggy and malicious is
> > fine, in fact I think userspace should not care at all about removing
> > the memory. Only the guest cares about acceptance state.
> > 
> > Doing a RELEASE TDCALL seems more robust and not hard.
> 
> I mean I guess the contract is a bit fuzzy. The reason why I was thinking it was
> a host userspace bug is because the conventional bare metal behavior of
> unplugging memory should be that it is no longer accessible, right? If the guest
> could still use the unplugged memory, it could be surprising for userspace and
> the guest. Also, ideally I'd think the behavior wouldn't cover up guest bugs
> where it tried to keep using the memory. So forgetting about TDX, isn't it
> better behavior in general for unplugging memory, to actually pull it from the
> guest? Did I look at that wrong?
> 
> As for the bar to change the guest, I was first imagining it would be the size
> of the accept memory plumbing. Which was not a small effort and has had a steady
> stream of bugs to squash where the accept was missed.
> 
> But I didn't actually POC anything to check the scope so maybe that was a bit
> hasty. Should we do a POC? But considering the scope, I wonder if SNP has the
> same problem.

Doing RELEASE will be required with TDX Connect in the picture.
Otherwise userspace wouldn't be able to pull the memory out of TD.
So, let's do it and drop the first patch.

We can suggest that userspace actually remove the memory, but I don't
think it should be part of the contract. Userspace might have a reasons
to keep the memory around.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
