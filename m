Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5614296BD2
	for <kvm@vger.kernel.org>; Mon,  2 Feb 2026 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017891; cv=none; b=oUEwWTR3HK5ARtvO/WvdarGUwAtB6LJEMjGilWFS9iE9NpibJnQKXbseClRhddAKkzrc5nR7v6Abmi6v6/ZMpGa6b4A7fF7UhJX6a5o4izSLs/OzrX/p2I1nl6JuiS8646mPLfMaGfsS9cljo8U9c7JtHslEBLKY10Cayw6nWTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017891; c=relaxed/simple;
	bh=cvnDgcytQEOhTBRXmoNztLr0cbaBZp0Q+rRcj8fKvo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXBIUwONLfKCJKV89iT9hJ0lqBaTQX9iEjh55hC2jNy0BWBLo/ib3bG532OXQi4MILcYv1CHXIrKTNuAJdMXa2/TBMjLx5XDApobyn2BZjqmo2o5ykV44jg7F4skbPRHBkhcppBp/f6anou+LKXv2C79B2zzx4IAqYlc2cjqZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOSpmTiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOSpmTiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B306C2BC86
	for <kvm@vger.kernel.org>; Mon,  2 Feb 2026 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770017891;
	bh=cvnDgcytQEOhTBRXmoNztLr0cbaBZp0Q+rRcj8fKvo4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HOSpmTiQgBbmw2oBhRT1YXfSo8tibbTp384ANPIaOgxUJR2BscsfNUgBayGgogPo0
	 9VrACkPhPmPeQvFy+ZklXsZkcyrK9Wz9O9U2BB9MN4iX75Cwvlz7za7SQdUyMhIMWu
	 0MSFNFYoEf3YjQF1tmsZyvyUX21mM49U9it/VunogfL4pwUqFbUmy5jITt+ydQS8fL
	 tjhdqeAWH2nwq5bQGvGccjYjwI6cPNGK5ANyCbG73KKVmC+HzhpkhLDLHSVPFo2B4E
	 MjNnkZGea5LP0st75jHqP/Yc+QDsv/mrLzTdFQL6j72E7bF/226gNI3wvIOxIb261E
	 k8fXJSJQJsLRg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2CE53C41614; Mon,  2 Feb 2026 07:38:11 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221033] Real time clock does not trigger alarm on QEMU
Date: Mon, 02 Feb 2026 07:38:10 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: richard.lyu@suse.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: rep_platform
Message-ID: <bug-221033-28872-JUWTKG4PER@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221033-28872@https.bugzilla.kernel.org/>
References: <bug-221033-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221033

Richard Lyu (richard.lyu@suse.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
           Hardware|i386                        |IA-64

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
