Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A793E5EEA
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094260; cv=none; b=sEucojpbD/bhNCvqFFB6JEwhxrkbdNGDR1NXc+LnjdWHx/V1hBQyD1pOLyXonuvO2poYyXatS220EkQ2HwKSQXUdVbV0ieXx/kXu4QnihXSxkMXEFl1tWDyQuRFgosmf+F5EjKObhx0E7rXD5ODohF8igutQB1d3NNSE316swVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094260; c=relaxed/simple;
	bh=MGKLlq36HiHXlGe5g/y71kKbHJHwTgRVaDtmJJX9xPM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f4fAc2fkoezBOaJPvjHlP1JRbrjBIxuLtamIBgkAj/xEZn/u9RVpMS0mR0prJwipeSlUpTrbYWwv4+y9JdwMmNeASJsZCXSkSe21oF8Hpi14TPc5lF2F4s5pSzobiDJts8jJGr047fNRUQZp/InoidPZ5rES5zItoTDYEcBxHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIScS8co; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIScS8co"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 179D4C2BCF5
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786094260;
	bh=MGKLlq36HiHXlGe5g/y71kKbHJHwTgRVaDtmJJX9xPM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cIScS8co0bfip4FdkkvZg6k7TVyUGckxGxe6IWRLPH8mVZVLKi9N3Jha+fxS6WoP9
	 7pjaWzYgIJUQbp93lzU17jXZooQhLZ/GCXVs9JnkZTq+e9w03+5WqARRUGH/tDCz2l
	 A3i9Sn4HTIkAE6hsABxBoGDQK7j0MHTPkMIgPzxfhpADUTwIVvlr+S/m/IQOMUKU4y
	 O3lEV1d0Q/Z7/SS0yTGgcNj7/VhUpMg5aRJSFjiQrNusHHtObiIXie4/Vj/Jyai87h
	 GFkJlogXYg0Rnt6UGPJ2B9OBoHxq8Tk+cZ8me5uk1Nfa3U01VKTgbW1oILFi8aYbYL
	 MJTY4dbuPWNug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 0466DC53BC9; Fri,  7 Aug 2026 09:17:40 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221841] KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
 VM-Exit loop due to missing RIP advance
Date: Fri, 07 Aug 2026 09:17:39 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: vkuznets@redhat.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221841-28872-H4VjyfTP92@https.bugzilla.kernel.org/>
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

vkuznets@redhat.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |vkuznets@redhat.com

--- Comment #2 from vkuznets@redhat.com ---
(In reply to Sean Christopherson from comment #1)

> >=20
> > A malicious L1 guest can continuously trigger VM-Exit handling and cons=
ume
> > host CPU resources, resulting in denial of service.
>=20
> No, it doesn't.  There are no "host CPU" vs. "guest CPU" resources, it's =
all
> just physical CPU resources.  Whether the CPU is running guest code or ho=
st
> code
> is irrelevant.  What matters is that KVM honors NEED_RESCHED (especially =
on
> non-preemptible kernels, i.e. before PREEMPT_LAZY came along), which it v=
ery
> much does in the slow path VM-Entry/VM-Exit loop.
>=20
> > The issue affects availability only.
>=20
> Only the availibility of the L1 hypervisor.

Yes, basically, misbehaving L1 hypervisor can shoot itself in the foot.

>=20
> > Technical analysis:
> >=20
> > The eVMCS path should behave similarly to other unsupported nested VMX
> > instructions.
>=20
> Only if the TLFS allows it.  I assume it just says "unsupported" or
> "undefined behavior", i.e. KVM can probably do whatever it wants.  Vitaly?

VMREAD/VMWRITE with eVMCS are explicitly called 'unsupported' in the TLFS:

"Any VMREAD or VMWRITE instructions while an enlightened VMCS is active is
unsupported and can result in unexpected behavior.".=20

As for VMPTRLD, we only have
"No VMPTRLD instruction must be executed to make an enlightened VMCS active=
 or
current." but there's nothing about the expected result there. VMPTRST is n=
ot
mentioned.=20

So I guess we can do whatever we want in KVM and skipping the instruction is
not a bad thing. Ideally, we can try and see what genuine Hyper-V gives us =
in
this situation (by e.g. running an instrumented version of KVM there). It d=
oes
not seem that we have an extreme urgency here so I can put it to my backlog=
 and
try to get to it some time next week -- unless someone beats me to it of
course!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
