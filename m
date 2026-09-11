Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D34BEE25
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165216; cv=none; b=u+J+C803osYfIN2t5JBuS5BSDrWcb7H/GOWLnRZ0kHZn+dKD9paYtSUot97ubIK4xBoqUg3h9HBIHMkXG3PqrgIUAv845Vc+2JWkKwDRb0mmqrLRXjTWjCv72xZZrSiXgO66UqtzJgX9rC+qmLLEb/CNKW0mxLTJISAcO8Hvl2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165216; c=relaxed/simple;
	bh=AIJIfK2MxIIddBZSjrUsldeX4biD/oFNkLMMbERVFuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2yy8L5h3ZeN4jcoHgEx8isNNlwyAmZrHj03TzealgrRFLgBDBuMvwwbl1o7yW0hmPyc9+Ro7yxsJ09FzbwTfBtXLec968oFuM6G58F/sGEtrJVW+vRfVwqk3Twz/G3fLwKlTQPdF61DsGvuGtrECEZM3ayr6IBq6DeIufwy4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAqpvbnG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAqpvbnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CC01F000FF;
	Fri, 11 Sep 2026 22:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165212;
	bh=TVvnZ0x8s1NbebSY1w6VXkP1QCDt28ipTtT11CWLOwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CAqpvbnGn5PoiXcCEzApfDZi/5/YVutOVaXvhM1+1TU1DsxNpzggaB1Va7rk6GUZL
	 vyAngX1t8KJYXRULx0JLvGvEBHDBt4c7abuVZXgiqusWDBvsmfkb6SmUmYJ6psZprv
	 odoW+y9z5tBpQJBOQr9KoYlN1wiY4gRqXwlAWm/uW3QZNwkgGswcq2VqxVeYkzWL71
	 b9Si7fW7x2OvMfWEBvvoShe66wPppQ8V7LKa4uLrGZnB8W7nYk4RLYZdEZETyhcMGA
	 irlz8KNr2QlEXpixJuYwKge4q/bvKESmALUXIJA4titeRb+w8BYaK6pbmVqONbVTMM
	 aabZcGfYSk4Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 22/28] KVM: nVMX: Restrict event data VMCS fields to
 FRED-supported hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-23-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-23-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:20:11 +0000
Message-Id: <20260911222011.D2CC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete restrictions for new VMCS fields exposing unsupported=
 fields to L1 guests.
--

commit 54389ae57bfff5e56dff4d41b4c42f872fb1693f
Author: Xin Li <xin@zytor.com>

KVM: nVMX: Restrict event data VMCS fields to FRED-supported hosts

This commit restricts L1 guest access to the ORIGINAL_EVENT_DATA and
INJECTED_EVENT_DATA VMCS fields via VMREAD or VMWRITE when FRED support
is disabled. It updates cpu_has_vmcs12_field in arch/x86/kvm/vmx/vmcs12.c
to check cpu_has_vmx_fred for these specific fields.

> diff --git a/arch/x86/kvm/vmx/vmcs12.c b/arch/x86/kvm/vmx/vmcs12.c
> --- a/arch/x86/kvm/vmx/vmcs12.c
> +++ b/arch/x86/kvm/vmx/vmcs12.c
[ ... ]
> @@ -222,6 +222,9 @@ static __init bool cpu_has_vmcs12_field(unsigned int =
idx)
>  	case HOST_SSP:
>  	case HOST_INTR_SSP_TABLE:
>  		return cpu_has_load_cet_ctrl();
> +	VMCS12_CASE64(ORIGINAL_EVENT_DATA):
> +	VMCS12_CASE64(INJECTED_EVENT_DATA):
> +		return cpu_has_vmx_fred();
> =20
>  	/* KVM always emulates PML and the VMX preemption timer in software. */
>  	case GUEST_PML_INDEX:
>  	case VMX_PREEMPTION_TIMER_VALUE:
>  	default:
>  		return true;

[Severity: Medium]
Does this code leave other FRED-related fields exposed to L1?

While this restricts ORIGINAL_EVENT_DATA and INJECTED_EVENT_DATA, it
appears to omit all GUEST_IA32_FRED_*, HOST_IA32_FRED_*, and
SECONDARY_VM_EXIT_CONTROLS fields.

Because cpu_has_vmcs12_field falls through to the default case and
returns true for unhandled fields, wouldn't these remaining FRED MSR
fields and SECONDARY_VM_EXIT_CONTROLS be unconditionally exposed to an
L1 guest?

If a nested hypervisor (L1) executes VMREAD or VMWRITE on these specific
fields (for example, GUEST_IA32_FRED_CONFIG) on a host without FRED or
secondary VM-exit controls, KVM intercepts the instruction and calls
vmcs12_read_any or vmcs12_write_any.=20

Because they are incorrectly populated in the vmcs12_field_offsets array=20
by default, it seems they would be allowed instead of properly generating=20
a VMfail (VMXERR_UNSUPPORTED_VMCS_COMPONENT), violating the CPUID-based=20
capability masking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D22
