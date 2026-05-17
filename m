Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734B33F8C6
	for <kvm@vger.kernel.org>; Sun, 17 May 2026 08:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779006828; cv=none; b=PuVCvtMDjxc3bqnuor1y7bwYRv2k1+EsbGnMeaI6eHSPv13BBvy8E2NPPDoJsnXBZ5Tc0+PdY/zMI8pgvbWjeJ1b4EdrsBPi+WsSds3FE98yFzCjn8VBbmOoDkHgqiUErgfvkJ2GvS2K3TKris0rm4kcqNIZBTeQlU2pVDCQn70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779006828; c=relaxed/simple;
	bh=jMsUzXbk15u+sEYL9pdsEfOSntHcCFKwbtkNcxW03As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf37Y5GlWlXkUb4Ws1YW62C0vtG7/wyf77eVC/7yAApZZ6tjkmkoMj0xzyJqwUzUKLU7mlYy9CsjT7CBmR7VDilFsN0nBlcQdJalIbvKsW7IzjMP1UmaLf/WhQOejTPAs5qzpIlUpAMnonXOlHL3YTFKeCUtw2fZlUB6QZmEJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxNviKu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxNviKu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED95FC2BCB0;
	Sun, 17 May 2026 08:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779006827;
	bh=jMsUzXbk15u+sEYL9pdsEfOSntHcCFKwbtkNcxW03As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxNviKu9Cn97wFZNCO7JbZPk/fSHnbdwXcxrU3+1dJXfoVLVaKoaAWCUaVq9jEe+R
	 rFaEXXttnWxne1zS8EzG9rc113zhlw9K/C1dT65woU9Td09Do1/LfFshi6u3TqGZ5n
	 sfScsWw3Q8Y3LqnMghHZTLD5Yz5lM5fhh+VgmBNHLhJkU7t7JzkgswKZ4l5XySEIPS
	 3yoaEePrioG60FgT6AzbEx1gFaZQXCD/KE9zMeTBJOKjAoOhAwaRWQbjDL8gw0icE+
	 Sj4+/P8DrL7bZ+Iq53PzB5gGMM40ij/exGFFcasTlKtLZBSraRgFMd3LneGaAoJWXY
	 aG5RG1xSi6rSQ==
Date: Sun, 17 May 2026 09:33:42 +0100
From: Will Deacon <will@kernel.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 3/6] arm64: Initialise the PMU last
Message-ID: <agl9ZkPWVKSl2tsN@willie-the-truck>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-4-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323150221.49256-4-alexandru.elisei@arm.com>

On Mon, Mar 23, 2026 at 03:02:18PM +0000, Alexandru Elisei wrote:
> PMU initialisation is done in:
> 
> setup_fdt()
>   vcpu->generate_fdt_nodes()
>     pmu__generate_fdt_nodes()
> 
> The PMU ioctl KVM_ARM_VCPU_PMU_V3_INIT requires that the GIC has been
> initialised, which is done in gic__init_gic().
> 
> gic__init_gic() and setup_fdt() are part of the same initialisation list.
> The relative order on the list depends on the order of compilation: gic.c
> is compiled after fdt.c and this places gic__init_gic() first on the
> initialisation list.
> 
> If the compilation order changes and gic.c is compiled *before* fdt.c,
> gic__init_gic() will be executed *after* setup_fdt() and PMU initialisation
> will fail with an error message:
> 
> PMU KVM_SET_DEVICE_ATTR: No such device
> 
> This is fragile and hard to debug. Improve the situation by creating a new
> init list, last_init(), execute it after late_init(), and move PMU
> initialisation on that list.

Hmm, not a big fan of that. There's always _somebody_ who wants to be
later/earlier than everybody else (see the CCA probing converstion!).

If the PMU genuinely depends on the GIC, then perhaps we should just
call the PMU init function from the GIC init function, along with a
comment to explain the dependency? This is all arm64 code so I think
that's fine.

Will
