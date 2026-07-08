Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5237DE8C
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 13:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517959; cv=none; b=uCxykiR9JnMyI/J3ZaN7yTIzH8SVhtSITOxO5zGK0n3bXpWshhsEQFnD5r2r+PBvoC6GYWC7EQNl68QOThIL2oBwNc0F/5Sos3DgjFwhJBU+8gZ+3VNAsV01UDO66mTDnpHI7L04ZuXzp2+P6RioWEZV1WQj9eVmvFyTFIzFrT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517959; c=relaxed/simple;
	bh=/0g+Y4wPFerm9mXGe154aQarap2+uauds1ZHfE+SLQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxC/BpdBiVCqEG3vQ+2/RjRFAOietFrvetr2VjE4jMK6F1wSPeKo+iymjmGNXWfDc/pUPtf+4eYiFh6/Xt8XNO4FBeFnQLcfjO4RQqS+cOWrxg/apfIwcSfPk9aJN8NZFcwUuMCury3zRpsb91FW1QauwmzxicEuSGGzFVJPbjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8w2Wv3j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8w2Wv3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783517956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ECVWxNUMUUQjHTObpd3YI7AQD/uZ8AjllXMw0PpKKdE=;
	b=H8w2Wv3jgzVvf6oG1iZ2uwA9Z0JwJ2IPFTDo/jcgrwSvKPjId+t1WndwteUH5EZ1C6t7tL
	hDcSbUGC610PBY67LLB3MCz+mJJACd6DiHua8hbvpJefFfmfp1YRYzGiDans+tRUKan5RZ
	EEeu5MgSBPR5zV2a0fXa2XQGAyzadU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-VvKfb93-PWWDpygkYNfy2Q-1; Wed,
 08 Jul 2026 09:39:13 -0400
X-MC-Unique: VvKfb93-PWWDpygkYNfy2Q-1
X-Mimecast-MFC-AGG-ID: VvKfb93-PWWDpygkYNfy2Q_1783517951
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED33018005B1;
	Wed,  8 Jul 2026 13:39:10 +0000 (UTC)
Received: from work.fritz.box (unknown [10.44.49.159])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71BA03000C13;
	Wed,  8 Jul 2026 13:39:08 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v2 0/2] KVM: x86: Document APIC base memory hole constraint
Date: Wed,  8 Jul 2026 15:38:53 +0200
Message-ID: <20260708133856.302151-1-twiederh@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When virtual APIC access acceleration is enabled on x86 (APICv on
Intel, AVIC on AMD), vcpu creation installs a private memory slot at
the default APIC base address (0xfee00000).  If user space maps a
memory region covering that address, vcpu creation fails with -EEXIST.
This is not documented and very puzzling when it happens.

This series documents two undocumented constraints:

  1/2  KVM_CREATE_IRQCHIP must precede vcpu creation
  2/2  APIC base address memory hole when APIC acceleration is enabled

Thanks to Sean Christopherson for the thorough review of v1.

Changes since v1:
  - Dropped enforcement patches (3/4, 4/4) per review feedback.
  - Patch 1/2: Reworded to avoid implying that KVM_CREATE_IRQCHIP is
    mandatory.
  - Patch 2/2: Reworded to reflect that the APIC access page is not
    installed in every case. Added note about KVM_CAP_SPLIT_IRQCHIP
    having the same constraint.

v1: https://lore.kernel.org/kvm/20260706092021.3625908-2-twiederh@redhat.com/

Tim Wiederhake (2):
  KVM: x86: Document that KVM_CREATE_IRQCHIP must precede vcpu creation
  KVM: x86: Document APIC base address constraint for in-kernel irqchip

 Documentation/virt/kvm/api.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

-- 
2.52.0

