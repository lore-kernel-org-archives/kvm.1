Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68331D730
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727353; cv=none; b=oH6IU3f5qEJjcCnGvI/azyG0AnMYtSpDWgNusN9Dx99zijV8q66SUL5NMP6RlQuMQ+u1AQG7xo7CEmBJhzj+pX3gBfbOvb4vk3V4pliTTxqodiK/7lMJY7pg4DpUHQhT2SufwF3eQMlqmhyE+fDBwMqF6JcBstZYI3Hbus+N6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727353; c=relaxed/simple;
	bh=BnAWdonHK+K6yOqDPYgJrtxQvgh0xPG6HMteCT+CSOE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FQ8Kh9NY0O83t5BmXLEPTHRHni9Rw5kyU4y8sUhhPN4ZREX2cbgx2pW/ZmiJr9/EsTNgsEbXv6LrwdG1yqlC0QS6dCVQDmmWep2ilw+jFSHokrdJplrAH04wsDKHNdEZMrxbPg4IoDj1JERjAEre2eBFZGcxw/DJmmn/vpif/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+lJMOZv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+lJMOZv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6791F000E9;
	Wed, 26 Aug 2026 06:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787727352;
	bh=DqVXudRtenvSO5P+Q8Bsf0Lgzq8rEMNlngabfYsRL/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+lJMOZv7k5kKATMQNzFB+WWTkTUUIFDB5+jR5nZKbJk8asxVkaxYeemAZjMG3Vuz
	 KoEt/g0PwWEr34Y9xadeSRuBz/CbsJUPmIERwitXpFjgfShjvAo2mYgmab5kJfQsJx
	 NPKr/SoS+vOZkOKBWvF5il1zwgBnzmn/jV2+t99Ds4pucVIcUe4ZTY4fqVOwIg3lS3
	 ODOVvP4Kr1oIMBW/eapel09L6WIDJ8dhTiVpZDMKNfMOeVAeIftbGCaTwq/Y8Ny1hx
	 uhiAr6utSq4JUZ6Veq8fOJ3so0UJ4gV1hAiKCK2dTlUeZwFnZOczrfZYGyP0Um0jTA
	 HgrkIOsTgO3EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Fix sdata leak and stale snapshot_addr in
 snapshot_set_shmem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zongmin Zhou" <min_halo@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826064117.58029-1-min_halo@163.com>
References: <20260826064117.58029-1-min_halo@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:55:51 +0000
Message-Id: <20260826065551.DC6791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Guest-triggerable `pr_warn` allows a malicious guest to spam the h=
ost kernel log.
--

commit 26a57cbd434dd543af868b0052521f7a8fda7faa
Author: Zongmin Zhou <zhouzongmin@kylinos.cn>

RISC-V: KVM: Fix sdata leak and stale snapshot_addr in snapshot_set_shmem

A guest may call SBI_PMU_SNAPSHOT_SET_SHMEM repeatedly. Each call overwrites
kvpmu->sdata without freeing the old buffer, and if a later guest write
fails, the error path frees sdata but leaves snapshot_addr stale. This
clears the previously installed snapshot area before installing a new one.

> diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
> index 752f1014d633e..14f73490f12cb 100644
> --- a/arch/riscv/kvm/vcpu_pmu.c
> +++ b/arch/riscv/kvm/vcpu_pmu.c
> @@ -454,6 +454,14 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm=
_vcpu *vcpu, unsigned long s
>  		}
>  	}
> =20
> +	/*
> +	 * Clear any previously installed snapshot area to avoid leaking
> +	 * the old sdata and to keep sdata/snapshot_addr consistent if
> +	 * the re-install fails below.
> +	 */
> +	if (kvpmu->snapshot_addr !=3D INVALID_GPA)
> +		kvm_pmu_clear_snapshot_area(vcpu);
> +
>  	kvpmu->sdata =3D kzalloc(snapshot_area_size, GFP_ATOMIC | __GFP_ACCOUNT=
);
>  	if (!kvpmu->sdata) {

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the PMU
snapshot code I noticed a pre-existing issue in the same file.

In kvm_riscv_vcpu_pmu_ctr_start(), a guest can intentionally trigger a host
kernel log spam if the shared memory becomes invalid:

        if (kvm_vcpu_read_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
                                sizeof(struct riscv_pmu_snapshot_data))) {
                pr_warn("Unable to read snapshot shared memory while starti=
ng counters\n");
                sbiret =3D SBI_ERR_FAILURE;
                goto out;
        }

Because this pr_warn() is unconditional and not rate-limited, a guest can
configure a valid snapshot area, invalidate the backing memory, and repeate=
dly
call SBI_EXT_PMU_COUNTER_START to spam the host log, leading to a denial of
service.

Should this pr_warn() be converted to a rate-limited print, or perhaps drop=
ped
since the error is already returned to the guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826064117.5802=
9-1-min_halo@163.com?part=3D1
