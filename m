Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786F1A682E
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053619; cv=none; b=rfuFvjOqLPZ24kr1T/AxkK3udAx1KJuMf4k+1pb2uGcdjopeTP4ak6faz27/7YiMnDw7y0BgtJNX+MkLH75hAvgY+PHHCZoDB4u/572Azo8jZ8IxBunqUv6CIsIKsYiG9PFTkjHG/2q4I8z4zYglkswk+fqgYZHpXpc2L3vP/SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053619; c=relaxed/simple;
	bh=Spxypcdm6omH0qy0Gi8LAGb6cZtqe11+51rYF1CvgWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=heIcMal+fHDOXoVzQv7ZIYA7dNO2giKgOcSz9ndOStZ92PvfDVoBKNtR87Rh6JXfL8+lgMfz/0Bjvqz0Xnywu0BkIN09+3FiKKhCSJ4MShF1FIpgpfZC5nUHlI7j7KulIBA1yEJzQiOT9mkkgjBte+znnomuY1TD9rpwbMDOs9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvBE4Rik; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvBE4Rik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0501F00898;
	Wed, 10 Jun 2026 01:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053618;
	bh=aHPQEsjKm/6T5JBEL97APcIfZZAYV8cQYH0qmdMia5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvBE4Rikczlx0m7EXO0zicWWvokpJPmQGB6zidjdcYKa1E8p7znTz1WNpPQIlz1xE
	 HKeWmWSs88y/4Q73XcWs2mRjHGcagrp02nRW7+7tZLtf0ZCo6SeFSRK66as/dSzARg
	 E/7T/Kc3oV5Wd533sXHu89k9uoAQKniZrSMOjkA/BcVTr3XSDQmr3SdxjtHTbihFwf
	 vap6OltDCXN/Pfol2Jd50FdXIT0izxkvItEAJuiIyP7aigLcDXa6V1MOg4u4QxDuvY
	 OqsFwkU/H6VGnHxVcAOQ3XnvKzzfjh1NsGyiO+lIlMiDmbsylO7jhymu4caTXdvo5f
	 OnEDgOmX+qCWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/18] KVM: selftests: Verify interrupts are received
 when IRQ affinity changes in IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260610005338.2967132-10-seanjc@google.com>
References: <20260610005338.2967132-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 01:06:57 +0000
Message-Id: <20260610010658.1E0501F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Using get_nprocs() to generate a random CPU ID for IRQ affinity =
can produce offline or non-existent CPU IDs, leading to test crashes.
- [Medium] The test picks `gsi` and `vector` using an unseeded RNG state, m=
aking the selections completely deterministic across runs.
- [Low] The `irq_cpu` variable is used uninitialized in a TEST_ASSERT messa=
ge when the test is run with `-d` but without `-a`.
--

commit 49ffc3d4b49fbef72ecbe743669ae8e39951edb2
Author: David Matlack <dmatlack@google.com>

KVM: selftests: Verify interrupts are received when IRQ affinity changes in=
 IRQ test

This commit extends the eventfd IRQ test with a '-a' flag to randomly
affinitize the device's host IRQ to different physical CPUs. This stresses
the kernel's ability to maintain correct interrupt routing and delivery
during dynamic affinity changes.

> diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selft=
ests/kvm/irq_test.c
> index 6888be54ee4a9..9e22874902628 100644
> --- a/tools/testing/selftests/kvm/irq_test.c
> +++ b/tools/testing/selftests/kvm/irq_test.c
[ ... ]
> @@ -160,10 +163,13 @@ int main(int argc, char **argv)
>  	int i, j, c, msix, eventfd;
>  	struct iommu *iommu;
>  	struct kvm_vm *vm;
> -	int irq;
> +	int irq, irq_cpu;

[Severity: Medium]
Does this test pick gsi and vector using an unseeded rng state?

At the beginning of main(), kvm_random_u64_in_range() is called with kvm_rn=
g.
Because kvm_rng is in BSS, its seed is 0. The actual RNG initialization
happens later during vm_create_with_vcpus(). This means the initial
randomization will predictably return the minimum bounds (24 for gsi and
32 for vector), defeating the intended coverage.

[ ... ]
> @@ -192,7 +198,12 @@ int main(int argc, char **argv)
>  		printf("Using device %s MSI-X[%d] (IRQ-%u)\n", device_bdf, msix,
>  		       irq);
>  	} else {
> +		TEST_ASSERT(!irq_affinity,
> +			    "Setting IRQ affinity (-a) requires a backing device (-d)");
> +
>  		eventfd =3D kvm_new_eventfd();
> +		irq =3D -1;
> +		irq_cpu =3D -1;
>  	}

[Severity: Low]
Is irq_cpu used uninitialized here when the test is run with -d but without=
 -a?

When a backing device is specified (-d), the code enters the if (device_bdf)
block and irq_cpu remains uninitialized. If a vCPU times out waiting for an
interrupt, the TEST_ASSERT macro evaluates and passes the uninitialized
irq_cpu to the variadic format string, printing garbage values.

[ ... ]
> @@ -216,6 +227,11 @@ int main(int argc, char **argv)
> =20
>  		kvm_route_msi(vm, gsi, vcpu, vector);
> =20
> +		if (irq_affinity) {
> +			irq_cpu =3D kvm_random_u64(&kvm_rng) % get_nprocs();
> +			proc_irq_set_smp_affinity(irq, irq_cpu);
> +		}

[Severity: Medium]
Can get_nprocs() produce offline or non-existent CPU IDs, leading to test
crashes?

get_nprocs() returns the total number of currently online processors, not t=
he
maximum CPU ID. In systems with sparse CPU topologies or offline CPUs (e.g.,
CPUs 0, 2, 3 online; CPU 1 offline), get_nprocs() returns 3.

The modulo calculation will produce indices from 0 to 2. If it produces 1, =
the
test writes '1' to /proc/irq/<irq>/smp_affinity_list. This will fail with
-EINVAL because CPU 1 is offline, triggering a spurious test failure via
TEST_ASSERT(r > 0) in proc_irq_set_smp_affinity().

[ ... ]
> @@ -229,8 +245,8 @@ int main(int argc, char **argv)
>  			cpu_relax();
> =20
>  		TEST_ASSERT(GUEST_RECEIVED_IRQ(vcpu),
> -			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d\n",
> -			    vcpu->id, vector, gsi);
> +			    "vCPU %d timed out waiting for IRQ (vector 0x%x) from GSI %d (via=
 CPU %d)\n",
> +			    vcpu->id, vector, gsi, irq_cpu);
> =20
>  		WRITE_AND_SYNC_TO_GUEST(vm, guest_received_irq[vcpu->id], false);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610005338.2967=
132-1-seanjc@google.com?part=3D9
