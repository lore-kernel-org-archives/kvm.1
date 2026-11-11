Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380761;
	b=CoTQ23nydlwXgUTedf0nbpU2EoeQRVfADeuRfYjBMZWkcmRveeVyqJjCf/C01QMGAjDU
	 qubAtiX3CFStNUliJAV055/Coboyri55kUT4SLXGFSWx3N4zeNL51Rgbow49P0BoZc413
	 sWJC/QwFAbhM5rsPhc3KCSyphAa/qwdI78IVT26cRng6A6UnNbodlQaNlhYERZhMqHNLQ
	 8tcQYxQJ6RBfMGjMoh2MhVjT5hd06AzYaUrusEEtAz/HNpnNhYX/J1YjnC4LI9CmMJhE7
	 RuF7iEo0JoWeocisEtfQM+d3S7cBlfhAC3PVLu6hgFUr828YmYwBK+AtCrS3gOeieBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380761;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=up0JdiB5n9SroiBNejK/lvU9Z0Dv/KHd3jE+Q0sTkSQ=;
	b=xoBtgzIdj0O42ES5R9M/KIveB9spYEzLglUfysWziXd+2vfN/HSj3A6C68o+6Xn+TrF8
	 jvK5uuVOXIZL71bKotq+xt2yaS592Sjlv3SsG5C/+q7aiI3FBHf6HIOAA83Z/p/L2590x
	 6gkWsbATNZIvynvnCnigQlwsFK869ipkcnaleHW7df1KVv6NZ6efbMzsLzUm6X4LW8g0K
	 MV4DbFf8Ild60xqZyTjwp/aS6mYagAPZ7ciQq/KoCePC/7ZMp/kRBQp7jWM9B0jvMwf/N
	 0PdZOpRJKkQdnCMOia+m84fJ32yX/zfZOzmbrXa4dd273WhmHedWIjqXi2ZuZmAav5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVAkZFsM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A935C606A326
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IVAkZFsM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196771F00A08;
	Wed, 11 Nov 2026 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794380761;
	bh=up0JdiB5n9SroiBNejK/lvU9Z0Dv/KHd3jE+Q0sTkSQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IVAkZFsMoVahCYfZhKmCjXdAv922nMc+SJJlmQGuldiaotQ/JR+/u5ZdQ/UXWw1xz
	 GDA8yuwxJkDF+XbgquTanXgC5o71wWFl6epb/dk8MS0KwA0mX7TdpB/MsA6/HKqlH7
	 o+Q18XT5MDpkMHcBr+r1/LQHVHzqXiK277Je9XJgQMFDCeJFm2xystuwJarA4Wodw1
	 Ieo2PfqQ+OEW1i8q1oKnn8skZWoWI+v1/hhN7O4LOjW7i/X9HsXr5EQQgeUYbbZicT
	 eIdlOR46sIOIcmWiL5uOSEe7FiRHNltnH+luafk3gEXwgomlUi9VNehtXfTNBqQ/Wr
	 Vh0w2KfvAQ9Dg==
Message-ID: <sashiko-outbox-208489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261111064242.29336-8-sarunkod@amd.com>
References: <20261111064242.29336-1-sarunkod@amd.com>
 <20261111064242.29336-8-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 07:06:00 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] iommu/amd: enable_iommus_vapic() leaves amd_iommu_gappi true
  on early return
--

commit c24e6331ec8e811c471b1e85ddce5dfb41ecad29
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Provide kernel command line option to enable GAPPI

This commit adds the amd_iommu=3Dgappi kernel command-line option to enable
GAPPI when the IOMMU GAPPISup extended feature bit is supported, and
documents the option and mechanism.

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 054ef7262f3cc..6a248327047ac 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c

[ ... ]

> @@ -3131,18 +3141,27 @@ static void enable_iommus_vapic(void)
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
>  		return;
> =20
> +	if (amd_iommu_gappi &&
> +	    !(check_feature(FEATURE_GAPPI) &&
> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
> +		pr_warn("GAPPI is not supported.\n");
> +		amd_iommu_gappi =3D false;
> +	}

[Severity: Medium]
Does the early return when !AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)
make the AMD_IOMMU_GUEST_IR_VAPIC() check right below it unreachable when
false and leave amd_iommu_gappi set to true?

parse_amd_iommu_options() sets amd_iommu_gappi =3D true before Virtual APIC
support is validated.  If the kernel is booted with amd_iommu=3Dgappi and
IOMMU Virtual APIC is disabled or downgraded (for example with
amd_iommu_intr=3Dlegacy or when check_vapic_support() falls back to legacy
GA mode), enable_iommus_vapic() returns before clearing amd_iommu_gappi
(and likewise if the IOMMU is disabled or fails to initialize).

When CPU AVIC is active in KVM SVM, avic_update_iommu_vcpu_affinity() and
avic_vcpu_free() check amd_iommu_gappi before checking whether the vCPU
has any IOMMU IRTEs:

arch/x86/kvm/svm/avic.c:avic_update_iommu_vcpu_affinity() {
	...
	if (!amd_iommu_gappi)
		goto skip_wakeup_handler;
	...
	if (is_running) {
		kvm_pi_disable_wakeup_handler(vcpu, svm->gappi_cpu);
		svm->gappi_cpu =3D cpu;
	} else {
		apicid =3D cpu_physical_id(svm->gappi_cpu);
		kvm_pi_enable_wakeup_handler(vcpu, svm->gappi_cpu);
	}

skip_wakeup_handler:
	if (list_empty(&svm->ir_list))
		return;
	...
}

Leaving amd_iommu_gappi set to true when CONTROL_GAPPI_EN is not enabled
causes KVM to register and unregister per-CPU wakeup handlers on every
vCPU load, put, block, and free even though IOMMU Virtual APIC is not in
use.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111064242.2933=
6-1-sarunkod@amd.com?part=3D7
