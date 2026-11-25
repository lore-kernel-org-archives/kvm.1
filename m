Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580388;
	b=mtA1nYT5PQr1Q+hHVdgDezNGGuGQzySxPjMybBEIyBcSSJMSHDpiqyqCk89+0F+OS9yw
	 G13/Np/Aiy4PgFRKStaaXzfSQJ8YFm7NNu+qEyOUWkH/peWN9BG3kIg3le3zuzYJutGqJ
	 u/n/lOr4qhIdTKQoFllPxsmqFB/iggZun2oaA+Hc650nVphO954B7LKWX3OHM99vPaNP9
	 tG4GP10v2UT7szFCeZQ1FxNUepCJFVpTiVn/CI+fr2kyZi/e3csfzRNaPhhyI3R+MXSIq
	 KhKIXRRne356TXb0ccee3wds4mhwllkZSe3ts9IteB1gnkesAB8N0m/00we/lY8FgdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580388;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8FpdbQr5U540XWq8qpM0aJQCblydKOK5+qBnoBbGMYo=;
	b=YsoMjBR/8Wmp0DK531pa8CrPlPRK2/xBvYQPsS9nr1sWj/dxuXS2g84fbuLkHEJ6kOlc
	 UMyiwgxdP0CmvzTDiWnNobXnfNmDGnHmOf+Jry7v2cSIMQA0hWS3CpA6x4JnOdILweT7m
	 IMuX5EATFsKEPwh7EvptGurZ2Be8+JFjsg+nFUerOiMoATpwfRWRHoHAzJDs56wvwygBm
	 au27riDoQKgkWSLa1Yox8BuBSWZVPtna90ZDyAgRF21co2fNkQ36lV0Vq18jHxCEnC0Ed
	 Tsq60vYPtU3xRPKji3zaLvd/kQjRMnSPJZmUoKiXcd8bjG/URHfKP1LnlL/jsnD6lUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="lLadB7/A";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F89606A323;
	Wed, 25 Nov 2026 04:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F89606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=lLadB7/A
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3030440E0232;
	Wed, 25 Nov 2026 04:19:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id erZbZOSv36E0; Wed, 25 Nov 2026 04:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795580382; bh=8FpdbQr5U540XWq8qpM0aJQCblydKOK5+qBnoBbGMYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLadB7/AMSH0bnWrG9xwLno+OYr+qwCYSvaF3NMxOG2vSxPl6Hflo6BOJBmBrKADS
	 16gNb3w9ez0vTY4wJxM63+WgPp0FsHCxCyAAnVzncLqR2cFwKCB/U4KohCXJpgA4l9
	 8A9xi4XwdnwklHJox1J2XPLTNNAgj2MJDXNkDGcy4YV2sPGxlwEWy3H5SQVQrRr6ev
	 f38O+m9kKzD/eM9LveP1fl06IBu6qQHAIjvYpyA5e/OtEub3T9NoGPD7PF6gGJOn6r
	 3Wax4h3aAK4rlJVaA/kYgnGh6Hp4xAsW97NAn4UBURWJPReTUBiGJu7XDDANEEp9GG
	 syZdcHObLvvsNOCEfxKmk3yDRphG9VRkEPtXUDa4e2pKBEbXYSuLoMPM1pJS1ygct7
	 G+ijXFu01gKaYaXDTn6u2LzoCNZX0x13ZlIptdYyJeDpEMmvZeQbmthaMRKg+lnaYy
	 btzsvM8FTGC1hA7tr4BNM+FEekS2AdvLGtYio7j6ezT0FCbrmHN1lp9QAswBe8Wn8g
	 0yVEPAvHkV70ASMVczs+j371QMI6K/os2ZiUQYIb56O9/w+AfMi8QhyzeZ4e7DTwb6
	 K8oT03neUIkDcx9tdxR0NZO2XRdBDAO5CYRgUv3n0FgVtHdJ5OIuto+FU6ZAbdCEKy
	 hg200zQQ1NHTqdnQFGOtO9g4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BE7040E01E1;
	Wed, 25 Nov 2026 04:19:29 +0000 (UTC)
Date: Tue, 24 Nov 2026 20:19:25 -0800
From: Borislav Petkov <bp@alien8.de>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: nikunj@amd.com, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	thomas.lendacky@amd.com, Srikanth.Aithal@amd.com,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/sev: Skip DR7 write during kexec when it would
 trigger an unserviceable #VC
Message-ID: <20261125041925.GCawZhzVbU3ngXnt5c@fat_crate.local>
References: <20261116230335.1161521-1-Ashish.Kalra@amd.com>
 <20261123234341.GCawTPrczGd6iM_Uby@fat_crate.local>
 <47cb97d1-5919-4ee7-ad67-6039551304d6@amd.com>
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
In-Reply-To: <47cb97d1-5919-4ee7-ad67-6039551304d6@amd.com>

On Mon, Nov 23, 2026 at 06:22:09PM -0600, Kalra, Ashish wrote:
> On the "bogus VMGEXIT": before Nikunj's change, __sev_get_ghcb() returned
> the per-CPU GHCB, which snp_kexec_finish() had already converted back to
> private. The host mapped that GPA, read ciphertext (exit code 0) and
> returned GHCB_ERR_MISSING_INPUT, but couldn't write the result into the
> private page, so the guest saw its own stale contents, treated the call as
> successful and moved on. The DR7 write was simply dropped. It worked by
> accident.

Oh lovely.

> As for using do_vc_no_ghcb(): the GHCB MSR protocol requests are meant for
> specific guest-initiated operations (protocol negotiation, GHCB
> registration, page state changes, termination, etc.). The only one that
> corresponds to an intercepted instruction is CPUID, which is why
> do_vc_no_ghcb() handles only the CPUID exit code and terminates the guest
> for anything else. There's no MSR-protocol equivalent of a DR7 write, so the
> no-GHCB #VC handler can't handle it.

Well, can you fashion something with VMEXIT_DR7_WRITE and a dummy GHCB MSR request
to the HV which is innocuous, just so that it can satisfy the flow?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
