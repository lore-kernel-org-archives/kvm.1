Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6C5286413
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278179; cv=none; b=skRGtD1mmgjTc7xhebccNoFJco7UvmLv+0l3JELYivDFzjasqCU5kxGnzv8r6U8an8K0Aq6ity1cg+Bv998dtFzPlNwJ8B2eHIJLTWsFh7XQ6IMybu4Y0Uo9wD5R2RrGii0VW76/wxy936nBKeN5JB3ek9dpN6qFeuC5UfIymVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278179; c=relaxed/simple;
	bh=artZDPB8a+i4J7IXve7pgC34EmStMjkJjrZkPurcCcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szlW9UXQET6/7OKhXo4b+uQQE4MC9iPU0eCfwzOvIGs7xtSxwmO1JSlJXmQiyVbYB3mcpmJ9R0B8mj7ZZiXhhR0lODeVIASYYqZstdC7FAvnRBHgED0FVvyOvF+C4QccWHys6yOOIwnhZ7b9G5RzdssvVmy0No5794HreGF3SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C488614BF;
	Mon, 23 Mar 2026 08:02:51 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B14A3F73B;
	Mon, 23 Mar 2026 08:02:55 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 4/6] util: Set exit status to errno in die_perror()
Date: Mon, 23 Mar 2026 15:02:19 +0000
Message-ID: <20260323150221.49256-5-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323150221.49256-1-alexandru.elisei@arm.com>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exit with a return code equal to errno in die_perror() to make it easier
for the user to get the error code directly.

As per man 3 perror, errno is undefined after a successful library call, so
save it when entering die_perror().

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 util/util.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/util.c b/util/util.c
index bab4bb394111..fc732200f2dc 100644
--- a/util/util.c
+++ b/util/util.c
@@ -100,8 +100,10 @@ void __pr_debug(const char *debug, ...)
 
 void die_perror(const char *s)
 {
+	int e = errno;
+
 	perror(s);
-	exit(1);
+	exit(e);
 }
 
 void *mmap_hugetlbfs(struct kvm *kvm, const char *htlbfs_path, u64 size)
-- 
2.53.0

