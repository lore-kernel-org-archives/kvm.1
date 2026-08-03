Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EB33F38E
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763662; cv=none; b=eyX/PjfCgMCF/FFpNIcN9HvurxCzE+Jk+hn3tZ7whkq4Oqwu7NW9oPuF8WniXFC5ao6CWSwtDpJiUJQyf1K59SW5UngtYqwYJZTllYEfXjq2up99+Ou4d2OUsZPeUaTSrTzuYqpPP1f6qYGyR1MZO5aC3r837GttfpJ8mseZzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763662; c=relaxed/simple;
	bh=Ok+FPteqqX8FfWNnjBXS1I6Y80Yi4DOthKadmcYqcaA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ah8WaHvXhQQZUxhJ0pN8bQj8jjE2ehKajXy0UabT4WwqTJGXep+QNt8vMM8E9QKWpI+5fnnjGjdMQD7ubk7boPq+EpIojCWJVpCCSRf2Qs/41NWGcNIb8Q+ubimmWuh9qHsURP6n7mDS9bc1U6o2c57KI7BOZhjW06R4PkHmrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdGnhp8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdGnhp8k"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C57DC2BCF7
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785763661;
	bh=Ok+FPteqqX8FfWNnjBXS1I6Y80Yi4DOthKadmcYqcaA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MdGnhp8k0TVNobuSjJhhH+ENx9EOLiZqI7691qeJsBs2cvtxkbFIv9u+zkp0nTkVM
	 ibGcduzVfKEov4RhE6n1+6r88r4TDu7IDGHW9gVhSdc48+3tDPD3hUv8+JYCqqbliK
	 1aYdMdAYqMbYb+ThRN5qA7kByE5xjIcnPBtRw1p6IMAJRE6HhQbpRqdtMKO6XYVD3X
	 NyFpD9EFsu3N4JO5R8ZzFWmu58Uv3qcNQeqOwr+daLaVjUUrtOwx4LOwQdG6L3h4Sp
	 277cg/hEcw49470ifyXgr5o4h4g051ctSQ/MPDNgw4voYPF+wxce55OAGNtvYbX12l
	 5c3plJjxQPpnw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1311EC41612; Mon,  3 Aug 2026 13:27:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221828] Windows 11 blue screen 0xc0000185 when using disk cache
 none on newer kernels
Date: Mon, 03 Aug 2026 13:27:40 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: cf_regression
Message-ID: <bug-221828-28872-yrEoTQz5Tw@https.bugzilla.kernel.org/>
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

Samuil P. (samuilsgames@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Regression|No                          |Yes

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
