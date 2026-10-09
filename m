Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCCF3DE43D
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791579053; cv=none; b=STjNylNvypJDCinYwO5GZr1Ek0PFkO7m/GUqeCERPug2shVhdJ7Cq+Cl6uIOp0v/RO+rdYWoI9ZDPnbAdcAqkufvPli3bCCyod1dAT3unLUrfA2ynO9pO0mxzzWhBywX0OvZHGarsM6pTV99mZzAMDGHI8n7J4JCuGvpGzjoGoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791579053; c=relaxed/simple;
	bh=gcpgAAlstUAea7MeoephBSM8C3AiipGF3t9WWqRAKes=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cbr4buG1bo++A5PC2YBtw7m1BnjSbjIjWJk3qgAV29o47ppAKPDGAXnB1VapRvq6CY1n/jQag9oBXlqCiOERPDuZfYXcpy523LS5Uwd0lvXCEGf+IhE3vQJcdmYCrME0CEzdcq22ysdLQBQQkQIclb1h0fJ1vgC0Wkyna4Xh2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yza0Lu1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yza0Lu1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791579047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h6V5Kq3HUV5oYb9OPFBcxaJZjH3kjttdL3dZebuSKks=;
	b=Yza0Lu1ao8IMEK9B0YiWMuQtLHFnd+J4PESFiOfIhsahaD1yhf46LVno0w3fvx4AOyYCP/
	Yr78OVvHfdsUg1x3rKFkzFb4NWT8RuoL+xP/JWYUUoC/+RO8nItKgRgMLIacpGn10LwNb2
	b7y5Jyu5CVR4HS6HzrN9nviKgo47Wr8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-dbbTl_wsOcu36Honji-mOw-1; Fri,
 9 Oct 2026 20:50:39 +0000
X-MC-Unique: dbbTl_wsOcu36Honji-mOw-1
X-Mimecast-MFC-AGG-ID: dbbTl_wsOcu36Honji-mOw_1791579038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B15CE1843AD4;
	Fri,  9 Oct 2026 20:50:38 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99B6118004D4;
	Fri,  9 Oct 2026 20:50:37 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 0/2] KVM: nVMX: fix nested APICv emulation for windows guests
Date: Fri,  9 Oct 2026 16:50:34 -0400
Message-ID: <20261009205036.672523-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix two problems that were recently discovered that cause nested APICv=0D
to malfunction on windows with hyperv enabled.=0D
=0D
The first problem is that unlike KVM, windows doesn't set PIR.ON when=0D
sending posted interrupts. X86 spec actually allows this.=0D
=0D
The second problem is that unlilke KVM, which mostly ignores them,=0D
windows depends on accurate delivery of the posted notification=0D
interrupts, even when those miss the guest.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  KVM: nVMX: don't check PIR.ON when processing nested posted interrupts=0D
  KVM: nVMX: avoid losing the posted notification interrupt when exiting=0D
    L2=0D
=0D
 arch/x86/kvm/vmx/nested.c | 20 +++++++++++++++-----=0D
 1 file changed, 15 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.54.0=0D
=0D

