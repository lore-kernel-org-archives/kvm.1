Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D80261B8D
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115589; cv=none; b=FKRY6uxopSCf0vtMp3SlP21uH8e8cwwQJQQzZkzqfmEgdr5eH/r2OKxSLNTVFeoGWo4CIbye0l6Us/uh6KZrGw21UHc3EmUOGg0Jf9hL5nTm7yyQdSWmzEGJ5XBrC/aMiQvQmcjOYrJ/SRry/vAWW4hhqzf4ct5rEFx6WZqkS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115589; c=relaxed/simple;
	bh=MfYb0w3/0nhNBlzuNw8HHMPhnMM4Ih9dwEmy+okoTvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VtUINXQvFXGr58yDl+c9ZuBZytSk/CFIMioDA1q0QZvPagICHy5mR2IEZv4+Ya+WUfk6ZPQa/dIlMu/aVqGqHfB4IuCDyGEwV9zkO+dWTvhj9f3HixQpT9QmvdQuhvButfhI2vCNghCvK2RrL/KVYLgFSREmdP9eyxnQHvTA9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilIOe1sH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilIOe1sH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so1057269a12.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779115586; x=1779720386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8SzJCc/VsQGWrBeaOpA/+co8xReZ9jTdJ3oXu1ePILw=;
        b=ilIOe1sHUMhCXfX3vY9MGFOAGZAppYNvFixcjMTcy/h8qE38V2ovVPAjCvofzqzYjF
         C2qFAtbYu07RgXuBtWRrLRiZaXElap6g1JS/7HcxPBeJrNZ5p0RyE5dAFpMGF6wLOr3X
         Mul5kgRXrJVgOUxxpacW8HVUSIgyuyDv+y2beKTIIyncPQWPcM9RaXFtcfcNF/lvbdHd
         AzlJC3/Zn8wIB9l0YvklnkWWjITXnoDfHkayvQcIvEXkw09VKD7svMlPzob6M4Yu+VY2
         P3QRaXRKXmboNbGdw9Cp1hUAzXuroth14BUdBFK8SOtPm/tEZ1YcCOsUjrdu8oNH3Dvz
         ZkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115586; x=1779720386;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8SzJCc/VsQGWrBeaOpA/+co8xReZ9jTdJ3oXu1ePILw=;
        b=KZcSWncttYE0EhbBQq7rojHhEr4P3S+pNVz/87QM4VxMS4tQlwL18K1NN1bmyUM2Tx
         xT3HzMeRwBRqmcrmv2cpB6aR0MG7KZC3kY4w1ocafgXDDYeDsv/5h/xZSDq3MeNkQEpQ
         /C2KW+NzDe3+vOquhoprnudPYjGfi2YkgQ2QCIjozh6BaomHA3n7M2wmpJ8J6+OQBDMj
         p0vH/um2EK+kWhoPcx4e9TA8ilFivhcLJ4JuFCXqGCHcTjncPpFtSx4L650ZmpAaBq/o
         JnhJ9vZebDbzkPq0RO15H3OqNsSnjLaHqdQN36W9rbawpp2N5Mkhdqkig333nOJoElYr
         ftWw==
X-Gm-Message-State: AOJu0YzPzUqektD7Ols2F4uu3asdqSfd5TBvW9JO3H0IOOEtsEeOA2eV
	SKtWdZs2I04RCFWwchsPH6AubcSxOcVZRGta9snAXFH/WrDOTCTDKK4fmhH/J84QxC5nNCGfQ8m
	nM3GJaQ==
X-Received: from pgvd24.prod.google.com ([2002:a65:6218:0:b0:c82:c752:b253])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f90:b0:39f:82bd:298
 with SMTP id adf61e73a8af0-3b22e373bffmr17838349637.0.1779115586280; Mon, 18
 May 2026 07:46:26 -0700 (PDT)
Date: Mon, 18 May 2026 07:46:25 -0700
In-Reply-To: <20260516163412.601908-1-clopez@suse.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260516163412.601908-1-clopez@suse.de>
Message-ID: <agsmQaqJ5ShSaV07@google.com>
Subject: Re: [PATCH] KVM: x86: Fix array_index_nospec() protection in kvm_vcpu_ioctl_x86_set_mce()
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Jue Wang <juew@google.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026, Carlos L=C3=B3pez wrote:
> Commit aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and
> handle injected UCNA errors") introduced kvm_vcpu_x86_set_ucna(), which
> accesses @vcpu->arch.mci_ctl2_banks[] using @mce->bank as the index. The
> @mce struct is user-controlled, provided via the KVM_X86_SET_MCE ioctl.
>=20
> The caller of this function, kvm_vcpu_ioctl_x86_set_mce(), bounds-checks
> @mce->bank and applies array_index_nospec() to advance the @banks
> pointer, but @mce->bank itself is passed through unclamped. On a
> speculative path that bypasses the bounds check, the raw @mce->bank
> value can index mci_ctl2_banks[] out-of-bounds.
>=20
> In practice this is a very weak gadget, and would at most allow leaking
> a single bit in a 64-bit integer, but prevent potential future issues by
> clamping @mce->bank in place with array_index_nospec(), before passing
> the struct to kvm_vcpu_x86_set_ucna().
>=20
> Fixes: aebc3ca19063 ("KVM: x86: Enable CMCI capability by default and han=
dle injected UCNA errors")
> Signed-off-by: Carlos L=C3=B3pez <clopez@suse.de>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 209eae67ab18..2d2415031267 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5497,7 +5497,8 @@ static int kvm_vcpu_ioctl_x86_set_mce(struct kvm_vc=
pu *vcpu,
>  	if (mce->bank >=3D bank_num || !(mce->status & MCI_STATUS_VAL))
>  		return -EINVAL;
> =20
> -	banks +=3D array_index_nospec(4 * mce->bank, 4 * bank_num);
> +	mce->bank =3D array_index_nospec(mce->bank, bank_num);
> +	banks +=3D 4 * mce->bank;
> =20
>  	if (is_ucna(mce))
>  		return kvm_vcpu_x86_set_ucna(vcpu, mce, banks);

As a follow-up, I think we should fold kvm_vcpu_x86_set_ucna() into
kvm_vcpu_ioctl_x86_set_mce().  Splitting it to a separately helper makes it
unnecessarily difficult to see the usage of mce->bank.

Hmm, and isn't the handling of UNCA errors misplaced?  Per the SDM, the onl=
y
allowed values for IA32_MCG_CTL are -1ull and 0.

  IA32_MCG_CTL controls the reporting of machine-check exceptions. If prese=
nt,
  writing 1s to this register enables machine-check features and writing al=
l 0s
  disables machine-check features. All other values are undefined and/or
  implementation specific.

I don't see anything the SDM that exempts UNCA from that logic.  Ditto for =
the
similar IA32_MCi_CTL check.  So on top of your fix, over two patches, I thi=
nk we
should end up with this?

	mce->bank =3D array_index_nospec(mce->bank, bank_num);
	banks +=3D 4 * mce->bank;

	/*
	 * if IA32_MCG_CTL is not all 1s, the uncorrected error
	 * reporting is disabled
	 */
	if ((mce->status & MCI_STATUS_UC) && (mcg_cap & MCG_CTL_P) &&
	    vcpu->arch.mcg_ctl !=3D ~(u64)0)
		return 0;
	/*
	 * if IA32_MCi_CTL is not all 1s, the uncorrected error
	 * reporting is disabled for the bank
	 */
	if ((mce->status & MCI_STATUS_UC) && banks[0] !=3D ~(u64)0)
		return 0;

	if (is_ucna(mce)) {
		banks[1] =3D mce->status;
		banks[2] =3D mce->addr;
		banks[3] =3D mce->misc;
		vcpu->arch.mcg_status =3D mce->mcg_status;

		if (lapic_in_kernel(vcpu) && (mcg_cap & MCG_CMCI_P) &&
		    (vcpu->arch.mci_ctl2_banks[mce->bank] & MCI_CTL2_CMCI_EN))
			kvm_apic_local_deliver(vcpu->arch.apic, APIC_LVTCMCI);
	} else if (mce->status & MCI_STATUS_UC) {
		if ((vcpu->arch.mcg_status & MCG_STATUS_MCIP) ||
		    !kvm_is_cr4_bit_set(vcpu, X86_CR4_MCE)) {
			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
			return 0;
		}
		if (banks[1] & MCI_STATUS_VAL)
			mce->status |=3D MCI_STATUS_OVER;
		banks[2] =3D mce->addr;
		banks[3] =3D mce->misc;
		vcpu->arch.mcg_status =3D mce->mcg_status;
		banks[1] =3D mce->status;
		kvm_queue_exception(vcpu, MC_VECTOR);
	} else if (!(banks[1] & MCI_STATUS_VAL)
		   || !(banks[1] & MCI_STATUS_UC)) {
		if (banks[1] & MCI_STATUS_VAL)
			mce->status |=3D MCI_STATUS_OVER;
		banks[2] =3D mce->addr;
		banks[3] =3D mce->misc;
		banks[1] =3D mce->status;
	} else
		banks[1] |=3D MCI_STATUS_OVER;
	return 0;

Unless I'm wrong, I'll send a v2 with your fix plus two more patches.
