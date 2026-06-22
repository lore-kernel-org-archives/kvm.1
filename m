Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74E439934C
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127651; cv=none; b=s9CewowDOUJITm+XPQyvPkM+kymL04Fo/lcZ5d2kP2DDuuJTnss1hrXko1XOGGUpk4w+kdrHQv0TWkq9x464tLP3xv/BsDKeLVr1mF0ja0kdplY26fmSuR5s2MDoaE9MFyujdaVFjXMdxwR+FWDUfcJyK7HnQ97i6qdFbtukT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127651; c=relaxed/simple;
	bh=k+7jP4Wkx2qr4mIR7Ae+mlnckzUKMGMrYgw4vX7F7jk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qCInNc/QttgBuwdvJwwk1+tJvlpNOAc95aGO828zIuFCOeVkR8pbzBCPFbnwLoY8pLDkwxoQE26npeXe7Af5Wmc5CH5Bwy6mc+pcqkqSeiUbvpGapIepphB/7a9RLgpg/5pSBU28o3CaaqHetKWL7KhMewjNNaO/+4VfeCZE4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VahgoLpv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VahgoLpv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782127648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OvGuH7JqOKs8Gs5wGx/+vNIcyLyxFDaqn5May/oeVNs=;
	b=VahgoLpvYWYaNTXrJyMV/INPB+IutuPBcOg4txvlKIsJ+UgI56vIQP8aFtvnslG3R++IF0
	vDvYr3BegJaMYocAPvwXptvAzJqiahVwrTOVS1fTBpVj5H1CYpqFL1Q0SewWAlcSNGe3mF
	S84jsJk6evDvY0DHSu4WmLry03JfSuk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-BIbqxOxcP2CptuCzFez5zw-1; Mon,
 22 Jun 2026 07:27:27 -0400
X-MC-Unique: BIbqxOxcP2CptuCzFez5zw-1
X-Mimecast-MFC-AGG-ID: BIbqxOxcP2CptuCzFez5zw_1782127646
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60D871956067
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:27:26 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11763195394F
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 11:27:25 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Subject: [PATCH kvm-unit-tests] svm_tests: replace rdpru with byte encoding
Date: Mon, 22 Jun 2026 07:27:25 -0400
Message-ID: <20260622112725.40348-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 06eba51b..ccbab1d0 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -3652,7 +3652,7 @@ asm(
 	"insn_rdtscp: rdtscp;ret\n\t"
 	"insn_skinit: skinit;ret\n\t"
 	"insn_xsetbv: xor %eax, %eax; xor %edx, %edx; xor %ecx, %ecx; xsetbv;ret\n\t"
-	"insn_rdpru: xor %ecx, %ecx; rdpru;ret\n\t"
+	"insn_rdpru: xor %ecx, %ecx; .byte 0x0f,0x01,0xfd;ret\n\t"
 	"insn_invpcid: xor %eax, %eax; invpcid desc, %rax;ret\n\t"
 );
 
-- 
2.52.0

