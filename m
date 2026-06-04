Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F240B6EE
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780589264; cv=none; b=IrO808VGMKZgE33DslJ5Y0xCdzQc8KqNsPM+UfsIZkwDPtAFzgkPtcg1CRhDuIv20hmj8xjHu3n/wkU1NnH1NTXzTKVS/eC99wr6ZY72db/wcvxjmbUqxNVco4m/wVGOfFYtR9J8VYpUncOk5WnsKxJgIUbawkUuc8tg3PX1y34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780589264; c=relaxed/simple;
	bh=qmYmEfVd0jiFrAfzy3ueq9gyyCGiz4HjVS1qGb0zAVc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uygf8SXpzFu19/DoXgKNdNsdw1AACk8QBhVaXBX6KQQZM4BJyiIdB2Sz7BIom5RGYGjcfcsarIS34q9TYVT3ek63MIqLkKBY/XUG44OI19un2+CGeupJTrY+R8Tqis+eRlFZm5uZjwpXiyG0X2Zcz4Ot2IVaCVeV80s3UQ7BEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AuKs065O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuKs065O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780589259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FuFO8WB7VeQw2FVZURsckB2c0qZDblvoRDfdsET3A2s=;
	b=AuKs065OoomRGR91+YN3SCGTIsvNAgmf00+oHPNsqKWaeW4Jtsv7fsNMZnVUJsc/dX/LYl
	3GcFIDgPqJ20y+LzRvIv48EO0zwYyZ5lq4Xyc6nheeZOVYELNqf81hqkNSSrHBa0dEkNV3
	cwi9idzgkTriaHQ0jZ2Jeo4CugZcG9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-Imrwd1MTNUGbm3ZQfWwPIQ-1; Thu,
 04 Jun 2026 12:07:35 -0400
X-MC-Unique: Imrwd1MTNUGbm3ZQfWwPIQ-1
X-Mimecast-MFC-AGG-ID: Imrwd1MTNUGbm3ZQfWwPIQ_1780589254
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B2C5180034E;
	Thu,  4 Jun 2026 16:07:34 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 346F51800361;
	Thu,  4 Jun 2026 16:07:34 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/3] KVM: harden and cleanup PDPTR load on forced L1 reload
Date: Thu,  4 Jun 2026 12:07:30 -0400
Message-ID: <20260604160733.12555-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Nested VMX tries to detect all possible VMFail cases before committing
to execute VMLAUNCH/VMRESUME, because the steps leading to the VMCS02
VM entry need to load various bits of the L2 processor state into
KVM's software model (vcpu->arch, essentially).

However, there are cases that are not caught or in some cases even
racy because the data comes from memory rather than from the VMCS;
in that case the earlier load of L2 state needs to be unwound, and
nested_vmx_restore_host_state() exists for that purpose.  Sashiko
found a hole where L1's CR3 is restored there upon a VM-Entry failure,
but the PDPTRs are only restored if EPT is enabled. If shadow paging
is used, the L2 PDPTRs from the aborted entry attempt will remain in
vcpu->arch.root_mmu->pdptrs.

Fix this by forcing use of nested_vmx_load_cr3(), in the same guise
as load_vmcs12_host_state().

The other two patches are respectively another minor
hardening/clarification, and a small optimization.

Paolo Bonzini (3):
  KVM: nVMX: unwind PDPTR load if processor triggers a nested VMFail
  KVM: MMU: unconditionally clear MMIO cache on root rebuild
  KVM: nVMX: remove unnecessary unload on processor-detected VMFail

 arch/x86/kvm/mmu/mmu.c    |  1 +
 arch/x86/kvm/vmx/nested.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.52.0

