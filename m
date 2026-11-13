Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794612817;
	b=2AQmTyTNIQsJwQevxAiUPWP6MshsvwF79uZpfc18HTXg4sftb3M+LWowPaIK2O59qDyF
	 9NOsxShNszAxXiNVnwYimDY7ga076ItGbJdnWcagrgoLzbqdRKSS1zB8cFEqiKvORPk6S
	 XtFd/k724WDIAcepwYxW1sYiNr7ma5ivVB4gA9hCnVV408kem9pWz48a3N16tY/2yb0g2
	 NO/610/N6xefwbnqTL4XaVy8b17qnMiHvJGCqxlKkzcPp1yZRW/USxn/bJxlBPsPOA/mX
	 VCssxT3jOzyfHeoWIf2WKs+M5W2V1ttnZXYqWdd9VFZ5eFlDcFklarCGC4QD6zYDSeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794612817;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=M/i/Ynwqw+pfbLKXDHYYoCFsRPcW8TMPNBDCCP4OkdM=;
	b=Q6J2Z0esN+zRSjUj24Re5oOVZdEkU83PB1iaF9JqNna3OZr3t6x8pbOxDy35MJ74yVmy
	 6SmycbFYj4MJSEHkdJxUHQOu6qTaVhJ34m1/sHvkOgZlGn6Di1RwohJ/XKqYtvbiSKzLM
	 HUW0KaAY7ZdPZ5WqTcpBgJjOB25ckpictXtA/gNc1lopczncClxVDCp+gDY/bJtGue+Hq
	 fuolbzC4ziQalC2jLXBkBrgfbAmFRLK3btX7dk7pdZhgwvc4x/JIMtOU/udjACBm36Vpl
	 a060+f8GnTPl288E0NSkmA4r7o5X3yna1TW/zoHKqzw7P0aLgZgfzrQk0/tPRmZXI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=AkMu07Gj;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C09606A327;
	Fri, 13 Nov 2026 23:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C09606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=AkMu07Gj
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6CADD40E0184;
	Fri, 13 Nov 2026 23:33:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OK7KlsJqDe9p; Fri, 13 Nov 2026 23:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1794612804; bh=M/i/Ynwqw+pfbLKXDHYYoCFsRPcW8TMPNBDCCP4OkdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkMu07GjwQ82MBP+6gBaiGnCrVDqU9lAfVRhTkMPK3E5ItkZV08We/V3Rt8OB76nh
	 BJIuZlqMyBcO5/p84Qajl94vvTwhahqkv+/wNtoQGBGQSo56Y3IogQHTxEmSjQRvpT
	 FXJ+/YYCfpBAxm3h2dGyst8e5VPu9U6Chx9S3ecxyuMenk9yjRwyl+k/WhmyRMh5vM
	 smMbzQwHDnVx3zb/d/xDEyYlyUSmkdkgnyqhc+ytVtk7QVVIddNo6DCSRjlpGXpOzL
	 iXNu29y6gSrs/hx8l15E5O/JrP4xeQ5r/eADptmcJJ7d1+GTiJMQnehkGSvHXNBbJV
	 HYJr6bkbxH/DtC/+ffD69pyO2ZJAkd0skTfxfI6lfERluQv4VD6Y171xQRv+e2uujM
	 +QY//eEn1tDVjErmBL8OZpMIDpvmfs8Sw3ZstS8Zl2CedTSq8Mjs9D9AtIp951ltd7
	 DJ/Bdiz7afY5O7CysBjnFP5mHxapwWKrwKKr96QxQ4tuV5AIlfDaDjyjKzFYiyIYvE
	 pmfkNRKF2u65pI6OOLZj6254T9UrL1l2UWthn76rZ+kpO9PGdqdnHYlq0Z3xPrZELn
	 8kcAs+2s4BnJt3jfUAhAALXKxLqffaqHMEy8QagXryptrVInQaZcGkhj9vY6Vu6OQM
	 DFQU6NFL8t52oXoe80/ArClE=
Received: from stx.tnic (unknown [209.52.143.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3A22440E015B;
	Fri, 13 Nov 2026 23:33:09 +0000 (UTC)
Date: Fri, 13 Nov 2026 15:33:05 -0800
From: Borislav Petkov <bp@alien8.de>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, pbonzini@redhat.com,
	thomas.lendacky@amd.com, kim.phillips@amd.com, nikunj@amd.com,
	michael.roth@amd.com, ashish.kalra@amd.com
Subject: Re: [Patch v4 3/4] x86/sev: Add guest support for Enhanced SMT
 Protection
Message-ID: <20261113233305.GBaveeMRizuR-KfjE9@fat_crate.local>
References: <cover.1794244450.git.prsampat@amd.com>
 <c64b614ddc83eabc6bb1bdf288272110df04256a.1794244450.git.prsampat@amd.com>
 <20261112184929.GGavYKObGQNQ0wbDpD@fat_crate.local>
 <avc-5lkQhoR6US9o@google.com>
 <43616e23-cd28-4017-ba12-1a0eed4cf05b@amd.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43616e23-cd28-4017-ba12-1a0eed4cf05b@amd.com>

On Fri, Nov 13, 2026 at 03:23:12PM -0500, Pratik R. Sampat wrote:
> Boris, series 2 still carries the X86_FEATURE_AMD_ESMTP/scattered.c entry and

You can hold off on that because I wanna whack scattered.c first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
