Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDAD3890FD
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523284; cv=none; b=SlIbUe1tfTPIhC1xJPl1sCHBwrkOI+GmRfsJNMFg9aT3Q0qh7DtL2vJsYvsY/yuCjgWOsXeLE7f6F8k3s5ath8iHBY6ZD+c8Vvef+xQ/g3To3U1v65Q9+xVXZI0NtLPHgkltbTU3u0+1AoXe/Tyjl0Oox8/rQBSc6hvckn3kE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523284; c=relaxed/simple;
	bh=1f4Z1ZCP8oU2S705ZyvgbJy59wP4hX2T9UGnbQlR2Hk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pfg3rrFUV/BvUoY/A88FfryKd6tTyK9/MjwmUZeFhJKaxGDmqtrva2TcY/yUAn5tE06uIptEKd+yqyod1LZpOYOitnOgNCf+siYmIm4lbsmAAlDkI1OsXdH6LLnC8KQ6hZB+RP+iFE2jRrumfRfSJbCSzP5nda0EKnYf74owH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBjwZPsX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBjwZPsX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10F5CC2BCB0
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774523284;
	bh=1f4Z1ZCP8oU2S705ZyvgbJy59wP4hX2T9UGnbQlR2Hk=;
	h=From:To:Subject:Date:From;
	b=sBjwZPsX+vCc7ZzosdzG20cbIP0yqNlYb0cmy2601v3DKF+Q1oqvUlVF9+eFX6Xtk
	 Wem8Ea+Uziz6iWNps/ql3cvrCIi+jXCiYDGoEHmt+Ui1xvuDqQAdSP/xMqSj+D3L2u
	 AwmgL1Gk1fX2OGmRMbaYlwQwR1Cijd9hV0bXFvAPvwnDJeuBp+M2KIjpY0zCePzIUs
	 cC/mVKM0GJj41k6tvkhtB/u409B0o5xLsO1OmZhXXCUt5Q6rqlzRNYp+uSL0/ITr6e
	 +BKUpn0vu4nO9Z30QRpbH+PqLiw8r95e5/UfXr2K7QeyZ8WshFwivVez0ItIevjDBH
	 TLd1EmFf3f9rw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 09326C4160E; Thu, 26 Mar 2026 11:08:04 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221285] New: isn't UML component missing?
Date: Thu, 26 Mar 2026 11:08:03 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: enhancement
X-Bugzilla-Who: marian@famion.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-221285-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221285

            Bug ID: 221285
           Summary: isn't UML component missing?
           Product: Virtualization
           Version: unspecified
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: enhancement
          Priority: P3
         Component: kvm
          Assignee: virtualization_kvm@kernel-bugs.osdl.org
          Reporter: marian@famion.eu
        Regression: No

In the component list shouldn't be an entry for User-mode Linux?
In the documentation (https://docs.kernel.org/virt/) UML is together with
KVM...

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
