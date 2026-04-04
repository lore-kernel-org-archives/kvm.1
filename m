Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643E3368BE
	for <kvm@vger.kernel.org>; Sat,  4 Apr 2026 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775326481; cv=none; b=ml5qvl5y6mOYJgRYlYptnqhbu08aP2Fgm4bxIhXePQkms50POH5wEu6mUzDb6YjVZ0KjBoRzf41KHjiC9Z4+ECU32sn216zQJ+cnotc5UnmBkK88f/YsxQnBUig3kplV/Ryd/A8ofClSc8NJr9l4uPUN92pFc2whUNnD2UL6ixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775326481; c=relaxed/simple;
	bh=yzs5/uo2bliqohVmxP9Lp9DIGTiTCTBbD9819t+4Dlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUUqn5GeWdW6w54hOsYy09CZl+Jg0cpZDlt8No+9VcPlQVJ0g6F03UMbj+wmBD9KRp2ywKhNpVsafdnlip8QMWOecb9ZMyaexhuEmYTiANKli5YtrLqtXnztSCwgTogMwKG9b0os5wAw5xa8l3Xjh0PGJFwOn03saZBWQKg7nUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikFB3JAD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikFB3JAD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so1567849f8f.3
        for <kvm@vger.kernel.org>; Sat, 04 Apr 2026 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775326478; x=1775931278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzs5/uo2bliqohVmxP9Lp9DIGTiTCTBbD9819t+4Dlc=;
        b=ikFB3JADdVPeu83ss06I0lJjMPxoPmgkLp6X8FNtHCPqTy9oLRO6AjoDRcU3dyvDYy
         fNJKfBmtL3p9cRbuVQMpPg33BpW+Ky2Wd0ZcJwMhTzGkLIfTWlVqu12UXJH/1uhc8mci
         cTD3G0TajGmVlvC8mo2pwzYFz/o37xRi/q4LAU/7L/JRHwpkrwSuKTXD5C0+v1rwe2bH
         elr1P06wbnnioRg2ojBEGinPOomF1HRwJn/JJsxIRdeO07wH6ish1IgbKlQjTQ7t2ypv
         eQA96TEfZneEiVDkKcqPY2vSNm+6PJiVJVf97tNXQXAo3kat3yENNf/mQM6bcq0iR5YR
         iBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775326478; x=1775931278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yzs5/uo2bliqohVmxP9Lp9DIGTiTCTBbD9819t+4Dlc=;
        b=TUiMbTX2NuUteF+40rd/LvOGtQjwFr5SDZ4Zosy3bjy+e0sduQ9Z/XnQtwNcQmyw6p
         FD/xfd4g7IX8cf0T8C+q9KVW9XX3jONuuEizbiJwUpTC8WgMvUc58dWnerZTj5XdyKWA
         xx1lNr6FSWDbtUWjBf9Lag4E9suoAr1p+yn6dpo9ZgFXIBl3Tb8ua67XdNGBhNtCPyhR
         1PAVbsMYyFv4beBs/PEQuZDQePj1ZiiZn2M88hrFq6sY+3G7mBBVCN1RR1H1o5do6Cg1
         MkFW2s948Gd3rg6hsH1yt0ln6CGRG0p2YsUJYumTcvrQYSSqO1hS5SXPDF0U/Z6/DFcT
         9AMg==
X-Forwarded-Encrypted: i=1; AJvYcCUHG8hGyF/U9nXcj5Owtz6BX3OpfzrO/NdNoMSZQ4DVLhZ4mU39ADnBmhAHkbe6CPXTel8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRL7QItAREiZ/ReU47g8xSMG+upTKith81RFmC4fF4vvGCJ4xT
	cPvPgOSs/mCbKXZBhz4iEGma272/69JcwF/LUEgavNi6KEruMabcW1tm
X-Gm-Gg: AeBDietstqA5YBTl1yMEiQ6mp4vgpCNsIAeLkCGwqMOwJWTsd2uRyBanyHAndV8rXk9
	jn6E88iaOk1sZDPqdgi0XvRtrLNTvIihVmDzljz+YlstmC9GK8i4oSVypaEeU6YQwwDp3dlIqsJ
	zRjO9UI8s7idstvo7CMhrkloKXHm956hDDpFs4ftoM/MYTLy4Lu7Q3jjjQQ8AoPEr3JxDJA+arG
	63KUqi0alKdB6VSjvvElappRFZe+4lolwc/tCxJzrurwxlR/GtE7W0mgKvQbobJaLPtQQSk+Qd1
	HsIpQQJMPZBT7NbLsVrwK8J+rGVO105lmCauvY429kGBAtG5wJseb9vQ9mRDJ0Kc5kNawA5zrHm
	VPjN+fmFiS+IjHjow1bdHxdJoIXYjcse125twXc5emBq/hCrRGhZz409hWuiBtcCUOFNtZm6F9Z
	LUhV2zwtqGy5oEBYDkYltWvWy6uP2I3bHMPbWOwq2NrqDcdeqcB5jfrIcVmV64c6zQl8D3Oss0G
	+3rTp0pRdmCgNtrSkfJ8KMgrXXN+1qSVokTlMmtxwq/NiPP5eiRRRnrWe3T0yRjjaJU4UDmpoBm
	nYbi++YSN8gS0HjxHvMCkVj1W8jyjhEF7AQG2y7H9E/3NrTD2zK8kk5D+BU=
X-Received: by 2002:a05:6000:208a:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43d2928f291mr10149634f8f.18.1775326478388;
        Sat, 04 Apr 2026 11:14:38 -0700 (PDT)
Received: from archlinux.kangaroo-newton.ts.net ([185.213.155.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm26047308f8f.31.2026.04.04.11.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 11:14:38 -0700 (PDT)
From: Christos Longros <chris.longros@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Christos Longros <chris.longros@gmail.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio/pci: sanitize bogus INTx interrupt pin values
Date: Sat,  4 Apr 2026 20:14:36 +0200
Message-ID: <20260404181436.754390-1-chris.longros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401165920.373e7584@shazbot.org>
References: <20260328230126.73230-1-chris.longros@gmail.com> <20260401165920.373e7584@shazbot.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alex,

The RTL8852CE reports a valid interrupt pin (INTA = 0x01) under
normal operation. The 0xFF only appears after a VFIO bus reset
bricks the device -- at that point the entire config space reads
0xFFFFFFFF, not just the pin register.

Since the root cause is the device bricking on bus reset, I think
the right fix is a PCI quirk rather than the generic bounds check
I proposed here. I have a quirk_no_bus_reset patch ready for
10ec:c852 (RTL8852CE) -- I'll send that as a v3 instead.

Should I drop this VFIO patch entirely, or is there value in
keeping a safety net for the pin register? The PCI spec limits it
to 0x00-0x04, so anything outside that range is invalid, but I
understand if you'd rather not add checks for scenarios that
shouldn't happen with functioning hardware.

Christos
