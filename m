Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AE224FA;
	Wed, 18 Mar 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848398; cv=none; b=DZcHWM/iIUpWdNRpsHkjeREmgLNmA93QglHOtVqika72lXeuoOragAg5e6euoj/7zetNCp3pskRZ0XfdwI++xfDyaBGSYJB/Inav8mO7CzFfppn3d3XW3x1mghHqr7d707OnA9q9eTCS/v5iGfBLpnfzU7uQReGEAiU6ee0rsf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848398; c=relaxed/simple;
	bh=eyk1uhwymVZw+J3KKFGH/0h+tt4qrTKUhQOfz+w60tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBnck8HARnceTXEckil4ci7ev2b/qs7SXGZqzA/lc/fWGwjDpvGs/pJMGt6lre54Fx/YiQKijZ6LO2i5yxV6a6ABSiQUHQXUB7X5QAUFyBjLACJlpzKgSOYL6+beRZRGhwaLVBmwcoktAdUuRn34Lorl50y5MieWrMwB0oVleF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Dv3078RH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dv3078RH"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D014B40E0224;
	Wed, 18 Mar 2026 15:39:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2Xo13spqg7rf; Wed, 18 Mar 2026 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1773848380; bh=glFFB6Yo3VpbqeKhr8SdXci2nPSMcl11KpfYt464fFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dv3078RHGkY/5NFUhjcM1H0x9mkA4zCQPCUPIYak1IOTaX+0h1mwNvsljs+hN8xBB
	 dYRFUNYMRHo2o60+hD2PhvuVvLOELqy2HO3ubOJmtKwoTkyaXaaXJUBVNOscpd6GBU
	 vqwmwyudHAVJdLbQXT2tS26RagBpgUncm66zw+pxkYEKqjQMVX86dAZ18hgKKqyQW3
	 Bcd5KqbOfEysV6ZqTLF/LQVzmmDZEOA9p64cHZWDeP3pZ/C8Fdqoc4U84iNuqk/g5W
	 uBBRbrdLTYHL1Yfit0isWrR6BmCr/SQ5JYTMM4zOzOBbssncutaXEfDJryOK47W2pA
	 9Fq+3wwkQc8D3zVw85Q+egwmus+M2R+UA0QTaIHC9cIuZYbEmz6H+2n1/o8PjpnaxK
	 yP7/oN7NQbfO24URqqTmVnUuVRsp6O9bkqEGEMcMoOMpj5WJfnLhfxwLqnxKS4Ez64
	 XjWEXtK3XZjoxDdY0ErsCr7WbW0Wpf73iXX3URGS/6Qh/JslGz/yPjP6hpsk1BhZkO
	 dOa6iSmO/8ipuuqotvrGQFE8VTE1+pHbaZwoP0e9JCS4NmbgzfywAbHHvGrFeZq2Zn
	 MKR5Tv2FuL1AV9DYX+qFmXyDoL6FpgDJc+YHlGsX3zypH9dn+VV+m/u92IsO9uvGDE
	 9/L+8VpfvEgtykYkOiEHGu6Y=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5658940E0221;
	Wed, 18 Mar 2026 15:39:25 +0000 (UTC)
Date: Wed, 18 Mar 2026 16:39:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, thomas.lendacky@amd.com,
	dave.hansen@linux.intel.com, tglx@kernel.org, mingo@redhat.com,
	hpa@zytor.com, xin@zytor.com, seanjc@google.com,
	pbonzini@redhat.com, x86@kernel.org, chang.seok.bae@intel.com,
	jon.grimm@amd.com
Subject: Re: [PATCH v3 1/3] x86/cpu: Enable FSGSBASE early in
 cpu_init_exception_handling()
Message-ID: <20260318153918.GBabrHJjRA6T2crJbK@fat_crate.local>
References: <20260318075654.1792916-1-nikunj@amd.com>
 <20260318075654.1792916-2-nikunj@amd.com>
 <d3140cf6-e61a-40a5-8153-300d5fe07954@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3140cf6-e61a-40a5-8153-300d5fe07954@intel.com>

On Wed, Mar 18, 2026 at 06:54:46AM -0700, Sohil Mehta wrote:
> It would be more accurate to say ".. before any exceptions that uses
> paranoid_entry() can occur.."
> 
> I think early exceptions such #VC can still occur and the
> bringup_idt_table is set up to handle those.

I really don't understand what the splitting of hairs is supposed to bring
here?!

The commit message is more than clear and overly detailed - I even thought of
shortening it because it went too long...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
