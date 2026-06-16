Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD0140DFD5;
	Tue, 16 Jun 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781596774; cv=none; b=bhX/7wv/nrlO4jQutXG+7vaVkesI4e9ErHe+Wz1y6Vxfsi43N+YYM9B88Rb8EnnNy22t51hO9PNXN9OMJLYrYquAOSJbqApLoTj4/mUBCX3cHjZEoUp4wxDZTQpFoukNx9A4kw21MuGnBGahdNmVZmwxO0Pt9kt+oJkhYpJMOrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781596774; c=relaxed/simple;
	bh=gKP5DcvmMO6xgByzdiIkNIGkOK6SkC+32eB1C5N0gV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWXhPHvvn2+COMjWDtL5jc9zh+0tdcN+5BKGOjjAuWjIYgq5Z6q5Gbbtc4we5IfLXWjLNoVMhgcpMQt6fjJxThbRg49rQ+13b/77f6MqHEmPXV8raP/Eah2GS18NUcy2i26MlRGHhH8JQKszmSdXR5ywomUWTZnnbfqYWiwl1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgsIaeJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgsIaeJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9321F000E9;
	Tue, 16 Jun 2026 07:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781596773;
	bh=DI6u0Wnv2/kzWWu1T5MhnvSeapILfFQhVfTVysZJ7ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lgsIaeJqUmIBMv1FVGx1SEOH1/vE0QATOaph/QXxvOHblNyj8iffo5fUtttsvm5y1
	 iRTV7seo6na0FpQxlthfczl7Md5siyeieQg4fX46YBs5I1n1wdF9RzECfO8NIYr1z3
	 s6T7XVN+0Bmhu4pQ7EODTXMaYC6rKrijLS2UIMuohW6C9QmHAv3RIm5nwulvsRnO2c
	 s80HOt4t9A677Otcb9swFQEqzHfAVqOs/BYwSh8Z5ppouKQQDu/WaMM1MKfK+8AhP0
	 JbhbWEtdoGDs9bjK+o7t6cTwSpbKX9RKRci3Mly4/pTfiGEJYMYTQV9PmX2naDm1cO
	 iIkQyLVD6/ICQ==
Date: Tue, 16 Jun 2026 13:27:51 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>, 
	Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH] x86/apic: KVM: Use cpu_physical_id() to get APIC ID of
 running vCPU for AVIC
Message-ID: <ajDsUg236ilh40YZ@blrnaveerao1>
References: <20260612185459.591892-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612185459.591892-1-seanjc@google.com>

On Fri, Jun 12, 2026 at 11:54:59AM -0700, Sean Christopherson wrote:
> Use cpu_physical_id() instead of default_cpu_present_to_apicid() when
> getting the APIC ID of the pCPU on which a vCPU is running/loaded, as the
> kernel has gone way off the rails if a vCPU is loaded on a pCPU that has
> been physically removed from the system.

Or, has been unloaded from a pCPU that is then soft-offlined and 
physically hot unplugged before that vCPU ever got a chance to run 
again!

> Even if the impossible were to
> happen, the absolutely worst case scenario is that hardware will ring the
> AIVC doorbell on the wrong pCPU, i.e. a severely broken system will
> experience mild performance issues.

Indeed, sending a doorbell to BAD_APICID doesn't seem to do anything 
bad, so I think we are ok with this.

> 
> Kill off KVM's superfluous kvm_cpu_get_apicid() wrapper along with the
> for-KVM export of default_cpu_present_to_apicid(), as they existed purely
> for the wonky AVIC usage.
> 
> Cc: Kai Huang <kai.huang@intel.com>
> Cc: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>


- Naveen

