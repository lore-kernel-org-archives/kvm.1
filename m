Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F036F91D
	for <kvm@vger.kernel.org>; Sun,  6 Sep 2026 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682773; cv=none; b=H4CX9F2nxNt2+SSD4ioUKsV7Kc5eBIIqLC913OC8UEx6Ya25Iu0bRyTd+mZnMmlneYN7B46BbnOatP9Hy8Ww8HuDt3AHiyTgVHqXrm4aYX6y08uEnby+K23jL0Re4tdSdsxURDbXhfysVk5VehgNWpNOeYl2Rpq2AWV/I/lLZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682773; c=relaxed/simple;
	bh=8qQq/o6412voNAgXkeqjKxnZWxqPOp2b4SJui2t50rU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hy+8tL6R7dxOvp6lFffV+rPLDuWZyyRXbyWQMc4e8t/rsNHnEjrsqqcR04YTOivl2q8j4RjbxAyOgdiAJqzzTDySsGIaqhGDe/dT36pHQs64WPQodqQIH0UxvJedlw+JW8l+N3qCnOEjyKaNL4yiq18/ugXopxJAD34OmfBd2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aq/D6YV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aq/D6YV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCD11F00A3A;
	Sun,  6 Sep 2026 08:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788682771;
	bh=d7KJZZpjv6R7swUnr9wL+N9FvZFGXKpF2LIx8N2u2kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aq/D6YV7tlglEC7yiqK+GI4BmjUwlyLDxI1a3HFOpwsk2IRhX0bYFTHM13r3KmhmU
	 jBJ292kwCa/tTSDWzIA0XBdsHE7YbEMk7O61YchYF5M7aDNbjsxtdNrNfmQVG7N8PZ
	 7WWypuQTAOVvlC0DjatvbDB9KwRG2shhLUCbkkU2Q8wmpyXLqgYPkKpy7kEJPX8m/J
	 +nmWUYGDqVUz9tkWr3x3OhSs13GZMll4x21o+iuvK81y74ZRuvw0glgeNV4vGj5ZJt
	 0AxuasKVV8O6aZLHcLWPLw/cuppVAYKcVERx7dtIV89eDQhbv44N9CU8Q9lPMqbSQS
	 40HKk0Ci0+Ziw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] RISC-V: KVM: Publish NACL HFENCE configuration last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <hppiscas@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <caplitmus-rv.c91c005b844342d9a9f60949b04c520d.d65@163.com>
References: <caplitmus-rv.c91c005b844342d9a9f60949b04c520d.d65@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 08:19:30 +0000
Message-Id: <20260906081931.4DCD11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM silently drops TLB flush (HFENCE) requests when the NACL share=
d memory is exhausted, leading to guest memory corruption and use-after-fre=
e vulnerabilities.
- [High] Per-CPU `nacl_shmem()` is evaluated and accessed in a preemptible =
context, causing a race condition that corrupts shared memory entries and d=
rops TLB flushes.
- [High] The shared memory entry configuration is read without `READ_ONCE()=
`, violating Linux Kernel Memory Model (LKMM) rules for shared memory and c=
ontrol dependencies.
--

commit c8294fdfde274970a69be416dee2db8089a33132
Author: Pengpeng Hou <hppiscas@163.com>
Subject: RISC-V: KVM: Publish NACL HFENCE configuration last

The SBI NACL interface requires software to write Page_Number and
Page_Count before publishing an HFENCE entry with Config.Pending set.
__kvm_riscv_nacl_hfence() currently stores the pending configuration first.

> diff --git a/arch/riscv/kvm/nacl.c b/arch/riscv/kvm/nacl.c
> index 9aff03c4f667a..c5c4907aca08a 100644
> --- a/arch/riscv/kvm/nacl.c
> +++ b/arch/riscv/kvm/nacl.c
> @@ -5,6 +5,7 @@
> =20
>  #include <linux/kvm_host.h>
>  #include <linux/vmalloc.h>
> +#include <asm/barrier.h>
>  #include <asm/kvm_nacl.h>
> =20
>  DEFINE_STATIC_KEY_FALSE(kvm_riscv_nacl_available);
> @@ -42,12 +43,15 @@ void __kvm_riscv_nacl_hfence(void *shmem,

[Severity: High]
This isn't a bug introduced by this patch, but in __kvm_riscv_nacl_hfence(),
KVM silently drops TLB flush requests when the NACL shared memory fills up.

When the shared memory queue fills up, the function calls
nacl_sync_hfence(-1UL) and retries 5 times. If the firmware is sluggish or
fails to drain the queue in time, it returns void without notifying the
caller:

arch/riscv/kvm/nacl.c:__kvm_riscv_nacl_hfence() {
    ...
	if (ent < 0) {
		if (try_count--) {
			nacl_sync_hfence(-1UL);
			goto again;
		} else {
			pr_warn("KVM: No free entry in NACL shared memory\n");
			return;
		}
	}
    ...
}

Could KVM return a hard error or BUG() instead if a TLB flush cannot be
completed, to prevent guests from accessing stale physical memory mappings
and causing data corruption or use-after-free?

[Severity: High]
This is a pre-existing issue, but does reading the shared memory entry
configuration without READ_ONCE() violate the Linux Kernel Memory Model for
shared memory and control dependencies?

arch/riscv/kvm/nacl.c:__kvm_riscv_nacl_hfence() {
    ...
again:
	for (i =3D 0; i < SBI_NACL_SHMEM_HFENCE_ENTRY_MAX; i++) {
		entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
		if (lelong_to_cpu(*entp) & SBI_NACL_SHMEM_HFENCE_CONFIG_PEND)
			continue;
    ...
}

While this patch correctly adds a WRITE_ONCE() and a barrier for publishing
the payload, the read side is left unprotected. Without READ_ONCE() around
*entp, might the compiler optimize the read from shared memory by caching t=
he
value or issuing multiple loads, which could result in an infinite loop or
incorrect synchronization with the firmware?

>  		}
>  	}
> =20
> -	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> -	*entp =3D cpu_to_lelong(control);
>  	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PNUM(i);
>  	*entp =3D cpu_to_lelong(page_num);
>  	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_PCOUNT(i);
>  	*entp =3D cpu_to_lelong(page_count);
> +
> +	/* Publish the payload before setting Config.Pending. */
> +	wmb();
> +	entp =3D shmem + SBI_NACL_SHMEM_HFENCE_ENTRY_CONFIG(i);
> +	WRITE_ONCE(*entp, cpu_to_lelong(control));
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to evaluate and
access the per-CPU nacl_shmem() in a preemptible context?

In kvm_arch_vcpu_ioctl_run(), vCPU requests are processed before preemption
is disabled:

arch/riscv/kvm/vcpu.c:kvm_arch_vcpu_ioctl_run() {
    ...
		ret =3D kvm_riscv_check_vcpu_requests(vcpu);
		if (ret <=3D 0)
			continue;

		preempt_disable();
    ...
}

When processing HFENCE requests, kvm_riscv_hfence_process() evaluates
nacl_shmem(), which expands to a per-CPU pointer:

arch/riscv/include/asm/kvm_nacl.h:
#define nacl_shmem()							\
	this_cpu_ptr(&kvm_riscv_nacl)->shmem

arch/riscv/kvm/tlb.c:kvm_riscv_hfence_process() {
    ...
				nacl_hfence_gvma_vmid(nacl_shmem(), d.vmid,
						      d.addr, d.size, d.order);
    ...
}

If the vCPU thread is preempted and migrated to another CPU after evaluating
nacl_shmem(), wouldn't this cause a race condition that overwrites another
CPU's TLB flush queue, potentially leading to dropped flushes and guest
isolation breaches?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/caplitmus-rv.c91c00=
5b844342d9a9f60949b04c520d.d65@163.com?part=3D1
