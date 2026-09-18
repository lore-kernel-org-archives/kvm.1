Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F150C282
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739452; cv=none; b=dEq9kLn1EqKVTPThPTxSOKJ2iOXXfQ7APZQoxKy5QpWnAThIiVmMrkQGw0ksSPPil4wUVXGNYYBr86MhDYIRbc4wKH5FA1dvLLAf8vRrNcZjUXmafF1VnyG4mGf+Wsxa+Fa5MS/fzoDVZ1SSkc45KNSSE4Scn085ItRMkBPn1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739452; c=relaxed/simple;
	bh=bR9sKgYx+hoGl1ylg913WnYRmrSjcmjf4NRmMpS8YA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bF3wkkMNOdXjQQ4AUDceAwjXcAzoR77d6UG8zmAUWSWNu0Jg4tymkIEn/NFUxNiVloGCk80xQHQnxHaSv2hHJzzELsiTkOiiMG5/yg6LLOqHoMntcEAY2boJAwHt2nS1Wr4LbogOSXiWe/E3S6GUUEho7xYx3EMVgEbjXTDTtMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6m6P2MG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6m6P2MG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789739449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9taFNI3W/Tp21bOuKmeDxG1fnNSllKmxOsZqcqoycyo=;
	b=H6m6P2MGkhkQBPBMl+PNjR2JBcn5/PQFrfeF6MEyzCqPaZm6n2vZDXxshtnvaR6Hw53Asc
	FwXmIpQCO5d87A2e8q3IBCyfjSTQchus4D2uNe9o/b7RjDadccBAa4uLb71TfFi+oEhOkt
	uhn/epuU41iXCQyCgzy2kTQUAYzPB84=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-jhJl374dMHmTvxNWeNTOkg-1; Fri,
 18 Sep 2026 09:50:48 -0400
X-MC-Unique: jhJl374dMHmTvxNWeNTOkg-1
X-Mimecast-MFC-AGG-ID: jhJl374dMHmTvxNWeNTOkg_1789739447
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 401EB1944E40;
	Fri, 18 Sep 2026 13:50:47 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D963433;
	Fri, 18 Sep 2026 13:50:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH 17/31] KVM: Take memory protections into account for __kvm_vcpu_map
Date: Fri, 18 Sep 2026 09:50:16 -0400
Message-ID: <20260918135030.171564-18-pbonzini@redhat.com>
In-Reply-To: <20260918135030.171564-1-pbonzini@redhat.com>
References: <20260918135030.171564-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Take into account memory attributes when establishing a long term map
through kvm_vcpu_map()/kvm_vcpu_map_readonly().

Unlike the gfn-to-pfn cache, changes to the attributes will not be
propagated, so that it will be possible to place a nested VMCS, VMCB,
or APIC access page on a non-readable/writable page.  This will be
fixed separately by using a gfn-to-pfn cache for nested virtualization
data structures, in the meanwhile apply a stopgap fix.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index acf09059a1cd..1d111502b8c1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3193,6 +3193,11 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 	if (WARN_ON_ONCE(map->hva))
 		kvm_vcpu_unmap(vcpu, map);
 
+	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
+		return -EFAULT;
+	if (writable && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+		return -EFAULT;
+
 	map->pinned_page = NULL;
 	map->page = NULL;
 	map->hva = NULL;
-- 
2.52.0


