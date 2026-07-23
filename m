Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180EE3EDE77
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784797480; cv=none; b=N5JonewKepv9AXCQdlGyKWVEOx4ht/RtUwrcN7DZi/Av3JUllFVbPXMlelxPxN42/gA5O8vQ6mYCZSMvq1ZEyz2xps0otzjI2DiFM5UyLNnOvq3+/ZzMiCTtaMzyCqIWETmpoj5DP2h+Poambsfyy3SMUKEWQR7/VgjWgA8DqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784797480; c=relaxed/simple;
	bh=UlkPFryWaWNqF51ABjxm3hBsSBTolNTJ0VW80GvjZjM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uPeV5LErJoJ43KuSujSK8cDarCxM1y1RKU5/yN0pEt3FPXp7916lUdYjSPcj9riDQdfrmRdyJUZ8FMyJEy65JhCDcQxHXCI+7yeIhafHcBWPGA0GnHtd8YSyjU2sfRHo1z7bKm0fU+pkHGWsy78c1H4nh/p4MF/oSQ2/cQYlNRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aouCmOdP; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aouCmOdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=V8
	9j4LGxjqHI3vxHmNv8NV5BZhOiv873NGJEqyiiQvY=; b=aouCmOdPeRsK6sgDKa
	0zPV4/AA0gSHteRkmekDGPcMavArrJahqPK+oV/H98Xo/rS4W95SFPpRcwy/CEvS
	sXW4h4ld/VoUwAx8O68mGdwQmVhqrt2G8zJ6nW8ABY8p80csukwNqoKApol5yVW0
	rzOS6q712xmqE/IAXBJlR/yrA=
Received: from thinkpadx13gen2i.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3KQEU2WFqy2vpJA--.52286S2;
	Thu, 23 Jul 2026 17:04:21 +0800 (CST)
From: Zongmin Zhou <min_halo@163.com>
To: kvm@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>
Subject: [PATCH kvmtool] arm64: Fix resource leaks in find_pmu_cpumask()
Date: Thu, 23 Jul 2026 17:04:13 +0800
Message-Id: <20260723090413.52218-1-min_halo@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3KQEU2WFqy2vpJA--.52286S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Gw1xKw15AF1fGFW7ZFyrZwb_yoW8Jr1UpF
	srJrWkKrWFgw10kasYq3WDGr15Xa93Aa95ZFWUJw18Ar9xCw4v9FyFvF1rCa1fGrWkCry7
	Gas8t3y5GasIkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UNeOXUUUUU=
X-CM-SenderInfo: pplqsxxdorqiywtou0bp/xtbC0hVuGmph2RUcvgAA3W

From: Zongmin Zhou <zhouzongmin@kylinos.cn>

Close file descriptors on read_file() failure and close the directory
stream before returning from the function.

Signed-off-by: Zongmin Zhou <zhouzongmin@kylinos.cn>
---
 arm64/pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arm64/pmu.c b/arm64/pmu.c
index 78c15f1..b4d7605 100644
--- a/arm64/pmu.c
+++ b/arm64/pmu.c
@@ -75,7 +75,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
 	unsigned long val;
 	ssize_t fd_sz;
 	int fd, ret;
-	DIR *dir;
+	DIR *dir = NULL;
 
 	memset(buf, 0, sizeof(buf));
 
@@ -109,6 +109,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
 		fd_sz = read_file(fd, cpulist, PAGE_SIZE);
 		if (fd_sz < 0) {
 			pmu_id = -errno;
+			close(fd);
 			goto out_free;
 		}
 		close(fd);
@@ -142,6 +143,7 @@ static int find_pmu_cpumask(struct kvm *kvm, cpumask_t *cpumask)
 		fd_sz = read_file(fd, buf, PMU_ID_MAXLEN - 1);
 		if (fd_sz < 0) {
 			pmu_id = -errno;
+			close(fd);
 			goto out_free;
 		}
 		close(fd);
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

