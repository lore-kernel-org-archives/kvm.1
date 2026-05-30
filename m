Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD431E82F
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780128463; cv=none; b=XOkdtDmeCuqGoe7m/o1/GR+9j1iefaz56sk8Wx9sboXjzI5PDubrG5q+ZgiDkEIi1cYZB8ZRSthFqinWd1dotNhRvz+AZ1LDufGwXoQb/BhjFb0k6xcPIOe5BeyJAXuZXxO1ernBRClck5tCFqojNIp1ZeGq97VakTrB6tsvm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780128463; c=relaxed/simple;
	bh=xHUfe+D5+PDuXj1OkOf1YsYMYg1gquROx/UKfhpQxoE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hciBQKj17l8aUpv1tjOzejW6EarUiPTSivhFrRrg1uDEogX0rrc5oVrJ7girClzfq1noDBUEtqZx6d/bl4EzzQ3VTgSq6AQlegNknuUUmIv5oZGuZi4f48+Dq32fsCYTipS6LDt0yL5qnn8dglksE3jeqvm9C5jzxGKdCd30uwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AF347d10; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AF347d10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173DB1F00893;
	Sat, 30 May 2026 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780128462;
	bh=WG73XLiif+O/rOB5lOsz5vQQMmHYKuJUxNCbsOYR2js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AF347d10pEmom/1pmUwuJ+h0QX/Bg7RAGVRmUCr6/TrKMJPZbXKeNdyAr55u2HTCV
	 OUSEg1TSPWLuwtAluFNGsc3C+/XknBkMhO7s/OJwFpUN7KmRJbokGDX4UaWzOIoEiT
	 kCKLyg4nwpzbrhx1g5qpjeTBIE0w/4FF8RWs5JzRndRrfe85p5l34Ydy4CZeV7kWaD
	 AUEJFr1psuO/NUHzPomCReyr4U9opX37XNOSiEIfGI4tifNFZvtuS6v/8pGoT9lN1n
	 cfEct4XQ19Xn+d7V4B2J42G3SpES+UayJTG+LfP9k3kMQua4S/Bj5XOngaPdungwjf
	 hotS2gCICMf4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/24] KVM: SEV: Add an anonymous "psc" struct to track
 current PSC metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529183549.1104619-13-pbonzini@redhat.com>
References: <20260529183549.1104619-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 08:07:41 +0000
Message-Id: <20260530080742.173DB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] KVM incorrectly passes the 2M page size flag to userspace for part=
ially completed 2M PSC entries, despite forcing 4K handling.
--

commit c91cb923b18a5adb2ee4beca4e478b8c40f1fbc2
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Add an anonymous "psc" struct to track current PSC metadata

This commit groups Page State Change fields into an anonymous psc struct=20
within vcpu_sev_es_state to improve code readability. It also renames=20
several local variables to clarify that they point to guest-accessible data.
Lastly, it clarifies that inflight represents the batch size of pages.

Message-ID: <20260501202250.2115252-13-seanjc@google.com>

> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 1982d13e71d9e..9f6543cebedf5 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c

[ ... ]

> @@ -4000,14 +3995,14 @@ static int snp_begin_psc(struct vcpu_svm *svm)
>  	 * KVM_HC_MAP_GPA_RANGE exit.
>  	 */
>  	while (++idx <=3D idx_end) {
> -		struct psc_entry entry =3D READ_ONCE(entries[idx]);
> +		struct psc_entry entry =3D READ_ONCE(guest_psc->entries[idx]);
> =20
>  		if (entry.operation !=3D entry_start.operation ||
>  		    entry.gfn !=3D entry_start.gfn + npages ||
>  		    entry.cur_page || !!entry.pagesize !=3D huge)
>  			break;
> =20
> -		svm->sev_es.psc_inflight++;
> +		sev_es->psc.batch_size++;
>  		npages +=3D huge ? 512 : 1;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the Page Sta=
te
Change updates in arch/x86/kvm/svm/sev.c:snp_begin_psc(), I noticed a
potential problem when handling partially completed 2M requests.

When a 2M request is interrupted, the guest resubmits it with
entry_start.pagesize set to true and entry_start.cur_page > 0. KVM handles
this by forcing 4K handling for the remaining pages, setting huge =3D false,
adjusting npages, and advancing the gfn.

However, when KVM forwards this request to userspace via the
KVM_HC_MAP_GPA_RANGE hypercall right below this loop, it populates the page
size argument using the original guest request:

switch (entry_start.operation) {
case VMGEXIT_PSC_OP_PRIVATE:
case VMGEXIT_PSC_OP_SHARED:
    ...
    vcpu->run->hypercall.args[2] |=3D entry_start.pagesize
                                    ? KVM_MAP_GPA_RANGE_PAGE_SZ_2M
                                    : KVM_MAP_GPA_RANGE_PAGE_SZ_4K;

Could this result in passing KVM_MAP_GPA_RANGE_PAGE_SZ_2M along with a
4K-aligned (but not 2M-aligned) GPA and a non-512-multiple page count?

If host userspace performs alignment checks on the mapping request, would
this cause it to reject the malformed hypercall and fatally terminate the V=
M?

Would it be safer to use the adjusted huge boolean instead of
entry_start.pagesize when populating these arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529183549.1104=
619-1-pbonzini@redhat.com?part=3D12
