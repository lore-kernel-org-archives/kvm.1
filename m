Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC92DE6FF
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558625; cv=none; b=N7s82QEtuDUnWAXhC2lRW0+D9DkFjIzqVqE7H7yypH/ohSfkTgp2EpDLqezcU4y/UUBb8uN+AQpv6g0J2lTwfUVhhuZViXg8ZiFox5//6jAsm2nyg14Iw8R+1dg/2UmPwizLLvCM3qVDewyLc/yWSb41oyoX1+Uwq26yeDDqJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558625; c=relaxed/simple;
	bh=3kjv8KyyP0ov61MjpVAM+ObMo0WdrjrLznye0ijVEBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ac62imKBp4ZHZ/xoSD3qU5xjrvpmHXC4q2KJXVpcLDUt37O30/8R7ABB3joZO1vQ9PcxjMA/nkUoBL+7kYcNV8k8hqkJJ24IV/RyUSOz7xwFg2iS4Uon0nFmC3GAFZ2XxPHaKRzsmJwgf9efJUiT0bFLkn6CU2o7YxhbFl8xMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajrNAsda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajrNAsda"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28277C2BCC7
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780558625;
	bh=3kjv8KyyP0ov61MjpVAM+ObMo0WdrjrLznye0ijVEBI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ajrNAsdaNeym6XRCMV99pxc8nC8/fyp+dxA9epa21q6SOemghuqx0y6OfembKQNdj
	 J1EAbZaeDfA2yd3kfq62Z1I/X9UcHvyWAv7LSroOCmd2kv3gFMK8yHzmHCGNKLQdPi
	 MotMvAM1OxFhODGC+04kUhfYX3V/5NL/X1PjtLYXUYBGhhg59DAgNsAjBdhsqiWLrj
	 j1m0/5RLCm9+wJeDUJ5OrJlkKX0/GMPYWJpwVokjijvenETemVn3+1nGew9hbwXpaB
	 OckeQubwyc6hhyiFr8DNRBvmj8m9lIRfKHHs3X7Xk0lFfccNQizP36yFiUnSFN6d9t
	 hOrK/VVG2Qv4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 214D6C53BBF; Thu,  4 Jun 2026 07:37:05 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 220776] When passthrough device to KVM guest with
 iommufd+hugepage, more hugepage are used than assigned, and DMAR error
 reported from host dmesg
Date: Thu, 04 Jun 2026 07:37:04 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: farrah.chen@intel.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-220776-28872-0iogtFmmzq@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220776-28872@https.bugzilla.kernel.org/>
References: <bug-220776-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220776

Chen, Fan (farrah.chen@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
