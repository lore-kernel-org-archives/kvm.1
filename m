Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793544418;
	b=a6RwcUB1RNvXI7izhkM0v3QgVUSkGHacQeWdgGXnh7SUTv5JOKOc+oaPUTjEend3a1y3
	 SIX0vKwMxAj8mb7TqthtV2HX/V2KdEVSdaDeiiuqLIdfWwksVTBnwUBD9odvbrSeNLVgN
	 WbxZlIkFbAsXHd0hv2ZXGGEQNSw/XHi0Yh8CsbjlTmMcflEW4l/ZRzGJunX2xXZtW05ne
	 MvxGs2A2y4m3gQUQA9SsRkF8/j5sNHj5Rjb2E8d4RUFxOQMv1B6d6xyFD4MizDh5bilDZ
	 ahZMUWA/ysOkvgbFbNuv60O6SRVRsy924HlwaEmXmYU4umCvZhGLR8NDVgHUlnQn1HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RxWoIhpJjuj2outZeAOWH2ZFPlszOZNa+qnxn1FwicE=;
	b=lLyEAPkyHRypyTKEadMuJWLVjZ2EftkdniHMFIo8s4ecuUcZOUGA0SELMd4JJ8BQVXdv
	 hJg7KYwJqLnv589WT0GLEtmXekd7NShpKcYItiaYi8aRg9/EE2H2VY5LWV90ZZmRTfLiD
	 pWVfLhx3WTA7tAPlATubseK4OdroDYXK/CtetM1iL9XQh1Md0kye+v9rqwR4UdJCIGgxK
	 sCe0cAtT+maAQycdCmZn/It3eZ5OPj20wbIhui2ROEERqBTS1pinoY7cRAOOssMLnUFAe
	 RyCpTxgORPeCDxxqbn87shlYfpiIuqUc+YzlMY8dN12FMeyW85Yjsnyxb18w3oxJhkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzxaxrxu;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31EF606A334
	for <kvm@vger.kernel.org>; Sun,  1 Nov 2026 14:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F31EF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzxaxrxu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so4066039eec.1
        for <kvm@vger.kernel.org>; Sun, 01 Nov 2026 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793544417; x=1794149217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RxWoIhpJjuj2outZeAOWH2ZFPlszOZNa+qnxn1FwicE=;
        b=pzxaxrxuEpl7w2cfAkfUmjHhWik/DLGXnibNG/mFSk/Ex5bKSgkprIWXlqZ6U4ErRl
         rOKWDgoBIRd1pg9zfPqWwa2J1MSdBBEjbfYd24EV0zFvSsPquu9IY0NLZRYhAbqR+nrP
         7Az1Xclnic/EFIuPtnN1Cf/exdiN7QwOJU+G8DE+vY03wZrRsUcLWNCHDIQjussF5TcV
         oJsHQmpQAhSO/rG4umMX1Xs0i6s0aCK66nQZXODKJQhd9d4wOGI7yO9kUY6loj0YpS95
         bq/xh1jcDu4lH3bZp5VEaOgeivLiVuueFKF3LGCfPgQ1uZZSncOW6wiJu5LPE456obmC
         WrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793544417; x=1794149217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RxWoIhpJjuj2outZeAOWH2ZFPlszOZNa+qnxn1FwicE=;
        b=Iic6ONgk8esqb3Pz86MhDpnTZ8srVgGEd8u7vbChezdim2uXn9N4GlznILLPJxagFB
         l+RYgSGID05WkmY1//B0H8ChvJBd7P0efVOPsXuva+l0Iycnj2j0aaZS+DyRkNuVZ+9Q
         8cHjF661nAI5MURnQj0/800OMKPJpCsi1fzwKPl6RsWRv8gqtSK/9hLKfZGCg0ZPfIDe
         CK7mf5/rrytYabFX8leQeL6e7dFcYiHmIpCAnN5nnMHsKmCKlvzpWYDCw+/H6tf+tiCx
         G4qggO6uyxxfiDjm1Lj6NioI9GoTr2xLD1JpiV2smskxkuegNnKVXodxN929WVX0lnx1
         KCqg==
X-Forwarded-Encrypted: i=1; AKwUvByyWLAyv0oEkfrfWujHIqJZSkB67E8rxFRk8vI2OgCgD38foF+Cm8vylbt3JgvvBwm91MY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmdEOtV0rZaDspM5p5+RRDSov3cU9UHz4zWR4XzOU6vVp9sfos
	ADhLcCu/Lm05GIyNUypGIhORlCeWXTW21BXfWCzg2TLYDIFZ8KHTH7fe
X-Gm-Gg: AYBFou3VGBCPShsZfKQcHutY0ixJrZeS1/6VJhENbeRC26/KviXXsZBQK5e/5p6gD/b
	C0iMgkRO5vmh0DAxPMgX+86+hdEgeJvsJJzJ7VMq5R+wCYPG2cpVT4NmoixzJcwqPeH/VRJU+TG
	kZi2AAW61j0NnK2spAMVevIscuhCK4hG/gc9EYMq+yZU6D8QllQww7/Dhkftd79VWTs+TvOQtqv
	+LxxnG/wq3vl/kMpSOfca8ukrb62M7k9L0QsNamMOgyFKGH+EKwIIY6Gtl4UU+n6k1Lx5iSQmeJ
	TdT8Ii6oOEBng+VoG93GWfka+bDVHN8qLGYknnl5QncrYLn19rAe0zitWCqk1TGBIstZX52BRHt
	+HW6Y7l+Fq3L6Erdq9Q4nnVXj8fqmugYkN2EsXnXv0NVEHBoiNbie/zS5K23mBC3O0psmhbTFJD
	o4Tu8yTreUtJTgE8UDD6dTxGxSwawSGUp2l0TgEVTpeqCCKYZGlt3TFvbrCIL19RbsNxSdUYUdG
	I5j/eowqJfKQmXPU66fvEQzs8kYgY+a9X0tgkYGUhLbf1wXAY9XZJq6pxDWhBSzL+I038oKn6jN
	puF8yodsWNCcBdMPCc1f7UwRqwRCIqMOCzM=
X-Received: by 2002:a05:693c:88c8:10b0:36a:1f:9b74 with SMTP id 5a478bee46e88-36a423bf83emr11475457eec.27.1793544416826;
        Sun, 01 Nov 2026 06:46:56 -0800 (PST)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm32747545eec.25.2026.11.01.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 06:46:56 -0800 (PST)
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
Subject: [PATCHv2 2/7] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
Date: Sun,  1 Nov 2026 20:16:27 +0530
Message-Id: <b985cc12b0ed62599815ddf87e612bc8b6b2813c.1793543627.git.ritesh.list@gmail.com>
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

This problem was caught when running KVM PPC selftests on big-endian.
__ffs() doc clearly says:
  "Undefined if no bit exists, so code should check against 0 first"

This cause KVM to deliever an arbitrary interrupt to the guest and was
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
index 2efbe05caed7..38816578d002 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -401,7 +401,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.pending_exceptions)
 		printk(KERN_EMERG "KVM: Check pending: %lx\n", vcpu->arch.pending_exceptions);
 #endif
-	priority = __ffs(*pending);
+	priority = find_first_bit(pending, BITS_PER_LONG * sizeof(*pending));
 	while (priority < BOOK3S_IRQPRIO_MAX) {
 		if (kvmppc_book3s_irqprio_deliver(vcpu, priority) &&
 		    clear_irqprio(vcpu, priority)) {
--
2.39.5

