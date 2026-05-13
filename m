Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A35D3B2D04;
	Wed, 13 May 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702454; cv=none; b=CjhtkHcS3hm5w3FpEM71WhMhcXs7dgv7B+HYHlH/f3dAh/vUqusJncAX1ybz+OzOsx+QthqqLIvIGit2R756X99fZAIkE1pZJEMs1kYrt+T5WOlIkGDxAxIQYF/koZ10j5vW3eMBU/2ZjtpjdxHq3c2UICapjaNpK7yh1hKRrkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702454; c=relaxed/simple;
	bh=h2Rp8pECBnEEjbxWg2cSp4Ha8T60BcenwNfy9tLnHY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua7/syyu2mMOASuaell+zWd8R6mCnpyoQ3geAm4+9GHQr/qMpK5q6YqMmvsWKZmw0Z6Fb+YqVqf37JUy9hmXpGLmlZVBKo+Aam3NUhid8GDCj4HX5iCypc77oW9MsKb/QT1qJaZDGZh6KNQ9LLkUWXa5rV2U4HVPxDQGbl//jwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UbgaxRCR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UbgaxRCR"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B244140E00C2;
	Wed, 13 May 2026 20:00:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bCSP9vlyU4KE; Wed, 13 May 2026 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778702437; bh=Z8gZ8G7+I7sJIr3V0YVbx+2hUE06GUS20RPMnyBEraU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbgaxRCRphe5aE9aGrPdKGhf7480O4SHqK915N0vgN5qv2gYHNLDmm5hEx9ox/wDm
	 WD5Jqj5xGJYL6wgPfX6W3ey9Xac0KNRoiKlrJH7cswIkCl7NgG1Vc70Qh4SeaQmWwy
	 48SzlsSgezxb2T+2E4pHtePNul9Ax1cMSHjmo2mBleZujVrLdfAE/kqFfj61aHMa4v
	 3LD4fkkVsQJMGtIeOvZGE6HCg7+wOCGZVvi9j0lGeaFRBRxOWPy793+wgJO+0LpHJD
	 /NJit+hUSA7ydCNeu6ZL5TWzC3w/pYY74RZMP0Hw8SpViZbSCrrqpEnWsmR99fUTtx
	 wjv40fKeuVhbX2/mNwHxHWNVLScsj5bnCIpPNWWlUeCg3I6dOYETJKuWIJPZfxYCY1
	 RYHebW4t0AiE2z7g20M6AMc/Hr8ReKiiX5knhMFei6RIss9qmVEZGXr16L3GQSooYo
	 M99I6AgBsUyL2re0D5/uqzH9j2TlxdfBYvowP0OKu4hTA1DgmbbIcACocu/flneDQC
	 kYE3/W5XUtVp5b7PC15KED6MDbvVhTJo1BDY4lmCBJwDSK39umhH6102JTcMv0O3Mt
	 yfKZLKlMdx+jfwaBlQhYJWTKUNaJE3UjAhZnqOWJnuwXKXrr4Z6TMM93WETW9xA0mz
	 vc3TWwzkBBYxctH1PqgC0jrg=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EC1C940E019B;
	Wed, 13 May 2026 20:00:24 +0000 (UTC)
Date: Wed, 13 May 2026 22:00:17 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Message-ID: <20260513200017.GLagTYUe_TGXnFVh7I@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
 <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
 <20260513101436.GAagRPDAryWZ5hGqFO@fat_crate.local>
 <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89d52fff-ec3b-420e-9f01-5cd2bc8ce5cb@linux.intel.com>

On Wed, May 13, 2026 at 10:41:18PM +0800, Binbin Wu wrote:
> Tested the diff by running as a TDX guest and it fixed the unchecked MSR access error.
> 
> Tested-by: Binbin Wu <binbin.wu@linux.intel.com>

Thanks.

Patches coming up as a reply to this message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
