Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F2B429CEB
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834686; cv=none; b=nhoQF0wd06GYA7Tu46ujduKLZr7g7MyJgA3X9DOUlQKwT8FPAniNuAghBvgEXp+nJJw8Ibryz4UsDrtLoYpNrPDkQtkOBbVvEKHRpxk2bpwTNaLgDWWwGS29SCDme4Bl3dzJj9DvvheskxSBECYcNrCX5lf4H5XI2AJoZI4xkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834686; c=relaxed/simple;
	bh=Kcvh4gf1055bC8SGlhEMaMZNV0STmqYgBWb5V+GyCKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7MId6sb/THU7Nz6N/ze27uFJjrF8GDW7oogUNdFQw7Jpiq22EKjyq36vPeSzgyl+opV0fAEhZNY5DI/GUorXdVtbFtF4fKscbmxuTDTLIxepxOU/nPlb0iZfRTCT6wCAY6owf8teVWSR0kA+r2NJwEWcI1hFSPx8nRPFoEoz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmkLJS3/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmkLJS3/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96FB7C2BCFC
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785834685;
	bh=Kcvh4gf1055bC8SGlhEMaMZNV0STmqYgBWb5V+GyCKw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LmkLJS3/37esF7ph9FufS5zWW6IsWpp+9h3mkT+OfaZI8S+23x1vvoQhdLo2QqFEC
	 qHymM7AOjf5gh6tYQUtPW1tghPRlaRPmygZzn8ZgVrmnmy1FXY9moOLFBqFDGifNwU
	 bMjHJ4XiTDalsidoJwt+eSBrrmrbttl77rQBLNKlSfq6AD5AxXe0fixGuzmgelnMk3
	 8p7BNN9bOqpINEGdwjXGdRHXpx4YAdjuyTjOdMw0D8fK/hUyw7d9V8N3+yVx76hg+d
	 M1UDwPB46Ql+13KF/MGR51YyfxSgBoZg8tHt9Y5UdPDuUDstGmkBKHLKF5dbNheXEE
	 gS/9IOaZwdZaQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 84131C41612; Tue,  4 Aug 2026 09:11:25 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221828] Windows 11 blue screen 0xc0000185 when using disk cache
 none on newer kernels
Date: Tue, 04 Aug 2026 09:11:25 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221828-28872-RnnomOtH41@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221828-28872@https.bugzilla.kernel.org/>
References: <bug-221828-28872@https.bugzilla.kernel.org/>
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

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |regressions@leemhuis.info

--- Comment #1 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
(In reply to Samuil P. from comment #0)
> Is this a known issue?

Hard to say. Wonder if it might be the problems this fixes:
https://lore.kernel.org/all/20260720201057.1862857-1-kbusch@meta.com/

Or just a timing issue.

Maybe a developer will show up with an idea what's wrong. But if that doesn=
't
happen in the next few days you most likely will have to run a git bisectio=
n to
see where the problem is coming from:
https://docs.kernel.org/admin-guide/bug-bisect.html

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
