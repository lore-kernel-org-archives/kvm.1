Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32E374735
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720404; cv=none; b=j0rDp6QkmtvejR5/MBXZPREJSzcR9gIbBaWgwiuzNcUSosWIZjppy9oUqCUv1TyhN5xxPcDPUax7L5/L6DZs458JbzP6EZ+qS1hR9W9z5+9m8x44uycE8OvtF+ogL/M74m0lyIYJ4YHAN74OOKPrQaLMk5fZCSqyITqMPFV9ELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720404; c=relaxed/simple;
	bh=Hbjti8u+oWvs7T6fv19RGRXEPJ7xE2Bor1ywKgEWzUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SdU7iSPIH1W+VzNKGR3obK+qqYh8eu43SWv8WZ9jZNfXFw6u/f1dpytIFGQJyWCpXCkfyVVM7ggTOa+jvFQ0QWgG056gOBFSD7V7c6nNbMYH+tR45TkHblMDQN05cppZbNo7SJK4kPLZqHV4XaWeXeZpxKz+xDKYS7jT2PHoay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOuBlkf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOuBlkf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87F11F000FF;
	Fri, 18 Sep 2026 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789720403;
	bh=DrLW+hUX8DlfnStNop1aIY0HVXlDSFXvOwgH2xu+i4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hOuBlkf1sEJVGmrmALlwICSdti5ck0dkq51jVUyFO2HJMWh4bwQcBmFI6WICWP5qV
	 kTRw3mT2JLtHtvFRTO+qY9z/IR0mogXfMqRpwsNhu63pX7wp9B3ieoFFw+emmaGD4d
	 mpSEmVpFY69JXPT3UgE0TZ693rfCFXvc0y6pClaDTIKeuPlUgwP+2DOXegSBIiQmV4
	 0ybrPfl4fTFf12bHb53glpD9ikJarDdzMUi+NX5fHKaatXlohJINIQ7sFMNEHr9Zeu
	 F7N8/+N/s9PgBqNCNZfWhQ0p+9NVvq4a8jORI03lwwJxxhP9wrVl8318bMB0sD5874
	 rdVWUbVA2yM2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/28] KVM: x86: Introduce memory fault on invalid
 hypercalls reads/writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918081543.139871-6-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
 <20260918081543.139871-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 08:33:22 +0000
Message-Id: <20260918083322.C87F11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] x86/hyperv: spurious memory fault on HVCALL_SIGNAL_EVENT due to do=
uble validation
--

commit 9e7f4342fa28fd49b13df88579465f8fb51e4a93
Author: Paolo Bonzini <pbonzini@redhat.com>
KVM: x86: Introduce memory fault on invalid hypercalls reads/writes

This commit allows userspace to perform arbitrary actions when a hypercall
refers to an invalid address, by exiting with KVM_EXIT_MEMORY_FAULT.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 604651cb27399..9f5adcd26cba3 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2547,11 +2617,30 @@ static bool hv_check_hypercall_access(struct kvm_=
vcpu_hv *hv_vcpu, u16 code)
>  	return true;
>  }
> =20
> +static int kvm_hv_hypercall_userspace_exit(struct kvm_vcpu *vcpu,
> +					   struct kvm_hv_hcall *hc)
> +{
> +	int r;
> +
> +	r =3D kvm_hv_hypercall_check_params(vcpu, hc);
> +	if (r)
> +		return r;

[Severity: High]
Does this code perform a physical memory validation on hc->ingpa, which has
already been overwritten with the connection ID for slow hypercalls?

When a guest makes a slow HVCALL_SIGNAL_EVENT hypercall with a connection ID
that is valid in userspace but not registered in the kernel conn_to_evt,
kvm_hvcall_signal_event() reads the connection ID and overwrites hc->ingpa:

kvm_hvcall_signal_event() {
	if (unlikely(!hc->fast)) {
		...
		ret =3D kvm_vcpu_read_guest(vcpu, gpa,
					  &hc->ingpa, sizeof(hc->ingpa));
	...
}

It then returns HV_STATUS_INVALID_PORT_ID, and the switch statement in
kvm_hv_hypercall() falls through to HVCALL_POST_MESSAGE and calls
kvm_hv_hypercall_userspace_exit().

Will this cause a spurious KVM_EXIT_MEMORY_FAULT instead of a normal
KVM_EXIT_HYPERV because kvm_hv_hypercall_check_params() incorrectly
re-validates the overwritten hc->ingpa as a GPA?

> +
> +	vcpu->run->exit_reason =3D KVM_EXIT_HYPERV;
> +	vcpu->run->hyperv.type =3D KVM_EXIT_HYPERV_HCALL;
> +	vcpu->run->hyperv.u.hcall.input =3D hc->param;
> +	vcpu->run->hyperv.u.hcall.params[0] =3D hc->ingpa;
> +	vcpu->run->hyperv.u.hcall.params[1] =3D hc->outgpa;
> +	vcpu->arch.complete_userspace_io =3D kvm_hv_hypercall_complete_userspac=
e;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918081543.1398=
71-1-pbonzini@redhat.com?part=3D5
