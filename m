Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A510238C1A;
	Wed, 30 Sep 2026 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790737649; cv=none; b=RqGLV7sohIaXh3e9j8tgn9SkrqewCjd6EQOPlb/lRmPIZxej7PswTfK5SPOIrW3eEKCOcAEu1rKGuR2aKZr21xLlbQpxV2mWD4Zn6HY6iEgm1fxMX3Z23/Zozlq/tQMNCbhcWGXFZStvPvjI3OizUmKWM+DEZjoueqEaRiMXWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790737649; c=relaxed/simple;
	bh=QcytEi5EFi0lb9dm+YCtFESRKrrcgnTVA1IQXrSU70A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtmyuRFyAXFzEsW9jfHDRpsx+srGMwg2t7+SjJcGZvYAiTspaXaBU1cb4GCqSTc4fL1mf24Kgbd55lgOsSbR726xPiyIkU4Qu8YYb3YW70gkwjlk3mcrLvOfhMPzXdAscmvp/ed2nfJ71WM0M3pKLmad48LM5lAYTGDAf/bYJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GvVBU7V/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GvVBU7V/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 57CE040E01B4;
	Wed, 30 Sep 2026 03:07:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pCl_hRXdEl46; Wed, 30 Sep 2026 03:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1790737629; bh=YdJ54MSslT498RjCiYbCQXJS5Z94oOoohsSstXfSlJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvVBU7V/AaeBsYehRgDxS3wziUBU0S8xX13bi9Zxq12DjHfLHlQYNeZJOsA2HY+h0
	 Q7DhEAsg8ZG8w30j9IuMA1NtJ5ysO6iHe/TRxqgKk/DAedwKnIp9JCCvLYhhsTSyFD
	 EIFDzlWvqST69JP1OlhIL0przaduQujweR1P7JdoE0rADzcCvWNLk/03autNp6nB6i
	 vgZYViF1Y0OKD6oVWf8ZPCqYZaRRERrXaBf9p2WFfgrZAMTX52u3G6JHMhltt2uSMM
	 EjJ9NyRaRiI68dmGO/JjA8uIMtBC1GmpTbo9u40TRYCZVtY4tyKxicTANMVZ4HuHyX
	 mPvkrAqh0V98fxTbSI50DA/rf6ziz1ZMVU/vdpCXwCbyDpuTfCrZ+xmu0dAQvoRq8q
	 szt/hEJLc6SXduI2CHyFXwqmTLu8J5zDojJA/TN+nDt5+tfrzqGH77RXDyT/054iCb
	 PBqbu4LqilA9T8X/JZ3PE0y3MYbe+klx64HosKKqKc20WLeZnTDj/q8ocfvnjFY6jv
	 qgnmeoEg9TrdYpk8hHP8azk2H89sBdjKihkT7MBHTwuntyvDvFwaCmGeoh6CdSEj+L
	 SbCazCsExuJY1Azg6GFLzPF18b0lqo46iSR9Fjb62zBYhrtiasyBArYAyxiTPqCN1S
	 mRE+lbEX/1QyL97D/qvcKB1E=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4D0E40E01ED;
	Wed, 30 Sep 2026 03:06:52 +0000 (UTC)
Date: Tue, 29 Sep 2026 20:06:50 -0700
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
Message-ID: <20260930030650.GDarx8yvplZzQtGDBz@fat_crate.local>
References: <20260826223510.3669875-1-kim.phillips@amd.com>
 <20260826223510.3669875-3-kim.phillips@amd.com>
 <20260909210101.GBaqHJDWSUnpjqNcyB@fat_crate.local>
 <9b85be41-db5a-4bdb-95b4-beffb05a5ffc@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b85be41-db5a-4bdb-95b4-beffb05a5ffc@amd.com>

On Fri, Sep 18, 2026 at 06:01:55PM -0500, Kim Phillips wrote:
> SPEC_CTRL.IBRS is architectural and behaves on AMD just like it does on
> Intel, but the kernel offers spectre_v2=ibrs on Intel only: the option is
> rejected at parse time on other vendors, and MITIGATION_IBRS_ENTRY cannot
> even be built into an AMD-only kernel.
> 
> AMD's SNP BTB Isolation needs the kernel to toggle legacy IBRS in order to
> optimize the VM exit-to-re-entry path, and right now there is no way to ask
> for kernel IBRS on an AMD machine at all.

Same comments as to the other one: We need:

- a proper use case which is *actually* useful to users

- have it properly documented in Documentation/admin-guide/hw-vuln/ along with
  the potential impact so that people can make an *informed* decision whether
  they really want it

Without any justification for the added complexity to what already is
a maintenance nightmare, there's no point.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
