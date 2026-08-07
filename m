Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C938DC4A
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092085; cv=none; b=MK47fOlzxZrP1WrMe7JGaonzP/JY/Y2QU3hf7jdI/MNXJYwZb8D6tF6+AUthQON0Mr4t96nDHRwUpYNe56ATJOP3SEynKLnQ8rZT+iJ7PGSCRV3i//FYCDBQK06jLs3Jzk053yFI6I5pFgao4vaC2vWS4+HV70JnkUf+0bwvYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092085; c=relaxed/simple;
	bh=OXJqs62i2JQf1vZqZo0iRj0cxglD3Ik1g+1j1UvlxWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3tdG7YxU96dPq0exSON9beJei/tQPIKW+qhBx/TB43DNTu1yM8NtYTqHL4sRJZP2Po/w9P3Oe3XG0GwdtaqApnuDLwvfzbcd9HaEzMQ8T6Z+EEdZMMIlzhQRQBRpwvKil2Z7eVMEDCqY5e/gkCXk0/RqAxDeaYjbp7YH5+QHrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwnNTw+u; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwnNTw+u"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce98cb8165so21391335ad.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 01:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786092082; x=1786696882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIo2xLGgMhUY4A3TIq3AFuRK+7tc2N7MoWZXtLuV8JY=;
        b=ZwnNTw+u4PM8FcDvclVxqJQWxmI7bW6HqsG+ifB+pWiqF3IEuleUBdWU6Yawxdvx02
         NFb3HDzbt3ar7E5vd4juyscctKxUv2fefkaKIono7uuF0azjslB+aWKT8Mh6fOB9MKVT
         Mr4RMpe/qbbxmFSvZ2qPF6X8zo1CvwSPgjyuzfZ2LwLrBHk36euF8X8uXPgdDpdi14TT
         lGDhWoOvNudKmu5UtjcL5gzLUJL/G8kOU14AgI7NTrV9tTWdHTgNeSA20hVN95RGKK1K
         Pe03eKdQZXHrOxBymPsQvn5Lym70T9lfORTMZngvs6PhFtvzX3f+kHGbRMjJCDV2+xps
         XIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092082; x=1786696882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIo2xLGgMhUY4A3TIq3AFuRK+7tc2N7MoWZXtLuV8JY=;
        b=Dq44IZUW7We8B5/zmYMUdB/vSumTlpzplsABCLlgL4nYPLMV8dbk4/i47iq6xcJr3X
         KBOub05/luaDLcUZITGMTfkD1Z9tFjoq3rWyAr5TPiojuVEogQsHgxOh+D+i3XddbKSR
         NTEm0CqqDKylqs/xGY9TL3CWbBmIBET0m0eWYHIud9MY8t3La8YQ7WaPUuWuKbcr7f9k
         gO3uQAgDQdcxN2UPkuojyAUcgLUd4+pEXBCUDRCJY1h8X2PjY3W4Vsq6XhTI1h8lCN+A
         6Rcn15KKBpOtFxaJk+YC+dP1MfGS9vB8x7P6a0w+Cvga3h5hC39JddgW6py/IyDGFmlo
         EHTA==
X-Forwarded-Encrypted: i=1; AHgh+Rq3LDFANv7cBjzFlGytIoc6vQah4B1voWQOrq41gWNeJnRjcinRYKN51D1HmYSiQCDjCyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD+0ELvW5emREE1Casl1luhtbFhlW1he/R1C2YqGCkJrmz8Dh2
	iDSSNpWtkRq8LY/674+ktVc/prDfsS0lqPYQ/54fCfWE5cXdMYhujRNZ
X-Gm-Gg: AR+sD123G8AnH400KnDpI1CvQGkw8MMvnte0svusOj2ltBFNY94ImRy+ci4g6gh3h44
	JSLAOeohosmgohnEqGSsW2LWtxJ6UE2za9PS961ZI/o8lZxHcuwqyf3yFs+pnDg41ICm1AjrYTK
	xQiAvkv+ofx0xMe1vPXkcvGvlfyjF4nkdxVY/e9NQtJM/t9eVGlpUlwqabanN28jcdsMOEoTM8b
	iSVsr4P0EqO6iGpYywzVL2p9EU/WsALpDiJzDlBvNusts12xYH0wMSmo3fPzuICO4X0jYdAm+RC
	hmMRtjfc0z8ZGrg5Tv7XXlWORM/3hH/bDuLvvTFTFmDbQzAGvqetZJ71NK2RWlkmF5gDkcCPWLy
	dIYvRal+PerDDLtALzf4Lg4cLCqiRiTumakmTLvP73rnhN+oxJSbxj4SD2N0GmOef9p/tK+WnVc
	B8QrCe4SbpLowAtIjzHr+LO6FXm3GnTVRaYOwwNgbouBMBBq5zS2hWJTkq3iur8htCpE/HjWEOK
	NAJVQPA3jWMwub2bYVpmogc9VRp68eX
X-Received: by 2002:a17:903:38c4:b0:2ce:a6a4:451b with SMTP id d9443c01a7336-2d0f1c130bamr148775805ad.11.1786092082029;
        Fri, 07 Aug 2026 01:41:22 -0700 (PDT)
Received: from gayadav-thinkpadt14sgen1.bengluru.csb ([115.110.157.234])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be8a6809sm5006142eec.10.2026.08.07.01.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:41:21 -0700 (PDT)
From: Gaurav Yadav <yadavgaurav386@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gaurav Yadav <yadavgaurav386@gmail.com>
Subject: [PATCH] KVM: PPC: BookE: Use vcpu_err() instead of printk() in kvmppc_dump_vcpu()
Date: Fri,  7 Aug 2026 14:10:50 +0530
Message-ID: <20260807084050.25216-1-yadavgaurav386@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace generic printk() calls in kvmppc_dump_vcpu() with vcpu_err()
and remove the corresponding TODO comment.

Using vcpu_err() provides vCPU-aware logging context, making it easier
to associate register dumps with specific vCPU instances in logs.

Signed-off-by: Gaurav Yadav <yadavgaurav386@gmail.com>
---
 arch/powerpc/kvm/booke.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index f3ddb24ece74..23159eb5f5af 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -86,26 +86,25 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
 		       sizeof(kvm_vcpu_stats_desc),
 };
 
-/* TODO: use vcpu_printf() */
 void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu)
 {
 	int i;
 
-	printk("pc:   %08lx msr:  %08llx\n", vcpu->arch.regs.nip,
-			vcpu->arch.shared->msr);
-	printk("lr:   %08lx ctr:  %08lx\n", vcpu->arch.regs.link,
-			vcpu->arch.regs.ctr);
-	printk("srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
-					    vcpu->arch.shared->srr1);
+	vcpu_err(vcpu, "pc:   %08lx msr:  %08llx\n", vcpu->arch.regs.nip,
+		 vcpu->arch.shared->msr);
+	vcpu_err(vcpu, "lr:   %08lx ctr:  %08lx\n", vcpu->arch.regs.link,
+		 vcpu->arch.regs.ctr);
+	vcpu_err(vcpu, "srr0: %08llx srr1: %08llx\n", vcpu->arch.shared->srr0,
+		 vcpu->arch.shared->srr1);
 
-	printk("exceptions: %08lx\n", vcpu->arch.pending_exceptions);
+	vcpu_err(vcpu, "exceptions: %08lx\n", vcpu->arch.pending_exceptions);
 
 	for (i = 0; i < 32; i += 4) {
-		printk("gpr%02d: %08lx %08lx %08lx %08lx\n", i,
-		       kvmppc_get_gpr(vcpu, i),
-		       kvmppc_get_gpr(vcpu, i+1),
-		       kvmppc_get_gpr(vcpu, i+2),
-		       kvmppc_get_gpr(vcpu, i+3));
+		vcpu_err(vcpu, "gpr%02d: %08lx %08lx %08lx %08lx\n", i,
+			 kvmppc_get_gpr(vcpu, i),
+			 kvmppc_get_gpr(vcpu, i+1),
+			 kvmppc_get_gpr(vcpu, i+2),
+			 kvmppc_get_gpr(vcpu, i+3));
 	}
 }
 
-- 
2.54.0

