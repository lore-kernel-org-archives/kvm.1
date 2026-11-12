Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794526430;
	b=CCVd3iEM7owsArp7RCMZ/kAP/cV/0Pq7GVU268/bk/cg3hfUz97oWoEbuK35UGYorxOO
	 KyB7Gv5txX27ZTUXljHypnwAkcUimGZs+3Dzy1ul6gRmhIHFr58MxJ/VarT2Uf0ii42AG
	 nCLmJVfnHciHDKvfm114IwKoD0FK4TToFlMu8sqnvt0YCnaNt80f0qsBhVVNj59ciRz7d
	 q4rgj57Bh2jtFStnO0VV9jbB9b0pIsIG6HM1Op1phAgCgc9v4rukddmJYMaaW1zMUcsHU
	 QkpcWP/SZ4mMZHaSEREacBXe4NC2jqZXR3dTvFzlLx4Ks1z1kP13vQLd+yM20ptlEBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794526430;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5p7yafCYyqP8V9VyAbPPoILrtZ80lnhqJShWVT2+Ew4=;
	b=B8D9ynb2lyWWcN3dcAm48lCTvB0j3r2YbzRoBQGc0z1UD+EN7Bx0rqgMKd6tOJr8t9kQ
	 bt5pK5YMwi/FDI3/lJ1SURi8vWfyWjnyfCaVgfkE9e1xxwsO/0lKFSqaYunxuC+KrYRdD
	 4Q06bpazEDSP5EZN9pukpM2bUFZLu+e30A6eXWvz+HYebYIMZ/XhiLaY/F0AhN/D7ugTL
	 ysNuPNbXu4cKsyJZWomSTDhKCakNoPnccfWsuqx1lcaNA34HxpuE157UbyqdvYGa09vEZ
	 8OCh39wBE+LMcAi0HH0laiL5PjgSROW1R30xbKjiYF90JqvcC6opjRpYSzqLKaFgMzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="lI+V7x/6";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62048606A31C;
	Thu, 12 Nov 2026 23:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62048606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=lI+V7x/6
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 56B4D40E0231;
	Thu, 12 Nov 2026 23:33:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3AH-zT55Hw4E; Thu, 12 Nov 2026 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794526425; bh=5p7yafCYyqP8V9VyAbPPoILrtZ80lnhqJShWVT2+Ew4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lI+V7x/6cs2lvI6EccbUeM9AcKtwmBHMvcvSywtCJNTU6z6Gcg0nqntU4jWPSUQ3E
	 MPMt88Lc78ZZ+/2NyVOAeuhBpdNLTtTzfJfO7GNoh3d6PTTLqQX/dXrtcnji5D5WsZ
	 7aWiDYXuHG1QZ2vBPaVAuUJKh2BNpgvWjNJOhYCRgRtMhY90AvLX5xL2GdN+MTePrl
	 /jVTVlim5ACYptzhcCSVbkQnB9oG4FXNuByKVcMqZZTDO0tPxTUsSAZkEczc+SjB16
	 ocuuKKWRrHMN667ugdpAFL8CmXEmFMccbDOLW9M4qW1xQoguxlUnmfmNgH4Mt6XpKr
	 hlvLELlwfKWrcxdyoOtWuRSIF+Gl0OJUInvRYdUo95hWp8LTaTxkyEGe+t6eVZL4xY
	 n7GKLnKxUmG+qyGQCXjm95QdX63ZepbF+pvtSOULdUUPJDl1THl86TRsBjhP8UeVAN
	 6buKUrNWCqI6bkukDluZMllmAzji4NXT2av8ZsKx3f/twBYtwl0U+VRrjwiVlZx3VG
	 9dqoNH1tIgeBSd90yh21K/fFrcrh45PhJNd6KUqg7Bz7lWzogjv8vVdYiarcN9MKz5
	 +tBmNX5Htv5f7YpGUTh09lIuxry+Qmohbm0Fh+zH9/RnR6CN0rrjEkg+T9Eumzrq48
	 1G0FZ6kvRMoVk8ktucFDKynU=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 763D640E015B;
	Thu, 12 Nov 2026 23:33:31 +0000 (UTC)
Date: Thu, 12 Nov 2026 15:33:27 -0800
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, vlad.wing@gmail.com, security@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 6.18.y] x86/cpufeatures: Make X86_FEATURE leaf 17
 Linux-specific
Message-ID: <20261112233327.GBavZMx2etyTFh1be4@fat_crate.local>
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org>
 <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local>
 <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com>
 <29B14106-19E4-4589-BE40-3D42BA646CE3@alien8.de>
 <87o6btsl4g.ffs@fw13>
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
In-Reply-To: <87o6btsl4g.ffs@fw13>

On Fri, Nov 13, 2026 at 12:09:03AM +0100, Thomas Gleixner wrote:
> Even if a new leaf has only _ONE_ bit defined then it's a new leaf. This
> whole "save space" nonsense has been source of a gazillion of subtle
> bugs in the past and we just continue to "fix" them instead of actually
> tackling the underlying problem.
> 
> Linux specific leafs want to be in a space which is reserved by
> hardware for software purposes and not arbitrarily hacked into "holes".
> 
> Hardware defined leafs have to be represented by a proper entry even if
> there is only one relevant bit in a leaf.

Are you saying we should get rid of scattered.c?

Well, as a matter of fact, after stopping this silly nonsense of having to add
a cpufeatures.h leaf just to advertise feature bits to a guests, the space
saving is not really important anymore. We're much better there.

So I could whack scattered.c, we make it a rule to allocate a new
x86_capability leaf when we need it and then we will switch to the stuff Ahmed
has been working on eventually, when we get that upstreamed.

Anything else missing?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
