Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798940;
	b=pArUO+Ecii8Hg+FSANDbmTsACwdk7h6WfjVPlLqpgenxESFXYIf0xjEgc0CPd7I072vZ
	 Tpj5dUXj9n//8iQQgLyQVqBfG46F5Ug2okkkF6EvPvoTtrQoUO7rdTPOLae+5Vr/GkcAP
	 /e+OasTHNgQCqGV77OgdEupsbVqRKFVQQUzDuYGgFlgD/GOv8t7hO8kvvYopC4XUkVcj3
	 Wt8hZBd9rpcrVB8sOr8fiC/86kkCoURNXrt37ZwqOxWVowe7hHndSpiVdzdAxFBERQ7+9
	 fyDOtl6vus8ifEt3bXSob9/yeFYjXg67EoaeNpeUZFgs4JQAFFtqBEFDUGkW22aCKFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798940;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a1rYG1TalQ9YJsdpzA/JS3EHWX9ayK0ZVdBj8cqmZ40=;
	b=M/5gs6miXg4jNM10tavtLWh1y/D9EnhkTPnTvKo7JFHIBPKJ/KnMqiLWQEafr4yzMTxk
	 F2fdUzfAL4I5jrhQU+S8a4YU+kWlM5rfZ018kYzAJxf5AvHpYVT/JqrMzfjFv+Hx/07Zp
	 YtmewOvMqa30rpVccWeTvUfvwpCjPhx2rtQg/0iBkhGyRdjfcRhR1widJLIHdJ5T+x7yw
	 /sfamr7GzjBpdV27wdVudCmZr9vpuMUVnJ1JtYEAyrjYqkmcgdaYRy2DwPwxUbuLkDSQs
	 PxBMSdfS+TmVW20n3BJ0a+cDwJHVMkMzXhAnXHzypYMllE1LzZ3UdZumt1gKC0bs6Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IYW8Bvwn;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D436606A32C
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 17:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D436606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=IYW8Bvwn
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A6C1758;
	Fri, 27 Nov 2026 09:02:17 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1E563F632;
	Fri, 27 Nov 2026 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795798940; bh=6LC0Esz0vtaHqOKJrOblFkqFYsHjYoYynkmx3V1YY8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IYW8BvwnczMBxtZ+8L7neSR22lrBFrofGW5AO0CGb/ZQ9m/Twq4ZidQNF4p4Upng4
	 fnngUsqMn1oI2TAG1J9NYUzhUzFC3eXgakmX7pioQX3zmnOiyxnypi2nYfYJt8GhK+
	 KXldcSvQHz3CKN4viZyzLghdZrD+5zmPJH1grXbs=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v7 07/23] irq: Allow the initial interrupt line number to be set
Date: Fri, 27 Nov 2026 17:01:29 +0000
Message-Id: <20261127170145.4138182-8-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127170145.4138182-1-sascha.bischoff@arm.com>
References: <20261127170145.4138182-1-sascha.bischoff@arm.com>
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

Allow callers to select the initial IRQ line number before allocating
any lines. Track the selected offset when reporting the number of
allocated lines.

Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
---
 include/kvm/irq.h |  1 +
 irq.c             | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/kvm/irq.h b/include/kvm/irq.h
index 2a3f8c9d..17113979 100644
--- a/include/kvm/irq.h
+++ b/include/kvm/irq.h
@@ -23,6 +23,7 @@ extern struct msi_routing_ops *msi_routing_ops;
 extern struct kvm_irq_routing *irq_routing;
 extern int next_gsi;
 
+int irq__init_irq_offset(u8 offset);
 int irq__alloc_line(void);
 int irq__get_nr_allocated_lines(void);
 
diff --git a/irq.c b/irq.c
index cdcf9923..7c4bfec4 100644
--- a/irq.c
+++ b/irq.c
@@ -8,6 +8,7 @@
 #include "kvm/irq.h"
 #include "kvm/kvm-arch.h"
 
+static u8 irq_offset = KVM_IRQ_OFFSET;
 static u8 next_line = KVM_IRQ_OFFSET;
 static int allocated_gsis = 0;
 
@@ -18,6 +19,18 @@ struct msi_routing_ops *msi_routing_ops = &irq__default_routing_ops;
 
 struct kvm_irq_routing *irq_routing = NULL;
 
+/* Override the default offset before the first IRQ allocation. */
+int irq__init_irq_offset(u8 offset)
+{
+	if (irq__get_nr_allocated_lines())
+		return -EBUSY;
+
+	irq_offset = offset;
+	next_line = offset;
+
+	return 0;
+}
+
 int irq__alloc_line(void)
 {
 	return next_line++;
@@ -25,7 +38,7 @@ int irq__alloc_line(void)
 
 int irq__get_nr_allocated_lines(void)
 {
-	return next_line - KVM_IRQ_OFFSET;
+	return next_line - irq_offset;
 }
 
 int irq__allocate_routing_entry(void)
-- 
2.34.1

