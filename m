Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0B33F8B1;
	Wed,  5 Aug 2026 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890714; cv=none; b=Y2mYRQNw70Na1S9xUpxHf852mYYdZIaBtsPiCwrVPcImsi2VWnzJSO9aAd171aXf60OshNEwM3EdAdixeSAo2p1xZXyFFi98+8oMpdZIYqJsigip5fhM7AxO6l4oSuvwZsLFhUX/4mR+OqodhTpAlrZh054nUCeoKPkPyTimvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890714; c=relaxed/simple;
	bh=2FqqpqrMiLh/534TCcOdGxt8r09/4sRomYo5XCHm5tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4m7VjGEE0HjXkNCqX1NF01Y0sghhgvnuoXCw+GARH0sugLYXsH7+mDKU24ziQ85V9kGveJMNvyVW80dskHYMKc3DaArtpM/ZBi8TGAuHu8fa+BMJSApb1IEbh5ZpYei4lrMoHd8dZYLuU1d3Vc/c93Yq9+Ve5clbhv2vzhbX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DaJE3+H1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DaJE3+H1"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 520D240E014A;
	Wed,  5 Aug 2026 00:45:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 55nEz_bmw26Z; Wed,  5 Aug 2026 00:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785890700; bh=6Dltynf3hrVUO0HJCc60UWNi7IECzyisxqB1tEwAGZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaJE3+H113DkAOykYV/Jpz2vLkAGpBUPVfLygtXYS3Apx5hagBITTQ6JP0sXhaxKf
	 s8GBpmfmzvgCbV1ieGleB+OW8ZzNhkeLKsB6KZPZN5Z8bP7dfFxB+G7ZRRdbRXUPzc
	 2+LkDTK2TVqCZNa9IR+lvsEdjVxSQNqjmOeXHmLkNFhIeNYP8ToEaHz6ie+7KjEsf2
	 DzedcMH5eLdga1O4t8NDWxJ1b3H6kX24rSJtwTc6FKjQrc55iIBore+eCDC1XRm5/8
	 y1mGFRlFPaz+wb1z5IsBcmmC++qozay053Rt5FhxmCUCIKhPlU35Gbx72rDrcVAEUE
	 gYQC5ot/QLT7bug6dU3nZoOEpciUvQqLvA5zkMhQAXEhrxrewyBWmiTiZoFU56ZASK
	 xPFjtZZaP0mf4DqNIG0zPSXmZJcXx3amnM36DA+YqEqiTdQ8sFMksUyoj2gDsURHtp
	 Hyu2fePp7fFhYp7ZFJkeBag7vk0Scaji1AGdm0J3en6P/81wdRjV8GVRRJvQF/9rI9
	 Y09YKFBpl+/bIYkPsCZvQLFhX4g9NThV64PF4sYizXiBkJQXyZya0dnPfOT7xO5Kco
	 q7ir5d9fU07A3pyFAjjwR8ypODdsENIYC30RmWLR+Hkk38gh7vLIxmD4PnxwIukfFP
	 n+kcq7a407ybVWwH1sVh+waQ=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A75C840E00B8;
	Wed,  5 Aug 2026 00:44:44 +0000 (UTC)
Date: Tue, 4 Aug 2026 17:44:41 -0700
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
Message-ID: <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-2-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260804235611.4053375-2-kim.phillips@amd.com>

On Tue, Aug 04, 2026 at 06:56:02PM -0500, Kim Phillips wrote:
> spectre_v2_select_retpoline() unconditionally emits a pr_err when the
> kernel lacks retpoline support before returning SPECTRE_V2_NONE to its
> callers.

Unconditionally? There's an "if" there. :)

> A caller may then select an alternative mitigation, making the "no
> mitigation available!" message alarming and misleading to administrators on
> a system that is actually mitigated.
> 
> Drop the pr_err from the helper and emit it once from
> spectre_v2_update_mitigation().  Guard it on
> !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) so it only fires when retpoline
> truly cannot be built in,

This is explaining the diff. Doesn't belong in the commit message.

> and restrict it to the cases where retpoline
> was the implied choice: SPECTRE_V2_CMD_FORCE, or SPECTRE_V2_CMD_AUTO
> when should_mitigate_vuln(X86_BUG_SPECTRE_V2) indicates we actually
> intended to mitigate. 

> This avoids the spurious error on a
> CONFIG_MITIGATION_RETPOLINE=n kernel where a caller of
> spectre_v2_select_retpoline() selects an alternative mitigation, leaving
> the system protected while the old message claimed otherwise.

This should be your first sentence. What the issue is.

Which begs the question: why?

Why do we care about a CONFIG_MITIGATION_RETPOLINE=n kernel?

You either disable all mitigations or enable them all (distro kernel) and they
get then configured at boot time. Why would I want to disable RETPOLINE only
but leave spectre v2?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
