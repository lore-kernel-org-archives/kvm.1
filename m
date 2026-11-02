Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655292;
	b=n7a7TT8TINMsXA13eYLrUeHL5Hlrba5QG2GDura5OC4BiiY6l3cg2RHv3Ot5IrhpAWCl
	 Yfmm4LpFx0GFbrnbQD98UP3M+1G+sc6RB0iRZeENgATS6X3j/dB8vMfS1s5voGPCmGFa+
	 aZirVLaC1EgHxYj0gyDlAKY6WbTJ3KrBZBKnKcFTVRPpKXsGqIdEIko4SOMIGGgmNu64e
	 KBeUxQHWpr1U3Jd1ZbG1ytFqbjISADfVr+19fLIQ/LmND/qrABZrfdUHiDLERmvOjaaJ1
	 fjvg/68FlJRcksJEbYqlaCzH920zMJXxyjC6fG2/aAxOOYeABmfEE+QevTJgFkYbFaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655292;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pk8PjZLAHbCzbzy86taKCPbYB8GYNosz4QZrFN3MyUE=;
	b=VulDoNSax35fztrXoBeVNFDM9jc/oUHSrgaLYSnhvWDJsK0Lt1R450ll7r6OYRhFET7H
	 99bLt3z4K24mICy3EII39j0JTQMLY+r3qEiix82AXowt+gs59vUfLNOoWBvUZwmaGxCn9
	 9TEb3zOgkkVFQlgmg7WRiUVSBf3CZI9AaVXTSbQbe33FZvfhJ6JvezdymfttpQBY/yUj2
	 M4RzD9rU4JV8dmD9CBa0I4x4PGTo581snNWbDMH1ZYaqp1omXItw2f4bA8Bf1N5gDXAUG
	 HWebYmCMn/KkB8tSt9nJ4rmTQW+hM/rwHXMwu2ozaRrRoPOTaEc0oYL0suRon9kVppQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sYp8HXhw;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9E606A32E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 21:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D9E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sYp8HXhw
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9669D1595;
	Mon,  2 Nov 2026 13:34:47 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6197B3F673;
	Mon,  2 Nov 2026 13:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793655290; bh=FQ+eBBt4a3UC2ZrqObS9ll5v3S6I/4qmszsyg9uNjYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sYp8HXhwa83fODk/ZqkdE2zU4BqsG5gxkjBBNJ9LmIgLYNjDa9suzcpT/qJSnaO/N
	 L98zPy6r0+ApQhAV5/AqfsY9ipLlh8Ci61f1N3QcPniVqOVIYSQd29PvIfqL2gx/U+
	 nLTUtN5/QBEDjJSm9s6czr4/U3gQY8KC+CW05No8=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v4 07/23] irq: Allow the initial interrupt line number to be set
Date: Mon,  2 Nov 2026 21:33:57 +0000
Message-Id: <20261102213413.4136118-8-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102213413.4136118-1-sascha.bischoff@arm.com>
References: <20261102213413.4136118-1-sascha.bischoff@arm.com>
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

