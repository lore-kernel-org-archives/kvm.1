Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0128504F
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427817; cv=none; b=CVMrBsaV2CEcbbKz1KptGlcnpiSJ9gAWeOwprgWOcpscdSqGy8coLNWzO+l9eVuci+O8bsKKTWRw0MKa1bgMzxvvKrfRFS+oiXvI4FvnrTiu+uohsziEAl4zG1D2nLwMZkhKnl+cb//HRn6FX2UC70MLE9UXt+sNHO/3rOuVg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427817; c=relaxed/simple;
	bh=P7ZT0SKoPr4TdU6S8E8ItBWBNGG60KKrhpAWYSYi8ck=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SNMInqKHCvdNsElY8BNR1GpieHCXOYO6VswFK9ETaTWgTQb7Eyu3fL6oTUCtqO8SypVR9PNw4idRS+TM08jkDvmeP14BdSyYK3E6BDFe1CP/567i+q3635mEGHOtJBss0r3xlBJWQz4XZVFj2Fn5JetSYOkdYl3q+R7BmzrJ1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsdEPYu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsdEPYu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8C81F000E9;
	Thu, 25 Jun 2026 22:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782427816;
	bh=ckZAJMiP+DlOB7S4y//DFQmHXTuRsDWY60fSmnLp67s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KsdEPYu3t+MfmL7qiHCD2pwhVk2JFFj1NK6vwfQDc3/Sty0HCwHj4Ryl/vvKZH4D2
	 jI0DcJ6slUO2m+QyZ7pinNE6LBq0DiRFn8yatKbz9/ZyqeMJvUHJTTrJM0Qc8Jnfdz
	 PB6Nb8oxQ7yotUh9Pxm3Fg2Cn+scbV+Yuj5rfReOj08zJipE5v5Ti6hbWrWI9hF/Tc
	 wROABUeOzpDQ3p5G+7Z0QJEmJsEDbIHeU4ucYnCHviDEYjUDi48NUCf94Heemn2lbl
	 LUPpxpW9h+FfvT3oKI2hd4iJ6UXGW/7PbsrUnqqAYgVDJ3JeLjGVN8+kvyBFNbnnS9
	 BdaEcBrxc6opA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] KVM: x86/hyperv: Assert vCPU's mutex is held
 in to_hv_vcpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625223623.3376478-10-seanjc@google.com>
References: <20260625223623.3376478-1-seanjc@google.com>
 <20260625223623.3376478-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:50:15 +0000
Message-Id: <20260625225016.3C8C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] False-positive lockdep assertion failure during vCPU creation erro=
r path.
--

commit 8e755f55a40a2714aef28c3ce64f3c13f28ac85e
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/hyperv: Assert vCPU's mutex is held in to_hv_vcpu()

This commit adds an assertion to verify that either the vCPU's mutex is held
or the VM is unreachable when using to_hv_vcpu(). It also open-codes access=
es
in the Synthetic Timer callbacks to avoid false positives.

[ ... ]

> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index ea9c81d76dd38..37a0bcf03e281 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -76,6 +76,8 @@ static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struc=
t kvm_vcpu *vcpu)
> =20
>  static inline struct kvm_vcpu_hv *to_hv_vcpu(struct kvm_vcpu *vcpu)
>  {
> +	kvm_lockdep_assert_vcpu_is_locked_or_unreachable(vcpu);

[Severity: High]
Can this assertion trigger a false positive on the vCPU creation error path?

If create_vcpu_fd() fails in kvm_vm_ioctl_create_vcpu() (for example, if an
unprivileged user space process exhausts its file descriptors), the kernel
takes the error path:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
    ...
kvm_put_xa_erase:
    mutex_unlock(&vcpu->mutex);
    kvm_put_kvm_no_destroy(kvm);
    xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
unlock_vcpu_destroy:
    ...
    kvm_arch_vcpu_destroy(vcpu);
}

Since vcpu->vcpu_idx is not reset to -1 before calling kvm_arch_vcpu_destro=
y(),
the subsequent call chain of kvm_arch_vcpu_destroy() -> kvm_hv_vcpu_uninit(=
) ->
to_hv_vcpu() will evaluate vcpu->vcpu_idx >=3D 0.

With the mutex unlocked and users_count > 0, wouldn't this cause the lockdep
assertion to fail, leading to a kernel warning or panic if panic_on_warn is
enabled?

> +
>  	return vcpu->arch.hyperv;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625223623.3376=
478-1-seanjc@google.com?part=3D9
