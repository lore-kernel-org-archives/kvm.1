Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77F83644B6
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774210980; cv=none; b=Hj7WFBRxnbMk6mziwoEZ4vYlWs+JilPsr3Fc3wHk1sNNGiDiIT0QZa2YoPYVRpNZl5JGgx92i6+lelgTtik+mdtPURcMN3uK2JEHvmTOJIdmHd3a4u5jOwfHllIGmwM9XtRjXSy4S6b7ZQYKtx5RlPZA0juvgfOXByH22cpeh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774210980; c=relaxed/simple;
	bh=ZcPYg3A6dHlJXR7ekuRpuqwD/DVlMxIVlTMPSlXUDKo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u8dC/q7iDTyTBAZg2LcoGa5DVKuxlZuVSeINPbzB14m9mkHkYsVhSHJiluexNJJo+MFKbhW62lcfWbVua9heLpBwUPmHkWj6BdyQCp17yH6+kosLIyeTBzeBoBvwKGjJyASwsdFDzSlLyQlVRcyUfWjQoRl3poCekfuc62O13YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnwEtdt/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnwEtdt/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B309C2BCB3
	for <kvm@vger.kernel.org>; Sun, 22 Mar 2026 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774210980;
	bh=ZcPYg3A6dHlJXR7ekuRpuqwD/DVlMxIVlTMPSlXUDKo=;
	h=From:To:Subject:Date:From;
	b=jnwEtdt/uzYH1KgRcWeiZHJpNskWwvfrL05hK6P+zfROz8Q7VdW8jayZClIRj9go+
	 ccg6fwh5luMnGfv2/px4VV1+d8tve9rbx3T1IQSyV3XVfKwJLbA6mgwKJ7fRqVPAO6
	 4QZH3GieclgzKIPbK8cyUNid4UCI+nY/MhcUnPEISBXWZeo4uMhOgM2cib+8uggIhJ
	 jqzSMvN+6MAxFX1RCRoBs68fflQtZEKgUIFXeIf+eL0xFJO4fT1qHObpZZMY767CD0
	 GHZHeu7WDE3YXbI08WmcvFM08hztUKakNJrBg/U2rSiTz1Rz4zBORTicZaX+FYaojU
	 861INP0+ZQpNQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 428B7C53BC7; Sun, 22 Mar 2026 20:23:00 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221269] New: Linux kernel (6.18-6.19) memory leak issue QEMU
 GPU-Passthrough (RDNA3 ?)
Date: Sun, 22 Mar 2026 20:22:59 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: hitomiyukinori@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221269-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221269

            Bug ID: 221269
           Summary: Linux kernel (6.18-6.19) memory leak issue QEMU
                    GPU-Passthrough (RDNA3 ?)
           Product: Virtualization
           Version: unspecified
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: kvm
          Assignee: virtualization_kvm@kernel-bugs.osdl.org
          Reporter: hitomiyukinori@gmail.com
        Regression: No

System Info
Void 6.14.11_1 x86_64 AuthenticAMD uptodate rrrmFFFFFFFF
Ryzen 5 3600
ASUS DUAL RX 7800 XT

Package(s) Affected
linux6.18-6.18.19_1, linux6.19-6.19.9_1

Hello, I recently discovered a very strange cause of memory leakage, The le=
ak
was detected in cases where the following versions of kernels were used :
6.18.19, 6.19.9. Resources (RAM usage) are not properly released when the s=
ame
QEMU virtual machine is turning off. This only happens when gpu-passthrough=
 is
used.

Expected behaviour

When I use gpu-passthrough with kernel 6.14.11_1, before powering on the
virtual machine, overall ~ 950 megabytes of RAM is used (checked via ssh+ht=
op),
I=E2=80=99m allocating 14,400 megabytes (14.4GB) of memory for VM, powering=
 on the VM,
and getting something around ~ 14.9 GB overall is used (my hook script offl=
oads
display manager and daemons).

When I make a cycle, power-on, power-off, repeat, like 5-6 times, i am gett=
ing
stable results regarding memory allocation / memory used. ~ 950 megabytes w=
hen
the VM is OFF, 14.9 GB when the VM is ON

Actual behaviour

Every "power-on, power-off" cycle, something around ~ 300 megabytes of RAM =
gets
stuck somewhere and can=E2=80=99t be released. Every "power-on, power-off" =
cycle i am
getting +~300 mb of RAM added to overall "used" / "allocated" by host syste=
m.

Steps to reproduce

That is how it works with kernels 6.18.19, 6.19.9 :

1) VM powered OFF, ~950 mb of overall RAM used, VM powered ON, ~ 14.9 GB of
overall RAM used, repeating the cycle

2) VM powered OFF, ~1.2-1.3 GB of overall ram used now, VM powered ON, ~
15.2-15.3 GB of overall ram used now, repeating the cycle

3) ~1.6-1.7 GB of overall ram used now. VM cannot be powered on, because QE=
MU
cannot allocate 14,400 megabytes (14.4GB) of memory for VM now. Because 15.=
3 GB
+ 300 MB > Total ram available

This is how memory leakage occurs, without any new running processes, witho=
ut
changes inside VM, just powering-on VM, powering-off VM, leakage occurs by
repeating this cycle.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
