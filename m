Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024716;
	b=Eezm4b7fBx9mF3dqmySOBv6ry+1dM1jlQa8bT+Zodco6oGI4nTw+pOBMS7J7UuXgvTV+
	 WFujId3wWngRVJYRMKMF0mn9DKMikKLjNPulFMUZFqpyzKonZ6FmUM5w9bfI9ErzdwNRp
	 Puw5Dx5xx1vA+1pRCUBLCxUkC0oKxi4KBgD0X28sxfrxrdoLh3PTwr6EbL+HbUq+gjWIS
	 2abonPhI68DHP98k9dvo4uEFP/cPv52fVkljuwylT2L6FVckyAlRVaknEYos+9/rtAobQ
	 iGPf3R4+Dvv2sOEmqdLF/RfWs/iCU+QXefOx5moY4jLVn7MLegTPOa+Im/vS721g6tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024716;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a1rYG1TalQ9YJsdpzA/JS3EHWX9ayK0ZVdBj8cqmZ40=;
	b=C7cpmPeeCRlYNC1lKXs2W41IDEFnHPYsBgZkP0gdnZH2U3EFEOeWmqVf8uGb3H14Vkwc
	 83JGvuuP/LfDVuElCu9+/72fc5XuPGpg/+ToJ8psXdKlZ7g2k+3kphPrS7GG5gigtwq8j
	 4nH9qtO84+fpEEkJpkfNn2qpv2KJmFyM9aFLBz2shi/fm1/zJQagE8Vwdx0fgCRw00Xl0
	 yt9PZfVjUNWRinp3fO6l14XDs1enRzzxeSETxVzNM/tWyU9Td+XTBcLgkdXzYXrHUpWkG
	 r4YED/OXO8gwDtHpB6pFJvZ81in6fU9rZtDOQR+90Rs9BApNQGqAR5sV+8Rg8c0yYQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XUorBv+5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B34606A330
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B34606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XUorBv+5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B952B1477;
	Wed, 18 Nov 2026 09:58:32 -0800 (PST)
Received: from e133894.cambridge.arm.com (e133894.arm.com [10.2.80.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61CD73F632;
	Wed, 18 Nov 2026 09:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795024715; bh=6LC0Esz0vtaHqOKJrOblFkqFYsHjYoYynkmx3V1YY8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XUorBv+5BYXRmwmIWIfIyz+4MgwsWz0U87h+LHxBUHSQeUvhU2DThAAs3CormI+5w
	 Lr539mChwoOlzp2NPE0pOtVLIoLj/Hm3wuTiduKBVYBctaoZsbN/n39w62PNPGiflw
	 ZmClNw5N21e6+6N1EGEcyVrINI22MLDfWFrxVnGI=
From: Sascha Bischoff <sascha.bischoff@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: vladimir.murzin@arm.com,
	maz@kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	timothy.hayes@arm.com,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH kvmtool v5 07/23] irq: Allow the initial interrupt line number to be set
Date: Wed, 18 Nov 2026 17:57:39 +0000
Message-Id: <20261118175755.1946977-8-sascha.bischoff@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118175755.1946977-1-sascha.bischoff@arm.com>
References: <20261118175755.1946977-1-sascha.bischoff@arm.com>
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

