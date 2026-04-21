Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5252628D
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731508; cv=none; b=KGZDXXpgcHfkG53JfERSHyKxBQBWPrDHEB/r5ZBBK9uG0xk/vaAdAOTrml065Jv/BuC/JygggQxMZw+LkFI3oRVYXbemAMUsVU+AJ3nPYE7BxnG0jwLBicIw83rBgLCzBR7ONPsDzao6qBeV/Ul3QaJ548XlwnF00jgqg+bDrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731508; c=relaxed/simple;
	bh=M1FCO9X/zWh+g4RYnN6KJvrJX4cEdAvGzje3AUbBweQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=irezL2xVcy1HDZzWp1p+H9Wx0TSf9HzBuboSYPmKvgq12GSW1+wW1f8mOKVtUhp2hRTv4D1cj1NhCc5VAkl8gw2dcM12nEZfn53dhfD+o40HQemLo8i1imfDbPGLVI4a9S+aClQO1W5g7axSODBIeqUheJJo92CpV0LNd8LjQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPjJRqKF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPjJRqKF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CE15C2BCB9
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 00:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731508;
	bh=M1FCO9X/zWh+g4RYnN6KJvrJX4cEdAvGzje3AUbBweQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kPjJRqKFqtu1zpm4ewrufLZH3ZhJ+S/xZ4FOLasAo5is0FdPj/Ytcoh+OZ0ZirfmP
	 bQMJcjWYoGkpB3UEJkJl4Veob/pcG11hUg8sRPZeLM8ljIEu3GPtTrmx+CeTnUiTe0
	 ifZFRXAUPyALMeuOjXL8igjM2FGy5jn7XVIE9T9gBjjuRF18N5WR8kjaM0XS3rmV67
	 eWpSQDskQhge7pc0Qx2RRB+r4GYuk7xP08bXkHbKBYh9VNbqEuvB0t+92f2rOp3Bp0
	 sygBtzBKg9kNhdSjqe5gwSladh18/mU2mhjFk6tpYelcaU1WainC6WwN8nK0iGFoIh
	 qTllAUewEh8Zg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 7595CC3279F; Tue, 21 Apr 2026 00:31:48 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 209155] KVM Linux guest with more than 1 CPU panics after
 commit 404d5d7bff0d419fe11c7eaebca9ec8f25258f95 on old CPU (Phenom x4)
Date: Tue, 21 Apr 2026 00:31:48 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kronenpj@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-209155-28872-kUzKGODBW4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209155-28872@https.bugzilla.kernel.org/>
References: <bug-209155-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D209155

Paul K. (kronenpj@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
