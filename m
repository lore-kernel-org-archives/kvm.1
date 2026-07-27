Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0756D42A82
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138010; cv=none; b=UgUQs24el9oeKZPKYMkShYXv2ULslLA8bE8iki5WzPsEeU8/ZsQ5a7kwXheseCw8AmZRao+vY1DHTuFMeeQmPwMa3KejmdsFPeO9iw713t9noNbfZTlk/wr/H8orl9xmlnhlOy3Rg5xji66KH3xsoRekRkY5bOrL+Jjnb1Zce90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138010; c=relaxed/simple;
	bh=Tm/bbOZGtoLIagqZanpert2YMnPzHOPLN+pPdLc5GNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHdB0531sEvnjxu119mavvx9W5+fNDBqd1Nz7dvmLRb3mX85IrtY1bvd88TZOLvn2f27Ly5ttOPi3XWrF/uElJIxz1xmv3htWCsCC1EC2Q7FxQZde6tzHmVtzEIO6ZcxMYrso6i9+r8eP3R0UL6ASxx0ynAClwgTKYuwnLPXLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIA+lLZ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIA+lLZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953AA1F00A3D;
	Mon, 27 Jul 2026 07:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138008;
	bh=342lR/7D86KBbD+fSqXaBsHtD1LOKmeTGwGNOty294E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIA+lLZ0LQT2b4PDAdL3Ptxht0lc3igCIBAxRZMJ0XcbfX/q/Clzq20aKEJ3Fxll6
	 YaEFpHDCjomPypnlP4iLFxGbrji6l5V2mssF6CwSGcxLgHyMuYKVZSDwrTs6Bj6kwa
	 Ow4XIGRz3Ka70Vy+4A/9QDgvAKWxe4AAXbMKKSej4jUe1A3hju2PCPcF1a3cD5Dfy+
	 B21Xvi/mTDT91wU5ia1CG7QOFAOGJRaQ1ssGI7g70XtzQOBXIgY+D1FPZvgpI/ixmR
	 fWgv4elxbf92dzERZzOaJvf3IxeD2hPSwo5dv3+/YI9Lm6fsPidLY1zh3G01Mb8IRO
	 TdykCpxmsnFyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] LoongArch: KVM: Enable separate vmid feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727072109.2151675-7-maobibo@loongson.cn>
References: <20260727072109.2151675-1-maobibo@loongson.cn>
 <20260727072109.2151675-7-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 07:40:08 +0000
Message-Id: <20260727074008.953AA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] CSR_GTLBC_USEVMID is not cleared when virtualization is disabled=
, leaving the CPU in an inconsistent state and leaking hypervisor state to =
the underlying hardware.
--

--- Patch [6]: [PATCH 6/6] LoongArch: KVM: Enable separate vmid feature ---
commit 255d457e2558ae0a9e092e8d465e179d08390542
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Enable separate vmid feature

With CSR GTLBC shortname for Guest TLB Control Register, separate vmid
feature will be enabled if bit 14 CSR_GTLBC_USEVMID is set. Enable
this feature if cpu_has_guestid is true when LVZ is enabled and the LVZ
version is 2.

> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 86b1af823e2b4..43f5b40786f24 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -365,7 +365,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>  	write_csr_gcfg(0);
>  	write_csr_gstat(0);
>  	write_csr_gintc(0);
> -	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
> +	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI | CSR_GTLBC_USEVMID);

[Severity: Medium]
Since this clears the newly added CSR_GTLBC_USEVMID bit during initializati=
on,
should it also be cleared in kvm_arch_disable_virtualization_cpu() when
hardware virtualization is disabled?

Currently, kvm_arch_disable_virtualization_cpu() only clears the prior bits:

arch/loongarch/kvm/main.c:kvm_arch_disable_virtualization_cpu() {
	write_csr_gcfg(0);
	write_csr_gstat(0);
	write_csr_gintc(0);
	clear_csr_gtlbc(CSR_GTLBC_USETGID | CSR_GTLBC_TOTI);
	...
}

Does missing this bit during teardown leave the CPU in an inconsistent state
by retaining KVM-specific control bits in the Guest TLB Control register?

This might cause issues during CPU offline/online cycles, kexec into a
different kernel, or when another hypervisor initializes the CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727072109.2151=
675-1-maobibo@loongson.cn?part=3D6
