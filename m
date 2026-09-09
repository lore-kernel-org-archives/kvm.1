Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3813C0A06;
	Wed,  9 Sep 2026 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987696; cv=none; b=mdpEzGGQx7i07tJN3xNhmeYQHGrm5g9v1wjdo16l0O2t0MgsGfPoUSPxDS5+z2glHl/G9iSDJS0fevbwV+MCJqLx4OnBrVr4wBsnGULQxKpJC7JuT3datpiH1XdF9lpWGqGeZ08oAcEnaDhm0/5/PKMcgp9AbXRm4hLaTHEdDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987696; c=relaxed/simple;
	bh=7DD2c1iECmw0DK8Di/BukPP+DSRRMMlZjYNM85Qr9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fklamafVYV7Z2Z4QDTCS/RYb1AlCsm881781+LBz93RDRjlr5X/zMTz4zk2Km8UIwbyXzWHehSM/KcX3xAyVC2hK9N2IgbWjlmw8LJEXYgYlsaPztaO7PfVi6lO8GCTiH5/xdUwp0JjHn77XoyvkNoezRTQmbIQ4Ba/+h0EUE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jD/unM81; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jD/unM81"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B9A0D40E01E1;
	Wed,  9 Sep 2026 21:01:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id B6OV7LugChsZ; Wed,  9 Sep 2026 21:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788987681; bh=5tHpc3QKQiYiGvFzUyGwBZ7s7GkbfnMqR8lYHzRbEQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jD/unM813+DM4NGUfXKCxOiJChDCRYqLeGADTCsYWqxEr4FoNREuaMLY3wBO9EdqM
	 nhlVPWAo71D8JT/WAmC2cKeSlMeKVsowHUgI2Y7e9qEQht7z0/ClQLpNzuBL4O9kYV
	 GhXlUA9SfYNhcaj3d2Le7GUks1m+yDRuOcqH5G8QdkpcCy60YYUBZCW5y/Gy/LmgnP
	 aaRc0HEblXxpq3PtnP0I5urswE7e3NvKD9zUQUPPgmUWBZcGkM2IIudcpQe8438911
	 IHhcbYWUh1YzRUAsnO1N6dx4sG8XRfHHxhtkxthURu77lTQRSMs7NTWeBVebjEUuWw
	 2oD7OmkgCD/mXBCtpyICAZjgT2oKCR0cM0pMUoG01O4a1QYZE9yHQNeQSOK6M+/bFf
	 r2ZSl1pJRnxbdWVsp55KrCjazFv18SGEisDkKtBG0mYjKH4R+itm1Orps51hGp8V1h
	 nnJQEHIhA7dl4N3PtoAXqL85PVWK1qYF+un1XU3sW/BTLKFWujQuZbhVb/6VrpHtkr
	 Jt1b3rHruQAec9gtgODEs91/tzcvOeiA3b8xj9ZiQPyqRnNGxtJwEOHH4L2o01PSNy
	 1HFzlMHnm9nBcqYnxLa26QyPsApN3onjGcEFYJndxzhvOdHYFaIAZvk8e6TEd1l1pe
	 vLAXvPxopOBO2c5KyIYiCY4w=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D1AA40E01ED;
	Wed,  9 Sep 2026 21:01:04 +0000 (UTC)
Date: Wed, 9 Sep 2026 14:01:01 -0700
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
Subject: Re: [PATCH v5 2/8] x86/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
Message-ID: <20260909210101.GBaqHJDWSUnpjqNcyB@fat_crate.local>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-3-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826223510.3669875-3-kim.phillips@amd.com>

On Wed, Aug 26, 2026 at 05:35:04PM -0500, Kim Phillips wrote:
> Prepare for legacy IBRS toggling on AMD, where the BTB Isolation

Same question as before: why?

This commit message is explaining what the patch does. It needs to explain
the why.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
