Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124905;
	b=bOzhBnlWRbW0mceXgpdtfcdaqlF4dmZxeRMHDxdMmhZ/s3h/ABhYR5IEwUevKude5ehf
	 KIp5siYWCPkNlGS+q3pMUjF51Y2h45fDI92tQ11+Ti5Z8oJp+bOn5G6+qkoqWmHzuvg+t
	 0QRzjAGEKJeHJmVzhKqna+rA6QBGUVPJg44OhgvqPqqMp4hKyPndWTMTGN5Z9Q9CBam/U
	 E7vWF8Z5gE7wqPRnuEFLTfpE9Cp5eTToLbg7zJU7Y1kPEIs+w1IfKQugPMRhBrkqvHQWO
	 Oit3vjdGweWIthd0i9gRb56tMb3qSOj9jPkeDIfSxsucg1pKCcYkNxP1SCev1/j56og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124905;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=SjzJ86NcoOOpiqoXBZbehS0Nmy6hg8V1H9Fb+oCNfGQ=;
	b=wuTycwtxH51IXL6T4tMuYWEnJVOBNjGiFujJdQuiECMP/fHfwDIcaDyIuw4DQHTc7Kvt
	 anTRpinsb9YZvqucXF7GosB5/COe069y8DytKdhkJTUEftrVmXWO6oqG1xYRGhVmYF6SS
	 61Ir2WU0yvRQjAvj9qJ/c7LA+BM7PiTwhKm2pjVvu0p7DSa9NRx8Cy8dj1FtX8e4TAnaL
	 Hj8Z6gCWqGJjtOMPx25dKSN63+xI+0dMGoW2y8hETqkdbFP7Bfif8Goy34Bx0pmXtCGP8
	 MK1/QVk/xJ/+qUwUSJZ74oS6//wa/pwl7O4inlpsqqpXqVhxqsXyOFVMNvSNBt6yLcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSPSQGwV;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9723606A31F
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9723606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSPSQGwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjzJ86NcoOOpiqoXBZbehS0Nmy6hg8V1H9Fb+oCNfGQ=;
	b=HSPSQGwVwikI9pH7DqIeGZ14irmSABDUaV6pMOZ3Nkz/8aleL09bgZ8SJ8UBQ6hItCAi7h
	DIyvMmOWGyJIfwo1NZOykqTtYUbHNqhXcCKM43IgGGH+K3mnrpZsQ/lR/HFwdO0KpaRaVh
	McPR+1G5Bf+lS0AB8x1ZemkZ7OmCecI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-6LQe5KMvNl2nCJ5O0yFuYg-1; Tue,
 27 Oct 2026 14:15:01 -0400
X-MC-Unique: 6LQe5KMvNl2nCJ5O0yFuYg-1
X-Mimecast-MFC-AGG-ID: 6LQe5KMvNl2nCJ5O0yFuYg_1793124898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ACCB18052C5;
	Tue, 27 Oct 2026 18:14:58 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2AFAB18005B4;
	Tue, 27 Oct 2026 18:14:51 +0000 (UTC)
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
Subject: [PATCH 06/11] hw/s390x: mark 's390x-ccw-virtio' as a secure machine
Date: Tue, 27 Oct 2026 18:13:55 +0000
Message-ID: <20261027181400.1752951-7-berrange@redhat.com>
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

The 's390x-ccw-virtio' s390x machine is already declared secure in
docs/system/security.rst, due too its intended usage in virtualization
scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fda5ecc9ad3..15b16ba99d0 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -986,6 +986,7 @@ static const TypeInfo ccw_machine_info = {
         .name = MACHINE_VER_TYPE_NAME("s390-ccw-virtio", __VA_ARGS__),        \
         .parent = TYPE_S390_CCW_MACHINE,                                      \
         .class_init = MACHINE_VER_SYM(class_init, ccw, __VA_ARGS__),          \
+        .secure = true,                                                       \
     };                                                                        \
     static void MACHINE_VER_SYM(register, ccw, __VA_ARGS__)(void)             \
     {                                                                         \
-- 
2.56.0

