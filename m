Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3842C367F4D
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110978; cv=none; b=I4BBOUBWw+dav195xXFimkJWm3lqcLu5THpwChV5TAzKf4OK7UfO+mQMr1jr/OSVCywjm7PDHmYll0VLzn/9XAO0DCzdqfl1gq3wlU1SF9goffidYcPZGXoFuCVkyxhguOH8uhJRn4loTXHBRPi7sUTq2DuWeWvJO9JhFJdKCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110978; c=relaxed/simple;
	bh=8836WRUEapfuU7tOOjyv6OE1GpzsJEzvHvkU5WNy+8I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+q6FJ8aVoz9Wv33ASiZUGo9uBjcB+u+H0ZBPcAQGK58EUKuYbHbVwRYJSZdBIG5uUk3HkcInHyXDfyRn24ngwXwOJ8iLuFYhtN6PMHHMCT/U8YCKn55yfG0dyInLbdZgFvQjxQ3fQIIN158QywlZsWaFjOSZmevXH/JW4IKcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfnjVndF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfnjVndF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4294EC2BCF7
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786110977;
	bh=8836WRUEapfuU7tOOjyv6OE1GpzsJEzvHvkU5WNy+8I=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HfnjVndFfKpYs/2zeWmzkqOUfBK/Bz1EhcXyn2q1VFTpbySu40XtnUlOyRIR2tkwA
	 z/w3S4I5k6mF3IiQdrpqlmkW+5hfyXCLusZuyBmPGYyruomcfw8UllGMpiPVPJMNsu
	 yTcEySvGrMkaEF3eVcxb21SZSEYc4NbgMVzgEbM83UVGVJtbLPb6LuLS+qnN+mK5p5
	 De3jKphP1pmJODBysM108F5MmCcaEjf8jA1li23s9Gt425khT86yW0UgXZeK2tFlIE
	 nspMroO+P1EaNShiF9Oo72M/iKoH5oicp1J8RnzLHzVrbUsGtWApb0GkieCot35m10
	 R5dk14b9wFSFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2ACFBCAB780; Fri,  7 Aug 2026 13:56:17 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221841] KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
 VM-Exit loop due to missing RIP advance
Date: Fri, 07 Aug 2026 13:56:16 +0000
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
Message-ID: <bug-221841-28872-fDgDl2o1z7@https.bugzilla.kernel.org/>
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

--- Comment #3 from Sean Christopherson (seanjc@google.com) ---
On Fri, Aug 07, 2026, bugzilla-daemon@kernel.org wrote:
> > > The eVMCS path should behave similarly to other unsupported nested VMX
> > > instructions.
> >=20
> > Only if the TLFS allows it.  I assume it just says "unsupported" or
> > "undefined behavior", i.e. KVM can probably do whatever it wants.  Vita=
ly?
>=20
> VMREAD/VMWRITE with eVMCS are explicitly called 'unsupported' in the TLFS:
>=20
> "Any VMREAD or VMWRITE instructions while an enlightened VMCS is active is
> unsupported and can result in unexpected behavior.".=20
>=20
> As for VMPTRLD, we only have
> "No VMPTRLD instruction must be executed to make an enlightened VMCS acti=
ve
> or
> current." but there's nothing about the expected result there. VMPTRST is=
 not
> mentioned.=20
>=20
> So I guess we can do whatever we want in KVM and skipping the instruction=
 is
> not a bad thing. Ideally, we can try and see what genuine Hyper-V gives u=
s in
> this situation (by e.g. running an instrumented version of KVM there).

Heh, I agree, so long as Hyper-V's behavior is to either signal VM-Fail or
inject
an exception of some kind.  If Hyper-V loops (like KVM does) or skips the
instruction without synthesizing an error of some kind, then I think we sho=
uld
diverge from Hyper-V, as not signalling failure of some kind is pretty gros=
s.

If we diverge from Hyper-V, think my vote would be to inject #UD or #GP,
because
for all intents and purposes VMPTR{LD,ST} become unsupported instructions.=
=20
E.g.

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 7ed79894d11d..e743c892eeb8 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5888,6 +5888,12 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
        if (!nested_vmx_check_permission(vcpu))
                return 1;

+       /* Forbid normal VMPTRLD if Enlightened version was used */
+       if (nested_vmx_is_evmptr12_valid(vmx)) {
+               kvm_queue_exception(vcpu, UD_VECTOR);
+               return 1;
+       }
+
        if (nested_vmx_get_vmptr(vcpu, &vmptr, &r))
                return r;

@@ -5897,10 +5903,6 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
        if (vmptr =3D=3D vmx->nested.vmxon_ptr)
                return nested_vmx_fail(vcpu, VMXERR_VMPTRLD_VMXON_POINTER);

-       /* Forbid normal VMPTRLD if Enlightened version was used */
-       if (nested_vmx_is_evmptr12_valid(vmx))
-               return 1;
-
        if (vmx->nested.current_vmptr !=3D vmptr) {
                struct gfn_to_hva_cache *ghc =3D &vmx->nested.vmcs12_cache;
                struct vmcs_hdr hdr;
@@ -5961,8 +5963,10 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
        if (!nested_vmx_check_permission(vcpu))
                return 1;

-       if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu))))
+       if (unlikely(nested_vmx_is_evmptr12_valid(to_vmx(vcpu)))) {
+               kvm_queue_exception(vcpu, UD_VECTOR);
                return 1;
+       }

        if (get_vmx_mem_address(vcpu, exit_qual, instr_info,
                                true, sizeof(gpa_t), &gva))

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
