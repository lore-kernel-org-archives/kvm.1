Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6C23D2AB
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774579065; cv=none; b=sstDkIwcFiUCFSyE4H+GLJ2z0V+G+yQEIxHgNxrtTYyzyaAi4kGbSW4Oao9h1ECBDXENBMAB0fIxuRIbQW7lRPaUoQRtiqLEbaeUG8UVauyIvRuBRhSWryupSuiW/8w8SvphyJH8CVO5C7Iid8RRppQtDHwNGvdfT7asTSSaRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774579065; c=relaxed/simple;
	bh=sso6wnQOmcPsgryxLOS1dyVwikJhyGMFvPTQ2LZWG4E=;
	h=Message-ID:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dv/E1HNDPu6I10A3r317tQZqtuyL1VuJ3gQ32/kzyPiptp6CX9Mx/VT1rkPt4lk4Ps4dtsCbv7fGTntJ5Z4laR8/wy2Mmg9Mt2Z8em0JlXKHKuo+cplVGT0nwUq5/wILGxRfF0t/nbVQdamBw+wxdfyZO8ocIccxNlETUmJFVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d22wXMMk; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d22wXMMk"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so949428a91.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 19:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774579063; x=1775183863; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sso6wnQOmcPsgryxLOS1dyVwikJhyGMFvPTQ2LZWG4E=;
        b=d22wXMMkjn/NjO4GOwLaM1sTDTtKwSLtx+RiUhbp+cSixJe/JsgMy1/Hm6Uf9+Cksd
         Z8VbOp6jLJaZg88aX//q0Pf82Rg/cb8lTg45LnrIoNzjwOZo6Z/29BvpGvg+dbphH9Mc
         UuBMmPAuxLKid7N44nHk9PVGEAnYeFC3WhV6vIzrq1feZWezbfB2kBEXPXT7BGOpqhAO
         xhHJblABqLyEQ6eNR2CafURq4vrgDhwB8bsWLgL3E6MSio0vgbDaEqx5exyM/OVLwjCN
         XTZarEVw1n6l8mmev1Xput6P/+U4rsRcMdMC6xHuzd6Ypb1E+bFZkliH9k4ia50bngEQ
         MeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774579063; x=1775183863;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:date:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sso6wnQOmcPsgryxLOS1dyVwikJhyGMFvPTQ2LZWG4E=;
        b=PGSvk4wihacMYti87g4Sj9ElUfUFgbDpwk2F9tQdJSmd9iNoIdFkcUIAuMm9UtuglY
         CkS2CoDfVhxQ9ZbLF1DJAEUKMCQkdGdPCsCF7MOlP+MOzNlHCW3aOBITozf/oV4nbTB3
         salZ8vs/QeJ3STeNzmKnMdzR2HlLNbfNG/7cmnJxxkupP05XcJNpTNaijt67e21TdGQs
         JxVwIj40IPlQyyvVEEG6mIUVq0ezmdzjuFwoBTI0ZVM7wG8oLWb566b7budOeoo5fQQB
         x3KYsKVtb4aOpu5m+2moagsr/eZaYR5NXhIjytO7xw0HGhu3aMBeXIrcceB6SYLsDa82
         SrDQ==
X-Gm-Message-State: AOJu0Yy9OGuT/bPF1EguX3MiD9Vk0K3XlkiQ9xTM2sLwrtbS1DuLecxo
	QAokOJFChaRCbD4wi8i0SZRvVCN7weR5fSIuughufLaAvRuv7az4zBHkQOyo1/gwkJOviw==
X-Gm-Gg: ATEYQzxoeOkY2HfcBiH9AE0U+RPahTWw1iUBJzn7+DXj0ziyuJmpmGYkJMdiZX23ckx
	iBYw/FJF2XmqziPTT/MRvF898npgYMe1Eng4+I85+fkes506kkWDAs4ByNR7oMmEo9XZEnyq/oc
	T5V3De3lCyyF8o1BJUUOaHZ9DIvoS9n4+9AFydQsKI/9nP+vm07sJjPU99QZWTFAfF0gl2n6JEo
	7uI0bmlPs8k3mkTs6/PV55Xy+ubF9LPj3lVXLLppD/s4f5t7tCN+ntBT23Ddr9ANGDmkI9x+ZjL
	dr/8d9XSc28+B3K/PZ14fc8Afgs04ReWCXxYSpz/ZVRurdm8++958JtPGoaECg3N/2eJ+viGJwJ
	hfInziYpGDj4KTgP8bPMkdCKH9ytXUa8bGeJI1vK/AVBEVxFYNJh6hkGnLE86P51Y6/PmS3la3y
	4oKt6aWobR7yII0uTxQwsu
X-Received: by 2002:a17:90b:1804:b0:356:24f0:af08 with SMTP id 98e67ed59e1d1-35c2ffb7149mr783481a91.1.1774579063148;
        Thu, 26 Mar 2026 19:37:43 -0700 (PDT)
Received: from [127.0.1.1] ([112.28.134.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22ce693csm2933495a91.14.2026.03.26.19.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:37:42 -0700 (PDT)
Message-ID: <69c5ed76.170a0220.1f4965.c4f3@mx.google.com>
Date: Thu, 26 Mar 2026 19:37:42 -0700 (PDT)
From: vince <liuwf0302@gmail.com>
To: kvm@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH kvmtool 2/2] arm64: Add GDB stub and step-debug support
In-Reply-To: <cdc9df07-5da4-41f0-b386-56fb1ae37e56@arm.com>
References: <20260318154156.2064989-1-liuwf0302@gmail.com>
 <20260318154156.2064989-3-liuwf0302@gmail.com>
 <cdc9df07-5da4-41f0-b386-56fb1ae37e56@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Ryan,

Thanks, this is a good point.

On arm64, simply patching guest memory with a BRK instruction is not by itself
enough to guarantee that a later guest instruction fetch will observe the new
instruction. This is different from x86, where software breakpoint patching is
generally sufficient without extra instruction-cache maintenance.

I checked QEMU's KVM path as well. While its software breakpoint handling also
patches guest memory directly, I did not find an explicit cache maintenance
sequence in the userspace insertion/removal path.

To make kvmtool's arm64 software breakpoint path more robust, I updated the
implementation so that instruction patches (both inserting the BRK and
restoring the original instruction when stepping over it) go through a
dedicated guest-instruction write path, and arm64 now performs instruction
cache synchronization for those patched bytes.

I have tested this locally and it works as expected.

I'll include this in the next version.

Thanks,
vince
