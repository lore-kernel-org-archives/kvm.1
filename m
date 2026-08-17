Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056393101A7
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 07:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952736; cv=none; b=m3qcqlwXNPVi0Ya0fKqsgNnqvGnh6RnZuVMQd+bRe+FFLcWTf5l1sPbLFiydtvAF9yeAZbKC1wPp6ZX0fBBTRfUEOp3Jeo+mFXpuUfoS/GZVN1K0yX62ApolKmJAHduD8LPRQXs1npfRiqE0i479qsCiC6Ce8YtXAT/awFghrFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952736; c=relaxed/simple;
	bh=vjkKgnFiBNP2HGGd9J/CZNGvHoUHvQVVs6i6VBm3+0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WzGbq1WIyeF4j2a1itQmU6RWE/+/zQpL6tBFzCUBF24WkhmCzuBCnx96xPHjVNxamMEH9PA32cXoY02bdmM/ZTy0I738kGCwd9SbM1rY7YOFEM/Hg3hW2vFds1F/DnKEUX/QAZwroQ+VS12N+UlHvMKm65wX1jTtOBUjzX2CcFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVYgNg6S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVYgNg6S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E32F1F000E9;
	Mon, 17 Aug 2026 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786952734;
	bh=rytCuCKDTSR4L6172u9Cp5lkRC+NIp0v2Ro4CvW5UgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JVYgNg6SBJCz8q9XbFbGBwReTC70CSzTCHaMsksM9kmdnQky1XYmGKD7E1O6rbyB9
	 O+efVYj1jF3l07sZzuvUTF+kSIsDGa5Xm6Oe4+fvqe1LKVItrmLrOyNL0zEXAfzSj8
	 5rDxNFA3UvcSMpbC7bKSAxAbjgZPbi3KOvz9H7741urnEHdAuE3Q1ykWCAPg/hIPkX
	 5PwY1MjeCsW8mwIjYL2NqRpWt7szqVX01htziE/uoTwd8obzuREiy4ydlnfL29SudZ
	 ZXqZRgTVJUPMTo6LuGsqtZcDFZ/Rs2+U8VSTsZ543ag7JDwViawA37NpuyCcGhhtwE
	 u8mj9R33bwfLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: RISC-V: Clear HSTATUS.HU on hypervisor
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yong-Xuan Wang" <yongxuan.wang@sifive.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260817-hstatus_hu-v1-1-28c53cdfb408@sifive.com>
References: <20260817-hstatus_hu-v1-1-28c53cdfb408@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 07:45:34 +0000
Message-Id: <20260817074534.7E32F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The mitigation for HSTATUS.HU is placed in KVM initialization,=
 leaving systems vulnerable if KVM is not loaded.
--

--- Patch [1]: [PATCH] KVM: RISC-V: Clear HSTATUS.HU on hypervisor initiali=
zation ---
commit 57c0e5888211429befb42a79f59ff40cc9adf07a
Author: Yong-Xuan Wang <yongxuan.wang@sifive.com>

KVM: RISC-V: Clear HSTATUS.HU on hypervisor initialization

This commit clears the HSTATUS.HU bit during KVM initialization. This
prevents U-mode code from executing hypervisor instructions (HLV/HLVX/HSV)
to access memory, as the RISC-V specification does not mandate a reset
value for this bit.

> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 85e772588fad6..e80a99e93d569 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -47,6 +47,9 @@ static void kvm_riscv_csr_init(void)
>  	csr_write(CSR_HCOUNTEREN, 0x02);
> =20
>  	csr_write(CSR_HVIP, 0);
> +
> +	/* clear HSTATUS.HU */
> +	csr_clear(CSR_HSTATUS, HSTATUS_HU);

[Severity: Critical]
This is a pre-existing issue, but does placing this mitigation in
kvm_riscv_csr_init() leave the host vulnerable if the KVM module is never
loaded?

If the hardware or firmware leaves HSTATUS.HU=3D1 after reset, and KVM is
not initialized, could an unprivileged user-space (U-mode) process execute
hypervisor memory-management instructions (HLV/HSV)?

Since guest translation registers might remain in an uninitialized (Bare)
state, this might allow direct read/write access to host physical memory.
Should HSTATUS.HU be sanitized unconditionally during early core
architecture setup (e.g., in arch/riscv/kernel/setup.c) instead of only
when KVM is active?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-hstatus_hu=
-v1-1-28c53cdfb408@sifive.com?part=3D1
