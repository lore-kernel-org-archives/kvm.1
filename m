Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792679008;
	b=SGaHh+j9lBZ42Xd4CsgK+67A+vJ0LOJ+W8wHYuGhsy3tOhUeyCguShZ3yufICTZ4VqwV
	 Fm+UWtq4ncohxqcnG6CuD5gW+MLs2otTdidMtCPTZYlKX0a0PBBqIPaKF3AqytqjpOU+W
	 U9kzVkhR8Cn5H6lrYz9Yt643gV4RkiP9fbJxMKdYp6NpnNC3aEXRbPqvIBXa3EDqppbSZ
	 c6CF28OfUjtm2yJaXNxU7gq4IU9jU9LnnSy9rdicjKnfhIZY198k5U4nqz5OpCc+Cdjr1
	 zIuoCv8bvee6VbHBxPBHsM1Na7584NXWVwAkHlQ4DnwomL83f1bMOyAVTzKwyrI2hyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+ovM2TRSVN35j+scs8YpmdtGbBYNNm/tASvNJTTpOiQ=;
	b=Ug4qp3TyYqyQncLqTbeqfBdwFGuWXDSDpDnY2C3l/GRaUwmS8Muf1JlZC8g3ZuC8Xm6F
	 3c0hZHGu4lrym9fe8GsmvCtajD5AZmLdr815hLWxTzAgkLv7Dy/OVwj2JUMz4SaJ2aQrj
	 cRjDqSfo9A3eJ4YWZYm1QMSwduH4WuulNjVvEE04sfE9vx9g+xQrOIIWVvq8lyW64XO24
	 H9HtKwLi6uBCfi6ZDGCvWVwxmGo+86EUP/0bcOoTGCpzGNk0f92wZddQwpQi4CBi0VoQK
	 OuJRB1zEUxhRcfpc2EjkhnG2rGVIEqp2ZpPgwzF6Wu2fxxSq6vObHM1Rnd59JF6taUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="n9L9Vas/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C504C606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9L9Vas/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E551F000C1;
	Thu, 22 Oct 2026 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679007;
	bh=+ovM2TRSVN35j+scs8YpmdtGbBYNNm/tASvNJTTpOiQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=n9L9Vas/7EClOTxH2UGabl98uk/8nQrS2NcFLBqhvVmee57fuhIbZ73LV8ezFLP1L
	 OneC6lDn9wO7zAhfW4Ds0sbBIs9pKYMJq11sZZWoOeXTJ4aTOuIPhmecP9Glem5FiB
	 s4yRVfFJZDVwI4P4zt3IEkVz/6pkZ8tg6Fbj6Q/8cQX9mDsIVlR7nlGw8xmQufcx1+
	 G66ghjY5G6D/gmgG/b+mHx/pC+EbN7vwfhi5OQMxHP4eF1x6amo8hcTxCRFPVAbmp1
	 oDbcvI4FBhE5sR/KVAAzK6QxxlKVMr/rlOPecSa5hmZ77aD4j40zYRJOBwIXX5Q2/G
	 XZyorvHaBFiyg==
Message-ID: <sashiko-outbox-181630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261022140425.27465-8-sarunkod@amd.com>
References: <20261022140425.27465-1-sarunkod@amd.com>
 <20261022140425.27465-8-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 14:23:26 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] iommu/amd: enable_iommus_vapic() leaves amd_iommu_gappi true on =
early return
--

commit 2f329c3e02b74f486082bc1f7b970f7b86fabe68
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Provide kernel command line option to enable GAPPI

This commit adds the amd_iommu=3Dgappi kernel command-line parameter to ena=
ble
GAPPI when the hardware supports FEATURE_GAPPI and Virtual APIC mode is
active, along with documentation for the new option.

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 78e3c14dc1c28..72394c92a3fa0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c

[ ... ]

> @@ -3027,10 +3037,19 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
> =20
> +	if (amd_iommu_gappi &&
> +	    !(check_feature(FEATURE_GAPPI) &&
> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
> +		pr_warn("GAPPI is not supported.\n");
> +		amd_iommu_gappi =3D false;
> +	}

[Severity: Medium]
In drivers/iommu/amd/init.c, parse_amd_iommu_options() sets the exported
global amd_iommu_gappi to true during early boot when amd_iommu=3Dgappi is
passed on the command line (with CONFIG_IRQ_REMAP enabled):

drivers/iommu/amd/init.c:parse_amd_iommu_options() {
	...
	} else if (strncmp(str, "gappi", 5) =3D=3D 0) {
#ifdef CONFIG_IRQ_REMAP
		amd_iommu_gappi =3D true;
#else
		pr_warn("amd_iommu=3Dgappi ignored, IRQ remapping is not enabled\n");
#endif
	}
	...
}

However, earlier in enable_iommus_vapic(), all paths where Virtual APIC mode
is not enabled or gets downgraded to legacy GA mode return before reaching
this check:

drivers/iommu/amd/init.c:enable_iommus_vapic() {
	...
	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
		return;

	if (!check_feature(FEATURE_GAM_VAPIC)) {
		amd_iommu_guest_ir =3D AMD_IOMMU_GUEST_IR_LEGACY_GA;
		return;
	}

	if (amd_iommu_snp_en &&
	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
		pr_warn("Force to disable Virtual APIC due to SNP\n");
		amd_iommu_guest_ir =3D AMD_IOMMU_GUEST_IR_LEGACY_GA;
		return;
	}
	...
}

Doesn't this mean AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) is always tr=
ue
when this check is reached, leaving amd_iommu_gappi set to true whenever
enable_iommus_vapic() returns early (including on the
MMIO_STATUS_GALOG_RUN_MASK poll timeout) or is never called because the
IOMMU is disabled?

When amd_iommu_gappi remains true while IOMMU Virtual APIC and
CONTROL_GAPPI_EN are not enabled, avic_update_iommu_vcpu_affinity() and
avic_vcpu_free() in arch/x86/kvm/svm/avic.c still see amd_iommu_gappi set
before checking list_empty(&svm->ir_list):

arch/x86/kvm/svm/avic.c:avic_update_iommu_vcpu_affinity() {
	...
	if (amd_iommu_gappi && is_running) {
		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
		svm->gappi_cpu =3D cpu; /* Store cpu number as target for GAPPI */
	} else if (amd_iommu_gappi && wakeup_intr) {
		apicid =3D cpu_physical_id(svm->gappi_cpu);
		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
	}

	if (list_empty(&svm->ir_list))
		return 0;
	...
}

Wouldn't that cause KVM to unnecessarily call kvm_pi_enable_wakeup_handler()
and kvm_pi_disable_wakeup_handler() on every vCPU load, block, and free when
running guests with AVIC enabled?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022140425.2746=
5-1-sarunkod@amd.com?part=3D7
