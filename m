Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96EB43C7A1
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110081; cv=none; b=XO57kDzCLDI8pBROcNvMuifauLU8v1K06ieG/NsRSLb4xHK6nI367360PRBkB0XttULiFxKybh4jEzYeKuRJj/RhkFtd0G+SBfJPDT2rZqkoBidQcM6YtOziM+jc0H8JTqXb2bw6S7uyPTTmS7u90la0gLMd/YX87tbHII+h9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110081; c=relaxed/simple;
	bh=mnhSSry7A9epbrW8XNbZH3Scvm1346BfLMvjZVQsYMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRDaUNeCouPl3l+oAsTDQX6uZmO/S6sHaHEW7FrcrAj4kgbFIg5B+D/V6Zn84tvW5hNscXpAswCTNRe2viRUhXnJKCeY68z7Hodao/+k17PrE0jHeHDnlm1s1ReV22xGm9GZxuxG+D7GIU8dy+Gcy4nDkXDADvOqDxiFZWVaE4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ERosZfwN; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ERosZfwN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784110066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AuC4cYSfF+mzcGCA7U93IQLfX79hKMfO8Qc5mhCW67M=;
	b=ERosZfwNPBuygiG8SFfUYxkXF6tXTA0d9OxKprrxe6Fn5khOscmbVqi5wQT7OZ0fQFtWm9
	6qQwt9gvQTmO55LN0wJ/iEfWxuObqbTyAKBUc4yChHzp1zqFXlohU9fitRq3l12NkNE8Yr
	j4pANqBS6Gh/I2IP7wx6JYJPspg3has=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	kernel@xen0n.name,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lixianglai@loongson.cn,
	cuitao@kylinos.cn,
	cui.tao@linux.dev
Subject: [PATCH v3 0/2] LoongArch: KVM: Fix timer restore issues
Date: Wed, 15 Jul 2026 18:06:38 +0800
Message-ID: <20260715100640.1454413-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

Fix two issues in kvm_restore_timer():

Patch 1 fixes a one-shot timer firing immediately after migration because
vcpu->arch.expire is not migrated.

Patch 2 fixes a division-by-zero crash when a guest programs a periodic
timer with a period value of zero.

Both are in the same function (kvm_restore_timer) and are sent as a
series for convenience.

Tao Cui (2):
  LoongArch: KVM: Reload one-shot TVAL on migration destination
  LoongArch: KVM: Prevent division by zero in periodic timer restore

 arch/loongarch/kvm/timer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

---
Changes in v3:
- Add patch 2 (division by zero fix, found by Sashiko AI review).
- Reuse the existing now timestamp instead of a redundant ktime_get().

Changes in v2:
- Move the expire check before ktime_before() (suggested by Bibo Mao)
- Remove the old else-if branch that was one-shot only.
-- 
2.43.0

