Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019363C277F
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764192; cv=none; b=B+Yy+2d3OUuOidjzoBrWZQu9q3GFI0oE5H9c9detVN8o0Z00Y9manf6bbM00+P/FigShQGOvNzf6ImXCGFl1yaoA1hCV4UCVFHss8s6IMWyMRzg/zzELYcidVBuD/XQRvXiOg++LSr0iU7nyTMY8ic9Qyln4sPGL1cWadD8bzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764192; c=relaxed/simple;
	bh=FnTw4gkh/aMEPEFibFib7E8fab8othFzaK/43ijCVHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl+gNQ9x9bsggfw9eNtqiNNLmRgSfFNa5+9jFOEDfMwmzFzcrLTJucuYSOkUN5llPx9TdrChcSeuW6LhZmyQH+dAji+pybIAhZUDrPTtT11NE8+09koIVm3Z+rB3zgoeFjb525z2aK4zsi0eBIYxlL00ryg+QFMb/rNR1puhFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANxPZGN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANxPZGN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C156C2BCB3;
	Thu, 14 May 2026 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778764191;
	bh=FnTw4gkh/aMEPEFibFib7E8fab8othFzaK/43ijCVHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANxPZGN92Di3TGZw6/3a6diXF1dDnHsPJ8SIAQLySFg3ylzL1PLgA/buFniTNLMsN
	 GM2j8NJK1+C/ArwdxL+IS3DaDPOJRWdg8dVEED/BpVyEzh5gRL3UplU1fzLM89XCmq
	 mHfs1ckUs3wUni+aWwkCoJ5RO47Dmp/iTOeGQaXjriWnDwmtF6+9r767SZQPNnUgJs
	 uk2Xj7kIpqjfiVhkbXkpfy8J86Nwusrom02cCDX0XdwEOea/0It80ijT1D2FYg1N2p
	 utbMx7odBSVLT0OpVTaaikaAY7GSuJExj7iA5czOBThSqrd8Z5TSIfHg8MfYoixP66
	 ORFw8bbzBlpRA==
Date: Thu, 14 May 2026 18:38:15 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 4/9] KVM: x86: Introduce KVM_CAP_LAPIC2 for 4KB APIC
 register space support
Message-ID: <agXHsttHBB6XQLMg@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-5-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-5-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:47AM +0000, Manali Shukla wrote:
> Add KVM_CAP_LAPIC2 to allow userspace to opt into extended APIC register
> space, i.e. to expose the full 4KB APIC page to the guest.  Extended LVT
> registers are part of the 4KB APIC page and are AMD-specific. Extended
> APIC registers provide additional interrupt vectors for hardware features
> like Instruction Based Sampling (IBS).
> 
> Use a capability negotiation model to allow for future extensibility.
> KVM_CHECK_EXTENSION returns a bitmask of supported capabilities, and
> userspace enables the intersection of KVM and VMM support via
> KVM_ENABLE_CAP.  This allows KVM and userspace to independently add
> support for new APIC configurations without breaking compatibility.
> 
> Define two capability flags:
>   - KVM_LAPIC2_DEFAULT: full 4KB APIC page support
>   - KVM_LAPIC2_AMD_DEFAULT: extended LVT registers are supported

This should be split into two patches to separate out the AMD bits. The 
base patch should introduce KVM_CAP_LAPIC2 and either also introduce 
KVM_GET_LAPIC2/KVM_SET_LAPIC2, or should be after the patch adding 
support for KVM_GET_LAPIC2/KVM_SET_LAPIC2.

> 
> Require that the capability be enabled before vCPUs are created to avoid
> the need to handle runtime changes to the APIC page size.
> 
> When KVM_LAPIC2_AMD_DEFAULT is enabled, set kvm->arch.nr_extlvt to
> KVM_X86_NR_EXTLVT_DEFAULT (4) to track the number of extended LVT
> registers available to the guest.  Future patches will use nr_extlvt to
> emulate guest accesses to extended LVT registers at APIC offset 0x500.
> 
> Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  Documentation/virt/kvm/api.rst  | 31 +++++++++++++++++++++++++++++++
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/x86.c              | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/kvm.h        |  5 +++++
>  4 files changed, 67 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/api.rst 
> b/Documentation/virt/kvm/api.rst
> index 01a3abef8abb..71b4d24f009a 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -9291,6 +9291,37 @@ KVM exits with the register state of either the L1 or L2 guest
>  depending on which executed at the time of an exit. Userspace must
>  take care to differentiate between these cases.
>  
> +8.46 KVM_CAP_LAPIC2
> +---------------------------
> +
> +:Architectures: x86
> +:Target: VM
> +:Parameters: args[0] is a bitmask of LAPIC2 capabilities
> +:Returns: 0 on success, -EINVAL when arg[0] contains invalid bits
> +
> +This capability indicates that KVM supports extended APIC register space of the
> +whole 4KB page.
> +
> +Calling KVM_CHECK_EXTENSION for this capability returns a bitmask of LAPIC2
> +capabilities that can be enabled on a VM.
> +
> +The argument to KVM_ENABLE_CAP is also a bitmask that selects which LAPIC2
> +capabilities to enable for the VM.  Userspace should enable the intersection
> +of capabilities supported by KVM (from KVM_CHECK_EXTENSION) and capabilities
> +supported by the VMM.  This must be called before creating any VCPUs.
> +
> +At this time, KVM_LAPIC2_DEFAULT and KVM_LAPIC2_AMD_DEFAULT are the supported
> +capabilities:
> +
> +  - KVM_LAPIC2_DEFAULT: Full 4KB APIC page support
> +  - KVM_LAPIC2_AMD_DEFAULT: Extended LVT registers are supported (they are part
> +    of 4KB APIC page)

I don't think KVM_ENABLE_CAP should be necessary for the base LAPIC2 
capability (i.e., for using the full 4k space). That will make it easy 
for userspace to default to LAPIC2: it will only need to query for the 
capability and can use the LAPIC2 get/set ioctls always.

- Naveen

