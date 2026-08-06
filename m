Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C8125AA
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983561; cv=none; b=MnZH3YV+ru1kawDS7fITan2QdU5dvbGwzGepgy3MH2f9LMaz+fb7TihcQXAgG6xkG+MjFwG0EGRp/3cSVkL09lJPIWeoxdMEyFBu6ENIIHDI84HuFL+PayfS7Z4j8KcnY6pcIRxzOC3mdNg2bDT6RFi/5e0yd/6JYGaSEhTUXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983561; c=relaxed/simple;
	bh=pVw3uqLQ74KsE2jtyZ+bAHxm2JvDBHvjmk/3ueKy6ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PFh6J0BPHEeabb2R+mo13GWIGjYpbmAkdPXAKgPnbJ8Bhc2VFUoKgdpPqCjIx9jUsfMGIjcQjYcZxw9k5BlOOMmpv/RFr9k4GieumKwB0ISrsHRhmw/a+Op/yThsZoLTWmWwC1niQdDEBD7cZ6OU0wED5w8QNvowFKbUS5GeCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZESZpyPJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZESZpyPJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=EZ
	08qhvly3JNIVqwZ1l76zEtzFqIVCqCZBpqdoxTOU0=; b=ZESZpyPJ9hpuRrsSnb
	Sxih0gzAr8/jmQ7pn0nCFs1XoUB/Wsu3o7lwz07iaj8ZU2+Nu3ulf+E0y1QAOG9q
	pW0obBd12k9qDknexEdHVby8Tp65UErImJlAe4g9pmDlIMan+ib6sF/32vN4VugD
	Wu1IHzqOEhUfavQW3FBC2dvjg=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXr7c08nNqqAY4Ng--.23109S2;
	Thu, 06 Aug 2026 10:32:21 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: will@kernel.org
Cc: julien.thierry.kdev@gmail.com,
	kvm@vger.kernel.org,
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH kvmtool v2] arm64: Fix resource leaks in find_pmu_cpumask()
Date: Thu,  6 Aug 2026 10:32:18 +0800
Message-Id: <20260806023218.21068-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <amzVh6ILi4rd6PwU@google.com>
References: <amzVh6ILi4rd6PwU@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXr7c08nNqqAY4Ng--.23109S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF18Xw17CF18AFyxtr4xJFb_yoW8Xw4UpF
	srtrW8KrW8KFy8KasYgw1DGr15Xa93XaykZ3yrJw18ArnrGrsYyFWYvFyrGF43GrWkCFy7
	JayDK345G3ZIyFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_3kNUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC9BVB7Gpz8jXb2AAA3R

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Close file descriptors on read_file() failure and close the directory
stream before returning from the function.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
Changes since v1:

Save errno before close() so a close() failure doesn't clobber it,
allowing a single close() for both paths.
---
 arm64/pmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arm64/pmu.c b/arm64/pmu.c
index 78c15f1..ef7faca 100644
--- a/arm64/pmu.c
+++ b/arm64/pmu.c
@@ -75,7 +75,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
 	unsigned long val;
 	ssize_t fd_sz;
 	int fd, ret;
-	DIR *dir;
+	DIR *dir = NULL;
 
 	memset(buf, 0, sizeof(buf));
 
@@ -107,11 +107,12 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
 			goto next_dir;
 
 		fd_sz = read_file(fd, cpulist, PAGE_SIZE);
+		ret = errno;
+		close(fd);
 		if (fd_sz < 0) {
-			pmu_id = -errno;
+			pmu_id = -ret;
 			goto out_free;
 		}
-		close(fd);
 
 		ret = cpulist_parse(cpulist, &pmu_cpumask);
 		if (ret) {
@@ -140,11 +141,12 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
 			goto next_dir;
 
 		fd_sz = read_file(fd, buf, PMU_ID_MAXLEN - 1);
+		ret = errno;
+		close(fd);
 		if (fd_sz < 0) {
-			pmu_id = -errno;
+			pmu_id = -ret;
 			goto out_free;
 		}
-		close(fd);
 
 		val = strtoul(buf, NULL, 10);
 		if (val > INT_MAX) {
@@ -162,6 +164,8 @@ next_dir:
 	}
 
 out_free:
+	if (dir)
+		closedir(dir);
 	free(path);
 	free(cpulist);
 	return pmu_id;
-- 
2.34.1


No virus found
		Checked by Hillstone Network AntiVirus

