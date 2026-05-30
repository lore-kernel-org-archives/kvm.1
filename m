Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F661A6814;
	Sat, 30 May 2026 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780103031; cv=none; b=HSN2bWymekRHDrHB3yAep0N3PwWxwkwIXUDan7k+PODJHKmbt+9e6WiMbY+XxdRpYcgDAjoVDWHcuMBuMG4vpKuYP5Tr85JUHM5WV4YcRGuJqsOV7fzARXMwD5jlUUjbAaxTMbd5S6cUMvqsHdDmp1qtnfSVo/Vp6F32OQMMds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780103031; c=relaxed/simple;
	bh=mro1/v3FSPkKI3rghUUMNO2a9UFY9+kXVcLdOqtiSos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7Sa1JuTh7wtOibJfsgOio4LzRTxF00NoUE9YUDg6VaoyQ4Ou3gKfU2uZcz0NAa/RbKGcORMkV17DTbpcEfHrslgBks5gIwxZoJVTV7omUNSjNLW4+PdRxA0TB1w8BS+NfPHXsPmBqcW0IGDP5/lNzRfg//iBpZ1e/McM+C7zis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsTAo1fP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsTAo1fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E271F00893;
	Sat, 30 May 2026 01:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780103028;
	bh=XTMypCakE4jegsEZ8u4mMZAzAyMH2zquTIvQGgmIrNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bsTAo1fPetLFJWt7W4tjS8k/QiIRs4nz3+H16dL6gOPvkP/+e4alifv244KNpP7sX
	 41TWkWJQyOql023DvKFDOg6Ljf9p2VYW1lMimPEBIJlvr/EgT2H5suWgodM9sQGRIN
	 pmLiwoCbdWKYVBQElOeXvSvR76W7PdKDbVtzKzmUy+Gh1we/FXtsbgh+0ysnhKm+l7
	 0d7zKBNnr8MOYPyN4aJM42+kReFqjrXcWkE88588ywqZzfc9vWdQ0bigZMK1C2e7Ww
	 dOX0hpVvN8oAWJ6hRsHzv0Mk5RsGh8zQynLGSItlSpTInIKN+dsoPLJvIxOl6oedwh
	 dbERR2UPFzjnQ==
Date: Sat, 30 May 2026 01:03:46 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Binbin Wu <binbin.wu@linux.intel.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCH v3 33/40] KVM: x86: Move kvm_cpu_get_apicid() from
 kvm_host.h => avic.c
Message-ID: <aho3bUUI_RGXXGvf@google.com>
References: <20260529222223.870923-1-seanjc@google.com>
 <20260529222223.870923-34-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529222223.870923-34-seanjc@google.com>

On Fri, May 29, 2026 at 03:22:16PM -0700, Sean Christopherson wrote:
> Opportunistically drop the CONFIG_X86_LOCAL_APIC=n stub, as KVM hard
> depends on CONFIG_X86_LOCAL_APIC=y (the stub was there purely to deal
> with kvm_host.h being included by non-KVM code).
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
