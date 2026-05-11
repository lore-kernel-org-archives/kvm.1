Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD934C134;
	Mon, 11 May 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493920; cv=none; b=J24++d08MlWyAjZzDx63B5yzUFCunuZBH7USj/kJsE+gBr7CH7N/DzMSDORUiw30culrxDxk1u0qRepWy0pmFjlp/matzloawZ8aclmN921UxKwrTJZSoxFXiWmFJU9S2dJKW3uQPVmJjdTRuJJQ8WP/qK3PMe+s9tFWV1FWjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493920; c=relaxed/simple;
	bh=kR2dotnzAhWRRqmpbucEJ4jJbQlDQ8K6A1NNnjA0RgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mr+1Xi/Y+EBIuJV+WhaJhJiHTS1ndFXeVxd8Yuf6tqadbd5vXd0AdU26AqtDjJDoNTZ3a9Olbm8Kox7IjuAdDMuLnGDgu2oZQ8j5R8UItX4aFL2Em4BPd8cTbsUpfDA3ov+XLCQkE4Y5yyUYb6lAaYVBk5aZFZfUNIcxsyaaTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XhGnS1DV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XhGnS1DV"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B7DF240E01A1;
	Mon, 11 May 2026 10:05:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vLB8D-dmiw3F; Mon, 11 May 2026 10:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1778493905; bh=hD5C6lV0NA5nGnxBVSJSE3Q6YDC/eyltW+R4Qr+bEtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhGnS1DVEp4M+s+6f4qL7neas3S04UNuuB+UkSVR+uuUNAnBdkit7DT0KAgfqatK9
	 SzkFVR4o7aFbyRHDkq5zBoSayxK4ibRkyGjacCW6ak89K1MXQRGxZe2x8qVYP6vC6S
	 1tySLsKFT+q8a08vvVSF6FMDKqwcH5M/iydfUn1n9mtIsdnSQlJQTsM5DAmYXzwd/5
	 fsxY5kPWFLqfkXzZfOz9vpAj/BJxximnScpKJTFOCFR+QAXwgvxaN5C5/nhgkUoVPm
	 shzL2GxS6j7NUJC/b9SB7/JY0Wqj40g+agyA8JAFGGb51YRRhSAaD4mcd2XtzB9s05
	 NDkwz/Yb8Z3VlyRDs28eTJCx52f9xTiPQflWaClTDrfUwOpyb/y4Ge2bbKFbYSINqb
	 Tox0off0MMMgFjN2MvQds9IXf3vs0+O61cXnR4mTwfQxK8btyM8B4kbvFFlL/riSUy
	 m1boeggUh0DBerW562XRXinaGicOhKPBc03yplrwYqnd5o9bgXPJhSetSV161kpWnn
	 XwWc/8lP/H4MT8GmKdAdj6766p5qMjolR4JJkH4thr+3Eav48Hw+AJsFeDBRlC7vdQ
	 gHM3blfIuIgUFMhPuiA7FsjKd3+WmXqFhwNuZQudtkcXCNoiqJlEZhosA++scym4MO
	 ozHFTZls6CHFosImMg3j/dcY=
Received: from zn.tnic (pd953014d.dip0.t-ipconnect.de [217.83.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A84B640E0140;
	Mon, 11 May 2026 10:04:53 +0000 (UTC)
Date: Mon, 11 May 2026 12:04:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
	kas@kernel.org, rick.p.edgecombe@intel.com,
	vishal.l.verma@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
Message-ID: <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430020953.1405535-1-binbin.wu@linux.intel.com>

On Thu, Apr 30, 2026 at 10:09:53AM +0800, Binbin Wu wrote:
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 37ac4afe0972..1bc0c350726c 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -147,6 +147,10 @@ u32 intel_get_platform_id(void)
>  	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
>  		return 0;
>  
> +	/* Don't try to read microcode bits when virtualized. */
> +	if (cpuid_ecx(1) & BIT(X86_FEATURE_HYPERVISOR & 0x1f))
> +		return 0;
> +
>  	/* get processor flags from MSR 0x17 */
>  	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
>  
> 
> base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
> -- 

Does that work too?

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 18d2eff7a4b7..1b24de94bdd5 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -139,6 +139,9 @@ u32 intel_get_platform_id(void)
 {
 	unsigned int val[2];
 
+	if (hypervisor_present)
+		return 0;
+
 	/*
 	 * This can be called early. Use CPUID directly instead of
 	 * relying on cpuinfo_x86 which may not be fully initialized.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
