Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F237FF46;
	Thu, 14 May 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755266; cv=none; b=dD09qwclWF3w8VcLz96g7bqvu4EWnTAi5tJgV0okNSVxjeIATIxtPIUbS49puIK8q+KtaBplURL/HtD2MQ1vatS2OzkS80qvlmnb4kLSqR4MQoXTSgbTI1Dud9ylWyUwhkqwxo+GsYu4TnDXAuMNMkFTa9cQlm+D8RJWX4etDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755266; c=relaxed/simple;
	bh=vPuorauXMl/h/wg2FEzLaOHOzC5siIsj/mMvD5/A2Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njAmYmbeRPqbZFCZw6X19X8bBdx/u8w/WKRUfN1EOo79zOYJpQvYOQ6k45IcdjyTjK22sGGJV+IU3M5sFJpkpTFaS2XA+8fFHQMvRfbumLTbnPWinc8CjjhzMk+e7bYT+R1+GQU5JHt3RYO9Wy1Ivbz+gYwL787KIebsQRnkOnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HDLsR3vW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HDLsR3vW"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2B3BC40E00BA;
	Thu, 14 May 2026 10:40:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id igv4gu8lMZmr; Thu, 14 May 2026 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778755247; bh=xFTtoNONN/I495zdy7edaPKgEVX47wy7ElthomCpSK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDLsR3vWcA8CQzy2uEvhHkmIu7C2GYjD/CdxZFV59UnwzY22z79H0eINAdY1UjblX
	 bev135MA3yxGGXw6tQ9e5Da05veFkSAsCQQvHDHg08vCagAtYbej9RqI9Mc1/8S6bp
	 SGy/s6ZTcXFrE+nmSkhs/AgMGGJiwRPEAXyi4G4VsbTsABiBQaGp9461YpVKLRdwpT
	 jmRIB92QtHrk5bmf4Iq1jDXD/5klYYoptfzDYvG1rwml0dyntxIqEGoQ7gDZtULcEC
	 cgOrWZJl6hBabV/K+kvxr0SgWpICg3IOHwvNqJQuPxB9GL1U1AYmUJB0vtQtcmU0/Q
	 pfFEXRQk5ExZ/FVsltI10fSPYzwLhPcrTCYPigNyfgZmjYCsbJhCmGS9Ll5rtxQjxD
	 Feo+g78EOuhvqqrf5DikjDaklbknHbW7XaFmS2Cn7ArbS0pvcFYvUC1RAbslpxOqbm
	 3oM2XdWSQ8oWjpl6+Yrw/b4c3QC499ySJEMXG1PZ8/m810Y2P7fRpMe44p8OogFXwF
	 45vDS+0FnO1Np8bn9696JnBjhsazjKCd8BW1vtJ765u4yzSq6mgRHjz2xGWANpdAzU
	 YkHRmjk5kXESikrQgYObUDtxsmMogIxCkEpwkkhl5Rp3ExfrNco2AOlmAWdkwAm1Fn
	 VqVROoyNXrA+sdykFR6JdDCA=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 1264640E0031;
	Thu, 14 May 2026 10:40:35 +0000 (UTC)
Date: Thu, 14 May 2026 12:40:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: Re: [PATCH 1/2] x86/microcode: Do not access MSR_IA32_PLATFORM_ID
 when running as a guest
Message-ID: <20260514104028.GAagWmnJiOUrfTkZmN@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
 <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
 <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
 <7e8c7907-5237-4287-9ccc-ec22e15a7415@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7e8c7907-5237-4287-9ccc-ec22e15a7415@linux.intel.com>

On Thu, May 14, 2026 at 02:22:04PM +0800, Binbin Wu wrote:
> > -	/*
> > +	 * 1) The CPU does not support CPUID, detected below in
>                                                          ^
> Nit: 
> "below" is a bit ambiguous, maybe "earlier"?
> 
> > +	 *    load_ucode_bsp().

The sentence says "... below in load_ucode_bsp()." It can't any clearer than
that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
