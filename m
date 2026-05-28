Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57823A1B5
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970636; cv=none; b=VKR11jwJOu+oy6yv05RGafbxNfcJvB7PnWRKxtrapv+7eFLxV+GTmunl9V3hTf59pek4nwENOTi8fZ0XsvGUfVtA6DYbv9kmO+A6IUBz0VrnSDMYmiJO2gHrv4J/1qv6sqg218D3dOlR8S5Y0IcBsSreDBsUhiATsPAqP7a/L/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970636; c=relaxed/simple;
	bh=YeVpyuG0i6OjwUZe2EmRFN6sTrLzQndRSHhgN/SSEyM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AMv25KpR7YX2JvXQKVX0727TuEF5q7og0AduWI8A0RIyV0bJV+yeC+cOmfG/vurVy5Vc+SGyfU8rXKf2jTRKg7oE+OCU0mf4Q1EGJ8hxVEF96j247PTcjyUHTuVmW2TCdD/ESi54P5JZweV23WwNh1I32WWfgjbM8XMhkIsNriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTdb2eNI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTdb2eNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691701F00A3D;
	Thu, 28 May 2026 12:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970627;
	bh=gBG08BIzxEBqqfdHVundtiPhLz1KLYGTfNkKQx6vijM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CTdb2eNI26j1fawerKy03hzqGUpIuMg5kd3tk8MoKLww7EGd9eVep3E/7S9MwPPPE
	 qEf2e0cPbnkXz/+zMbkr6twiGwpx/Ghb0wJPYdDlpD7xs45L2VI3wMf9JW8YnrHhBJ
	 ffmy6MP+cOnKRn7fEIDDBdBP2izsq/SiGk8DuMHCr/ma7qvSqsOhzRUHGrOFK4TTiI
	 hXQLN/sv2kVDjY9IKeNS9XIahto5VvcRSJBl0ky/05I0x97cKHB5gjUNGSrVwgSpOb
	 43YaEB0dWxgK9DaqY2YfYrp4fXoml+vSZjrJx520wor+y8pok3TCR4Lkna8e3MEkLs
	 0OOTk3+L0aByg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] KVM/x86: Return -errno instead of "1" for APIC
 related MSR emulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528113605.267111-3-jgross@suse.com>
References: <20260528113605.267111-3-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 12:17:06 +0000
Message-Id: <20260528121707.691701F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Returning a negative error code (like -EINVAL) from MSR emulat=
ion handlers causes KVM to abort the VM instead of injecting a #GP exceptio=
n into the guest.
--

commit 7f1a730b4cdc6c3d32a0f5e2d9d557acc42efaa6
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Return -errno instead of "1" for APIC related MSR emulation

This commit replaces literal "1" return values with negative errno values
such as -EINVAL in the emulation code for APIC-related MSR registers.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4078e624ca667..3e7d83db2f7ab 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2412,11 +2412,10 @@ static int kvm_lapic_reg_write(struct kvm_lapic *=
apic, u32 reg, u32 val)
> =20
>  	switch (reg) {
>  	case APIC_ID:		/* Local APIC ID */
> -		if (!apic_x2apic_mode(apic)) {
> +		if (!apic_x2apic_mode(apic))
>  			kvm_apic_set_xapic_id(apic, val >> 24);
> -		} else {
> -			ret =3D 1;
> -		}
> +		else
> +			ret =3D -EINVAL;

[Severity: Critical]
Does returning a negative error code here bypass the exception injection
logic?

In the KVM MSR emulation framework, functions like __kvm_emulate_wrmsr()
treat a return value greater than 0 as an instruction fault. This allows KVM
to safely inject a General Protection Fault into the guest.

If we return a negative code like -EINVAL, the negative value is propagated
up the call chain instead. This reaches the vcpu_run() loop, causing the
KVM_RUN ioctl to fail and forcing the host VMM to exit and terminate the VM.

Will this change allow a guest OS that probes an unsupported APIC MSR to
inadvertently crash its own virtual machine, instead of receiving and
gracefully handling a General Protection Fault?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528113605.2671=
11-1-jgross@suse.com?part=3D2
