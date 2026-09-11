Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8E29CB52
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102633; cv=none; b=Bxo/gvr7zbvJ8M5nWRl/M5UzlybRyHbBfg4RlfIYbCeA+y2WOVqQe7/vaM+jfV9sGwg+CA83WXKH/Q+ieeKgTkGmtrJ+a/CoHS0VriGZ2VmkJ3hxL2esOIooeefg3R2mI8gHWBo9NdRiUCpn1/jizSCks3wPK92hdNJcetMyEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102633; c=relaxed/simple;
	bh=cxWWtKOcVRFOfPirj5NlhN1Lr4UnI5/R64/0wn4Md1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QceQ1X0H3WG6VKmprlfF+p1kTg2cCMXRzYeMF+1zJBj/Nqpg3Qlmf2mcs0dacvbiP7jRKZkLcrHnyND1vDUujkKqqO7ysSiogH2zfJSJyE+4sZVErLuwoS12sdwhwS4gfIzXs7vgzB2UvvPUo/NyFQmvVopbeFPA5DxYRswShP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0AbRI9k; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0AbRI9k"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-86959a6f7f6so359550b3a.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102632; x=1789707432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vP8L0nOQBMaqyTnSGV2kxiWzOWPb5E1yklPGYnOA60=;
        b=C0AbRI9kgOPa48aaQSPf2yu+IdigwG5lNWBrcV8GHr/HHQrPJv83+Rja8vg/EHtjec
         0zowjmv9MBaXHhOo+PIKiD7WxQttBvp7U6ZRz5TTsx/tE/cElFcrDH93d0L3a6CQRJ2x
         F4jbY7qbtmcDagVGDrsZhFcebbEXcgo2wTRrB43Zt8EmyW3ExSciCzm9mqc6Go2iGYps
         JSw88iz+2zQ5hyu8uYIdYYAp2kbSfU/x4he4SHH5tSomnUQ/PcUq7DXlD1zthIt62iN4
         +P85UQExymba8ZbGWtZ9C4R72ZCkbZ9NNVc8ju6Ox/8TYvNeWpHw4v6svLLma4HBzhp/
         52FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102632; x=1789707432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3vP8L0nOQBMaqyTnSGV2kxiWzOWPb5E1yklPGYnOA60=;
        b=eSeDBvZhycCgE1PCmFcCNAeD4nrBuD9P/6Pv90BDd1728RWMEKW8fvXaNn0kmbsLZW
         H442Jv+CS2EEzFtUBOVFraj/boRr5p1s4tvoh5/8dfVNwx95wv635G/NF7emi1aUW//6
         Kr9WsHusONi4zhMoBjHR9KnA3pBqykYs/fRDkcHq0kI87P9JaqqYcOVitxOR0e5xZZ+o
         f4GW7PTFToOvlNeBP+HQosDgwJ0SWTZIBvXA10yf7+R3Jy+S4DLs6dWZFRoqMuOJdS9g
         Uriix7pG2N6+AD8YGcyImtl9qjm6MYhlIW71XaTGZ+gFFqAMDaFHsG/USqwyusK+dQ6K
         BRbg==
X-Forwarded-Encrypted: i=1; AKwUvBzaxjRgqNWHQeNmHu+IPPIrXOsx27oqCSdLm9q/QXtFHIdiOym6LZlP2Xhl+YL/FeLTMOU=@vger.kernel.org
X-Gm-Message-State: AFuF++nEw48UeCLBbwDNLdBM/tUh/W1VgP0tLyGlF3rL4V26rlvf3oAm
	aF4Uy48/R3U1lcLINu6NGY2JoLZTZyRCsEAx/U/0EDXxlz4CTvs7pETQ
X-Gm-Gg: AYBFou1IVsLobtq6Z1qCQoAzHqmmt9sFs1FjS4tEGRheFPPN3yiqwobwZuhNHEPNOrf
	hNVYyXCJ46i8SBaBb9cdMrgzFNLRBpBB0LFynD80x8KQjkULLVwKYOGc+st2N6Be8Ym6gRp0ZKf
	eRdSSlZV2pHzKuVisZ2mmrmS50fwsqjJOxkQ4acN92PdlEiYMcHvUxuW2/VHLny5WLY72KKljcz
	K7SWonK+TLEXN3HqCD0UhkJPiX61Nr7MM+HCMcv410jqfLJatr0muiIVHN8svkDAbH3hi4P/uUx
	49xhCc6u9wlc9qReqt29jQ0Lr40is62xw4fqsDJ5/TRXdUmXIsFBLitf8gSjFrjjqhPY20SbCkk
	KIGq0slvnD8AXg0Y/jniGa2/a9prZ4FMMmASG/Tv63JZ9BQfjGNrDH9YxNQ/mT67jMr4r7KfLlG
	OBdMWjdJumQHjwR9JIEgT5wzqVsMJCXlc9VrcgAGUSKD8NEMTINSEDbdzoV/Fl8vfYofF3FkiqR
	GZkOBJi5x+sGNqHqnKCBYRP1y4v/Mqm6kK3RkxzXTv+coG9y88upJGLDn90cCI=
X-Received: by 2002:a05:6a21:15cf:b0:3be:b0b3:3962 with SMTP id adf61e73a8af0-3daed1c1f53mr4438486637.9.1789102631764;
        Thu, 10 Sep 2026 21:57:11 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e9a3casm2837953eec.12.2026.09.10.21.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 21:57:10 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 2/3] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Fri, 11 Sep 2026 10:26:46 +0530
Message-Id: <3578c377329d39a4a9063c24496d2ac4c31a169d.1789099725.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1789099725.git.ritesh.list@gmail.com>
References: <cover.1789099725.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This problem was caught when running KVM PPC selftests on big-endian.
__ffs() doc clearly says:
  "Undefined if no bit exists, so code should check against 0 first"

This cause KVM to deliever an arbitary interrupt to the guest and was
causing guest to hang up while running these selftests.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2efbe05caed7..e4152e9a0d96 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -401,17 +401,19 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pending_exceptions)
 		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exceptions);
 #endif
-	priority = __ffs(*pending);
-	while (priority < BOOK3S_IRQPRIO_MAX) {
-		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
-		    clear_irqprio(vcpu, priority)) {
-			clear_bit(priority, &vcpu->arch.pending_exceptions);
-			break;
-		}
+	if (*pending) {
+		priority = __ffs(*pending);
+		while (priority < BOOK3S_IRQPRIO_MAX) {
+			if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
+			    clear_irqprio(vcpu, priority)) {
+				clear_bit(priority, &vcpu->arch.pending_exceptions);
+				break;
+			}

-		priority = find_next_bit(pending,
-					 BITS_PER_BYTE * sizeof(*pending),
-					 priority + 1);
+			priority = find_next_bit(pending,
+						 BITS_PER_BYTE * sizeof(*pending),
+						 priority + 1);
+		}
 	}

 	/* Tell the guest about our interrupt status */
--
2.39.5

