Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883C1DFDA1
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380464; cv=none; b=Cc0nf7wicniz3rCYr7I8qUGkuqkewyqKFejea1vn5GSQzfDuB6Cmou82ZK5EFKzRpaIQiEhmifZS2M7BRFdAf3rsE41HWGHyMhP6dfKuH6hjVcm6PusABPpSszQfZDNpqAhNiA6O4zXPHitFN+98hXoef71yTBfq55FeiQ8ySyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380464; c=relaxed/simple;
	bh=wb7HPBDPSpx+mGLdMWhQV+4kVRyovx+6gKSHSxAs0DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKZT/neEQrLCMd4LHTLVwHWAnoOYPJV1yzbpA7MvvpND0oAPs0BtYIvYMqNqkoVPrMWQOs1TXAZ9G0tAl/0ExUDgyIKya/HXa9rhsY/w781R7nZXkmI4kY6U025FJi0y9FiKkwGtVT7MBYXMV2Ebq+Bj4xM9nAmEQ1GAMjaN1QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFDshsgR; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFDshsgR"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1397e093f90so5823365c88.1
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782380461; x=1782985261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T8vdi+ZUIaeli2i9PAq6D3r0lDeMc1uAtGUUn4rxcQE=;
        b=RFDshsgRsvEqSYpELifB96Hb5v03ud6/WG63HODN/fTeLkVAdvC9cuCeqnXmP/vyzy
         6+gOEUT1qwV6Bo5hlINzWrPfu0ugyanl9eeXCx9g6jAC0rt9wKM7adiKZzyIRxePCz7u
         iL3ouWsczGHuVWWGc/ZMQXI+gtJY6+USgK8sJMAFKK/hnDvYEbcZfdeDqXOniEvR/a1S
         eM+RbYfN6F7RgKnqB9Fii/a/o1GMUy27Da4R5HXPWiN2keCoB26Ew9Z8SwxhIioZvXTz
         Qj5/5P2HXDM45du6DWO9mfhquLKautpklCVQnIpMmzRWU0+zMJwHC53NBfv6ndo3TL1T
         0AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380461; x=1782985261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8vdi+ZUIaeli2i9PAq6D3r0lDeMc1uAtGUUn4rxcQE=;
        b=Eqv9+ykSBD7V0UJfVKV/s1SgGwNWxrTW+nDf/D+ca5CQ3t/kI45E5qbpRCX3D6EImX
         NWyrPVQNavomo4Zip/6/6bOBc5oyOu/bnEcRY6aH8ZlY1MFk00Jn082IDnzRA+SLzmZb
         KfUfDspUSxk1ix+gNTSTiVdH08k8JCYGD5/CuGiQOIWJu1Le5tsxXCjptgPN5nAiix4a
         oKfVMuIexbXc2lcqd2oPJwIf6C6LxChPJHAVRKkK8WWvi8vmg9MDdWeNWQaa58NWrlo1
         caZxpNDMGcJVjAUrNu8rzMNwuuykGfyiuoogYqrCj0hLrb5XUYmmN1NwYIffOZZOgJUm
         L09g==
X-Forwarded-Encrypted: i=1; AFNElJ+r7YhEERiTgTXugnWoP9iteNzYiqA4AH8MIrCeNSiXEJR7U0mKZiQdIVd0ZVCPXmNCBdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZeUAmUMHo8GbFIIZ2sDxPSINdTB6kk1KA4d5gxpSaa3vzMDOC
	n9Q5PfCr68o0drATQNniIcZdeF37Pt2lC5GcvzRmQ0KQt/InGttAdnp/
X-Gm-Gg: AfdE7ckO9cm1Nm8/LAVjze0RsXA89QpSbHaxKQTYq7Fw2JVsWxJx1bHazZKXv8+3E4d
	usfZMBTaf4/mwACjmo39ajxltwg+YetYUMIAw1HAHGVhUhsDBNAYsUy8JvnmW8Pn7xn/ggdNyk4
	7rMGGH99dWh0GMrfaW6jRPFeggvSFdL9yv3n+TnMpv5qxh9IgovR/HPkM6ggbwVUEYuFUdHQPkT
	2qtLBCrZfqNId7ofJBfnLXesjOspINin0yOTMyluRm+1k1QxxgxrakojU9J/0x2+tQjz+ZTxIbh
	Ud6kGYn+YhRCvTN09fRUvBuRIQVzFUXS+Hq+T00Za2cNV5Gl501N1zqVMTK8TzosO96UcfTtzAQ
	IBH9btYsOMFWsSHPFB68QrNC2h5JErnWyxmrA9+rpBzaO8J4E8autcWaWEccNdKoyNkGA9SiEDy
	HzI9kjgvobpUbTuFU4zQIMGTKfy1DmkOxIeg==
X-Received: by 2002:a05:7022:390:b0:139:c4e3:9499 with SMTP id a92af1059eb24-139db9edd39mr1684753c88.2.1782380461152;
        Thu, 25 Jun 2026 02:41:01 -0700 (PDT)
Received: from 10-86-27-11.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d90e940asm6267256c88.9.2026.06.25.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:41:00 -0700 (PDT)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] KVM: SVM: handle wraparound of asid_generation
Date: Thu, 25 Jun 2026 17:40:47 +0800
Message-ID: <20260625094047.255954-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If asid_generation wraps around to 0, it matches the initial
value of svm->current_vmcb->asid_generation (0), causing KVM
to skip calling new_asid() and potentially reuse stale ASIDs.

Fix this by skipping 0 when incrementing asid_generation.

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>
---
 arch/x86/kvm/svm/svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9658ce4e0..fafd0af5d 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1900,7 +1900,8 @@ static void svm_update_exception_bitmap(struct kvm_vcpu *vcpu)
 static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
 {
 	if (sd->next_asid > sd->max_asid) {
-		++sd->asid_generation;
+		if (!++sd->asid_generation)
+			sd->asid_generation = 1;
 		sd->next_asid = sd->min_asid;
 		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
 		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
-- 
2.47.3

