Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE22321F2D
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740682; cv=none; b=JXtgIKCbJc/qFstNy7IkiV8AJAHM3ufFeiMwxM38VYwVQxxIQi0Cs5RHfZ0D78++sYPJE5DI3jViKgadKYt8uqsH6VGGDRJOThJMNoWTgWi5IlBWW1XS3JHQbVrLEqkm/xnw6ndxAwj7J90gs0ggqSRawYei5hEo+zQ7qAeOJgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740682; c=relaxed/simple;
	bh=1XMPnpWz1O5sQHhWOe71l9Ttph0LJB8BB7fwBSYL0Fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dp8HwMOv3rCnWTDFEzFTq6Gu87ZgP9O3d2i8TZJRSD38WAlHyPla6GRgTHXD+NyKkzdTS6Hw0v5LB+7/iu/4ziNVu88ie1kT6xO0koN8CNERD16NH5+BWDqflqHHd1PCqAcibj4NNXVuM/BdTbFroo6KMnylXQ+uUOZU+ZJ3Os0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDuCCRsy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDuCCRsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622831F000FF;
	Fri, 18 Sep 2026 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789740680;
	bh=PBbn3lsu0bKNa9a7sTndZPGhV6+qRqbOCsKicrUdFkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JDuCCRsysk1ubbmiLBO4FhVJ3alDeQBji/L98gUwt0V6JfucQUpbguoYuYzTb+j+v
	 G7fXc0spLbOnMufG8EuQ8NJdjmVvxm6kmTdLqg/Hs+ATDOmICF6gxnMJlAXgJibAlw
	 HwydblFy0Kl54H4EQNZn44n/prm/r3pquqodEVTIR3WsazD3nzyCZmuPD5sZpPdDF+
	 J3Dmm59pZODdS0SW1HDqhrOaaIU55mmahPyhHSpEkNj6N5alDj5tXanPOXse0RDIVf
	 X41yOz+m6PFWBrEqRT2rVmxXsOUiigPWar0UfipY3+XuAyi/bzLN11qAmr9Gf/FRbg
	 fWocnKGBdYWcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/31] KVM: x86: Introduce memory fault on invalid
 hypercalls reads/writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918135030.171564-7-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
 <20260918135030.171564-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:11:19 +0000
Message-Id: <20260918141120.622831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: KVM_CAP_HCALL_FAULT_EXIT can be toggled dynamically at runt=
ime without locks
--

commit 2924fdad4ef4a10a3e4ce84aa7cf7e1887f8928d
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86: Introduce memory fault on invalid hypercalls reads/writes

This commit introduces the KVM_CAP_HCALL_FAULT_EXIT capability to check
memory read or written by hypercalls. When enabled, an inaccessible input
or output page causes an exit with KVM_EXIT_MEMORY_FAULT. This allows
userspace to perform arbitrary actions when a hypercall refers to an
invalid address.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1b8f24577dbf5..9206593878ee9 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -4210,6 +4211,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>  		mutex_unlock(&kvm->lock);
>  		break;
>  	}
> +	case KVM_CAP_HCALL_FAULT_EXIT:
> +		kvm->arch.hcall_fault_exit =3D cap->args[0];

[Severity: Medium]
Is it safe to toggle this capability dynamically without synchronization?

According to the KVM review guidelines, new state flags and capabilities th=
at
modify behavior should default to immutable to prevent unanticipated state
machine transitions. Modifying this flag without acquiring the VM lock or
verifying if vCPUs have already been created allows userspace to dynamically
flip the capability while vCPUs are running.

Does this also introduce a data race with concurrent readers in the hyperca=
ll
handlers, since the capability flag is written without atomic annotations
or locks?

> +		r =3D 0;
> +		break;
>  	default:
>  		r =3D -EINVAL;
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918135030.1715=
64-2-pbonzini@redhat.com?part=3D6
