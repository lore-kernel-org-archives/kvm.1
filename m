Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88454AA037
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378439; cv=none; b=rsrtpBHrqqshoT7BKimApeyJotmbz7IhBrup5ejCB7EF2kJNxStyX8HDx70LAOufYpWWT4yuU7Gs/EV2LZqSBOn6WaKYcfK0EyekrZ+G1hmKc9fSJMxyNLzsPQZc0jfm7pgTNsmVKB5edEFPgnXSgkmC3lrOZK5lWcbQBZWawkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378439; c=relaxed/simple;
	bh=wOiGSHTvuaGU2hGJD2n9TN+YSN62eWKKXnnL46WXyRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAn10nWrHG7OqAzpyDz+i1ZlLsgrgrl9uHJKCysmTUloVhCbOEvQnGruUne4UzxpeLexoQwjTY2KmGCHlPEdwCn5EOYLnYntCT76sun56HUChzNnw/Yo+FHToOh3GFDGSjC5cgdfvpfESoVEYfc4xkexTseS9csaTplC2TAciSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TqzEg1GQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TqzEg1GQ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90f9f8553e0so11497276d6.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378423; x=1788983223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VW5hThLcNiS9B9Y8k40LTfPGZJYf7iWoviGkGwyNijs=;
        b=TqzEg1GQ0mynWcwNXcKYtfBFIQpz9l41oqKUyll6YjdI/vbPvKurVd3ahcqF5Z+9vC
         diu/Sc4/gcVQqbwhZKKA/r4yMh+2LIKGsuHPLT0kudAppx86QSYaPVUdEDZV7CimPozC
         uW0/aBAgRla3TRFKjL13fdzbjOYMSub4btlS7O83eMysyi1D4kPcfCSL9S2qQi6sCZgL
         57JHb85z4KSV4+Pkg8cKbZ59Of6yO84dqwC5vZw6CG5C2STQ+51C1jBqYLKq7algduMm
         gNFo8AkMfCOTy0o5iht6PGXA3YaL9R1B4KFl+Ytl2BlSfzAU2mHJ65Q9S/z6tJIOmncc
         fpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378423; x=1788983223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VW5hThLcNiS9B9Y8k40LTfPGZJYf7iWoviGkGwyNijs=;
        b=RiXB9nXLHXHmW3qAZU3WJmWkgGYyfvJr9QcMDebBVTTYqr3XE9KcCZSoyF91LJku1U
         a3PVXVYl+uW0AiLPx18OYF+7F+Kl1yGjDT0/zFwWEiHhCPi/MbLgOf4JzQ75lG3Fq605
         vBwAKaXBvqSp68T48T6TIAKEz0vUCXhilnJGGH2hFnhI617A2KADF6gM+siwTCZeTfE8
         AKQ5AinzRLy2ZKP43W0fGwy++hkgVDtF2SxwxvNE/NSdaW/+WSexPGymxq0WTR1TebiX
         w+9BYJlLAmuEgqqRejdujLY2bBv3Bf8aNhBUEMQawk8ZYvOqfyVTbA/vgms1oE3DzZWd
         QZYA==
X-Gm-Message-State: AFuF++kelSnFRdhZec6t1ucugbRjat7aBdPm7JcG6STKby443MG4Qzug
	BTBCMbantzB4R9WMbOG3Bayi5LlbwHAjjiiKPYzMmHbp2hB45IDQvgZ0bDLRJ9oI8sU=
X-Gm-Gg: AYBFou1w5UuLoxUv6UAV2p/S0Son/3GXjSMQ69TrKWRLTW4lSnBmHpSW8103GAbFzXs
	44YhIFMWWtZmPEMgeBg9KjnoS11FaHdimAbFLjrVle3SZ1vjzFJJJ9ZJIpYAZ2RxGsXgBmD2wcj
	UTFiFZlg64VrPwdDzLsawmgA87zg00caVoQA+I78KQeUGvBSp8P+qFaeKLK1Gib6N23kj/tWDtu
	wUxy0h0ulFlYds4r9/K2JbZvpMdwVyFemrvaTIPlunb0yCPixHT/uArCp8Nhz0fkPBZC/iNF5ye
	ZEJ6Dyc18JVZSXdbzAg3spmWNfZiFUh3MiDmmeeb365l/u7ZFKmwB87G3BASKhYgtzLv/oVVxDA
	HzwQNgpFv1RJAZyK0SBTXZWrp33fuOlWm1suQGzoi5cPlGaY13qC3sX3VyZ+P+RmSnii5V4i8ex
	jjeDnWhtaLO+hy5PIEjLPV78mGv0yh1818jKp0EyTexrDd/hYPCrwuqJuJqN9+Byw6B1ZLOBU2M
	ZsTIFby392Cpt8tMRqSzrq3nElQD9IaAaBq4qrsUSmMs5HxVg==
X-Received: by 2002:a05:620a:a40f:20b0:939:191c:cac7 with SMTP id af79cd13be357-93960e19503mr738239685a.13.1788378423217;
        Wed, 02 Sep 2026 12:47:03 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm299300585a.16.2026.09.02.12.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:47:02 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	shuah@kernel.org,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH 2/5] mm/mempolicy: add mpol_set_shared_policy_range()
Date: Wed,  2 Sep 2026 15:46:54 -0400
Message-ID: <20260902194657.79075-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902194657.79075-1-gourry@gourry.net>
References: <20260902194657.79075-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpol_set_shared_policy() installs a policy over a VMA's page-offset
range, which is the only programmatic way to populate an inode's
shared policy after init.

Two limitations make it unusable for binding an entire backing inode
from in-kernel code:

- It requires a VMA, so it cannot cover unmapped offsets.
  (e.g. unmapped file folios faulted by pagecache)

- mpol_shared_policy_init(), the only no-VMA installer, reconstructs
  the policy from mpol->w.user_nodemask.  That field is only populated
  for static/relative or mount-string policies.

  a policy built programmatically (e.g. by mempolicy_create()) leaves it
  empty and stores w.cpuset_mems_allowed instead and _init mangles it.

Both matter to a caller that wants a whole inode bound at creation.
guest_memfd is one: it has no VMA at that point and may never gain one
for a given offset, and it builds its policy in-kernel rather than from
a mount string, so neither existing installer can express it.

Add mpol_set_shared_policy_range(), which installs an already-built,
fully contextualised policy verbatim over an arbitrary [start, end)
page range with no VMA.

Reimplement mpol_set_shared_policy() as a thin wrapper that derives
the range from the VMA, so both share a single underlying path.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Assisted-by: Claude:claude-opus-4-8
---
 include/linux/mempolicy.h |  2 ++
 mm/mempolicy.c            | 35 +++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index aef018ad92317..398318175cec7 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -124,6 +124,8 @@ int vma_dup_policy(struct vm_area_struct *src, struct vm_area_struct *dst);
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol);
 int mpol_set_shared_policy(struct shared_policy *sp,
 			   struct vm_area_struct *vma, struct mempolicy *mpol);
+int mpol_set_shared_policy_range(struct shared_policy *sp, pgoff_t start,
+				 pgoff_t end, struct mempolicy *mpol);
 void mpol_free_shared_policy(struct shared_policy *sp);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    pgoff_t idx);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index da133ffe0b1c8..ce10ce4374643 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -3312,24 +3312,47 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 }
 EXPORT_SYMBOL_FOR_MODULES(mpol_shared_policy_init, "kvm");
 
-int mpol_set_shared_policy(struct shared_policy *sp,
-			struct vm_area_struct *vma, struct mempolicy *pol)
+/**
+ * mpol_set_shared_policy_range - install @pol over [@start, @end) of @sp
+ * @sp:    the shared policy tree
+ * @start: first page offset (inclusive)
+ * @end:   last page offset (exclusive)
+ * @pol:   a fully-built, validated policy, or NULL to clear the range
+ *
+ * Installs @pol over the given range, replacing any overlapping policy.
+ * @sp takes its own reference, the caller retains its reference on @pol.
+ *
+ * The policy is not reconstructed, so the policy is preserved exactly.
+ *
+ * Unlike mpol_set_shared_policy(), no VMA is required, so a range that
+ * is never mapped into a VMA can be covered, including the whole file.
+ *
+ * Return: 0 on success, -ENOMEM on allocation failure.
+ */
+int mpol_set_shared_policy_range(struct shared_policy *sp, pgoff_t start,
+				 pgoff_t end, struct mempolicy *pol)
 {
-	const pgoff_t pgoff = vma_start_pgoff(vma);
-	const pgoff_t pgoff_end = vma_end_pgoff(vma);
 	struct sp_node *new = NULL;
 	int err;
 
 	if (pol) {
-		new = sp_alloc(pgoff, pgoff_end, pol);
+		new = sp_alloc(start, end, pol);
 		if (!new)
 			return -ENOMEM;
 	}
-	err = shared_policy_replace(sp, pgoff, pgoff_end, new);
+	err = shared_policy_replace(sp, start, end, new);
 	if (err && new)
 		sp_free(new);
 	return err;
 }
+EXPORT_SYMBOL_FOR_MODULES(mpol_set_shared_policy_range, "kvm");
+
+int mpol_set_shared_policy(struct shared_policy *sp,
+			struct vm_area_struct *vma, struct mempolicy *pol)
+{
+	return mpol_set_shared_policy_range(sp, vma->vm_pgoff,
+					   vma->vm_pgoff + vma_pages(vma), pol);
+}
 EXPORT_SYMBOL_FOR_MODULES(mpol_set_shared_policy, "kvm");
 
 /* Free a backing policy store on inode delete. */
-- 
2.53.0-Meta

