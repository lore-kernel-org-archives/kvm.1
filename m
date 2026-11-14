Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614822;
	b=BU4VUmVkSuA5ZPfI4rZdP8/PV/CwpaXK0+7Utao1iE9dckqpXN+HD6dSikjimJKojah0
	 /X783AO5lx1+YxjLWvzQuNPcaPmJtEPuIm5y3HfvfVg2P9HEoucb0bxjvc+1w9H27aEFu
	 DyGNnB+ozKZkud8khstmjOt+6mlnRxNthT24h1Yk/8Udul0z7ogizDz1LMijTNQK3ur5e
	 9+Nb7pznX5W+p9CbaM7eh2Z2dW3n8pHBoFI+Fw++MljakHCiLvsynLviiP/G+fbJbTYZF
	 AbQ+PNbogzB/3iH4sEiA9Xxyp8ILHNPIuFsYffLpIBdyRdnIEjkHW2/cuy5u1xA5lXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614822;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=94fisBGc1VBi3d2j7Dn40cj6s5hYrDP82tmnwi/gW64=;
	b=XxZdJjtrx84OccmEu5nhxlV5ELRyVpdvaZOYk/Ms9fx6x5RDe1Cwwf3gf7IIqImReM+z
	 8cotjkZIDNGVyIZA4XMcIJPZSmweVDRmTOJw+Fz0m2+Vt3fJ1/0x/1RB2vxexpRZUQS89
	 hRYNFjc/ZXkGG9H8nHe7hvzUf7V2h/VYnKp6NwtGJ0cDsS/a1pmufBaAe2cn0D/JJibof
	 qyZ0ZIAYvdbQSb8533HnSOAJ7cNGV+c17wgQLWd+5MDpd2QtPJR5NVzO2Q6K3DOJ4Xyud
	 Yl2Ot8TjbfR+1JxkjbajjFbEPVOm81bB7Ruv9OKVPWjitWSv6iTZZnOcVxazARWS/2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=L5L2QlBA;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53A606A327;
	Sat, 14 Nov 2026 00:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F53A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=L5L2QlBA
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5DCF540E01DD;
	Sat, 14 Nov 2026 00:07:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kNQd6-Yr5Rtq; Sat, 14 Nov 2026 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794614816; bh=94fisBGc1VBi3d2j7Dn40cj6s5hYrDP82tmnwi/gW64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L5L2QlBAVgMoCOqd9Ajw606xXk1QT3VhoaXWA2PA4SmtJzoGreR2s+NQZlVvpm5Z4
	 nqGhDWyQ8eHpIcoui7CnJvC35AOHEmxbCD3FJhNtK1H8KamOmatENYz16ZuFAviwUj
	 zqG93zI+pmf5mOAy1UKvuVu3csf+ENlIIm5CYfhys9Je5geK2QOmgtb4d0NUpI8yCL
	 9Ch34NEvRSy01JxMEzwermQuTDSUpv7zPhp0WaxHeNjRXy2wT8rIcOQOGZoE0r2ujX
	 A2Bb2OZtG46WCc/R8EjptD6yBf3kzsaEAPecMkXSnBNtbrSK55IPWL1W/J7k8DbsJZ
	 1tX3+gsmCDAshq4ZnA0EBKLY3UkOAIJCLt9JYd2+Qq44LEfaI40blKdrz49Kik9F/P
	 9jWdYTGrtrVJvPZp5v1feZTNnbJEEsZEd9PR+qMneQ9hTDX1WdzbpgFA0Rl1bhxQCO
	 +8MymZJj7gxaY+7vyMFo+jq1vyLXXGa1mXnuvo02Dfe6Yr+WMrzeWC9qU/LMylLGOQ
	 TZwg8GI/9lE2u4CzaQUj5A9nBzwY+l78tV66V2zwfJLaC4YyHEnhKo3okbDKj3AQVK
	 qmL6/JHDTW7NquAfJxlDXqxl9D8Thdm8AK8k0CC8X5Nnr8ZiIAGMif2fPbmDBxlxaJ
	 M4r9f7/dt6T4off7X+mkt7vk=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1821440E015B;
	Sat, 14 Nov 2026 00:06:43 +0000 (UTC)
Date: Fri, 13 Nov 2026 16:06:39 -0800
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Srikanth Aithal <Srikanth.Aithal@amd.com>, kvm@vger.kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
Message-ID: <20261114000639.GFavemD1v0D7JQJ_kG@fat_crate.local>
References: <20260821201432.879450-1-Ashish.Kalra@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821201432.879450-1-Ashish.Kalra@amd.com>

On Fri, Aug 21, 2026 at 08:14:32PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> machine_kexec() calls hw_breakpoint_disable(), which writes DR7. On
> SEV-ES/SNP guests that do not have DebugSwap enabled, DR7 accesses are
> intercepted and delivered to the guest as a #VC exception, which must be
> serviced through the GHCB.
> 
> By the time machine_kexec() runs, snp_kexec_finish() (called from
> native_machine_shutdown()) has already converted the per-CPU GHCBs and
> the boot GHCB back to private and set boot_ghcb to NULL, tearing down the
> GHCB infrastructure. The DR7 write therefore raises a #VC that
> dereferences a NULL GHCB pointer, causing a page fault and the kexec to
> fail.
> 
> The NULL boot_ghcb pointer is a result of commit 3645eb7e3915 ("x86/fred:
> Fix early boot failures on SEV-ES/SNP guests"): that change makes
> __sev_get_ghcb() return the now-NULL boot_ghcb in this window, turning
> the previously-benign teardown-window #VC (a bogus VMGEXIT the host
> rejected but survived) into a NULL dereference.
> 
> Skip the DR7 write in this case. Its value is not needed across kexec
> because the new kernel re-initializes DR7. Guests with DebugSwap enabled
> context-switch DR7 in hardware and do not intercept the write, and
> non-encrypted guests are unaffected, so both continue to call
> hw_breakpoint_disable() as before.
> 
> Add a CC_ATTR_GUEST_DEBUG_VIRT confidential-computing attribute, so the
> debug-register-virtualization state (AMD DebugSwap) is queried through
> cc_platform_has().

Do not explain the patch in your commit message.

> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c3f4a389992d..60d25ceada03 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -398,7 +398,16 @@ void __nocfi machine_kexec(struct kimage *image)
>  
>  	/* Interrupts aren't acceptable while we reboot */
>  	local_irq_disable();
> -	hw_breakpoint_disable();
> +
> +	/*
> +	 * On SEV-ES/SEV-SNP guests without debug virtualization enabled, DR7
> +	 * writes are intercepted and generate a #VC. The GHCBs have already
> +	 * been torn down at this point so the #VC cannot be handled. Skip the
> +	 * DR7 write as the new kernel re-initializes DR7 during boot.
> +	 */
> +	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT) ||
> +	    cc_platform_has(CC_ATTR_GUEST_DEBUG_VIRT))
> +		hw_breakpoint_disable();
>  	cet_disable();

hw_breakpoint_disable() does

	if (snp_hw_breakpoint_disable())
		return;

and this way all SNP-specific code is contained in sev.c or so.

Not the other way around.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
