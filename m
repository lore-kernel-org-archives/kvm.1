Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0883471414
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932411; cv=none; b=JTM+LmttgKp1XJYRhuRsTTs9PNMDwfetXOaoIhBZIUWDt+1/BZm9dL6DcH6ccoM7GyqOur2HHDDan0c94NcSjKn0kWaJxncvDhWjDKdJFj4bhPrC10u6WWyI77RAGKORHgpUeVByUkxHEzgT05jK6FEuLgyMVTqL1UBz++SNveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932411; c=relaxed/simple;
	bh=vD1aXSCXwLybyQlgarl6UnUZi4NTNokCO813Ap9fX7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JsNrfZQeaUVs+FPrMUKDKYYtR6DHTFhLhuVVmMMWZ1+mg6QiuPq+pTrU4qyHS6nS3I8XTKX+DdTENkUr20fuksWH7pmq/jvpbHktboa24MsPjAhfRKc86VZgko4vQ/yFHLCUyamSwBKQ3CXQQE6tbIui9TYgCJDnVx5ujzZ+w/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urv8oCpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urv8oCpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5D31F00899;
	Fri,  2 Oct 2026 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932410;
	bh=AgkJjlqNuDMe84OOTCM0B+ciSlK8qprxC5O4/eE+gUc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Urv8oCpbqnKSwe3Uc0FM0q1+aWS8QNjlgrhJ1CXRzXVdcd7ybG1/Kmb72/PrFdKGP
	 3OTIFqVoEOg49i6SG4z+C1vgOSxUratdBuSDQKFcIZeh3FvTqB9TUbpKfxmu7aBXB6
	 qcQ+ww9gaLtiz0tR49wok6M3fCClht5YbsYP+zCbhtLWUiac0i7yTjv19Luw4djUmA
	 Ksuw1nGY5+eMoNt3bs/EIpJcbeTkcbxzZUihL2BIKH7QCoIakfduQuXIv8EU5nJvJ2
	 IqBrIbrXiAZw89FcY9ToyIqVn2udXJKqit5pF4YBwspH1SRzG05arIsVuxBrm+6G97
	 95h2JfuND2qOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 07/23] KVM: selftests: Add TDX boot code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lisa Wang" <wyihan@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001-tdx-selftests-v15-7-7c62a5d8a992@google.com>
References: <20261001-tdx-selftests-v15-0-7c62a5d8a992@google.com>
 <20261001-tdx-selftests-v15-7-7c62a5d8a992@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:29 +0000
Message-Id: <20261002091330.4B5D31F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kvm: selftests: missing wrmsr to set EFER.LME in TDX boot code
- [Medium] kvm: selftests: incorrect register used for TDX vCPU index
--

commit 0050b7c1fa5f321a19fe7395b74ac22ea9e52f99
Author: Erdem Aktas <erdemaktas@google.com>

KVM: selftests: Add TDX boot code

This commit adds assembly code to boot a TDX test VM. It loads relevant boot
parameters from memory into registers before jumping to the guest code.

> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S b/tools/te=
sting/selftests/kvm/lib/x86/tdx/td_boot.S
> new file mode 100644
> index 0000000000000..726ec51e040e8
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/td_boot.S
> @@ -0,0 +1,65 @@

[ ... ]

> +	/*
> +	 * Find the address of struct td_per_vcpu_parameters for this
> +	 * vCPU based on esi (TDX spec: initialized with vCPU id). Put
> +	 * struct address into eax for indirect addressing.
> +	 */
> +	movl $SIZEOF_TD_PER_VCPU_PARAMETERS, %eax
> +	mul %esi

[Severity: Medium]
Is it correct to read the vCPU index from %esi in td_boot here?

According to the TDX architecture specification (via TDH.VP.INIT), the vCPU
index is initialized in the %ecx register, while %esi is initialized to 0.

If %esi is used, will all vCPUs evaluate to index 0, causing them to
incorrectly share the same stack and guest code pointer? This seems like it
could corrupt the SMP stack and fail multi-vCPU tests.

[ ... ]

> +	/*
> +	 * Set up control registers (x86 does not support moving memory
> +	 * directly to a control register).
> +	 */
> +	movl TD_BOOT_PARAMETERS_CR4(%ebx), %edi
> +	movl %edi, %cr4
> +	movl TD_BOOT_PARAMETERS_CR3(%ebx), %edi
> +	movl %edi, %cr3
> +	movl TD_BOOT_PARAMETERS_CR0(%ebx), %edi
> +	movl %edi, %cr0
> +
> +	/* Switching to 64bit mode after ljmp and then jump to guest code */
> +	ljmp $(KERNEL_CS),$1f

[Severity: Medium]
Does td_boot miss a wrmsr to set EFER.LME before enabling paging?

The TDX VM guest boot code enables paging (CR0.PG) and physical address
extensions (CR4.PAE) here, but appears to omit writing the EFER MSR to set
the Long Mode Enable (LME) bit.

According to the x86 architecture, enabling paging without setting EFER.LME
puts the processor into 32-bit PAE paging mode instead of 64-bit IA-32e
mode.

Will the subsequent far jump attempt to load a 64-bit code segment
(KERNEL_CS has L=3D1), causing a #GP fault since it is invalid in 32-bit mo=
de?
It seems this might crash the guest VM unconditionally on every boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-tdx-selfte=
sts-v15-0-7c62a5d8a992@google.com?part=3D7
