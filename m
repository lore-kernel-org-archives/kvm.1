Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923EB4418DB;
	Tue, 28 Apr 2026 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381001; cv=none; b=hWONznhq//3CrFPOHlEDYW6aX+6qZUyGOyW+zxTy5eUjex45a9HdgkPx+rCysHlFHbW/WnT1vnz6e7UyDotDYXgc9Jim+Uwqdeh6D8JwbIzLRRkNq4Pyh/gbejaExF9fpPVWBDoj91WGDGEjixFzdYCkRLCgMIPDZKmxQKtgDec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381001; c=relaxed/simple;
	bh=i3WZ31u15mmq7qOSE5UR1atswzGLQhAJAwFp0uSLTY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQdRcqb1ahxeC6l1iXzG/IknbVOE69Uf61DK5WAGhnaAqs0afZxLBcEpdxEkImwneeAb2ZDsaD5cTQEgqRGfZl3qirnVwAqloAt224qITLtC3/7S10hbpNrHHb4WQuUfNRnHWkT+t5QXcGovEx5XYOQAN1zszfcDfvvqj8JSdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neoPJRNm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neoPJRNm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B2AC2BCAF;
	Tue, 28 Apr 2026 12:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381000;
	bh=i3WZ31u15mmq7qOSE5UR1atswzGLQhAJAwFp0uSLTY4=;
	h=From:To:Cc:Subject:Date:From;
	b=neoPJRNm1LYG80+dieR6PJZoLnZ99lU1Ya+0jYbfghjog+dZxBQyyN3hHJo+likAJ
	 +KxaMM6c7EyRBzFshcmwKepY2Fhbhdshjp3gWhaJQ3iQDbyBPJW8o8cPSdCn1DeMkH
	 91XKopjnj1gGhYFfygNE9Qdle+q3rH8pJA9gJQ+QS51QIBDVPayJdUd+RSXA4bVekx
	 FOFzjSYbYMFZvCO32CWDukhLvt/vWhDLI2bWpCCmY0YG4iShOV3MmVJD2Aoeb2lw6l
	 yIyGK46cm2LfEB/Iuv4doDKa4NwEk+gt0sLFrdAw1mw4zmPXBm1Nmx6JLx0/NMnrTr
	 jTegSsn1SBfZg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 939D0F40077;
	Tue, 28 Apr 2026 08:56:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 28 Apr 2026 08:56:39 -0400
X-ME-Sender: <xms:h67waRRU-dGrckzOMnNjMYO_AFaY3_d3aTrQ5PIvqEwseel3i6DQfA>
    <xme:h67waQUk1vZinwauV1tLTUTEuQGgAuX5wL-xa5LeGaXvp1kDgm7gnEl-lIfV01wpv
    JoHj0yPBczVHaohU0CQIsUc2SwN9fvIqrOcKjkybar-Kv0bO7A_lmc>
X-ME-Received: <xmr:h67waQZcdxxYFTUr5tuNI3G9LFl8ITirplenCAd_60WBgdCouh0ismjDE9ms7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcuufhh
    uhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheduvdeffeeludfgkedvueejfffhtdfgvdeludekveetuefggfel
    ffeigfdtfefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqd
    hkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvg
    hnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopehrih
    gtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrght
    hhihrghnrghrrgihrghnrghnrdhkuhhpphhushifrghmhieslhhinhhugidrihhnthgvlh
    drtghomhdprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:h67waZ7QjURZ6r3SAOx9p5oui2TzhiJqPlIaNnctEzG5vWg_ToYn8g>
    <xmx:h67waRzjc2W22Bpc0uymBB44nQxZXnCENWzFN_RPvutnZFnr79M1gQ>
    <xmx:h67waaommcfeKEm0DDvf564-q_qrGZet4zRvYEvVTcEor-iVxOQ2hg>
    <xmx:h67waT1wqXV9899-rwHA-bh85nqLsl4OmbySoZ4w80e-NgkJoSPzdA>
    <xmx:h67waTAWcO7rRU_MItZ3BOg_MpGTLsWM2jnUcd-Kf7LgELfVKQmutqZp>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 08:56:37 -0400 (EDT)
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	stable@vger.kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v2 0/2] x86/tdx: Port I/O emulation fixes
Date: Tue, 28 Apr 2026 13:56:30 +0100
Message-ID: <20260428125632.129770-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two technical inaccuracies in the TDX guest port
I/O emulation code reported by Borys Tsyrulnikov.

The first patch fixes an off-by-one error in the GENMASK() macro usage
where the mask was being calculated as one bit too wide (e.g. 9 bits for
an 8-bit operation).

The second patch ensures that 32-bit port I/O operations (INL) correctly
zero-extend the result to the full 64-bit RAX register, as required by
the x86 architecture. Currently, the emulation preserves the upper 32
bits of RAX during such operations.

Both issues were introduced in the initial implementation of the runtime
hypercalls for port I/O.

v1: https://lore.kernel.org/all/20260331112430.71425-1-kas@kernel.org/

Changes in v2:
  - Rephrase the size check in handle_in() as "if (size == 4)" for
    readability (Kuppuswamy)
  - Add Link: to the bug report on both patches (Kuppuswamy)
  - Collect Reviewed-by tags (Kai Huang, Kuppuswamy Sathyanarayanan)
  - Rebase onto v7.1-rc1

Kiryl Shutsemau (Meta) (2):
  x86/tdx: Fix off-by-one in port I/O handling
  x86/tdx: Fix zero-extension for 32-bit port I/O

 arch/x86/coco/tdx/tdx.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.51.2

