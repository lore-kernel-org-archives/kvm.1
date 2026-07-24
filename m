Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5807F39A4CF
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884266; cv=none; b=lScyV4dzcpCGetLQ++PWRKpjUo6GQsTiwE5FN5/wOFGnuAnTj/jXAhXl9Mx6Dst4yAd6u3wk2JsTG+eueEwQR4/jjaKDAAPtl5qHLiSlHRhf5Dp+Cd2EunpYg/VE49NM0M42veDx9DRnpKwmcX1WZ1nl9RIu1jjZp3+cyjp+mLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884266; c=relaxed/simple;
	bh=CRGzjnZgYM/YU8kU1FgLBi7DBdsrc2FoVYDLHN3Nhy0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8y/ajqo3EUoHzL/HDm1JeW3HWCD22HV9YGaQx8RfZgZqYx1p2WhkD3XJRMQJ5d/osN4juyeuyqJjb3wz1Nl4eQdGFHkMljbf7W9vDMj3iRbdsg9WZw53KsftkKTHrjuWGHo8H4lYpA75z1MW8A0DM0TSKNucleCLr1AeuiHIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=O5RvBMLk; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="O5RvBMLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=qyoCY880F7
	STjP4WxtzLMG5x4fWxaPo0C1Ee4Hjjbqs=; b=O5RvBMLktk4Qz+QAIL+FDrwAFB
	T4oCJTOUynKYdHiZSk8XW5jP/hdLWnQ3T64g+xrYwQHRDsUOfjt+dwDw/vFg65Hb
	RSEnTwoWMhdHXQNMqPobs69A3c7vgtwbnJQVvKiMdQWtAGi7U2emfKP+90rJsYcc
	LkXFZDUCnMhsK6mFE=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwA3cUIzLGNqjywVAA--.17724S2;
	Fri, 24 Jul 2026 17:11:21 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: kvm@vger.kernel.org
Cc: Xie Bo <xb@ultrarisc.com>,
	Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH kvmtool] virtio: 9p: Order used ring updates before notifications
Date: Fri, 24 Jul 2026 17:10:41 +0800
Message-ID: <20260724091046.1868685-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwA3cUIzLGNqjywVAA--.17724S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xKw47XF1DtFy3GF4xCrg_yoW8Aw4fpF
	WFkaySyr98WrnF93W5GF48Wr17uws7Gr17JF1Fg34UWr4YqFn7AF1UK345tF4fu395Xw1Y
	yrWv9a9Fq3yjvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
	9x0JUDpnQUUUUU=
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQAOB2pdm1EAHAAZsw

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
 virtio/9p.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virtio/9p.c b/virtio/9p.c
index cf3e547..d2680e9 100644
--- a/virtio/9p.c
+++ b/virtio/9p.c
@@ -1372,11 +1372,15 @@ static void virtio_p9_do_io(struct kvm *kvm, void *param)
 	struct p9_dev_job *job = (struct p9_dev_job *)param;
 	struct p9_dev *p9dev   = job->p9dev;
 	struct virt_queue *vq  = job->vq;
+	bool completed = false;
 
 	while (virt_queue__available(vq)) {
 		virtio_p9_do_io_request(kvm, job);
-		p9dev->vdev.ops->signal_vq(kvm, &p9dev->vdev, vq - p9dev->vqs);
+		completed = true;
 	}
+
+	if (completed && virtio_queue__should_signal(vq))
+		p9dev->vdev.ops->signal_vq(kvm, &p9dev->vdev, vq - p9dev->vqs);
 }
 
 static u8 *get_config(struct kvm *kvm, void *dev)
-- 
2.17.1

