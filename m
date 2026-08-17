Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CC3F1ADA
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976806; cv=none; b=KBaPf5JE6m9QkH5lt9RYeb93U45ovtmvRI//PscxC1yMC/SflUN7rZYzdShDjfGUrwL/MXepMKJ20hoxV5TkMmljrD0cbC7a31b38xxKGXVCY5zEhiqd5Nc5ZQloE+xuouHymzOchbLNz1Tid4tndiGimtR3oMeI0G73bmnSCrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976806; c=relaxed/simple;
	bh=LRVpa5HfWfzaTkPyPVVCIA4kYYTtEA3p0FpO+JkMh40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VkZ44MyMw0C1dvC3cyo9zFlqkouI/XWXcChV0fScOwqokfVs1/JqPMavQswpM2FcdtNmPlnYloSvt975JXG5p4PzmrZEAJnMuSeNct97/hZBT51fvEsNRKDlGh6rxaw9aK7svnmF8Ry/RqMmbuBsvAF5taFSGUZ5hheTVcDVSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXgHJBWW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXgHJBWW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E10B7C2BCFF
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786976805;
	bh=LRVpa5HfWfzaTkPyPVVCIA4kYYTtEA3p0FpO+JkMh40=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dXgHJBWWqnOJ4pSVjoOWS7oUuDxJcXFbzvMqXPXw3fW98uaecVZeB+vC/ocMMrZF6
	 N2RWj+rM5kFHMrQBbQkfnqzTCmihGEgXWS7b3VfgqIcfJS+aliuZYICugeyZFaqzkW
	 7p+yCNUErCJeIlgCKd2McNqPMjr771+Lrw7jZaHYLagaHs0s/yQNzNWEyX19pZZ5at
	 mLAQdSOSYUNQatI8lJoNyQAxW3tly9+mz2Q2Q+flcSyrnVKrjj3MJAsNcd9zVLg9zD
	 0E3X756e3B7iblN6vz14aizfNLla6CziQ6Gl/WrOmLUiuMvJVSXLwwIlNNdMjx4zUg
	 82d3mz8GaAmiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1762C433E1; Mon, 17 Aug 2026 14:26:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 219009] Random host reboots on Ryzen 7000/8000 using nested VMs
 (vls suspected)
Date: Mon, 17 Aug 2026 14:26:45 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219009-28872-IANwzhH66Q@https.bugzilla.kernel.org/>
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

--- Comment #53 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
> this issue seems to be back

If the issue was gone before and you're sure it's the same issue I suggest
opening a new ticket and bisecting.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
