Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883A39CCF2
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643510; cv=none; b=abXd0wdRbPmw8V10pH19D6TrHtygAF0aB18HLq1H0I34I2S5UOpA5RhzqStJOg8ANKHUI6HDTjItahn7XgZ5OWMQx+Jx/e2yNGYD7Sj5RGDYilp4VczB59xBF+ztPLD0BRHzMRtG1cigdpPwH7iIoTkDQR3WES9mn2MzioBQbr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643510; c=relaxed/simple;
	bh=1W4IMzCRaYqXbF37BhC2gvXlfKI+e1Q7RdhojDSCfMg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d7XLqipsUCgvQ84RdWn2Ac9KPhEviXf1Xw2Ek79VKg4tcVrB/FlgUN2YAECoJwjO2ghNi6bi8cjEc+dqxu73Me/ClMt4EZHaOU7jfaZ9RmvrwGW1iACfQkN7Z0kywSCJVdPATc29LbUK3nfCV1Oz+XaokVI7e9fOKrElk57z6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXP3f3qe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXP3f3qe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9DBCC2BCF7
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786643509;
	bh=1W4IMzCRaYqXbF37BhC2gvXlfKI+e1Q7RdhojDSCfMg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=aXP3f3qeNgV6cTJ8oHL0jK7XB5Q9LhlujC8JLbJg5XKvScmadx5B8ldZPdKvh2N50
	 T/WEBBdLmN+pGkGXogwi70Mxyn+56ucafKBxws7TSuDVSZXzWxRIu1JCDoNZeduoOP
	 k/e9FeJOLtOi1eQQJiWwx7b/QiE2m09lJHl3g1ohrPB5895bjGBQjJ+xQyQSeD01DG
	 x7qzU+R4JdQ1Hi4WR/P6uNBt5Ts/dSQv4m06Xi2/zhrzXkeW+ehDFtrxMEXMd4kG61
	 DUL5vVKBN7veCncFsRMYHClG8YT9kyvq5GLkmLiIIoKFKoUz2mQlUB+fZ4h/pJ8YZK
	 E0zGUWTmBAJWg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D1B3DC53BC5; Thu, 13 Aug 2026 17:51:49 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221841] KVM: nested VMX eVMCS VMPTRLD/VMPTRST causes infinite
 VM-Exit loop due to missing RIP advance
Date: Thu, 13 Aug 2026 17:51:49 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221841-28872-xYMBun87e7@https.bugzilla.kernel.org/>
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

--- Comment #4 from vkuznets@redhat.com ---
(In reply to vkuznets from comment #2)

> Ideally, we can try and see what genuine Hyper-V gives us
> in this situation (by e.g. running an instrumented version of KVM there).=
 It
> does not seem that we have an extreme urgency here so I can put it to my
> backlog and try to get to it some time next week -- unless someone beats =
me
> to it of course!

Tested on Azure. Apparently, VMPTRLD is completely unsupported and generates
#UD right away, no matter if I give it the same 'enlightened' address or
something else. VMPTRST, however, is different: before VMLAUNCH it gives us
0xffffffffffffffff even after we set a valid eVMCS pointer to the VP assist
page. This is (AFAIU) somewhat similar to the architectural behavior when we
execute VMPTRST with no current-VMCS pointer. After VMLAUNCH it works norma=
lly
and gives us the eVMCS pointer we used. I think it makes sense to mimic the
behavior in KVM.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
