Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3B272E6D
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977470; cv=none; b=L50gQ6rcuE+WEUS/z/1pM4LzpZ7v0tPuqLSphIWtafhptJ++za1V3uER+HNw0nfY1OEUR+ecCmOSWW74/mwWKcLm5c6l++H580xINXPM+BYxnqNjTyJlOhTeBvJOuUVfnyOatDLQkXHcWAwVgbrfOh573+vnSbG6eKIqwZtu794=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977470; c=relaxed/simple;
	bh=moa4eC629NIpKb9dAWfgZZfSi69x4eGNeVxKTp62QjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f3oGC1bP8Ri+9G+4iIZ4LbK7xrJopl3F9aCOItMfOOKI+vRIK43v08HliRoSNonOvzcJG41eXoLLXJ0qmXly9T8Lf/aj1ULFr9pT6e26Avt50wDB1PRKb6POJnQVGxeuwV+6O9KF83A+QMT7avCN9FXRcvBq8jPbZfqCmty41VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6iWuNAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6iWuNAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A211F000E9;
	Thu, 28 May 2026 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779977469;
	bh=sDlK4Kx21hsJBBLqoWm6/4a22osx6abHRazE5NeoXFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6iWuNAoOVkrMRsnIczRdtoMoSK5U54Cf3QanWBfwqXnj2cHzEXLhkEgUdEJRnYvi
	 d3Y6/5MWggE/E4WZt2+hxf0Pqc7+7EgYQOj0ewJN8juyHn4PcCuxa7T31dOkyb024l
	 cNg+7dqa6abQqk+AJsr5Qib7283Fddrt/wDOZfVmaeYS4nqeyCn7G7TMZ3PHsg3c6X
	 M1I+pSSyF/Ub72JOdrlV/FalZT4Rw9QvLaIhSiBFvQ7nl8qehUgmyD6X2SyMU8BJfY
	 vH9TVU0WxLVg44atvabjltVUhnb0KwivkvInk7qckG1zdogqGeJkKmaiTza7BwnwFa
	 GT9PpgOPvzF4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] KVM/x86: Return -errno instead of "1" for VMX
 related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528113605.267111-5-jgross@suse.com>
References: <20260528113605.267111-5-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 14:11:08 +0000
Message-Id: <20260528141108.F2A211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing literal `1` with negative error codes (e.g., `-EINVA=
L`, `-EACCES`) in KVM MSR emulation handlers breaks `#GP` fault injection, =
causing guest MSR violations to fatally abort the `KVM_RUN` ioctl and crash=
 the VM.
--

commit cd49bcf603dc5dd7de8fce25d5359556bec52252
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for VMX related MSR emulation

This commit updates VMX-related MSR emulation handlers to return negative
errno values instead of a literal 1 on error.

> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
[ ... ]
> @@ -2391,12 +2391,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info)
>  		break;
>  	case MSR_IA32_UMWAIT_CONTROL:
>  		if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
> -			return 1;
> +			return -EINVAL;
> =20
>  		/* The reserved bit 1 and non-32 bit [63:32] should be zero */
>  		if (data & (BIT_ULL(1) | GENMASK_ULL(63, 32)))
> -			return 1;
> +			return -EINVAL;

[Severity: Critical]
Does this change break #GP fault injection for guest MSR violations?=20

When a guest executes a write to an MSR with invalid data, the handler is=20
expected to return 1. This signals __kvm_emulate_wrmsr() to inject a #GP in=
to=20
the guest via complete_emulated_msr_access().

If the handler returns a negative error code like -EINVAL, it appears
__kvm_emulate_wrmsr() will instead hit the "if (r < 0) return r;" check.

Won't this propagate the error directly up the call stack, abort the ioctl,=
 and
cause userspace to terminate the guest instead of properly injecting a faul=
t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528113605.2671=
11-1-jgross@suse.com?part=3D4
