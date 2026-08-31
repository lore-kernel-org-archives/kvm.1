Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE238D
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161029; cv=none; b=AickkfKe4r0aF4o5fzVkI2tr9/tBZAxAvcVe2TTw9A4IcXWjV/aYCEPtMl9/p7UJqnvmpOzoMyfcwS4UziWCfz8cHTBYom0DJJuSQoV6LORG6xlbtofXvUYdGinq1XGxXEozklTm/dGBeAooWlXtZhkATFA5gmJUkL8gBgGNq5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161029; c=relaxed/simple;
	bh=WOi6qKfJ4I7pFvTUm+Hy5Z5xysLPScODGZ4Ju2V6WE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZMCijIJPU0AlEgNikCdYBZjnIfDYOHYOXSlBzmuF5pYCk81jFJIeZJAo/7jhEiJCRizgI90lD3HZVqaKUL0YlQECv/QnS0CVN/qqTX2MxgInTQs/05RfquO/VbgKfO0+lAX0utxG2195qt/oOXIR+7gYO2/JHws7v9gC3Pr4wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbpjMi8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbpjMi8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD2E1F00ADF;
	Mon, 31 Aug 2026 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161027;
	bh=t48HDpUQ7GYXDql3zsnP2SmwGw8vcOE5F4xfO6tZlJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbpjMi8PLfRG+Do/hS/GxkAK2OW48gnr7LoIGSQnu+l9Splj9RR+gT2MMIWRpO0Jm
	 TOzTIoaHHKHOePioNKawIfo93XCHr3IeRbgrB1+KlU4X1y79QGya6G4XCk1EHPBxXk
	 7pKdXz0HyytFdYKDXoW+JmNMhfGZzD3+aAKdcelCCXN2T8M8Dl77S2NVP3Yq5VnEc7
	 XdA3ecngLE6zpZaEEEj2OI3ZcyVlo5HC9jVR4hvJo46ayQkG29i+S9/+ptaxV7jBVx
	 kkkoo6n7VnaG+wvnrVVQ4MaCGBdbUYohw35n0zXb+oqRqZcb0GUEYRTM6awMK2wlbZ
	 f4UgGT3lLwzpw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] KVM: x86: Add optional KVM_EXPORT_MEMORY and
 KVM_IMPORT_MEMORY
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tony Lindgren" <tony.lindgren@linux.intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260831071304.762939-4-tony.lindgren@linux.intel.com>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-4-tony.lindgren@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:23:47 +0000
Message-Id: <20260831072347.8FD2E1F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unvalidated UAPI fields `flags` and `id` in `struct kvm_memory_t=
ransfer` can lead to ABI breakage.
--

commit b6f49e80a58eebaaa2a6d123950fd36709972a10
Author: Tony Lindgren <tony.lindgren@linux.intel.com>

KVM: x86: Add optional KVM_EXPORT_MEMORY and KVM_IMPORT_MEMORY

This commit adds support to export and import KVM memory for cases where
the memory is only accessible to the guest. It introduces the optional
KVM_EXPORT_MEMORY and KVM_IMPORT_MEMORY ioctls to assist with live
migration of confidential computing.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7064fd709e56d..8a99c665008a3 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -7258,6 +7258,37 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *fil=
p, unsigned int ioctl,
>  	return -ENOIOCTLCMD;
>  }
> =20
> +static int kvm_vm_ioctl_transfer_memory(struct kvm *kvm, bool import,
> +					void __user *argp)
> +{
> +	struct kvm_memory_transfer mem;
> +	int r;
> +
> +	if (!kvm_x86_call(cap_live_migration)(kvm) ||
> +	    (import && !kvm_x86_ops.import_memory) ||
> +	    (!import && !kvm_x86_ops.export_memory))
> +		return -ENOTTY;
> +
> +	if (copy_from_user(&mem, argp, sizeof(mem)))
> +		return -EFAULT;
> +
> +	if (mem.reserved || mem.buf.reserved || !mem.nr_gfns)
> +		return -EINVAL;

[Severity: Medium]
Does this input validation for the kvm_memory_transfer UAPI struct miss
checking mem.flags =3D=3D 0 and mem.id =3D=3D 0?

Failing to validate that unused UAPI fields are zero allows userspace to pa=
ss
uninitialized garbage. If KVM later assigns specific meaning to these field=
s,
older applications that unintentionally passed non-zero values could break,
leading to an ABI compatibility issue.

Standard Linux UAPI design usually requires enforcing these unused or reser=
ved
fields to be zero for future extensibility.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831071304.7629=
39-1-tony.lindgren@linux.intel.com?part=3D3
