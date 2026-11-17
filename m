Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794948226;
	b=qFByHmHcj+N2ERCtUsbmeO0KQIpZX0GF4bJm6TjXRwSx6fMgrtXlxdu65JSlcpG1RUEA
	 hsonMIj5TDjhUmI2KgUmEqc52EHTB2PHtoXUSNkk7Nlq+T9coW0Llil+4hFxl98AS2CZv
	 Xilg82ppWYQolsg9Mxi5kYoh3XRBxEVqRJ5C0yaIJNV7m6c+CbHW0e/UR1dx8OhaF9WJi
	 usrHdx/Q3oYjkGnB2+KBF1iuq/7y3RWs6uhRMhS641+tVJKdF1fDUfLWe2km73kGezEgH
	 NTyamh8b0mfdY865wjs+gta0WKDD1S+qUZGyphNoKx8ruLy1qXHPlZjjuyYnhJMmkbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794948226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=4s7Hggd7+AEEhOvi2jMoV+jP1lHkwbJcfKFilHVKaf0=;
	b=W8abGD3u5o3q0wRUC3/5wSuuj7vnzL2TJf6MDFZPVJ+8EOQeu9JqAnu8eysFyhCWug96
	 00q82vBHQth0yPrhPq/fjl8TcKlufnAXICCCKdVNkJUf/vG37KiHG7a8y41Y4XARew3Ua
	 ZrMGazSqxmJC/7gdegY8p6b1S2ysuUypbhJ/QX47Sa3uYx6Fwy0Qcto5eDxcqYSq4qN2j
	 Wco2SMwl5TOml0MqkpRsfOrA7JxrCKCYruyhpSZt1bSzY5v7n+bsyUG190s5ynWhzKcta
	 Ks/yOxAv1cfwGprzm5ow1dDfuV2FkfxKsjXC/Zre7xquOZlIo904IrQu9Tkz8MrJtpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hf1FZP29;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7D4606A32A
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 20:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B7D4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hf1FZP29
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e937c5bd4fso100803b6e.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794948225; x=1795553025; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s7Hggd7+AEEhOvi2jMoV+jP1lHkwbJcfKFilHVKaf0=;
        b=hf1FZP29riuJ8joZj5I8/Dp0oiP2wnkbiDC1o23rDnPmSLp/Hn43Cv5j+JMs7GJtWI
         GY4XVk4SGzv2gD/1hGDkvfR4PyLkN1SbhbVEWOCHhVXigYfTI5IiFZ4V3outCg7fLKpA
         vCGRxxFRna1N+qQbWgwATRt6SKNzZp6f+irfV8mLi6rf6IrGSr2eOOR53WzAC8MKHpAd
         e43LX8V3zA2DQEZuum/94GtpwdHbMml8ijD/hPLC0cJrEgbropai5JeK5TjAsROXHMFi
         1piRarIL5dhhrUptE+aNEJFI4Ux4AKv6Ozz7meutcWubDikRjWlSHuzw8Uin9eUVdtWP
         vH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794948225; x=1795553025;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4s7Hggd7+AEEhOvi2jMoV+jP1lHkwbJcfKFilHVKaf0=;
        b=Ub8QGU1GBXI2zv9+sT0cwviowQdIs5JQvC5UDpAlCABViZ/C67qoTiY5Sgds+gll9q
         npuAwtUBO7W6Hy9SFTd5rEWdfexq4KNSAoHp898FZhDFOyuYBGeiTbEPohAKojfqbRHc
         OmWGBUGbTt396TNokC+6BtNoCRlzS+kTPO+Vd2hLrWNkxkvtKKuPGjPbv8j2+DAHzeGH
         l77B4Uoelw0NxK4BOAbXu/75VT04whcpOYaoCvAlYFdhjAWP6jfocA4LGfLHIeTdq5wT
         XUOdblp2Q09rkRoJridy3D3R0I8ND/EScX45HdO12yZBm9YJe7PgsoS2zk1oO70xqPZw
         p+lA==
X-Forwarded-Encrypted: i=1; AL+hErGqsEYTrppj+ygBybw8Yf4Smy7xezYxAv93H+AqBH473jCd7UmrKFhGEIjQYsyAHRQ0QZE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XQd2X99DFA5vQvfkKH4k8mOd3scpNSypfKTYPPltP4+0/YXu4
	mgIKP3q0uGeMYlxh4qQmmbkt0uweAUVn7cWfDQewAm172l9nH8EMXH1LIK5TWDSzuYGIRp++sW9
	iE1eYWY11pN4Hw3QkUmxFJYxzJw==
X-Received: from ilbej27-n2.prod.google.com ([2002:a05:6e02:4e1b:20b0:522:8039:f8b4])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1c0b:b0:571:b166:3d76 with SMTP id 5614622812f47-5773c6322b9mr918759b6e.29.1794948224648;
 Tue, 17 Nov 2026 12:43:44 -0800 (PST)
Date: Tue, 17 Nov 2026 20:42:19 +0000
In-Reply-To: <avyNBn24sLjxrfgR@LeoBrasDK>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116200418.3535619-1-coltonlewis@google.com>
 <20261116200418.3535619-2-coltonlewis@google.com> <avyNBn24sLjxrfgR@LeoBrasDK>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261117204343.4017815-1-coltonlewis@google.com>
Subject: Re: [PATCH v1 1/2] KVM: arm64: Fix inverted E2H0 check for HCR_EL2.NV1
From: Colton Lewis <coltonlewis@google.com>
To: Leonardo Bras <leo.bras@arm.com>
Cc: Colton Lewis <coltonlewis@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Leonardo Bras <leo.bras@arm.com> writes:

> Maybe feat_nv2_e2h0_not_res0(). What do you think?

Agreed on renaming it. Since HCR_EL2.NV1 is the bit marked RES0 (while
ID_AA64MMFR4_EL1.E2H0 is the signed ID field controlling it), I renamed
the helper to feat_nv2_nv1_not_res0() in v2.

-- Colton
