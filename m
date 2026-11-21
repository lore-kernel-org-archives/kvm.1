Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265951;
	b=Z4+x9J0JSPcFS/grRYNJBCH+6sIuAqjDllBc+QxCzDhiOEhCdm1Bz65wFprzvI6A823E
	 aqMCYabV+CQvDuRxRw6B7YJkFoMaTNp+aVa4KelA1fb+gEVRihxSgEvcwRpRhT/NOFGFR
	 nuoGNreCOwnftXRgTcvc/QYLj7D4GX2DedTs4MYLES0UKbAoP3Vdl8lgHZSoJfoD5ZJnp
	 rizRFfClwKcq7PPNDJ73CW6rVGhtTz8/OySyfqZwEbl85c6cNrilaG/i334l3Rp7K55Mf
	 IDCSK4HnMmcXw/AIzN5TQiXw6TmkP9uzacQv3Cgix2dG17Ii4elBBkQJ3T5wpVy1SkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265951;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LHw9hhByR5W+5isYku0aOkbyv5R/DWvbzdf1tvKzPQQ=;
	b=PFOORLSLbrA1QeJ104/zXajgCxV99hAu639NVznDRI4mocyV+UggRwgnrXSRHEPoUqHO
	 J6FkBmTfan3VeIHqGWyVO6jEHV8HjIQ3KBcRjxgv2Z65jcyWVP58xYMrrtwpzhitPb9ru
	 P6zBgBYw+0ksbuIod8/VV1d9S+F3QXAT5JWDqxfOTX7JLkEPW+5xqtyGVDK8zmczBzq5k
	 vqkbteXbbZyTugoDyTGpcNjuqKMm7AkHtutcqCNjbmErn+/sdLaH/c2aAzIBuwJrxTJB9
	 It2Tjf5E5qadiqN+YLssolDUHweP9dnyvJnHpnVDYRWhWuGvMkxQLkzGEvbb1+agF9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=NyZEmAHn;
	arc=none smtp.remote-ip=79.135.106.102
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24787606A320
	for <kvm@vger.kernel.org>; Sat, 21 Nov 2026 12:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24787606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=NyZEmAHn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1795265949; x=1795525149;
	bh=LHw9hhByR5W+5isYku0aOkbyv5R/DWvbzdf1tvKzPQQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=NyZEmAHnlA/LIiFfV+YpEXhc1y+scANQbm9GQbwAQkg6mTs1KKXT2p0ch0aYEHPAW
	 Xb05MlByxrROp2AZJVXh/Rn/Kd60yG4zPXjVHE3FDz6NNTcn2ELGNmB126uBxVz6zQ
	 4yilCvgEw/4LDuROZvWkhX8ZiUxVVZZ2KLdlmZnFSoP9JfVHLrftWbqgA/n6V2U+n2
	 YEtsjHSjyq300Tba1xZY9mTux6nmjeajJouoZ9XiVz/NQjUnghBF31f3Apnn0T0PK0
	 i569kZFOckLDlfi7fKc/9svgQ1JYufmiY6/FQ8zYOZlUi6n0lcXr494fJIEPLK4iju
	 0TNi+/6wz1iUw==
Date: Sat, 21 Nov 2026 12:59:05 +0000
To: "kvm@vger.kernel.org" <kvm@vger.kernel.org>
From: Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc: "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Linux KVM Flaw CVE-2026-99312 Lets Guest VMs Access Host Memory on AMD Hosts
Message-ID: <Ql3dvLz2uQYZFACks5SUAF1ReTATGk4LY66UljA6BX-2k-MFc2C9OZG0tJa25DX_ecvJV-qZBF2wYkJp0Kq5G6ox9-iS-K4CSBB-0nkfbfk=@protonmail.com>
Feedback-ID: 39510961:user:proton
X-Pm-Message-ID: de9151258ec482e799eb65274afb91296798cbdc
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
Content-Transfer-Encoding: quoted-printable

Subject: Linux KVM Flaw CVE-2026-99312 Lets Guest VMs Access Host Memory on=
 AMD Hosts

Good day from Singapore,

Here is an article which I would like to share.

Article: Linux KVM Flaw CVE-2026-99312 Lets Guest VMs Access Host Memory on=
 AMD Hosts
Link: https://thehackernews.com/2026/11/new-linux-kvm-flaw-cve-2026-99312-l=
ets.html
Date of article: 20 Nov 2026

Thank you.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individuals Singapore
21 Nov 2026 Saturday 8.57 pm Singapore Time





