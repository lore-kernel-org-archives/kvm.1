Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DB23EAA0
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 06:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295436; cv=none; b=l4AAvI5TJPCmCDVRt3BWS0gve/fpB7mU7Id3mn8f4ylpDwRxTTsDRBADTVluXwhUOJLwh6txDVVzillxUN9Gn7alyXGtgCafBLtIrHn262YqUCVQ5VuH4JcuuxQV1q6Uz1eInDUTtb/uONakuIlRbaWlELedfJ+TS2PjZfsSpKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295436; c=relaxed/simple;
	bh=W58/Wc/3VMm1Y1l+wsSv1kr+dbSO59U58nst9fut1sQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cBy9QvK1iRb7bPysZF1BKV64M4rXzLjeHaH0+GYwTOI3WZcOD/FGDLz2SI1KDqv6Ny1nQcwyq1hk1yaHpxd79ttBMyHhMMmxve0tGIRRb8+n8T4aZMkE2RD6Nz5+vZjlVb0OPIkfJvqGBPDlL7w57n+5z67an1QYeOuqXn/O3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tutJ7g1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tutJ7g1w"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB7D3C2BCF7
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 06:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780295435;
	bh=W58/Wc/3VMm1Y1l+wsSv1kr+dbSO59U58nst9fut1sQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=tutJ7g1w3hHYYg4rvRdOhkNWzax/0g7viP5O3Z5KIA85CeGgi35AxMaCW9dPU4WeH
	 as1TL8pUUGy3UBh7ocfkV85ZwlWQjB0fR7lqhawcVTA0INxA6ZL8rU63DWpYfzGePY
	 J+DP5XmikJgGLzd3M9CCdB+LvmEtrmo5G8bXYkG5MGUiTQjR79TL3XLgnMlqMm1Fkq
	 dw4pkjE90gtDFwwBMMQry2qGCgpqpNfNCKKa8jsK09sYnOYxSzM2t0p2p3mKTxSWfV
	 B+yiEA330qWpGemLcO5IoUsaLCypi95gYzalSwShTBZM62mHgc3wL1hTNvfr6vJ2gF
	 gEB3Zp5b04I0A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id C2145C3279F; Mon,  1 Jun 2026 06:30:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 220776] When passthrough device to KVM guest with
 iommufd+hugepage, more hugepage are used than assigned, and DMAR error
 reported from host dmesg
Date: Mon, 01 Jun 2026 06:30:35 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: chenyi.qiang@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220776-28872-MsvbsBMA7k@https.bugzilla.kernel.org/>
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

--- Comment #4 from chenyi.qiang@intel.com ---
The fix patch is now merged.
https://lore.kernel.org/qemu-devel/20260527122700.1589764-8-clg@redhat.com/
(commit id: e6c47bebdf8628e635e1ba970919ca96d572dbbe)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
