Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8C44369A;
	Fri, 10 Jul 2026 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783649061; cv=none; b=hRPOUSjf1/vs/Qy9sqP2b7IlSSi1z18s1DfMrrCmrScib3iKGA56feg5VYbivK/lvae+RXre+A2Irx69pGssLg3mUaXiKuqWcYi3+M1TvNlFeozb4k9McNU1YjeRY5DOpNGcZWkhGEsQUhkZaK2cSl8qZflAdJGSUM5FrEMc2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783649061; c=relaxed/simple;
	bh=UzwwpPSyanNW97F8fxBGilEZHbSAY3BoQGqx5fRpVAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYognSVv9KxuJl3qy/2prVJW1XEJqjsXadIQU7tx886NHyWgqkFg7jDB+O0x0xYBRzt7JOUb4JaueOp/Ba7+oLjtsILzEojXTouerRYGhfl6LfD0AiVWM8sBJUJ3Tz8uTLX9xLg7UHhYS75KbNHHl8gtCrCA/nULcPyXmhTxFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DSca8NJ+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DSca8NJ+"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 48E3240E02B3;
	Fri, 10 Jul 2026 02:04:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SficvG8F8J2k; Fri, 10 Jul 2026 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783649044; bh=Sv6lBQxmayItp8jJFkEu9kqKh+2GtoeFPiG+opTGA5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSca8NJ+x5f2JIF7Cq62en4SqGshhCQEseey1OovpYR5UBoQwiq9mUOpOVTWS2jT3
	 6Xu0M8n8WO+1O7taOwz3ijdIJ4VVbsB0z+dS/oeqj4EGeN9AmhT+sYvTdflTvkxQQd
	 Puya977ouAryqfaew/Hfl4Xarrwbyt2uvus2djZePYzW3wGpE90Omw5tLjqDT96iSy
	 4hqM/Yw93naNfjp57AOexJpx1sAE0kgShNV3CuLEhXhEOiqwtHrFLW/HuG1G83qDBd
	 lRUlR4Q9+esaqhPrLBKPmvvnDAP2UavbrDRTCaL4A7pqId/+VHauOV+ZZQVklek5uL
	 NUGUzae5nSRxv+DqAdCHqKtA/o0Tj8GKMpmU84ItCWC1+5t9rR9gDGwG2lrJz+C08c
	 gpsKxfj3R3Cpl1+O4cDU/Te/lNQWB4iXvp48LBbF5WAg8Yofa9p6gaRSJpWDOwNJyn
	 FghuuN8paaauCun5PlRpm8DM6prubs8WLauyxF8CpNEm0rCvAHdI7TdvaI6mDzD8uY
	 GhhO9VfSRJ4U0tGm8LZO2DbQS2VMdbs8h8dVMvwnzj2V6kxUcNqQ/FOixxKftiA2/X
	 IcngYfdMGl0wNn8thDS5iweiz/51/EjIWjMSJWbZx6pmIXSB9mrN2cpMy2Mrk0o/Hw
	 dF1Kvn2Q7u91iaENTNjF3wiw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBE4140E02B0;
	Fri, 10 Jul 2026 02:03:52 +0000 (UTC)
Date: Thu, 9 Jul 2026 19:03:49 -0700
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
Subject: Re: [RFC PATCH v3 01/27] x86/apic: Propagate APIC_SPIV writes to hv
 for Secure AVIC
Message-ID: <20260710020349.GAalBTBSz6pX3FA_fd@fat_crate.local>
References: <cover.1783490022.git.naveen@kernel.org>
 <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <891e7c5b74a9c027bc417a2dd32e23c0d4d0c336.1783490022.git.naveen@kernel.org>

On Wed, Jul 08, 2026 at 12:01:59PM +0530, Naveen N Rao (AMD) wrote:
> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> 
> Hypervisor needs to be aware of the VAPIC's APIC_SPIV state for
> LVT masking/unmasking. So, propagate the guest's APIC_SPIV
> writes to the hypervisor.
> 
> Fixes: c822f58a4fab ("x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver")

What is that patch actually fixing?

Does it need to go to stable?

SPIV needs to be masked and unmasked by the guest?

Doesn't seem too earth-shattering to me but what do I know...

> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>

verify_tags: WARNING: Sender ["Naveen N Rao (AMD)" <naveen@kernel.org>] hasn't signed off on the patch!

When you send someone else's patch, you *must* put you SOB after hers/his.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
