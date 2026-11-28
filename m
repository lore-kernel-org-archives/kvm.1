Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847245;
	b=AYYhSWEs2YyF9X2E5F8VkuhuIe7L4U5eivR9vjNqK+/fto2LQ1qKj59J0oNHpYNldBUD
	 vDE9t9WscehiLvds4b7gGq7FvcNpl/72S99RlRXml6rpYM3AgGsoa3Phekp35MxCbu6Ze
	 KsPDx1/8v6n/wmKn0UhISZaCtutEBKVrbC79fnVMGFpQiCPmwxRZXJUd7FEFOes+RKptt
	 5WuS2XyocSNbfHvKOMGF4AlimcQsNqJDuXd88IXUwDmseQOWkK056Cp1QmxHLnTkMqkct
	 vrL5Q5iPsI8dLS7+KP+eIixpMN4hWE1GKAJhXN/m7Y3YqLSnjWWM+pkww8TBYZEGL4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wcZBeuMIMZGh5V5Nkisgmrflj3EBBSr6rcajrufM/Cw=;
	b=sZw2pyYnR5T+SU+h4iDiKfh+RzoZXbWLKV+mLXLHScz+w9OkSeyZ9iiptdjSPHgmbcnO
	 3y5/trH8arHJa3+bfEpyMPF4zrp1nsyO55xmmFQBiW400xKdTsyj0YvRFqn+K9UMOC9xO
	 kyuy6YzR/X8RRItAoPq7ChShU7pofuRPAPpWv/M2hSD1MTwW+Mfe7qrm5JCnJvYYuEqBw
	 NEv2LZfZofeB+Fty0Bk8tMxBWgBCQcWEYDVxYDnJvT5KXBvp2G8YSAARfmSP8lzT2bEsy
	 eU7FnEoOfSzHiEDHTZVVQH2c7oCkLDVM9DATlq8IT/KB+ACiQhe7Rnb+gAAaagpx3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jIKbU4Xd;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0DD606A31C
	for <kvm@vger.kernel.org>; Sat, 28 Nov 2026 06:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB0DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jIKbU4Xd
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bba5e17cbeso32703145e9.1
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 22:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795847243; x=1796452043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcZBeuMIMZGh5V5Nkisgmrflj3EBBSr6rcajrufM/Cw=;
        b=jIKbU4XdZkWkydk5e42m6SuDkTymeUApCS1QrZ/yE1F90oMAeP/g97BSMVLOlgzQ5c
         QqVRA3K74kPwq3xGYhEuqROx+/YEx7pb5UcPaBVxzDA8nmDm0O8XqkPrXRcfydT61nrM
         iza4xM9uZ6Cab34jX9HLCnXDOh3NooME7gRZR9cUBctCKn6IsaV/PIps+LeGNvBg3rKz
         1MtQHuhrA8WiuZ9Jtih5GJwlk696YrzS6CYmiBHjA15LZyN/RjN6avJj/A0YPfXpCjev
         RDFMU7PUIpNIEQiIy9553WYur5Gbe6anAO7wQYDczuZG6xzsTkil5Xu0iSJDXMbUi6ER
         W/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847243; x=1796452043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wcZBeuMIMZGh5V5Nkisgmrflj3EBBSr6rcajrufM/Cw=;
        b=qlxc+FcnVQzZyh1odJpkmD8DFJTC6uW1ylIDetHBfppMGb8Ww1yzplV1k1/nei694e
         jJGzhd24LOfllwNDJa6S1qsoSkGzNzJIYtkznltpJlf+9UXd2hwmm3Xl6g56zWxqG3bs
         Ep5XIOIKszcc32yGJ4mac/gcyxsGkDJCapW41Ln9skdrdMHCZDU4/sPJJ/l7HHmmPb3J
         HWtm/EBQfywQpaK8M/xchseuzNXSXfEXdhk3E27OIwzDvqxj0znZf3wUh9xKtOXtz28Y
         ApdFjNgxlZlV7CmFGyb3aniRGDsTDsHrr1vAj1399LSYShDFa8IIpJFErjkEENE1NrFC
         Oeig==
X-Forwarded-Encrypted: i=1; AL+hErFT1gEjmSanBt9VAgUCIyEFBARQGmlAqtqwEeDh9WTpPBirdvzOx0aw9TgSwYlxwtoXFHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H09LDFknPggQn8EsszHNKahmFcmG+LJEdRPQ9VO/h8vcZeEVd
	Ko64xTzFiwh745wFGBHx34XrNzM+FIEqAGoVdSSAyfgsNjzbINvDfSKg
X-Gm-Gg: AZFdTZfeuweARQlKIuqAj36ppTvzgA+f8o69LiThZt4ammzUhuFDASmgBwwKr3PT/K+
	vXIbW7AtEbWwGWIFPvZ4Jyu/E++su/MWn0e2CFysBNPJYjsTDcDITrR8PpVIu6Y4Ijap4Srna+Y
	MXd4Gc5HGz4lNPKWSouQyiYqdVchesNkLBGYdxbjdTW5Zn2QTTloJyF7vCGPraEArQoCn6Bd71+
	3oplmDyVUNINLF6DbW0nYFAaGZdijDWaIQ6sfGtq0jbPgSNe7zt27jFQs+0nGy8eI71kh2ozR6d
	6dLV3j/NXXaZVJBET2+UqBlRczOatSeiO/5lRaM1R77m4CB6pwGm4nrKLmOjBASktA7cg29DIXO
	n5prTi211CKpv+s/ePHsPqLE9rC5CQv2ziFHm3BEk962huXnX7DUoFc+Man/wr6fQe7I0l13/e9
	C7oWp7J5RuVWVV5Oo9Yr4XBfsVXBJZhWbFl3u4Wb09wLsNGVFWU0fGyZ7yT7SndH/mdT8LueNkz
	kw4GruqGnuJAkvrV0dtGFR/LAkeKT0X0mMhhFDOPlwsD075d6zytiwEivUhShE0+8vvXZGu3IhM
	wWmaZVF5URBOHJqvQQTG2tC0Q89Dd5u2XkpHLptFD3KlwCk4dDCbPq4CrYrWUrxVrVhY7GZGfwQ
	ExeSx6AgnII+rJrxALAzFZSGY
X-Received: by 2002:a05:600c:1d8c:b0:4a1:c5eb:b445 with SMTP id 5b1f17b1804b1-4bb88820436mr553100495e9.35.1795847242750;
        Fri, 27 Nov 2026 22:27:22 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm685756885e9.9.2026.11.27.22.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:27:22 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
	Eric Auger <eauger@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Khushit Shah <khushit.shah@nutanix.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	Haseeb Ashraf <haseeb.ashraf@siemens.com>,
	Marc Zyngier <maz@kernel.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with SYSREG_ID_AA64MMFR1_EL1_VH
Date: Sat, 28 Nov 2026 11:27:15 +0500
Message-ID: <20261128062715.130056-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9746F4BB-6688-4B39-AC6E-DC0295599927@unpredictable.fr>
References: <9746F4BB-6688-4B39-AC6E-DC0295599927@unpredictable.fr>
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

Hi all,

Thanks for the feedback.

For the ID-register cache, I can drop
kvm_arm_refresh_e2h0_idregs() from this series and let Eric's SYSREG
series refresh the affected ID registers generically after property
write-back. Please let me know if that is preferred.

Regarding the interface, there appear to be two possible directions:

1. Keep VH in the SYSREG framework with an explicit init-time
   exception, as in the current RFC; or

2. Introduce a higher-level CPU property:

     -cpu host,vhe=on|off|auto

   Here, on would require VHE, off would require nVHE/E2H=0, and auto
   would retain the accelerator's default behavior.

The first approach follows the SYSREG_<REG>_<FIELD> model, but VH
differs from ordinary writable ID-register fields because its selection
takes effect during vCPU initialization. The second approach keeps that
implementation detail out of the SYSREG interface and lets each
accelerator evaluate the requested mode before vCPU creation. That may
also make future HVF support less awkward, as Mohamed noted.

Since v1 used the separate-property approach and Marc objected to it,
while the current approach adds an init-time exception to Eric's
framework, I would appreciate guidance from the maintainers on which
direction they prefer.

For now, I will wait for that design decision before posting v4 and
will adjust the implementation accordingly.

Thanks,
Haseeb
