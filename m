Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600379;
	b=K+KefyymE8nHVG7cwzSYfg5hpLXNgesi9nl8jE6N0zygqQtiKUtOM1z1jdkNdrIDN2VU
	 uobDrlBMiydGbsOpVywVrBzJvTFRjdOkBDdJHAaL53soKUskyNcMd99OKTmSnCLL6kbaf
	 h7kBmsD2QEQV3/PyWxCsf5SdsJ/eCD8AbU/gMJs3GpqOqqO9l+EzAe84m84QjGEW1ISSX
	 9Gj8NKIqVBsaAXoJ6kRAZln1wlNXX6yIpu6s+DAjl6XyCRjmEdECIBd4MghLCHau7LRgZ
	 tVB5s2Vh+jC9uvXhxs/7KjKgE7O2kmG9oVliBouJJBt9y2t6c5rhC2gNQE+n7Wh/fSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600379;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=IZZnczJRu/Z0IH1I/CXcERUjWwZSG/xclOlmPjwrQuE=;
	b=hasQ3lLkNhL/Mvs63hquoWXHHaTJzpdQHChMt5F5QSWYWFAaeYYbX+nXo6RySBQbkTKq
	 FLxzNQpPGFIGeUrFeiuV4vT1q/M36Vh5H9kpmD066WWyVn1O07Elsv2gUM0ei5nmLxSK/
	 npOkPuP67fldkg9lyCc8ITQgl7D0IXcPnoAVrRP1q0NWuWcYELZXqHbcSjshgmm3TUYNC
	 xiv5s2kwg5lyxU+2IXdXlBZv3cJ/rqZlnmvinwbl7rpXitjPmC67V4G2sHwFHevUuufAF
	 2+XsHkqBny/vaKT1eevaqBGOYEqfVgy+NNWsrWtWYEZgd0jm+A0qLMKsXr6RD0z6XQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="dX8/Ifmz";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C7606A322
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 16:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 980C7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dX8/Ifmz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IZZnczJRu/Z0IH1I/CXcERUjWwZSG/xclOlmPjwrQuE=;
	b=dX8/IfmzPZsS7OvDEuQfOlNUmDrruoxXQ1erGa3B9+i3HdUw4hx4Jc4aoOy59v93U0N8jV
	OVZ4hiqftWRAQB0kCiNhfYIfdcypsoOcuFFtGSNf8TbRmH8wifgNSSRONeNaC7FlRsEZsq
	Js3YFee2MKE+JS04VObfUMtxK+xO/Cs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-Uq5iEOvkP4mwMgDGIJoKjA-1; Wed,
 21 Oct 2026 16:32:42 +0000
X-MC-Unique: Uq5iEOvkP4mwMgDGIJoKjA-1
X-Mimecast-MFC-AGG-ID: Uq5iEOvkP4mwMgDGIJoKjA_1792600361
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBFEE180049D;
	Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70C541956087;
	Wed, 21 Oct 2026 16:32:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 424351800912; Wed, 21 Oct 2026 18:32:39 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 00/10] Firmware 20261021 patches
Date: Wed, 21 Oct 2026 18:32:28 +0200
Message-ID: <20261021163239.1131460-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The following changes since commit 8967b2fe1b2aaae3c29e207d85fab901d580a2dc:

  Merge tag 'pull-9p-20261019' of https://github.com/cschoenebeck/qemu into staging (2026-10-20 07:04:06 +0200)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20261021-pull-request

for you to fetch changes up to 966572648f246483b2076149b4fb9d665789409a:

  backends/igvm: fix parameter area entries leak (2026-10-21 18:26:52 +0200)

----------------------------------------------------------------
- igvm: fix policy handling
- igvm: misc minor fixes
- igvm: add command line parameter support
- hw/uefi: fix pkcs7 wrapping typo

----------------------------------------------------------------

Luigi Leonardi (8):
  sev: split set_guest_policy into set_guest_policy and set_id_block
  igvm: move set_id_block call into the SNP ID block directive handler
  i386/sev: convert the guest policy properties to custom accessors
  i386/sev: add a get_guest_policy callback
  igvm/sev: forward the IGVM guest policy to the platform before launch
  backends/igvm: supply an empty device tree when the machine has none
  igvm: add command line parameter support
  docs/system/igvm: document MADT, COMMAND_LINE and DEVICE_TREE
    directives

Martin Pitt (1):
  hw/uefi: fix ContentInfo detection in wrap_pkcs7()

Stefano Garzarella (1):
  backends/igvm: fix parameter area entries leak

 include/system/confidential-guest-support.h |  36 ++--
 include/system/igvm-internal.h              |   8 +-
 backends/confidential-guest-support.c       |  24 ++-
 backends/igvm-cfg.c                         |  21 ++
 backends/igvm.c                             | 159 +++++++++-----
 hw/uefi/var-service-pkcs7.c                 |   2 +-
 target/i386/sev.c                           | 225 +++++++++++++-------
 docs/system/igvm.rst                        |   8 +
 qapi/qom.json                               |   7 +-
 qemu-options.hx                             |   6 +-
 10 files changed, 336 insertions(+), 160 deletions(-)

-- 
2.56.0

