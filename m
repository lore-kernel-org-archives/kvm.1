Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198B28D831
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763720; cv=none; b=KSkuK0GSRU6szgP44+HiO5QTkDhY+emx1KpWkeVAQUVsAMmk8MwYERaDjDgO7yQTNVbPdnz1CJpezaEUDSvN5gdLyj7L+8QEjfESbbQfA5Bzl8is7wuhGKPcOoLbiKlDQE4u4SrEE4iBESBRR9sqpOnTmHlOkjzk/5kNjgbRSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763720; c=relaxed/simple;
	bh=ReFelFzw8RPv5R+JRklCSw5SqC6T4FD2++E4X7zJwM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t10HENPGSJHChPW/tuyHd9bYGiRLwH49QCzbweSgbd/oKUnOHjeH4IIpmSUWHhF3ykcyEsUpKXYRbLzw+JmoRs8aC8JhwrdLIMCWxhwLbk/KXLkF8JpxfUKDiXt7N4YR0liqWQxRbW8kgztLmUJ0T1DYPOpLydFJ6nS3aPZBV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmJ6or46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmJ6or46"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB374C2BCF6
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785763720;
	bh=ReFelFzw8RPv5R+JRklCSw5SqC6T4FD2++E4X7zJwM0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cmJ6or465rU+VhrxNkKRKI+6/TqB8Fd6jBkUTNRrxuBnWfUIEccGULw98BCiY9kv8
	 z9z+EZ8Vno5KyCgD3LvBseH0QUqMDjhnY6fQkmeZyd2fbHn3L5wM/kXG4/PFA+vdHN
	 oQeCIMh1et3Ythd/bBq98W7jHUyjptS0c91rRFV+lOJgS9SFjtmhp++jGcGzcscqwm
	 a1DfO/zTE2mlbbOTOd/CByZnELMvqStx6YXex0WH0kpI7LNnNkW5yMRx7Uz8zaHiBH
	 vVLktLQg5Ec15FQlFs/IxbNPEsnyyy+eMWS6ZMDVkOlQPFknaGjaL9od0Q5bdnmFod
	 krAe0s9HIbw6A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DB5ECC53BC7; Mon,  3 Aug 2026 13:28:39 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 221828] Windows 11 blue screen 0xc0000185 when using disk cache
 none on newer kernels
Date: Mon, 03 Aug 2026 13:28:39 +0000
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
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-221828-28872-r4TUv0ozDs@https.bugzilla.kernel.org/>
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
     Kernel Version|                            |6.18+

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
