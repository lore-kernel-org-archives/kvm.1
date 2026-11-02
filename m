Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641531;
	b=AJqQIZGKzi07XpvijzNt2hBzWqR/J+yxVc78DKMhG4EWDY29K+LOdFzPmcb3cgXyy6uM
	 5HS43abCTM7kC/2Fk9FzEr3H7ZReoWHwgCY3cBB0NhTjmrv9pl2F9TCJagjcMe4vaC4AS
	 OY0lr8kPW2nmY1t6+WBsk7VpZSmLnh53fEPJmAxOogYI0MRkmGxI14qOHZYgoCg3pGbRI
	 DpfQBom+wr/f5iJhH/wcWeFx7hOXlLnvAUJcP9U9l56aJTB/k9avIbc4iSQfq6TY6pIMq
	 v59wTlOOxTJV+oYZO2FmXUrCHDs1HB/HVvXSJWT8sWAJU1tXRz2obEDG1VxiogyKptw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641531;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Y6no/JVsXMyaF2S1vCkMXnFSBxc9Aomb7dY+A82TzLk=;
	b=O+wds+lazIRafqluilIk2zKuOVSu1rY0ISy2bo8GxF/E2bEJGI2LaqPUMTijHb4fHYYz
	 8+89QlJIRBooE/ObwjB1JLiyIwRbcim7JLszq37VMWWielB9mxl+m4p5FbhYQuN208Z5n
	 0PMwbGyCmUlzupmzQpReI+vr/CazNiwu05UDjy01oreOJhm8j77jk1/hRtIQLDsRh7M9y
	 jUbAkoespkpywbJLYwkq2txYMShuyHuISMI9UKdo0Ggi4PEUW1lpfb+v+NtFKJ4SJUZJ0
	 UiLzBWwwS7hZcNDY7FGfO+/D0zlyqIG2r2WWTNgzBYVWcZhi/Oy0NpkutZlxwLQJYjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSh7B8bb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636660B33D9
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5636660B33D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSh7B8bb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6no/JVsXMyaF2S1vCkMXnFSBxc9Aomb7dY+A82TzLk=;
	b=XSh7B8bb7/PP15o5ZXQb/NeKAXEz/Hyu0Jgd4dWd7+44tMe98NBuuA8+a2+DQoLy+jY8ED
	eNl/A/EMWBF8yrMKaW4dgY5iwcDtTBsie7aUv8IEYaKBX4Ukrh1TYiMO6JCHN+YYndh6v7
	6tKIt0BP+a/7Tx0ghZG5UHOTE83f+gk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-FMWvH6nDN_2EH_YxlK7FMQ-1; Mon,
 02 Nov 2026 12:45:29 -0500
X-MC-Unique: FMWvH6nDN_2EH_YxlK7FMQ-1
X-Mimecast-MFC-AGG-ID: FMWvH6nDN_2EH_YxlK7FMQ_1793641528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 097331800610;
	Mon,  2 Nov 2026 17:45:28 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 80DD2180057F;
	Mon,  2 Nov 2026 17:45:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 38/45] KVM: x86: mark VM as dead after KVM_SET_SREGS fails to load PDPTRs
Date: Mon,  2 Nov 2026 12:45:05 -0500
Message-ID: <20261102174512.8903-22-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If loading PDPTRs from guest memory fails, the KVM_SET_SREGS ioctl
returns before resetting the MMU context and with stale PDPTRs.  Mark the
VM dead on the error path, so that the vCPU cannot run with inconsistent
state; userspace should anyway use KVM_SET_SREGS2, which provides the
cached PDPTRs and avoids the guest-memory read.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index b7c25b16ffca..3a11a6d06889 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -634,6 +634,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 			r = load_pdptrs(vcpu, kvm_read_cr3(vcpu));
 			if (r < 0) {
 				srcu_read_unlock(&vcpu->kvm->srcu, idx);
+				kvm_vm_dead(vcpu->kvm);
 				return r;
 			}
 			*mmu_reset_needed = 1;
-- 
2.52.0


