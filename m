Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62CF3B27E7
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786357446; cv=none; b=iFKiv0MHHrZtg6+/tu6DY6wJ+C4eJCVR+xCQJ7+0pPaT78yFHU264TlEQj+GIqdDFeJ3YacYc7slv0hTZX+xWXY9agRnd+LWm+m+Q3v+betTTGty2hO1WQr07lsIf207u7xelFmlz41ii85VI9K5dbOrnCdYmEj9kNIAUnGytSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786357446; c=relaxed/simple;
	bh=QYOh2F6nGjwqxKIBc9UN/BPWGu90bWOmHzCT3Z/XzJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IrAqgNwHlezYscBO+eYGVbHd6cPfLm9ln+KgnNky85NFFXExKLZpgxHt4ctgPA9A5jp9oAeaP6j6wk1QvuZLuo7xZsnBs+JSPxXrhJLdDMSh8JPpnF62EgOQqUeeD5gVFZTkPzdVntfQm/BNNA5NLEOMg+SczbEtWsCv08xdyow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENCWd3PX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENCWd3PX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF471F000E9;
	Mon, 10 Aug 2026 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786357444;
	bh=doY4eFMYgVgauuMUX2QC15I0PPKB+XaBdccWH+XIA6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENCWd3PXlF/5Yex3sZ1eDQCV8Up+RkzCxxIyqw3VUmNX3ZO4cm03FXgHpWhTHGp/m
	 T65EmwY0CZHGlNoRfDFJvEgnG9e729LMJ1t2ap+Ftai0IrCzDWwPLxly9as2zicYwA
	 mqe12nTEnY1FO9+gUmqi5RR6hGuKCj7Oleugjiifkw04p5S59PAl9yNrxlbtfUtJ4A
	 lqlzLKCdzZ2O8HWzxB7IQm7qtXopGciVT2cMDxJJMq6WmG9p+fAZ4FbTH887IDH3NJ
	 NqppmhWEXT+uSxDp6SMLp41i8cPwlCvxa1lE0sbZGuvIFbMMnm3zp32G025dN/3xOB
	 NzK614ofI6l5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] x86/cpufeatures: Add PerfCtrVirt feature bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sandipan Das" <sandipan.das@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <cdea00ec61978f097d15202a2d5fe4f8fc9c4948.1786345201.git.sandipan.das@amd.com>
References: <cover.1786345201.git.sandipan.das@amd.com>
 <cdea00ec61978f097d15202a2d5fe4f8fc9c4948.1786345201.git.sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:24:03 +0000
Message-Id: <20260810102404.4BF471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch modifies `arch/x86/include/asm/cpufeatures.h` but fails t=
o update its synchronized copy in `tools/arch/x86/include/asm/cpufeatures.h=
`.
--

--- Patch [4]: [PATCH 4/8] x86/cpufeatures: Add PerfCtrVirt feature bit ---
commit d0af0746d5778097e8c3fa7f7763e5d0b909732c
Author: Sandipan Das <sandipan.das@amd.com>

x86/cpufeatures: Add PerfCtrVirt feature bit

This commit defines a feature flag for bit 8 of CPUID leaf 0x8000000A EDX
which indicates support for PMC virtualization. Hypervisors can use this
feature to offload the guest PMU context switch to hardware. This enables
hardware-switched mediated PMU in KVM.

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cp=
ufeatures.h
> index 1b4a48bff18f7..d6281870efe02 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -374,6 +374,7 @@
>  #define X86_FEATURE_VMCBCLEAN		(15*32+ 5) /* "vmcb_clean" VMCB clean bit=
s support */
>  #define X86_FEATURE_FLUSHBYASID		(15*32+ 6) /* "flushbyasid" Flush-by-AS=
ID support */
>  #define X86_FEATURE_DECODEASSISTS	(15*32+ 7) /* "decodeassists" Decode A=
ssists support */
> +#define X86_FEATURE_PERFCTR_VIRT	(15*32+ 8) /* PMC virtualization suppor=
t */

[Severity: Low]
Should this addition also be mirrored in the tools directory?

When arch/x86/include/asm/cpufeatures.h is modified, it usually requires a
synchronized update in tools/arch/x86/include/asm/cpufeatures.h.

Does omitting this update trigger a kernel ABI header differences warning
from check-headers.sh during the tools/perf build?

>  #define X86_FEATURE_PAUSEFILTER		(15*32+10) /* "pausefilter" Filtered pa=
use intercept */
>  #define X86_FEATURE_PFTHRESHOLD		(15*32+12) /* "pfthreshold" Pause filte=
r threshold */
>  #define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Control=
ler */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786345201.gi=
t.sandipan.das@amd.com?part=3D4
