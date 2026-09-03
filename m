Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD3283FDC;
	Thu,  3 Sep 2026 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408245; cv=none; b=kkDypGN9ent9DNBEKoGdMRHwzHQQR6Znilpkni2xNaer1y+zkJu8bliGD+wA03fvYkN/dv7X9s2EK9nbztuny4UMRF6NKs+0cvl9VAIopWpp9UMDhQxtGvJgAVjXpYe+zKeeLGXGGN1a0wEA2jd0af+YPVqm5zuKVxAvQpMkV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408245; c=relaxed/simple;
	bh=LUmXoc1C67fDi5VJnp4KcInKxgyiVD2SdZpN/nz8eXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7fqMxJXlpQGY+w30VrKA6AozvVvT9xuEjZXSCe4/rVnSK70mZKSuxckswIxem314kLMRFaKskJpm3wMTJnfAmrgfJ5xqzS51egLT/aGbHHla+H3av+FtO+pEVteOUwdwyVMltniuj21vkUpecE16aPMhkxCBPPtQRHvQpiTGK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pzsv5fSt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pzsv5fSt"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 424E240E02C2;
	Thu,  3 Sep 2026 04:04:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zdy0ZbA16YNR; Thu,  3 Sep 2026 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788408231; bh=7XeV0mEuifcWbEdGvyLniuY9lvwKVyb6NFjoKuT33/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pzsv5fSt9JkXsNLJu0vTswJkI/xvbqkqe9TrIugbanXEUow8ZxV3l2dMCwmKWzpRz
	 ZIX+/PAUh6bm+rrwgtn3MSA3V5aG6liI+jJX3HPcKGhNVV6NPcC8p4zVr6RU04yZJo
	 IxORvXpYm+YeDG+y3c87sOYx2XZtKUr2AsXkIEXPcvUiTJYmlPSGtSPnCl7MCH8XPB
	 QM8NvCw7h9JKXXPXu28Mm9IsKALo+24mS0gr7vnAmzdoACg4kUd/avG8bhhb5GtnmW
	 OKxtdRNhqvS8n/3dUT6M0A8iQsEbslABiUE3w/uk3x1vk3FRfEf1Vw5Zt6hsb3NBX7
	 YTkjWdk7YApAX9QuS7Zv/kHs9a3g9SkcHsbOCfUP88TXAljqdAnsPWyr7c1FLfcOX8
	 5BRT8MqVd3kzpJoRNlujwrmp5fxx2cczEqQFVuKstNXqZ9oVZBp5KNg3xzbXvBpTw9
	 Yp7foHCimYfMUsQ4YjPxVi6ChjGXSltmCaSGFQrfUaiKkOurx8G5IqRK+gEaDkHgNR
	 Ap0JqfuUU/EnPdzR0CoKR/vA/MdGBgbj2YsK7Y85dnzX1pFZogdUFB02um5Rys5LIn
	 Jz99PqpOMUlBmaVnXtAsyD+FSKSgk28eBGZpB7KNJcy/yae9JlMZHvoDXb4XpRloJL
	 gzmIRwTcaHY1qPUFwn9YA9QE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8037740E024B;
	Thu,  3 Sep 2026 04:03:34 +0000 (UTC)
Date: Wed, 2 Sep 2026 21:03:30 -0700
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
Message-ID: <20260903040330.GNapjxkgMd2Ey38egR@fat_crate.local>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826223510.3669875-2-kim.phillips@amd.com>

On Wed, Aug 26, 2026 at 05:35:03PM -0500, Kim Phillips wrote:
> spectre_v2=eibrs currently enables retpolines when SNP is enabled,
> instead of AutoIBRS (EIBRS) because the commit that disabled
> AutoIBRS if SNP is enabled stopped short of enabling
> X86_FEATURE_IBRS_ENHANCED.

This and the comment below in spectre_v2_select_mitigation() is somewhat
hinting on what you're trying to do here, and I can only guess. But
I shouldn't be guessing. Rather, the text should explain it clearly.

> Change the logic to enable X86_FEATURE_IBRS_ENHANCED, and move the
> decision to switch to retpolines in the default/"auto" case in
> spectre_v2_select_mitigation().  This allows the existing
> spectre_v2=eibrs logic to work as intended.
> 
> Condition that switch on CONFIG_MITIGATION_RETPOLINE being built in.
> Otherwise spectre_v2_select_retpoline() returns SPECTRE_V2_NONE and an
> SNP host with AutoIBRS available would be left completely unmitigated
> against Spectre v2 in the default/auto case, which is worse than the
> userspace indirect branch performance loss AutoIBRS costs.
> 
> Also emit a performance loss warning for using AutoIBRS with SNP
> enabled.  AutoIBRS is activated for all three eIBRS modes via
> spectre_v2_in_eibrs_mode(), so use that helper to cover
> spectre_v2=eibrs, spectre_v2=eibrs,lfence, and
> spectre_v2=eibrs,retpoline uniformly.  Word the warning in terms of the
> eIBRS mitigation enabling AutoIBRS, rather than naming AutoIBRS as the
> selected mitigation, so it reads correctly for the ,lfence and
> ,retpoline variants where another component is also active.

This whole text is explaining the diff. Never write about the "what" - but the
"why". Why does this patch exist?

Please structure your commit message something like this:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

And some of those above are optional depending on the issue being
explained.

But do not explain the patch. If there are questions about it, I will ask.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
