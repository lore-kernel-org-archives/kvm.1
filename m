Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC438E8B7
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944782; cv=none; b=L2WnV4twTzqjN9u+Vj/Peqs5jMq5EE3Wr/dT3mI9lSHEyvwxzxJWkDziI7/BdqG0it6xxjin/8peL3XEOniXtkDW+WLXy3DlmZjSGPGjXULCAifKNy021Siis7UQa2dzB85q1Smh1HyYa6+y9V/LLLMO6lUazUrKjIvcCd7qDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944782; c=relaxed/simple;
	bh=vy++vdSqretynCRwIXnbik7ESUvcPJ8B3hg+0rARvt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g9XUb3uPPk965YcisLOyQslbHfrD1s2CVitQJFe6DVhoCHOH5UweyLkisoXMywlO5XQHIbkKz/ivAlq0loVmBJCsDEfw6B81BrDgrk27cE6AMNpaxfNC1PnNRdM28WKCzLJcoPsww5bp0FBW8wlx1AGKK3l8wk99mtnS3436slE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFTGC8Er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFTGC8Er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326AC1F00893;
	Mon,  8 Jun 2026 18:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780944781;
	bh=CKPMFBmSLeg25/wHAyTakxZxjmhlAz3XH+pxSMwHOQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BFTGC8Er1EZ/cdUiWpGH/IDmJZtZ15xKf+hqJ3aQKu6LIhVRAwIlbR/SO+mGDZuRU
	 rtak/P4a5xNSUKc0KuPJoKZldDGN1M/5WIlWLlH19Mc+nUSIvPyEv80WKjqs8jop99
	 7Wkr3GicEfhXSEXN84t0OFH4g1OnjDPWYn57jHI33EYibDDw2yj74BrY3K5lNgePRD
	 u9EBrUNvvwTWclNoFnIiPaS1yGH6AvFTzJuJtCgfGNH8dTYJMGRNfL5W9PMY86sPWN
	 hFwzYHTWoXW39bcrDsrLrYCknyadUdIlnxE0iins8OveSLI6LrKpj31QqUmJtYTlK6
	 3HimCGhWWMmTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/34] KVM: x86: Kill last_tsc_{nsec,write,offset}
 fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608145455.89187-20-dwmw2@infradead.org>
References: <20260608145455.89187-20-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 18:53:00 +0000
Message-Id: <20260608185301.326AC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Mathematical flaw in S4 host resume TSC adjustment permanently bre=
aks cross-vCPU synchronization.
- [High] Lockless read-modify-write of `cur_tsc_write` introduces a race co=
ndition with concurrent `KVM_SET_TSC` ioctls.
- [Medium] The commit silently changes the logic for TSC matching after an =
S4 resume without documenting the functional change.

Pre-existing issues:
- [Critical] Unprotected iteration over `vm_list` in CPU hotplug path leads=
 to Use-After-Free.
--

commit d9bfcd24b7d69aa51689545f7274022cd36bbee8
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Remove last_tsc_{nsec,write,khz,offset,scaling_ratio}

This commit removes the redundant last_tsc_* variables, as they pointlessly
duplicate the cur_tsc_* values used for TSC generation tracking. The patch
renames the remaining properties to reflect the current generation and
updates the S4 host suspend logic.

> These pointlessly duplicate the cur_tsc_{nsec,write,offset} values.
> The only place they were used was where the TSC is stable and a new
> vCPU is being synchronized to the previous setting, in which case the
> cur_tsc_* value is definitely identical.
>=20
> Rename last_tsc_khz and last_tsc_scaling_ratio to cur_tsc_khz and
> cur_tsc_scaling_ratio respectively, since they are properties of the
> current TSC generation.

[Severity: Medium]
Does this commit also introduce a functional change to the S4 host suspend
logic?

The commit message describes a pure cleanup of duplicated variables, but the
patch removes the explicit zeroing of last_tsc_nsec and last_tsc_write (whi=
ch
disabled TSC matching) and replaces it with a math adjustment to
cur_tsc_write. Should this behavioral change be documented in the commit
message?

[ ... ]

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c8c0633263fb..bbd642e0dc54 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -13543,13 +13539,15 @@ int kvm_arch_enable_virtualization_cpu(void)
>  			}
> =20
>  			/*
> -			 * We have to disable TSC offset matching.. if you were
> -			 * booting a VM while issuing an S4 host suspend....
> -			 * you may have some problem.  Solving this issue is
> -			 * left as an exercise to the reader.
> +			 * Adjust the TSC matching reference by the same
> +			 * delta applied to each vCPU's offset, so that
> +			 * future KVM_SET_TSC / vCPU creation still matches
> +			 * correctly against the adjusted TSC timeline.
> +			 * Scale from host to guest TSC rate.
>  			 */

[Severity: Critical]
This isn't a bug introduced by this patch, but does the iteration over vm_l=
ist
in kvm_arch_enable_virtualization_cpu() need to hold kvm_lock?

Since kvm_arch_enable_virtualization_cpu() is called from the CPU hotplug
callback, it runs under the CPU hotplug lock but doesn't seem to serialize
against the kvm_lock mutex. If a VM is destroyed concurrently via
kvm_destroy_vm(), could this lockless iteration dereference a freed KVM
instance?

> -			kvm->arch.last_tsc_nsec =3D 0;
> -			kvm->arch.last_tsc_write =3D 0;
> +			kvm->arch.cur_tsc_write -=3D
> +				kvm_scale_tsc(delta_cyc,
> +					      kvm->arch.cur_tsc_scaling_ratio);

[Severity: High]
Does this S4 resume adjustment to cur_tsc_write permanently break cross-vCPU
synchronization by omitting the symmetrical adjustment to cur_tsc_offset?

During S4 resume, existing vCPUs compensate their offsets via delta_cyc.
When a new vCPU is subsequently created or KVM_SET_TSC is called,
kvm_synchronize_tsc() assigns the new vCPU's offset directly from
kvm->arch.cur_tsc_offset:

kvm_synchronize_tsc() {
    ...
    offset =3D kvm->arch.cur_tsc_offset;
    ...
}

Because cur_tsc_offset lacks the delta_cyc compensation applied to existing
vCPUs, won't the new vCPU's TSC timeline be permanently shifted backward by
delta_cyc relative to the existing vCPUs?


[Severity: High]
Can this lockless read-modify-write operation race with concurrent KVM_SET_=
TSC
ioctls?

Since CPU hotplug can occur while KVM is running VMs, if the platform
registers a backwards TSC during CPU bringup, this path executes concurrent=
ly
with userspace ioctls like KVM_SET_TSC.

KVM_SET_TSC properly acquires kvm->arch.tsc_write_lock before updating
cur_tsc_write and offsets. Could this lockless subtraction tear the 64-bit
value or overwrite a brand-new TSC generation state from KVM_SET_TSC?

>  		}
> =20
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608145455.8918=
7-1-dwmw2@infradead.org?part=3D19
