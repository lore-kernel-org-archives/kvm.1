Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FD360EE8
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993192; cv=none; b=hH7GfZAmVC60ioVmzb7ugELVSc419BHWhWEC5yU2ij6DURhs0WyNhCFERM+dMdIb/Djlubnzrk0xjFQDkMsyI+dtQfeqW1gqSem+onMXXwaLJ37UJgzxXpe2eSCp0VWwd4TWVRrTXZDYsKPsGPx9v2g//KU4g0KdadCOBGN7E8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993192; c=relaxed/simple;
	bh=oHTqpKLqZUPiG2LXGDu6PM4kAhB4WvhEE8qozib3ico=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JdbG/KGZiVvsVMlbJKERzIvBHfJ6a+Npd6JY1YAigdHWqY09YU4pBbxlGitvh3eorjWweRkRymNL7IV2HB2rcHNt+2DMZfjRXd4OXhaiVQ0CkZf15CdJ6ucdI314SR4sRtmB9SjmWEhrdII3XuszoQV85Z/9jlDEruq2DDWCJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i96sOXvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i96sOXvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC551F000E9;
	Tue, 14 Jul 2026 01:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783993190;
	bh=h0iDVQHth/Jk+0mXTGR7VWyaq1eTUETmuJpMARN3/Vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i96sOXvpNuzIo6U3V5bzIxVkhDWiJNCou7OCpy+NF95XYLCD0j6tH7GznoSTFcFtq
	 h2+O8m0SDi4RZbZ6oe3M7OK9GdS7ActAdX6Oij7sCdbWH0z35ou8Tm2dZZJlWzF9YJ
	 f7rRS5oEp/z8jiWU+hBKOcXoqejWPW10bHN2IhifvaYhRS8QU9GUkU/+6RZjWEePlr
	 r8RlTqIHr3w0FlEC92yb9HVBx1tggNQzOt/cMA4zcgY8iZDpFLH4LpBSVfTNoffrWd
	 jHJEDirkQkrK5FgwiyVINH1PnuLsosaQRWJoziykSFY3YG84dxobg5QAN2OPdq1Pso
	 4EMlUt2YGJBsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] LoongArch: KVM: EIOINTC: clamp ipnum to valid range
 in INT_ENCODE mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714012452.1021833-2-cui.tao@linux.dev>
References: <20260714012452.1021833-1-cui.tao@linux.dev>
 <20260714012452.1021833-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 01:39:50 +0000
Message-Id: <20260714013950.7CC551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Guest or host userspace can trigger massive out-of-bounds read=
s and writes on the host kernel heap and undefined bitshift behavior by sup=
plying an unvalidated MSI data value.
- [High] `eiointc_set_sw_coreisr` fails to decode `cpuid` in 1-hot mode (`E=
IOINTC_ENABLE_CPU_ENCODE` disabled), reading from the wrong vCPU's `coreisr=
` state when reconstructing `sw_coreisr` during `LOAD_FINISHED`.
- [High] When a guest writes to `EIOINTC_COREISR_START` to clear a pending =
interrupt, `eiointc_update_irq` clears the fast-path state (`sw_coreisr`) a=
nd de-asserts the parent IRQ on the currently routed CPU from `sw_coremap`,=
 which may not be the CPU whose `coreisr` was actually cleared.
- [Medium] Lockless access to `map->phys_map[cpuid]` in `kvm_get_vcpu_by_cp=
uid()` lacks memory barriers.
--

--- Patch [1]: [PATCH 1/2] LoongArch: KVM: EIOINTC: clamp ipnum to valid ra=
nge in INT_ENCODE mode ---
commit 21ec11994b801fe6a14903dedc825bbe4a3246e5
Author: Tao Cui <cuitao@kylinos.cn>

LoongArch: KVM: EIOINTC: clamp ipnum to valid range in INT_ENCODE mode
   =20
This commit clamps the ipnum variable to [0, LOONGSON_IP_NUM) in INT_ENCODE
mode. It prevents out-of-bounds accesses on the sw_coreisr array which is
guest-programmable, preventing out-of-bounds accesses reachable from an
unprivileged guest.

Cc: stable@vger.kernel.org

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index 2b14485d14a70..0c34d7ab264dc 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -17,6 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eio=
intc *s)
>  		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>  			ipnum =3D count_trailing_zeros(ipnum);
>  			ipnum =3D ipnum < 4 ? ipnum : 0;
> +		} else {
> +			ipnum =3D (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
>  		}
> =20
>  		cpuid =3D ((u8 *)s->coremap)[irq];

[Severity: High]
This is a pre-existing issue, but does eiointc_set_sw_coreisr() fail to
decode cpuid in 1-hot mode when EIOINTC_ENABLE_CPU_ENCODE is disabled?

It looks like it fetches cpuid directly from s->coremap[irq] without decodi=
ng
it. In the default 1-hot mode, cpuid represents a bitmask, but the subseque=
nt
call to kvm_get_vcpu_by_cpuid() expects an exact ID. Could this result in
looking up the wrong vCPU during state restoration, causing lost interrupts?

[Severity: Medium]
This is a pre-existing issue, but is the lockless access to
map->phys_map[cpuid] safe in kvm_get_vcpu_by_cpuid() when called here?

When kvm_get_vcpu_by_cpuid() reads map->phys_map[cpuid].enabled and vcpu, it
doesn't use memory barriers like smp_load_acquire(). Concurrently,
kvm_set_cpuid() updates these fields using a lock but without
smp_store_release(). Could this compiler or CPU reordering cause
kvm_get_vcpu_by_cpuid() to transiently return NULL?

[ ... ]

> @@ -42,6 +44,8 @@ static void eiointc_update_irq(struct loongarch_eiointc=
 *s, int irq, int level)
>  	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>  		ipnum =3D count_trailing_zeros(ipnum);
>  		ipnum =3D ipnum < 4 ? ipnum : 0;
> +	} else {
> +		ipnum =3D (ipnum < LOONGSON_IP_NUM) ? ipnum : 0;
>  	}
> =20
>  	cpu =3D s->sw_coremap[irq];

[Severity: Critical]
This is a pre-existing issue, but is the irq index validated before being
used for array accesses here?

The KVM MSI routing mechanism allows guests or host userspace to inject MSIs
with an arbitrary 32-bit msi.data payload. In pch_msi_set_irq():

arch/loongarch/kvm/intc/pch_pic.c:pch_msi_set_irq() {
    ...
    eiointc_set_irq(kvm->arch.eiointc, e->msi.data, level);
    ...
}

The user-supplied e->msi.data is passed unvalidated to eiointc_set_irq() as
the irq parameter. This unvalidated irq is then used as an index for bitwise
operations like __set_bit(irq, isr) in eiointc_set_irq() and array accesses
like s->sw_coremap[irq] in eiointc_update_irq(). Can this allow unprivileged
guest code to perform arbitrary out-of-bounds memory writes on the host
kernel heap?

[Severity: High]
This isn't a bug introduced by this patch, but does eiointc_update_irq()
operate on the correct CPU when clearing a pending interrupt?

When a guest writes to EIOINTC_COREISR_START to clear a pending interrupt:

arch/loongarch/kvm/intc/eiointc.c:loongarch_eiointc_write() {
    ...
    eiointc_update_irq(s, irq + index * 64, 0);
    ...
}

The write handler issues the clear request without explicitly passing the
original vCPU. Then eiointc_update_irq() dynamically fetches the target CPU
from s->sw_coremap[irq]. If the guest has re-routed the IRQ while it was
pending, sw_coremap will point to the new CPU. Will this clear the fast-path
sw_coreisr state on the new CPU, leaving the old CPU with a permanently
asserted parent IRQ and an unrecoverable interrupt storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714012452.1021=
833-1-cui.tao@linux.dev?part=3D1
