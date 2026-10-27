Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101582;
	b=zE9IJRvMK2UKe8Jdm9jzrhv+hlME6/m9iNOsMGj/L7veX3bOQgJ8FUFpwn1Lpn94xoSB
	 XOxPXnpUgtetPvJwRiCAqcrphbZX++VkcDuUObD1PyDXllhCb8mlX2F8e4PyOKGrtHggE
	 LGPO+0I4xla13eOJ0HXo02shgUef9l2Uky/+CIbHoZYan4EMpz8ivTf4MpLaMO1BIzycN
	 EVEqAJPl+sOCbe4IucVQn29eud1nIWkaXTQXsapFtKkxnOuX71IcmzsBfiorjW+duZSJu
	 0/Az60clztEsOTAStr/IMMXVPXBHtZITuJbqzxkr/B9/NtTtraIs6WDiYwbj//cxUHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101582;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-ZMAIL-USEORIGINALEMLTOOUTBOUND:X-Zmail-RealSender:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Rwh35XQW/B+4T/QUwz9ROHBDhdVX2RvEsu0ct5jv/fA=;
	b=efFyvS/KbtIf9PzDfCRgApezlHmNOemOqoABniuIONkkEakOYQJ5wtksSI4VBkVJubtu
	 CM14f9jrR0Rq4oTDSinCotpxr430pGuY2nXQpyBkfx/3oK5Dkt6E4roW7FgUaMP5B83E0
	 PjZEmWkac7uPWuxgA/+NPExwghA4qL6CWePyP2g7D7OvijXV11Zy5Y4qJ/CirRZiNNS5X
	 kD/tc0DgVlR2NaO3e502vOUJ92pvhPt73K09HFRT0tSGwwUKgt80oIhzBBAmzr7Qs3GIz
	 SRg7nvbLXQFfyrnh7FFkYktTEvoXxcJ3ijCxzdCqXbkv+IWYvjdSCqILK1TpJRFYN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC44606A328;
	Tue, 27 Oct 2026 11:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AC44606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jDTGb3ttYz59trH;
	Tue, 27 Oct 2026 19:46:15 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl2.zte.com.cn with SMTP id 69RBkBYp038591;
	Tue, 27 Oct 2026 19:46:11 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 27 Oct 2026 19:46:14 +0800
X-Zmail-TransId: 3e816ae08f05027-7111e
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH] RISC-V: KVM: Fix out-of-bounds index into aia_irq2bitpos[]
Date: Tue, 27 Oct 2026 19:44:36 +0800
Message-ID: <20261027114439.699273-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 69RBkBYp038591
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 27 Oct 2026 19:46:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE08F07.000/4jDTGb3ttYz59trH

aia_get_iprio8() and aia_set_iprio8() index the 64-entry
aia_irq2bitpos[] array with an irq value derived from the
guest-controlled VSISELECT register. For RV64:

  first_irq = (isel - ISELECT_IPRIO0) * 4
  nirqs = 8
  isel up to ISELECT_IPRIO15

so the irq number can reach 67 and aia_irq2bitpos[64..67] is
accessed out of bounds. A malicious guest can trigger this,
causing host panic under KASAN/UBSAN or undefined behavior
otherwise.

Add an explicit bounds check in both accessors before indexing
the table.

Fixes: 2f4d58f7635a ("RISC-V: KVM: Virtualize per-HART AIA CSRs")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/aia.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index b3b466e4db33..a51d2db7f331 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -286,8 +286,12 @@ static int aia_irq2bitpos[] = {
 static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsigned int irq)
 {
 	unsigned long hviprio;
-	int bitpos = aia_irq2bitpos[irq];
+	int bitpos;
 
+	if (irq >= ARRAY_SIZE(aia_irq2bitpos))
+		return 0;
+
+	bitpos = aia_irq2bitpos[irq];
 	if (bitpos < 0)
 		return 0;
 
@@ -319,8 +323,12 @@ static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsigned int irq)
 static void aia_set_iprio8(struct kvm_vcpu *vcpu, unsigned int irq, u8 prio)
 {
 	unsigned long hviprio;
-	int bitpos = aia_irq2bitpos[irq];
+	int bitpos;
+
+	if (irq >= ARRAY_SIZE(aia_irq2bitpos))
+		return;
 
+	bitpos = aia_irq2bitpos[irq];
 	if (bitpos < 0)
 		return;
 
-- 
2.27.0

