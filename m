Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB14296BCC
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763056; cv=none; b=pR71sjoMMXPe2zDDU9l/avjhAH0bPTnjW7WtVzEGNHvm1GbawWWJGPIC4PoTntgQen5jTvSG1Qhzg3R6DOTFkL1rH0/8eJGu3Oa4o80dQ91iduuTobLQUxA8TtC87XixYmOZEYQEVjmE6gAhdazFn5eJ0s7PsjH7XRy4qo6fn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763056; c=relaxed/simple;
	bh=+USuryOZBR8gMFyPlsftSoD0sllDtWrs1L7FQu6x4+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1TYmLz3JE0DS0CRI1m+NZuvZMyUSjbJbEuW7e+BkoLeZtWMfGLi/roAlbmD5R4BwbpHF0w2qgRcPj/JZQNzdBxD4PdVMaS5mpaF53pfmvFiFawwzicNx5JlT6OcwyiFHDIN/KhZaZJzr2Ec8A7s0Ruj1IWYco2yLtXMKFzEai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzOqgd/q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzOqgd/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E48BC2BCB3;
	Thu, 14 May 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763055;
	bh=+USuryOZBR8gMFyPlsftSoD0sllDtWrs1L7FQu6x4+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzOqgd/q8CgIluR2XKLTyEPrdixzexDEqRtGCOiRaTwIQ/f3Kr+vsYnEcSCyMJPch
	 +0x1r/uiyqfS/DwEuR4/1c3bF7m8Q9zIxHUmdzH9zzozpMXSLVyJMy2SoiLek9HRPP
	 Ghhw+aR79CFAGUjJUJqizmwdDq8QaG22Br5P5xdaFsLoU4Eaip26150YWM9YYaZdQa
	 LREODZa/5KwXyf9wYrkP/t/wE7vBa4kchrCJ77PBmzqiKLnNhhDX4cKPV5obFhK1T7
	 8R2GfQAygilMHUYdBP9rzKwM1YHxeYaaPf3DTbS3wsU9hYhTlP7Gd+dB0auSyKQuJB
	 kyIoKIRsga4pw==
Date: Thu, 14 May 2026 18:20:20 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Manali Shukla <manali.shukla@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, kvm@vger.kernel.org, x86@kernel.org, santosh.shukla@amd.com, 
	nikunj.dadhania@amd.com, dapeng1.mi@linux.intel.com
Subject: Re: [PATCH v1 2/9] x86/apic: Add helper to get maximum number of
 Extended LVT registers
Message-ID: <agXEy94sHAwj2r-l@blrnaveerao1>
References: <20260204074452.55453-1-manali.shukla@amd.com>
 <20260204074452.55453-3-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204074452.55453-3-manali.shukla@amd.com>

On Wed, Feb 04, 2026 at 07:44:45AM +0000, Manali Shukla wrote:
> Add lapic_get_max_extlvt() to retrieve the maximum number of Extended
> LVT registers supported by the local APIC on AMD processors.  The count
> is read from APIC_EFEAT[23:16] (offset 0x400), per AMD APM Volume 2.
> 
> Extended LVT registers provide additional interrupt vectors beyond
> standard LVT entries, enabling features like Instruction Based Sampling
> (IBS). Current AMD processors support four extended LVT entries, but
> future processors may support up to 255.
> 
> Wrap lapic_get_max_extlvt() with kvm_cpu_get_max_extlvt() for use by
> KVM code. Subsequent patches will use this helper to configure the guest's
> extended APIC register space.
> 
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---
>  arch/x86/include/asm/apic.h     |  1 +
>  arch/x86/include/asm/kvm_host.h | 10 ++++++++++
>  arch/x86/kernel/apic/apic.c     | 17 +++++++++++++++++
>  3 files changed, 28 insertions(+)

This shouldn't be required if we go with:
http://lore.kernel.org/r/78a4c3ddce65e2a79f23aea6fdc05faf4346d290.1778594390.git.naveen@kernel.org

- Naveen

