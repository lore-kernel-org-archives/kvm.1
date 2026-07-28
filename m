Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9FD30568E
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785251945; cv=none; b=kBsf6AwlVKJCU/CdKUibYba7pE56PPXorJvNneIWModvS+m63qRKlSJcsWQdPztLczuZPRpep8oGWbf/NBAWnYIS1Fl1c8Ip7slonGDpY5KyPnpd08x2krVM8HlWNYytNEeg1U6Qvacr4TK5Y9JeynkKoGLARm7DPZ5cERUjL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785251945; c=relaxed/simple;
	bh=IjkFdsbewhkCcCmu+YhNAP5IiqATlISe6Iry8e1ZhlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cuxyKXX7oU6Zwsg2vHcvaU6TdSEyrYyJV3Og20s/vgjWRuXm64woruOBt1bbUOpqBA1/r4oTDj7/BLVzw9eGH/5iM1fTVnTJCyrhHc2J/s9m07EsH4knQv1UCqBFprG7gy3KG0saSaNnTasNNbP1h9U0vbD86FGFxJ3G6KoLxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oClo08Hb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oClo08Hb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC561F000E9;
	Tue, 28 Jul 2026 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785251943;
	bh=K79czuWMANjfznWLq/Wncr9cbSUFTqYSrutFk5zsB90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oClo08Hbt83zWa3tIM0GGc1IZ+CezllyFvfWKebJmzdt55eRlg4Zn+oISufNfZw2R
	 D6sO5JGGlu+6apsHCQz9VgYgjfhZX2hrW4rLbZlyALRxNXq8WItNpEbF87N+teUlTB
	 OK9ywrU8Q6Dgj142JbNOxSFTxE+xoU+0hPrZ+7ja7BVM8GOXnCM3MkqfOldo7GWG60
	 EEIQ+Sbz/tLWErcaWyGaWFqDzQKejCdkdc2+aNVHJG1fkPzCD+yWknvmOInYQ9vqgA
	 /gJlamMwMmlt+d+731eFLLRqgweGLt20ElEWgEaryR82LsOzYkwiMIvoagHDeF2qSQ
	 IU7JUtpARG1Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 23/36] KVM: x86: Re-synchronize TSC after
 KVM_SET_TSC_KHZ
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260728144954.355376-24-dwmw2@infradead.org>
References: <20260728144954.355376-1-dwmw2@infradead.org>
 <20260728144954.355376-24-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 15:19:02 +0000
Message-Id: <20260728151902.CEC561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM_SET_TSC_KHZ unconditionally sets user_set_tsc =3D true during =
vCPU creation, breaking the 1-second slop hack workaround for live migratin=
g young VMs.
- [High] Lockless TOCTOU race when synchronizing the guest TSC causes guest=
 clock stalls or backwards jumps during preemption.
--

--- Patch [23]: [PATCH v7 23/36] KVM: x86: Re-synchronize TSC after KVM_SET=
_TSC_KHZ ---
commit 7a6fbf4fe1dbd0e60f9a3418fa5cc8be64f86841
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: x86: Re-synchronize TSC after KVM_SET_TSC_KHZ

KVM_SET_TSC_KHZ changes the vCPU's TSC scaling ratio but does not
update the VM-wide cur_tsc_scaling_ratio used by get_kvmclock().
This commit calls kvm_synchronize_tsc() after changing the TSC
frequency to ensure the TSC value is continuous and updates the scaling rat=
io.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1942ccadb7a50..57494812cc839 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -1061,7 +1061,17 @@ static int kvm_set_tsc_khz(struct kvm_vcpu *vcpu, =
u32 user_tsc_khz)
>  			 user_tsc_khz, thresh_lo, thresh_hi);
>  		use_scaling =3D 1;
>  	}
> -	return set_tsc_khz(vcpu, user_tsc_khz, use_scaling);
> +	/*
> +	 * Read the guest TSC before changing the ratio, so we can
> +	 * re-synchronize to preserve continuity across the change.
> +	 */
> +	tsc =3D kvm_read_l1_tsc(vcpu, rdtsc());

[Severity: High]
Can this lockless read cause guest clock stalls or backwards jumps?

If the thread is preempted between this lockless rdtsc() read and the=20
lock acquisition in kvm_synchronize_tsc(), the delay is lost.

kvm_synchronize_tsc() takes a new rdtsc() reading under tsc_write_lock:

arch/x86/kvm/x86.c:__kvm_synchronize_tsc() {
    ...
    raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
    ...
    host_tsc =3D rdtsc();
    ...
}

Will this effectively stall the guest TSC for the duration of any preemption
delay, shifting it backwards relative to other vCPUs and the host clock?

> +
> +	if (set_tsc_khz(vcpu, user_tsc_khz, use_scaling))
> +		return -1;
> +
> +	kvm_synchronize_tsc(vcpu, &tsc);

[Severity: High]
Does passing a non-NULL pointer to kvm_synchronize_tsc() here inadvertently=
=20
break the 1-second slop hack workaround for live migrating young VMs?

Since kvm_set_tsc_khz() is called unconditionally during vCPU creation via
kvm_arch_vcpu_create()->kvm_set_tsc_khz(), passing &tsc causes=20
kvm_synchronize_tsc() to treat this as a user-initiated write and globally=
=20
set user_set_tsc =3D true for every new VM:

arch/x86/kvm/x86.c:__kvm_synchronize_tsc() {
    ...
    if (user_set_tsc)
        vcpu->kvm->arch.user_set_tsc =3D true;
    ...
}

Would this defeat the flag's purpose, causing the 1-second slop hack to=20
incorrectly trigger during migration and overwrite an explicitly restored=20
guest TSC with a value synced to KVM's dummy creation time?

> +	return 0;
>  }
> =20
>  static u64 compute_guest_tsc(struct kvm_vcpu *vcpu, s64 kernel_ns)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728144954.3553=
76-1-dwmw2@infradead.org?part=3D23
