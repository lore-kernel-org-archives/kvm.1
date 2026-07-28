Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEB1A681B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261298; cv=none; b=cdjlIBVjk2O24XSurzBB/ZXbtEM+jN/ncnn15EzWR03uy+AETFfPv5B9jzlaiQH5D3+LTEquQYF+sDwREb7pVQ06PE4VEfjQfyHTNO/JXtul7lkMXe/yfbNkMJkHMcaEgkbL8WB4MOCYgCRM+B2VMtWcSwcN//R5cNvXgW6O5mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261298; c=relaxed/simple;
	bh=EOUoE05HGkpRuc7JiZImvdSrz4jFhhcS+zBeX2ys8uA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JHQnQwS8BqB8hpXVzbj3qt2Xtz7XMaQfp6NZerYpXLy+YQ0gubKbFAPzMX5JsmUxqMq8+Ah8Ttja4t9RiXY1PY5sX/oVQR3ZB1BTpIQn2smS5J++dVvzPBR8rHIVSoGqmaVpaSOyaoen8Pihgw/nOWW+Z3i223rbFh8jpVj3Bo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQghXdjm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQghXdjm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E991F000E9;
	Tue, 28 Jul 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261296;
	bh=jq3jlh8DDo56c6Sw0A8rYjNlUGbJRj4m7dcALRA1Kfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JQghXdjmmL5x58d8tocrsHW8g91pU/eHKnh8wig0oUwYXOt8hcxalRK4wwGuLRuFh
	 BKQBfVEAv/LMvggjpWucdri48+qbKjt25JKR6+xgNhRhHHGa89Yth1I44F28SbfyJO
	 dI3k9Xn7KPtNbbxvW7aY/H093W30jWxeTOrzVcMSeE/yBkgUoGBwSa4zmM1iJ4OMj2
	 D92xeeYAfaLXBNGqfm/KbDysAPeA4eYcWhUucQOqWex0LN57yHmj8TvLWn0JqH49HT
	 BfdgShxYMWSWnOVTSVNHna8qavz09Z0//J73r7H2p3fRJXTEDwT9tXIEgzRajQmnTE
	 pTl1rATh/Y81Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/13] KVM: selftests: Reuse GPR switching logic for
 nVMX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728174232.2423257-6-yosry@kernel.org>
References: <20260728174232.2423257-1-yosry@kernel.org>
 <20260728174232.2423257-6-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:54:56 +0000
Message-Id: <20260728175456.67E991F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced VMX_SWITCH_GPRS_ASM macro uses a shared glo=
bal variable `guest_regs` for swapping host and guest general-purpose regis=
ters, introducing a race condition when multiple vCPUs execute nested VMX i=
nstructions concurrently.
--

--- Patch [5]: [PATCH v5 05/13] KVM: selftests: Reuse GPR switching logic f=
or nVMX ---
commit a0021d28e505a4c708c955c20d96663fad9fc879
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Reuse GPR switching logic for nVMX

This commit reuses the SVM GPR switching logic for nVMX by defining
VMX_SWITCH_GPRS_ASM. It replaces the previous push/pop sequence with
macro calls that swap a broader set of registers using GUEST_SWITCH_GPR_ASM.

> diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testin=
g/selftests/kvm/include/x86/vmx.h
> --- a/tools/testing/selftests/kvm/include/x86/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86/vmx.h
> @@ -290,6 +290,23 @@ struct vmx_msr_entry {
>  	u64 value;
>  } __attribute__ ((aligned(16)));
> =20
> +#define VMX_SWITCH_GPRS_ASM \
> +	GUEST_SWITCH_GPR_ASM(rax) \
> +	GUEST_SWITCH_GPR_ASM(rbx) \

[Severity: Medium]
Since GUEST_SWITCH_GPR_ASM() uses the global guest_regs structure, will this
cause a data race when multiple vCPUs execute nested VMX instructions
concurrently?

When vmlaunch or vmresume is executed concurrently by multiple threads (such
as in the memstress test), they might race to read and write to this shared
variable, potentially corrupting host callee-saved registers like rbx or r1=
2.
Could this lead to host test code crashes when one vCPU restores another
vCPU's parked host registers?

> +	GUEST_SWITCH_GPR_ASM(rcx) \
> +	GUEST_SWITCH_GPR_ASM(rdx) \
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728174232.2423=
257-1-yosry@kernel.org?part=3D5
