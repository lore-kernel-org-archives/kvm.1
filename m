Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FC43DFC6D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000302; cv=none; b=sZx/3zaQRVNohsY7BFD0vmEWAVVQTBrdYEU7fT+rjRETgT36Gx/On3CePD/CwAG0tt3ljg6u9ExxCvEfgSuvjfyTQFQWgKzh4fvNgGhmGR2DqhgLu0UmIdfz28c1YqbkRMpulx4y7vOF/EJR8XmxBjeUtbQaXDtl/TSqTBGQ6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000302; c=relaxed/simple;
	bh=OvrpbT/ZY16YxkcS1p8jEy1nMyCfhsspRneCnxOrToM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tcL3zSefeP3SOHhMYL0MOIKEMpxo6GxUoA7s7CTrgfxGMMCmQL3bTI5feeD4dOp6p4qFo45QYiuTPE0YjLvCSMdS7yVza02Ea9iiuaetYWtcVfB6Oyn3YsRnP8r3Dz4oBoKcO5YhR26WSH9IxyqDMo45PJK1liJt0f7dnLMxrPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJBb6kfB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJBb6kfB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73813C2BCC7
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 07:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786000302;
	bh=OvrpbT/ZY16YxkcS1p8jEy1nMyCfhsspRneCnxOrToM=;
	h=From:To:Subject:Date:From;
	b=HJBb6kfBAizaGTr67aJ4uQ5Emv+m6RFQddJ/NDkT0sWbJu3sk2a0JV6nBVwrNo9x9
	 AT4mhQWXAbQ0mmblsLyEGfYCKI3VUTpUx8QE4gkzBYM7hRwvLoc1/kjPRV7o6itsfT
	 35XNa83t0dn9syz7DcCw9TxN6jOWqZk0kyRpQEMPPirCwf2MpgQ3QtXY017BSbYJra
	 eNh/jUQfCRd4CHrmdHSlPR4JB4R0r9Fu+quGuipNSCVQPy4u8FCLarVb7jDhDxwqJ1
	 JYd4u780OerJbG/2xH+21QXSniBr/l0JWqQXeutQtHFx9dPhgWZ0VleZolFjcCeQGx
	 Ss7LRIDEFeBbw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 58879C53BC7; Thu,  6 Aug 2026 07:11:42 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221841] New: KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes
 infinite VM-Exit loop due to missing RIP advance
Date: Thu, 06 Aug 2026 07:11:41 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: f734222792@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-221841-28872@https.bugzilla.kernel.org/>
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

            Bug ID: 221841
           Summary: KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
                    VM-Exit loop due to missing RIP advance
           Product: Virtualization
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: kvm
          Assignee: virtualization_kvm@kernel-bugs.osdl.org
          Reporter: f734222792@gmail.com
        Regression: No

Created attachment 310582
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310582&action=3Dedit
Proof-of-concept exploit demonstrating infinite VM-Exit loop caused by miss=
ing
RIP advancement in KVM nested VMX eVMCS VMPTRLD handler.

When eVMCS (enlightened VMCS, Hyper-V enlightened VMCS) is enabled,=20
the nested VMX handlers for VMPTRLD and VMPTRST return directly without=20
advancing the guest instruction pointer (RIP).

Affected code paths:

arch/x86/kvm/vmx/nested.c

handle_vmptrld():
    if (evmcs)
        return 1;

handle_vmptrst():
    if (evmcs)
        return 1;


Unlike other VMX instruction handlers, these paths do not call:

- kvm_skip_emulated_instruction()
- nested_vmx_succeed()
- nested_vmx_fail()
- nested_vmx_failInvalid()

Therefore, the L1 guest RIP remains unchanged after VM-Exit handling.

Reproduction logic:

1. Enable nested VMX with Hyper-V enlightened VMCS (eVMCS).
2. Run an L1 guest.
3. Execute VMPTRLD or VMPTRST instruction inside L1 guest.

Execution flow:

L1 guest executes VMPTRLD
        |
        v
VM-Exit to L0 KVM
        |
        v
handle_vmptrld()
        |
        v
if (evmcs)
        return 1;
        |
        v
No RIP advance
        |
        v
VM-Entry resumes L1 guest
        |
        v
Same VMPTRLD instruction executes again

This creates an infinite VM-Exit loop.

Impact:

A malicious L1 guest can continuously trigger VM-Exit handling and consume
host CPU resources, resulting in denial of service.

The issue affects availability only.




Technical analysis:

The eVMCS path should behave similarly to other unsupported nested VMX
instructions.

For example, handle_vmread() correctly handles eVMCS:

    if (evmcs)
        return nested_vmx_failInvalid(vcpu);

which advances RIP through the normal VMX failure handling path.

However, handle_vmptrld() and handle_vmptrst() only return 1 without
instruction advancement.


Suggested fix:

Replace the direct return:

    if (evmcs)
        return 1;

with an error handling path that advances RIP, for example:

    if (evmcs)
        return nested_vmx_fail(vcpu,
            VMXERR_VMPTRLD_VMPTRST_WITH_EVMCS_NOT_SUPPORTED);

or at minimum explicitly call:

    kvm_skip_emulated_instruction(vcpu);


Verification:

Confirmed:

1. eVMCS VMPTRLD/VMPTRST paths contain direct return 1.
2. No RIP advancement occurs.
3. vmx_handle_exit does not automatically advance RIP.
4. VMX instructions executed in non-root mode always cause VM-Exit.
5. The issue reproduces as an endless VM-Exit loop under eVMCS.


Workaround:

Disable Hyper-V enlightened VMCS / eVMCS support.

No known CVE assigned.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
