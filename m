Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E49B49F113
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061719; cv=none; b=GroVqU36z+Voh58FqF/wF7rZyQ9fwXTzc/1DaR8P7dRl9IlmMC576cUSVN9qpq5XtbnQB99IOidhHRzLBDfqWvdcTBvzhdnr9SXpEXI3CPGcYSsiJyJ7zM3yevZ7gcd9NKPq69TimrwuxK29UHcfXMv8lAYXd0fF5JhTPh2het8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061719; c=relaxed/simple;
	bh=QjvFBMui7YcbTivf4rfTCdSWVyPWxu6KDyDA3xgJg0M=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ETWOlLBdNEFMwRefJqJxNk19646Gb36dNKhhQ5bhazwXmyQ4kk3OXQ+kuI8Vyzn9CLzZySCc7LgKaMjh/FVal93OvR65wMspN4j8a3KjC0QZU18MBdwHCgPhPHRMeVU38VMKHA+dhQ/fPgBbiWrmq109JnqiY/XL4s4bGnFXxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyPOCYyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyPOCYyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800681F000C4;
	Thu, 15 Oct 2026 10:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792061718;
	bh=FK0jGAQNjkZDLeTVqDSYN4S7vQrkVvjoDjDq1ZeW//8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MyPOCYyVsr3JZpglKGnm7dE0RSE/nTezsYzIktA9HWCM4/WtGWai4qi7BgcvHdPpg
	 Sb0/vSnxO/XKyqF1YdC04/CieKaMfcfO36ZqDvHFQReDVnvBxPITUq0FyQcihTlsHp
	 tkBrN60SUrSBL+NS1n/cvxIWYZoWxDj6u4tOPNzHI3AyL6VArO0TFu1+RQDaFb9Rio
	 BIMIHVlnyOV1q/T2HV54qeFs7ZZkmF/hmEZdTiofKtYpH7fdHyjDUnmBAM2YOM8ceZ
	 umNOmlxGYDn9Y5ZErb2Xoy7so4F01saSgx8hxfi51lEndhdFburBvsXqH3zd9WIF7e
	 pk1ljdd93pjPQ==
Message-ID: <sashiko-outbox-172691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] KVM: x86/mmu: Log dirty GPAs only for the
 nested GPA walk
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikunj A Dadhania" <nikunj@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015103933.2088307-2-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-2-nikunj@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 10:55:16 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: x86/mmu: L2 GFN type confusion and missed PML logs for L2 pag=
e tables
--

commit 39018b0fb43ef6b337e5d8b61b880163828654c8
Author: Nikunj A Dadhania <nikunj@amd.com>

KVM: x86/mmu: Log dirty GPAs only for the nested GPA walk

This patch gates PML logging on the walk being the nested GPA walk, assuming
only that walk yields an L2 GPA. No functional change is intended as the EPT
template only backs the nested GPA walk.

> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmp=
l.h
> index 8e350095508c5..043d0ec02b272 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -235,7 +235,9 @@ static int FNAME(update_accessed_dirty_bits)(struct k=
vm_vcpu *vcpu,
>  				!(pte & PT_GUEST_DIRTY_MASK)) {
>  			trace_kvm_mmu_set_dirty_bit(table_gfn, index, sizeof(pte));
>  #if PTTYPE =3D=3D PTTYPE_EPT
> -			if (kvm_nested_call(write_log_dirty)(vcpu, addr))
> +			/* Only the nested GPA walk yields an L2 GPA to log. */
> +			if (w =3D=3D &vcpu->arch.ngpa_walk &&
> +			    kvm_nested_call(write_log_dirty)(vcpu, addr))

[Severity: High]
Does this change miss PML logs for L2 page table modifications that occur
during an L2 gva_walk?

When KVM emulates setting A/D bits in an L2 page table (during an L2
gva_walk), it is writing to an L2 GPA. Hardware logs page table updates
to the PML buffer, so it seems KVM must do the same.

By ignoring gva_walk, does this fail to log L2 page table modifications
to L1's PML buffer, breaking L1's dirty page tracking?

Additionally, looking further down in update_accessed_dirty_bits():

arch/x86/kvm/mmu/paging_tmpl.h:update_accessed_dirty_bits() {
        ...
        ret =3D __try_cmpxchg_user(ptep_user, &orig_pte, pte, fault);
        if (ret)
            return ret;

        kvm_vcpu_mark_page_dirty(vcpu, table_gfn);
        ...
}

During a nested guest page table walk (for example, when
w =3D=3D &vcpu->arch.gva_walk for L2), walk_addr_generic() populates
walker->table_gfn with the untranslated L2 GFN of the guest page table.

When update_accessed_dirty_bits() sets A/D bits in the L2 page table,
it passes this untranslated L2 GFN to kvm_vcpu_mark_page_dirty().

Since KVM's memslots use L1 physical addresses, does looking up an L2 GFN
here cause type confusion that could corrupt L1's dirty bitmap and fail to
dirty-track the actual L1 backing page (real_gpa)?

>  				return -EINVAL;
>  #endif
>  			pte |=3D PT_GUEST_DIRTY_MASK;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015103933.2088=
307-1-nikunj@amd.com?part=3D1
