Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1D14900E;
	Tue,  6 Oct 2026 03:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791256853; cv=none; b=ZAMLtMCWM95obXAmklJFqibhSW5xdG5GncWg+IWw8BX5CX6fVeszcwuqnpDe4VBUG/cuUUyEcuWkiG29wxoF+3aBHj6FBB5oUnlxugwduKoj6PM0fSLjIVba0XXAuz+u30FSZdiIBLc8RX7NTtiAeB8PWiayYfrJoSBdB1UEVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791256853; c=relaxed/simple;
	bh=aDMNrkiFfV/FgrlhS8D/SJJa6yPvpDnJ9tIj/1/d9/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDMBettECC/YyrfEpcGP3RBYzRiE6gFp5OC4PVMla3Sikm8mvLOyxr8YUMx9URkb8Df3oArL73B/v48DfYPBIu8l17zUyFmmc9slr8pzshPo4pTc7EZBehul9GyeJM1szlaz0kdaxw6TjoBCCyc50zDr50ttiSgTCM8LZ3zL6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f9pQ6LMd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f9pQ6LMd"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB29940E03BE;
	Tue,  6 Oct 2026 03:20:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fMOAcKm0g0Xv; Tue,  6 Oct 2026 03:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791256838; bh=3oSnS6AkYxt2eUhdahHVO2pKu3vBNslFFoZydmTUKwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9pQ6LMdAFXsektYA/FYLTs5gxZFK8F/KNM8oZSN/2Ymm38OEGjiMQPSvq3rMbVnE
	 U2MGnYEwl44V+MO3lw6ClM42JdLc/Rn/UwlVfrYQ4cQL7lRqKyieUQPTIbtfBG/SZc
	 rQU0KOZX5HaCdV5CYuQ1bofkYZEX/3jQjjyX6bpMQpSiXlLUunVkJiiAsE8qyb/0aa
	 3XarubOWu6jJ/BT+722PvYjXcXnLjzSpXh2JMRIv5JlDmOSg5dQAaqHJm8eHndmICS
	 b5bUQS8bJp3+VN5UfWdY1lT+vSZZwPr4OzVxT6yeBa4XJACKianxxXDR0avcTnNzoW
	 IY3d+nUEuX5oDG4lix220g17ptskkqo6RYRIaeXtjxKnjUVfZzCQ58mznk0tmrHmGw
	 Zwjx4Pja5xAp6HPNWMoIjH4ypphlYMsigO5kR9iw0F9cEk79yKxJnCEJnxKWAxg9if
	 Hc2cfZw5f+asUE7KexFdOO36Rz6Fmw6WnRuhzn/hjORb4IkUv+zyW1+Fwye35Goat7
	 bI4EpHEqSmeW3v5c8RpY0DaHno+6lOUut5u5uIuMBzq2y6npEHijeFt0jIv52pWiwx
	 CBSCbU3IviVrshAc/gxA34trxcehlwPfU9WOjZn3dmiliQnVpbMo8pZ6Cyod/qPFRE
	 ztO8EAPEbfHhrOA86eb0h1Z0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 36C5A40E0481;
	Tue,  6 Oct 2026 03:20:27 +0000 (UTC)
Date: Mon, 5 Oct 2026 20:20:24 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Tianyu Lan <tiala@microsoft.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [RFC PATCH v3 02/27] x86/apic: Drop savic_eoi() in favor of
 native_apic_msr_eoi() for Secure AVIC
Message-ID: <20261006032024.GEasRo-APHHt24pP4g@fat_crate.local>
References: <cover.1783490022.git.naveen@kernel.org>
 <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36c039713c4b03c87b636635cb4c1f8b98c15eff.1783490022.git.naveen@kernel.org>

On Wed, Jul 08, 2026 at 12:02:00PM +0530, Naveen N Rao (AMD) wrote:
> Drop savic_eoi() in favor of using the native helper that writes to the
> APIC_EOI MSR. savic_eoi() was added mainly to be able to handle
> level-triggered interrupts. However, it relies on APIC_TMR indicating a
> vector to be level-triggered, but APIC_TMR can never have a bit set
> since it is only updated when the LAPIC accepts a level-triggered
> interrupt. In the case of a Secure AVIC SEV-SNP guest, all
> level-triggered interrupt sources are in the VMM (emulated IOAPIC
> primarily) and KVM accepts them on behalf of the guest resulting in the
> APIC_TMR in KVM APIC backing page having a bit set. This is never seen
> by the guest, which has its own private APIC backing page. As such, the
> savic_eoi() handler is dead code. Remove it.

So this sounds to me like we forgot some detail while spec-cing SAVIC. Or
maybe for SAVIC, KVM should not accept them on behalf of the guest anymore.
But what do I know...

Btw, In the future, pls split such conglomerate commit messages into paragraphs for
better/easier readability.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
