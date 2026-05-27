Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDB3CCFC6
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868272; cv=none; b=AeUP4Cq7aeqS1btIvWx9ECpX58LZIpylGwsproiiRhIquayuenYmIi2knu3S/WriM0TZ/IPWLI9L9aDxWtDb1Ot1+q3mI54iK8fp5tk5MqBRxFEgMt1AQOqSX5+L5nV2ZcM2h791Z0ehAec6l2JS8p5fSPxhzflQTLdze+nW2Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868272; c=relaxed/simple;
	bh=h151iN219CRUMxQmgARxzW5+q8bvl/VimbGXtFy8iy4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=czp5tKow+orFiZxBAzpsN6UgTXahxlRCNfs5Dq7oCuI165jasMzAOEYNTYbJoaaX7z4DLoX2i5IwHBdQ/lACSO0dkG0zM1Qxfs2h/D5uO/Nf+UBBX9sEZms5N0YoLdE3Oj6f73MmfCS5y86gd1aQcSVS0zcF/ptzQLHkUryC1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAp474tX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAp474tX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7486EC2BCF4
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 07:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779868272;
	bh=h151iN219CRUMxQmgARxzW5+q8bvl/VimbGXtFy8iy4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VAp474tX3ve9pSdLQxGtxtfUAXVwokiVL2qYxPqnT8njUrQSJ6zykCE9W+QjV0wbm
	 AQX1+H0GAF7Z0terVu5R6QErzd3Kq42LEuUxVekmh0rJUt1GJ2D25J+ILfkYBQM8Uw
	 MCFWA4T7uImwlgqiFnWYYz9LOZyO8oE1QVaHsEBE9VHGuGPLwO1tGnZTZeXrZMGt86
	 eyeQUUy55ZD6IXL0PnPSe6IRyP6K+y5D0AuWW9NLtMnMzs1zL4yKflcW/32mVabaVH
	 VBaR7+wrf3mFrj4ksWdy1YHt/IIxujP4FBUOBnBILVi5MuAzNQintB2ALhT0EAgKCH
	 G8uBGCedglvUA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 68F52C41613; Wed, 27 May 2026 07:51:12 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 220776] When passthrough device to KVM guest with
 iommufd+hugepage, more hugepage are used than assigned, and DMAR error
 reported from host dmesg
Date: Wed, 27 May 2026 07:51:12 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: AssignedTo virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Product: Virtualization
X-Bugzilla-Component: kvm
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: clg@kaod.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: virtualization_kvm@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-220776-28872-JyyXQIZ7JK@https.bugzilla.kernel.org/>
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

C=C3=A9dric Le Goater (clg@kaod.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |clg@kaod.org

--- Comment #3 from C=C3=A9dric Le Goater (clg@kaod.org) ---
Hello,

For QEMU related topics, the best is to open an "issue" on :=20

  https://gitlab.com/qemu-project/qemu/-/work_items/

and add a label to it, "VFIO" in this case. Then send a patch.
FYI, Steven has retired.=20

Thanks,
C.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.=
