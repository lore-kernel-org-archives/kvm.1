Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21C3009F2
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306766; cv=none; b=tChOwG2e5XsrlFDMaWjz8Gte31zxCDeujr56wWS/frGV6HnyOXVg+NsPjy4nTRnxgJzBbwW/IAm9xmNzvGfaFIw/9eQ2dQJvChfps+Vg3s8pcE8K03BVA+ZU0wkyMa0ut7exMPN0UqOA2IE2oiuaBdOaSrkU+KIyxstnRzFJRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306766; c=relaxed/simple;
	bh=9xLY++5UkHPsjEDCVbEVhrBCAlqRS+ZNANpAnHDaV8M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TFDIKEl8n86xsp9doQIg8ZLNQFVGd2csyKsCnyLLiWFX/WdNsP5HNS6juZZ0vfp1ZEcDMmCWs5N0NtI7p7ub7F2tRzAyHtyULd+O1K/snimspugUnfKIyA6G96KXfqP4X7ee4TM30R6QYe02Cw/6rcjKpXJ5VQ8qyBsMpvBTDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+jiQVoE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+jiQVoE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146F41F0089B;
	Tue,  6 Oct 2026 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791306765;
	bh=Zd7wdTTJ9I0TkFzwFvxOlHAkJXtyKBM/aDLN8UQG54Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+jiQVoEiBo9lpGX7I/dbdfLhuQAlLjslDJ0mn7BusvW8CwTpePYENu5KKiUbTb65
	 L2L9/6iXXZ+wSMCv1UL0RVzeg8oRB7t+CYpxz6Ma1OyumlB2FcrDx1HyxYPsQK908Q
	 XNFS8lDn7RzKole4KXP4+O4yOu4S59d4xzZzECxKC58f6BhwpZswEvkGzAoWTASGgS
	 6cD+SN0MZA4KyRqb7AeSqn7d+eDllSR6yvq6ZGVThNkyDaKRhzJFVO29cw/neVpE9m
	 Q6HnLl+dFiFtyJbQYvTHV6ILKZkKZLAD+AFv8TxreO8J9X/LDMAlD9deAhgSn3OINZ
	 4rKnmscT+8VDw==
Message-ID: <sashiko-outbox-162296@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v2 1/4] KVM: SVM: Re-queue events that were never
 injected
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <06cc309d12d59aed6d4b36688d8ef37fe8b089ea.1791302373.git.prsampat@amd.com>
References: <cover.1791302373.git.prsampat@amd.com>
 <06cc309d12d59aed6d4b36688d8ef37fe8b089ea.1791302373.git.prsampat@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 17:12:44 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: svm: unconditional use of non-zero EVENTINJ without VALID che=
ck clobbers EXITINTINFO
--

commit ccdc89849239002e8efbee8f8c5f359259c07989
Author: Pratik R. Sampat <prsampat@amd.com>

KVM: SVM: Re-queue events that were never injected

This commit modifies SVM to re-queue undelivered events from the EVENTINJ
field to EXITINTINFO upon #VMEXIT. It accommodates cases like Enhanced SMT
Protection where VMRUN might stall and exit without entering guest mode.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d0971685034b9..e2be2cd86c320 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c

[ ... ]

> @@ -4323,6 +4324,27 @@ static void svm_complete_interrupts(struct kvm_vcp=
u *vcpu)
>  	svm->nmi_l1_to_l2 =3D false;
>  	svm->soft_int_injected =3D false;
> =20
> +	/*
> +	 * Hardware clears EVENTINJ field when it injects an event.
> +	 * A non-empty EVENTINJ on #VMEXIT means the vCPU never entered guest
> +	 * mode, and thus that the event was never delivered.  Migrate the event
> +	 * to EXITINTINFO so that it's requeued instead of being dropped.
> +	 *
> +	 * An undelivered event doesn't imply a fatal VMEXIT_INVALID. With
> +	 * Enhanced SMT Protection, VMRUN may exit with an ordinary #VMEXIT
> +	 * without having injected that event into the guest.
> +	 *
> +	 * Clobbering EXITINTINFO is safe precisely because the vCPU never
> +	 * entered guest mode.
> +	 */
> +	if (control->event_inj) {

[Severity: High]
Is it possible for a stale EVENTINJ to clobber a valid EXITINTINFO here in
svm_complete_interrupts() in arch/x86/kvm/svm/svm.c?

By checking for a non-zero value instead of checking the explicit VALID bit,
this path might unconditionally overwrite EXITINTINFO when EVENTINJ has a
leftover value with its VALID bit cleared.

Since initial nested parameters and valid bit clearance are permitted by
KVM's nested_svm_check_event_inj(), would a hardware exit with a valid fault
record in EXITINTINFO be overwritten by the stale EVENTINJ?

Could this lead to silent dropping of legitimate L2 hardware events such as
page faults, debug exceptions, or machine checks during event delivery,
resulting in nested guest corruption?

> +		control->exit_int_info =3D control->event_inj;
> +		control->exit_int_info_err =3D control->event_inj_err;
> +		control->event_inj =3D 0;
> +
> +		exitintinfo =3D control->exit_int_info;
> +	}
> =20
>  	/*
>  	 * If we've made progress since setting awaiting_iret_completion, we've

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791302373.gi=
t.prsampat@amd.com?part=3D1
