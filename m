Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324820459A
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062990; cv=none; b=WHgYaQXhugagU1/pckzzlq4hAGqJJ8vU6ErrSxUXi12fg5gr+AlkxUaDIU3RwTO4CQEm/ldBuOQvga1xUXG8UbDyH4CF33hOvIxWmz1tepyW2uANhCA4A3vO1iGdva+rMk4/r/T7hjVAeEBfu3kgYW4Hw9k7WUaIqORDOz9v+lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062990; c=relaxed/simple;
	bh=czW0IXJE7KnY5bajfzV+bA3nt5deoMUEzjnz4yoY0v4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sar4D990xS5kMzvTc29MyWHw3C+sA7zTT+iO8jN5K9/hfM4LZUV0egpE46ymwDquQo6L4/QcXAhYsxjQuHzyxkM3OxmtsLyogpBAYQB0RsmyiPXIpCCg057rLIFc1qWuige7Tx2NBdctPfmwp1YNKhhL0nuEI66lv33isVOeW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rqP+99GQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqP+99GQ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1337264a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784062988; x=1784667788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hF4CEEV4ILiVKYzf81VM4xUABM2bAHY0WlN0Uchy+BE=;
        b=rqP+99GQxBmQ5fUslCkKPGsKJhrsdgmbK3U17OwCsb9WIxBlSeEqh6isTqoLf92+qu
         JxMa2JG7OUBCpdMiItAnAUQGysY4h3q2I0NcUp0H9VkEdApo4rhbxHfpOFrxmVaAzuu2
         VtRfug0VIFVd7sj4G2GXrkYCITrLbIuf+79iIL/PQreY//W2OHJj/BbfpHuNxF9QEBZD
         EVOF2RwW/MGGk3QPQUctCGNexWGfP1JRQTJEDxgfKFb9NAoDgoaLMQM8mjoNNWR0+Qh0
         ZlBswxt8RxpEteVnZLcHB6AGTuKPzsxSuTUZnyfrd+WhUa0BCJK3uE9mSJIgBDbaOi+6
         Blrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062988; x=1784667788;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hF4CEEV4ILiVKYzf81VM4xUABM2bAHY0WlN0Uchy+BE=;
        b=hJVOhSZo9Z4JgQcUHCxCmBAyX91jPTGQNYJSB+NpnXBcolp+fUvEhT4eD6Q9+0hXFp
         ePYv1JmoUowswgXu5rhNjb0Aohn4MgYrwKjBdbL2VotEONCX8XLG9Xjch3jTmIePt2wv
         haaK+q+DdC83Ka0dOShba1j0XBf77KRUb1WtKn+I0gTAlHuizHJoBJGj40Biz+bRyw9S
         D4xiwbjsAwIjmVhkCKVL60unKdYJN4ebP68SX2Jq58zjcqmDFWzz4m/C8lfQGaoFh8z7
         a2bhO/NHbPrBCnE+3d1BIy7RxCWgWeWpjURgPkapQcOle0OZ7rbOEOP3bgd15BpMPVEZ
         oc/g==
X-Gm-Message-State: AOJu0YzhHHAsF0xGhUEO84LJisHr3TDXsGHZ7B8JYUPfw92tvl6kYJfx
	QVZw2Kg1XpXUU1VvEizcvA3CxcL8hvGR01JAMD8honpQ+DjpAkRsWZksIFUJz82J46AY33t5cKl
	tO7rLQrdAd21/JrgKt4YuHoKRiFivEQTw5MNYjfe9GMc+21fWgcUoEX1JFsoKd15plWm+uKkJv/
	OihDwQMrf13w6eMqTZ7D9Vxpc86N7mQJxGGrqk5EY5odBllzmxfDTehQ==
X-Received: from dlnn30.prod.google.com ([2002:a05:7022:619e:b0:13b:a0a0:3b98])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:329b:b0:3bf:6e72:68f9 with SMTP id adf61e73a8af0-3c36c2ece17mr206932637.38.1784062988176;
 Tue, 14 Jul 2026 14:03:08 -0700 (PDT)
Date: Tue, 14 Jul 2026 21:03:01 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260714210303.3967981-1-aaronlewis@google.com>
Subject: [PATCH 0/2] vfio/iommufd: Prevent scheduler warnings when unmapping
 large regions
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Both the Type1 IOMMU and IOMMUFD can be guilty of not playing nice with
the scheduler during DMA unmapping on large regions (e.g., 256GB). Add
rate-limited calls to cond_resched() to ensure this doesn't happen.

This series was tested using the selftest proposed here:
 - https://lore.kernel.org/kvm/20260701203311.326798-1-aaronlewis@google.com/

And profiled using the bpftrace tooling proposed here:
 - https://lore.kernel.org/kvm/20260630141152.3757722-2-aaronlewis@google.com/

Note that the kernel must be built with preemption disabled and have
LATENCY_WARN enabled in order to trigger the warnings. With those
conditions met, the issue should reproduce as described in the
changelogs. 

Aaron Lewis (2):
  vfio/type1: Periodically try rescheduling when unmapping
  iommufd: Periodically reschedule when unmapping

 drivers/iommu/iommufd/pages.c   | 4 ++++
 drivers/vfio/vfio_iommu_type1.c | 3 +++
 2 files changed, 7 insertions(+)

-- 
2.55.0.141.g00534a21ce-goog

