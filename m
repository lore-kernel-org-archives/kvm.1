Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798743;
	b=vEksUVmqS9LTpUCdr/XbmW7sRutdOU+yvtNng2TfoXR/MPeQ64JKWqjcOJBDDY/KJVcO
	 yg7TwNBOOaMZhnCDOfcDLZz66lT3vohBlPBYkWhKVKm9UOXu0DROJWyGmKQwSuwd/tb94
	 RA357D0j92P1MYYnayR/Zu81UXddmrngFFgbRNW+GoGv0NSrjqptP+51LTIcuZhT++1wm
	 aMuyOTIBr3uNzLfunD4GgpNKHoXLag72BlVKvUNFrj0knuYyncykFlFhfxCRMOy3scwBG
	 QiOmEv41ONSTmTeDV0xClk0BeBriua8b1ji/HOaKfvUecC4IEBmaENhF6/fSc7z1ldQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=DvmbVObzWQ/wjQetSsmCBr+QUtK2yXQRsQ+DR88rIOg=;
	b=AIfWEtHdbxuRsnD+dLrsepzDbg7KA7YVZGeTjedhCOdfzWNabegQFhG03N0CS2cKOaao
	 EWzC6TXYYVU2GBoaCcrDDdSkbR2V9rvcd6pXilqSZRQYinCua8624yan8o7TjucRzwPC5
	 NwhH5RuN8/cNXw2Z6wxiz8uOsyH3fiNi27EHE9SyVobylEGUBWLeN5fcIk1qAfojsMOCA
	 g91dipsQGW7ritf4Xrxjm0XD7cXN7reVs2VcCO02gG3ALumhAifTROtkuF78/Ev7g/Ssf
	 MAj2jKI8PjnViPJqiRj3t0g3qqe2k0lipBicjNjEpAK/vur2yrldedV1VzPj6jATLYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D2BkIbEj;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3AC606A31C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 16:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB3AC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=D2BkIbEj
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a4654add56so56485325e9.2
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795798741; x=1796403541; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DvmbVObzWQ/wjQetSsmCBr+QUtK2yXQRsQ+DR88rIOg=;
        b=D2BkIbEja8NKkCjzEcJnhN+dlJ11/CY360Vflq49M7RefAWym4yv/TnV018ffzkb5u
         CLyBOkopMg4OyU5W6GZX034hXwt0v2k9WqDsIAdrD2Csw8KWtfQ2zgwV1tBUGzihJwU3
         xEHgitNPFwH/JMBP7FXyA+AedaUYIJPczcyJDl17d0wnS4wrbxvi30XL5wNjZmQTetmq
         wInY0Sec9DGnIEDY7V3o/MFKjd+wKp34sB3H1Ny0RXn9a4kGeB5lb0To6OYHcUH1UwGC
         fXkg8I/kBQ4SPEXik92MVBRs/dt20ExRW9ktdJ0Plq5NT9Oo3LasHi7G/STbqisensGi
         SUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798741; x=1796403541;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvmbVObzWQ/wjQetSsmCBr+QUtK2yXQRsQ+DR88rIOg=;
        b=zJZcMg7gOxfWV3BX3caDheZM4FhDaAl/gCaTfN/aPcBojQWS1lsQiX7LlgHE1uAmaa
         vzdPxR3PpQPJvWL0tun7czKU+wVxfV2VwIIVXUmr/X8cmUmQ478/1hjReT5gwxfMvvOq
         fzBibWJMZdKI0rDAj5VRgpHjHn0tDHJY1IXOIP4KAi3nuaXopemP99ZRoFEoiV17RxUk
         X5s3g6w2rPEm7eC1LlAY3qs1Jsyayf5NE4Hg3LDRXpP1sEnVEIu4Z6w9GoWhq11RchPZ
         uuAOcHC5FYRFfxXwR9XM7J9fb5StZ/UzE/6f6adZEfYpxadW0M25GTKRpWviPw0vK8kz
         kK2Q==
X-Gm-Message-State: APuU4Z/72xa3kXCu/hjlOfFrnRRb200KGwj0sglb8Coq+TStHOppPF1W
	0iI8lJ1i670YYLjXuE4YtH7QmY3s4NQqP84xkwP+sgOjWuEUouH/1dCGgDJu8c+yHgi1/BJsU4Q
	uMLnUqjqP5xu2fkR3XUXwCA==
X-Received: from wrmk2.prod.google.com ([2002:adf:e3c2:0:b0:4ac:b8f7:9ef4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c84:b0:4a8:9a2f:d27 with SMTP id 5b1f17b1804b1-4bb8881f47emr524772265e9.25.1795798740885;
 Fri, 27 Nov 2026 08:59:00 -0800 (PST)
Date: Fri, 27 Nov 2026 16:58:40 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127165843.709034-1-vdonnefort@google.com>
Subject: [PATCH v2 0/2] arm64: THPs for systems with pages bigger than 4K
From: Vincent Donnefort <vdonnefort@google.com>
To: will@kernel.org, julien.thierry.kdev@gmail.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, maz@kernel.org, oliver.upton@linux.dev, 
	suzuki.poulose@arm.com, alexandru.elisei@arm.com, andre.przywara@arm.com, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Enable THP support for arm64 guests on hosts with a page size larger
than 4K.

Changelog:

v2:
  * Memoize sysconf(_SC_PAGE_SIZE) in host_page_size() and back
    PAGE_SIZE with it to avoid repeated sysconf() calls. (Will)
  * Rebase on origin/master (2f3abe56dcd2).

v1 (https://lore.kernel.org/all/20261019145949.1922019-1-vdonnefort@google.com/)

Vincent Donnefort (2):
  util: Use a memoized value for PAGE_SIZE
  arm64: THPs for systems with pages bigger than 4K

 arm64/kvm.c        | 21 +++++++++++++--------
 builtin-run.c      | 14 +-------------
 include/kvm/kvm.h  |  4 ----
 include/kvm/util.h |  6 ++++++
 util/util.c        | 15 +++++++++++++++
 5 files changed, 35 insertions(+), 25 deletions(-)


base-commit: 2f3abe56dcd2658dc6dae3eeeb4996dc4b518bcf
-- 
2.56.1.839.g22a8290db9-goog

