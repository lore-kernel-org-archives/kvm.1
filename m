Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778088;
	b=Mb72wjva9kBTb1Q/5xPkfue6yqOHKnnhcGLiZlWSqIsR5gSMAqovAdddg8RYDhZcU2UD
	 1s5EGRSyoIP1TKfSJA7AcWNdF9J9k4+y2SNV6RaGwiFf24IzlkAKjiDpUtEh1zRTNy/bS
	 tk6B/mALwdAx0gcFoBxfSrXgd2DrYeqHg+K5KOCvZBhA7kAILqGauUiO8pefSzLqQjNUs
	 qVWF+mEnA4/MHEm8eB7Yn4+elLs8bMqI41dodzN6xTkvlezoF1xj9mNlkgE3uPEhWZjtb
	 tq2+EBG//mprfhEPMPj/VcNmuadhwrat9OnpGtDXkE5X5ZDHGZ4bQ6CeFB88q2AJijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778088;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UgE8E0wwyWrSNV9lEIMlWrzgZhXkwN/rj4cwFpTc9Jg=;
	b=AtBPPuGjug/aCgA4zPm9JKX2w+sCUy9WzCF6XmmGpkXkyMzxekNQ9bFnRTRQTiFXhIst
	 ebi1v85xU47fjts6k2VGlAANEF6fxyqURdqGDMBSFLvXeqs2Q0VMZK6Pr8K6Igl6ejsx0
	 SN6z4trdAA6IWkJfIh6Uipa3lBFU2w9kUZTiaJE99C4PXxxVlJhG9+TbyzXVTimXqwMG5
	 1K1dxUtWMNEhHFz99VhC0urigol3FzENXXSS1mQhVOpvVsVpA8Bg5RmcFgi0Bo6TREtFW
	 5PH+mxOnusdws8Bw6M/rP6KcBRDGVi8qVd9gwmafL50KM88yb7jpH+jF5r8uUPLIlGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kX9q8ozX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C85606A31F
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 11:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C85606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kX9q8ozX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5EB41756;
	Fri, 27 Nov 2026 03:14:44 -0800 (PST)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12CA13F632;
	Fri, 27 Nov 2026 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795778087; bh=gF7DAcDjFmtqtqB2ABYlm/QeU8ah6fV9j+HrkvyVNe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX9q8ozXHmqTw2YWHALVtX0jNvoOkAcfZxOzgTD3hihmxTJyL2ACsEBXlQuqnVF74
	 Qq0wBivx+X5PzqPtdcbUWhrNZwKwgQxuvNASCUyOajnrwTAiANn8J0rI5ceDgeypQx
	 nonjrFdu7X1WP0BfCB1cTaF3D0pQeTkgBGasHcGA=
Date: Fri, 27 Nov 2026 11:14:41 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Will Deacon <will@kernel.org>
Cc: julien.thierry.kdev@gmail.com, kvm@vger.kernel.org, maz@kernel.org,
	oupton@kernel.org, fuad.tabba@linux.dev, joey.gouly@arm.com,
	seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	catalin.marinas@arm.com, mark.rutland@arm.com,
	kernel-team@android.com
Subject: Re: [PATCH kvmtool 0/7] Fix --vcpu-affinity
Message-ID: <awlmIXJ9o6ssyBe4@raptor>
References: <20260917154932.193943-1-alexandru.elisei@arm.com>
 <179570874285.2888674.1910692252028588031.b4-ty@kernel.org>
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
In-Reply-To: <179570874285.2888674.1910692252028588031.b4-ty@kernel.org>

Hi Will,

On Thu, Nov 26, 2026 at 05:14:29PM +0000, Will Deacon wrote:
> On Thu, 17 Sep 2026 16:49:25 +0100, Alexandru Elisei wrote:
> > This is my attempt at fixing --vcpu-affinity, which I introduced. Patches #1-#4
> > are straightforward fixes, and they don't modify the current (broken) behaviour
> > in any way. Patch #5 fixes is most of the fix: with it, the VCPU threads run on
> > the physical CPUs passed to --vcpu-affinity, and most of the kvmtool threads,
> > except the virtio threads, use the main thread affinity.
> > 
> > The virtio threads are special because they are spawned from the VCPU threads,
> > and they inherit the VCPU thread affinity. Note that there might be other cases
> > where this happens.
> > 
> > [...]
> 
> Applied first five to kvmtool (master), thanks!

Thanks!

I'll just drop the last two RFC patches, there doesn't seem to be much
interest.

Alex

> 
> [1/7] arm64: Pass the number of elements as the first argument to calloc()
>       https://git.kernel.org/will/kvmtool/c/5b707c29743a
> [2/7] arm64: Consistently treat vcpu_affinity_cpuset as dynamically allocated
>       https://git.kernel.org/will/kvmtool/c/c1c630e7d331
> [3/7] arm64: Free the temporary cpumask in vcpu_affinity_parser()
>       https://git.kernel.org/will/kvmtool/c/e6fbd872f1b1
> [4/7] arm64/pmu: Consider kvmtool's affinity when searching for a PMU
>       https://git.kernel.org/will/kvmtool/c/8c3912c087d1
> [5/7] Correctly apply --vcpu-affinity to the VCPU threads
>       https://git.kernel.org/will/kvmtool/c/4c90ccf4c593
> 
> Cheers,
> -- 
> Will
> 
> https://fixes.arm64.dev
> https://next.arm64.dev
> https://will.arm64.dev
