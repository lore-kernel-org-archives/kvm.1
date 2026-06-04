Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6040635674E
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539689; cv=none; b=u7uYsC+dexweNWweAV0NI+rQ4qX3MZpIFMYLGBzNUaLf7N1QwszMon76yJklvid35ahA9YOe/V9cv0/EEEXe4gWQB0rPS00W9NhkNooRwRXtQwhV4Xn1eiC8sqJXbxqQmvbzNyKMaSAC9KS+8/nGkxE/mRiNrbl+/6TfIv+Y9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539689; c=relaxed/simple;
	bh=N8n2wOMH1B1jDFXhHJb7vnWHUGZJ0uSVqNxOc0Em2Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvtbKf1hm06cLXft5OCmAOJJUWturIvt38nHzNwb4rpWF4MBb8tiYdHvnDGQEEHUJJBcDPcjP9zNHdqToQcW74czj9nhtpXkGJRkzhZwRbJgLeDY/X2qSNTYT1o98V+O7LhyTKe8iGOHpxQIn0uD3hSxtodE6hrgLPoL1ShAGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMxrVw+a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMxrVw+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29011F00893;
	Thu,  4 Jun 2026 02:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539685;
	bh=TGzRYSkPoS/WYq42oTMynailrjOdWQgZCKfCWe7hOZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMxrVw+aLetIW1mtzEap/CyfknZsvG9r1cpPBtp//kTn3rcoI5jZSJ5xATP0dSLz1
	 6sS1FTiAz3PFaEqfoIm/+gvq8+nN9AvWFU1TfKd5nxprL1MPtjTCoZmGPsqyUoKDqE
	 EPgASFvD2qc3CFtb/8J/NM3DuGD8/+Bt3OsrsQ2/qlK7H4aLRR2VSKi0pNvTUSEyvl
	 FLSIk91dTPiC2GmklXkqBnZp4UChIxQGKlsoBC63TKHerkE5w2rprveYhBwWyxypTZ
	 43L5dQ0HLm3WpvRQM0QlbMV71c6HspFD51tCWil2GDAq/t8tqKOPRyZf0zbSdsH+6T
	 bCSci2sSRuNKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/21] KVM: selftests: Print vCPU affinity on timeout
 during IRQ test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Josh Hilke" <jrhilke@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604020143.748245-20-jrhilke@google.com>
References: <20260604020143.748245-20-jrhilke@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:21:25 +0000
Message-Id: <20260604022125.A29011F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm_print_vcpu_affinity() uses get_nprocs() as the loop boundary=
, which silently truncates CPUs with indices >=3D get_nprocs() on sparse to=
pologies.
--

commit 9e2355f47489ee5cf4674888f5c4b7d1058bc869
Author: Josh Hilke <jrhilke@google.com>

KVM: selftests: Print vCPU affinity on timeout during IRQ test

Adds a helper function to print the physical CPU affinity of a vCPU thread=
=20
in a human-readable format. Uses this new helper in the irq_test to provide=
=20
context when a vCPU times out waiting for an interrupt during migration.

> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/s=
elftests/kvm/lib/kvm_util.c
> index e538e6147ec3f..7fc3aaf763797 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c

[ ... ]

> @@ -662,6 +663,54 @@ void kvm_print_vcpu_pinning_help(void)
>  	       "     (default: no pinning)\n", name, name);
>  }
> =20
> +void kvm_print_vcpu_affinity(struct kvm_vcpu *vcpu, pid_t tid)
> +{
> +	int nprocs =3D get_nprocs();
> +	bool first_range =3D true;
> +	int i, start =3D -1;
> +	cpu_set_t cpus;
> +
> +	kvm_sched_getaffinity(tid, sizeof(cpus), &cpus);
> +
> +	/*
> +	 * Output format examples:
> +	 * - Single CPU:  "vCPU 0 (TID 1234) affined to pCPU(s): 2"
> +	 * - List:        "vCPU 0 (TID 1234) affined to pCPU(s): 0,2,4"
> +	 * - Range:       "vCPU 0 (TID 1234) affined to pCPU(s): 0-7"
> +	 * - Mixed:       "vCPU 0 (TID 1234) affined to pCPU(s): 0-3,8,10-12"
> +	 */
> +	printf("vCPU %u (TID %d) affined to pCPU(s): ", vcpu->id, tid);
> +
> +	for (i =3D 0; i <=3D nprocs; i++) {
> +		/*
> +		 * Iterate to nprocs (inclusive) to ensure that if the last pCPU
> +		 * is part of a range, the 'else' block triggers one final time
> +		 * to flush that range to stdout.
> +		 */
> +		if (i < nprocs && CPU_ISSET(i, &cpus)) {

[Severity: Medium]
Does using get_nprocs() as the loop boundary risk silently truncating CPUs=
=20
on sparse topologies?

get_nprocs() returns the count of currently online CPUs, not the maximum=20
CPU ID. If a system has 4 online CPUs but their IDs are 0, 1, 2, and 7,=20
get_nprocs() will return 4.

This would cause the loop to terminate prematurely, completely ignoring=20
valid but higher-numbered CPU indices (like CPU 7) in the cpu_set_t mask.

Should this iterate up to CPU_SETSIZE instead to encompass the entire mask=
=20
capacity, similar to other helper functions like pin_task_to_random_cpu()?

> +			if (start =3D=3D -1)
> +				start =3D i;
> +			continue;
> +		}
> +
> +		if (start !=3D -1) {
> +			int end =3D i - 1;
> +
> +			if (!first_range)
> +				printf(",");
> +
> +			if (start =3D=3D end)
> +				printf("%d", start);
> +			else
> +				printf("%d-%d", start, end);
> +
> +			start =3D -1;
> +			first_range =3D false;
> +		}
> +	}
> +	printf("\n");
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604020143.7482=
45-1-jrhilke@google.com?part=3D19
