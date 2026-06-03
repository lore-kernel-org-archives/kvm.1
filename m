Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385122797AC
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780483309; cv=none; b=LUQQUj3BgSChPfhAC98MmmhUwk9BMUZeFzSKZJc1V/gJNoArnbaQxFhrcWoNH77qy81BXuWj3zz8p5apiAtcui06uJjPgU8bv7Ipca7pfGFcgnOk/4yW1HA/5wZr8S/4BQQN9XBtz3v/heoCVqXQtvCTiWcaf1MmDivDWm1wHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780483309; c=relaxed/simple;
	bh=h+ZuVSoyn2f1R6RNdPoshSsNv4hvAn9pMDfj8Vd1zOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzq8pSjJ4pba3Om0E0dmiRpDQP6qXptm9gZkJg2v8kiD8kGrnyaOBd2gRwbUShM7jwiGFYsEdrpLPsvoJeGahkLvGzspkMjCP0BUUy5KyZXcS0UVDJndS08WdG3EeA9v0ATX6rn8zjPQNU0LAVKxO35PrC1ifd9sGmi2wEUIQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TeqeoHSI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TeqeoHSI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B539B49DB;
	Wed,  3 Jun 2026 03:41:42 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969383F632;
	Wed,  3 Jun 2026 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780483307; bh=h+ZuVSoyn2f1R6RNdPoshSsNv4hvAn9pMDfj8Vd1zOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeqeoHSI/x9EM81iEnVCF0ARFOYjblxXEGhx4L1AwcrKZ/mx+ECZwGz0yV4flC78l
	 C/vUc8LSL7MLbs4lCfASYAfEuB+3YUcVRO1dTgBZDy8ncjfTuGgKu92Ep9SeedXpeH
	 /ywK9Tc7Bz2NaHBXdyvP1aEsPCYYDjGqg2RLes4M=
Date: Wed, 3 Jun 2026 11:41:42 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 0/3] KVM: arm64: FEAT_{S1POE,ATS1A} support fixes
Message-ID: <20260603104142.GA2078466@e124191.cambridge.arm.com>
References: <20260602155430.2088142-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602155430.2088142-1-maz@kernel.org>

On Tue, Jun 02, 2026 at 04:54:26PM +0100, Marc Zyngier wrote:
> Whilst working on a slightly unrelated feature (FEAT_NV3), I found out
> that an L2 guest wouldn't boot if the host was exposed to FEAT_S1POE.
> 
> Upon investigation (and hours wasted in a SW model), it became
> apparent that while the AT S1E1A code was ready for action, it had
> never been fully plugged in (blame the usual suspect...).
> 
> This resulted in an extremely odd failure mode, with an L2 being
> unable to make forward progress, but KVM at L1 not taking the hint
> that something was really wrong. Additionally, an embarrassing typo
> was spotted in the CPTR_EL2 handling.
> 
> With this in, FEAT_S1POE no longer breaks our NV guests.
> 
> Marc Zyngier (3):
>   KVM: arm64: Key CPTR_EL2.E0POE propagation on FEAT_S1POE
>   KVM: arm64: Wire AT S1E1A in the system instruction handling table
>   arm64: cpufeature: Expose ID_AA64ISAR2_EL1.ATS1A to KVM
> 
>  arch/arm64/kernel/cpufeature.c          | 1 +
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 2 +-
>  arch/arm64/kvm/sys_regs.c               | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Joey Gouly <joey.gouly@arm.com>

Thanks,
Joey
