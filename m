Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880995;
	b=wroKT5Lsb5ZEKxIrNEDKnTZqHwWlj9IRU3JsneU8FGyQI7sDWKCTblJiOKZTyqb1fvW3
	 1gupur+IATGV2JxLweLiUfYuZuV2d4BhYGXvECpZw9rg7pW/UH9y7mHzDQ2sKQ6/e3wve
	 NqVJaN7MU8tkcinadh/5XgeV+00OqjePY46y1OKoFVdggEV/enEhXqXdvbkyiU3HmN66E
	 7fopT7J0DnAU9etwu8QyaCCc3EYAM32Rif/hJfcjWMlmmV9uH+FvBhUYrYjS5nglvquG2
	 Zjsrcf+y+U15rad2u7jmWw0vrM5KqTsNlUuPO/UlF6/qnf07lyzUSElvhWkkQaP31Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880995;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=KcvrewBhOXlM8MEBGzrRCZe7QXU+yH/iDXAzLiw8UXY=;
	b=eeXCLpEVRal4SfPmbbOL3ojxjUwpeQ7CTxqzsAM8+L5RR1SRt0OHsM4qwKtNQmuRkST5
	 rJmi0Y11ih3nL5IhdPy54MRpSeH/8Dklqm+G763s6v2nT2RiuOehATd5dzKvUJNRG4IkZ
	 PINzAR9RcKKPWLDR6fDBaX6K+hXNLgyp+HH24jH6BfxAtRj2BelmLvuhaWr3/K78t3xqO
	 +3ai1+a+dkioCM5vC+GoumWkb7NQxPGcWpCgpBcClXtvlgVeXtxLXeljDi13Vf9tEfZR8
	 MnMQr/Hl4eLoWbiFmLK12HOpMuKK2cx7RP1xCceZ76jUIBxeJARiOuMeO3OOW6tPQEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F191606A31C;
	Tue, 17 Nov 2026 02:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F191606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jT7L63YwBz23sl;
	Tue, 17 Nov 2026 10:03:10 +0800 (CST)
From: Daolong Zhang <dlzhangak@isoftstone.com>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Song Gao <gaosong@loongson.cn>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daolong Zhang <dlzhangak@isoftstone.com>
Subject: [PATCH] LoongArch: KVM: Fix uninitialized stack read in dmsintc_inject_irq()
Date: Tue, 17 Nov 2026 10:03:10 +0800
X-Mailer: git-send-email 2.48.1
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Tue, 17 Nov 2026 10:03:10 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AFBB5DE.001 by FangMail milter!
X-FangMail-Envelope: 1794880990/4jT7L63YwBz23sl/6AFBB5DE.001/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1794880990.6AFBB5DE.001
X-FangMail-Outinfo: 1794880990/6AFBB5DE.001/4jT7L63YwBz23sl/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1794880990.6AFBB5DE.001.4jT7L63YwBz23sl@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFBB5DE.001/4jT7L63YwBz23sl

In dmsintc_inject_irq(), the local array 'vector[4]' is declared on the
stack without initialization, and each element 'vector[i]' is only
assigned when atomic64_read(&ds->vector_map[i]) is non-zero.

Whenever any of the four 64-bit words in ds->vector_map[] is zero (for
example, when an MSI interrupt targets a single word, or when INT_AVEC
is injected via KVM_INTERRUPT with an empty vector_map), the remaining
elements of 'vector[]' retain uninitialized kernel stack contents. The
subsequent checks on vector[0..3] then OR those uninitialized stack
values into the guest's hardware LOONGARCH_CSR_ISR0..3 registers,
injecting spurious interrupt vectors into the guest and leaking host
kernel stack data into guest-visible CSRs.

Zero-initialize 'vector[4]' on declaration to prevent reading
uninitialized stack memory.

Fixes: 03de5eecb0f0 ("LoongArch: KVM: Add DMSINTC inject msi to vCPU")
Signed-off-by: Daolong Zhang <dlzhangak@isoftstone.com>
---
 arch/loongarch/kvm/intc/dmsintc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/intc/dmsintc.c b/arch/loongarch/kvm/intc/dmsintc.c
index de25735ce039..ef6c064e52f1 100644
--- a/arch/loongarch/kvm/intc/dmsintc.c
+++ b/arch/loongarch/kvm/intc/dmsintc.c
@@ -11,7 +11,7 @@
 void dmsintc_inject_irq(struct kvm_vcpu *vcpu)
 {
 	unsigned int i;
-	unsigned long vector[4], old;
+	unsigned long vector[4] = {}, old;
 	struct dmsintc_state *ds = &vcpu->arch.dmsintc_state;
 
 	if (!ds)
-- 
2.48.1

