Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968F367F3D
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 02:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294756; cv=none; b=UNcruesVjIG6CHle9e16StKB2uViYmCOkNnCrZdRlz+Xu49dp/eWb/5WsbFYclbA47eIeggDxxojtlRX+XLUdr5n+xrsra2dQGFPBRtzAII3JW3eP51uIokH1+Sfr6HIl/7uBmo8+b1eTF3E45kgzynf4JAVNrOdF0IutGSnsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294756; c=relaxed/simple;
	bh=bmoYLIMAIdQmc6pNReh+ZHJijJ41xbJDhG1wTdJvWzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q7hkxfGQaun0Bo+80tEdHFL+Zt40ry9itG1q07WU2kFMq4eMyQmOTgPl6gDz2ufTVxanbCqLBQnchZlvxReyTYH8SPQZcRPIYu1mM01iAHl4PNnJ6bq8kkSbhm80HR6FT5oePvwtBJ9+FlTDNtpbzrDMiev3XMe6Twd5Mlv4vuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qtEuaY0F; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qtEuaY0F"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778294749; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1kQdRcri/p8eyKWTapIiOdJtELmvqsXMqJcvhnHFCu4=;
	b=qtEuaY0FDffEKtPnlRlz81CEgR8VlyKV3/cg9lorL8v5AnWPYNhYORnGWQERVq7xwPwnc942WPsJM7SepN3g0GLnF1cZSP80cP9G6TEOiPvzaNTO9vLKPD9oHuurXM32SuNfUi+sveaYN8GNrhyZhS06elEiZ3TPR9nvj0GJN7Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guobin@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X2ZE7UY_1778294740;
Received: from localhost(mailfrom:guobin@linux.alibaba.com fp:SMTPD_---0X2ZE7UY_1778294740 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 10:45:48 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org
Subject: [PATCH 0/2] kvm: minor cleanups in kvm_close and kvm_irqchip_release_virq
Date: Sat,  9 May 2026 10:45:37 +0800
Message-ID: <20260509024539.90998-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small cleanups in kvm-all.c:

- Patch 1 removes a redundant null/fd check in kvm_close() that
  can never be true once the early-return guard at function entry
  has already passed.

- Patch 2 fixes an off-by-one in kvm_irqchip_release_virq(): after
  a swap-remove the newly placed entry at the same index was never
  re-examined, so a duplicate GSI could be silently left in the
  routing table.

Bin Guo (2):
  kvm: remove redundant check in kvm_close
  kvm: fix kvm_irqchip_release_virq loop after swap-remove

 accel/kvm/kvm-all.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)

