Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7043E06A;
	Fri,  7 Aug 2026 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786081515; cv=none; b=DwclkG4BWIu974NkrzsGH5szewZV3rJdBFRz3dyDQ/keoSRUu5kWIJHpzPsz0vduFhi4Y6oBlsY1iEpOQRm8GghZluJ6ImCQhMvferY5NrnWvnPpN7lyzlp1/OONPOCzonyHgANV3201Ihk4cMx4OzVqJvsUIRI2iB79xgOTpPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786081515; c=relaxed/simple;
	bh=d/2r2+AhBOWQmP8g+FQLL3It27YL3EbPCm6bJRi8Bi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuGo+07hUtNgkjBRQD7GRqUJikxCHR3gbt1EWI1WkI0wHCUaNtRfXl++/npP5g65ZUXxDOsjlHEjcfWnDRBhh9QNzhuW+gZ4LaZgf3nXVQUb0NcbhP0IogCDTR8ZaKuJADahEqve3dp1ULUdrAYdUzG+giJ4IV6v+1igEO8NnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=S4GrgSuW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="S4GrgSuW"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D8D6640E0171;
	Fri,  7 Aug 2026 05:45:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vMOQEzDPpw6P; Fri,  7 Aug 2026 05:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786081502; bh=mqLY/IlkJZJ84OtmC0xGmvvUMgSRewGVQtoJ68Bihu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4GrgSuW7I5NpAWPwkF4o1WCRTLANkSjGpoX7bnOqSaVH+tLUeGrpW5/t/MVGdD+T
	 JO4JZdNLcj5igK6SQ20ZWu51wsnGvx1CvSJYChz9h4fwuZ/LFlL+sjUK2VREDX4chN
	 lGdZWt/fPmgezpyvZqv/b5L16gojieUmqO8bKoH9jxl34nX5xzcpz10/ufQIa6qyas
	 bxRZHerxMFFHyBNO2MBFOQ4B029YbdHobUyMXZALA6KLKMj4Gm7R38sP72E6sMspPM
	 z7HJluR2PvxocEhqTV86KS0QMQPk84rB1wB8R0HN9oZ5QQzyB6BAsTh+ykksechb5R
	 SSX54f+HdgvdziuliL7PMaLhniPsQvJ2gFL/Avm/GTFRDuyMeGppTUMWq9Zm+dAQdK
	 146zeBGeYYhQY3TGLnlfRGtuxo0pfJ+p5JnSoJGwfHjsa+QZipfBIj/jWVSuTR3Q2m
	 Z5QuETbWSkkEHlwahsnohbtgIKD1Nkj9OWgzpTmEorv9zqIcwJvlbvni1Y4yJsr8Ey
	 /QL+t7/MFEjiYD7SpHvexIG7s72wtMtZqj0HBODRFrxD7uJ6lzF+oZUkM65LOLao1O
	 dzQBXf/ldKeHmGwIlMwuwkP9T5BsCaMHisGpR0womS/zDnuWEfDw0vR8T5PhWjA8O6
	 slIpcCrF3baKHDHrSnwYjZF4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD50040E00C3;
	Fri,  7 Aug 2026 05:44:46 +0000 (UTC)
Date: Thu, 6 Aug 2026 22:44:43 -0700
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
Message-ID: <20260807054443.GHanVwy9MnwWZQvfdj@fat_crate.local>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-2-kim.phillips@amd.com>
 <20260805004441.GAanKHecgJwfAOzZzp@fat_crate.local>
 <65d82937-113d-405b-9399-b70973e84c50@amd.com>
 <20260805224907.GDanO942iYDbai1kFx@fat_crate.local>
 <9e5183be-1f31-4f6a-8b91-0f9a92590241@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e5183be-1f31-4f6a-8b91-0f9a92590241@amd.com>

On Thu, Aug 06, 2026 at 03:12:12PM -0500, Kim Phillips wrote:
> If by 'this' you mean this patch, it's because it fixes a bug with
> RETPOLINE=n kernels that sashiko found when reviewing the rest of the
> patches in the series.
> 
> If by 'this' you mean RETPOLINE=n configurability in general, this patch
> isn't adding or removing that.

Neither of those things warrant to have this patch, *especially* in bugs.c
which is a nightmare as it is already.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
