Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CF72FE060
	for <kvm@vger.kernel.org>; Sun, 13 Sep 2026 07:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789284059; cv=none; b=sIjGCYQhmKvPIzGVDn8Zx8QpcDLa9rhcxB6XYCBznDUFqNCMMiC9YNa5mi3cFJRxvdopB/qq/nPD7C7sRNK3n+RHtCT/FXSEGr5gvIhbV5oj8dzOB2l1BCfOn6Ucllg3h6VBMe/wOFM4jT7Pg5MdHk1yrkrQh2iewIo3TOCGhvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789284059; c=relaxed/simple;
	bh=C5BLbR2L9dAlZHiMTgrTAoXsuvc3B9/rnTzxhX98l+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6G4fB+htJHJUwU7u1jz2wr3m9pRvHRjK8e6iBfe+GJdXgAvUJTWd9T1shCuHdPX+ojZqTZB6PI1mFSU3x0VLpqPI7k4Xyn9X5cytxct79aBh1SNsJZSsWrdPo4DpB2UtQZ/TctjFRmmsH3f3Yhg/b+9W0L7zqkry/6dWUM4qCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNvM4P29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNvM4P29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C0B1F000FF;
	Sun, 13 Sep 2026 07:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789284057;
	bh=OC9VujQgQtiVuSKudAr/ngqaQwILc1439vvF00HOM+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNvM4P29dDSXMM0gJupO3mnIiqP/WTQ6d0k4t+cdPpkGzJvM4E9ywy4WTraWTTyRs
	 KZC+7k5xXpYdwakBv7aUEoIwmwiCzIdfQ0Tj3ZfKHL+AyByWCJBPgPjiVxjRLyvL6x
	 9AL/piyXfNC60i3liaQ80JKOaB0pYvjCLAXgVCFqxSVB/ref9UvH+SCciuLdv6Tzo+
	 17QbEFpExDb4kCJBF74DAnToTY8uCkeKL7rNmv6Qk6yBEYUVKGO8Fcucl35iR3o3T0
	 T66KgAB97XMUK3siq/5tlFe+AQwxdcMJUH4wfsNxlYqfx4hgA8Q5vKkv4wnDh0cR1z
	 6xxAExJKDAmVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] RISC-V: KVM: add tracepoint for guest page
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260913070352.3626956-2-wang.yechao255@zte.com.cn>
References: <20260913070352.3626956-1-wang.yechao255@zte.com.cn>
 <20260913070352.3626956-2-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 07:20:57 +0000
Message-Id: <20260913072057.C3C0B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `kvm_page_fault` tracepoint misses MMIO accesses=
 and instruction access faults because it is placed after the early-return =
paths in `gstage_page_fault()`.
--

commit 9a1dfc5717473462915b50774722a5444137d7bd
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: add tracepoint for guest page faults

This commit adds the kvm_page_fault event tracepoint to count the number
of KVM guest page faults on RISC-V.

> diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
> index 88e0c369b3544..8f44e27563f85 100644
> --- a/arch/riscv/kvm/vcpu_exit.c
> +++ b/arch/riscv/kvm/vcpu_exit.c
> @@ -64,6 +64,8 @@ static int gstage_page_fault(struct kvm_vcpu *vcpu, str=
uct kvm_run *run,
>  		};
>  	}
> =20
> +	trace_kvm_page_fault(vcpu, fault_addr, trap->scause);

[Severity: Medium]
Does this placement miss MMIO accesses and instruction access faults?

If a guest page fault resolves to an MMIO region or an unmapped instruction
fetch, the early return paths in gstage_page_fault() will handle the fault
and return before reaching this tracepoint.

For example, when an error HVA is encountered:

	if (kvm_is_error_hva(hva) || ...) {
		switch (trap->scause) {
		case EXC_LOAD_GUEST_PAGE_FAULT:
			return kvm_riscv_vcpu_mmio_load(...);
		...
		};
	}

	trace_kvm_page_fault(vcpu, fault_addr, trap->scause);

Could this cause incorrect statistics for users monitoring KVM guest page
faults, since it skips all page faults that fall into those early returns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913070352.3626=
956-1-wang.yechao255@zte.com.cn?part=3D1
