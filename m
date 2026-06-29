Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152B1B86C7
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700648; cv=none; b=ekc6IFtT/a7c/54Py7ax3ubYpkg6u6OtkONPoNXSYrsRDMN21wP4MCU6oxRclRE0SbtD6afkHX505k6Qx7lq4vW+IU+cLephi6R/Gta6lzGb3EBBYTmjhPCyeZouUXtf1Fu7Zi2AmhH3nHNnhkXWW+/tTqn81fIAlDNTU3rtxVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700648; c=relaxed/simple;
	bh=gY67W8w7X9LFldn5Qb8CmKUHWorZueqQlrwmquNELcI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=foitxcm8WWwo8LDshDSWp9ddDEgrnfYnJQlJ6TDKLhApZVYp/hHwcRAFf1B1TGBngmn+bl4X6MZ2ZekonVcjJReakJ8F9HnVe4BgZRXwemEmoqc4X1uPdWBc5bPq/BG6hvfRS7l4gME1OhUh3fLSTKWOrHtNBIXeOc0nnwNhas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqugfYjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqugfYjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428171F000E9;
	Mon, 29 Jun 2026 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782700647;
	bh=9IGuemSkZI7WoYMCkU9Gh23Yg7kdavxbKjb96NJb9Qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HqugfYjoeKSSbzroFtEPSg0Kal/+ZKTsiYQZ4MC52EFeauzVIKZBxXQ4yiBKSn1QY
	 Bp2deQG/vF9wz2D/PVxscp3f6xx1OURSR+M+eALDjTz03uwTTBgRy7j7V6LhFANdGA
	 fpTKstXbnXgzEe+aFrLcEnIM0P6HJ/32RL0fhOxx/4/fWiLwxakoMe1I68SfWY93CE
	 VfgEk8MJIXupqymgiDjUQqwvOQZnQEr1/ZIn5sNiJ3Yi/bv8JMGts5YWauy0S5YLwm
	 heWpA6b559YfdxWbF5jTc9sU8LS5qpaxu2OPW3T7uJl3y43VGLTJBM8Cnh/C0oXXNR
	 CJMiJjSZQcEUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] LoongArch: KVM: Replace kvm_err() with
 WARN_ONCE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629023213.597030-3-maobibo@loongson.cn>
References: <20260629023213.597030-1-maobibo@loongson.cn>
 <20260629023213.597030-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 02:37:26 +0000
Message-Id: <20260629023727.428171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Replacing `kvm_err()` with `WARN_ONCE()` on user- and guest-co=
ntrollable error paths introduces a host Denial of Service (DoS) vulnerabil=
ity.
--

commit 2fb4171bf923d0f32f53ed0ef52aee506acd81c3
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Replace kvm_err() with WARN_ONCE()

Since guest kernel and ioctl parameter from user mode is untrusted,
there may be noise kernel log output in host hypervisor with abnormal
state. Here replace kvm_err() with WARN_ONCE() to reduce this kind
of noise kernel log, and there is no function change.

> diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
> --- a/arch/loongarch/kvm/exit.c
> +++ b/arch/loongarch/kvm/exit.c
> @@ -252,7 +252,7 @@ int kvm_complete_iocsr_read(struct kvm_vcpu *vcpu, st=
ruct kvm_run *run)
>  		*gpr =3D *(s64 *)run->iocsr_io.data;
>  		break;
>  	default:
> -		kvm_err("Bad IOCSR length: %d, addr is 0x%lx\n",
> +		WARN_ONCE(1, "Bad IOCSR length: %d, addr is 0x%lx\n",
>  				run->iocsr_io.len, vcpu->arch.badv);

[Severity: Critical]
Does changing this to a WARN_ONCE() introduce a host denial of service
vector? A malicious guest executing an operation with a bad IOCSR length
can trigger this path in kvm_complete_iocsr_read().

If the host system is configured with panic_on_warn=3D1, this allows an
untrusted guest to crash the host. Could this be changed to pr_warn_once()
or pr_err_ratelimited() instead to reduce the log spam without the risk
of a kernel panic?

[ ... ]

> diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/=
dmsintc.c
> --- a/arch/loongarch/kvm/intc/dmsintc.c
> +++ b/arch/loongarch/kvm/intc/dmsintc.c
> @@ -114,7 +114,7 @@ static int kvm_dmsintc_ctrl_access(struct kvm_device =
*dev,
>  		}
>  		break;
>  	default:
> -		kvm_err("%s: unknown dmsintc register, addr =3D %d\n", __func__, addr);
> +		WARN_ONCE(1, "%s: unknown dmsintc register, addr =3D %d\n", __func__, =
addr);

[Severity: Critical]
Similarly here, can a host userspace process trigger this WARN_ONCE by
passing an invalid address to KVM_SET_DEVICE_ATTR for the dmsintc device?

This would allow an unprivileged host userspace process to crash the host
if panic_on_warn=3D1 is set.

[ ... ]

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1473,7 +1473,7 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,=
 struct kvm_interrupt *irq)
>  	else if (intr < 0)
>  		kvm_dequeue_irq(vcpu, -intr);
>  	else {
> -		kvm_err("%s: invalid interrupt ioctl %d\n", __func__, irq->irq);
> +		WARN_ONCE(1, "%s: invalid interrupt ioctl %d\n", __func__, irq->irq);

[Severity: Critical]
Does this also allow unprivileged userspace to trigger a warning via a
bad interrupt ioctl parameter?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629023213.5970=
30-1-maobibo@loongson.cn?part=3D2
