Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414524;
	b=Woa6HfcSDMJpJhnn94jBtlumJhOt7sOih4oHNZQsS4mgCB6KZpo5LH5tcdZ2jyxreax+
	 bKlHVpFnDaXASXztamPioLvRdnG/KHzcHZIh5FR2JiDfICAn0c1mzr7sIGcjiHutLsFBJ
	 Qw0ynQDdNc1PAF0/7xivbCEi9yPyA4FZZ1xquMi1SEhIWcmbZgsvlmc3XRuMxPN6TYNM9
	 SUM0WNHLMSj7lfitjLJQJiIVrREKbYzVAIrPT1kw1t8PZDsUgL9X4jqHlp+UJqodODYA4
	 cq1PQg6Wb9kNb+HoVkeHKfjhwlJu5cAVdQzyTqUs7bKql2r436GaFlVCagkFZPCv6QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414524;
	h=Received:DKIM-Signature:Received:From:To:Subject:Date:
	 X-Bugzilla-Reason:X-Bugzilla-Type:X-Bugzilla-Watch-Reason:
	 X-Bugzilla-Product:X-Bugzilla-Component:X-Bugzilla-Version:
	 X-Bugzilla-Keywords:X-Bugzilla-Severity:X-Bugzilla-Who:
	 X-Bugzilla-Status:X-Bugzilla-Resolution:X-Bugzilla-Priority:
	 X-Bugzilla-Assigned-To:X-Bugzilla-Flags:X-Bugzilla-Changed-Fields:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-Bugzilla-URL:Auto-Submitted:MIME-Version;
	bh=o1/dxlsEKBmI2TT7ny9rYvM66DLCWSfxu50uH9NKb30=;
	b=LmWUS0pMxpsOeEMLvjQynpCJQIFlh76zgXQqs9NyeGKU4fmV46HX1AIH3xzGqOMLAI0i
	 C/Xekc4BnICcIeQKV6BUQg1zfEdqkHHbc07qtNdLHkRg13xqkmyPnD/NKR/f8CYOxCGrh
	 MM/Vuwh0YA+T238guARuccwzYAn/vsAwu3JRslvS3XDv7rvWa8gtOEmMtBXXS52OKSvFn
	 nvasVb+r8k6leQQIMI0eAXc9y4asd9EDuwh7mQHPlWdzIIyqzVjM4Zv8m7v/j1xR37Wq1
	 UaY9RoVoG9nIcVuA7iPVltdloUgyasZqzi11QXU4v63xuCAErs8rSIJfHHh5O7Bxrcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbHngCR2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B2606A31E
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbHngCR2
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67C001F000D4
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795414523;
	bh=o1/dxlsEKBmI2TT7ny9rYvM66DLCWSfxu50uH9NKb30=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=bbHngCR2P9xHiW+UsnmOg6u+Of68u/yboOQazXIFehngXAh2jnrKaYhdrCrF+EP0u
	 n8+6XHP0ZD/A2oDarjScCBmojZp8PkhZRRP0xApWDFK3Q3zynX4ZBhDwlbKvBwrYtV
	 SGo868qtfMmojEN/h9Ul3ATChDsrRSEDeWtm1y/XFn5c2chpwFLLGr3Nym2B9JYzaS
	 uTsRWv+DfofUWwT/vYvdOP+5ulNOsj7P4jf/uHHpqarSho1PIdQMHTncCWXqxJlY/Y
	 KDGivIsArDBxXFZqlKYStw3Q6sIR0h2ze3yaeLml8gbrwE9lixEwAfNI351BrjdtfX
	 v6wf5RKwa862w==
Received: by aws-us-west-2-korg-bugzilla-alma10-1.codeaurora.org (Postfix, from userid 48)
	id 5E66E240041C; Mon, 23 Nov 2026 06:15:23 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: kvm@vger.kernel.org
Subject: [Bug 222317] pci: 8086:4c43 host bridge enumerated as class 0x0604
 breaks Intel IGD passthrough
Date: Mon, 23 Nov 2026 06:15:22 +0000
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
Message-ID: <bug-222317-28872-MVsUYj9Xc5@https.bugzilla.kernel.org/>
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

--- Comment #2 from 2039475150@qq.com ---
Created attachment 311568
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D311568&action=3Dedit
lspci -vv, full

--=20
You are receiving this mail because:
You are on the CC list for the bug.=
