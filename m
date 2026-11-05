Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866858;
	b=ws5/paakKYOw695+nmrT4lHLCv4mMq3b3wXKd+6fHWzp3K+XnjaufkfuxzBAYz7Ptp0E
	 w0AK+KY5vqQuJmwqUSF3TGqZe9OxZ3yD3zufQgGv82A5oWQa9b/k86f8JTwLO1lEBz5nk
	 tgAx8ZU9RA/rWsvZdb+5f+n1fBpd+WQQGE4Pn5pmj2c8JI/rMmbHhpccIQXk7q9srwBW/
	 +aX8biGabM5HT4vJmDDnmTG6X97TsC2S1Avpu6cHSYs65kv19RjiP3YRyrWBSWXxjuBSS
	 GmmHMG3Gi+dkugY50KnkHuUWDO2jthLwKAasHp36ZebzhXg3BRHsjL4jrNS3NgNzJLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866858;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=T2FfoVqjwkfkSqA6qKb/AOlBch9f6WawwTs8MEUGzIM=;
	b=2duEAOx2hbnJUyKzAC9DrAwfA6NNhxx8eVL4qTZKDdXPBWzpISBBr0MCxIKeFTsrHnQR
	 QRj/fc5I+Kw6ZXNNQKjHyqSSz3BGYhQYmO26mOOa7r10fQxjBX8ixsZcs8Y3kYbsYX95j
	 aVuES8G+u4SLXKnXSeuebcE3PQqQMJr0/ygeUIpP43TxUim9/xsGtiZ+Kdv0HemtJCR/M
	 8etw82jLRt8PNVVL794EyHA1A5z7oZEh33pD6WNzGSQI/EuKGaGpRQjlDOp1PSp+JPSgc
	 SA9TPjPW7rRR6dU2CO8Mu6/jOhNSufh9/OUy+ILKAQPBhk1H6JFvabHGlKhcdul0SQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C4606A32F
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 410C4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [122.194.100.204])
	by APP-01 (Coremail) with SMTP id qwCowAC33vhaPOxq9ydRAA--.29171S2;
	Thu, 05 Nov 2026 16:20:42 +0800 (CST)
From: Xiang W <wangxiang@iscas.ac.cn>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org
Cc: andrew.jones@linux.dev,
	Xiang W <wangxiang@iscas.ac.cn>,
	pbonzini@redhat.com,
	thuth@redhat.com
Subject: [kvm-unit-tests PATCH v2 7/8] riscv: initialize ISA extensions for all harts in cpu_init
Date: Thu,  5 Nov 2026 16:20:34 +0800
Message-ID: <20261105082035.133680-8-wangxiang@iscas.ac.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
References: <20261105082035.133680-1-wangxiang@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAC33vhaPOxq9ydRAA--.29171S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4UJw1DCF18uFW8KF4UJwb_yoW8Jw13pF
	yDCayjkrZxGFs7t3s7Ar1Sy34Sg3Z3C3WxtrW8Z3yFva1UA398XrWDJ340vFyUXFWkCa1a
	9rW0kryrZa17XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU8a9aDUUUU
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

Move `isa_init()` from `thread_info_init()` to `cpu_init()`.

Previously it only ran for the current hart; now it is called for every
hart so that ISA extensions are parsed for the whole system.

Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
---
 lib/riscv/processor.c | 1 -
 lib/riscv/setup.c     | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/riscv/processor.c b/lib/riscv/processor.c
index b055acc9..ddecc25e 100644
--- a/lib/riscv/processor.c
+++ b/lib/riscv/processor.c
@@ -81,7 +81,6 @@ void thread_info_init(void)
 	unsigned long hartid = csr_read(CSR_SSCRATCH);
 	int cpu = hartid_to_cpu(hartid);
 
-	isa_init(&cpus[cpu]);
 	csr_write(CSR_SSCRATCH, &cpus[cpu]);
 }
 
diff --git a/lib/riscv/setup.c b/lib/riscv/setup.c
index f1121573..8c16686f 100644
--- a/lib/riscv/setup.c
+++ b/lib/riscv/setup.c
@@ -16,6 +16,7 @@
 #include <on-cpus.h>
 #include <vmalloc.h>
 #include <asm/csr.h>
+#include <asm/isa.h>
 #include <asm/mmu.h>
 #include <asm/page.h>
 #include <asm/processor.h>
@@ -105,6 +106,9 @@ static void cpu_init(void)
 		cpu_init_acpi();
 	}
 
+	for (int cpu = 0; cpu < nr_cpus; cpu++)
+		isa_init(&cpus[cpu]);
+
 	me = hartid_to_cpu(csr_read(CSR_SSCRATCH));
 	assert(cpu_present(me));
 	set_cpu_online(me, true);
-- 
2.47.3

