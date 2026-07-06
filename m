Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA22F6188;
	Mon,  6 Jul 2026 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357275; cv=none; b=WvJ7nCcBvRO3EndYjZ7wgdOH8byIKlbb3JXki1d1t8SjiOa7h+gR1HQ/L9RHMyp5k7AO7YhIcMw9C2GduUdwRKB8A1U8cZtXzzW9Ce9TyaR9RdnKcmoyzt0vhPQ0Y/JNwDIfVjE5SKZ5O3cMZp0IMDvMtysBYNB8aoQicbiHiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357275; c=relaxed/simple;
	bh=auQFFt9dAYTSaquzJRRDuhw9kxvvBvlZO71tJWRwQAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKi32/0f6RVz1gB9sYVnKiGSXwDwrWPp7I8QBGJQcXwh+mvh4GiQXISox0zae13VhirVeQ2Tq7wWSzHuIy8HNxhJ3LpVqTMFZ1RdfWU1TNKJ9N3g2x055oY09nkf30DCedKERJz80xe/uAAx8yW3cBOYmQM0b3Vm1kxlsbSUSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ebyV4JYK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ebyV4JYK"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8DA2940E016E;
	Mon,  6 Jul 2026 17:01:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fzUvSz7SGoop; Mon,  6 Jul 2026 17:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783357260; bh=FvtnePO0Hri9+xidXlssbTh1jCzzHZxIywo0k9LABd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebyV4JYKi7AJPD7gBzAoyyFaCzHWEI5dlGixs5MbYcQURWgvQDftVXdC3b/HiOQzi
	 Kqfhkf0z1cSGV/TFDqUuT57nRiWg9hgY1YYSrqBzHBTdYQhJFwYbmomhpDExVbdYJT
	 ow4mxdcq+h4D+K1gnCJ2fIxhQHCsRx/zMoQMuINdJtWzKhHGl0KrCHR2pR4pKEB0Yu
	 +zw1FuRyK/t+mbt2/3EV2uCzIKgBYPbiPmED5t5wUKN11jdAWeJiYzBDjpRK7u+LvJ
	 CoKtGFOUNbmPsyQDI0RY4xGKavo7XGbt17bdUCBA6pHhCS/IdqCkxKfbbvrXnk2+lZ
	 ljHf8FJRxi0kcrfliQkAI9G56o/bK6gPmcuawnqKIZdmbtHHc4Bsitd5vIHzhZDSBj
	 /49a9ZZXHG7wYYvcAOTS/OchR5cs+vMF7GgCaWTRC6oP6nBwVbBHYRfCs3Hhg1slJI
	 eYe+52QA5bXEUOkQbRQL+c8CT8nScy7R9eBb0DPwdGUsrQfoOtfsPg9ped4L/nW1nR
	 +iU8iBG8sMkEUoueTAUxdsmXYIV+fUY8qydn8dOokhxjmvCe0qJZZvqvSz78JkyHxV
	 kDyZdu0BWOpq1r0JQy2C1PkmkbgEm3u4rj+HnL4VAdFo58gWQTDp3Moh/GoEVpv3bp
	 s5TnIpXv1NZVTlq38+KEOTGk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EC17640E00DC;
	Mon,  6 Jul 2026 17:00:46 +0000 (UTC)
Date: Mon, 6 Jul 2026 10:00:43 -0700
From: Borislav Petkov <bp@alien8.de>
To: Sean Christopherson <seanjc@google.com>
Cc: Ewan Hai-oc <ewanhai-oc@zhaoxin.com>, pbonzini@redhat.com,
	tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, binbin.wu@linux.intel.com,
	cobechen@zhaoxin.com, tonywwang@zhaoxin.com
Subject: Re: [PATCH v3 0/5] KVM: x86: Expose Zhaoxin CPUID 0xC0000001 EDX
 cryptographic features
Message-ID: <20260706170043.GBakvfO6Ng0SVkhsGW@fat_crate.local>
References: <20260610023512.3690734-1-ewanhai-oc@zhaoxin.com>
 <20260701024521.kffehv7bxcjc5f3y@ewan-server>
 <akUfrLPAAUuD8zRZ@google.com>
 <20260702014926.GHakXDpsIK5srVj0Mk@fat_crate.local>
 <aku9-O5K4a7vTDXS@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aku9-O5K4a7vTDXS@google.com>

On Mon, Jul 06, 2026 at 07:38:48AM -0700, Sean Christopherson wrote:
> On Wed, Jul 01, 2026, Borislav Petkov wrote:
> > Btw, Sashiko rightfully mentions:
> 
> Please no, let the perf folks deal with synchronizing the headers.  I explicitly
> instruct people *not* to copy kernel header changes to tools/ when sumbmitting
> KVM patches, because it creates the false impression that KVM selftests actually
> consume those headers.

Well, how?

Maybe other headers, sure, but cpufeatures.h is special and I'd be surprised
if selftests consume it. And I think Arnaldo is happy when he doesn't have to
sync that header for a change. 

I guess not a big deal...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
