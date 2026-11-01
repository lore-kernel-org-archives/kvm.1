Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793546911;
	b=IjPAqYU+RPvnGntn6IjV0uqOIOW1ySOLkKV0l/ykZqwkNVL/AcRtYnlvQG2Hoo3rzmEm
	 0FN4g1vj3Z956Bx3jvkZYhbr0yi8fIs2KcpaT085UA/MfGeEr34z8sm9tkycWRwpp5pOV
	 OgjvWl+7qRmpba/7IO0YqKpNIJa4vtEbQkWrOkGK+efJFIwwtssmMAvML5ZSZgAGlg8JM
	 9E23w6kFoeXNKSzmYLy6k1w6vsvw9nsVnoBmjhgmdoblXHEdSlW05ImUGU42rZRND1VoI
	 zQGN4udG7S/HTTyUZZvjYe7rl97BjsAvWTcKot0qTEEKP4iHEFdfzjoVMB6gM3QnO0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793546911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TeZ6IgkzEeK3FNGEWnZ121HpRlWxGruZFzuJFvAehYc=;
	b=2Ec97JyCn4QA0WU6WG9XR6QDxkCRNOpqebuUZiLs4wjNtnh8L6xNGC8x4ssWnWkIdahC
	 ZmiwZzVyMVT6j4Zly+dzvxJbRzkATwdtatV2YUrn54HDZ00aqp805Gm6dsMBy5xG1dGPK
	 OQ5UT4jaYCgZw/LksCasBW8YTI3ZYGkSBmzuhZScHdv7Kp++7PHXW9ZCFJ6VGMxXarBwM
	 HZDvyqtrDeoUd/l7ixw5QRS55xUHsbfKlW7oWRZYUluqpCw/DFDIu79tghdIsEED0vOlD
	 4EtQ3UIycKjT46aRHorS8Fw8ND8eoqfZiBsW58Ao0Lr7e+crSJrHZVGZYL8JmVSBrVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="l9LyW/vr";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA0606A329
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 15:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64CA0606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l9LyW/vr
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1792220c88.0
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793546910; x=1794151710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TeZ6IgkzEeK3FNGEWnZ121HpRlWxGruZFzuJFvAehYc=;
        b=l9LyW/vrgM4MLfWz3YFU35M51oG1fpFusvhPGrpPe+xrj6gqzejB+gREyg8Mx+7DY0
         b35n2Xyn2CTmP61Xsy3QBJdqlUI8LA8IHuIs/CP2Ecn1YvCn3a8sbOfvEb0e0Mq9wg/y
         2E+AZodoEbrIORCIV4XJslQXTOCIjQZQNnZlGHWvKWL8X+eAn02SDWjP+QSfSeaGX1L8
         CjCgKc57A/VifhPpIYaCBTHTSIy9Tl6WSpeNgORFIZ4q1ePz4R8owu6cPJGVBIMmf2ZF
         +c9zu005BRbIUBjHFCW/LC8aAKTfNg5DnwP+YahogIQVLIFvCCbQxi1ARXgOqjq/wrhL
         ij7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793546910; x=1794151710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TeZ6IgkzEeK3FNGEWnZ121HpRlWxGruZFzuJFvAehYc=;
        b=S2HJa/NQMKQoidFdXqcabeXjQ1M2rv6TUCpial7cIpeCAYtHVbqlGMq6bvequpcG1Q
         zYxIJSRwcFx+8heY8ZkWNCbVMVQ20OQSgqwXrY3K3d/38dwZmr/xZ7K84XGxd4gVgm5K
         B08btBUVIOEaow6035GB5BRb4729FOUf3IaFaxATL2Mk7bQEjNAbc/GUvPHwq60oUZcH
         nILZkrG7p5lthH1iBp0vhJnNjmLAE6GXe1xuBGszQ/okukkGpWmnBIyTnOAJYPQ3/aPE
         ZwUOgdk3X6FaKtW7/3BhLTLvOFDwFxrvq97EUfH2aKa8EMGOAnAYfwNxCMcrvihdoXlo
         0xxg==
X-Forwarded-Encrypted: i=1; AKwUvBzv4oMfdIUqM722m6Rje8qVfDkuFf/tVvyDXtVk911bWSxLZ6fD4Py+VbtfYbQ9PGAc0iQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyZH0eKQ4kcuj1TEjp3k1uzQCpBS4EjKe/rM5sxTN7HwRJq2OA
	1Scho9Ivcaaa3lZYa+Ak00jrpJyuV0A7isH1aN8+DX+XFwLv5a5C3AW7
X-Gm-Gg: AYBFou3rRsUs/f9QHTjwwYJlzoNbhEoOs3bIs5WGthkmvJafE7TvUHAIOk4T6srAGCD
	uc3E26Og+B837udJwkWzBVzV6Qvst1BfcHHdnCizFACpfPGEOpb84BEz6BMs4X3nutU1deyDF4t
	5aDRLHsiE8FGfyuOROQ8JtntqiPfovxtKPmRqBn9jQDllYnsAPLEvgD4k50buiVv3vfDEyKGlZh
	J2u2tIWGeF/G23aBielDT1EBozLzTMTk1mwoWvwj5VaLaBlog1KQbFuDIkHSS7Pcl98Arx3h1pU
	/WPhZ983v9Xq0+1JXpwnKa99sp7g/RVqMpSOx7YtwEprCkAcMC/kgOaXpGN3KdBxhEuHWoBoNba
	wRtz8rKSjYPGWKSSUeI8hF0eBCmcm2Rs+N7SX7Hr2ZrBiuXUM/fsOrZs4XlG0vwYss7tNpU8fh4
	loznAJkE6uSSulIcnNbjVSoKkUcYam+RuUzs4F4LEd8odKfKFSUWfUxKSETkdvem/ANbOuFLXs4
	XpHd01LMa7LoX9AD3ESiB397VlP51zhZ7CJd+NenmSMlthDl2D6qFmM52V0ltG9Mvhg+hT5Vjqd
	03oQD5WtOuSE2IOZMbRTV0+MgRwQrenITg==
X-Received: by 2002:a05:701b:4590:20b0:193:5449:b889 with SMTP id a92af1059eb24-1ac6088a33amr10627985c88.45.1793546910336;
        Sun, 01 Nov 2026 07:28:30 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm24862665c88.8.2026.11.01.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:28:29 -0800 (PST)
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
Subject: [PATCHv3 2/7] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:58:07 +0530
Message-Id: <aa74d5ca5ad53a2fa03a7224126f28899ca9b308.1793546707.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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

This problem was caught when running KVM PPC selftests on big-endian.
__ffs() doc clearly says:
  "Undefined if no bit exists, so code should check against 0 first"

This cause KVM to deliever an arbitary interrupt to the guest and was
causing guest to hang up while running these selftests.

On checking further - GCC was emitting 0 in this case, which caused
System Reset in guest while running kvm selftests.

Use find_first_bit() instead, which reads the word once and returns the
bitmap size when no bit is set, instead of reading *pending twice
thereby causing TOCTOU as pointed by Sashiko.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/kvm/book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 2efbe05caed7..5de4b6e86656 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -401,7 +401,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pending_exceptions)
 		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exceptions);
 #endif
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_BYTE * sizeof(*pending));
 	while (priority < BOOK3S_IRQPRIO_MAX) {
 		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
 		    clear_irqprio(vcpu, priority)) {
-- 
2.39.5

