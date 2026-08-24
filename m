Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9F4052DE
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579516; cv=none; b=LOOuoQl943jL75UQRMJGSnAsI8I+tSwIc4bMaLxj2pwu9j1pn8nOPWs1ZK8x9lDnwnjIOvHFsSdubIauDJhbrwpHGn18WkQaerloOt0bvbvaNmV70vUTzIWQOoDpS1vO9Hg1v7U1U4iJ7poINGa2d9YqqbwTsKwy8CxafkI1eY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579516; c=relaxed/simple;
	bh=x5M5/q/IBl1wCtgChbPXsNXn9NVLzVCChR73VaVsRC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZaMrktLp76QqYdf0JJPow3T3CbMJelkAazIzH74FJgfs6+tUMiy29CqMHRJxBPdMPgU9YlSaYO7/sfmuEyciWNXT1c4uZhk05BwYthngtPNLphfLq5Hm+r2zSWcu6Xppno/Mo/+RbUcCVmchNdo6LgKPcMrP4YRnFEkKzfAcFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8Q1ikRn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Q1ikRn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0A41F000E9;
	Mon, 24 Aug 2026 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787579515;
	bh=7XADFKDUdCLWndCv55alOhsuc/O78USbRxX8wTzvf1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I8Q1ikRnutY7w6UzYSwTTvU+r1t5f8T4n+EzJIwKiTNi2d9L0A19v/9nqxrkpJxbN
	 FgSMUiRVYwOFLDBYqjUPdoQkAI9I5i9qFQKvQ7MbnL7lWEz/3svAY1D5EB3KcPsWW6
	 vfQpgIYMIDbk6hATQtLZ4JK9+KcnhRaSnQNpY/I3DyKizbi7ZETL8qqz9jW149fURe
	 80sFNAqRzv5HYGUuSJQxLWYkf67Z1+Qltk+fMZulkmhRi3fma9LjAl4vspV/1piVvG
	 wtzXRBIWQubkHZciYT4HTZuhihBv33uC5djdqi6WJqYQhn1NnAkF9NCDCWX8ZnUMHJ
	 rauugX8UgAqIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMCB
 on shutdown intercept
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260824131824.6040-1-shivansh.dhiman@amd.com>
References: <20260824131824.6040-1-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:51:54 +0000
Message-Id: <20260824135155.6B0A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `clear_page(svm->vmcb)` leaves the `control->event_inj` a=
nd `control->event_inj_err` fields intact across a SHUTDOWN reset, causing =
KVM to spuriously inject stale events into the newly reset guest and leadin=
g to an immediate crash or triple fault.
--

--- Patch [1]: [PATCH] KVM: SVM: Clear VMCB save area instead of entire VMC=
B on shutdown intercept ---
commit 887c839299b43bfbaf990edaf22e0335bb4c3119
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: SVM: Clear VMCB save area instead of entire VMCB on shutdown intercept

This commit updates KVM's handling of intercepted shutdowns for AMD SVM.
Instead of clearing the entire VMCB, it now only clears the save area and a
few undefined fields in the control area, aligning with updated APM
specifications.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
[ ... ]
> @@ -2164,18 +2164,23 @@ static int shutdown_interception(struct kvm_vcpu =
*vcpu)
[ ... ]
>  	if (!is_sev_es_guest(vcpu)) {
> -		clear_page(svm->vmcb);
> +		struct vmcb_control_area *control =3D &svm->vmcb->control;
> +
> +		memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
> +		control->int_ctl &=3D ~GENMASK(15, 0);
> +		control->int_state =3D 0;

[Severity: High]
Since clear_page() was replaced with targeted clearing, do we also need to
clear control->event_inj and control->event_inj_err here?

According to the AMD APM, hardware does not clear the EVENTINJ field in the
VMCB on a VM exit, which leaves the VALID bit set if an exit occurs during
event delivery (such as a triple fault leading to SVM_EXIT_SHUTDOWN).

If the EVENTINJ field is left intact across this shutdown reset, will KVM
execute the subsequent VMRUN with the stale EVENTINJ_VALID flag still set?

Could this cause KVM to spuriously inject the old fault into the newly
reset real-mode vCPU on its first instruction, leading to an immediate
crash or an infinite triple-fault loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824131824.6040=
-1-shivansh.dhiman@amd.com?part=3D1
