Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C437DAA8;
	Wed, 13 May 2026 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670517; cv=none; b=SjyAVqieo2L5Ifd+IhAQ+/WTygpTwEBYFMDSUQ1CyRuCWAZ8SwKfX17rXb4Ogv9MVoyb8Hxg/J6l/6gsfkFp30tohok5hWBJUuF+Vth24+tqv1cjVez+C2h4gV/Hire0k2VeJsLjvGr/OG6ZKAjEYnmITE1npKX9Sdbo/SXTVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670517; c=relaxed/simple;
	bh=Pzh82vNHNjhiLbExbScVu/J/26/8lHlzR4ATanosqrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEvCgrsoLRMV65klJW9pSL4Hn+Yl2pNnbWPhO4jEzXcF0EZ3elxNKkMLl3CTCdoj1+xe3gsOgtXM6RH9NNpuN/wlc54Q/A9SurO4h1XcbO6iCZeSGZT4Kdjtwh26P14k8FFqI4TbEUi4ph9Vf0LXUe6g8QO4ub3VlZLlaKDNKEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CfqCpkkC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CfqCpkkC"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1DADB40E00BA;
	Wed, 13 May 2026 11:08:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XCcxXqttawCy; Wed, 13 May 2026 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778670504; bh=lidrEyHLcok+9i4TSRj39b892qNrmvSxAh88DjnWWU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfqCpkkCpZ3Mcyc/ptlIkASseAxEoMnWi7JlkIGmBvih01esAcZSnaa4ovixISvSj
	 UQHCARmHmA4v+mViokplLGjunDWJIONK44kdVG+4xV9+7mIpSv9pJFcdEk/Dc2loqQ
	 hMtLBstVtY9dgUnUoSA+3+OGHR9n+4KDZIQ+/S4sYsZmd62aMu1rKcendQFyarb8zU
	 4N9CxF54+4TBEJ+tR13GsEkvWZ9IB/BN3v7v7mGe60UsOLXL/0riJtBn4BKLZ2o98M
	 ZLuiY4JIHKujrbQP7/+YLpridY5iAHa1FdnJLasy3bUoZQA7uAHimSAaFwyauxlMzO
	 8urQgMzDPlozfGrskqPwqa0MkIFcq1xEITU+ukT/+x7MvmC44lBaKwJbV0bEek3T7r
	 86skPSqznECccdxl/O4SqZUObJu5imIkjMfJ/P59D2hsTthcBwV5w5rMfr//iW+Air
	 qCsR8nDLchMhG2JrjTVnt3iZa9sDDb4KavU6FZWuDS/7/M/HIo2IM+vi6VkGCx67bO
	 UIRmhP6SNBNOuGq73+WxaerFcS2y8egPAjAm32FwIQiVKMTK9ud1bjprayxPc5+u4n
	 AOOeyXQnl8ogKtIeU8bQjjGbdHdqsWo/c0kKND9Ffe6VrBkit4FvC7+5AXSo/ar4Ge
	 PtA+c5iaKdE8oPOM5vgwNfjI=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id F1E6A40E00C2;
	Wed, 13 May 2026 11:08:11 +0000 (UTC)
Date: Wed, 13 May 2026 13:08:05 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Message-ID: <20260513110805.GBagRblQVSjxemzwsQ@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <4365e457-3d3d-4bc0-ac11-b3d4dfe8ccab@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4365e457-3d3d-4bc0-ac11-b3d4dfe8ccab@linux.intel.com>

On Wed, May 13, 2026 at 07:02:53PM +0800, Binbin Wu wrote:
> My version treated it as a bug fix, so I tried to minimize the code change.

I didn't like

	BIT(X86_FEATURE_HYPERVISOR & 0x1f))

in your patch. I'd use BIT(31) as it does.

But, more importantly, it added yet another place where we test whether we run
on a HV. And it is high time we unified those because we run more and more on
HVs nowadays.

> There is one case not covered by setting the global x86_hypervisor_present at this point.
> Xen PV guest will not go this path, so Xen PV guest will not see the hypervisor bit.
> 
> But maybe we can just ignore Xen PV guest case today?

Nothing changes before or after this fix. So Xen PV can be handled
completely separated from this.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
