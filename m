Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E4272E53;
	Tue, 11 Aug 2026 00:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786409323; cv=none; b=tyj6GZtWMObsvEQyBZJxJNmuSANMqv5hPpkm5uEsC2BkWUYenBLqheC2JXKC7cQI/IWIOAK87fW+xEIPca51SpJyTngA3w07P+Wesrb8Op0Xg82ATgWNXp7LST1JNoRbWrrc7eScbpceHhSTFrkKa9bgD0rhlBjI3qNux6qKKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786409323; c=relaxed/simple;
	bh=aFLKnD4RyrnjnEy2C7KByROLR8PVul4yulNf+iMKEJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y57szTMkuX2vO6pGbJoC4o7xoLP0SK65kmOW7UguJ4XXTOSFOxYvwrJmA8wNTnStMcOlVOdeN3z9xvrn+c0VYBpPlV5kCXDFn5HWT42CKEmgMvmdWbNXfdSXB+rssvr0Bj81tvgVtsk9J4g2T56VlMxGYhezqcWqcqU+M9uKTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IndAzZhA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IndAzZhA"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C038440E016E;
	Tue, 11 Aug 2026 00:48:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 30rMol4bSe5a; Tue, 11 Aug 2026 00:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786409307; bh=qjPsanQYvcnyxe6McAIhVGiqKp36zLUKRndgaaBUEmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IndAzZhADTxNDH14FBy8abekhCP7W8NqZ+bYP/T01Yh9k4p6SMVy2MxWkokjk9a+3
	 BIO7mi2uE4MVfAlSsprahQs8UVbS8qEQ1td2dmSmKbi9ztztVR2tTYUazHbhpSkjvW
	 D59PGIbkRaGE13leiZrSd0CPWmAOJXR9ozPJ1WqgEuH6WzIHptwikvs0J01wwM6bMA
	 PnzFSViuXu/7/n93qeWPDoSvOiwrdIcWNYtbjPbapbDGfqVwepGoqvVIatXt+EXmRh
	 rf6TlMFseIqkP19v5oZvLJpA0Uhv3xLye2c1TRxDvSr1BJkOJC+7rUzkZdZwruW/bY
	 4giuvQv0lMAm0n9zsjBERMQVLiwO0XelJsE+iRkudlbs2LjHBqnMgFBZwGBQksh3KA
	 vvOIx44P/u3Z7MFZRcSWHpDiINbvsS/tuY85C2GSx/GMD7uwqXq9VdVK43tX+HA2K/
	 eaocebDZjoEPMSirv82REECF9CS7lVC9oswNjUUtA/jHrD5aZmUaPI8s2/woa+Qn+U
	 h+fyqULbDRxMOEEyrhjnZSLhUcFGC/tldFthypDQnvWAaJxIHPEXisDoXthjkyKX9z
	 d3IevFyog9QzVeLU06DkGlYl5HzJP8JJgyyOh3lLrPZuomYJh0WkWiOs1jdCBxVA7E
	 rm3cLQjAZSMnd9/OXfUHXGc8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 309CA40E019C;
	Tue, 11 Aug 2026 00:48:12 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:48:08 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v4 01/10] x86/bugs: Only log missing retpoline when it's
 actually the missing mitigation
Message-ID: <20260811004808.GEanpxSO8Kct2DKZFW@fat_crate.local>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-2-kim.phillips@amd.com>
 <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
 <65d82937-113d-405b-9399-b70973e84c50@amd.com>
 <20260805224907.GDanO942iYDbai1kFx@fat_crate.local>
 <9e5183be-1f31-4f6a-8b91-0f9a92590241@amd.com>
 <20260807054443.GHanVwy9MnwWZQvfdj@fat_crate.local>
 <330aca04-b3ac-42ad-80eb-0a00c6d6aaf2@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <330aca04-b3ac-42ad-80eb-0a00c6d6aaf2@amd.com>

On Mon, Aug 10, 2026 at 06:21:01PM -0500, Kim Phillips wrote:
> It fixes a bug.  If you don't want it, drop it, but know that sashiko
> will continue to complain, and previously you said you had wanted
> sashiko comments addressed.

"Addressed" doesn't mean "patch applied so that some random tool doesn't
complain anymore." It could also mean: "noted, but the issue is not relevant
enough to do a fix, all things considered."

> Meanwhile, please review of the rest of the series.

I told you last week on internal chat: "You don't have to hurry anyway,
though, as it is too late already for this cycle" after saying that I will go
through them.

Did anything change since then?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
