Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88536C588
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857826; cv=none; b=lt7RprehStkoUL21c97PzK2Wn8Tl6yyI0Od7/2aBdOXT6MIX7f5EepEJPWLQNWCJBrmXFKY6gPMpYBs3SZp5TlMoRdkm/zHfmSk4vPPmC0nW5oSA9xvgNGQw3ihRfyVJgrXixKarWPOyvRYyrydgwez0hZj3ckY/vbHTOnHDogo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857826; c=relaxed/simple;
	bh=uvBUzyxnz42wb0U4LHPBPPBfXKwhiaAt7waTOzUqoN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+lmOI+TH87Wwwr0ufP58B5QijGBTw8bhVvR5WbWT7OaLhvSofVSSYEN53/li5L7VRwz0eEuFMZbER7TTPL6nnfHrNpraPZsYuRXs5gyLdt5z7Gg2k8651Zb3nErSpMN4UkIzSkzxursAdvktI62hr9ipHJ8lrI9jJ+wUNuf7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QKsvl3rN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QKsvl3rN"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2995E40E02D8;
	Thu, 27 Aug 2026 19:10:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BbPUhiWxhJBh; Thu, 27 Aug 2026 19:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787857811; bh=Ehax0z/HhM5eiJQ3UInuwf0CF0OeCOneTSCBYi1h/PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKsvl3rNRvXPlU4/31kGwpoqo9Vxchpx8pFInjxTq+fvMjuzDIaK0RbtDwIl0wTP5
	 8tbesDfPeocmAK8v9GrmeAD4WlTk3kwrCHdpV2iA+ZZsTx6172UwhaJCoWonMDd8lC
	 8O8EU2HlWtQFbJZUT26LT2uZjUNnT0MtlAi9kl/Z/twnjx9UReo5YgVuQiriRlhFW/
	 xic7rxuf7XUkrIV/qUIAmYhQyRtSuckTlaG3VSp92NRnvKT+hU53wggupr1QOsQMSL
	 /MiGy822vftEzzICUUoinhIyCQlaJ/tA0AtjYYE1TJv7VR1nlbJDjNE/mQLuo0XkCW
	 +7C1nigCagu2mkrZ6dKE5l8uCx7cZQWb/RIkJDRTMpfNx66rJfq83Cx8/RaFqaSLCt
	 hwXXSINqUgxSs4y4M+C1xutcudgevEiaVP+AYFwckCkb+iGOgAe8wqVy9yaSOCsumy
	 ZHRJiWl7mHk/J9Jq5wY5HymNTAFmpXSKQK3D2zB0kLlXBc4imHVxAGEv5aGgdt/gNX
	 ve2qSZlDLmoR8NiCUb9YjrS73uZkLwNGf7FUpdjDUTE11MuBVrcBHQrVTse6uKnWBe
	 9b3AvduI0vXPf1v4JGonXPXThqST3wbG+LaKQ8I8jsHzuTrUmwgyhdvCOXca4rxsdy
	 eHYTOuUzx8/+hjuj79Vltdmk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E04840E02CC;
	Thu, 27 Aug 2026 19:10:03 +0000 (UTC)
Date: Thu, 27 Aug 2026 12:09:59 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: Process for doing early internal type review on the list
Message-ID: <20260827190959.GCapCLh78HiPef9Xhd@fat_crate.local>
References: <827b213a9482b417abb1d172438f0fdbfecd4c7c.camel@intel.com>
 <575b25a59231cfb7bc5fbaf4bbe45bfedad1e3a9.camel@intel.com>
 <apCJ3B8zlVImTiaV@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apCJ3B8zlVImTiaV@google.com>

On Thu, Aug 27, 2026 at 12:02:52PM -0700, Sean Christopherson wrote:
> Another way to look at it: would anyone (seriously) argue that changelogs are a
> waste of time?  People can read the code, why do we need to explain what it does
> and why?  Because anytime future developers are forced to make assumptions or
> guesses due to lack of information, the probability of a mistake being and/or a
> bug being introduced goes up.

Now I'm sooo happy that someone else says exactly what I've been saying all
this time. Here's my canned response I had written down because I had to paste
it over and over and over again:

|"Please, do not talk about *what* the patch is doing in the commit message
|- that should be obvious from the diff itself. Rather, concentrate on the
|*why* it needs to be done and why your patch exists.
| 
|Imagine one fine day you're doing git archeology, you find the place in the
|code about which you want to find out why it was changed the way it is now.
| 
|You do git annotate <filename> ... find the line, see the commit id and you
|do:
| 
|git show <commit id>
| 
|You read the commit message and there's just gibberish and nothing's
|explaining *why* that change was done. And you start scratching your head,
|trying to figure out why. Because the damn commit message is not worth the
|electrons used to display it with.
| 
|This happens to us maintainers at least once a week."

oh, and there's more:

|"Yeah, the goal is for our commit messages to be as clear to humans as
|possible, even for people who do not have intimate knowledge of the matter.
|
|And, more importantly, when we start doing git archeology months, years from
|now, it should be perfectly clear why a commit was done.
|
|So don't worry if the official documentation is lacking/lagging. That doesn't
|mean we can't do a better job and explain exactly what and why we're doing it.
|
|So please try to explain the issue in a clear and detailed way.
|
|People and you yourself will be thankful for it, trust me."

So preach brother!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
