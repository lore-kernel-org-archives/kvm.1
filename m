Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A71D88B4
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 00:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830401; cv=none; b=OqBx6nxcizvr4fwNpFmKMdn6snNjxHg/+poO82Io1a4ZkjTKoCZ/L5wghh/e2b4jBfMTAq9tbjdosv7CQCsrxOj46eHuhddFIH8sPwqiWdP3rT2+SLfOdnOXqz8h7DrcXtL2dzaFII8Llu34AQksl0v9b2gqkmkqSPBeoDWdsbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830401; c=relaxed/simple;
	bh=X2XjxmUY/bHfC+VXR6ph1sLQys7Y93jxlXnD5T2CqcU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N3XX3eDKh3eJdbS861RrokKDJOvukNml6C2+Nym91FD9yJJiMem7iL20RlECCpqva6gm2S2fxCmBDtBQomgaxx9imss0gtm9nz6sughu2b59gAPxonO05DmayILuj+9TK7UNjd7NmFWWEvSGtiDOiZ/UEPumUovLtFnHEnJkAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWk4pebh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWk4pebh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A8F1F000E9;
	Fri, 19 Jun 2026 00:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830400;
	bh=B4/BAlfpeazuuPpw5nz3+adfwas1/X2d3i+ej5WKDTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWk4pebhldTVa+JIMPLQK69dRzpFUEVu969RcH5t7OUE5weRixgyGRpyWEuAoiiI7
	 S7pr/IIa8Uly+lCLc9bJzwtbXL8pXSiqd01u1Ewh6dlkYBULlOPCgGXGi1oXqocxoe
	 P+PhzgEy/GtdyptBb+utgcHJAdrdDIGnG/rf5IGEkm9zaBcPSn84h9H0DXdyQBc18p
	 NPEoBji71cE5S7v+mS59Q3CPyh2jzvUQ2poc7LKJnXkfa4LiQUaOpSm+s60g4j+Kbq
	 /BotCsy2zS3DCdwjQDLrNdafvNw+Pu/+pcL97DZhZG/bpBXiaUvaVIucOh+UPYqVav
	 Xuh8WJUuK2v0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise
 KVM_SET_MEMORY_ATTRIBUTES2 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ackerley Tng via B4 Relay" <devnull+ackerleytng.google.com@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 00:53:19 +0000
Message-Id: <20260619005320.51A8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing compat_ioctl handler for guest_memfd file operations cau=
ses KVM_SET_MEMORY_ATTRIBUTES2 to fail with -ENOTTY for 32-bit userspace.
--

commit d35a6816bc0c5b6e6650f6f4fcbbef3d9b3e3590
Author: Ackerley Tng <ackerleytng@google.com>

KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2 ioctl

Introduce KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES to advertise the
availability of the KVM_SET_MEMORY_ATTRIBUTES2 ioctl. This ioctl allows
userspace to manage memory attributes, such as KVM_MEMORY_ATTRIBUTE_PRIVATE,
directly on a guest_memfd file descriptor. It also adds an error_offset
field to handle EAGAIN results during transient page reference counts.

> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 876c0429f9d4e..129d6f6303251 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
[ ... ]
> @@ -1649,6 +1650,7 @@ struct kvm_memory_attributes {
>  	__u64 flags;
>  };
> =20
> +/* Available with KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES */
>  #define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, stru=
ct kvm_memory_attributes2)

[Severity: Medium]
Since this is a new ioctl on the guest_memfd file descriptor, will 32-bit
userspace VMMs running on 64-bit kernels fail with -ENOTTY?

Looking at virt/kvm/guest_memfd.c, kvm_gmem_fops lacks a .compat_ioctl
handler. Because KVM_SET_MEMORY_ATTRIBUTES2 is not in the generic compatible
ioctl list, the VFS layer falls back to returning -ENOTTY instead of calling
.unlocked_ioctl for 32-bit processes.

Since struct kvm_memory_attributes2 is fully 64-bit aligned, it requires
no translation. Should kvm_gmem_fops wire up .compat_ioctl (e.g., to
compat_ptr_ioctl) so 32-bit VMMs can successfully use this capability?

> =20
>  struct kvm_memory_attributes2 {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618-gmem-inpla=
ce-conversion-v8-0-9d2959357853@google.com?part=3D17
