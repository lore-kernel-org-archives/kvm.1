Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FA12F8E81;
	Thu, 14 May 2026 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768054; cv=none; b=Ops64lQCzQdi+rNwZ2lMNgLtNNHLbLiSaxzGQ2jydG2in9ShZ4bbDOTOU7MJZxiu7ONoHx0gqMvPHj5aJck5u8cH6uYpNfUoEG61xwO1MzqQoIvQp0LAzE08sN0PyFsP8zvYRfrtEapaxgFoZhHFSudEWAvrG3ofCgWFxtsFqvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768054; c=relaxed/simple;
	bh=nwAJF6Q2H8BQAkWwrUjLoQuk8hUkJLWS5HRex86Eeac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQWj1goGCF8jVb5Z1eMU13Ll9GwGwdd+e4KBJ0Bv4bUpXuPzt3Wb3J9fKqChuKC+72SeL8bQj+SS4W9dYeO9tJK1aFKMS+S0K7PVTQ0Tc+NnNCSm8GEyEpc8/tIq2zXvZ/tLKb71C1DWYXY2L5KWfsTX1BUHNTaVRxIhQd2OEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G7l7K/GF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G7l7K/GF"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9C66D40E0032;
	Thu, 14 May 2026 14:14:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rzE9NUAoGQq5; Thu, 14 May 2026 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778768045; bh=zChUe5zV2SaQC8GKfrzs0S2CgI0sa9KFW/41eR36i7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G7l7K/GFIPoLcDnty2G3QF8gJC+qRW+3M3Ky80Ssj6Cc6ETqOzNV1PT+oOSRCfPKl
	 DRxDLiSFLKyJTnGf9Rw4h+xZPIoJyhlgIa3BV1sQqPvVbPfc1n8xN1vyqHqIULM2/C
	 Bz4RJNYOuYkfIr1SOJSD3JqwY/jvHTqPpnkixtvtY7UyzIhclf4QALPUddYfs1/8IF
	 VJvAucVkkXaGpMXoS/fjDqAu20AGXWAYDee8xowivWnkkghkbrGplgJYvbVtMJ9ZMd
	 rlPs+sbyximWEauSzLxCwaf43R1TnzByMRCzZ2YNK8+XCpOGyM3/hnktDrkBhaWccM
	 EDbNE8+XvV64f409oGaOTXudzQHp+tTDk+D7uFnh3+yuTJtyLkF6I0bS6hFxb5rIbK
	 Lt0St9E3WfHL4p9Mk2xu4yLqLLnmllbLAcKRbg0sedzQ41HmWAsrJ55ICAnFpBW4px
	 rJxq7T04ailzUOe6vGyOthQs2SCeiSCZgEwj7mr5lZt83klgJVsWK8RtbmZUixA0zN
	 4R4QCGMqRd3FpJYNmJnEe+rVmSP0H+5pSWXrWmm+808tpBvpyb1Z+1WesRbjdUf12C
	 lFEgbIESKb7PMR0jL8m10bPOLL9/u7ogmskcKwak9SSO7DQgfwssjIaW3wpVVEndII
	 3x12WukWptCGH/t2gFq3jUZ0=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 03C9140E00C2;
	Thu, 14 May 2026 14:13:52 +0000 (UTC)
Date: Thu, 14 May 2026 16:13:46 +0200
From: Borislav Petkov <bp@alien8.de>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, dave.hansen@intel.com,
	seanjc@google.com, pbonzini@redhat.com, kas@kernel.org,
	rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
	chao.gao@intel.com
Subject: Re: [PATCH 1/2] x86/microcode: Do not access MSR_IA32_PLATFORM_ID
 when running as a guest
Message-ID: <20260514141321.GEagXYgTRSkuc2tQSb@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
 <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
 <20260513200601.GMagTZqT_CT6EvN1Uz@fat_crate.local>
 <2df97245-c1e7-4d72-9ab3-6c186b6c030f@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2df97245-c1e7-4d72-9ab3-6c186b6c030f@intel.com>

On Thu, May 14, 2026 at 08:38:20PM +0800, Xiaoyao Li wrote:
> But initializing x86_hypervisor_present by load_ucode_bsp() depends on
> CONFIG_MICROCODE, which depends on CPU_SUP_AMD || CPU_SUP_INTEL. So when
> both CPU_SUP_AMD and CPU_SUP_INTEL are not enabled,

... you don't need microcode loader either.

> x86_hypervisor_present will always be 0. It's not a problem for now, we can
> solve it when x86_hypervisor_present is going to be used by CENTAUR or
> ZHAOXIN.

Yes, we'll cross that bridge when we get to it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
