Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124914;
	b=j9FJ1eSfxYAHH0UhTAoL5impAtt+/6Ov4AHDa9xF2anMzXB/O7mw9nNJ503hnHqxJsiF
	 AUkpVou2Oe2hKHjGFz45aIseEZ1qFWo131PVxT9RiMSHcF1eg6CxcnXgvnWWZOioYaG9F
	 FINMEAQov8MiMu/6MQypLRQheuVmDAYMwfiMZLIXQvmdlBWdsPx2AVGQE5VDBC7M1gLdL
	 7Dkx95OL36jMUUFTcUV1uoCxga/w68hp9SaSepyKpuLQrJ3dkBYpwFIuY/fESSlaL//Fp
	 g7UhSbWiuVSr2seOylxhdBkGahDTqMq6+QxuqNtTB4gXwXxRHBRUrpCRfUEY2251mbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124914;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=x0eL0OHLT754EdZ0DXSCF0DHaRsDNV6qcq8Lkd2hMBk=;
	b=CNNwsTcHP/hBU54T8rKHcFkmc7HDUqDvqHBm9gxRXMpvbNOUbbe/EmuMgnrIkoUTaQjW
	 5dfUQEeTTkja45r7d9UU/6fujc2ZClYcsfconpDxwt2KZk0Bv3XG3wHd907ee8u8fgzfE
	 2XGYcRijOteBeS+TmqXkpfRpkE9jKbxVfPp1I/uj5DKUUZO2HQLq1zG3/nNsSFlcsF5oA
	 XORTofOLrHhu8GMZo6bJQper73woSTdJTJwyKj397i9V/R/1mNqRtyBlJo0wCtjNOFlTa
	 4ddbaRe2mE4Pid8o9Rqz4/jWGAsqwy0CYq8s7g7HjB4flx6yd96toDIETbvdNUbl8oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M7kqbwcn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F08606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M7kqbwcn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0eL0OHLT754EdZ0DXSCF0DHaRsDNV6qcq8Lkd2hMBk=;
	b=M7kqbwcnneVKfAoxORzpj2XL4z9McOSNYEVl42hGKut4TEqylvvLzaDnEeLU5Y1tugjxM6
	zgQbYyLmQmGbRPJI7iqsZXGuzwRi8gYe2jGzdoMAPpIhiGSrLwJ8kDbmVRK4W66ZP8GXlE
	UiEC8X/c1Nm1uwKb8Y6/tDFaDAs+UbU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-wPdDHKoBORCP-8DA1EmsCg-1; Tue,
 27 Oct 2026 14:15:09 -0400
X-MC-Unique: wPdDHKoBORCP-8DA1EmsCg-1
X-Mimecast-MFC-AGG-ID: wPdDHKoBORCP-8DA1EmsCg_1793124905
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DEE31956063;
	Tue, 27 Oct 2026 18:15:05 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BF2E18002B1;
	Tue, 27 Oct 2026 18:14:58 +0000 (UTC)
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
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 07/11] hw: mark xenpv, xenpvh, xenfv as secure machines
Date: Tue, 27 Oct 2026 18:13:56 +0000
Message-ID: <20261027181400.1752951-8-berrange@redhat.com>
In-Reply-To: <20261027181400.1752951-1-berrange@redhat.com>
References: <20261027181400.1752951-1-berrange@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The Xen machines are already declared secure in
docs/system/security.rst, due too their intended usage
in virtualization scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/arm/xen-pvh.c          | 1 +
 hw/i386/pc_piix.c         | 4 ++--
 hw/i386/xen/xen-pvh.c     | 1 +
 hw/xenpv/xen_machine_pv.c | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index f05956c1662..6b85eced1bb 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -95,6 +95,7 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
+    .secure = true,
 };
 
 static void xen_arm_machine_register_types(void)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 63c4667ea37..e801325dd6e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -667,6 +667,6 @@ static void xenfv_machine_4_2_options(MachineClass *m)
     m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
-DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_machine_4_2_options);
+DEFINE_SECURE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
+                         xenfv_machine_4_2_options);
 #endif
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index ab90c83a830..d81575b4c9b 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -115,6 +115,7 @@ static const TypeInfo xen_pvh_x86_machine_type = {
     .class_init = xen_pvh_machine_class_init,
     .instance_init = xen_pvh_instance_init,
     .instance_size = sizeof(XenPVHx86State),
+    .secure = true,
 };
 
 static void xen_pvh_machine_register_types(void)
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index c406821c34c..e0620a096ee 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -69,4 +69,4 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->default_machine_opts = "accel=xen";
 }
 
-DEFINE_MACHINE("xenpv", xenpv_machine_init)
+DEFINE_SECURE_MACHINE("xenpv", xenpv_machine_init)
-- 
2.56.0

