Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6572877E8;
	Thu,  1 Oct 2026 00:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790813587; cv=none; b=A6NKwFRFySizdOXTPt7ma0EWZdfi/RVhjxT/h2nAxHTCCETE/5cXHbk+cugotTDKkCs2SxNeu0xTnIEVb5xqj7oftqLspjo8WqmHLumB9iU2B2YOdK0c+IDD5Fb9d7+HdqvangBbsNxLpyhUFKrIDJjrs3R9dRRPyYFErwO4N2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790813587; c=relaxed/simple;
	bh=EJyylGk7CMmOpoOB0TsYeKYntilnjdMHKMHgiqCuBuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/4/M6uSFhhma5MXNsOoQ9qhYfxie4IfDwzOSoslbYf7KMEYsR2b2HzxZMJ/guEFIuTZ3mbSQLQmvL6wPgWaQ+qCC956RDnFse0+VFdPPeWFT9EwiacOYnN0Nwea4ylVwL8+93JXsE4aQyJafMAxDPPKW9bbTUkYZi7bZNRaS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=J94RFyPm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="J94RFyPm"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EDA1240E00B9;
	Thu,  1 Oct 2026 00:13:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vg-FyTJpARwD; Thu,  1 Oct 2026 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790813570; bh=92PF3oBMmxvqFIgxYoPM8pcEWiM9YtwmEdtE6BD2DIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J94RFyPmoR45hohCd9gKuPKbhPVaRzX70dELpsEkG5yvA5aV7LuoQlB2Dv/y7KGlR
	 lvFjs21MtHD/xl9OwvTrNjPiIWmq2q0C5WDq4PhFyDRek2GEesCC1S+JGuxSepp+68
	 T1vaFubDNI8AyLAmPtFAVB4BrkiyxmmOwCHQuXDHz7Ds2DrxUM+BPd1053Inda97m/
	 SX4UyTdJ8TlW5b6OhPl540nYTcMD99yLD6w4sik+DmLcRbkthOC9LwBqMOWhKdAYgz
	 WepzSraDJzkgI2K3tKvvLZUh2Et3qZgS+gROtJmJzYObl4atYkXha4elGhBqg3pykZ
	 GnOXI3gs2NWVpFQQcCCDUJLdmqsJdrAR+Zn3uS/HYxk3/U6Wn9YWknESKkUdSxrINT
	 vblCXJWsMCggdpG5c/BKz69L5e1htg4OZLAAHFzfAOdUAW9j9EPHWQ4rRNpus9ELH1
	 KLUt2hlt5190ZKiS9YOnbIzyuKvJVLo0qditsF4kLJ1KZpz2gWvqKatpc+3nPHLQpf
	 BddoFPzuLywly/En2tgO3oCYVNyBn9aRv63irA3WBpZqKjjcCYKR2zoKNACpu6mlfb
	 OqWNKIw9bbucpxU2d+5AOY85QWX3P9l3hrsl28U0NbO4OjYtA0lHOrhBx7TKKjguMN
	 BMvmzqyEVJXI9D2sWElFekVI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C44840E00E7;
	Thu,  1 Oct 2026 00:12:33 +0000 (UTC)
Date: Wed, 30 Sep 2026 17:12:29 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kim Phillips <kim.phillips@amd.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Naveen Rao <naveen.rao@amd.com>,
	David Kaplan <david.kaplan@amd.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nathan Fontenot <nathan.fontenot@amd.com>
Subject: Re: [PATCH v5 2/8] x86/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
Message-ID: <20261001001229.GBar2lbd9fQ-6j_Kue@fat_crate.local>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-3-kim.phillips@amd.com>
 <20260909210101.GBaqHJDWSUnpjqNcyB@fat_crate.local>
 <9b85be41-db5a-4bdb-95b4-beffb05a5ffc@amd.com>
 <20260930030650.GDarx8yvplZzQtGDBz@fat_crate.local>
 <ec3073de-74b5-4321-8ca0-5d00ac288816@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec3073de-74b5-4321-8ca0-5d00ac288816@amd.com>

On Wed, Sep 30, 2026 at 02:50:23PM -0500, Kim Phillips wrote:
> How is optimizing the VM exit-to-re-entry path not "*actually* useful to
> users"?

Let me try one last time: 

Back then we did this:

commit acaa4b5c4c854b5009f4d4a5395b2609ad0f4937
Author: Kim Phillips <kim.phillips@amd.com>
Date:   Thu Jan 25 22:11:02 2024 -0600

    x86/speculation: Do not enable Automatic IBRS if SEV-SNP is enabled
    
    Without SEV-SNP, Automatic IBRS protects only the kernel. But when
    SEV-SNP is enabled, the Automatic IBRS protection umbrella widens to all
    host-side code, including userspace. This protection comes at a cost:
    reduced userspace indirect branch performance.
    
    To avoid this performance loss, don't use Automatic IBRS on SEV-SNP
    hosts and all back to retpolines instead.

Now, in order to be able to prevent indirect branches from influencing other
indirect branches in another mode (HV in this case), one needs to be able to
switch to plain IBRS, which brings us back to the toggling of the IBRS MSR
bit.

I.e.:

"After setting IBRS to 1, if software subsequently

* clears IBRS to 0: The processor may allow older indirect branches that
 a occurred when IBRS was previously 0 to influence future indirect branch
 predictions.

* writes another 1 to IBRS: The processor starts a new window where older
 indirect branches do not influence future indirect branch predictions."

So in order to allow that, you need all that code complication from your
patch.

And, for the Nth time, I would understand if there's any real justification
for adding all that additional complexity to bugs.c which already is
a nightmare to maintain.

But so far I haven't seen a real justification for it. As in: spectre_v2=ibrs
on AMD is good for cases A, B or C and this is going to be used in this and
that scenario so having that capability upstream is worth the added
maintentance effort. Not it "might be useful" to users. "might"'s not good
enough for this.

And there's at least a *suspected* perf impact here which has not been
measured yet. And no, not with some script but with real workloads.

And it is perfectly fine if those workloads prove that some of them benefit
from this setting.

But because there is a potential perf impact - impact which we have not
quantified yet - then this is not ready. We need to know what that performance
impact is and that needs to be documented so that people can make an informed
decision here.

And so that they don't come to us and complain that this setting is causing
performance issues and everyone needs to stop the presses and the world is
ending.

These are basically the same two things I asked you for, this time I tried to
explain them in more detail.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
