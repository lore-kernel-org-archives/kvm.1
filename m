Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724691;
	b=xuQDA9HzIVP7Eq17Z8ZnMWZqcduKvTT/KkGK4WSKHAyJZnY98w3InACqQfDb/o1FiULh
	 qBk5GM18RbrLOgdR2aaC0P8jG7Jwco/nSOsg01wCx34gNMSWqnfiQcPK+9aCVA5c/WsQR
	 ZiCpee6hwakAGej/rxeFwxOT4keST2VH7BmcFqO4nzmmmcd62LmQtzW/ze+VnyGgXMqcw
	 xfcbbkNzQkdCNNLeEqhWDxllGUnFUrWlv6K8+TKaqEhC/OfFOAMGwFjXL3EO/dQRSDbkh
	 H0uwYS4r+SCSIHiHeAoYrCx15X38hAiTKZivxhvrX3mVdJ3FWLowg+5YAuENkCXzqcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=3ApuWDp5M/WoLyzPayp9OLv7sPY8GOMyShINb8lA2F0=;
	b=1lKWybpkGhFBspEBm4RT9QF8qu43UNc9vJCFXndoXQTEWdw5hb6G5KZKUsFVuGluovIE
	 kjjM00ujXbUYBm6KklWBJ3Kmfmq/Acs+jcHXx0aua7CDAAHPNNdWlHw7H32K62btYu+NT
	 A/PDymKR2CQYiFAaP71MHf8FnuupX9BqYUETiHERTPszilFm7g8zDBJxEnmaghWzC7Fys
	 Mxoa/W5LxnVK/qQAKa+Dv1sFPIhwGi5F/nlknfrQPXkuJqpXQwn3xsl968O7YM+pGJ08k
	 pM34drSkpiCL+pf0O/8IRl507raSeVd4DQNNHPJO3e2/Rl3gw0vMg6/XWq2qhBJX3iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=FZISpZkH;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7F2606A319
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 03:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF7F2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=FZISpZkH
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso365833a91.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792724690; x=1793329490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ApuWDp5M/WoLyzPayp9OLv7sPY8GOMyShINb8lA2F0=;
        b=FZISpZkHd1+DQOS3xp7qnKfdza2XZwlKXBt5vmRnAgZK5oKRZBcvcu2zEmZatvvxBf
         xI0yUwNmTyEZlzM6wqUR7jwNwv+/oWub165Eqj0/0UtBFlWDaBND//6AhSPPh1OY7odm
         l26EOHvZIJU2M9umG7yD8b4NmEHhfmJqUa9RfJ4FhYuwE++7UdwoSmCtTC+X3s+9GkB0
         PqaHWSflI538U5h1kV2+0HouR+f25+76tyNkLIeEYuAS2jwno+fJoEvB5F1H/PIy8BMX
         Ts9129140fM8hxWjpqag5K45fY9gDkyEwjUiDgzt7hiipxbr22IH5d9Jo/Q1dI7ahDQ6
         uH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792724690; x=1793329490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ApuWDp5M/WoLyzPayp9OLv7sPY8GOMyShINb8lA2F0=;
        b=n3inWvpkxcbjTSjeEJ1YCyPLAz/sNlnhqAZiJA7dUDdvLIRWygCUuCtpoi7jQZLVlx
         oT9wvQUD+R/bz+FA3q7/pgIQItCHSpWX81zHqRAUpYsuYNBKXyuaEGLR9Kuv6/iNbQGU
         +x12JzxKp6oaC3MmrdryG8mq+jes3fLKwiFIXstoD6LGS4dgW+1RS5zh4heRLyTAk0su
         CWiBVa3agkwFnxevf4ALiSj+I9JvJy7zsg34R+Jx1jCBB2CBuGC7TxZCQ7wf2PaAsIUE
         4DefLE0YvvExXf1Bv30R+mF9CP5H8lCyV6ts+9Wr8l5PyQ+KAdmN6IXU86wVrEGTpGGR
         23rA==
X-Gm-Message-State: AFq9FYKW5npYs4RVAcLvVvUQVpGftGV7zAJ//woJZklRNvMVn4Kg6OaJ
	0GrozVshBSI/rGzmgfxnpqv9VSBqbaW2sAwkOkSTXQfrqOJP4pNC8eW1n4rrQ1iLRN8oYselWDc
	tzeQs7scrIw==
X-Gm-Gg: AYBFou0iHItnChwZk73vSjNRym7hw1hxQQljgDTrkYjNHb1Dv4uV5Y7Wcp6AQ8xN/kf
	4ZYv1fg8npTYWJV1+lLr/vC/GWAZA1L0WFnD5suFb8luGMw+Dp4TROxk5AgBXEQmWaUr+jh3KH4
	F0bH2YBtuDT++65JrY/Nhnzw42EFCOt4X+bf+YBioNlpxqCgwkN4ENJX7wOnaMxSpO2yM0oGUH5
	LGzBjBLnYxxuveUpM44qKVq9Gt6isHhT/3fSsQFigZnQT99W+Wid512PNZISOMmo1kMnHT6LnDb
	Cb8QBZyOMGtc8uz67TUGUp9jmxuZ7vSv0XND3oDdvbhM4Vg+5D93Qx01cYZZVE25NXo3KBxPOPF
	JyUi4/63JYSnlUjBGMyPW13nC7ofYsb3xqUyLlEtDwpt8xZmt+jFM8kB03QOZ/Fl0and0bds9aF
	lhpQVdQFQH5fd58pTi+NnRaGK/ReF8jTA/h0TaDJDviTri5RU0/dqvKCcfudM0D4+13vNdvlnhT
	taz6+CJ8WY2hcVlQqfQwyBlG9DrjiE1/YYgDMax+aMp4atUwQzuJ931J611eUdELBrEdHHV+r0=
X-Received: by 2002:a17:90b:5185:b0:3ac:8897:7b92 with SMTP id 98e67ed59e1d1-3adce873fcamr721378a91.57.1792724689764;
        Thu, 22 Oct 2026 20:04:49 -0700 (PDT)
Received: from n37-012-226.byted.org ([115.190.40.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49544f1sm6687270a91.16.2026.10.22.20.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:04:49 -0700 (PDT)
From: Qingwei Hu <qingwei.hu@bytedance.com>
To: kvm@vger.kernel.org
Cc: Andrew Jones <andrew.jones@linux.dev>,
	kvm-riscv@lists.infradead.org,
	James Raphael Tiovalen <jamestiotio@gmail.com>,
	Qingwei Hu <qingwei.hu@bytedance.com>
Subject: [kvm-unit-tests PATCH] riscv: sbi: Fix timer delay measurement race
Date: Fri, 23 Oct 2026 11:04:42 +0800
Message-Id: <20261023030442.3709880-1-qingwei.hu@bytedance.com>
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

Record the counter at the start of timer_irq_handler() and use it to
calculate the elapsed time. Keep the loop timestamp for timeout detection.

Fixes: 14fa12b1351c ("riscv: sbi: Add test for timer extension")
Signed-off-by: Qingwei Hu <qingwei.hu@bytedance.com>
---
 riscv/sbi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/riscv/sbi.c b/riscv/sbi.c
index 3b8aadce..a298228b 100644
--- a/riscv/sbi.c
+++ b/riscv/sbi.c
@@ -245,6 +245,7 @@ struct timer_info {
 	bool timer_irq_set;
 	bool timer_irq_cleared;
 	unsigned long timer_irq_count;
+	unsigned long irq_cycles;
 };
 
 static struct timer_info timer_info;
@@ -256,6 +257,7 @@ static bool timer_irq_pending(void)
 
 static void timer_irq_handler(struct pt_regs *regs)
 {
+	timer_info.irq_cycles = timer_get_cycles();
 	timer_info.timer_works = true;
 
 	if (timer_info.timer_irq_count < ULONG_MAX)
@@ -304,7 +306,7 @@ static void timer_check_set_timer(bool mask_timer_irq)
 	}
 
 	if (timer_info.timer_works) {
-		duration = end - begin;
+		duration = timer_info.irq_cycles - begin;
 		report(duration >= d && duration <= (d + margin), "timer delay honored%s", mask_test_str);
 	}
 
-- 
2.39.5

