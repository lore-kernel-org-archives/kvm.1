Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792985867;
	b=A10fSC9qCONPU/VK0gKqrYIeyx1+EJECF5KqDL6rK5VNfSKupPg4eFZVkU9Jt5NDV+dr
	 39WZvnnQcD97RMMkrYL452fpxwq/Ac2r7uU9sL7DUFYoEN6na2BvvQFMbtAWsuI6AlBda
	 q57a/reeo5YQRB3VBmdafQvF37MsQl1nRBuvkpo6UPZ+iXXSWX8jWWpUbjLQwYGJBZT+z
	 /z+H6uBlKciNfpim+Vc2yQWLutVfVG+hcqHsYciFtBUaSsgBuPHUP7MRf6BMoDYda4KQn
	 SXtz1Hc5rMwFGDN/Vf+eaH069lFi8wzFE8S/2Ne5U9JNIn9OK92cDKuBihaRIBIAWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792985867;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AcVF0+7J4tCY38BzQtPDDFcEioY3MRDaVDGoLP3rSf4=;
	b=xIOuiXo3RmB1Y9bB8+utrXdjBctpRKHeyqMgwnQkbn9Tvxz+ifQmggnhNKlBLkn4dm8y
	 1oNlwkTdA86UIEU9apdheROvxoJhO5T7M+nU87sihPy8mTL3PUsg87jztUB+PsAKTYgMj
	 g1WqteeSXHygF6G1LSes5C8GFw+uKuq3Jh9U5MlhtcyZIaWZtmgLYTTz9crvnpfMGmdTC
	 OLlVXqa1vjd9aaxC9uGQyo+/TOxHBCxvIESciFz04qiqJcFrXzRN9z5UupYchwiGIvpuP
	 luO2alrZd9kqtJ7SNa2xSk45Bq3cNIa0xsQcteXeQzWQlB6bjOcQh5lgquNmldaV1Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VAgsQ1Yd;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3502606A31A
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 03:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3502606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VAgsQ1Yd
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1550429a91.2
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 20:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792985866; x=1793590666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AcVF0+7J4tCY38BzQtPDDFcEioY3MRDaVDGoLP3rSf4=;
        b=VAgsQ1YdNt0Y2u83226p1GJlrEQAge5zJn+naGeczL6mMbk4YtHwYrKXBR8fJp5q3n
         OHEXx2pSTg2MXotEv/oGU1mKLHhnJsnssYdbVB/CXUHSkynUpQIgqSGSPxwBVQ3YexTQ
         PpTc1nlbyvX1bNlkOo9MgqvZ7+MIJvIwn77Qy9qNvqS5OTniB90XJLN/mWS445TgR5Mw
         TnI8czsjAQJkXY+u8/yDPAQtDTkOMs9v2f/zjlhJhqF45hcEocwJszm6bLGWA/DB9Y9N
         RYMtWglSt4Vhx1BXF4X5tMtAR5xstrCW0oPfl4yfrisOXANUI1Vb4f2RJ/F+uIXqThvR
         s0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792985866; x=1793590666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcVF0+7J4tCY38BzQtPDDFcEioY3MRDaVDGoLP3rSf4=;
        b=wFxZiT6+NBL/LFfHRyp5Q+Isl7Y94tMVZ2bThQI5ANkZsoIIHllVxreutymZWYIiHI
         +2S2ZKJq/ovZz5F2QQA2eZVTkXrKx3KPRzc4XbL4keNa8e3cr5sN8NL36RukwJdWmGSm
         C56nlUEIwWctqSOlCJmyTztKRPaWzzuW6QcNdeuT5vsxEOIzyEZDfj5UfzWR+o5L8VMQ
         NaMKsKYc0CBmrnhso8F5mNEl3CFqyTjd/4ZwsqE7cm2bRqMtDHuEyI99H4efIb9WfHhX
         i4BJkOTC19jABRpL3pF7YU3+GRFg665njMSqP6JDWKMGRy6lzeLOXQ3vzzhS08aib7uz
         djQw==
X-Gm-Message-State: AFq9FYJ6z51O8IJUZHuE/kdE39ZSjF7sTCG/OCLlqRjwCjuaT0ofgv88
	aWdVL95thtQgNnHc/3nPkI8ojtFK87IdzFxntZmy9OvMe9/iNFa62Q62zkZOw0bE3bnnq+rxACT
	kbW/6Evmvqg==
X-Gm-Gg: AYBFou0o4lK7WHEvGgIMDRqgliTKFyST+zPjFW74q8Fp27KmGUshauNMkND6M31BnSN
	+yoaahx8IWXb2adJGaTWpwBo5BitcGH62t5z7ddJF9tGfCCghqQKTW7Slzv+yfSTKYYr6/yDZ9Q
	jjPz33Pgz+zCXCafPK5A2AJgawbipYaqTLZBxPbege7yutLmMWw2+LsHvMmAXoJgkFQ8LL5ryJp
	hE8VAVFFtbhX3vXm2+juwMMnfQCfO81nikvigvnPvsKXolFpH3GbkX4cbdhd9nj5bu1sBkILCab
	n9tdcUyeGRlX/IiI1MloWviNXsLT1ift1zXgrfAWf7sCTNP2r1QTmAuRmKuc621Hl+SVjW/rIvI
	wAVisxZhC5+1xL6tyh86urhYycsRuevQ0dr7hdoaNm12klmmxjSQbaRht8ZULsXemVbX41v70dD
	4VEY2ofF6oql2pk3wzkRSSnpwzUzMphW/V5eqpwAb0GzFvxvV0LwwWZoXmCB6dFpSxTth2YRQPv
	XNFni+Q2v2YLuLiyJdDiXqwvPJh6SLA1jooqOYTc17urUEp13pJBHcgsiHCRwQzzttJT2PChFc=
X-Received: by 2002:a17:90b:57cd:b0:3ad:5c64:c7a0 with SMTP id 98e67ed59e1d1-3adead48641mr4554613a91.38.1792985865903;
        Sun, 25 Oct 2026 20:37:45 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f09csm6754815a91.7.2026.10.25.20.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:37:45 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: kvm@vger.kernel.org
Cc: kvm-riscv@lists.infradead.org,
	Andrew Jones <andrew.jones@linux.dev>,
	James Raphael Tiovalen <jamestiotio@gmail.com>,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [kvm-unit-tests PATCH v2] riscv: sbi: Fix timer delay measurement race
Date: Mon, 26 Oct 2026 11:37:38 +0800
Message-Id: <20261026033738.96294-1-qingwei.hu@bytedance.com>
X-Mailer: git-send-email 2.39.5
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

The timer test samples the counter before checking timer_works in the
wait loop. If the timer interrupt arrives between these operations, the
handler sets timer_works and the loop exits with a timestamp taken before
the interrupt. That timestamp can precede the deadline, causing a false
"timer delay honored" failure in both the normal and masked IRQ tests.

Check timer_works first in the wait loop and sample the counter again
after the loop exits. Use this timestamp to calculate the elapsed time
so that an interrupt cannot cause the test to use a stale timestamp.

Fixes: 14fa12b1351c ("riscv: sbi: Add test for timer extension")
Suggested-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
Changes in v2:
- Check timer_works first and sample the counter after the wait loop,
  as suggested by Andrew Jones.
- Drop the timestamp field and counter read from the interrupt handler.

Testing:
- Cross-built riscv/sbi.flat and built it natively on a RISC-V host.
- Ran the SBI tests with KVM five times each with 1 and 32 vCPUs.
  All runs passed, with 15 tests skipped per run. Both timer delay
  checks passed in all runs.

 riscv/sbi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/riscv/sbi.c b/riscv/sbi.c
index 3b8aadce..5633b1f9 100644
--- a/riscv/sbi.c
+++ b/riscv/sbi.c
@@ -292,8 +292,9 @@ static void timer_check_set_timer(bool mask_timer_irq)
 	if (ret.error)
 		report_info("set timer%s failed with %ld\n", mask_test_str, ret.error);
 
-	while ((end = timer_get_cycles()) <= (begin + d + margin) && !timer_info.timer_works)
+	while (!timer_info.timer_works && timer_get_cycles() <= begin + d + margin)
 		cpu_relax();
+	end = timer_get_cycles();
 
 	report(timer_info.timer_works, "timer interrupt received%s", mask_test_str);
 	report(timer_info.timer_irq_set, "pending timer interrupt bit set in irq handler%s", mask_test_str);
-- 
2.39.5

