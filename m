Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73B73E7BA4
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948150; cv=none; b=nBAJyfl7DVY5ZwlnQi/VLCZyddkmHecKOhKJyrFD045hf0F+YP0j8f781vrW3gE0XsW+YmEsNQWprNfN9UkvyLd54bRmvwU/Zo9t+CzsLIZwW35yKPjCfaSmk4o0U6ZGkQVUMPuhI2smn2a4iq0Ee4smAgueQCXEmfoo9nrkepE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948150; c=relaxed/simple;
	bh=t5m6ERCM8/ja5UM9fijNwIn/f3zPS9hEw9/pidTjO3E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IeBEu4TGDCUhirMSGnV8lTMljbKA9wph+7TKCF87DaSlrVFCrAqC2gLUAzjPZVyDbTYcOkyLLt+772taVzT0Up9WifTPYXrjpBAO8ulSjOb6pNpuwGIFe5Rn4WJfEq33WEu9b2f5a/uyD2PBPBgD1/aAeETuFRbpAXxlJmt6wcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekuoyVVO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekuoyVVO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891731F0089A;
	Mon,  8 Jun 2026 19:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780948149;
	bh=BDM8/KCRocwZwMfuBHfThStY6xCOWJAyIAKetr/Aj+w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ekuoyVVO1Fm1Fir4GNeHWXlvhowsYnJl4JG5UEu+yO6oEXbka2Iciq2xOuppkWH0G
	 QawVTOX8IZ66WsW0ld5JZBacdZUuWnj2kcf/dCZlhOMPNehp0g5QoV0arJsh2083/0
	 A/iJAu9k9sDBdegIsnUao1ij1XbxRyZuuBUFK0neQY+1JbhWJlfVf2fcGQ9RDZFdjj
	 7pUPJ+2DQpXe8pPMZe3Vd73p/cFvZiDsUUsn6yT2V593iYkPK1CzlRaRs1Tk5I44/3
	 kTJeOK2CNhrCFnpcBRHSmIljryBRCAnMwAKpnNSMuJUxopjVF2xz/xc8Y9GG4PQk8Q
	 UymFjSu1GW6hQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 41/60] kvm: x86: Make apic_map per plane
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-42-joro@8bytes.org>
References: <20260608144252.351443-42-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 19:49:09 +0000
Message-Id: <20260608194909.891731F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Per-plane APIC map recalculation erroneously overwrites VM-global =
APICv inhibit state, enabling APICv unsafely.
--

commit ed523cb8e92284e8a72c3abcbafa7f4ecb34091f
Author: Paolo Bonzini <pbonzini@redhat.com>

    KVM: x86: Move apic_map to per-plane state
   =20
    This commit moves the local APIC map and related dirty tracking from KVM
    VM-wide state into the per-plane structure.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 1b763f164951..06a12b49fafa 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -403,36 +403,37 @@ enum {
>  	DIRTY
>  };
> =20
> -static void kvm_recalculate_apic_map(struct kvm *kvm)
> +static void kvm_recalculate_apic_map(struct kvm_plane *plane)
>  {
>  	struct kvm_apic_map *new, *old =3D NULL;
> +	struct kvm *kvm =3D plane->kvm;

[ ... ]

> @@ -498,16 +499,16 @@ static void kvm_recalculate_apic_map(struct kvm *kv=
m)
>  	else
>  		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_APIC_ID_MODIFIED);
> =20

[Severity: High]
Does this per-plane recalculation erroneously overwrite the VM-global APICv
inhibit state?

Since APICv inhibit flags (like APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) a=
re
global per-VM state stored in kvm->arch.apicv_inhibit_reasons, unconditiona=
lly
clearing them when a single plane doesn't have aliases might be unsafe.

If Plane 0 correctly inhibits APICv due to aliased IDs, and a subsequent
recalculation occurs on Plane 1 (which lacks aliases), would this
kvm_clear_apicv_inhibit() call globally clear the inhibit flag?

This could improperly re-enable hardware APIC virtualization for the entire=
 VM
while Plane 0 is still in an invalid aliased state, leading to incorrect
interrupt delivery and potential hardware state corruption.

> -	old =3D rcu_dereference_protected(kvm->arch.apic_map,
> -			lockdep_is_held(&kvm->arch.apic_map_lock));
> -	rcu_assign_pointer(kvm->arch.apic_map, new);
> +	old =3D rcu_dereference_protected(plane->arch.apic_map,
> +			lockdep_is_held(&plane->arch.apic_map_lock));
> +	rcu_assign_pointer(plane->arch.apic_map, new);
>  	/*
> -	 * Write kvm->arch.apic_map before clearing apic->apic_map_dirty.
> +	 * Write kvm->arch.apic_map before clearing plane->apic_map_dirty.
>  	 * If another update has come in, leave it DIRTY.
>  	 */
> -	atomic_cmpxchg_release(&kvm->arch.apic_map_dirty,
> +	atomic_cmpxchg_release(&plane->arch.apic_map_dirty,
>  			       UPDATE_IN_PROGRESS, CLEAN);
> -	mutex_unlock(&kvm->arch.apic_map_lock);
> +	mutex_unlock(&plane->arch.apic_map_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D41
