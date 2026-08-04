Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67F381B1D
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 18:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867578; cv=none; b=Sr019e67K7f6P8QrafZHGpC4mZV5DFqThjxT1nVKLl3x+YeJOS6rfT6O41hBoJKrDqQjpdcAQu4Yg4iINsX+cLnZhXL8cy6rMbzuzU+1fB4Fs2PCAUu4inASXysPI1o++p2B42iY/MWlpimmmHqQMpNpB5OJt4WunBSh8hfjBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867578; c=relaxed/simple;
	bh=OHEsUoOuaM7AjqwfID4fRLpsG1beywprHeA8s1R8WE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A5ToyLamhS1uZDAZi3ZLDWQiPJV3w5qB0d3UQl1k8W7Z0eWsm0ySYkJnh/tZvZqu4rzFqFqT8JESoPUwI/9fRLxva5oWvTmnzxqSIqmc+ePrtHJSQzRGF3CFwpiVsjcbXhTvFFbSFejXs/Xw70ee8i7+oZLt95sGeJPtnN246+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2ZBU5sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2ZBU5sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF2A1F000E9;
	Tue,  4 Aug 2026 18:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785867577;
	bh=vlWWqG5m01cnhtPGiJlh2RmxdNi01Y1P6Kr193nZXNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N2ZBU5sUPq+pTb6nX7YfVSWTl5g1HSfw5iVdTfIbqVwkr+kx/tMUwvnLm0xDmTuWQ
	 w9iOtKOzdwGK6Gd9+fr4RkQjT0ZF4HJHpCUAiWpWz3EQ9kINA+n0WwqJL9zyQZcMeQ
	 qFhkabpfyVXMblbDztzVfeCfnRMW1LJ/gZBgN5NyUV5qhjdF+r50Vi7YwGCxpH2kfe
	 KcGuPgjcfuZeSZAPu+UBOXZH1+QI4WF8tBymIdV2mNHWh25Tr5lyD/E6n+PxkWr8b4
	 yB2nUjTa+inQgclKlwupkb9GeNHKVM6k6ocOJLEXMvafBPXcN5yTu7Flzg8GZ1RjC9
	 UiKI3lvM08Glw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 wire up ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amit Machhiwal" <amachhiw@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804180705.59160-2-amachhiw@linux.ibm.com>
References: <20260804180705.59160-1-amachhiw@linux.ibm.com>
 <20260804180705.59160-2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:19:36 +0000
Message-Id: <20260804181937.2EF2A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The ioctl artificially inflates the userspace struct's `size` fiel=
d on success, creating a memory corruption trap if userspace reuses the str=
uct.
- [High] The ioctl unconditionally rejects larger structs with -E2BIG, bypa=
ssing standard UAPI zero-checking and encouraging silent input truncation.
- [Medium] The KVM_PPC_GET_COMPAT_CAPS ioctl availability is decoupled from=
 its KVM_CAP_PPC_COMPAT_CAPS capability, breaking capability negotiation an=
d bisectability.
--

--- Patch [1]: [PATCH v6 1/4] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS a=
nd wire up ioctl ---
commit bcf86bb5d3079ca2dbb4bf09693ba6e6a24b06c5
Author: Amit Machhiwal <amachhiw@linux.ibm.com>

KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and wire up ioctl

This commit introduces a new capability and ioctl to expose CPU compatibili=
ty
modes supported by the host processor for nested guests.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 00302399fc37b..8d6632c64ca5f 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -697,6 +697,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lo=
ng ext)
>  			}
>  		}
>  		break;
> +#if defined(CONFIG_KVM_BOOK3S_HV_POSSIBLE)
> +	case KVM_CAP_PPC_COMPAT_CAPS:
> +		r =3D 0;
> +		if (kvmhv_on_pseries())
> +			r =3D 1;
> +		break;

[Severity: Medium]
Is this capability check fully aligned with the ioctl's availability?

This check returns 1 on a pseries host using PR KVM (since it misses the
hv_enabled check), but the ioctl might fail with -ENOTTY if the backend
is missing.

Later in the ioctl execution, it succeeds on a bare-metal host using HV KVM
(missing the kvmhv_on_pseries() check) even though this capability check
would return 0.

Could this decoupling between the capability and the ioctl availability bre=
ak
capability negotiation for userspace?

> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
>  	default:
>  		r =3D 0;
>  		break;

[ ... ]

> @@ -2463,6 +2470,70 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned =
int ioctl, unsigned long arg)
>  		r =3D kvm->arch.kvm_ops->svm_off(kvm);
>  		break;
>  	}
> +	case KVM_PPC_GET_COMPAT_CAPS: {
> +		struct kvm_ppc_compat_caps host_caps =3D {};
> +		u64 usize;
> +
> +		/*
> +		 * Read the size field first to drive copy_struct_from_user.
> +		 * size must be the first field of the struct.
> +		 */
> +		r =3D -EFAULT;
> +		if (get_user(usize, (__u64 __user *)argp))
> +			goto out;
> +
> +		/*
> +		 * Enforce a minimum: reject buffers smaller than the initial
> +		 * struct version (VER0). This allows old userspace compiled
> +		 * against the original struct to still work on a newer kernel
> +		 * that has grown the struct with appended fields.
> +		 */
> +		r =3D -EINVAL;
> +		if (usize < KVM_PPC_COMPAT_CAPS_SIZE_VER0)
> +			goto out;
> +
> +		/*
> +		 * New userspace with a larger struct called an older kernel.
> +		 * Write back ksize in host_caps.size so userspace knows which
> +		 * older struct to retry with, then fail with -E2BIG.
> +		 */
> +		if (usize > sizeof(host_caps)) {
> +			host_caps.size =3D sizeof(host_caps);
> +			r =3D -EFAULT;
> +			if (put_user(host_caps.size, (__u64 __user *)argp))
> +				goto out;
> +			r =3D -E2BIG;
> +			goto out;
> +		}

[Severity: High]
Does explicitly rejecting larger structs here bypass the standard UAPI
zero-checking?

By catching usize > sizeof(host_caps) early and returning -E2BIG, the code
bypasses copy_struct_from_user()'s built-in validation which would safely
reject non-zero extended fields.

If userspace receives the smaller kernel size and retries by truncating its
buffer size, the kernel will only read the truncated portion, silently
ignoring any non-zero extended fields that userspace originally provided.

Should this rely on copy_struct_from_user() to safely check zeroed trailing
bytes instead?

> +
> +		/*
> +		 * copy_struct_from_user() handles forward/backward compat:
> +		 *   usize =3D=3D ksize: verbatim copy
> +		 *   usize <  ksize: zero-pad trailing (old userspace, new kernel)
> +		 */
> +		r =3D copy_struct_from_user(&host_caps, sizeof(host_caps),
> +					  argp, usize);
> +		if (r)
> +			goto out;
> +
> +		/* Reserved fields must be zero */
> +		r =3D -EINVAL;
> +		if (host_caps.flags)
> +			goto out;
> +
> +		r =3D -ENOTTY;
> +		if (!kvm->arch.kvm_ops->get_compat_caps)
> +			goto out;
> +
> +		r =3D kvm->arch.kvm_ops->get_compat_caps(&host_caps);
> +		if (r)
> +			goto out;
> +
> +		host_caps.size =3D sizeof(host_caps);
> +		r =3D copy_struct_to_user(argp, usize, &host_caps,
> +					sizeof(host_caps), NULL);

[Severity: High]
Can this artificial size inflation cause an out-of-bounds read/write if
userspace reuses the struct?

If an older userspace passes a smaller struct to a newer kernel (where
usize < sizeof(host_caps)), the kernel sets host_caps.size to its own larger
size. It then copies the smaller usize bytes back, overwriting the userspace
size field with the kernel's larger size.

If userspace reuses this struct for a subsequent ioctl call, it will now pa=
ss
the larger size. The kernel would then read past the end of the originally
allocated userspace buffer, and if successful, write back past the end
as well.

> +		break;
> +	}
>  	default: {
>  		struct kvm *kvm =3D filp->private_data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804180705.5916=
0-1-amachhiw@linux.ibm.com?part=3D1
