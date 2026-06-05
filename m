Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1290E3B71AB
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653307; cv=none; b=qfUePPfaB/Sp0j/58VbAMdcoeX+LRR/p8+oJYQ7Z3mts8QODk/XAyyyt5m7Zg1wrMwv/FRNwlCulRmVVSp87YxE57WpCOmKL+hRjPnSuU3cJZNmhhoBOXYOcn+FVoQROyBus8EsX/6DfhJpOnj9BMw16WpL6joy3YgMq/NzGry0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653307; c=relaxed/simple;
	bh=3CH1W6qJmJfL4yT6igbmjALeD9E3Po0X8Rb/2RdRW5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fpJKN9jYtYr8fIXgM204zCyQB4wAMNwyfOelhHlxrdGGwV5Wam09FreXW73MX23hOg5QVCSaPHXe5WF5xEF4UbRDlz1LdV/opscRJGYg6I3M8qGO4bnUHxSYwnW/De99vhyAcruSeXarA8WNZHQz06fiwz0HujUtj/oST5U1YT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY6+4kf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY6+4kf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FE31F00893;
	Fri,  5 Jun 2026 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780653305;
	bh=Fd+kBbfP4MJf/mqa604B5g3u98emZGvj0hoveUl7waY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JY6+4kf1Hv8Q0M0+FTv0AG0UZVn6xHODxyzfXBI1hs5UfuYDPOvwUqwsc+IejABIt
	 LQO8He3+2/YZIm1ElCY3aa9EKeEZMZL6FsfBYHRhvC+KDRtCPxZ+jepmVdEssU5Val
	 51qSB9N30ZTqlUxIFsf6VszkGh63yiPruhtDcGXhtT+M2sY83H6WaHZQE00bDZFe5P
	 GnQJV9Vw6yP3CUhHbSCe15SAqZjmNmWZG5XiYeSkg2Km+CFjo2MkVf+9LfiS+oQG67
	 pwup3RAWLpFqKZs9Heb9uHXhd/6s8OKWXyD8kgP4MuD+FTKm8U64+d7Uzzn2npVGrX
	 yOgc7Aybp+Uow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: forward LAPIC ICR writes to userspace
Reply-To: sashiko-reviews@lists.linux.dev
To: muliang.shou <muliang.shou@sjtu.edu.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260605093857.747735-3-muliang.shou@sjtu.edu.cn>
References: <20260605093857.747735-3-muliang.shou@sjtu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 09:55:05 +0000
Message-Id: <20260605095505.96FE31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Unconditional introduction of a new KVM exit reason (KVM_EXIT_DSM_=
SEND_IRQ) breaks legacy userspace VMMs.
- [High] The DSM IRQ forwarding logic misses writes to the APIC ICR when AP=
ICv is enabled or when the guest uses x2APIC mode, and its x2APIC check in =
MMIO is dead code.
- [High] UAPI header definitions are hidden behind a kernel CONFIG_ macro, =
making them invisible to userspace.
- [Medium] Intercepting and exiting on APIC_ICR2 writes causes a completely=
 redundant and disruptive VM-Exit.
- [Low] The variable `dsm_irq_forward_pending` is dead state that is writte=
n but never read.
--

commit 03639fcc9ef5482e6e522d1abf6a49009f2c78da
Author: muliang.shou <muliang.shou@sjtu.edu.cn>

KVM: x86: forward LAPIC ICR writes to userspace

This commit intercepts LAPIC ICR/ICR2 MMIO writes and records the
forwarding payload. It then introduces a new exit reason to return
this data to userspace when the pending request is processed.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4078e624ca667..2485d50b45647 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
[ ... ]
> @@ -2583,6 +2587,32 @@ static int apic_mmio_write(struct kvm_vcpu *vcpu, =
struct kvm_io_device *this,
> =20
>  	val =3D *(u32*)data;
> =20
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +	reg =3D offset & 0xff0;
> +	if (reg =3D=3D APIC_ICR || reg =3D=3D APIC_ICR2) {

[Severity: Medium]
Does exiting on APIC_ICR2 writes cause unnecessary VM-Exits? Since writes to
APIC_ICR2 only set the destination ID without triggering an IPI, and KVM
natively caches this value, could we avoid the redundant VM-Exit here?

> +		kvm_lapic_reg_write(apic, reg, val);
> +		if (reg =3D=3D APIC_ICR) {
> +			if (apic_x2apic_mode(apic)) {

[Severity: High]
Is this x2APIC check unreachable code? Looking earlier in apic_mmio_write(),
the function returns early if apic_x2apic_mode(apic) is true:

    if (!kvm_apic_hw_enabled(apic) || apic_x2apic_mode(apic)) {
        if (!kvm_check_has_quirk(vcpu->kvm,
                                 KVM_X86_QUIRK_LAPIC_MMIO_HOLE))
            return -EOPNOTSUPP;
        return 0;
    }

Additionally, since apic_mmio_write() is bypassed for x2APIC MSRs and when
APICv is enabled, will modern guests using x2APIC or hardware acceleration
fail to forward IPIs?

> +				dest_id =3D kvm_lapic_get_reg(apic, APIC_ICR2);
> +			} else {
> +				dest_id =3D kvm_lapic_get_reg(apic, APIC_ICR2);
> +				dest_id =3D GET_XAPIC_DEST_FIELD(dest_id);
> +			}
> +		} else {
> +			dest_id =3D GET_XAPIC_DEST_FIELD(val);
> +		}
> +
> +		vcpu->arch.dsm_irq_forward_pending =3D true;

[Severity: Low]
Is this dsm_irq_forward_pending state ever read? It appears to be set to
true here and cleared to false in vcpu_enter_guest(), but control flow
relies entirely on the KVM_REQ_DSM_IRQ_FORWARD bit instead.

> +		vcpu->arch.dsm_irq_forward_reg =3D reg;
> +		vcpu->arch.dsm_irq_forward_val =3D val;
> +		vcpu->arch.dsm_irq_forward_dest_id =3D dest_id;
> +
> +		kvm_make_request(KVM_REQ_DSM_IRQ_FORWARD, vcpu);

[Severity: High]
Does unconditionally making this request break legacy userspace VMMs?

Because this introduces a new guest-visible behavior and exit reason
(KVM_EXIT_DSM_SEND_IRQ) without a per-VM capability check, VMMs that do
not expect this exit reason might crash when a guest sends an IPI.

Could this feature be guarded by a per-VM capability instead of a
compile-time macro?

> +
> +		return 0;
> +	}
> +#endif
> +
>  	kvm_lapic_reg_write(apic, offset & 0xff0, val);
> =20
>  	return 0;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a5e09bf431cee..8e484a7230bdf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -11324,6 +11324,20 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcp=
u)
>  				goto out;
>  			}
>  		}
> +#ifdef CONFIG_KVM_DSM_IRQ_FORWARD
> +		if (kvm_check_request(KVM_REQ_DSM_IRQ_FORWARD, vcpu)) {
> +			vcpu->run->exit_reason =3D KVM_EXIT_DSM_SEND_IRQ;

[Severity: High]
Are the new UAPI constants like KVM_EXIT_DSM_SEND_IRQ hidden from userspace?

If they are defined within a kernel CONFIG_KVM_DSM_IRQ_FORWARD block in the
uapi headers, userspace applications will not be able to see them because
kernel config macros are stripped during headers_install.

> +			vcpu->run->lapic_irq.id =3D vcpu->vcpu_id;
> +			vcpu->run->lapic_irq.val =3D vcpu->arch.dsm_irq_forward_reg;
> +			vcpu->run->lapic_irq.val2 =3D vcpu->arch.dsm_irq_forward_val;
> +			vcpu->run->lapic_irq.dest_id =3D vcpu->arch.dsm_irq_forward_dest_id;
> +
> +			vcpu->arch.dsm_irq_forward_pending =3D false;
> +
> +			r =3D 0;
> +			goto out;
> +		}
> +#endif
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605093857.7477=
35-1-muliang.shou@sjtu.edu.cn?part=3D2
