Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE931CAA78
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957275; cv=none; b=e+q3Bo4cYby+d+0tzR4fUsymytKh8RyQXE+5+Ltgd9/HrRPzA9ERRHVc2hkbm5tCbuXyXBgi4mM2Au/3sPyWNBKozd6U88T7uFzsNCwCD4LvZtPs/FqnaIJf1JmZf48gMnnIJXwJIiByu0wZ6R4/vHNHkMU7Boi4QofHcO4RqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957275; c=relaxed/simple;
	bh=4YJkiRqTiXjyynR/u61Tys8JTXe0F14WyXk7y6djXFQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLOWFonLCag3hc8Kj2VdD+7x0OKQwdKh5FA52R+lCPma2iWqpHOBB/bLPNHA8iuCVD+Jk6Wi9OAYirlk3/BH0eey5vuzme0gl++4s4mmG3U/pr34/XzgovBMqZJVYrFVwI8ewHt8jNBAGlZXF0UkHALFW6aejN9zcqdrOrOC1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOD+r0SN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOD+r0SN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32412C2BCFB
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786957275;
	bh=4YJkiRqTiXjyynR/u61Tys8JTXe0F14WyXk7y6djXFQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MOD+r0SNeZxXTnztKSWC3nBANxhK0Fq6d1rdllOqDT/o9N5JcH3lt84yEyO2JhT0O
	 H2vS1UmcHHP3FhgBGvUYx4zzJG9Xju08dWTM8+WkdBOhL2HNp2A+g1T20MkLbA5I/o
	 jIeBWt4ujS2BfUDNpXMCUr9wbcjSh0CXyuysLEegevkUznz/JyiD/HPB9zG66tP1sD
	 tQK4Bph0YWbjYdK05iNlBHZq+j2MWwjVM/Ey/kwSKgmxVO8vdorFBxVjyZiJgYRm4B
	 s5wkzb8mhM79H6bVKIJPYEj3v/xUB0pdYic3UT6hxjXhraV5T0pUl5O7RQpxprSyZy
	 ttsYXRxa2FkSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 230FCC53BC7; Mon, 17 Aug 2026 09:01:15 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 219009] Random host reboots on Ryzen 7000/8000 using nested VMs
 (vls suspected)
Date: Mon, 17 Aug 2026 09:01:14 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ozonehelix@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219009-28872-NNitBcAvq6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219009-28872@https.bugzilla.kernel.org/>
References: <bug-219009-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219009

--- Comment #52 from Ben Hirlston (ozonehelix@gmail.com) ---
this issue seems to be back

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
