Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641522;
	b=uqn4PdA41IX6l062Au3szuHnoWdlEdmoxggsDB0X8RK7ikyl2LBVveiUdJ2fE59oAfdl
	 oTntJhkScsjg5LvMvfnFIflm53Utgcmt4mA6wVi2KaGMaPlwOZm8/TYmRcq+R8jFb/5TQ
	 cwe7P4aqjHSZgC/LB+XgigOxaZAq/OnRpaHVPR1CLBzej4N0Mp7zcW5dlExmkSkawFI4+
	 etgcKOvqbk5XYZ2ixMivLCwtpT2CH3gfRG7UIrKVMEpuqX6wguqW9+kfUtZi2z/XSjjZD
	 DoGIPJJ5SxuqHCYC5i4JviRS+x+zwIc0u5wnLqSKv6BQ4vXrxsAK1WfhhjtwC8ErsGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641522;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=FYhHSLxeTFvAmi4fll8DRpQ9fKphXXLZ5ute33mwd7k=;
	b=tI7do6wwf/2sk+wnV4olAmGm+KQO6kOkkAlG5TzqsbaTMsnAgE+jzwLusPKwsws/vmW0
	 eTlbH7l7itky7ubr0IWGh3Q6d299nCTEs/HZAX79TrSmHtohB8SWLkqo0JYWUOhXnsHIX
	 MsZeemNTYgzZTP5ypYjqDmHtr3+nvEORKujzlUs5eEGtsj75jy8OgtYPzZZBS4IMxs7Nc
	 uv4tUM5G0gAAiXbDKcroI4RNYJKDvfaEBuGAtFRRW2Mj9HXX63LSOV8+e9/AQsLH1GYmW
	 tBrQf3nPyPuWQjTZiM4PFBJsfn7R8KWM5cbYt72mBnm67PTd3dwTaRgW1LV3afq88yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6x7VDHe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A660850B0
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 819A660850B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6x7VDHe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYhHSLxeTFvAmi4fll8DRpQ9fKphXXLZ5ute33mwd7k=;
	b=U6x7VDHe8AoL6q94HeA0MTPF1agVbeUqVHRbqEHikTUA0NXtJZ5wCnU9P+35I+7bILwGMx
	H5dp4AowBurK/r0DOjFM0Vh6X/XZNh0Jf1i/to2kc9gN2cO8ygOwjypPao25PlSWAL2TjK
	z/kpYwu8smw5dNRFad1A21GTnY2mC/Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-3tp-u8AfNVey4uRV42bT0A-1; Mon,
 02 Nov 2026 12:45:17 -0500
X-MC-Unique: 3tp-u8AfNVey4uRV42bT0A-1
X-Mimecast-MFC-AGG-ID: 3tp-u8AfNVey4uRV42bT0A_1793641516
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 591FB195606A;
	Mon,  2 Nov 2026 17:45:16 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D09391956087;
	Mon,  2 Nov 2026 17:45:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 21/45] KVM: Take memory protections into account for __kvm_vcpu_map
Date: Mon,  2 Nov 2026 12:44:48 -0500
Message-ID: <20261102174512.8903-5-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Take into account memory attributes when establishing a long term map
through kvm_vcpu_map()/kvm_vcpu_map_readonly().

Unlike the gfn-to-pfn cache, changes to the attributes will not be
propagated, so that it will be possible to place a nested VMCS, VMCB,
or APIC access page on a non-readable/writable page.  This will be
fixed separately by using a gfn-to-pfn cache for nested virtualization
data structures, in the meanwhile apply a stopgap fix.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-18-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 virt/kvm/kvm_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index de54f52f2158..c7b8d1bcf893 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3302,6 +3302,11 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
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


