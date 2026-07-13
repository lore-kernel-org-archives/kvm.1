Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E93876B2
	for <kvm@vger.kernel.org>; Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940877; cv=none; b=m7ZKSFx3RXKgpJIHowoHCc5yV/Dc3RlC1xXNmlW90z/K5b5dwV7qur10+dYSEuf8xvc68AbiRL4g1J2vjOVcmO3IgcEpYy01JeayIFfPl6DGLNCz26y/7Txuxnbt9c/M1IAFB6HDEzKqEkNZA/dqCRRxaTLZzaCsUKPVfO4bBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940877; c=relaxed/simple;
	bh=d0ABzhXeHUBkFnNhjmI8xRulI0sp1gwLY39ccW0TbwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qjRy+Y2XKxpGSDehvKXFOuK2G7B3te2lqWF+KOgu9FCIpCbgoNrRIhwda0wQRaX9hIJYMZDPVfrfaxbYEztmbCpMqBaMxNSQYYkK8nDwT5Aj3Bz96Q5jhWFtv4n7qM+SooNaEJdL4s6tUVwVATGmQPiShxiWLfe5JLR9H6BUv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLpqzU3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLpqzU3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8351F000E9;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783940874;
	bh=QDKQ6E4jAYqwKHNVcDk6l3pwLwKJoybIfG3fznrvj2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JLpqzU3TvnMQnXyxfNh0kKXKnB8twJuM31VY1rOu0RCeloASUj/zDnSQSv+/6axVr
	 HBl3l4hCDCH8S8kGFWHQcY6UgAA6bHZle8AMPhgWSkIZPQ/HX5Vwav4eZ1fTHdOvyb
	 QuN2XxUg0xIZz4RwrqVSDlVZMeV7HjXY7uKr9jWbc53ZV+Z+88A99ad9O9+rXCyEKF
	 lIR4CoYrT7EfuThxUDEOil2nppmJiBKjP8/m46neRPPl0DzZ0eUVJJhKryTfddJncd
	 4Ck4tZdOCYj7xct8wRzN0/swyZbiW8bC3wf18BYBbx7i0tys8ktqU5JB1NFq0DwJYw
	 D3i68QBjCWA1g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 4/6] iommu/amd: Program guest-mode IRTEs for
 GAPPI wakeup when IRTE[IsRun] = 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260713105033.15405-5-sarunkod@amd.com>
References: <20260713105033.15405-1-sarunkod@amd.com>
 <20260713105033.15405-5-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 11:07:54 +0000
Message-Id: <20260713110754.9B8351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] GAPPI uses the lower 8 bits of the IRTE `ga_tag` as the host p=
hysical APIC interrupt vector, but this tag holds the guest's unconstrained=
 `vcpu_idx`, leading to host CPU exception injection.
- [High] When GAPPI is enabled, putting a vCPU into a blocked state configu=
res the IOMMU IRTE with a broadcast physical destination APIC ID (0xfffffff=
f), causing an interrupt storm.
--

--- Patch [4]: [RFC PATCH v3 4/6] iommu/amd: Program guest-mode IRTEs for G=
APPI wakeup when IRTE[IsRun] =3D 0 ---
commit aad2d4e0f82cbce4cf0a8e8b65994633202311a3
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Program guest-mode IRTEs for GAPPI wakeup when IRTE[IsRun] =3D 0

This commit enables Guest APIC Physical Processor Interrupt (GAPPI) support
for the AMD IOMMU. When a vCPU is scheduled out, it configures the IOMMU to
deliver a physical APIC interrupt using the IRTE destination and GATag
fields to wake up the blocked vCPU.

> Guest APIC Physical Processor Interrupt (GAPPI) is an alternative to the
> GA log for notifying the host when a device interrupt targets a
> non-running vCPU (IRTE[IsRun] =3D 0). Per the AMD IOMMU specification [1]
> (section 2.2.5.4), with GAPPI enabled the IOMMU delivers a physical APIC
> interrupt to the CPU described by IRTE[Destination], using
> IRTE[GATag][7:0] as the vector, while still updating the guest vAPIC
> backing page IRR as usual.

[Severity: Critical]
KVM constructs the ga_tag using AVIC_GATAG(vm_id, vcpu_idx), which embeds
the guest vcpu_idx into the lowest 8 bits. This unmodified tag is
programmed into the IRTE's ga_tag field when a guest mode is activated:

drivers/iommu/amd/iommu.c:amd_iommu_activate_guest_mode() {
    ...
    entry->lo.fields_vapic.ga_tag =3D ir_data->ga_tag;
    ...
}

If GAPPI uses IRTE[GATag][7:0] as the physical APIC interrupt vector, and a
device interrupts vCPU 0, will the IOMMU deliver a physical interrupt with
vector 0?

Since vectors 0-31 on x86 are reserved for CPU exceptions, could this
regression allow an untrusted guest VM to trigger a host kernel panic
(e.g., #DE Divide-by-Zero) by firing an interrupt while a low-numbered vCPU
is blocked?

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 91405e71b3c3a..7eebf4745a678 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3970,8 +3970,18 @@ static void __amd_iommu_update_ga(struct irte_ga *=
entry, int apicid,
>  		entry->lo.fields_vapic.is_run =3D true;
>  		entry->lo.fields_vapic.ga_log_intr =3D false;
>  	} else {
> -		entry->lo.fields_vapic.is_run =3D false;
> -		entry->lo.fields_vapic.ga_log_intr =3D wakeup_intr;
> +		if (amd_iommu_gappi) {
> +			entry->lo.fields_vapic.gappi_dis =3D !wakeup_intr &&
> +						check_feature2(FEATURE_GAPPIDISSUP);
> +			entry->lo.fields_vapic.is_run =3D false;
> +			entry->lo.fields_vapic.destination =3D
> +						APICID_TO_IRTE_DEST_LO(apicid);
> +			entry->hi.fields.destination =3D
> +						APICID_TO_IRTE_DEST_HI(apicid);

[Severity: High]
When KVM blocks a vCPU, it calls amd_iommu_update_ga() with apicid =3D -1 a=
nd
wakeup_intr =3D true.

If apicid is -1, won't APICID_TO_IRTE_DEST_LO() and APICID_TO_IRTE_DEST_HI()
convert this to 0xffffffff?

Does this regression result in writing the x2APIC broadcast address to the
IRTE destination field, potentially causing a host-wide interrupt storm when
a passed-through device fires an interrupt?

> +		} else {
> +			entry->lo.fields_vapic.is_run =3D false;
> +			entry->lo.fields_vapic.ga_log_intr =3D wakeup_intr;
> +		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713105033.1540=
5-1-sarunkod@amd.com?part=3D4
