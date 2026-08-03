Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DC64AA4
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 01:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720766; cv=none; b=NW5yLbcViN6xAWlhyiQWEoCiouVfI2O8VtugVCdNoYaHkad5Yapz5FU2LlipZ/1TrTeyPUOUZe5c49yNY8gqiGF8dGStt3fdY/G7zMBSR3KnxFhvuxku/yyqztCVdtgd1MByCXW9z9sTYmH6W0ah0gUkc5p9FUsGjyBwWrVQl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720766; c=relaxed/simple;
	bh=XgGSnrmiEplsuwdy9X5QAMWzJBtazd6Xs+YV0+ohndk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFs0WQwr/jJ33sjUhgTngvyjDbIamuY/W6fYl4ayyMZY1YX3HPvE1YcR6k282On4DO+tlh6Wzp0+O16SscxJMGKxAJTv8ujA4f4VrvvCuHe+l2eXLn/p2XVWsuT0mFhFW8JT4maLwVxpOFg9L8k9X5vxNIy1ui5GKQCf2ybqa+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=FBKt5gXL; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="FBKt5gXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=zyOoDT8YQTbXcnnqKnt2EmzdR1me4CRwRe
	9zua4HSmM=; b=FBKt5gXLT1u3RNW1U4FFeNvI57xME8QW49VyRDDI6HWPjLhQZ/
	fYbb3ufRsLGAz6muEkgJ6Kb7CDp6OdA0MAN2lywoU6ai+jEueTw3JXdFjA1bXsZu
	OWMkOMJMY2dcTg3WJN+rx3SeWMUxcF2BR3sa0sSULJeaixdVQYTv819Fk=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDXEELF729qJA0WAA--.18137S2;
	Mon, 03 Aug 2026 09:33:01 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	anup@brainfault.org,
	Xie Bo <xb@ultrarisc.com>
Subject: [PATCH kvmtool v2] virtio: 9p: Order used ring updates before notifications
Date: Mon,  3 Aug 2026 09:32:26 +0800
Message-ID: <20260803013226.333910-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <amzWlInb1rgkRy_4@google.com>
References: <amzWlInb1rgkRy_4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDXEELF729qJA0WAA--.18137S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xKw47XF1DtFy3GF4xCrg_yoW8AF13pF
	WvkaySyr98WrnFq3WfGF48Wr17CwsxGry7Jr1Fg34UXr45XFs7AF1DK345tr1fW39Yqw1j
	yrWvvFWqvayj9aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv214x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r1j6r
	4UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7VUjiID7UUUUU==
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAFB2psG9MAEgACsd

virtio_p9_do_io() signals the guest immediately after adding each
request to the used ring. Unlike the block and net backends, it bypasses
virtio_queue__should_signal(), which provides the full memory barrier
needed between publishing used->idx and injecting the interrupt.

On weakly ordered architectures, the guest can therefore handle the
interrupt before the updated used->idx becomes visible. If it observes
the old index and goes back to sleep, the completed request can remain
stuck indefinitely because no further interrupt is generated.

This was observed on RISC-V with two 9p RPCs blocked while the host
used->idx was two entries ahead of the guest's last_used_idx.

Process all available requests first, then use
virtio_queue__should_signal() before notifying the guest. Besides
providing the required ordering, this also honors the driver's
notification suppression request.

Fixes: 1c7850f95903 ("kvm tools: Add virtio-9p")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
Changes in v2:
- Drop the completed flag and rely directly on
  virtio_queue__should_signal(), as suggested by Will Deacon.

 virtio/9p.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/virtio/9p.c b/virtio/9p.c
index e6f669c..100926a 100644
--- a/virtio/9p.c
+++ b/virtio/9p.c
@@ -1375,8 +1375,10 @@ static void virtio_p9_do_io(struct kvm *kvm, void *param)
 
 	while (virt_queue__available(vq)) {
 		virtio_p9_do_io_request(kvm, job);
-		p9dev->vdev.ops->signal_vq(kvm, &p9dev->vdev, vq - p9dev->vqs);
 	}
+
+	if (virtio_queue__should_signal(vq))
+		p9dev->vdev.ops->signal_vq(kvm, &p9dev->vdev, vq - p9dev->vqs);
 }
 
 static u8 *get_config(struct kvm *kvm, void *dev)
-- 
2.54.0

