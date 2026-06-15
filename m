Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA93822A5
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512505; cv=none; b=hgPez7HArs5EHY6kRVo5kgvUmNlMTtCMjB1kLxbOB9R/eWZ5OHMcxCabyy4IwKQJtF+/1X9ixKPBRWq8iNEviYxtNKFYEf5Cklfi+ICUeZeag9tip3GvX1qtoByksYFmmnEIq7u938baltUxOX7VPPLVV0f/PgtwjUQ6yXvcpAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512505; c=relaxed/simple;
	bh=vGIorc/Za//p0L/MiyhAB/953yyDU+8DN4i7hvLmp1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k6eCbN0GrgWM76bp9nMtI+eI+yQOtbgThjFuchMmnRCC1t35v8RRO9ZZ6ew6IQY8bQpzUfBnQTNQJZsTlGglrew2gbifFj8KaPLVV+CzAWsXsdgZPprwmzP+uTZeRI41s0oeKITccs35RGJ+QimIQw9esVsIa74K+070Wvqkvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+bxIgty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+bxIgty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DD11F000E9;
	Mon, 15 Jun 2026 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512501;
	bh=L8SoVjmAyL45KZZ4WnNxBHq3/RHGNiPBBtA7lz1JNik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k+bxIgtyFGSxyT5k+h/f3zRhxVqNkr16w+fVcHnS01JY8qxRvgdAVQrpX7ToWeorv
	 q40Ti0/Y7VAUu/+CFHNSJamKw74fEdF6BvzOnvL3DBif9aWkQtho9BQbxSQqyEGdw8
	 VnJ6j6YlGeZgyUAkyLRM3ubWlrJcNTdncpDXVr6Z/XWfCcZu4X+INN9oxntbv+9O1T
	 tgADoAmBUpTeovbB3dVrw0J/6nVJ76vQjmeit/6xjZ1fgwtSGVkdf9NSu6hFh8/xjA
	 WDfd+YmiwPAyJIBCangY5F9+Er6zkpk5i79VNaiTkqm/3p+2dJ5YxhQAL0TddESB6d
	 G/rqilbAD5KuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] LoongArch: KVM: Add PV TLB flush support via
 steal-time shared memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260615082154.42144-2-cui.tao@linux.dev>
References: <20260615082154.42144-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 08:35:00 +0000
Message-Id: <20260615083501.44DD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KVM_FEATURE_PV_TLB_FLUSH is unconditionally enabled by default, br=
eaking capability negotiation and live migration.
--

commit f9022e883153b129074818c0b5b2ff53a144e2f5
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Add PV TLB flush support via steal-time shared memory

This commit implements paravirtualized TLB flushes for LoongArch guests usi=
ng
the preempted byte in the steal-time shared memory page. It introduces the
KVM_VCPU_FLUSH_TLB flag to avoid sending IPIs when the target vCPU is
currently preempted.

[ ... ]

> diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
> index 1317c718f896a..cfba45a7343c5 100644
> --- a/arch/loongarch/kvm/vm.c
> +++ b/arch/loongarch/kvm/vm.c
> @@ -54,8 +54,10 @@ static void kvm_vm_init_features(struct kvm *kvm)
>  	if (kvm_pvtime_supported()) {
>  		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PREEMPT);
>  		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_STEAL_TIME);
> +		kvm->arch.pv_features |=3D BIT(KVM_FEATURE_PV_TLB_FLUSH);
>  		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_PREEMPT);
>  		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_STEALTIME);
> +		kvm->arch.kvm_features |=3D BIT(KVM_LOONGARCH_VM_FEAT_PV_TLB_FLUSH);

[Severity: High]
Should this new guest-visible feature be disabled by default?

If a VM starts on a kernel with this feature enabled by default, the guest
will detect and use PV TLB flushes. If that VM is later live-migrated to an
older kernel that lacks PV TLB flush support, the destination host will
silently ignore the KVM_VCPU_FLUSH_TLB flag in the steal-time structure.

Could this lead to the guest assuming its TLB was flushed when it wasn't,
resulting in stale translations or memory corruption? Would it be safer to
require an explicit userspace capability enablement before exposing this
to the guest?

>  	}
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615082154.4214=
4-1-cui.tao@linux.dev?part=3D1
