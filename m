Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996051;
	b=k6K6zr1b0KQT/fL151/SCFmlhwZqe+QX0IwFzFAd6XMXEcDG2rciMToNpBQufb1YRVfe
	 e+agrc9ZvJ5oOAjoB/QeLEQbmu74pBvk3UDkvvXudzyrA7scrpOONezdEdpBhW7cwTFU4
	 4qWmLlPOMb19Vd8EUjwezYXboHTDGSevWHerbusunWjobMrop3UPToqUeUIx8jbu539Eg
	 v3it+t1Lhzu0AclJNyU0ONtKI4Ik0xn/DzOE4FB91WIEwPqt7YPwR3//euXacXzU2OWH9
	 NJT5ZwnY7W8xKzJvyiNM/3qOOZt8Az9Ay0P2mO5dBmvInF5fnto7wcBnBE34xNRK3Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996051;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J2iofcJL87VuzLLEHzx5m8VEI9RC+TD/ZaA8aoGOZDw=;
	b=kTzUV4VDTFEn86/HKd8OmZ08kNWZ/SnSIV172kVWq5wICfdLuPsLbls7QQE2s+Y+yaGu
	 iG0xjXsp5d+Bl0ax1MSStgCt/HuAPOIaYx2tzXu8yHH0T1gkVHf0RrYKtnCr0S5zEJe6c
	 iEtJ7B2qScGrld0eDXQAAqb+NMcAAtJcrVN4jnoW3CisQgI56k3si5h2uH+K9QNUGPRRS
	 Mi2KbqXSKd32DTV255aDn8jRsCxYqAOufp/b7QmPREW+79jX/JloU5nJLUa/VavNiOWSa
	 mtK13IhVf74AW+Bv0XyLp2AcI1htuOeTBJKm/p62VuIcnS3tmrvxQTDesy+B+4aX4Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXaD1Xzg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11D1606A329;
	Fri,  6 Nov 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXaD1Xzg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC18C1F008A4;
	Fri,  6 Nov 2026 20:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793996050;
	bh=J2iofcJL87VuzLLEHzx5m8VEI9RC+TD/ZaA8aoGOZDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oXaD1Xzgw1JyR1wcRKyOpDEt0LIlgXV8PHnUfD8BQf9ROua1LidW2jrnieOcvqXW+
	 zAoHYyub6OnczfElGs+pnnj2kFuD4+fwhQte2FQnBmqPGrm8lSPBMsS5Cd2+mTcVVg
	 RDPSWZSOcA6K7zg4fTx7dB5xNHzUk58Jss8K5ZR3BSlIX7BEET4KF/fX1fo92aPD/k
	 6m7mtph7fTIQJCnjygbzqdSVDBqnErFn6VMXOAr0pfTjqLYrEpqaDwuqr/kcbg0yY/
	 HPYjo3NAO5LmRVXMwYJYlBdtGCAv2cWcdPqJS3+rpKnF+BbJ7B9ANqEJGxbmxH44uW
	 afcjzZC2lBQsQ==
Date: Fri, 6 Nov 2026 20:14:08 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 10/18] KVM: x86/pmu: Document GLOBAL_STATUS_RESET
 passthrough erratum
Message-ID: <au40uLZo3C8a7fdg@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-11-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-11-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:19PM -0700, Zide Chen wrote:
> IA32_PERF_GLOBAL_STATUS_RESET, introduced in PerfMon version 4,
> inherits the MSR address and architecturally defined bits from
> IA32_PERF_GLOBAL_OVF_CTRL, while providing additional bits to clear
> new indicators in IA32_PERF_GLOBAL_STATUS.
> 
> From an emulation perspective, KVM handles it identically to the
> OVF_CTRL MSR: reads return zero, and intercepted writes are guarded
> against pmu->global_status_rsvd. No code changes are needed in KVM
> to emulate this MSR.
> 
> However, to reduce VM exits, KVM passes through this MSR in mediated
> PMU mode when GLOBAL_STATUS is also passed through. Consequently,
> writes to bits that are valid on the host but unvirtualized by KVM
> will not trigger a #GP (unlike when the MSR is intercepted). Except
> for the known limitation where host Intel PT in system mode can
> assert Trace_ToPA_PMI (bit 55), unvirtualized status bits are not set
> while the guest is running, so clearing them has no negative effects.
> 
> Document this divergence in errata.rst.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v3:
> - New patch prompted by Jim and Yosry's review on unvirtualized
>   status bits.
> ---
>  Documentation/virt/kvm/x86/errata.rst | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
> index a9cf0e004651..161ba6d1beb4 100644
> --- a/Documentation/virt/kvm/x86/errata.rst
> +++ b/Documentation/virt/kvm/x86/errata.rst
> @@ -84,4 +84,12 @@ memory.
>  
>  Note, this erratum does not affect AMD CPUs, which fully virtualize CR0.CD in
>  hardware, i.e. put the CPU caches into "no fill" mode when CR0.CD=1, even when
> -running in the guest.
> \ No newline at end of file
> +running in the guest.
> +
> +IA32_PERF_GLOBAL_STATUS_RESET
> +-----------------------------
> +To reduce VM-exits on performance-critical paths, KVM passes through writes
> +to IA32_PERF_GLOBAL_STATUS_RESET (0x390) in mediated PMU mode when the guest's
> +counters match hardware, without injecting #GP on unvirtualized bits.

Might be worth clarifying that this refers to the number of counters
matching, not the values in the counters.

> +Because the MSR is read-as-zero and write-to-clear, this cannot leak
> +host information to the guest.

It can let the guest clear host state tho, but I assume this isn't a
problem because GLOBAL_STATUS is saved/restored on guest PMU load/put.
Might be worth clarifying.

> -- 
> 2.56.0
> 
