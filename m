Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.90
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513154;
	b=SeUWRig0Pv4en60CDEPBtzJ4NkLirJNMw63hCewU3OC58YwxWAu2oSiL3ECPUHzMSUZG
	 W7NDRzHM6wcN6JSkYOclWQi7ZNIwHFG7cKYRWhnIAz2Inj8CyQIFB5nQgiPgk8YzG8lWy
	 IAJovF7Hjw/PGV5k+ttW12DJF8VNOQSKgIpt1Yq6BbrDlSUP92UHJPtj6dp9c+mmallTj
	 +oFH+Mp0Fxzj7DqlVhDI+2y0Z0QSYnQDtGL8ylvuwe2cU0RXkceKizsU9sbwGMOqmkOGy
	 OCdsa92oIitxtzo7sJwLJaycHJTseb9I/b6GHVkRvzhQoesYFWmSZUL3Ttv4L69w/IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513154;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=XD3y0uRelfjcM8wuzE5PStYzhtdNUf4TcgUCbGZyLAw=;
	b=GXV4D0LwCCRUwCnWKinEwWZE+LH5H6wQqX2j+jqkCG3sfPDtEE5YnSnIMjNPOpRAgc4U
	 NXl3qv7epZuW2GWALmbWoa+ih15GYBs+PMRF8R0CeVzIhwGXMaOoGfluluV+U2zUhpYky
	 oNssgfxPEd858fqgq81hVUW7BYidhDu9+/t3wsJ0TbWGFEHL1eNoi5G/if6c/qK//9GeK
	 EtAxW1buZYVLk7B6A4oEk6SGqCaHcRaJ68lGIzLZGYOy/99aP1qlN5fNTgquye7FE6X0n
	 IKueUntMsSGL8L4KC/cP4oBkIdJ1Qa0I14Rtr4YhlmYDBMHtLpesbBioud4o/rD9vOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aoDtwoD6;
	arc=none smtp.remote-ip=95.215.58.90
Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CF606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 09:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 860CF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aoDtwoD6
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ilOuyRk+MAIQHiCii2Y/pLuL3MbXC2Pov4MVI4OLeCc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795513151; v=1; x=1796117951;
 b=aoDtwoD6aEnxVNS2nu2WMjGXr21s04kvsRcAWHC3TX9tp6wkV36l1Rp/G0K741fBdI64zQJI
 adq2n/BY9f5cT5A8d6myU/hwotopoE0ZDyHXdJmAE9XR/S3CkghHLBHaGKlOnxZqbr1CIcC5gvI
 QIeP4TwsuOYbMmjSsGYqxo54=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e013843edc348aed;
	Tue, 24 Nov 2026 09:39:10 +0000
X-Mizu-Trace-ID: e013843edc348aed
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be58ad9600so22015e87.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 01:39:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEZjLRONAShp/GuXjGzgtmdBHC0jh1jHvsNkJQQtZoDVGFAcewwmUz/s9vHIeEnOS7JGI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wH/AsR2SkxLUYRKnSZWpe/BDzhlK2aQF6dI7DImFTAhOyK1ar
	cP3FDmFwyAHNqXNbaFUTlS9dHzvmWq+6G5uagj1i/JM1lrBOiUqWO/bV65ufMw2EoI5bGyVxUFj
	2Pe4rIBKqvGYXdCqErc7uoGP/72WsLZyDvdXp4CZj
X-Received: by 2002:a05:6512:3502:b0:5c1:488e:a067 with SMTP id
 2adb3069b0e04-5c200ba538amr329242e87.16.1795513147393; Tue, 24 Nov 2026
 01:39:07 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123192457.8700-1-maz@kernel.org> <20261123192457.8700-4-maz@kernel.org>
In-Reply-To: <20261123192457.8700-4-maz@kernel.org>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 24 Nov 2026 09:38:00 +0000
X-Gmail-Original-Message-ID: <CA+EHjTynhBzhjrFzd514Sycib=1rmh7JqYp0xSPVBvurk6Sm-A@mail.gmail.com>
X-Gm-Features: Aa3M54oJsiX7PUIr0O3Es9w-Trkkm26FAlvtAIKuj1DU-Bg32tEzMiolqN2nYfU
Message-ID: <CA+EHjTynhBzhjrFzd514Sycib=1rmh7JqYp0xSPVBvurk6Sm-A@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: arm64: Drop open-coded GIC idreg sanitisation
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Marc,

On Mon, 23 Nov 2026 19:24:57 +0000, Marc Zyngier <maz@kernel.org> wrote:
[...]
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
[...]
> @@ -5874,51 +5874,6 @@ static int kvm_vm_finalize_sys_regs(struct kvm *kvm)
[...]
> -                 * On GICv5 hardware that supports FEAT_GCIE_LEGACY we can run
> -                 * both GICv3- and GICv5-based guests. Therefore, we initially
> -                 * present both ID_AA64PFR0.GIC and ID_AA64PFR2.GCIE as IMP to
> -                 * reflect that userspace can create EITHER a vGICv3 or a
> -                 * vGICv5. This is an architecturally invalid combination, of
> -                 * course. Once an in-kernel GIC is created, the sysreg state is
> -                 * updated to reflect the actual, valid configuration.

nit: This comment is the only place that explains why, on a
FEAT_GCIE_LEGACY host, a VM's ID registers can show both GIC and GCIE
as IMP before the VM first runs. sanitise_id_aa64pfr0_el1() and
sanitise_id_aa64pfr2_el1() still set both at reset. Is it worth having
a short version of it next to the tables patch 2 adds?

[...]
> diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
[...]
> @@ -180,7 +180,7 @@ int kvm_vgic_create(struct kvm *kvm, u32 type)
>           * We've now created the GIC. Update the system register state
>           * to accurately reflect what we've created.
>           */
> -        kvm_vgic_finalize_idregs(kvm);
> +        kvm_idregs_enforce_dependencies(kvm);

This now also applies the S1P[IO]E dependencies when the vGIC is
created, at a point where userspace can still write the ID registers.
Was that intended? If this clears S1PIE or S1POE, the first KVM_RUN
doesn't restore it, so the final ID_AA64MMFR3_EL1 can change with the
order in which userspace writes the ID registers and creates the vGIC.
If that's the intent, should it say so in the commit message?

Cheers,
/fuad
