Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998793AA9D8;
	Thu, 24 Sep 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214353; cv=none; b=KSRDQj3MU5TpZCP5E4FJXCsGiObi2J8Nt46bJ6S5/u07blGji467KfIj79QqYb+qkr1kUJP96RmoA8eFl0xysoQqvy9cixaoaAWhzhkdsuPD4TIin+jbg9Z3OkL1yqKnpHcTO9jzS7RKSY9dkLJXyo99ujFX7WeKG0OhRAJwfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214353; c=relaxed/simple;
	bh=aRRi6RHOjTOyCJ/5HtsiLAqhCPs9CduVQPKUndFydks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1wRhJEEUQ2RoEEYTdoFGSVyrcFpL5OMTICGI9rpj6l4teCQ+rXQUN3tiG0OZstwMpcFLH6a66lyMybth+AEFg0lKDP9jPFgI0KNvIqA6Su9/5+nOb/aoG8rtE5uOSElblmlPFp2efR1HA8MRwhz1TjcNlGYflmG9j+91CafcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dLh1rHhN reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dLh1rHhN"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06C9340E015D;
	Thu, 24 Sep 2026 01:45:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TvbiNa2KeqAs; Thu, 24 Sep 2026 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790214337; bh=K4Rjc0zg3eS2N5HthlBowVt5KP/fUl4gPGDlXBupBBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLh1rHhN3tOa99B2mh2ge76ptxzketW9gjSmLr8l4gv4G7u3hfzhmwMEK/7qkYe+D
	 yu3rUcu0HlmHG77mGrKWBMkhL6weYHntcHxtDbubnh7tGy/dKxh5qHeSzcCQo84Whh
	 Woj8NuO+PEQCztKPWVtV6gjy5Dy0nOK0KNEmCdkDQpqDvCcOTXJVPg+/hr/8C5CKRR
	 hcstMLw9/3BbWys5JTg55jVQnd2BcNhMgThsKXInjGprHCOTxBzLIOMJ8aFJ1LgRp3
	 REQZ6FCSo8hqKy6ZbJF7xnUKp2vprPm23KCE8uo915nI4GNhCMXk7Liy1W6Hloni/D
	 kSLWxEcTP6zyKg9KzbM9Ra/8dv/dmUsDKB+z4eowVONp8ATdVuP4vsMkjDlwDGmieW
	 XkYc//1wAKjfMfdr42s+rRCme6T8/qI56Knz/+iy2s7y5B212R52IPYjviEjVK+LeO
	 Hjru5IfRfhPXrx0VMTT06X0kIXNqAamSCKyhyZzWb+YZ8KMmJltuQf+d84rIM1MUwq
	 ARqkW6uXnxiYyl9EWpIyfSy2qMxkbaB0dHFpVswcZlCRKiZKAcuJEOYuqoLda7NBfI
	 wucrymXTfFqXfvE2clGg5agfBWVeTRre8xW9f5YQF+KhlSJLBhk1MyVfGyX2ZEfJCr
	 QCwzwfsHbb5e6dOG3OHtvnoM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BB7540E00B8;
	Thu, 24 Sep 2026 01:45:21 +0000 (UTC)
Date: Wed, 23 Sep 2026 18:45:17 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Fontenot <nathan.fontenot@amd.com>
Subject: Re: [PATCH v5 1/8] x86/bugs: Allow forcing Automatic IBRS with SNP
 active using spectre_v2=eibrs
Message-ID: <20260924014517.GEarSArVM12m_ZshhA@fat_crate.local>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-2-kim.phillips@amd.com>
 <20260903040330.GNapjxkgMd2Ey38egR@fat_crate.local>
 <01b57e61-df45-44a6-848b-c19eae226ad0@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01b57e61-df45-44a6-848b-c19eae226ad0@amd.com>
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 06:00:21PM -0500, Kim Phillips wrote:
> That fallback cannot be overridden.=C2=A0 An admin running an SNP host =
whose
> workload is dominated by guest activity rather than host userspace may
> well prefer AutoIBRS

Why would she/he prefer to do that? Any persuasive arguments to make her/=
him
do that?

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
