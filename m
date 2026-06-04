Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C03449EA9
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580219; cv=none; b=KnzBOMHQHyJBwme/hicUJQpaX4QbHCh/jY6LHY5ucvhl1R2/FfpJU57gMBbKgdAp5CYkOpnOslz4FjBKlbRmin/MoC/H7KBlHPQ44F718jLSXXneddCn63Lgr7S4SPz4J7YyocPPv+GhZSBVinUtr8JPWfSc4dLti1WLsOtGp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580219; c=relaxed/simple;
	bh=qIGW4sFxRqrKN/Eou8ixehlbh5aNZt/zUnw0JCKlIWY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rkXNIf+s3Dfd9Rtw6lZGk8v8G8uCFcaW70PMsxhsMcrGCIuK2J/zelyhi/DLERPF+YFx4TdDDOtLsV+kzS9mZscIhXdL4fGAbtvw2GdWoge9jh6uHa+pbdHTx8jZA/IKQttRUIdyemZVLoN2GuiKLB6DTeU+sEp0hmByjnR1Gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1NP83Pb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1NP83Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFD61F00893;
	Thu,  4 Jun 2026 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780580218;
	bh=HUQzEoO8HsNZDS0hVPmMXB5Ra2qbCpT++0hFxJ+vtkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1NP83PbFupSrpeqbrjyca9GdC+BK4SvgEWJViifCErFQRRvWBGqUUTgqQLdyDJX3
	 bA1ZURaBuk/er8qYtnOzM+UtdiJZ8WfHdwApC1bOqGut4hmCF1jOq3fDc1O13E+yS/
	 S9hwhDnSNcs7krXz0gqAwkaYGOKPkoymsEV1lK7Tq1R2kJCbj8yufkKKYgd3/ociQ6
	 P8BcyBIk/h7drudHohrzBAO6I4dzwCzkbi267ks8A8u4NgJNJoEzBd7MMbEB5dL1oo
	 QbM9RSPyiCx8PwCFN3ANo3epGBTwGtiPdEmdWWRx9IQDFWfThgwYLrs3cnu9gzRI3H
	 C4j6BuAjFvQCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] riscv: kexec: Route normal kexec through the
 trampoline page table
Reply-To: sashiko-reviews@lists.linux.dev
To: fangyu.yu@linux.alibaba.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604132418.15725-10-fangyu.yu@linux.alibaba.com>
References: <20260604132418.15725-10-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:36:57 +0000
Message-Id: <20260604133658.0AFD61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch removes the `set_memory_x()` call in `machine_kexec_pr=
epare()` but fails to remove the corresponding `set_memory_nx()` call in `m=
achine_kexec_cleanup()`, leading to an unbalanced page protection modificat=
ion.
--

commit 1f36a552a8c04150c5598c4bdd508c89d475252b
Author: Fangyu Yu <fangyu.yu@linux.alibaba.com>

riscv: kexec: Route normal kexec through the trampoline page table

This commit routes normal kexec through a trampoline wrapper, which drops
SATP with PC already on a PA. As a result, the relocation code now runs
entirely with the MMU off.

> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machin=
e_kexec.c
> index 71688c63af65f..82fcb84a03ec5 100644
> --- a/arch/riscv/kernel/machine_kexec.c
> +++ b/arch/riscv/kernel/machine_kexec.c
> @@ -164,9 +164,6 @@ machine_kexec_prepare(struct kimage *image)
>  		memcpy(control_code_buffer, riscv_kexec_relocate,
>  			riscv_kexec_relocate_size);
> =20
> -		/* Mark the control page executable */
> -		set_memory_x((unsigned long) control_code_buffer, 1);
> -

[Severity: Medium]
By removing this set_memory_x() call here, does machine_kexec_cleanup()
now have an unbalanced set_memory_nx() call?

Looking at machine_kexec_cleanup() in arch/riscv/kernel/machine_kexec.c:

void
machine_kexec_cleanup(struct kimage *image)
{
	...
	control_code_buffer =3D page_address(image->control_code_page);
	set_memory_nx((unsigned long)control_code_buffer, 1);
}

Since __set_memory() unconditionally splits the linear mapping on RISC-V,
will leaving this set_memory_nx() call permanently shatter direct map huge
pages down to 4KB PTEs every time a non-crash kexec image is unloaded or
fails to load?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132418.1572=
5-1-fangyu.yu@linux.alibaba.com?part=3D9
