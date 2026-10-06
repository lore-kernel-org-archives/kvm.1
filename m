Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08803E4115
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791282593; cv=none; b=UD0aVRGvvtY8NGUHBEmjQOAOV8rJ2HcPCoSk/2vXjCf3VWWwOX0O484kLUvLRSVnCJaILknhHCHHGlKtHf193Wg573ARPEHSBNDcj7LcXO7jwwHbpjjyRB8vPLJF7f6kA9+ODiI8FIiE29hcH7CoI7IQvrJEjMUBRL1djnvpwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791282593; c=relaxed/simple;
	bh=rpq9jJOwYIlsQansIvZOVW9bA4KM5MDP/BqvMbCL50I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sksFqcC5xfHYxyWoMm/Y5ELmKMfe8ydBNRmNp3RplCkChigANMCBUGgYrawcYc2t8SUnWCquIjiCVp2Z6O9HoTAo+NDlB8LpAO/4sxawkXrUov9tl+FxkjtIJWFzURNbcASRCd3qCqxUeyjNwdKpUHMZxEUdsWT+8aFIEEsKnl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIeGsmtX; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIeGsmtX"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35115b52125so421894eec.1
        for <kvm@vger.kernel.org>; Tue, 06 Oct 2026 03:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791282588; x=1791887388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bEjXEmlCAVQzsXstKVYkWam80HXGnlDzJrE3eDAdOhc=;
        b=sIeGsmtXUvxHs1u+w3g3vR64vajFExGKqdXCHqjHi8j6c3l/b9KjuhOxc7+AGT8QZW
         aGz7a4jcZ83G43gjxQ/ubqRWLa860eCzTDxrPzJl9cNhJvK6hrSDJNZbgBkug+ki3JLK
         hs9u5sFn5O8/sprasqErHG2EVNCImoFHEo77Vs914I1gMSk0e2G+jV8EvEddXXtBJobY
         RDoQ/SH96NlubiJrmEF6abRuQprFlBfP7fKfkjz1mM9hcTr3fJF+W2GrAvWPn4b5rgYh
         xD7qhSivzFVyRPH3Msg5BiNbQR2JjvZjIuO4zGj4WK9v2aTApvQZNczlIP1vV0UOcfJI
         dv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791282588; x=1791887388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bEjXEmlCAVQzsXstKVYkWam80HXGnlDzJrE3eDAdOhc=;
        b=run/5TIx9TuKFkOTJoRvlc1zLIU04WG+Sk6ekd5hkxSAj3iqS37TV7GyijN8pg3M1L
         1TO7kuaEhtZkPy/E+ycRlM+MIMm1QRQ0dkkgbGExehi1nQ9yxjPLzouIi4Y9NIX2f2iO
         PLPCuAdP9DpE3hemX43CQDioxTm2iYdXe1qRmXFM81mOPuFLnxidWkTr9FNGD6gkoaP/
         Lj7WWHJe8qhxUk8nllE7wmUkVSpTib5Gh6/zB6r3MPXJG29v//Hy2Hod3rKjTdoJylfU
         4h5ePbVOp7pNbjeokmmH5Zg8MCsSBo4dPXTPNcgVAF1Smvw+asBc4nf/3GipmjBbrBZ7
         EoDg==
X-Gm-Message-State: AFq9FYLKHKdAZVExPfFQ1LYN2mbdwckNjBCN7u+8KwW1eMTzqvEKxwne
	MkoLImzYl8me2vDCsuPdAJKsSIwRpshLifIgp6muoeHmhGm51/bMhoyfmDmjvwdU
X-Gm-Gg: AYBFou01Cr0xbNlDelRvL0Y/o4OOC2LHRNwLNQ6hLbdsu2wNrGvW6X8Qp1CdjbXpqdT
	AGEqZ7b7wwPLoeO4aUGr7Cml5bRAhjbEanHZgMzvfCX4UjJfEmm7rEe5qLDD3SRwAmulsOaG5Dk
	hm7FFL1w0wfdhmQVu4ZJwvfypvUzkojnJ8zDmvu65+cwcUP18oHbfhUIsrJTkXNxtM/CU3f7PQt
	q/7QnW5clPOFpx4Q2tTXCYOJgqFwihVGg5Bo/NkKgTUNhIXr+7IXHiNdmzrUUKxDk3qmbKecxUJ
	2SqhpPUwrJbFotLqbbBSDGiRJ0fEme+28W9/KOPKGNmUfdpJRLtwyC0VwaC8RNWG/5eULyodS6r
	6pwdh6IXOfOJGf4HiP/x/6i/ZF9bM1E1WJEavFsH/fdj2AkW5i0RThJ1sc++yFJ+SXHwFq5jbqG
	EH/O5zCdAfnqYGLPFqGXeSFM8VLzZi9ckDquSq+Gq2UBa2vq2C9LgC1POqXyjwuiFk/d4FU9oUA
	EU61sgs2COBmxRd3icXrDmILrI/kcT9XbouLlXwvDEszX5qXHJ5ljnWUKJv
X-Received: by 2002:a05:7300:ec97:b0:351:1f66:469b with SMTP id 5a478bee46e88-3514dcbd7e7mr1038255eec.2.1791282588308;
        Tue, 06 Oct 2026 03:29:48 -0700 (PDT)
Received: from pve-server.rlab ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351469fa189sm7443970eec.6.2026.10.06.03.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:29:47 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v7 1/8] KVM: selftests: Don't limit LE dirty-bitmap bitops to s390x
Date: Tue,  6 Oct 2026 15:58:35 +0530
Message-Id: <63c900860b5f7e49cfa7258602e94b58b3de73b3.1791280439.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1791280439.git.ritesh.list@gmail.com>
References: <cover.1791280439.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dirty_log_test already has BITOP_LE_SWIZZLE helpers, but they were
compiled in only for s390x, so every other big-endian host used native
test_bit().

The test fails on big-endian powerpc because it treated dirty host pages
as clean (because of the endianness issue)

w/o the fix the test fails with:
  Clear page 1 value (1) >= iteration (1)

Fixes: a049a377164c ("KVM: selftests: Enable dirty_log_test on s390x")
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index af5eb0334a74..8189eaac713c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -44,8 +44,11 @@
 #define TEST_MIN_WRITES_PER_ITERATION	0x100
 
 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
-#if defined(__s390x__)
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
+#else
+# define BITOP_LE_SWIZZLE	0
+#endif
 # define test_bit_le(nr, addr) \
 	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __set_bit_le(nr, addr) \
@@ -56,13 +59,6 @@
 	__test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
 # define __test_and_clear_bit_le(nr, addr) \
 	__test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
-#else
-# define test_bit_le			test_bit
-# define __set_bit_le			__set_bit
-# define __clear_bit_le			__clear_bit
-# define __test_and_set_bit_le		__test_and_set_bit
-# define __test_and_clear_bit_le	__test_and_clear_bit
-#endif
 
 #define TEST_DIRTY_RING_COUNT		65536
 
-- 
2.39.5

