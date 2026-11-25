Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598328;
	b=TPmTWeeqnKj6jRJwD7MCo20+EEgexWgg5m20yIM1xfLy1N5Wnt6xITuZqNMJ7K5mrbMD
	 cpX3aZ7YqlbHzkWk+VRLdMYaVBtgq2HY37JWrq5g3hFmwuw0R3S4S5EgX6nqpDmvl2rPX
	 MThE1aolnsBpLRnQO0c9SSY+glJrzGfNk2YcK5cgCBHXrwnCwAoQCnBMXtRcjGkj5uTda
	 waWRNdB4slIO2IoSvw3lKIlifHQK+TPFV6210p+ELz5oKXp0K2oeMPw+Ny1Op9x0ZICh6
	 RDBC3SH8dnWZCkQYVetMjG8DHUlp+BXGZ43UQyfKXBijbEWYJnx6CN3EpRKRtqVeHuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7h2E6/RXXaN8qvTmARnXOrgPNEtAf1zGpXXBrvYlAFw=;
	b=lUXXwnunnF8GPWVuOrLcAdYOYxZhe+d5/RfPqpos0sqfQAshClbsJRILc+FgBoqknQDK
	 7V/ZStnw+ibrkBDY2s7W/soK4alstWUUPJpRcwksLPqq7sZOELe9/gy80TuhJcfkOkRHz
	 oxqxu+dJ2vkpOHJBC7NN0Iff7rKOlIvbwYON6AcJwafdCJ/xFPwZINuu7SumLvAShL6+z
	 KALC3VW1fJWv+IrlLci/v7sWfNJkbXIGBGlN0WHk/rMra5BUUxoFAAIEhRqNo/G0t0hFQ
	 2Ov0YOpsy12z49CQ3ZftibDJZtOYpKqJ53jvtAwCDjQJ6rddS1Yv5PhWAko8h7c8GNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=EBAjagYT;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADC2606A690
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ADC2606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=EBAjagYT
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb61185057so35487345e9.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795598326; x=1796203126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7h2E6/RXXaN8qvTmARnXOrgPNEtAf1zGpXXBrvYlAFw=;
        b=EBAjagYTDtXb640X/LMHtmRmHPx8TPwRLOZXR+yAF4KZjGFD+8DVhHZHmT7RuUuBWo
         mvf6Za3XyvOXl0UpaX/caa/fPJxmqzUEc5orKXrb8WRR1aCwKmvrIB5l1ckTmufObfT3
         tgp+T8TJeMf9BweFFB9/u+woxehbFaugstbdDgKwEJNWzydE6ywZrQTJSDsJ7L6Ap93C
         shZKGAamOPiEYNRdJkg1KediWJVEXvDQJ7XXlndkKsMqjb9WYk+P7og1odXvH47WnDEs
         gGWI5ART/BFa51vro6SJCGwTxDZrRmXxorrbBRWgt2HTU/2K21erjmx/OewaCYCKzlog
         PVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598326; x=1796203126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7h2E6/RXXaN8qvTmARnXOrgPNEtAf1zGpXXBrvYlAFw=;
        b=HeZl3uHB45qbAqL3RtvD1+Jle9u+T/dRRhTCzELHaMK1wUFTVlgcwcQcCKz3va2bLX
         lnjpsAiCi4suM+spntOCziQ3KhaOIhAOlki/LlyRvsT6lzFwCQP/jl2dQOA0dRxlO41e
         FeqzDhWNkOHGLHz1ZpK19RCQv1F3uVHiS/T0xErzQ6Qs7uHftszD+BWyNomSlgY6MVlJ
         QpErtELUs+xeQL+HgJR6cxAXJdcbKTtc9CwhgNPhuyleb/zUSNkHTI6qpnAc6gZKtX9Q
         hvUa2H8uPvyyQquPsj5nziBhH92qZIdkNhV+wXUraS5xHNREDFEe9G0XiJUouvuFCYDc
         q65Q==
X-Forwarded-Encrypted: i=1; AL+hErFn3WLD1bWeIrNJ3aPqtnX0Q8I/igxBRHI8amkYPtPmkhmE84irb39ksX43aybzJelKmRs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/60cUXFBSE+8PfNiblmRQkSU4xd2MhoPqU32mKCbiyI99oWvXK
	AiMpR+1zt8D1ezKp/nb0oWb4zaOIL4XOdgRnvUpLJ5hecspM5C/YMq8/zhDWQSSHYAY=
X-Gm-Gg: AZFdTZf0AGE1B3VkRoZbe4Ca39pATnzMuwWBimvohfXZdvqDb/U5DYIN0E3+H3FwB5I
	MxS7QwhKtf9arsSD0+N35odzay88y8/qOvq9aLvP/KPywJFYG/y3jKfpaKilK9x4zfcO1tGGqqP
	CGIn5ccNRwBO354tswoand0yNeye1DP5AKc8X4Zt5tuk1gOOKYcZb3XOKqJp2X4Xr3kfZbq/unz
	g0kxa2bEwWTPXSsQqQhQi625Shs1p0XB185duNc33PdUXfvssmbMJJcRYTyvYZnwSJYXchbeRhX
	w21g44JVyjJ5V/7WTs1LiCE+4WCTHD7fUzF8RK9Q57Pl4+B6QAQ7qPzEfQ5vNVRNnhRHIu738Vc
	f+9QMl4iwAniYHnzEBIUgPrnnpJNZU0H4g4PhMej41Vt6Q2Rx0cmAAEj9LvnkfmvUVjfQ5id8M6
	0nk/J6nzCuyBIepLU12rgTvjPv/4KqtZuSZoLh6Ze3UcKuNPwI0b1ZThdnmQE7uJBsycDuNdR6D
	VVBBGGgY1c6DcrK9PDPKeHZDVGueouVlV1hCxqtlgqABpQ8ozbqOumpD98MIs6kKqwhC9/MhRrd
	tebm9//AoLYm7XW7XEw=
X-Received: by 2002:a05:600c:3b1a:b0:4bb:875b:3d91 with SMTP id 5b1f17b1804b1-4bb88820bfamr364901185e9.30.1795598326473;
        Wed, 25 Nov 2026 01:18:46 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b34e9c3ffesm16850149f8f.19.2026.11.25.01.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:18:45 -0800 (PST)
Date: Wed, 25 Nov 2026 12:18:42 +0300
From: Dan Carpenter <dan@pereq.eu>
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awan8mSx5cbzXzJ7@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <sashiko-outbox-232760@kernel.org>
 <awam4std0Zifdn9k@stanley.mountain>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awam4std0Zifdn9k@stanley.mountain>

On Wed, Nov 25, 2026 at 12:14:10PM +0300, Dan Carpenter wrote:
> Let me add the s390 maintainers to the CC list.
> 
> I considered doing it the way Sashiko suggests but s390 doesn't have the
> __vcpu_assign_sys_reg() helpers so it broke the build.  The registers are
> not the same so, either way, some of this is going to be specific to
> arm64.  But Sashiko is correct that s390 probably keeps a stale SP_EL1
> across a reset.  The s390 maintainers could probably take the selftest in
> patch 8 and modify it for s390.  :)
> 

Actually, never mind.  This can be done in kvm_reset_vcpu_core() like
Suzuki Poulose suggests.

regards,
dan carpenter
