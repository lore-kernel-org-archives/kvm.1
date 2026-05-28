Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D73D6491
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969122; cv=none; b=oF/On4vzLjcvNPJ+SpZL2kATi2dVG6WLkZJtGoW/J9N0W7ouw+0jc+txua89ZgTwMusg1uuiFer8BT03/zFSSNeuU8eJRIgfwYv/TABFdxqdn6ErhqQ8ZhlLr/uk7CbP5jP0Xv4U8p6X3x/htuCKpZS7pYmVIvyiclwcNkzpm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969122; c=relaxed/simple;
	bh=uijUlhCxWFyaC6NH0gBD7Auyr6UAYE9YXA7OZ3tctwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GuEQWioV8f45g7Bx6q0dWBsV+ktLK+rKyQVEua8afb/FJxty/ox1j2Rf2f0UezHjU5fEA7+ampedljXKiKsyJSRtEHSRi2ZavIkm3t1PnPPGILNVDvSV/bsxVq960ZuMw2t5qHIPMypGwLXrf60xOvJ9tW9/aMjXH3w0vQOgFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drmycm+n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drmycm+n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CEC1F000E9;
	Thu, 28 May 2026 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969121;
	bh=RKZm9ELsP4UxUlZVU/9W9Uw8SP69XP1g3dAoKEX147g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=drmycm+nOxHoKWhdSsZgDpQw7GmSSC8lDCDrI5kBeM7f9o7SOkMOJoteSZxom6I8O
	 PD5smpgpZyNhjqjohdWf9cwk6OmwBlr262EeL84L9BxZ2hVRvx+CUtYYyrdq3DA8HO
	 l1eVEPXWO9F4aMhEuNSbZnFSjsP/sldeFkjGKC+qSsMtG3m7jYKwUSCIXbGsLTo/BJ
	 IuMCoIEow0KsKQmRtpY/ZKUre67WjuxZ8X7eRpSJGgyFo+V8e3cLXd8xEcsm/T6/yI
	 ghO7Aj0GjtlQQaOuxmkwkhOmaKs1VXZhvidpUVrETQbQpBzuHSQQUvTqB07Vgn3TJC
	 WfTX+Rg9m8NGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] KVM/x86: Change comment before KVM_MSR_RET_*
 defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Juergen Gross" <jgross@suse.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260528113605.267111-2-jgross@suse.com>
References: <20260528113605.267111-2-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 11:52:00 +0000
Message-Id: <20260528115200.E6CEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The commit message and comment change incorrectly dictate the =
use of negative errno values instead of `1` for MSR emulation failures, whi=
ch misunderstands KVM's return code semantics and causes fatal VM exits.
--

commit 71177dccfb6890950255b0c75cdd52620e26871f
Author: Juergen Gross <jgross@suse.com>

KVM/x86: Change comment before KVM_MSR_RET_* defines

This commit updates the documentation and comments for MSR emulation return
codes in KVM. It advises replacing the return value "1" with negative errno
values for error cases.

> Replace it with a statement that it is fine to use negative errno
> values, 0, and the special MSR emulation return values defined.
>
> Don't mention the value "1", as current cases where MSR emulation is
> returning "1" should be modified to return a negative errno value
> instead.

[Severity: Critical]
Does replacing "1" with negative errno values cause fatal VM exits instead
of injecting a #GP into the guest?

Looking at how KVM handles MSR emulation, a return value of 1 (or
KVM_MSR_RET_UNSUPPORTED) allows the code to fall through to
complete_emulated_msr(), which safely injects a #GP into the guest and
resumes the vcpu_run loop.

If a negative value is returned instead, __kvm_emulate_wrmsr() catches it
and returns immediately:

__kvm_emulate_wrmsr() {
        ...
        if (r < 0)
                return r;
        return complete_emulated_msr(vcpu, false);
}

This negative value propagates up through the exit handlers to vcpu_run(),
where it breaks the guest execution loop:

vcpu_run() {
        ...
        if (r <=3D 0)
                break;
        ...
}

This returns the negative errno directly to userspace, which typically
causes the VMM (like QEMU) to abort the VM.=20

Since guest OSes routinely probe MSRs and expect a #GP for unsupported
registers, will changing these to negative errno values cause VMs to crash
during normal operation?

> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 38a905fa86de2..5ca2f3d44092c 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -675,8 +675,8 @@ enum kvm_msr_access {
>  /*
>   * Internal error codes that are used to indicate that MSR emulation enc=
ountered
>   * an error that should result in #GP in the guest, unless userspace han=
dles it.
> - * Note, '1', '0', and negative numbers are off limits, as they are used=
 by KVM
> - * as part of KVM's lightly documented internal KVM_RUN return codes.
> + * Other than these internal error codes negative errno values can be us=
ed for
> + * error cases, or 0 for success.
>   *
>   * UNSUPPORTED	- The MSR isn't supported, either because it is completely
>   *		  unknown to KVM, or because the MSR should not exist according

[Severity: Critical]
Is this comment update accurate regarding KVM's return code semantics?

As noted above, negative numbers bypass the #GP injection logic and are
treated as fatal errors by the vcpu_run loop. The original comment appeared
to correctly warn that negative values are part of KVM's internal KVM_RUN
return codes and should not be returned by MSR handlers directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528113605.2671=
11-1-jgross@suse.com?part=3D1
