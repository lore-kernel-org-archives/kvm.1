Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39126233954
	for <kvm@vger.kernel.org>; Sun, 12 Jul 2026 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783866346; cv=none; b=Pab9ml4BtiTM5wIlfR74hsnYT+8a5boCXzXp4g2VaLLbQalVRYkEBEWNtLuRg3QnVARSzNiHGO+GWWm4Qy1Faxx0V8IlMvkgDmiMZvjW2+TS5VjpJJ6U6DnTmFyI5r4fNJ021ku4IAzO+Z3gRwIKEiFsSOVK+5RVBwHkrFsAeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783866346; c=relaxed/simple;
	bh=4l0mFBJOiD9VR6tHQIXH8PsiJlQlx/e0iU2aPRxHgKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LceH8vRnU6B2i3WD/+M/Pxh/6cIZPxJGt4gXFlIjzIT1AYwStAKle38CU5CWee027Gb+FZMZ8NcmB06UQcuu0SYXu6QhnG24omeiwIrOysdC5rU7c/dQKPGXOHrZQ8zxdYvvRPTBQF0WFAHN6lZOq+N9EtMvlB9VWTBbCVq/B6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EAqZC+2C; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EAqZC+2C"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783866343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfxyrrfIwD9kYVMYsO/FmdMfv3qC4C0W8ePlEH24TgQ=;
	b=EAqZC+2CEL6Hub6G614hH4TGbtrQuTLiwmZbaPkexwbcYXsmI2uwgpdBESlloHgUh/SRW9
	WxyoJPUrAPSCgpRvcu0v6vOT7BVwlNobK9aGh1v4WA/PMSbLZgcPwAhWv10xAaZqxs1Zy0
	CvdPUhkkoaWC/J7SRFYT7PSp6oWvfDA=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: kvm@vger.kernel.org
Cc: kvmarm@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>,
	Fuad Tabba <tabba@google.com>
Subject: [PATCH kvmtool v3 2/4] Remove newline from end of die() aborts
Date: Sun, 12 Jul 2026 15:25:34 +0100
Message-Id: <20260712142536.1391557-3-fuad.tabba@linux.dev>
In-Reply-To: <20260712142536.1391557-1-fuad.tabba@linux.dev>
References: <20260712142536.1391557-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

die() already adds the newline at the end of the string.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 util/util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/util/util.c b/util/util.c
index 6f41e2c..05d49c4 100644
--- a/util/util.c
+++ b/util/util.c
@@ -128,14 +128,14 @@ void *mmap_hugetlbfs(struct kvm *kvm, const char *htlbfs_path, u64 size)
 	unsigned long blk_size;
 
 	if (statfs(htlbfs_path, &sfs) < 0)
-		die("Can't stat %s\n", htlbfs_path);
+		die("Can't stat %s", htlbfs_path);
 
 	if ((unsigned int)sfs.f_type != HUGETLBFS_MAGIC)
-		die("%s is not hugetlbfs!\n", htlbfs_path);
+		die("%s is not hugetlbfs!", htlbfs_path);
 
 	blk_size = (unsigned long)sfs.f_bsize;
 	if (sfs.f_bsize == 0 || blk_size > size) {
-		die("Can't use hugetlbfs pagesize %ld for mem size %lld\n",
+		die("Can't use hugetlbfs pagesize %ld for mem size %lld",
 			blk_size, (unsigned long long)size);
 	}
 
@@ -144,10 +144,10 @@ void *mmap_hugetlbfs(struct kvm *kvm, const char *htlbfs_path, u64 size)
 	snprintf(mpath, PATH_MAX, "%s/kvmtoolXXXXXX", htlbfs_path);
 	fd = mkstemp(mpath);
 	if (fd < 0)
-		die("Can't open %s for hugetlbfs map\n", mpath);
+		die("Can't open %s for hugetlbfs map", mpath);
 	unlink(mpath);
 	if (ftruncate(fd, size) < 0)
-		die("Can't ftruncate for mem mapping size %lld\n",
+		die("Can't ftruncate for mem mapping size %lld",
 			(unsigned long long)size);
 	addr = mmap(NULL, size, PROT_RW, MAP_PRIVATE, fd, 0);
 	close(fd);
-- 
2.39.5

