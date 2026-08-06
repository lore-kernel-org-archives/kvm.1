Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F04364926
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024889; cv=none; b=jCNocWEq9gtLaSuMlYFWtKdNz7LdtM9Vwh6Jn3+HYuzmHYvgKqD03WW1v5Rj1ZScao3J22i8DoMCvSr6AwCps7DjgveWfoQKqER+uRAJeUO+MqjFtBulIEFEQGWhsuydL9mG5bhRdCjthytrg6wW8It0LH4aK/14NBSUZtlukQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024889; c=relaxed/simple;
	bh=UPf+0uK/gkzrofEyf2xLzHrc4NO5DT6+A4JeQMM0n54=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jJ/tKa8ewwmKvfaxjIp2uGN9aR4DNFmoUhKRV4s81xxiNvYDYsrA+kbm1f/ZXfiFd42mVv7aOTJbT0AsLUFJ2NLKNb+gWh6OrYUdLmv2doDCahRnlcS3rhDwyIUveYh2bynSz65KuAud0N9dnmBBUQkYKCV7A8k/omjHtpTK6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKko7ibN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKko7ibN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B2F3C2BCFA
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786024888;
	bh=UPf+0uK/gkzrofEyf2xLzHrc4NO5DT6+A4JeQMM0n54=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rKko7ibN/oFCqDfRjTBC/rKUERvs3da65JINkOXfmBQZlSbtFEwvSAqUBxlVJGXYe
	 8zILJmp/OKAaQJ0AB+8bslPJ5bV/GjALZmDomfJk4aZ7FvswP8G3776eb2weZO5opG
	 DQb0vSCI8JTo+6P8ooAw2Kbu65QCCPt9UXR71VFDrMPgOIfck/hLZo7yK9C5zBSE8/
	 ODdjyBM+n6vDQQiif2XR7zlB+2voaUjV7IiDufDRlmvW7v+KyAw4//O1C9EysCjDcP
	 fNxkhCbmMD9HBId1bKo/g7V2VC7f1jKTOFWsJ6GfyXLsjdJBkAzRWVXzvBCC4rN2Po
	 WZcMRZ+7pyCkw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7437BC53BC7; Thu,  6 Aug 2026 14:01:28 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221841] KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
 VM-Exit loop due to missing RIP advance
Date: Thu, 06 Aug 2026 14:01:27 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: seanjc@google.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221841-28872-PDwcCWjWBt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221841-28872@https.bugzilla.kernel.org/>
References: <bug-221841-28872@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221841

--- Comment #1 from Sean Christopherson (seanjc@google.com) ---
+Vitaly

On Thu, Aug 06, 2026, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221841
>=20
>             Bug ID: 221841
>            Summary: KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
>                     VM-Exit loop due to missing RIP advance
>            Product: Virtualization
>            Version: unspecified
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: high
>           Priority: P3
>          Component: kvm
>           Assignee: virtualization_kvm@kernel-bugs.osdl.org
>           Reporter: f734222792@gmail.com
>         Regression: No
>=20
> Created attachment 310582
>   --> https://bugzilla.kernel.org/attachment.cgi?id=3D310582&action=3Dedit
> Proof-of-concept exploit demonstrating infinite VM-Exit loop caused by
> missing
> RIP advancement in KVM nested VMX eVMCS VMPTRLD handler.
>=20
> When eVMCS (enlightened VMCS, Hyper-V enlightened VMCS) is enabled,=20
> the nested VMX handlers for VMPTRLD and VMPTRST return directly without=20
> advancing the guest instruction pointer (RIP).
>=20
> Affected code paths:
>=20
> arch/x86/kvm/vmx/nested.c
>=20
> handle_vmptrld():
>     if (evmcs)
>         return 1;
>=20
> handle_vmptrst():
>     if (evmcs)
>         return 1;
>=20
>=20
> Unlike other VMX instruction handlers, these paths do not call:
>=20
> - kvm_skip_emulated_instruction()
> - nested_vmx_succeed()
> - nested_vmx_fail()
> - nested_vmx_failInvalid()
>=20
> Therefore, the L1 guest RIP remains unchanged after VM-Exit handling.
>=20
> Reproduction logic:
>=20
> 1. Enable nested VMX with Hyper-V enlightened VMCS (eVMCS).
> 2. Run an L1 guest.
> 3. Execute VMPTRLD or VMPTRST instruction inside L1 guest.
>=20
> Execution flow:
>=20
> L1 guest executes VMPTRLD
>         |
>         v
> VM-Exit to L0 KVM
>         |
>         v
> handle_vmptrld()
>         |
>         v
> if (evmcs)
>         return 1;
>         |
>         v
> No RIP advance
>         |
>         v
> VM-Entry resumes L1 guest
>         |
>         v
> Same VMPTRLD instruction executes again
>=20
> This creates an infinite VM-Exit loop.
>=20
> Impact:
>=20
> A malicious L1 guest can continuously trigger VM-Exit handling and consume
> host CPU resources, resulting in denial of service.

No, it doesn't.  There are no "host CPU" vs. "guest CPU" resources, it's all
just
physical CPU resources.  Whether the CPU is running guest code or host code=
 is
irrelevant.  What matters is that KVM honors NEED_RESCHED (especially on
non-preemptible kernels, i.e. before PREEMPT_LAZY came along), which it very
much
does in the slow path VM-Entry/VM-Exit loop.

> The issue affects availability only.

Only the availibility of the L1 hypervisor.

> Technical analysis:
>=20
> The eVMCS path should behave similarly to other unsupported nested VMX
> instructions.

Only if the TLFS allows it.  I assume it just says "unsupported" or "undefi=
ned
behavior", i.e. KVM can probably do whatever it wants.  Vitaly?

> Replace the direct return:
>=20
>     if (evmcs)
>         return 1;
>=20
> with an error handling path that advances RIP, for example:
>=20
>     if (evmcs)
>         return nested_vmx_fail(vcpu,
>             VMXERR_VMPTRLD_VMPTRST_WITH_EVMCS_NOT_SUPPORTED);

VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID is probably the best fit?

> or at minimum explicitly call:
>=20
>     kvm_skip_emulated_instruction(vcpu);

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
