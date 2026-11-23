Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414485;
	b=2N9ItEkaLgI7ek8INbjOD8toS/WygQJvCJESnlGKDZKvd/YJNjBd9VKbKevYLhTlpexq
	 vqhuLmJurFCU/R9nMzXJz68c0RQMqYJGXLpW7dt2PNhUYT1JWvUEyKxpz2XYRVJCieZkS
	 zpj5mW/CmLIRO4QSgkQgh8IzOIDl0hpG7I7d2hpDenC5LAbm2aEvAhZiIot7IG9meFkRd
	 D5QvlqqiAwryXPNys6tBMwzNoCRydmAJ+q9fKgws8MGEdVgGM/fagsjQ0I95v++Mg70P9
	 ev7yAIwwBEm7xV23B9pIxn1POab1wPvtUEn/1ryw7UcGKakOngZPaKW7DyK01aEnMqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414485;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=SyVZIMI6+9jzreJlkqlfcvi2m/s+Ya1w4ujIvB49DTA=;
	b=H/QS0/9IQ+sxHhgAZUZFoSpzkzDPkmY/Z6HIM2RWE2bdA7K7j3E5mOiYKpLSo9KFjkPM
	 4hPsTvDOd0C9NXEPC2MGrzkwHrTYBDBf2SBbrWgtscIUPGsbOOZXG4lwsBUP/HmVbUx0e
	 HV+4O0VTcGPCR8+1yoSl/fjPNFTZFV3xxGhsZ/dtvul7Z7CmbK/B+8B99sp2GJGY8Nctk
	 qVsVDDrhwx0W4xzv4gVmobOD6OnMEi6aHdfIpJsVCFDBIcRKJdiUM7FDWtvk40xYmcPR6
	 rQXiP29ZCZ7SCT/C+qojpXRmvixTKSQjDvuX/uCdh6DfAJTkHtGWV07NCSAdZAw/BDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBOY82s9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BE3606A32D
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BBOY82s9
Received: by smtp.kernel.org (Postfix) with ESMTPS id 307A51F000CF
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 06:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795414485;
	bh=SyVZIMI6+9jzreJlkqlfcvi2m/s+Ya1w4ujIvB49DTA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=BBOY82s9+H9JNDRmsTFrNqvTPPkU1TGpzvdHAZVUERCYcNsdnNPqN4uW6CsJehcu5
	 Z1nSNiNVgdThiA6oC1tp3oezg89G6idCA7nCGoMS0D97uIZdHl1j5baMLzQs9xquZ3
	 Pe8dffjV6sjQxCpbvYjuUjQz4JF7+lT8xUthOOArXVaRBA+y4MrW8XtyD/P56zWxP0
	 W7EURzETp5hFRkLQE9WUxbjWmFBOM9/awsqKTUuJsT2YHFFsn/loWHjMCjwbdhsEKZ
	 Kec4WVHzVGqNbCOHGTPvBQ0tJIXGKQ3i6qR45JLVCp0qnr1+ae/U/6F3W5EysmYIrL
	 gp4ViNfIk/8cw==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id 1B61A240040F; Mon, 23 Nov 2026 06:14:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 222317] pci: 8086:4c43 host bridge enumerated as class 0x0604
 breaks Intel IGD passthrough
Date: Mon, 23 Nov 2026 06:14:44 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: PCI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 2039475150@qq.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: drivers_pci@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-222317-28872-9RC42TEwNt@https.bugzilla.kernel.org/>
In-Reply-To: <bug-222317-28872@https.bugzilla.kernel.org/>
References: <bug-222317-28872@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D222317

--- Comment #1 from 2039475150@qq.com ---
Created attachment 311567
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311567&action=3Dedit
dmesg, kernel 7.0.14-28-pve

--=20
You are receiving this mail because:
You are on the CC list for the bug.=
