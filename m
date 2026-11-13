Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.6.4.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563322;
	b=x4v9gcLgdYSWqAkLvPXXiilGcPFQi71CLoreYMbkDSw9SNuD0ucrPWRWNEvlwBm0Y3Fk
	 N7rrcuDX7lARR/SFT+wM//EjgiKpQvi6fBxaA9ukz1AlWkyiv1o7GfW1WksKruzMOoxYq
	 kJmTJM3mqpH09xFbJdFhE7zlWJ+fZZr03JKf6K/Ux2E3sAMPJs3Tn7Fr4Ek2E4leXyuy5
	 34zzB8j+wDS25NnHRHB2gVLJ8MxWZLCTTD75sqbwOxutrJw4JZkVtla2Qd5GAxZWVTF9h
	 IPWz7IA0apCNjHYVbaUosdKr220NjfqZGCnkIIpTqJ6CGlwIMyBmhJenWM307V+Q5nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563322;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=WrgiXMgDnLyn81IHw7OwTp99pe2tAXjTUQfDjOQj1WU=;
	b=HO9zEkrs4XyDKJsgi/rUwu8NPuvRlc6BwBhk2XdjD6A/yoEuapIWXX8GTsMbCI4ILPod
	 iubYfMIMK//AwIF6GD370EQY7sLov+4Ctuzqrc1b2M/ARcrOPHB2bAVs+k5kB0ircfRGx
	 I0tzfstIH9Efbyl2JHzgfIa7fhxp8az4HZXHbWapuC2qhwnkE3UhjAL7IdF+wKHkEM8aF
	 xxVsaI/tlchliBZWLc4wOdAuOPqMMu1IDjuNNvgeQcIMpRFyoagqrkh7Kb/BNZ0zdiG3v
	 LlOCM+kIobgNSMOHC/XWR1FM3WpUC6JyYiPuTlqbUMBTyFeaN2rse0u2QtrcW756kPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mails.tsinghua.edu.cn;
	spf=pass smtp.mailfrom=mails.tsinghua.edu.cn;
	dkim=pass header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=BTnM3zoD;
	arc=none smtp.remote-ip=101.6.4.70
Received: from tsinghua.edu.cn (smtp46.tsinghua.edu.cn [101.6.4.70])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD4A606A323
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 09:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD4A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.a=rsa-sha256 header.s=dkim header.b=BTnM3zoD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=WrgiXMgDnLyn81IHw7OwTp99pe2tAXjTUQ
	fDjOQj1WU=; b=BTnM3zoDav8SyH5Dzs2v+m6M03uItdlp6Gi1J3pbLdQsF/VVpa
	1XPtlWBamXxBup6HJK2aO3EFE0n5qwIQeHArjHsjfaYPcmDweddtDPibee4Oxxti
	feLiBdRQa3Do0WcnSuCBXWhpBVTd12AigotoZEkRumg05NhqIBoRCF+FA=
Received: from ubuntu (unknown [101.5.154.165])
	by web1 (Coremail) with SMTP id yAQGZQA3qzvR3PZqgA5CAg--.9318S4;
	Fri, 13 Nov 2026 17:48:27 +0800 (CST)
From: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
To: qemu-devel@nongnu.org
Cc: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org,
	kvm@vger.kernel.org,
	Peter Maydell <peter.maydell@linaro.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	bin.meng@processmission.com,
	tangtao1634@phytium.com.cn,
	Chao Liu <chao.liu@processmission.com>
Subject: [RFC PATCH 02/20] hw/char/dw8250: expose the baudbase property
Date: Fri, 13 Nov 2026 17:47:36 +0800
Message-ID: <cd2f3b71699aa3785c99142f5288190a7a6eedef.1794555589.git.w-yf22@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
References: <cover.1794555588.git.w-yf22@mails.tsinghua.edu.cn>
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
X-CM-TRANSID:yAQGZQA3qzvR3PZqgA5CAg--.9318S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtF45CFWxGFWDAFWDAr4xWFg_yoWDAwb_GF
	y5uFykXrs5JF13KrW2kaykWrn8Cw1rJ3ZrtFn7KFZ8WrykW3yDXFy5CrnYvr47u3yDCrW3
	J34kA34Ika45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbdAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8uwCF
	04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
	18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vI
	r41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhjjgUUUUU=
X-CM-SenderInfo: fzn1wj2s6ptxtovo32xlqjx3vdohv3gofq/

From: Chao Liu <chao.liu@processmission.com>

The RK3588 SoC clocks its UARTs at 24 MHz, so the embedded serial
device needs a matching baud base to calculate the guest baud rate
correctly. Alias the serial-mm baudbase property on the DW8250 device
so that the SoC model can set it.

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Signed-off-by: Yifan Wang <w-yf22@mails.tsinghua.edu.cn>
---
 hw/char/dw8250.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/char/dw8250.c b/hw/char/dw8250.c
index 4f9a8ea989..6fba0d66aa 100644
--- a/hw/char/dw8250.c
+++ b/hw/char/dw8250.c
@@ -117,6 +117,8 @@ static void dw8250_instance_init(Object *obj)
 
     object_initialize_child(obj, "serial-mm", &s->serial_mm, TYPE_SERIAL_MM);
     object_property_add_alias(obj, "chardev", OBJECT(&s->serial_mm), "chardev");
+    object_property_add_alias(obj, "baudbase", OBJECT(&s->serial_mm),
+                              "baudbase");
 }
 
 static void dw8250_realize(DeviceState *dev, Error **errp)
-- 
2.53.0

