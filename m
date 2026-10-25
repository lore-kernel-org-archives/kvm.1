Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.83
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792914710;
	b=4d5VnNfGIzb+/1RWZHWZHQ5kDig/Uq3yBee2XVsavIblh4zwEP3fdRf7+hyCMUGfzSHA
	 f7Q94pLfrvOcCiG5MsILwWce2NheAJGCeoWXF7nqPdPvTm3kfFVPgRgldIu2cLOiIJN8s
	 pc5uJZf5svrAsN+C8NAEiFVmAoCdIlBPq/O7mcJtZEH2j+kcAP4qL6WTzNdRcFm9Zm/lo
	 yXicZvMA8OXnPi6aW9LHwr9ZtHzBCT843yXmw58h+EtAfB/rGQKOEbP5Rg9kcmYeDZ7nm
	 jnvFbytBjDmaC7QYnXiFUDx3+xfZzJ0BF+UK7lIelQFzTE+x84GuuaMZKamqqjW3W9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792914710;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BKCIoewPxqJjcEiMn9aSQhwGTJS5ZRgwusOumNV0ZUQ=;
	b=BFWCrkrXmX0/gQB7qTl+bDiQ6JzRXUWHaDM+qMTRqrpNK74lf3MzuUWCrTsvIHbjheOh
	 cKggHGpW7S1G73njJ/iJiUepKA6JHfsiTSC4Y8aGUCG8jgHJ1uoFclhA2JnEfxB32Xpci
	 xAq8tkqwLSIqXL97M1/xcYGyQgvdWGHgPexWNRNm4Y4HL1KSj9JQpQFYGUd4lItktd/XZ
	 LCNOLsX9uh7WaMNA49XurdfVC7RVFaY3WN4x6cu6We0n/CdZTbBfX/Mofrmm7uztArBRM
	 +Del74gIegqpAJ1hu3eg4TJDvC3W8o11dzZOUUBvG+CIezjcGr60QSFoPyjDTMaDr7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HdJQUu1a;
	arc=none smtp.remote-ip=95.215.58.83
Received: from mta1.migadu.com (out-83.mta1.migadu.com [95.215.58.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092D606A31A
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 07:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E092D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HdJQUu1a
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PFBAXwuqQFvijjX3+VrafA0FdNMSxN6wY89RZNPerd8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792914707; v=1; x=1793519507;
 b=HdJQUu1ayqge7qfrxwLdd4FELHnZf0oyAY/CGV7uKs21K5SrdMGw7oHi8l7mi/uI58ddAeMp
 o6vL1PVURof9cmd5g8Bv1tNTluivYqfm3Cn7jO7ATVFwM9qPpBydBp1hNgwkgxnVV0B79jNS9W3
 UE8s+melIna9HJxYBacDbXbE=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b9760d0147542ea5;
	Sun, 25 Oct 2026 07:51:47 +0000
X-Mizu-Trace-ID: b9760d0147542ea5
X-Migadu-Flow: FLOW_OUT
From: Fuad Tabba <fuad.tabba@linux.dev>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Fuad Tabba <tabba@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] arm64: Add override for ID_AA64ISAR1_EL1.LS64
Date: Sun, 25 Oct 2026 07:51:34 +0000
Message-ID: <20261025075138.2919734-2-fuad.tabba@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261025075138.2919734-1-fuad.tabba@linux.dev>
References: <20261025075138.2919734-1-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accesses to ACCDATA_EL1, which FEAT_LS64_ACCDATA adds, trap to EL3
unless firmware sets SCR_EL3.ADEn. Once KVM context-switches the
register for its guests, a host whose firmware leaves the bit clear
can't run them.

Add an override for ID_AA64ISAR1_EL1.LS64, with an arm64.nols64 alias,
so that the feature can be disabled on such a host and for its guests.
id_aa64isar1.ls64=2 disables only FEAT_LS64_ACCDATA and above.

Cc: stable@vger.kernel.org
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 arch/arm64/kernel/pi/idreg-override.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47e..ef690cf6c3664 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -571,6 +571,9 @@ Kernel parameters
 	arm64.nohaft	[ARM64] Unconditionally disable Hardware managed Access
 			Flag for Table descriptors support
 
+	arm64.nols64	[ARM64] Unconditionally disable 64-byte Load/Store
+			instructions support
+
 	arm64.nomops	[ARM64] Unconditionally disable Memory Copy and Memory
 			Set instructions support
 
diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
index 274bc72ba98d0..0c7f293779c1f 100644
--- a/arch/arm64/kernel/pi/idreg-override.c
+++ b/arch/arm64/kernel/pi/idreg-override.c
@@ -174,6 +174,7 @@ static const struct ftr_set_desc isar1 __prel64_initconst = {
 	.name		= "id_aa64isar1",
 	.override	= &id_aa64isar1_override,
 	.fields		= {
+		FIELD("ls64", ID_AA64ISAR1_EL1_LS64_SHIFT, NULL),
 		FIELD("gpi", ID_AA64ISAR1_EL1_GPI_SHIFT, NULL),
 		FIELD("gpa", ID_AA64ISAR1_EL1_GPA_SHIFT, NULL),
 		FIELD("api", ID_AA64ISAR1_EL1_API_SHIFT, NULL),
@@ -253,6 +254,7 @@ static const struct {
 	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
 	  "id_aa64isar1.api=0 id_aa64isar1.apa=0 "
 	  "id_aa64isar2.gpa3=0 id_aa64isar2.apa3=0"	   },
+	{ "arm64.nols64",		"id_aa64isar1.ls64=0" },
 	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
 	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
 	{ "nokaslr",			"arm64_sw.nokaslr=1" },
-- 
2.47.3

