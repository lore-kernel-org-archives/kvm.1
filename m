Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522249;
	b=oPujZWaG3c4Z04yq1r2PKmVcPgLHtY8jyhF3+a11U5rA7BAH49qCwhoB/aeqMA+8VfRQ
	 geqFFwMecJwHiauLkGlTPzXZ2RRg12UDQrbn6DmSkUAIzbo5AljQZHjASFHkzmOOoCB1i
	 /com7p0ftaplA34GvHURW252+NRyqX2WLnV9niVMw/lbTUNOIB+gbNpSv3yUhktSlQYtH
	 sqTw0f/b4r7M54CbaUid7s8U5fcXbSL3SQtjoxmnePE1u5K3fq+GTeuomBCyhaVYVd7oL
	 59BZPGR2R4Eq+vHhbJNw76kr5Qe2IHF8H9WCxX5Q3YMYwvL1xKAggRu/Cm5+PO/GZOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522249;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S6Cy3EpSYBPEqoUBkddb4jPru4ujktF/dPMRtIFOmkM=;
	b=3BfVqgHroUl+TYfifKzZsqpTMBLVF9v/1GMd8hIuQhO+5QYyRiOPbA7e5MZc4KtV8jvy
	 LmjVK/5W+BfeJeaPN21eyWCRxRutnFElQsej8oRdl/9A65/a2RwF7oRupPTqXKqcf1xsN
	 +h/W0YY7j88iYmyUoNBcashiFVPe53RPa8WxDy4Qz1DJB37eribWFGQLtm5LqQlWu3WlT
	 YL4ELbvn3RAQ4zL7qhtz31E74YPRT4GyEyJbIMV1wCZb1k+cLPihSW5ZbQu3QbA5Iwb/v
	 JmK5HRmj4SUJCrRg2GtNbg2XYQ1XHcl8rXf+is4sRWM4vzdmAm3o7f6Mhly9Dmox/7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b="B1GaFK/v";
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364C606A321;
	Thu, 12 Nov 2026 22:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4364C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=B1GaFK/v
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9FF0340E0231;
	Thu, 12 Nov 2026 22:24:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T5saqsF50iug; Thu, 12 Nov 2026 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794522242; bh=S6Cy3EpSYBPEqoUBkddb4jPru4ujktF/dPMRtIFOmkM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B1GaFK/vWQrKG1uX3J1hargPwDG6JnkRgO9kyuJ87pumCZNN3Xd/Z+vceAWmDvLA5
	 szJajHThhNmMaWrQ5EEzPNyGcFPUJ5sDGTsmd+JiDwBrn7il6rBaQ64PcRqmzPJZ6o
	 4AQY/CFaxeqYH/MgkJloD25Z1SU8lRb+9z1Ji8ENpMTFPq3acj/FsQ4C2J/d0EMMe/
	 P4e8bBIZ1khLndBpbKQv0zRSqoPQ670BdNunhvoxAn9zTkPwzQfvdote3MThpAdwnK
	 OfoZsVw6qV/ZYiL9LAOjLHBq/MkPDfAkeQ260GS1/FY5oXuAuLdzP914xKP9nFLYEs
	 T/FinBagE7BIa1grsqXZg8qrSaAhOwPgbXtYLxK93mTx8KD2LwI8WLULaMz8wWVO7/
	 wso03iRG/pKw9JCGZSNmB8HOhEekLpWVUefepp9yxl48GveQiQDIM78g4GVl8DypZe
	 J9KQO1R0bWqkFMKCxNSKc3M5DqrD8vBkJ1cvgOjW4sCl0qNGTwBmII73Ohkhr/KtCr
	 1lfv7pYAOUqscBHBUKJv7qaSBm9HcM9sWP38+MVkUFOSzx2+S9AgdZMDsZdxMjSvYi
	 DRmNu3AcWhLbpq2izjZVHcLtC2G2PF/esv0/B5MsqknjgLsuivNYPYmrZ8YkSvGWpI
	 m06kREaU09u7AwXy/Ed8zfyk=
Received: from ehlo.thunderbird.net (mobile-166-172-120-26.mycingular.net [166.172.120.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6EA940E015B;
	Thu, 12 Nov 2026 22:23:48 +0000 (UTC)
Date: Thu, 12 Nov 2026 22:23:43 +0000
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Breno Leitao <leitao@debian.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, vlad.wing@gmail.com,
 security@kernel.org, kernel-team@meta.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_6=2E18=2Ey=5D_x86/cpufeatures=3A_M?=
 =?US-ASCII?Q?ake_X86=5FFEATURE_leaf_17_Linux-specific?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com>
References: <20261111-stabe_srso-v1-1-45512320ba5e@debian.org> <20261112045703.GAavVHH8KA2yyCU7oc@fat_crate.local> <9492bce8-aab7-4982-8a0c-7d736c745e12@zytor.com>
Message-ID: <29B14106-19E4-4589-BE40-3D42BA646CE3@alien8.de>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2026 10:13:31 PM UTC, "H=2E Peter Anvin" <hpa@zytor=2Ecom> =
wrote:
>Still, I have to wonder if it really makes sense to fold these leaves lik=
e this, since they are going to be populated soon=2E Surely we're not that =
short of bits?
>

If you mean the leaves in scattered=2Ec, I'm thinking the moment a leaf ap=
pears there with half of its bits, it'll get moved to its own separate leaf=
=2E

--=20
Small device=2E Typos and formatting crap
