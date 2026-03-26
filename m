Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8534D4D5
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 08:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774512526; cv=none; b=TFUnRhQRIGuijtTV3CclGwrWrM5SvxrBJKy3lYlCs1s2G5Lo24bK+Z/LJCIM4MHtBwRMbRJzRSU3UbWANsexX5c3NzIo9Li6lDH57bfYPoxP3i6JNrI0V3q7ZK5JYg8eVS9nN8A1hdEeqsX3SYcQKqDUlihfus+J/B+G78xOPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774512526; c=relaxed/simple;
	bh=sf6ZRopiRtrqEMlCQEVNfp8Vt7nygFqSKsvnUNGcEHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hY37+tfMEj95T/MowRmJXY91W/607ezLQt2mrDNB/7MSO+nwM2K1UfzKS5c+neK8cbjTMWfjlqA1SsZl1TvFrhtHYJ5Ma6Gvcfk/2OVcAP6QAbhPUq0NwgOLILTcPhUSvy3nWYaNihL8tUk4cKG68aj3qZOkvAtUBBJH5u+aeos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LUvHAW7L; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUvHAW7L"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279caef718so663697c88.1
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 01:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774512524; x=1775117324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=LUvHAW7LNoZv8pxT5kMz299rQ3sQw5KTiRBTHyeSYvnHX3ReTAMcmTsE1upIxRTQJS
         hmNH4G4YgL2xFLEo/9apgYlNbmZ0io9gsE2MOl4ahN+ANNKgxlW+T7P2uXY0+C8naLY/
         YComYY787qk4vXbIIAbbO5J3eRGQe7Ew3bY52n57aNxsucOuoYjf2uZTSedFs/mM/6TQ
         b/iKt2GlTUHmuQKHzWKqa4ZuCMHAVuRAj0Q9ZhqmOc5A1NEWmTvp+GvRnxBaPjXRp14z
         Txx1f5CYqN7XhqNZN3ST+xT4jQPUeKXJC7nfyPG2jl4w8tE9LKnZYWmxNrAZgXCMIX10
         qPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774512524; x=1775117324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGMSLi6pfWPDruUV3e3+0duVYRVGge54aYv+ZuYilb8=;
        b=s+78wu/TqqatWw75yvRYM4PU4HHUtsrTtTX2JqxR21IWKwZ0+f9lsZScI/ElYkpsKE
         xinxULSVaf2WJvUJ7LC40Z19DqFoe9Efo0EHO8qupojjSETLL97Kbhh/HtylsyGOrMpA
         jpGJRsvBv252UgUK2q+VFtS7X3YpDJsyKaUd8rJjzKdnjH8ZMJyEXdXjsG8yHF0Q8Z9W
         LFM1vd1OnIi7IB/uR63+C8GH5v6WeaMKrVCxVvs3SdybikFjI2Z4eJSgKG+9T11HlIgV
         wyyfI/fHwf/blErDenV4yumIo8Mzct+GpIZKrd4ANYIJpqPPqStWK4RoWajYteMrJUVs
         FU9w==
X-Forwarded-Encrypted: i=1; AJvYcCUWCHIgwe2BbQpbCHrpGVkwgnJ3LLw7VDQXANCgsXsPmAHThAWDBhNfvUuUQUTSERqhix0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjEy5J8zutsF5n6X4vPhxulWW6YfysOAgr9wuYGdrKOQLnmiuI
	7eISejr6vt2lg8C8/DU80gkFOFgRgzInQ3+p0Fe0jn+9n48ykbOM4IIQk2YBLAgBBdksSFNtwBN
	cPzlbEQ==
X-Received: from dykg12.prod.google.com ([2002:a05:7300:578c:b0:2c0:da3c:9f74])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2c0:f424:b545
 with SMTP id 5a478bee46e88-2c15d350374mr3760721eec.15.1774512523474; Thu, 26
 Mar 2026 01:08:43 -0700 (PDT)
Date: Thu, 26 Mar 2026 01:08:31 -0700
In-Reply-To: <20260326080836.695207-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326080836.695207-2-surenb@google.com>
Subject: [PATCH v5 1/6] mm/vma: cleanup error handling path in vma_expand()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

vma_expand() error handling is a bit confusing with "if (ret) return ret;"
mixed with "if (!ret && ...) ret = ...;". Simplify the code to check
for errors and return immediately after an operation that might fail.
This also makes later changes to this function more readable.
Change variable name for storing the error code from "ret" to "err".

No functional change intended.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 mm/vma.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index a43f3c5d4b3d..ba78ab1f397a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1170,7 +1170,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	vma_flags_t sticky_flags =
 		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
 	vma_flags_t target_sticky;
-	int ret = 0;
+	int err = 0;
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
@@ -1200,12 +1200,16 @@ int vma_expand(struct vma_merge_struct *vmg)
 	 * Note that, by convention, callers ignore OOM for this case, so
 	 * we don't need to account for vmg->give_up_on_mm here.
 	 */
-	if (remove_next)
-		ret = dup_anon_vma(target, next, &anon_dup);
-	if (!ret && vmg->copied_from)
-		ret = dup_anon_vma(target, vmg->copied_from, &anon_dup);
-	if (ret)
-		return ret;
+	if (remove_next) {
+		err = dup_anon_vma(target, next, &anon_dup);
+		if (err)
+			return err;
+	}
+	if (vmg->copied_from) {
+		err = dup_anon_vma(target, vmg->copied_from, &anon_dup);
+		if (err)
+			return err;
+	}
 
 	if (remove_next) {
 		vma_flags_t next_sticky;
-- 
2.53.0.1018.g2bb0e51243-goog

