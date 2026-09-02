Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85763C1F46
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378430; cv=none; b=Pnx32A/v2hMbWEnXUu0GWUS3DOE9ptk95EYyFzh1szLC6n78GvoHSKZWgLqs9a1B2j8s8XWnIwyk5nSaTHREvavMoykWO5xNM7C84JPrWKRlLCzd6VOmjOAGCE1Og+ITKuqFKlL+E6Tfwu8d8GRizyhtBxUuqwjo2n+5u2yDq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378430; c=relaxed/simple;
	bh=0nDpyHAZVWDLsoBhhy63Ifby8fFRcSPcb4Ws9onqaLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cb+TB7GvsW3cbiz8hum34bmWGcRlMG7HlKSog19THjBJra+rFcouyaPVK/uUPVVGwxYtZAe7zK7ss6eM5gJ02s8ElJyTxqvaNxWV41DQ2JJ25CJ0tdkLF7WPF9lIVNlNtF+z+Hofjo4CCkmqZNm6mn9k3oVCAenDafeBJC2FQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=FX5lvnqF; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="FX5lvnqF"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-939309d02d6so141300085a.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788378422; x=1788983222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kwKfYOaniBtFKBvRoVSK69Bg/ErimmVxxQRLm+ngzMY=;
        b=FX5lvnqFShYmBHLU90fDe7NqbwVu6vFPjuEsl4uNiisD/EYI0o308OLv+3OxIueOi6
         iqsXFyjNk2mH0BJqLNcR5V+3VXGn+rDLE4+9aot7i96ogfWQHO856zIe7D6qXv6hInrR
         oXyofk4o11G3pisIFIkbBbb6yGKc4RJB5IneWaZ6blnT6YA5hvYWCMMD/ExSqSolrsjt
         nC5q90WycEMzWrzRn3+KIDkCbcbkgBGgpsstozusLOBWB9b0knQznES0P1N5ItKxF86k
         kROKiiixbkDX3jyroXdWbPullQkQi7AgZP5/8wotjmFkGqzLnPbEQRQJQg63IAHUUkyD
         jCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788378422; x=1788983222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kwKfYOaniBtFKBvRoVSK69Bg/ErimmVxxQRLm+ngzMY=;
        b=CB6OROKs45eZEL3uYNOYHNGNEjTNDU/ttakkNdV340mB/ZUNByzDgIFdrxDx5RR7k+
         PJQjNPVjxO11VXNnOLvwdk3wlI/GfigRrIbJ5pIX2Eid1pfDTEVxwiyhD3LlNu7DLjgT
         FcHfRMEoJDsn+zeqPsv66lTvhvqh3G45CM8g+CtppJnu43+mqvAgmbnj+v321SRzMOxP
         OfFfIvqW6L0btkuupjeLc8K01bSsg1PpNkwTpKO6FZHuiDDNFMIqFxMoG4hXYnt/ItZv
         n5GS5x4OCHpWlrBusr/KjLXBJDpJBjfK4bjm94tryAOgbirLh05CxGThUOpwJy53zNJD
         6Q9g==
X-Gm-Message-State: AFuF++kcIyxPaWayIKxDKb6f7drpolWWOtJJqJ5G35+8up1/lXov4l6x
	l0AcMDdQFYYa5LYkhmAl/JdsHihja/J67t+APVkETnNTLpEkl8wW3Fn4669UivYixTw=
X-Gm-Gg: AYBFou2VNSwBn5v78Nxey1SDqXiiboeB+kbgUn3ZZQ8cH/I24c8JSfct1qQtfSyHP7y
	tjhI/i7isjSJZL0EWDbjTKbgUZaExNth61nTb/ioQ0Gx0GD52EhCeR1b+4Vpr8II0zrSPubeWiS
	9eoFBIJqGeqrEgpgDa4OKUViV5+okxzdbMQ6EwER/64ONENU8jV5eD7x9JceMh4PBkoFEPzv0SR
	R2Y8ahvnV38GkwM5iUZJ00K8CtkOOzo4QLI+e9MxXsm/lTnlvLCk4Ha6ptGj5c47uFXYuPlU4UR
	sVidoiioYCcpzqbhA1JBNZKSxhaFVEu2NlyTQ3LF+rjhtaNOc7Qx7X+NHdzk/IWV5ttjHlhIWNe
	q7zfd/1P1N+Qv0NX+NR8GP8qHDVLUsZTbdcu9DisFkVdOAWeqrQvS7JmrA+J1+s0wsnZKFdzXSu
	GU77jhs+ZWQUDsUD45FdE07trVi0LpZKPhqpZdKPkw+NlQCS4OFOIvA641BfBs/ohbv5hNHPZ9c
	uCZnddNv38WUvkxnfeKf+LNdZ1RvsJwO+RIwdQdT450yH6grw==
X-Received: by 2002:a05:620a:4586:b0:930:9585:e08e with SMTP id af79cd13be357-9396f83aa9cmr61071585a.10.1788378421813;
        Wed, 02 Sep 2026 12:47:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f18801asm299300585a.16.2026.09.02.12.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:47:01 -0700 (PDT)
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
	shuah@kernel.org
Subject: [PATCH 1/5] mm/mempolicy: add mempolicy_create()
Date: Wed,  2 Sep 2026 15:46:53 -0400
Message-ID: <20260902194657.79075-2-gourry@gourry.net>
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

do_set_mempolicy() builds a validated policy and installs it into
the current running task.

An in-kernel user that wants to construct a mempolicy wants the same
validation without the install step.

Add mempolicy_create(mode, flags, nodes): it allocates the policy and
contextualises it against the calling task's cpuset, and returns the
mempolicy to the caller (or ERR_PTR on error).

do_set_mempolicy() is deliberately left alone rather than reimplemented
on top of it.  For syscall users, mpol_set_nodemask() and the current
task policy swap must run under the task_lock(current) acquisition.

Export the symbol to kvm for use in guest_memfd integration.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/mempolicy.h |  3 +++
 mm/mempolicy.c            | 40 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 65c732d440d2f..aef018ad92317 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -128,6 +128,9 @@ void mpol_free_shared_policy(struct shared_policy *sp);
 struct mempolicy *mpol_shared_policy_lookup(struct shared_policy *sp,
 					    pgoff_t idx);
 
+struct mempolicy *mempolicy_create(unsigned short mode, unsigned short flags,
+				   nodemask_t *nodes);
+
 struct mempolicy *get_task_policy(struct task_struct *p);
 struct mempolicy *__get_vma_policy(struct vm_area_struct *vma,
 		unsigned long addr, pgoff_t *ilx);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2ad0a5f18280a..da133ffe0b1c8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1085,7 +1085,45 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return vma_replace_policy(vma, new_pol);
 }
 
-/* Set the process memory policy */
+/**
+ * mempolicy_create - build a validated, cpuset-contextualised mempolicy
+ * @mode: MPOL_* mode
+ * @flags: MPOL_F_* flags
+ * @nodes: target nodemask, or NULL (interpreted per @mode; see mpol_new())
+ *
+ * Creates a new policy and constrains it to the task's cpuset.
+ *
+ * The caller owns the returned reference and frees it with mpol_put().
+ *
+ * Return: the policy (NULL for a default policy), or an ERR_PTR on failure.
+ */
+struct mempolicy *mempolicy_create(unsigned short mode, unsigned short flags,
+		nodemask_t *nodes)
+{
+	struct mempolicy *pol;
+	NODEMASK_SCRATCH(scratch);
+	int err;
+
+	if (!scratch)
+		return ERR_PTR(-ENOMEM);
+
+	pol = mpol_new(mode, flags, nodes);
+	if (IS_ERR(pol))
+		goto out;
+
+	task_lock(current);
+	err = mpol_set_nodemask(pol, nodes, scratch);
+	task_unlock(current);
+	if (err) {
+		mpol_put(pol);
+		pol = ERR_PTR(err);
+	}
+out:
+	NODEMASK_SCRATCH_FREE(scratch);
+	return pol;
+}
+EXPORT_SYMBOL_FOR_MODULES(mempolicy_create, "kvm");
+
 static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 			     nodemask_t *nodes)
 {
-- 
2.53.0-Meta

