Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7074A43B6E2
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731412; cv=none; b=d0HqtfNzg1n+zPYv1QcpObhNsqC5TaqP6f0plJfiByyREDlhzyIM6mI31q083mMFrI24GUv7joF/M8MvO41EUv/tViiBxyr4iPuDh4MJkovjcmMijzrFQCI4d4FNuHsNYiw31av9PSiJUKJ92xpb1sZ+gA9gOV8uGPvPgTe0a14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731412; c=relaxed/simple;
	bh=3ET0knDUgnDsJMyjwUdtJJUBQcdsxUvwQA8gNlINT5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZEa02/dN/gkXQoflgR4uQ/lOTleML4Hl4C/IxwC8jqJuNArBV+Too09duVvyPciX9DaP3HcikG/yqt+i3+XjAw1U512/BrUwhH92CXnoS/ih5f5HsIfQLN13aUm63aeEzuEJID0N+mPiW6IIIDsjCAs11TMS6M7cALdoFac57UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIGlSG+V; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIGlSG+V"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so344711a12.0
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789731410; x=1790336210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EiY/TSJNOxMMy8e6PlWLzVlCOoeYw1PqDh74a6kOopk=;
        b=AIGlSG+VgagFYtuYU4jhf9YruN9U5c9o2xhM4onteqi5c5YKYrQ4xexFnyFpBlJiUN
         PHPe0VrGUk3JfzJIwrUdViEXnI0+W2WEl4gnHRnwJSpv89b9Ugdkdubcf7LfRvS9TIsD
         sNAPZnzptsn5fsmSg8PDz0bKEQVi23Pqswvg9De+p5vjuARn/lseVORRtSSNyNDpNcI1
         blEvVd1eQ9MYxPivOZq1kfRubWClFXmuGbjTdx7Ld8GHEd7U/RcaP08sDTc9cnI8TomM
         cgvs2LIdbKXswOIAMD738+m5tymxfo4diOFvpmb+g+L8p1/52/LbBtBrHT6PmR3UvBZF
         Y9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731410; x=1790336210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EiY/TSJNOxMMy8e6PlWLzVlCOoeYw1PqDh74a6kOopk=;
        b=poURgTwhub0Ditg1GjpHJe7l9A3UJszW6G5tC/ODfhaUxIOxrm1QnfpbznpM1Dhz4Y
         US7EqtPdVG2wXrRbaG19pKbLnQWImnqwI1AUhZBhybI9PoV5fNTwoF92asNzykQVuM1w
         idM75ddMWyG/6ia6HPYpy3iCAoBkWSutz5DXLl6eldCpy/RYxgDRQdCk7seHD/b0MiAo
         WyQ88mLaYtUG30KK3D1PZX65R6b0qNUYX94qIO/P+kU4Byx6ZBkGvpI/BTBANOSvdk1l
         0q8nuUABiE37M5f9ErT2C5Qt9MLXpDAGUHuB6Pfo3DKL+WLp+k64fvO4JzhB0wHJAd3j
         m+Eg==
X-Forwarded-Encrypted: i=1; AKwUvByBNcB0Ihn5jPXyxIPjPW2U9aC+5+6YSznnLnU1yqXHZXmecf94bvDPiHgiIsrhTNVw80Y=@vger.kernel.org
X-Gm-Message-State: AFuF++niZV3m2kVRJhWIryN74HmIvH6FCuDNDqnId64xoq1VKm03rhiG
	gCzS1G5/bRiPrVzUQ7Pi1G6zMqDvcTXVd6f9TOjTLQfjK8e47gofZEOl/PdeHA==
X-Gm-Gg: AYBFou107xiO15hc/PqK1F2SnJ2SulRCObC1eL37HiLExR/B6BlZWvq068v1SvOSNM6
	mUHGc1SIcHncLcTRC8fsg70Dq3TnmgTA8KygG+tSrdqWCQWjMMcXIQv0TKFdRz8XbFMuI2dcdjx
	1dnMWdF6Xq207JO5CVqizMI5p/yhfDLquCMwESr81XV6vWscHbgMnngM0JghYD+3Sbz0LH0WQHu
	+lIPnRJpmLuRA+HQDRzCGplrfSQD5KEDrQvwOu2D6XOO48Rl8th4y6MCHoKNvuJ4EFX7cpk1vNJ
	ahBJs56pmXcW8pte6KWWUohaT5B5SVMeuzd4bRYkxP0k0Q2+uehoMNg1mpDu8RVvnO5UoyMsDNO
	pitMLd1i34eeR1PJ7+MwniegZI2P+AdQyyNmaOFdtswFoTfY+pHUKtN+ugbxNuDy6exrbvGoiRw
	T2fuBYwYigUFu2MaH/FvGPH4SrpnoMwduGGP/iPg8gHS8+yWdjiUAujX5FVEVWpOnEwV9RzatXa
	lVWLfGEWZ3S
X-Received: by 2002:a17:90b:2b8e:b0:39d:f024:c7ee with SMTP id 98e67ed59e1d1-39e5500a842mr4964155a91.25.1789731409674;
        Fri, 18 Sep 2026 04:36:49 -0700 (PDT)
Received: from 10-86-27-207.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c28723bafsm5137011eec.15.2026.09.18.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:36:49 -0700 (PDT)
From: Gokul K <gokul02k@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: selftests: Delete the unused sparsebit copy and count helpers
Date: Fri, 18 Sep 2026 17:06:29 +0530
Message-ID: <20260918113631.634233-2-gokul02k@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918113631.634233-1-gokul02k@gmail.com>
References: <20260918113631.634233-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sparsebit_copy() and sparsebit_num_set() have no callers.  Nor does the
FUZZ harness at the bottom of lib/sparsebit.c, which exercises most of
the rest of the API and still builds and links with both removed.

sparsebit_copy() was the only non-recursive caller of
node_copy_subtree(), which leaves that unreachable too.  It is static,
so keeping it would trip -Wunused-function; delete it as well.

The comment on the num_set member gives sparsebit_num_set() as the
reason the count is maintained.  The member stays - it is what lets
sparsebit_all_set() answer in O(1), and the dump path prints it - so
point the comment at what still uses it.

No functional change intended.

Signed-off-by: Gokul K <gokul02k@gmail.com>
---
 .../testing/selftests/kvm/include/sparsebit.h |  2 -
 tools/testing/selftests/kvm/lib/sparsebit.c   | 63 +------------------
 2 files changed, 1 insertion(+), 64 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/sparsebit.h b/tools/testing/selftests/kvm/include/sparsebit.h
index e027e5790946..8a2ab11dae6f 100644
--- a/tools/testing/selftests/kvm/include/sparsebit.h
+++ b/tools/testing/selftests/kvm/include/sparsebit.h
@@ -30,7 +30,6 @@ typedef u64 sparsebit_num_t;
 
 struct sparsebit *sparsebit_alloc(void);
 void sparsebit_free(struct sparsebit **sbitp);
-void sparsebit_copy(struct sparsebit *dstp, const struct sparsebit *src);
 
 bool sparsebit_is_set(const struct sparsebit *sbit, sparsebit_idx_t idx);
 bool sparsebit_is_set_num(const struct sparsebit *sbit,
@@ -38,7 +37,6 @@ bool sparsebit_is_set_num(const struct sparsebit *sbit,
 bool sparsebit_is_clear(const struct sparsebit *sbit, sparsebit_idx_t idx);
 bool sparsebit_is_clear_num(const struct sparsebit *sbit,
 			    sparsebit_idx_t idx, sparsebit_num_t num);
-sparsebit_num_t sparsebit_num_set(const struct sparsebit *sbit);
 bool sparsebit_any_set(const struct sparsebit *sbit);
 bool sparsebit_any_clear(const struct sparsebit *sbit);
 bool sparsebit_all_set(const struct sparsebit *sbit);
diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 4d845000de15..8ce230af4f14 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -184,8 +184,7 @@ struct sparsebit {
 
 	/*
 	 * A redundant count of the total number of bits set.  Used for
-	 * diagnostic purposes and to change the time complexity of
-	 * sparsebit_num_set() from O(n) to O(1).
+	 * diagnostic purposes and to answer sparsebit_all_set() in O(1).
 	 * Note: Due to overflow, a value of 0 means none or all set.
 	 */
 	sparsebit_num_t num_set;
@@ -269,39 +268,6 @@ static struct node *node_prev(const struct sparsebit *s, struct node *np)
 }
 
 
-/* Allocates space to hold a copy of the node sub-tree pointed to by
- * subtree and duplicates the bit settings to the newly allocated nodes.
- * Returns the newly allocated copy of subtree.
- */
-static struct node *node_copy_subtree(const struct node *subtree)
-{
-	struct node *root;
-
-	/* Duplicate the node at the root of the subtree */
-	root = calloc(1, sizeof(*root));
-	if (!root) {
-		perror("calloc");
-		abort();
-	}
-
-	root->idx = subtree->idx;
-	root->mask = subtree->mask;
-	root->num_after = subtree->num_after;
-
-	/* As needed, recursively duplicate the left and right subtrees */
-	if (subtree->left) {
-		root->left = node_copy_subtree(subtree->left);
-		root->left->parent = root;
-	}
-
-	if (subtree->right) {
-		root->right = node_copy_subtree(subtree->right);
-		root->right->parent = root;
-	}
-
-	return root;
-}
-
 /* Searches for and returns a pointer to the node that describes the setting
  * of the bit given by idx.  A node describes the setting of a bit if its
  * index is within the bits described by the mask bits or the number of
@@ -964,22 +930,6 @@ void sparsebit_free(struct sparsebit **sbitp)
 	*sbitp = NULL;
 }
 
-/* Makes a copy of the sparsebit array given by s, to the sparsebit
- * array given by d.  Note, d must have already been allocated via
- * sparsebit_alloc().  It can though already have bits set, which
- * if different from src will be cleared.
- */
-void sparsebit_copy(struct sparsebit *d, const struct sparsebit *s)
-{
-	/* First clear any bits already set in the destination */
-	sparsebit_clear_all(d);
-
-	if (s->root) {
-		d->root = node_copy_subtree(s->root);
-		d->num_set = s->num_set;
-	}
-}
-
 /* Returns whether num consecutive bits starting at idx are all set.  */
 bool sparsebit_is_set_num(const struct sparsebit *s,
 	sparsebit_idx_t idx, sparsebit_num_t num)
@@ -1035,17 +985,6 @@ bool sparsebit_is_clear_num(const struct sparsebit *s,
 	return next_set == 0 || next_set - idx >= num;
 }
 
-/* Returns the total number of bits set.  Note: 0 is also returned for
- * the case of all bits set.  This is because with all bits set, there
- * is 1 additional bit set beyond what can be represented in the return
- * value.  Use sparsebit_any_set(), instead of sparsebit_num_set() > 0,
- * to determine if the sparsebit array has any bits set.
- */
-sparsebit_num_t sparsebit_num_set(const struct sparsebit *s)
-{
-	return s->num_set;
-}
-
 /* Returns whether any bit is set in the sparsebit array.  */
 bool sparsebit_any_set(const struct sparsebit *s)
 {
-- 
2.54.0


