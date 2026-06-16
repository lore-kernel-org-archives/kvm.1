Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5430F52B
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781571966; cv=none; b=Kt1ubhYeFj1n/+s33Hbn6C+LkaIh7exTjfJ34sXmWR3woMUeIB6rMm61oYhvInIaEcigUOUvZLk5/k4ju3sE2W6VAkkS0/XeYMhqKc+MvTv1PK7r2TL2iH0lavY5QefPAaiTZmq8mgeZtTBEiC+Lif0b/Sa892EZdtUy6W1WqAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781571966; c=relaxed/simple;
	bh=bQ17ANv9RSt2xYHOXE74URuaXR+v68zfwkyYGmZEUBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dezRxerBqVXTSWdaK558vKMnuMphDpPoeB0oS6nghdFbYlRn25jgL+Kf1E8H2jW9rinNflIQ2ktn/1T70FUBpeZPPzjgYefzHK7W1R3PmEdB3m5mk5WOj1vaf3tnOBeihPClQ6rhn2yB7kqThsLZ/CWo9pR/ShOuGmLpY+1y6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKgfJo+k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKgfJo+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC021F000E9;
	Tue, 16 Jun 2026 01:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781571964;
	bh=1fBA1/8t+/Hwa6NBtb+c8OPlhyAxEGE+79NosgP9aiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKgfJo+kruJjOGJWbyDhsA2TFmA8D7WMY1WOTJlmkfjl7yhdMxAe7rsow52NnJrlm
	 GAEeC411dXj+FxM81KvKleJmwRYa5Lxro0Bh5q9c7agmBR15u47+dF90Vqx6fxWjz0
	 uUGaNfmWMCin/PXxXwKB2upVoVrA4PK8+xn7XXsE21qyI2KGM8aaOy1yw3IOFdURrb
	 x/C0juHRcxzsOPYCkfdpIJvomAilWAO5RjzCiOFwey4vQ+8YmEFXQQtbPcyuyc4OsX
	 BpeLLRm3eU3uXtXaIYievVXImTZQtSDUghy3pUrYg5wmWt0PF2ZiJ81YQiulGQxv+8
	 QRtfkkxFm4rXQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 08/25] KVM: SEV: Stop using per-vCPU ASID for SEV
 VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260616004155.1435766-9-yosry@kernel.org>
References: <20260616004155.1435766-9-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 01:06:03 +0000
Message-Id: <20260616010604.ACC021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A malicious SEV guest or an unprivileged host-userspace process ca=
n trigger a host WARN_ON_ONCE by executing VMRUN (entering nested virtualiz=
ation) or via KVM_SET_NESTED_STATE.
--

commit c3ac1dbd3331e2991b6bd808b207ce3395a73130
Author: Yosry Ahmed <yosry@kernel.org>

KVM: SEV: Stop using per-vCPU ASID for SEV VMs

This commit updates KVM to initialize the SEV VM ASID once in
sev_init_vmcb() instead of checking and setting it on every vCPU run. It
replaces the run-time assignment check in pre_sev_run() with a warning.

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3555,10 +3555,7 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
>  	if (!cpumask_test_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus))
>  		cpumask_set_cpu(cpu, to_kvm_sev_info(kvm)->have_run_cpus);
> =20
> -	/* Assign the asid allocated with this SEV guest */
> -	svm->asid =3D asid;
> -
> -	if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> +	if (WARN_ON_ONCE(asid !=3D svm->vmcb->control.asid)) {

[Severity: High]
Can a malicious SEV guest or an unprivileged host-userspace process trigger
this warning by entering nested virtualization or via KVM_SET_NESTED_STATE?

KVM does not strictly prohibit userspace from exposing CPUID.SVM to an SEV
guest. If an SEV guest sets EFER.SVME and executes VMRUN, KVM intercepts it
and handles the nested transition via nested_svm_vmrun(), which switches the
active VMCB pointer to the nested vmcb02.

The nested vmcb02 does not inherit the SEV ASID assignment from
sev_init_vmcb(), and its control.asid is initialized separately. During the
subsequent svm_vcpu_run() -> pre_sev_run() call, the VM's valid SEV ASID wi=
ll
no longer match the nested vmcb02's ASID, causing this warning to trigger.

Since this condition is guest-reachable and controllable by userspace, does
this create a host denial of service vector when panic_on_warn is set?

>  		svm->vmcb->control.asid =3D asid;
>  		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616004155.1435=
766-1-yosry@kernel.org?part=3D8
