Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B05372058
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558605; cv=none; b=TN945XqDN7FB5QYXlM/ZTZnZTy/d2vcZmFEcKV5QF7hNOkLJmYGb/V0liWCHaDVsSo+t7LRhozyq5+psVO7Mr+hMaiagJ45at25qZ2eXjbAQ4Wsvv1TLUVoN+rkdOgZL2d62+Qoi0IpiHZ/MtAsBdADlLtpR/CoKOc61rY8fWhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558605; c=relaxed/simple;
	bh=yIlf4vsoeEDI/2N+r4FdsCTzokD8RIObdCk2ZvZVEnQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORc1Xeis706RtmCKmRRgAl70Ry9q4JnBjHC4h4KZi/zGzLCNDH3XySqqX08oaYAL24a1pSMWnTixI01yoSRQf2Qvsicu+WPGju8RlZ1RPZTuhMpppOFX6YJVi4Ceg+1RGvp89uEVLX0+cJMzef0Ic71DCAfTxsAq2IK8kUeP4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trspQfMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trspQfMX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF23FC2BCF5
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 07:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780558604;
	bh=yIlf4vsoeEDI/2N+r4FdsCTzokD8RIObdCk2ZvZVEnQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=trspQfMX+7l5+HtydimGlpwCXfH21PzOOdVgtPYBL3ACLMM2222cOTQz3LF9mRadg
	 ZKuvukNPN987ZQ+9BrJRUT/aCDXjgdFD+dvSQ1RgytL1p8ulyN+vtDMYR99yTvrEH8
	 2z9yvlDAqlQnIRPdCfE1c1+O2Q1DtskCdnUSQxjFzUTFR7lhLXVrnmk7ucnwyBiThw
	 wFHaP76/KytM8FILWJqR1pF/lA+PjvVMVFHam7f6f2tT+qh/Axb+ATw3n6HHHdrrOh
	 Hudfx5/Rf823OKeXmm2fRrUqYraGcobtePiMrmFh7IDJKvtcOeGp0SzPIyQwMZSI9J
	 ToIKutdbKwP3w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D5646C53BBF; Thu,  4 Jun 2026 07:36:44 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 220776] When passthrough device to KVM guest with
 iommufd+hugepage, more hugepage are used than assigned, and DMAR error
 reported from host dmesg
Date: Thu, 04 Jun 2026 07:36:44 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: farrah.chen@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220776-28872-uy4MUNM5za@https.bugzilla.kernel.org/>
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

--- Comment #5 from Chen, Fan (farrah.chen@intel.com) ---
Verified on the latest upstream QEMU 405c32d2b18a683ba36301351af75125d9afda=
08,
test passed.
Thanks for the suggestion, I didn't know it is a QEMU issue when I open this
ticket, I will do more analysis before file ticket here, thanks again.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
