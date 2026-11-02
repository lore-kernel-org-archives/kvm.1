Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641296;
	b=D/60XPy0D+q7EGSU1vp76vlDog7MOfE2RuPJzo1ro9qQ8bt/DpP31d4exejSo4qkG7tP
	 wvfEqEHGxxXzV0lx+/36vYJt45bYWa0xayHQLDGiOQTa9jWdAXuQqpZGyKthg76E7/H+t
	 yr4o+Zfz4cjVfmz7FBL4S14KWrpDpryIr1HUYWj91jYzirCcraWqpdeb7hqoH+HOeaCRY
	 rNVTi4w4ip0Mbc3Vt8H8GiulYwbn2kROoBlCESXHq7QQX0RzlutfCOwKNz5/0AdOJljZA
	 g4MHds8jchdl6PJ7ekd9AvKZM2tnjUwLnU8Dnc9lHPyu4Mom03W0Uugue5g2PAmJazw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641296;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=p3IG+nUKXuxbgUw7WUKWXDkB6yF68LxYxq24wEK1Vhs=;
	b=xzjBWy3n5YHMk4agQSO3knZewFBX67drrG0Wi47fdwP/XE1arkpNawjo17frFTp4f8ew
	 0ie2bcNDLzBRY41F434oodXVXcQuDz5XmXWKAXf0zHIO353/T3ZflbBV0oW263L45Nt1u
	 aLIIJpoFs7wuRx1Bla94ZtDEfUj+ZGW/OW4YSB/ywtm4khWolHBDPs+WJ3XgS6vw0wKIm
	 alNV1BROKDn8LLtp9yj2sadC/yUOb1DVI8r+jYuxDQ83Ze4hLB8OXWVK7gGnvfgTiKhpR
	 TT2CGgcvqBusGr3NYpzi2RyUBc74PvYZUDr9j4NqeipNML88FkLIyCQ6ow97HfoXXvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mc2IsVb6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E50607039F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17E50607039F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mc2IsVb6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3IG+nUKXuxbgUw7WUKWXDkB6yF68LxYxq24wEK1Vhs=;
	b=Mc2IsVb6U4KI03CHFEot29RF1wXIRA7zeFczYm+JIM4BWFeF9DDTObKmyg4GAp0nz2JQWx
	QNTOreCzuiNDEyMzhDiH7uIZTDFTwDGpu8JJdTBzNOQgNxsTzZckH8hwyLoP1ftAHOAUoQ
	+a3iNEn+F+Rd+aTYH8zubQSP7bogjeI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-v6qnrRePOlq3c2cpy7KUCQ-1; Mon,
 02 Nov 2026 12:41:34 -0500
X-MC-Unique: v6qnrRePOlq3c2cpy7KUCQ-1
X-Mimecast-MFC-AGG-ID: v6qnrRePOlq3c2cpy7KUCQ_1793641293
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F35A41955DE8;
	Mon,  2 Nov 2026 17:41:32 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 95D3A30000E3;
	Mon,  2 Nov 2026 17:41:32 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 03/45] KVM: x86: apply nGPA->GPA translation to KVM_HC_CLOCK_PAIRING
Date: Mon,  2 Nov 2026 12:40:47 -0500
Message-ID: <20261102174130.8779-4-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

KVM_HC_CLOCK_PAIRING writes to a guest physical addresses.  Treat it
as an L2 address when running nested, which is consistent with the
Hyper-V TLB flush hypercalls for example.

This is technically backwards incompatible, but it should be extremely
unlikely to happen in the wild and thus we can treat it as a bugfix, I think.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-6-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..ec151374ca9e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7256,8 +7256,8 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 {
 	struct kvm_clock_pairing clock_pairing;
 	struct timespec64 ts;
+	size_t offset = 0;
 	u64 cycle;
-	int ret;
 
 	if (clock_type != KVM_CLOCK_PAIRING_WALLCLOCK)
 		return -KVM_EOPNOTSUPP;
@@ -7278,12 +7278,20 @@ static int kvm_pv_clock_pairing(struct kvm_vcpu *vcpu, gpa_t paddr,
 	clock_pairing.flags = 0;
 	memset(&clock_pairing.pad, 0, sizeof(clock_pairing.pad));
 
-	ret = 0;
-	if (kvm_write_guest(vcpu->kvm, paddr, &clock_pairing,
-			    sizeof(struct kvm_clock_pairing)))
-		ret = -KVM_EFAULT;
+	while (offset < sizeof(clock_pairing)) {
+		gpa_t gpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, paddr + offset,
+					      PFERR_WRITE_MASK | PFERR_GUEST_FINAL_MASK, NULL, 0);
+		size_t len = min_t(size_t, sizeof(clock_pairing) - offset,
+				   PAGE_SIZE - offset_in_page(gpa));
 
-	return ret;
+		if (gpa == INVALID_GPA)
+			return -KVM_EFAULT;
+		if (kvm_write_guest(vcpu->kvm, gpa, (u8 *)&clock_pairing + offset, len))
+			return -KVM_EFAULT;
+
+		offset += len;
+	}
+	return 0;
 }
 #endif
 
-- 
2.52.0


