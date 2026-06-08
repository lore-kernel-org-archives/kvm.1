Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC13A4F26
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955086; cv=none; b=DGwzCHYNlkkCZz/Ea9pA/BJk1CqpEqSkK02NVS7GXLTIsalM1t6axb9GSkGrvKc1or1XA0zedpg1gMcS80UKb7p90qi8uaK+SvnGgK9mBDGNRzCdVzzsYSU5iynkNkLe4+6T/Tiu+fCYklWwdvde6CmhBX6WhHtgbPp6h86lqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955086; c=relaxed/simple;
	bh=C0fMalMZ6kI7XNHdfEQYV4Fy1o/vFTRvZVHgdPNKCsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GC2SgXEB23zktKG0rDtfDtCxaoTDNrn2f7hVVhx17wAFPWMkuYJZ1+qwhodmg0IgoJEz2zKkvAxp8k32XJfXIcs3uPCoXzs0c8NXmQTtlqBeePUO5XL/4J4rCS//h657AvNOOhO8zhatsVh+pJknyOf2DWceRT7XfM0nSvBTS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bo4Y6Mll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo4Y6Mll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159E51F00893;
	Mon,  8 Jun 2026 21:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780955085;
	bh=LpgBGZmD1iuMWtKI4Qc+JSpfMqM1cWIxjEz4zuZdXl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bo4Y6MllDeybNHD3uPSx0NjwP/pNUEVRnJoqmp6EPuvfWIAPHxuCKqrSn5xrZR3ko
	 Cp52GjIh0AEQqr23cjA5SChXsYlAumH/ALoaDhxoaW8P7xdt9KMSPaL7aFhW5bPEx+
	 Miiz4czyjSAlZUHRnSRYFIwqLwJgH9MXIrhXfva9T0qowaqjqKPApK4YBGUpfTtHZo
	 2DNlzFfowub/Lmqu+l3S3s5BZBBdJSwItQr/Xbz+j629UsZ3mkYvdYTBmv0nCj1pWb
	 YQmOvkyk2smx5ExchahJ5/j98OOANqU+B70Qn74prCl5Nm2BfUzEm92ynPPcw5DY4v
	 vxxv766EIPY2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 50/60] kvm: x86: Make
 KVM_REQ_UPDATE_PROTECTED_GUEST_STATE per plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-51-joro@8bytes.org>
References: <20260608144252.351443-51-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 21:44:44 +0000
Message-Id: <20260608214445.159E51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macro KVM_REQUEST_PER_PLANE is used but never defined, causing =
a build failure.
--

commit 6b874952b1263ad0ba1bd6a4606b9ddba2194117
Author: Joerg Roedel <joerg.roedel@amd.com>

The VMSAs are per plane, so this request must be too.

This commit modifies the x86 KVM host definitions to add a new flag to the
protected guest state update request.

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 0955097aca9c..0327b77e56b7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -129,7 +129,7 @@
>  #define KVM_REQ_HV_TLB_FLUSH \
>  	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
> -	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT)
> +	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT | KVM_REQUEST_PER_PLANE)

[Severity: Low]
Is KVM_REQUEST_PER_PLANE defined anywhere? I could not find a definition for
this macro in the kernel codebase or in this patch. Will this result in an
undeclared identifier error during compilation?

>  #define CR0_RESERVED_BITS                                               \
>  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D50
