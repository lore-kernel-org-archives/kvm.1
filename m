Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459479;
	b=WB/dbAH218B4ag0N2I3pRotIfzF8Pq1FPC8mP5ECwuPhowpjzU+hIf0OBFNzUmJVXd07
	 32wNmjbxSoYqbiVIZhGt9X0k4vz42e6CQaXHYIxEwY1MWCxvGSEZ+4cO0PqYIGLuMy0jm
	 /D7tcGsGq2H9W2yEhc3NWn1zv3eVolcRFfFaxsX3dKxaJQKVS5CW0USlPCyJvNYRg7wDx
	 12hy1ARbztH5r3l3plcay2yDNDoyxWSMHZx5vVjSL1rf340iAesY9VfUxwqYNVMXiPmYm
	 flmbwLz9boSNGXp9ldxc+VFYEzlnb70Sj6eXTpoQpXbvD7TV4Y98mmnPy/aDBl67XwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459479;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Ytz6JpdI1aOWSPZT336Zn/ACErFeICCJWcNWrycsAPE=;
	b=phzk/vupE6YkoEqCADNWr3BdMzYqFMlAfsIZE+jKknRCZe7d0ytgA3hZC5Sf8RrJJ4FG
	 4ziytf34nRrVqPArFRK6lEBwvL2tAz6AMLKzqVT4Pp0WGI2a+r3DTvMZPCFgK86ijf44a
	 GkgiF4avU2Isumiwoh2jzdeP9/lD2wNgaS4p4mlPFAf2dVqVNQTUgoBG/jddwo9G08OK7
	 Hi+dyY6RkO2/QgPnW9nci5b7m8QVdQIP7rO+hlM7AztroFYcggFoRITgItEiFsiqV5jOE
	 eQthooj99bA9zuww+5lg+6i69t7H+wJK2qtwQMEkv3+BnWsuHrcMLy2BrAMVE5AxhGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=iSp1Bg7q;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A134606A321;
	Thu, 12 Nov 2026 04:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A134606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=iSp1Bg7q
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8F40740E021A;
	Thu, 12 Nov 2026 04:57:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rTeTKjYBm0-s; Thu, 12 Nov 2026 04:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794459472; bh=Ytz6JpdI1aOWSPZT336Zn/ACErFeICCJWcNWrycsAPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSp1Bg7qmXQYuEODkDk22wXw870gkxY9xW4DTUuMVGv2pG+69zza/p3x877vqYQxj
	 +fiGcivEBSAsxpJXHNhrsYbh2qyPblprOHNHEPzN3KZuCFbc77qguawcgJDgDvyg2g
	 9QeiLrcFyWMuqtj2aWvda38J4UsT/NhppuF/8BCUeEl2HgSTQh6EYhmS0Pwrdh4U7n
	 g5wHa4CRvnzKEzm6xVt/Hb4sJuk6wuH+QQxyhcOmtwJkliWOQtA6R6LgcESvpxiwo1
	 azf3gpidPgXonXFnQzkHF6r+UKqi15rv6CW8CtHxkYlJfUWbiYnuQhF59GcqUdcIoA
	 AbLIYJNRIfpOtURvFSr1Pl51XseCg/WcYomFR9nft0cq6vrDBeM2SGWZxmYz/VP8OJ
	 j4Wdjoui6fUfmfYGPPZBDoXQa3m0e9PSYfzVHFfB5eKNJ7b1KFMrDBWg4241YmDqwy
	 0v7qcUms/QWoK6XL5+zuLDbD0FRAk239T4LoXUtnQ9dafWqU3Z/ZAiKx+n1yULXcX3
	 uO1V7D0lFAmK+WONNLoUfBOBOSGgJRW7US0hG/SrL5GgmyDMmU62BvLvAjsnYe6UAd
	 1X6+7i0ub8cyObArVTuWuw9bJztMCFRH0hPL2mQ2W1uSq/AguMjCifXR/2Ptc99cKe
	 flC9FSFF+XONMAm1BOC2kBHI=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1374D40E0218;
	Thu, 12 Nov 2026 04:57:38 +0000 (UTC)
Date: Wed, 11 Nov 2026 20:57:03 -0800
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, vlad.wing@gmail.com, security@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 6.18.y] x86/cpufeatures: Make X86_FEATURE leaf 17
 Linux-specific
Message-ID: <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local>
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>
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
In-Reply-To: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>

On Wed, Nov 11, 2026 at 08:06:21AM -0800, Breno Leitao wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> commit ddde4abaa0ecc8395e0fcfa3e92f65d481890cc8 upstream.
> 
> That cpuinfo_x86.x86_capability[] element was supposed to mirror CPUID flags
> from CPUID_0x80000007_EBX but that leaf has still to this day only three bits
> defined in it. So move those bits to scattered.c and free the capability
> element for synthetic flags.
> 
> No functional changes.
> 
> [ leitao: Required on 6.18.y: the 6.18.61 backport of ae1d2082d93b
>   ("x86/bugs: Adapt SRSO mitigation to Zen6") put BTB_CTX_ISOLATION in
>   word 17, which here still mirrors CPUID 0x80000007 EBX. The flag is
>   then falsely set on Zen3-5, and Zen5 silently loses its guest->host
>   SRSO mitigation. ]

Good catch, dang. That's nasty one.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
