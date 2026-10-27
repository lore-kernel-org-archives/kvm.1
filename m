Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124877;
	b=Pjy1i1PklJwB+aHoyNW3ASWIlXdPjtecaVEFgBoAEhvKGyD217nCHwwLoZhbZO5bpC1j
	 mfXFxo4jNN8zZG4q8CqrSJgFEEAm0v82FHeLbvymQHh36kMw/eYqF45UAbaJdFUEzaof4
	 0b8x3DxkVFCBWTI2jUmbU7nVYxr/9f2yESK3PXGsyA4HKk6AgO0wu67HqJeu1tsY2Tnse
	 /Mqe9SYXCIVJZrv89bsO9Fw+Ok92nv1tiLNdqphemqUY+z66us3Q/FzR4OmdhFLSGDtIf
	 RH92Obwhhky/PleUBgjhsZngGrrXCI4INmjU2HU2DHRobT/sfMe52t0uEXFTS3JF+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124877;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=c8HnPQcFtU7MhJRZ/6L5s11AsfWMBibuK6w1Kgqphf8=;
	b=bKXbDw68jToajpJhKbZn6mOcptJRB10v80Ri5Cao5ye/4wAOL8vf7xnKur11ikcGpdpp
	 0kCTNXwoqVC1t3h9R7lWmiiK4eXEbnNePUryzTm1SILHBxakUwck0rrbkfxYEcMFdK9uP
	 XQpS8KZDTVX8iN8MHkOHJPLj7Su1kHF8egJk80pBdmn6ETLd6ScRhC9jsLgfA4NRpa5+v
	 Frg4NPPtweVp5wFgA6uFjnzO4q9bSr32Q49K8Do0vxHopknS9GEYll5L5di/uQciOKdd2
	 KNuqCDCuNJ0G1iA4j3nx29BRH5Njk7utp7Jdfhy0ZrX68woQZWL21SZ0ieknCYLXbTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWbXkW5k;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6FD606A31A
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 18:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E6FD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hWbXkW5k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793124875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8HnPQcFtU7MhJRZ/6L5s11AsfWMBibuK6w1Kgqphf8=;
	b=hWbXkW5kZx8SU/EJ4dFQPQa23RCl3PyA8z6AfoD3j971c5GQC8oOEzPINBnGkIzqmgL+ww
	lbhYrMY9KaL2KKQS+H40/EKRPi+pb+Dgkx66eFk9khkjzOmtG1Hp/+qgZXvsG+Z+x7HSTT
	/RVocpX/sXFmfwZoDaR7k/ymsvn0ouo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-DAvRLKr5NMGyM-khrW0W2g-1; Tue,
 27 Oct 2026 14:14:31 -0400
X-MC-Unique: DAvRLKr5NMGyM-khrW0W2g-1
X-Mimecast-MFC-AGG-ID: DAvRLKr5NMGyM-khrW0W2g_1793124868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DE8C1800747;
	Tue, 27 Oct 2026 18:14:27 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C10C91800586;
	Tue, 27 Oct 2026 18:14:19 +0000 (UTC)
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
Subject: [PATCH 02/11] hw/i386: mark 'microvm', 'i440fx', 'q35' as secure machines
Date: Tue, 27 Oct 2026 18:13:51 +0000
Message-ID: <20261027181400.1752951-3-berrange@redhat.com>
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

The 'microvm', 'i440fx', 'q35' i386 machines are already declared
secure in docs/system/security.rst, due too their intended usage
in virtualization scenarios.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/microvm.c    | 1 +
 include/hw/i386/pc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a49de337497..342aa7a9dd0 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -736,6 +736,7 @@ static const TypeInfo microvm_machine_info = {
     .instance_init = microvm_machine_initfn,
     .class_size    = sizeof(MicrovmMachineClass),
     .class_init    = microvm_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 8edec62a1af..4ac489d2ffa 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -330,6 +330,7 @@ extern const size_t pc_compat_4_1_len;
         .name       = MACHINE_VER_TYPE_NAME(namestr, __VA_ARGS__), \
         .parent     = TYPE_PC_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__), \
+        .secure     = true, \
     }; \
     static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
     { \
-- 
2.56.0

