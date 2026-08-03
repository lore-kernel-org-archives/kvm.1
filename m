Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79B392C25
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763463; cv=none; b=rMVuQE3zueQwpSIR3uyyVoAFGGg+VmMum8qmNgcvFeO1kMu+9mm6zIZg/Q3TBymmXExpVtut+x/ZJA08bsNtPafdwzn28nRbX5KKgbRr6+YnqVrkeopkc6qruv2xn9p1I7a1KaQ1nq3gycphhDhS9IDCRpW2J8urySOv6YWxfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763463; c=relaxed/simple;
	bh=W1djI4dHt9J6W2YZZbiUKPFR/+aZEQNczVX8UCmnIa0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UQUXtQpoRr206toAIM4b5goSZc0zDOzW32+2TZuPKFcE9rd4IwcJLeZLtV5+jmdrcvPdn5akokiUqPLKx6DGrP/y7PCo/shsNUazg+Gc9OI+SjAvvT/nipeGJ0TxLJcz0qU5u/rwFtsNQ3E70/Zd6I0dQ3XHg9h8a0F9f1Vrwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntjFO6i/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntjFO6i/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14A74C2BCF7
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785763461;
	bh=W1djI4dHt9J6W2YZZbiUKPFR/+aZEQNczVX8UCmnIa0=;
	h=From:To:Subject:Date:From;
	b=ntjFO6i/nmpUOx4cxZ7dMTdjkcDzGtz7/DjfMuhdkEKcvv9Cmt7vXYrioM6sQs+6d
	 SsfffKXq2DbbuW7NqDYBfrLkyA55KawoeBzIdyxgj06q3VP4s7euUDwHyOD9AaCAFp
	 d+pu+f6PXeUe4z9FBp+8bC9kqgGJGwfQ3GgFT1AlIdr5/GAOTnBj5xMpnVrQq4u4di
	 DiCkcvzyqNILQuc9zGYVeOpRhBu8SQkGvyGiLrWyJS5pfO8gDZIdd4sYwB+aLf9fUL
	 Ct+Jwc8qb+NLiXmAIWJnDCxJ7DTJCsMYONQ8vpUth5MZ9C0tnJYAEwebtEhK2REgMC
	 xw8JZXAokpM4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 008FBC53BC7; Mon,  3 Aug 2026 13:24:20 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221828] New: Windows 11 blue screen 0xc0000185 when using disk
 cache none on newer kernels
Date: Mon, 03 Aug 2026 13:24:20 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: samuilsgames@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221828-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221828

            Bug ID: 221828
           Summary: Windows 11 blue screen 0xc0000185 when using disk
                    cache none on newer kernels
           Product: Virtualization
           Version: unspecified
          Hardware: AMD
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: kvm
          Assignee: virtualization_kvm@kernel-bugs.osdl.org
          Reporter: samuilsgames@protonmail.com
        Regression: No

Dear Linux developers,

I have noticed an odd bug that makes Windows 11 crash early during boot with
error code 0xc0000185:
1. Create a QEMU/KVM guest with the Windows 11 preset
2. Change cache mode to none for the the virtual disk the guest OS is insta=
lled
to
3. Install the OS
4. On the first, the error code appears.

Changing the cache mode back to writeback (QEMU's default), the blue screens
don't happen anymore. I kept virt-manager's defaults everywhere else. Anoth=
er
workaround was downgrading Linux from 6.18.41 to 6.12.100. The problem also
happens on Linux 7.1.5. NixOS makes it hard to install EOL kernels, so I
haven't tested which minor release actually added the regression. Lastly,
Windows 10 doesn't seem to be affected and GNU/Linux distros for that matte=
r.

My setup is this:
CPU: AMD Ryzen 7 3700X
Host OS: NixOS unstable
Host Kernel: Linux 6.18.41
Host FS: F2FS
QEMU: 11.0.2
Guest OS: Windows 11 Pro (25H2), Windows 11 IoT Enterprise LTSC (24H2)


Is this a known issue? I couldn't find anything on it. Are there any logs I=
 can
post? Thanks in advance!

Best regards,
Samuil

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
