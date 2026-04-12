Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB936BFCE
	for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008857; cv=none; b=fJL/eCr84SclGbM/EohEdIGA5oHwkjr2jOutuUToVYglpQnHo5Q1wtU+5SDJS6VF9Ud21k1OnLCPuXv4QXCa+sdU1V4O3Z8ANO24RFtlcmqP27HpUmOoJQuZTIHZYJgKFrkkUAthIB/yzODKgmEIu1HW+asG5kObLaAvkyL5G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008857; c=relaxed/simple;
	bh=8UYgurtRs4zvUL/faoCskSA7EINte1mghSE/m3TSfAo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8tCSR911hhMhSQdgTyAmZgD5UlrOqIUvkfrsOkV4fUU+bopMagEbT1eypcI8VfVU+RtIDK0IOjm0k4hQD5arY1iGT6qivcbCsKtk4B3euc/Tazz4YHQoJFrhUH702OrFD6ndINXeUdNItTSuZRGjY+fApCN3/VYP0o6inkuV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScJYnatk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScJYnatk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D4CC2BCB1
	for <kvm@vger.kernel.org>; Sun, 12 Apr 2026 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776008857;
	bh=8UYgurtRs4zvUL/faoCskSA7EINte1mghSE/m3TSfAo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ScJYnatkOLEOMaJu4yGjs2CYs+iNJ9A4MrAHeCuZPSdcqG8Vs6eXeoAqNjlqAzReE
	 VfdjFH9gn11VmAXgpz1HqUJ6lx4VOdLOcus5djakbwdLHu9Bh2u6VEJfXfT3oJ1sD9
	 BbzrQdAk/0RTALdRMVX+r1I6pz34xA/2bd92J0ws9VVqnleakWb5wF41ZZQQrpxRyc
	 XTTDsfSQ2uyc+NKzrU5sMGXXwl5rWVktwwKVCo7pgjSI8RHCsbjm29Psdxl3HBwllR
	 Co1fTp+qoyT+UU7UUOH+sNnA9C3QG+kFsqgFJ1cnDlDyV7NshVDxhVo5xVTV7zS2IP
	 9rs95+etbbbOw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1A984C53BBF; Sun, 12 Apr 2026 15:47:37 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221249] kvm_amd prints "CPU 1 isn't AMD or Hygon" on Intel Core
 Ultra (Arch Linux)
Date: Sun, 12 Apr 2026 15:47:36 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thisisamirv@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-221249-28872-PX8bfzXpqv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221249-28872@https.bugzilla.kernel.org/>
References: <bug-221249-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221249

Amir (thisisamirv@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #2 from Amir (thisisamirv@gmail.com) ---
Got it, I will report it to the VirtualBox bug tracker instead. Thank you!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
