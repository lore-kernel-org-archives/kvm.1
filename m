Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682212DF13A
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331151; cv=none; b=Xv9r8NSrh5az4KfaQwGFrPwWLuFlifk0l5XbqDjuyBcevW3gqDEg1f7wUtHCPsNm8k7a36LOn7+ZgU32jIETW6P459/A/jzGfotD2CgPILA1R4IBUgzL1Zw7r+VwQ0irK6XAuW6ENR/IjB0OzfWSRbGR2oryRkD9Bgo3/TVH1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331151; c=relaxed/simple;
	bh=f28RqbbERckEWmTU5LV+8Yab65R+8OFamOu0E4xp3bo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VWGlPiIXfunNLWKlqop8iNRIelOXDcQTO720BPQmVr1GmMvUTEarHHfaPfB8rPvq6OP1HhhphXkeSc+G1lRJ9n5OEw3qovpy/+DcsCXqD3uWqONkNSNKKcPOv7ptwjqkCoGIlQabDaEXa67HB/vXdoA917ETSch1DnKj3IZRxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0jrbEUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0jrbEUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2893F1F00893;
	Mon,  1 Jun 2026 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780331150;
	bh=U2e8U0khiRkOamnvg+Xkkff/lLuvXCB6lm5f6UpDFAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C0jrbEUcgpwy//KUKc11t7Y1yOPCTd2/2cbs+SkBIBmVOYJDqv/QAFAj/Vi/brpgE
	 lJq9KRT/ddAx3p5dMpcFRRuOq7dNHWxOSeRjsh0eBeCDgs7TYaGi51Fl+6eS1W/lsj
	 z54oiwWx55YjhOmXivvhsOE03t7mH7sNY2Prh0tRcwF8WnFvtX3BJYyXrCFTvIsOGT
	 lTui16eaoiQJjCZhYaFSWNWWVmMSUE4yRtrxhz68oqg/J1m+5IE20CuKeKJhATLnKv
	 BBkzlet56AquKrhkZyTmQo9A6QOWf47e1P/fffSqF41k6nq8lcnH41Z49iV6uWKZ1W
	 OFrabQOuwnx1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] KVM: s390: Fix guest / virtual address confusion
 in _essa_clear_cbrl()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260601152951.196859-5-imbrenda@linux.ibm.com>
References: <20260601152951.196859-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 16:25:49 +0000
Message-Id: <20260601162550.2893F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] ptep_zap_softleaf_entry unconditionally calls swap_put_entries_dir=
ect for all non-present PTEs, including migration and device private entrie=
s, leading to WARN_ON_ONCE and potential reference leaks.
--

commit 9ec1cdb739d15e125c9d1bb7c4db08fb59c07068
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()

This patch fixes a bug where gmap_helper_zap_one_page was being called with=
 a
guest absolute address instead of the expected host virtual address. It
resolves the issue by converting the address to a host virtual address befo=
re
performing the zap.

> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index cc0553da14cbb..447ec7ed423dc 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
[ ... ]
> @@ -1199,8 +1200,11 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu=
, unsigned long *cbrl, int len
>  		if (!ptep || ptep->s.pr)
>  			continue;
>  		pgste =3D pgste_get_lock(ptep);
> -		if (pgste.usage =3D=3D PGSTE_GPS_USAGE_UNUSED || pgste.zero)
> -			gmap_helper_zap_one_page(vcpu->kvm->mm, cbrl[i]);
> +		if (pgste.usage =3D=3D PGSTE_GPS_USAGE_UNUSED || pgste.zero) {
> +			hva =3D gpa_to_hva(vcpu->kvm, cbrl[i]);
> +			if (!kvm_is_error_hva(hva))
> +				gmap_helper_zap_one_page(vcpu->kvm->mm, hva);
                                ^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: High]
This is a pre-existing issue, but does fixing the address passed to
gmap_helper_zap_one_page expose a bug when encountering non-present PTEs?

Looking at gmap_helper_zap_one_page in arch/s390/mm/gmap_helpers.c, it
dispatches all pte_swap entries to ptep_zap_softleaf_entry:

    if (pte_swap(*ptep)) {
        ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
        pte_clear(mm, vmaddr, ptep);
    }

In ptep_zap_softleaf_entry, swap_put_entries_direct is called
unconditionally. For non-genuine swap entries like migration or device
private entries, get_swap_device returns NULL, which causes
swap_put_entries_direct to hit a WARN_ON_ONCE and return early.

Furthermore, for device private entries, the required folio teardown sequen=
ce
(normally performed by zap_nonpresent_ptes) is completely skipped. Since
pte_clear is then called, could this lead to a permanent folio reference le=
ak
in addition to triggering a kernel warning?

> +		}
>  		pgste_set_unlock(ptep, pgste);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601152951.1968=
59-1-imbrenda@linux.ibm.com?part=3D4
