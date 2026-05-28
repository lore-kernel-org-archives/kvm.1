Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA712F12CE
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978979; cv=none; b=XJzwGolngs1Pd3QSGSSPwVFSvfyMTd3A5Dn3ql7josl6i77UTQw9Rr2rKi0tef1qqS0kizEgPVcVf/P3ReTNBboUhg3BmW8d/Tn/iuu7T7z+diJOkTBYOeBMQfIl1I4iwCf3PwKnFEJXBpC/abeDb9qtsxYNXBgV7f42td3Bq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978979; c=relaxed/simple;
	bh=vTzzWbUBLdCBRmavGH9+PlNlAMEZstuSSPjafl37zww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pFSDgOFaw3Ioj0Bmq9HZMPZtbRI1gpFemCLA/sBndW3b5+qcWOls0b9ZpfsTPtsQ4uYFL9ssZf2DIalbA0DRJXih83UKcUhsrtnlrOIARcxyTDNNgzCoBKMFSWAp4TLiej/0ZUyM/iQN4Y7Jzumn15yigJ0+6ksyvLXawHJKYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp864jIq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp864jIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A501F00A3A;
	Thu, 28 May 2026 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978978;
	bh=bp/HKOHUwENnU7joarl/ygLqLiCPuJ9XOnsc5cn7YS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kp864jIqigOYDZkR11L6oT1ceoUasV2qTmta6sxGcun07DAp/KHuohcFjglyu+mEU
	 xbPi2FqfvcWtoXuSj3A4xHdlW3E/RcYSqHfIAQget/xFU+DMAejBT8POHWW6Nw9vxg
	 OMPYPsJNX52A5vCgboqUoNhHVFPidG6msSMWbzqEJzYkb6hr1Krf5DNETNtYsZAYUZ
	 oZRehzb9j0ybERwVpq4y4NyPAS9qtVlDNOH0QxCe4+Cqx5c7YyONRPLKdHSUKoLUHD
	 e29yj3hM8jCIa254e2ajOqMaBRs939ChS8i34+9WtTiC2CpKn3PBSxbnchRcmn0uPr
	 uWPQNY+FGIegA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] KVM/x86: Return -errno instead of "1" for VMX
 related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528111357.264809-5-jgross@suse.com>
References: <20260528111357.264809-5-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 14:36:17 +0000
Message-Id: <20260528143618.49A501F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guest-to-Host Denial of Service via MSR Emulation (KVM_RUN ioctl a=
bort)
--

commit 68dde399e7fbf1e1f2516727d71c3f6a0bd2fb77
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for VMX related MSR emulation

This patch updates VMX MSR emulation routines to return negative errno valu=
es
instead of a literal "1" when signaling an error.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 3fe88f29be7a9..2236f15ffab22 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1611,7 +1611,7 @@ int vmx_get_vmx_msr(struct nested_vmx_msrs *msrs, u=
32 msr_index, u64 *pdata)
>  		*pdata =3D msrs->vmfunc_controls;
>  		break;
>  	default:
> -		return 1;
> +		return -EINVAL;

[Severity: High]
Will returning a negative error code here bypass #GP injection and=20
terminate the VM?

In KVM's x86 MSR emulation framework, returning 1 from an MSR handler=20
signals KVM to inject a General Protection Fault (#GP) into the guest.=20

If this is changed to a negative error like -EINVAL, the error handling path
in __kvm_emulate_rdmsr() and __kvm_emulate_wrmsr() treats it as a fatal=20
error:

    r =3D kvm_set_msr(vcpu, msr_index, data);
    if (r < 0)
        return r;

This propagates the negative error code directly up the call stack to=20
vcpu_run(), terminating the KVM_RUN ioctl with an error. Since userspace VM=
Ms=20
like QEMU generally treat KVM_RUN failures as fatal, does this allow any=20
guest to trivially crash its own hypervisor process by performing an invali=
d=20
MSR access?

>  	}
> =20
>  	return 0;

[ ... ]

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 49feecb286b23..f6ec51dc7c778 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2359,7 +2359,7 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_d=
ata *msr_info)
>  		break;
>  	case MSR_IA32_DEBUGCTLMSR:
>  		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
> -			return 1;
> +			return -EINVAL;
> =20
>  		data &=3D vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528111357.2648=
09-1-jgross@suse.com?part=3D4
