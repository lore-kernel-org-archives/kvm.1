Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124866;
	b=OcR4vxPQaxKmnUfk+iUCGSYJZYZx9gg6KgWewVPv1NJ7wZ82F745eg2+LTrLHb1EIJM7
	 q6fXkwKWd+MuybFmcZOEWbFPOaOjcu8RcIE8jZzLFQUzw8yUY+mTyreqrIQ4d0m7aXLOW
	 VKXplZG7LDAiwiM2cbvCgac5hlHdp1rRxhlChycpigZ7fspR65BR2sb3wQmLDjzkhMY+t
	 iDl9RqJ3rDuEY5kAcSfWYxgmaa+eDHx0HT1eI4ubGcYRk4q5knYWDsEMYEDaNMR07t5sp
	 Q3ESvduTndUYoSRH8v9bclOsaLbboL2V9QuLN9XJYODR+FFb+inuvQZHBx/H/xRJxAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124866;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=caBZVIE/hSguJ/sxrRpKGVVVydsKnFLoXQm6GdDdBq0=;
	b=3nwed9f1Itz4jivWC7Qdv5Lm2iElXnkkmZ8f1M0DVazxtz7N3qo48mqe8lNy2qGlAQuC
	 3y/FQwVEK/P6dexKmuH57LdfqFBCJiu34OLirLyUVcXDr7aIy09fuiuujFflp+go/ApYE
	 41jjas9siAMzbcQaAz816My8nUA4KTIAhO7GRTTUjS/2AI/CnIn5AKnRgTtQL8P2uCwuY
	 zbQ42juogvSMf7WNiXKotacVfM0hJ0g/CRG6aeUfRh+GtazGaF5d5ncny/40/9nS0NLih
	 PJxQ47lgDFRSoW5N+MAqLy4J3LKSU57IUaa4hOpnrmB69nTEAeDLYI8pmxflpxKuRsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="C3/RgCrs";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9877606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9877606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C3/RgCrs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=caBZVIE/hSguJ/sxrRpKGVVVydsKnFLoXQm6GdDdBq0=;
	b=C3/RgCrsuaoT6deF5d+L8VTH/NOkEUt2B/U/zTLA6a9GBtLYIWxcMfp7BT0X/1hC/2mf/c
	UF/TJua3jfEYlaBz+ND+ffk+jDroBRvH8bg7ZIrX/jAPaH7+0rSqCk7sLkPucnaYTGEt5/
	hbzGDrCSl9czz92hNqCvGpjjausx9F8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-ogOcdw8xNomqQoUIrQuolg-1; Tue,
 27 Oct 2026 14:14:15 -0400
X-MC-Unique: ogOcdw8xNomqQoUIrQuolg-1
X-Mimecast-MFC-AGG-ID: ogOcdw8xNomqQoUIrQuolg_1793124851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EFF81955BF1;
	Tue, 27 Oct 2026 18:14:10 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D1DC18005AD;
	Tue, 27 Oct 2026 18:14:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-riscv@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Chao Liu <chao.liu@processmission.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	xen-devel@lists.xenproject.org,
	Sergio Lopez <slp@redhat.com>,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Xianglai Li <lixianglai@loongson.cn>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	qemu-s390x@nongnu.org,
	kvm@vger.kernel.org,
	Alexander Graf <graf@amazon.com>,
	Song Gao <17746591750@163.com>,
	Eric Farman <farman@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/11] hw: mark virtualization related machines & accelerators as secure
Date: Tue, 27 Oct 2026 18:13:49 +0000
Message-ID: <20261027181400.1752951-1-berrange@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This is the machine type and accelerators patches pulled out of the
bigger series and split per target / accelerator:

  https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg03555.html

Note this only deals with marking leaf types. All parent types
are implicitly also considered secure if any leaf is secure. A
future series will explicitly mark parent types too.

Daniel P. Berrangé (11):
  hw/arm: mark 'virt' as a secure machine
  hw/i386: mark 'microvm', 'i440fx', 'q35' as secure machines
  hw/loongarch: mark 'virt' as a secure machine
  hw/ppc: mark 'pseries' as a secure machine
  hw/riscv: mark 'virt' as a secure machine
  hw/s390x: mark 's390x-ccw-virtio' as a secure machine
  hw: mark xenpv, xenpvh, xenfv as secure machines
  hw/nitro: mark 'nitro' machine as secure
  accel/kvm: mark kvm accelerator as secure
  accel/xen: mark xen accelerator as secure
  accel/nitro: mark 'nitro' accelerator as secure

 accel/kvm/kvm-all.c        | 1 +
 accel/nitro/nitro-accel.c  | 1 +
 accel/xen/xen-all.c        | 1 +
 hw/arm/virt.c              | 1 +
 hw/arm/xen-pvh.c           | 1 +
 hw/i386/microvm.c          | 1 +
 hw/i386/pc_piix.c          | 4 ++--
 hw/i386/xen/xen-pvh.c      | 1 +
 hw/loongarch/virt.c        | 1 +
 hw/nitro/machine.c         | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/riscv/virt.c            | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/xenpv/xen_machine_pv.c  | 2 +-
 include/hw/i386/pc.h       | 1 +
 15 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.56.0

