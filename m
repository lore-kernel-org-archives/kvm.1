Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693831E845
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339478; cv=none; b=pdtYUcVD728yka75nopGR3XDE8CDTlW6MsgAeZf8xBtfFMGeCVUfg+ATNFk/b7etjxW2MjoVm4e/6tgcqBHDh9KgsHmSInjb5emODQmfJaQBhTdg4jAWCybi1fpSdMgqjPPfmv6cFvtVqOl7wsXqKkVEv0BSSWOb3gS3fxqzpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339478; c=relaxed/simple;
	bh=hOOvba2Yf9EB6gHQBmNO5ZHqZ5TyeyFEN8CfcY7/bMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/r1tdlq33f/hwpI4mh8mhjCsvwpX458Bgx7Fvng+2Pr9LU1zWLaIEKmvkgVA/B+w51v5U/Py3Z9bE89T2r7FNs5+f0Iv9dIKwNdzV35cybzEtoOLbvJYpCMGVdSz4z4K7j9R9x/hIuHo73igKXPVB8gsTfX14K36wIMx3cVTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXtEp7Lv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXtEp7Lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393111F000E9;
	Wed, 24 Jun 2026 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339477;
	bh=5EbpocBefvO/vMIlxBPaSSTIhTj35t/7thRsZQZyAGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DXtEp7LvdIy6MiAN6l+SP8ZKn3vB75JxRYWLf/tvlSvWSHANL36WKEq2dhhBfumVV
	 Q9riefqxqZyt5N5wak8O7NF2Jcc34z7Ev0Dx+syrsRGCMObqiAWrL45h5f2xmOCiKE
	 W/u/Ia92Xs0Yx8zchSf+l9U1gfARtqEBSKwUTHwNiQOQhtsYlUjn1xqMQvjMSzfnkU
	 Fu8IbAHM/c7jYkMvuMT0lLFLW/SidZSEOpejhgqo6ywTnfRLrv7fb5P1DctoD42w7a
	 zEdagTWtJqtCeR60hUfZRbiXrUoCzXJiDCySJIVUZE7gm8EfdLKFKd9WezUImrD5su
	 EOMXfRy9d9ygw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260624220516.3033391-1-seanjc@google.com>
References: <20260624220516.3033391-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 22:17:56 +0000
Message-Id: <20260624221757.393111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] pv_eoi_test_and_clr_pending() fails to clear KVM_APIC_PV_EOI_PENDI=
NG on guest memory access errors, leading to an infinite loop of spurious E=
OIs.
--

commit 8d31266dfac4b51fef59bed9e9475da6bffdd83d
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Ignore pending PV EOI if the vCPU has since disabled PV EOIs

This commit fixes a host panic by explicitly ignoring internal requests
to service pending PV EOIs if the vCPU has disabled PV EOIs since the
request was made.

> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
[ ... ]
> @@ -3382,8 +3388,6 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_=
vcpu *vcpu,
>  	 * KVM_APIC_PV_EOI_PENDING is set, KVM_PV_EOI_ENABLED is unset:
>  	 * 	-> host enabled PV EOI, guest executed EOI.
>  	 */
> -	BUG_ON(!pv_eoi_enabled(vcpu));
> -
>  	if (pv_eoi_test_and_clr_pending(vcpu))
>  		return;
>  	vector =3D apic_set_eoi(apic);

[Severity: High]
This is a pre-existing issue, but if pv_eoi_test_and_clr_pending() encounte=
rs
a memory access error, does it skip clearing the pending bit?

Looking at pv_eoi_test_and_clr_pending():

arch/x86/kvm/lapic.c:pv_eoi_test_and_clr_pending() {
    if (pv_eoi_get_user(vcpu, &val) < 0)
        return false;
    ...
    __clear_bit(KVM_APIC_PV_EOI_PENDING, &vcpu->arch.apic_attention);
    ...
}

If a guest provides an invalid memory address, pv_eoi_test_and_clr_pending()
returns false early without clearing KVM_APIC_PV_EOI_PENDING.

Will this cause apic_sync_pv_eoi_from_guest() to falsely assume the guest
performed an EOI and proceed to call apic_set_eoi() below?

Since the pending bit remains set, will KVM continue calling apic_set_eoi()
on every subsequent VM exit, erroneously clearing valid in-service interrup=
ts
and making the VM completely unresponsive?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624220516.3033=
391-1-seanjc@google.com?part=3D1
