Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DD14B08A
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 02:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367214; cv=none; b=ihFdJbwS6vfkVaUGd1HxeOA65/uqnSJlt2a2uv0JBodTL8J2J1ItxB/5gCklsW0iERshSKgrjc5hoUHVZRiCM1hJA7xM1YguIki4f5kmpMHY17UdndHRbS/ZF+hRfALTojgJrjik+BdjVpA8oxmRgyhCE4l2x7p5x2Ew0j6+Z1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367214; c=relaxed/simple;
	bh=cbaS8XGOxcWOC5J26p5mqsH3nd+/CLWTrWq511fi1YA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eYX/PXAo71BXaqHpPMEqGL4ltx5ysiUZMY1tTZDl0rwlDWEp+LJ/N/sZVEpEBf22ApZjbBzPJFv6nr13cs8sJKkzDQY3FXj3xKr6GLQNJFiJeXMOek/iaeyqQZ8TDzkJ0A9mIYmebe0+kKLBgqfL85LFYEPlAtmViG4u2DniFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGtYabC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGtYabC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2DBF1F00893;
	Tue,  2 Jun 2026 02:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367212;
	bh=v2detW87c43lAX5u4lHEK53rrEXzUc03NTPSTGV1cyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UGtYabC6ymPylV1LvbjIpF0xQ5MCkyXJBDS533hs5fPilvWLjHLJxDZPZnaD03QKK
	 cPDgeEMXQq/zRRw5whPn0BkO+629KRLris44cUAfevGQt/10Rx2KPkJLwJ+pygC7i9
	 5gvHDQ4SnWOW8CcqFoiI2GVrQ52REEORUPrH8+uNI0ze5F2HxqDCvYnYUxsvlsmYu3
	 t8td8LglixRd3/HFTi6hbgctnsi3qkbaTeIq8aJEVvkv3oacM3XQjhEjQfuPghb/ep
	 jIwp2hBmndksqgnpCWAvBTM+g31Iv03hiJrFM8ZwQgF8auUHc/CU6H6FpuGCYdy+Ln
	 U2gBTLxqwUV7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] LoongArch: KVM: Preserve auto-enabled PV
 features on userspace override
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602021819.2373404-2-cui.tao@linux.dev>
References: <20260602021819.2373404-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 02:26:52 +0000
Message-Id: <20260602022652.B2DBF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch unconditionally forces auto-enabled PV features ON, prev=
enting userspace from disabling them, which breaks VM capability negotiatio=
n and live migration.
--

commit 2e3dfd10f9606ff82713655e6b87be567a31ec59
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: Preserve auto-enabled PV features on userspace override

This commit adds a pv_auto_features field to struct kvm_arch to save the
kernel-default PV features. It then alters kvm_loongarch_cpucfg_set_attr()
to automatically OR these saved features back into the user-provided feature
mask during KVM_SET_DEVICE_ATTR.

> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index e28084c49e682..47a59ce9e5616 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1165,6 +1165,13 @@ static int kvm_loongarch_cpucfg_set_attr(struct kv=
m_vcpu *vcpu,
>  		if (val & ~valid)
>  			return -EINVAL;
> =20
> +		/*
> +		 * Auto-enabled features (e.g. PV TLB flush) that userspace
> +		 * is not aware of are preserved so that no QEMU changes are
> +		 * needed for pure kernel-internal optimisations.
> +		 */
> +		val =3D (val | kvm->arch.pv_auto_features) & valid;

[Severity: High]
Does unconditionally forcing auto-enabled PV features on prevent userspace
from disabling them?

If a VMM configures a VM for migration to an older host that lacks features
like KVM_FEATURE_STEAL_TIME, it will clear the corresponding bits in the
feature mask.

By forcing these features back on even when userspace explicitly omitted
them, could this cause the guest to observe a feature set unsupported on
the migration destination, resulting in migration failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602021819.2373=
404-1-cui.tao@linux.dev?part=3D1
