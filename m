Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1D1862
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289455; cv=none; b=tXUpfY2Rx42846tfB2Qy1hKcgzlYMVSWhBDlMA5+mQmj4oq5rt6P3jGvmzxPEkd8E749b1AbRfZPN+V9BaGg601u/sLPSugNLpsQHBaV5eEU7ARYPdhgd5u1l4I6Av+JgrwNYlQlC1xDXL0eG74KsvHfppQ+ffg6aw/Dx7U6bJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289455; c=relaxed/simple;
	bh=N0edJjqZ7fOxuYAAW+jEf3ZL2rJMVf5us4TSMR9o3pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3Bl1HMjiAgTA/YUu50PVOEcl66T8GYctFcA2h8n+HH7ej8LCh9hwuLsyFKVG57OlfvBiLEKOafhACk6fLEoqsKovZJIn7odScAu3/2VA7+oo+VfcCyKtohTT+wMyDLGlin1dtYayRDPM0XE8fj9eWCvNLGWie2Sv5LvHMpfIlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=BhrKCZ08; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="BhrKCZ08"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=YRzlPZJkac
	eZu0LXEiMQQeZN5gA/rIBzLagLqhP7D8k=; b=BhrKCZ08ogZpq7Fr7XAQoGOosz
	eg/IhzRqtigI2ZEvC4HNQikb8+jaMrTSsYZrhBwla/Pbe21dzN+z+f1Ij7NmusXv
	HHmyEiJwkbj0nWAUkqKmh6rKoWrSiLzdAx6L76UywuqGStS/D+ZVt5d/H/UwI1Ha
	PjGYNv+Mc6ZXPwkzo=
Received: from ur-dp1000 (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnEkP9WmlqHaYVAA--.17835S2;
	Wed, 29 Jul 2026 09:44:37 +0800 (CST)
From: Xie Bo <xb@ultrarisc.com>
To: kvm@vger.kernel.org
Cc: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	jean-philippe@linaro.org,
	Xie Bo <xb@ultrarisc.com>
Subject: [PATCH kvmtool] virtio/pci: Serialize legacy ISR and INTx updates
Date: Wed, 29 Jul 2026 09:43:48 +0800
Message-ID: <20260729014348.6601-1-xb@ultrarisc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwAnEkP9WmlqHaYVAA--.17835S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4fuFWUWFyDtF1rKrWfXwb_yoWrAr47pF
	nxGF4kWryfXrWxXFZ5JFnrur1Svan8WF9rCryFgw1rGF98twnY9ryUtrWxZrW0yrWvyrWU
	Xr1rWrW5Zr4DuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjfU5oGQDUUUU
X-CM-SenderInfo: l0e63zxwud2x1vfou0bp/1tbiAQATB2pkMtIAAQAVsv

The legacy virtio-pci interrupt state is represented by two pieces of
state: vpci->isr and the legacy INTx line level. Backend threads set ISR
bits and assert INTx when queue or configuration changes occur, while
vCPU threads read and clear the ISR and deassert INTx.

Those operations currently race. One possible interleaving is:

  vCPU thread                      backend thread
  -----------                      --------------
  read old ISR value
                                   set ISR queue bit
                                   assert INTx
  clear ISR
  deassert INTx

The guest can then miss the completion because no ISR bit remains and the
line is no longer asserted. A guest waiting for an interrupt-driven
virtqueue can sleep indefinitely despite completed host-side work.

Fix this by adding a per-virtio-pci device mutex and using it for all
legacy ISR/INTx state transitions: queue notification, configuration
notification, legacy ISR read-clear, and modern ISR read-clear. MSI-X/MSI
delivery continues to bypass the legacy ISR path.

Fixes: 2108c86d0623 ("virtio/pci: Signal INTx interrupts as level instead of edge")
Signed-off-by: Xie Bo <xb@ultrarisc.com>
---
 include/kvm/virtio-pci.h | 3 +++
 virtio/pci-legacy.c      | 4 +++-
 virtio/pci-modern.c      | 4 +++-
 virtio/pci.c             | 5 +++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/kvm/virtio-pci.h b/include/kvm/virtio-pci.h
index 143028b..1fb931e 100644
--- a/include/kvm/virtio-pci.h
+++ b/include/kvm/virtio-pci.h
@@ -2,6 +2,7 @@
 #define KVM__VIRTIO_PCI_H
 
 #include "kvm/devices.h"
+#include "kvm/mutex.h"
 #include "kvm/pci.h"
 #include "kvm/virtio.h"
 
@@ -37,6 +38,8 @@ struct virtio_pci {
 	bool			signal_msi;
 	u8			status;
 	u8			isr;
+	/* Serializes legacy ISR bits and INTx line state. */
+	struct mutex		isr_lock;
 	u32			device_features_sel;
 	u32			driver_features_sel;
 
diff --git a/virtio/pci-legacy.c b/virtio/pci-legacy.c
index 02a8f8c..3038a1e 100644
--- a/virtio/pci-legacy.c
+++ b/virtio/pci-legacy.c
@@ -59,9 +59,11 @@ static bool virtio_pci__data_in(struct kvm_cpu *vcpu, struct virtio_device *vdev
 		ioport__write8(data, vpci->status);
 		break;
 	case VIRTIO_PCI_ISR:
+		mutex_lock(&vpci->isr_lock);
 		ioport__write8(data, vpci->isr);
-		kvm__irq_line(kvm, vpci->legacy_irq_line, VIRTIO_IRQ_LOW);
 		vpci->isr = 0;
+		kvm__irq_line(kvm, vpci->legacy_irq_line, VIRTIO_IRQ_LOW);
+		mutex_unlock(&vpci->isr_lock);
 		break;
 	default:
 		ret = virtio_pci__specific_data_in(kvm, vdev, data, size, offset);
diff --git a/virtio/pci-modern.c b/virtio/pci-modern.c
index 888afa5..2b234a7 100644
--- a/virtio/pci-modern.c
+++ b/virtio/pci-modern.c
@@ -246,9 +246,11 @@ static bool virtio_pci__isr_read(struct virtio_device *vdev,
 	if (WARN_ON(offset - VPCI_CFG_ISR_START != 0))
 		return false;
 
+	mutex_lock(&vpci->isr_lock);
 	ioport__write8(data, vpci->isr);
-	kvm__irq_line(vpci->kvm, vpci->legacy_irq_line, VIRTIO_IRQ_LOW);
 	vpci->isr = 0;
+	kvm__irq_line(vpci->kvm, vpci->legacy_irq_line, VIRTIO_IRQ_LOW);
+	mutex_unlock(&vpci->isr_lock);
 
 	return 0;
 }
diff --git a/virtio/pci.c b/virtio/pci.c
index 8a34cec..4852ce3 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -242,8 +242,10 @@ int virtio_pci__signal_vq(struct kvm *kvm, struct virtio_device *vdev, u32 vq)
 		else
 			kvm__irq_trigger(kvm, vpci->gsis[vq]);
 	} else {
+		mutex_lock(&vpci->isr_lock);
 		vpci->isr |= VIRTIO_PCI_ISR_QUEUE;
 		kvm__irq_line(kvm, vpci->legacy_irq_line, VIRTIO_IRQ_HIGH);
+		mutex_unlock(&vpci->isr_lock);
 	}
 	return 0;
 }
@@ -266,8 +268,10 @@ int virtio_pci__signal_config(struct kvm *kvm, struct virtio_device *vdev)
 		else
 			kvm__irq_trigger(kvm, vpci->config_gsi);
 	} else {
+		mutex_lock(&vpci->isr_lock);
 		vpci->isr |= VIRTIO_PCI_ISR_CONFIG;
 		kvm__irq_line(kvm, vpci->legacy_irq_line, VIRTIO_IRQ_HIGH);
+		mutex_unlock(&vpci->isr_lock);
 	}
 
 	return 0;
@@ -346,6 +350,7 @@ int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 
 	vpci->kvm = kvm;
 	vpci->dev = dev;
+	mutex_init(&vpci->isr_lock);
 
 	BUILD_BUG_ON(!is_power_of_two(PCI_IO_SIZE));
 
-- 
2.17.1

