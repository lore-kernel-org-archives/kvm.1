Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018630;
	b=tev1JNzwkSRbJA5CRI+5c4y5PULRs58VcETQcRUGFWAh6dTJ4j05VAFYOlMNZ1CIOZCm
	 t+FXyDUB5krZQBAFvwPg4g3Rm1z2A++sgXcvK+IUOKOX0OfMfApMGCkXGKwPH50ruyoCH
	 3OKszgRuMP71Hl0DSXLkkKlvDebru1o6/36ex7XXZdaMqCc0ZJOnJNs3SyD7+gopXVFAv
	 V9IZrkwfQdRFIXLt8MjYj1CcugzCNagKQ89SVh3OsLTdQ6OLb83L9w0iSVV8LO9HdR2rf
	 D9sXjDIaq2O70LiMrkpvqcv/uBrlIZ3HLU4ZBmpWDh13x4FMz2nQZBqjmyf1C3KXD4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018630;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8frWPaVaB9d/k6ijjDWbjjjUUJ/LohWseRkfCzhWv8Q=;
	b=TAJxNC7n3PEM2iVAshHboDA6cuyZ7mHjDQP12I+nvNQVzX2UMJQ4Ji9Qfc8300DP+1gs
	 2+FoTiKGW1fKaX1LyQZKAkiwuuRwODURQV+ntDSE1+ChBUr5mcuoNCiShrcez9xgXiSAp
	 rAtR2tSisbFM9A8LwqwPp66o28p2F+Y/wEHI/xu14SbEKUoQyBPAyGzNyJIiUOtzl+2pM
	 kTFDsbBRwCWu6TQ5q+VkslkZ/q/Apb1TUiQim14xB52wYkfFFcDLOcuPv2iOKbAqXC6eS
	 9vR6o/FM2B8PRoK0imUB1kQz/jqc1bBR99bLdM3A3nm5XC40y32SB003QV0guPEPuHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvZ55scC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05F606A32F;
	Wed, 18 Nov 2026 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvZ55scC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826E51F000C6;
	Wed, 18 Nov 2026 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018630;
	bh=8frWPaVaB9d/k6ijjDWbjjjUUJ/LohWseRkfCzhWv8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jvZ55scCw9jriUaLK5rs8KLzw3ga4j8gjai6+GQKG7VDHmKCi6+E2wZJCxvgwqGwC
	 yFv83HyrQ81PmxWFi8G/GeB6kn3k+Z4kU9K4SnnBoH8KXDsCptoDx5v8zxZy7aCIPC
	 aT3x5YembzkCGG0D7IkWbwGMsfcpJPIiU/ig8Hnxz0alvc4IiRbvOFcwna1Fm2cbU3
	 P/HCIv1KNZvMAmfVctIu26E2CHZ9fxU7bCd0wapGS8Ffc/rFCKWkP4OasHL0ZN2NWr
	 cwuHs/rwmQ7D1A41U3o+swSGH6TXX7+mcV4Wyu2spzS1Daba8r8mZfXKWkTLcRsrOn
	 AHAHzSLjWBDHw==
Date: Wed, 18 Nov 2026 16:17:08 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 15/21] KVM: x86/pmu: Clamp pmu->version to
 kvm_pmu_cap.version
Message-ID: <av3O9YqD6iW4UT9c@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-16-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112203227.289379-16-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:21PM -0700, Zide Chen wrote:
> KVM's policy of not policing guest CPUID allows userspace to configure
> an arbitrary PMU version without KVM rejecting the ioctl or mutating
> guest CPUID entries. As userspace is responsible for validating its
> configuration against KVM_GET_SUPPORTED_CPUID, userspace is entitled to
> "shoot itself in the foot" by presenting an unsupported virtual CPU
> model.
> 
> Clamp pmu->version to kvm_pmu_cap.version so that KVM's internal state
> tracks the effective PMU version that KVM supports, and avoid exposing
> or emulating features that KVM does not support (such as MSRs gated on
> higher PMU versions).
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Suggested-by: Yosry Ahmed <yosry@kernel.org>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v4:
> - New patch. (Sean, Yosry)
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 5eac64ba8832..0be9956810ae 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -574,7 +574,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	eax.full = entry->eax;
>  	edx.full = entry->edx;
>  
> -	pmu->version = eax.split.version_id;
> +	pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);

Why not AMD too?

>  	if (!pmu->version)
>  		return;
>  
> -- 
> 2.56.1
> 
