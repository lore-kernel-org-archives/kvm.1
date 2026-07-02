Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB270390C81
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976008; cv=none; b=XyJFKQvWOKCy8mV6anmyo/8NjtOsfmWggC5EPVPL3GijNYs8WsbvkJdCVM83cAbBktFpqlceQA928QjmG2BdDYBYYzQjZ/EdisnD8ejY5yGd+5kqZxF5Lex10OVZlTP5LCuuPY6EQ0J3rpGptZRAgtPeV9S0Pc+rOHSX2ZcOo1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976008; c=relaxed/simple;
	bh=+IKjA1q8ywnsNa1rdq+ArnI+6VLdEB15twkY73YqLEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkLVqH4/7PDWSEES8z5wt3YAQXuR1ISftDxGQhHxAjoXJHCRKEbr/dympIeKMwZl6hnegsWEvnt+9Z3nQFNvCLxV8Elj5NACrMUUK0g2X/lv5LF/g2xGDd538z6OPg58oSbSUU4NSSXhz8oJlJA8tac9xRpOZ/xlAAdwMeiWVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Q4cwfKZ/; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q4cwfKZ/"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVb3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVb3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975047;
	bh=yN5Eehydmx0x1TtfUz5PlbiFkUUsZCyK8weP/cq16B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4cwfKZ//mlpWNCPdV8MjM0pL7ibwxhCWXBEq5YR4Tw/CwdP3XexEz2PHfs/s9st6
	 DsMeGUnFUkrUlqYD4pypB2eWb63+QPeCC1kcttmexA+Aq5Qu8d4/sjwKqDi+upwYdD
	 scrGysnp6uY/Bq2A/DQIikWZyBNbXLova8ZOMw7Hw1B+fBARP18ZGd0rq5a35MvOOr
	 VMONvsdS9Da5W1QIueuCBkoxOesBzo4KezW1q8XsaTTy/O3uhji3gg5nd7jghFK3xy
	 mpUjKuHAH9BEY+nerU6MiGqArsm0MQFZcDYyJiNPCbbqB+BDbHGRTZ/U56qtXNk72l
	 hBl4W0dnGWfag==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 02/11] x86/vmx: Allow bit 13 of VM-entry injection info to be set
Date: Wed,  1 Jul 2026 23:50:30 -0700
Message-ID: <20260702065039.3434909-3-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065039.3434909-1-xin@zytor.com>
References: <20260702065039.3434909-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of VMX nested-exception support, bit 13 of the
VM-entry interruption-information field (Nested Exception) must be set
when injecting a nested hardware exception.

A CPU supporting FRED relaxes the Intel SDM's conventional VM-entry
validation checks: if the event type is a hardware exception (bits 10:8
set to 3), bit 13 is permitted to be 1, regardless of whether FRED
transitions are actively enabled following the VM-entry.

Update the event injection test logic to allow this bit to be set to
prevent spurious test failures on FRED-capable hardware.

Signed-off-by: Xin Li <xin@zytor.com>
---
 x86/vmx_tests.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 16f8a648..bb61610d 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -4708,6 +4708,15 @@ skip_unrestricted_guest:
 	/* Reserved bits in the field (30:12) are 0. */
 	report_prefix_push("reserved bits clear");
 	for (cnt = 12; cnt <= 30; cnt++) {
+		/*
+		 * Regardless of whether FRED transitions would be enabled
+		 * following VM entry, if event type (bits 10:8) is 3
+		 * (hardware exception), bit 13 may have value 1 (indicating
+		 * a nested exception).
+		 */
+		if (cnt == 13)
+			continue;
+
 		ent_intr_info = ent_intr_info_base |
 				INTR_INFO_DELIVER_CODE_MASK |
 				INTR_TYPE_HARD_EXCEPTION | GP_VECTOR |
-- 
2.54.0

