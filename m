Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538A1DAC81
	for <kvm@vger.kernel.org>; Tue, 29 Apr 2025 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938924; cv=none; b=XONpDJvs7bbS3F6SHR62w5p7ff1q3TS0UkaxB5ECA19DJGkwcDnsSUg+q4J/9km1fEpGz0lFMXwkeh6/wOL9AwOXSvlhOnCXpCcpo4nsStMOL+tF2r284heGe+vRGAMzC7/xOKq/N4Bj5HVPTJVOGpAubzNWzYW9MZ8BPNGENyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938924; c=relaxed/simple;
	bh=VG5MSLQ1U89oQl6Ix2BWlhyxfQ929WNfns6OnJt6ghw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RO+s9GqiLFBD8HBiUrtQnHEIiYqcDmS32lxagryVeKkn0jmsbCpmDCxv89pyu7G0MfCT0OSMVWKfpxWan4kKS3dP/EhIgOI+57y/U+xDmveTLD/29PpQWL/GngQtx3DvDDcV/swxiDKgjygbG97XbbAT3iQ/ZvRsYNsOzlZ+auI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpJt69VS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpJt69VS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 916D8C4CEEF
	for <kvm@vger.kernel.org>; Tue, 29 Apr 2025 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745938923;
	bh=VG5MSLQ1U89oQl6Ix2BWlhyxfQ929WNfns6OnJt6ghw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CpJt69VS5C6hjaruiKsHPm5Ho99qxjvX9r8Y6oCh9khjmtNDoXr9dpJEBciA5E1G3
	 ee18eGIKg0T4pCrsiv4CRCx/leiPEiz8zDLphmn+kM9Qf+/ycsUhv2+9ycWFpkOcRy
	 nHDXPQNy5beuNYgNjYfomrdQlmSWvZGp14bjbio/CAYTriincbNewColGngvE0l7IW
	 CL6dZ6tvgL60mYTFFhtfF9tEC5LbL451DGuJ9BxVTTfIe4t3qqR6NGGs8XG1LQ2+5j
	 cSb/wDG6vpDykx5aHOLuWiAelXC31VezitYVlA9rE6TPpC0Sz6KVN66R6uBopSVsAX
	 gWxhhPCZsGbdw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8922EC53BBF; Tue, 29 Apr 2025 15:02:03 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 220057] Kernel regression. Linux VMs crashing (I did not test
 Windows guest VMs)
Date: Tue, 29 Apr 2025 15:02:02 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: adolfotregosa@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-220057-28872-kDIe7hq3Zx@https.bugzilla.kernel.org/>
In-Reply-To: <bug-220057-28872@https.bugzilla.kernel.org/>
References: <bug-220057-28872@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D220057

--- Comment #26 from Adolfo (adolfotregosa@gmail.com) ---
(In reply to C=C3=A9dric Le Goater from comment #25)
> "-cpu host,guest-phys-bits=3D39" should help to define compatible address
> spaces.
> Could you try please ?

per https://pve.proxmox.com/wiki/Manual:_qm.conf , guest-phys-bits does not
exist in proxmox, but yes, I can give it a try.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
