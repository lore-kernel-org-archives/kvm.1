Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544438;
	b=SWUbKzE8oGg6t2F9DsOLDIWlAeAqT55RVABZmyDtoaW/OyWawYvj+q/KTXtgXMmqReFb
	 mWYQ6uF0hiAffLaISaJOdQA4Dp94pCTBedteRY8d7JxvE0qXsPzyNQFT6iBGCgwUqJrcf
	 Q6OFzpdQymAsyIscFfzlCm/dWmoUYuCoREunWNLyzEPrDS85sF78X+/dmz3BjOF7X032H
	 uKtU0y0s1QDo+TTvEIabIktM0GyTeUpHOdVZqly35L4VdKNYkPmtSxSlrc7G+a4pKGjrD
	 3jU91R53isNQxdJ6qSq7/mSGiwOBLMhM6XgGE95sp2wvvz0EfRTPcrve1pUVBTbRznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=V2lcCV5azjsGrWatUG1LtEdItX9x2QFl+QgQazoBrAk=;
	b=5tPd6kg8FIEUYPO0Ye2Zv6EvnT7M1gBFcpCM6S7K0s9z6qo8Wx34DlLzS31sitxf/t8Z
	 zkX9vGZi1scIwq+DWskQ0o5qLLKnocD2Q1D996vhWUvg0BX3Dvwp/GX6epxh56h0ASEfN
	 Zspm35L/ox5kKBVf6hFtzOm6Z9N9mvfLwybujvat/5UeHnEke970SctZ2+qb2luHlDKgG
	 JcnrmFKW0CdFj9C0l/Sp/owRfJbujiMQGHQp9VozFPZ2lANVeOWeKXVmAnuEpe//BLvVH
	 oUm5nDqynN41i0sOejGqWdD5gJZckaOiAt/7Ww4yXllo/rddktQbqLs8TO5fmU72SbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fd8w8b0f;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631CE606A327
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 631CE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fd8w8b0f
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35c76e9614aso3134412eec.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544436; x=1794149236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V2lcCV5azjsGrWatUG1LtEdItX9x2QFl+QgQazoBrAk=;
        b=fd8w8b0f7MOG8V/KrCeyk2gPvDBJKhVBEko1EZ8P5BYIWiFtm2yuYLz5hRWEDo1sJE
         EIA2MTmfG6kGDtiMmzlu+c52/v0tAdr2jiISuzyKSTcid/GDQRklXW9FOJ8y+zOBIZR8
         t/3PZAwKD2rusBW/eYOqTnf4j8F3fYXxc1LPdrGnNG2YWU6qlSKnsl2l9O7qwWWksfps
         B+IG4QtMP/7YILwhroJWwj3xbmHCO5dqdpvPdpgawnwJqrCul7qERwy+RXZCjniVINru
         My41J5+gMdIWgw00a1HCytVSDcuxNq/9L3iCDV5TPX12w6F/fkjLt5Qu3+PW1fyf3Ej/
         k0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544436; x=1794149236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V2lcCV5azjsGrWatUG1LtEdItX9x2QFl+QgQazoBrAk=;
        b=WY92mtPYgE7UTotrd8dVXcx7IDrCyNUcPwiidThG2kySqQ+ZkQCsFdio5LLpkvcxyP
         LYxNmTqXCGd+jOOewyvrPfr9St4Wsyyvb8bB3n6GIRnmRSwD+p8V26UApTKpNw1nSnAT
         xjz5jk5dZQWJ4KqEgNGCYIy3DbLCnz/Iq+qZgw3A/eg2Qzpw9HzV+KSPP9Tu7RHh9B7M
         mcVk0Kg/l/WLMOlPnukp5mccAMzMl4ZJeiy1S26BPIavJ0NherbTYWid6ss3p6n6maF/
         mzHYk74ZjpJU1DHu8lijL036W5VZLQjtbYhx7AqpBcPP5x4UUIxl1wBbf7dduyzrJHLX
         MM4Q==
X-Forwarded-Encrypted: i=1; AKwUvByJA17hHso/AaB4a7yBVbJMS7ews7U+vkAmHdfUk/xiXA8eTysg+f9Yyb4TUAVj8RcEi5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLHkMVCd5s7SuyaVX74uiiyju/lVogYwUwqdBbnTte7mGuy4I2
	mFs3PbLR6fM1/7CCzxFcZfmha0ETzYEDdO0noQrVDOuXNQcs8QAytthv
X-Gm-Gg: AYBFou0+cFvfzTGKZ0Modw6Y9kEmUp1+FXrdpBaS1yKIH6mwiD0+iq5wVWC6ruhMEHF
	yBhgC8esU1PVO4uOZExtGH4iWMgQ/hq95Dp6sMGrB388YmvyDs8eNJb62nPjQMoioOc4nz+FVuv
	2Lq90tRad4yxdrZ3o5DiaF/5YFoiOKTWMRnVrfUwKS7fUHKJIiPpUd/fSjyYyE1BzyAeicrZ9Bw
	FjoN/1QaqNt5P/JYBv3d3oGe58HJCb+FQZX42eoUd14G503OrK9oq5Yhj5AZno8sZN2UiBzcJBL
	x31Wo6j5o3SoEa+eaFyca+L5FJZfD46kTNapI7aTfJvRA31LLHbEgulcO66HDRAyIkZkqo3dFC5
	CQ2d5PD+PuadHHbTLn1xdyX6iopB/dQ6FdLWRkdfvQwyjtw/sYcPAuV3XsKb2JE3lHqeFtJGBUr
	2EtAOCefJIGIu2m6n/g3j4dO9L/emcFw8u+91dVDxeaYDGw+uzERPb8JuIzc8QEQPPRODVOQCx+
	iynrrLB+MXAEmLm/OhzGzQ6UAaP+n8XaTGQ5g7PIMWvmoYGLKTIZnVEla1maNjNhj1Ipaw0Tz0f
	Nyaqpr7579Bbkae9wAkk5w0yRTTY32kGHA==
X-Received: by 2002:a05:693c:639a:20b0:359:1b05:ed30 with SMTP id 5a478bee46e88-36a42203bc1mr11532986eec.4.1793544436256;
        Sun, 01 Nov 2026 06:47:16 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:47:15 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	chleroy@kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	kvm@vger.kernel.org,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv2 6/7] KVM: PPC: Book3S HV: Fix error handling during vcore create
Date: Sun,  1 Nov 2026 20:16:31 +0530
Message-Id: <ca419693358e3af49b1dfa7887b34b8ef91a5daf.1793543627.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793543627.git.ritesh.list@gmail.com>
References: <cover.1793543627.git.ritesh.list@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvmppc_vcore_create() can fail and return NULL, this patch fixes the
error handling when this happens.

vcore and online_vcores count should only be updated when vcore was
actually created, otherwise it's state gets messed up for the VM run.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 22283d46e8fe..7975e5de89d0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -3090,10 +3090,12 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
 			err = -ENOMEM;
 			vcore = kvmppc_vcore_create(kvm,
 					id & ~(kvm->arch.smt_mode - 1));
-			mutex_lock(&kvm->arch.mmu_setup_lock);
-			kvm->arch.vcores[core] = vcore;
-			kvm->arch.online_vcores++;
-			mutex_unlock(&kvm->arch.mmu_setup_lock);
+			if (!vcore) {
+				mutex_lock(&kvm->arch.mmu_setup_lock);
+				kvm->arch.vcores[core] = vcore;
+				kvm->arch.online_vcores++;
+				mutex_unlock(&kvm->arch.mmu_setup_lock);
+			}
 		}
 	}
 
-- 
2.39.5

