Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CD3815E4
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098036; cv=none; b=uSViHT5sXHwKTxSzAk771hbtLPcztLjq/Bx1jsqlvkB/kTXJEbhoTcQF4EXws3x3mHQ7fTHvtxf3bbcXf7Zr0tXe1BPc6PK6KIow/586WiEfrbH5/BqvbyCXG2/LU3VeprMZDDI5mpB4xsMJjca0W83OqJUaezCVaPgH56y+pNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098036; c=relaxed/simple;
	bh=GfvMl6WGemQn8t00BgiIEeQLOVOzEyXeVlrE6+qyWTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIDyRNF6qwjwvULsxBtYCKVgHKHVha5SkS2Clgt3fXRo/MKu2olNlIrLokgN2Sn4AVETaKqe/c35ke+VtUThj+KxtJxDZmqWvRa/dXJo7ODObzfOUBIavHD+kknpu9iTu/o7Ax1ppPaLPYXm7dmi4OnsRu+1VEz+8fPSDZt20vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fUcMv31T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fUcMv31T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8AB32328;
	Mon, 18 May 2026 02:53:48 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65C63F632;
	Mon, 18 May 2026 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779098034; bh=GfvMl6WGemQn8t00BgiIEeQLOVOzEyXeVlrE6+qyWTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUcMv31TD31fT5BjAU//JcJlRgzq0ZI5mJefEZt4AGTuCCZdLmLddTTsGBriC6ITv
	 /RO+Kdi2HD9tqtITz5m1ZZ9dtdth5fn1XKv+RCht5zYBtuSfwmHcdqnF2ijH9/qRkV
	 fG/NfnKLoJ311NnY3WwrpX1JykMQX4FtjiP4lnEA=
Date: Mon, 18 May 2026 10:53:48 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, maz@kernel.org, oupton@kernel.org,
	jean-philippe@linaro.org, andre.przywara@arm.com,
	suzuki.poulose@arm.com, kvm@vger.kernel.org
Subject: Re: [PATCH kvmtool 3/6] arm64: Initialise the PMU last
Message-ID: <agrhrBjythDfc9qY@raptor>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
 <20260323150221.49256-4-alexandru.elisei@arm.com>
 <agl9ZkPWVKSl2tsN@willie-the-truck>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agl9ZkPWVKSl2tsN@willie-the-truck>

Hi Will,

On Sun, May 17, 2026 at 09:33:42AM +0100, Will Deacon wrote:
> On Mon, Mar 23, 2026 at 03:02:18PM +0000, Alexandru Elisei wrote:
> > PMU initialisation is done in:
> > 
> > setup_fdt()
> >   vcpu->generate_fdt_nodes()
> >     pmu__generate_fdt_nodes()
> > 
> > The PMU ioctl KVM_ARM_VCPU_PMU_V3_INIT requires that the GIC has been
> > initialised, which is done in gic__init_gic().
> > 
> > gic__init_gic() and setup_fdt() are part of the same initialisation list.
> > The relative order on the list depends on the order of compilation: gic.c
> > is compiled after fdt.c and this places gic__init_gic() first on the
> > initialisation list.
> > 
> > If the compilation order changes and gic.c is compiled *before* fdt.c,
> > gic__init_gic() will be executed *after* setup_fdt() and PMU initialisation
> > will fail with an error message:
> > 
> > PMU KVM_SET_DEVICE_ATTR: No such device
> > 
> > This is fragile and hard to debug. Improve the situation by creating a new
> > init list, last_init(), execute it after late_init(), and move PMU
> > initialisation on that list.
> 
> Hmm, not a big fan of that. There's always _somebody_ who wants to be
> later/earlier than everybody else (see the CCA probing converstion!).

Sure.

> 
> If the PMU genuinely depends on the GIC, then perhaps we should just
> call the PMU init function from the GIC init function, along with a
> comment to explain the dependency? This is all arm64 code so I think
> that's fine.

Sounds good to me.

Thanks,
Alex
