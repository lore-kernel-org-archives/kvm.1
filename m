Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EBF42B744;
	Tue, 28 Apr 2026 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777381010; cv=none; b=WuwgjotsAyemNoRidIfwDtIaDo5iamwMhJzT9xQJTo1/WCqq3QevFFCMz3IdIFWPQvpEaZElhfKQz39fQTTklcbwjUbt4ffh6RHXuw/EMtWqFOdyv8FvKybfc7vx54QvUx+lpulbtvU5LQOHFfwR0p71gxf9bGmNLL1DwsmlzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777381010; c=relaxed/simple;
	bh=2hl4a9MSG0TGWQxwpRoQsmFXs3qdRP68o0BXUM60uUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klzSJ2d51o2DlmXxgcVKbestP8zou30P/yNGjV90gIbrIDdP2bo6Oq4zwvam2av+RbxjM5Q+Ny7Yc3PgJRmpjz8KZdqaul7Clq/3EJnJ//JXNMQNQIq19pHBNQT6dVDDSdWkgWIYM/JCgEBHxnN4JL3piOKVK1e1OCX3ia2Q9ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayPlWpiG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayPlWpiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D57C2BCAF;
	Tue, 28 Apr 2026 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777381009;
	bh=2hl4a9MSG0TGWQxwpRoQsmFXs3qdRP68o0BXUM60uUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ayPlWpiGVuBAWzNY8NFal5aIfyy49d5jfvMKaIiBlJBVVu7ZRAWudgweP5iynVTkQ
	 IPT5hFAfG6nMBB52e9tNsPLGfua3AeNpPJwQAZmmNnajMUx4YzQtHHr1VANGI43BVZ
	 l/TSgzGC9RmM9ECNw0i9M5O7051P45yEkXjxtgEh0rOJWxzh20iMZ4n+3Rh4ygBkZr
	 xSKWa7dn9D8WqqTJE5X9Cw+5vd01Q8dHssdoDnJ97SNIGj8nU1v3HNq2JCPiS3cQIF
	 HxJ2TFw6akb53I196yIBEuB9txa/A7GLCw7RTJWE9YQAkh/Ula2l1wqA7VOizNtZ3A
	 6M7uLUywdeTIA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id E648DF40079;
	Tue, 28 Apr 2026 08:56:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 28 Apr 2026 08:56:47 -0400
X-ME-Sender: <xms:j67waaAoshien10nL1wO75QgLQag663uXJXwa_8FTBMMj8U3rZ_tNg>
    <xme:j67waaFrjnt45q7a98SQwI7gvSz-9dvrvGddcLmtjCHbhVAoXkPIa8zCSZ6KlreUV
    sdAiVnPbAeIB_DkjA9mqQIcmZ8B9ZkycueveNSgv3q6NHXqRRJRW9c>
X-ME-Received: <xmr:j67waXIBFHvE6Osp4DeQ1DB0raa0od7uINYR8w-xLKjgi6f4vTDY2Ld3f1OUyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfmfhirhihlhcu
    ufhhuhhtshgvmhgruhculdfovghtrgdmfdcuoehkrghssehkvghrnhgvlhdrohhrgheqne
    cuggftrfgrthhtvghrnhepjeeliefgueefleduieejuefhffdttdehfefguddtffekteeg
    ueeujedvffelleehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvd
    ekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggp
    rhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnh
    hsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhope
    hrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthhopehs
    rghthhihrghnrghrrgihrghnrghnrdhkuhhpphhushifrghmhieslhhinhhugidrihhnth
    gvlhdrtghomhdprhgtphhtthhopehkrghirdhhuhgrnhhgsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:j67waZpHb3EsN1NkuHi1PYZD-hH37R5ObQGUsj09VmTE2K7VjyRtDA>
    <xmx:j67waWj0qUqs79mR0cWwGeOEUVfyvJNM6oknJDLprIbS9If7NunJdg>
    <xmx:j67waQbMOM1TL1x-jcT0RV8k8goHs65trTEOmvCVWViyfYhBnLTCig>
    <xmx:j67waWmAA4JP-caNP33EkJNrgfJNUG8uh1VtpjMkstk1OtBUgsiliw>
    <xmx:j67waeyA4Cs6z3yZ0_2LLgWdttGcHzA_iVWvqThthFik1a4G4eMhcSBk>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 08:56:46 -0400 (EDT)
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
Subject: [PATCH v2 1/2] x86/tdx: Fix off-by-one in port I/O handling
Date: Tue, 28 Apr 2026 13:56:31 +0100
Message-ID: <20260428125632.129770-2-kas@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260428125632.129770-1-kas@kernel.org>
References: <20260428125632.129770-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_in() and handle_out() in arch/x86/coco/tdx/tdx.c use:

    u64 mask = GENMASK(BITS_PER_BYTE * size, 0);

GENMASK(h, l) includes bit h. For size=1 (INB), this produces
GENMASK(8, 0) = 0x1FF (9 bits) instead of GENMASK(7, 0) = 0xFF (8
bits). The mask is one bit too wide for all I/O sizes.

Fix the mask calculation.

Fixes: 03149948832a ("x86/tdx: Port I/O: Add runtime hypercalls")
Reported-by: Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>
Link: https://lore.kernel.org/all/CAKw_Dz96rfSQc6Rn+9QBcUFHhmkK+9zu+P=bxowfZwxrATCBRg@mail.gmail.com/
Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/coco/tdx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 186915a17c50..65119362f9a2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -693,7 +693,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 		.r13 = PORT_READ,
 		.r14 = port,
 	};
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 	bool success;
 
 	/*
@@ -713,7 +713,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 
 static bool handle_out(struct pt_regs *regs, int size, int port)
 {
-	u64 mask = GENMASK(BITS_PER_BYTE * size, 0);
+	u64 mask = GENMASK(BITS_PER_BYTE * size - 1, 0);
 
 	/*
 	 * Emulate the I/O write via hypercall. More info about ABI can be found
-- 
2.51.2

