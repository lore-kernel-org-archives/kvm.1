Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770083;
	b=TKra0HfyiQSAfiQ7vd4hIZMHTvJDKE+tiI4Q4kZ0TriUdTf15Ktz2lJT1NFKjJfWN3S1
	 /e1RhqSDEMc/4bJcQyHHrkYqLMGJC4zohAjADCeh/LzOpWg4sBk9W/aVWjw7QlLySKosD
	 t2nPyMkD8pSD+5v8ouqOweu1VGqO8NERH0ZPlcpbhbWI8bCiRQN0NQe6QiMDFxZSXTPk7
	 txAW6dQz4I2Mo3dZlvuK/B+YodR/xjy0VX1I6yvP0ZlY6fdGSduCuIrMBCL31ld/l4Ckh
	 s258iLv8+n9a3TKouZRKNbij5RiMzzQH9eN00j72Dzst47uuwpEKrGK/rLbxH5jHrvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770083;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=P25Y7uzPXrVGItwrCetIL9bJnrg+CXL7WnvX0Dbcdys=;
	b=A7gZhmyMExfdforhpHdaPGm03g79/ELWIUn2PMkTQPYNdjlNeEqooWR/J243cpET6xuB
	 5FGHCQMyVfnxY37EsiuRRmydRYg/2M9o8KYlQgoDLh2vE1ZRDnGBJ6XCYg6256QSAD2MW
	 7EW+y51AsnchlACnJ0Md1KU52GuC5rJngkHoqJO3VqD6Df27RrEA7va3zxEzc0NOF6VOA
	 skEKQzOSDhwpK9vmNyISxg9fgYSZ103Jo6P9ov5G/EI4uX1IBmA058f52j5Rfjl56ywAL
	 Im2yHSc2hgjM0BA2NfZez9Qss1Alk02ielCwU2yVZfSXPMadBjqHhTKVZcqcK+rcVBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIm2o2xv;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87917606A680
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 09:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87917606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UIm2o2xv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795770081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P25Y7uzPXrVGItwrCetIL9bJnrg+CXL7WnvX0Dbcdys=;
	b=UIm2o2xv5xVADz/QzfngY4oYgDk8gZDhyv5Bd11KpmQqLd/emckCNeFcKyPjL6M4oGLCV3
	nozUN6YzhutuVFvR6w4eOussU9eXs/FT+9TNwbRrcAij1vTtWb215FSf7uYRbqXoIoeFF0
	fQHat5YUSMhxXVwiUd87F2RewIiNQ4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-OPIqrw-1MnGGXVGANb3qRw-1; Fri,
 27 Nov 2026 09:01:18 +0000
X-MC-Unique: OPIqrw-1MnGGXVGANb3qRw-1
X-Mimecast-MFC-AGG-ID: OPIqrw-1MnGGXVGANb3qRw_1795770077
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F05A19560AA
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 09:01:17 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3CD01956049
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 09:01:16 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests] x86/run: clean up test device detection
Date: Fri, 27 Nov 2026 10:01:15 +0100
Message-ID: <20261127090115.2408921-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Drop support for the old testdev device, and unify the pc_testdev and pci_testdev
variables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/run | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/x86/run b/x86/run
index a68d469d..7d4792b7 100755
--- a/x86/run
+++ b/x86/run
@@ -15,34 +15,34 @@ set_qemu_accelerator || exit $?
 qemu=$(search_qemu_binary) ||
 	exit $?
 
-if ! ${qemu} -device '?' 2>&1 | grep -F -e \"testdev\" -e \"pc-testdev\" > /dev/null;
+if
+	! ${qemu} -device '?' 2>&1 | grep -F \"pc-testdev\" > /dev/null;
 then
-    echo "No Qemu test device support found"
-    exit 2
+	echo "pc-testdev device not found"
+	exit 2
 fi
 
 if
-	${qemu} -device '?' 2>&1 | grep -F "pci-testdev" > /dev/null;
+	! ${qemu} -device '?' 2>&1 | grep -F \"isa-debug-exit\" > /dev/null;
 then
-	pci_testdev="-device pci-testdev"
-else
-	pci_testdev=""
+	echo "isa-debug-exit device not found"
+	exit 2
 fi
 
+testdev="-device pc-testdev -device isa-debug-exit,iobase=0xf4,iosize=0x4"
 if
-	${qemu} -device '?' 2>&1 | grep -F "pc-testdev" > /dev/null;
+	${qemu} -device '?' 2>&1 | grep -F \"pci-testdev\" > /dev/null;
 then
-	pc_testdev="-device pc-testdev -device isa-debug-exit,iobase=0xf4,iosize=0x4"
-else
-	pc_testdev="-device testdev,chardev=testlog -chardev file,id=testlog,path=msr.out"
+	testdev+=" -device pci-testdev"
 fi
 
+
 # Discard lost ticks from the Programmable Interval Timer (PIT, a.k.a 8254), as
 # enabling KVM's re-injection mode inhibits (x2)AVIC, i.e. prevents validating
 # (x2)AVIC.  Note, the realmode test relies on the PIT, but not re-injection.
 pit="-global kvm-pit.lost_tick_policy=discard"
 
-command="${qemu} --no-reboot -nodefaults $pit $pc_testdev -display none -serial stdio $pci_testdev"
+command="${qemu} --no-reboot -nodefaults $pit $testdev -display none -serial stdio"
 command+=" -accel $ACCEL$ACCEL_PROPS"
 if [ "${CONFIG_EFI}" != y ]; then
 	command+=" -kernel"
-- 
2.56.1

