Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371B25393B
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278171; cv=none; b=YMSjSyQzyV8fj76wSiP0wcAk5Yx/LtuOIEM4myggFWqBNg8vbU7P3Izh2TRVEbwdZTEjTxKjgmfcIya08mxW/23C3o8Rhkd/3NhZIZGekP7Y/GzNwKDPb/wzROpKxPNVe6WNVTpROJXcmxoBQ09CO5FY+sEk2HL9DM9dSKtp/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278171; c=relaxed/simple;
	bh=FWZZVFErfnfTu3eg2iv8rgeJGoD04ju8Lf+c86clM5w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sti9yqw7qf/7N2afpahsI4ZpJiHVgw3UmnprPI78zd63B8itEFjESHEsJbya2IcrdDpy7JZZ7X65vsKeYVYnKyA1JHYvYukQdWiNXg+UXAqpqXesGSw9ldAmmxJ3OKCIa8IAIg0k8fspcc+xCHIGpStCzvUq3q1szTofCBY9Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD8651516;
	Mon, 23 Mar 2026 08:02:43 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B30F03F73B;
	Mon, 23 Mar 2026 08:02:47 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 1/6] virtio: Do not modify const strings in virtio_9p_rootdir_parser()
Date: Mon, 23 Mar 2026 15:02:16 +0000
Message-ID: <20260323150221.49256-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323150221.49256-1-alexandru.elisei@arm.com>
References: <20260323150221.49256-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Even though @arg is of type const char *, virtio_9p_rootdir_parser()
modifies it it if a tag name is specified, leading to the following
compilation error on an x86_64 machine with gcc 15.2.1:

virtio/9p.c:1503:18: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 1503 |         tag_name = strstr(arg, ",");

Fix it by copying @arg to a local string, which can then be modified
in-place.

Also use die_perror() if realpath() fails, to provide more information to
the user.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 virtio/9p.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/virtio/9p.c b/virtio/9p.c
index e6f669c49895..cf3e547d3173 100644
--- a/virtio/9p.c
+++ b/virtio/9p.c
@@ -1491,25 +1491,32 @@ struct virtio_ops p9_dev_virtio_ops = {
 
 int virtio_9p_rootdir_parser(const struct option *opt, const char *arg, int unset)
 {
-	char *tag_name;
-	char tmp[PATH_MAX];
 	struct kvm *kvm = opt->ptr;
+	char *tag_name, *copy;
+	char path[PATH_MAX];
 
+	copy = strdup(arg);
+	if (!copy)
+		die_perror("strdup");
 	/*
 	 * 9p dir can be of the form dirname,tag_name or
 	 * just dirname. In the later case we use the
 	 * default tag name
 	 */
-	tag_name = strstr(arg, ",");
+	tag_name = strstr(copy, ",");
 	if (tag_name) {
 		*tag_name = '\0';
 		tag_name++;
 	}
-	if (realpath(arg, tmp)) {
-		if (virtio_9p__register(kvm, tmp, tag_name) < 0)
+	if (realpath(copy, path)) {
+		if (virtio_9p__register(kvm, path, tag_name) < 0)
 			die("Unable to initialize virtio 9p");
-	} else
-		die("Failed resolving 9p path");
+	} else {
+		die_perror("Failed resolving 9p path");
+	}
+
+	free(copy);
+
 	return 0;
 }
 
-- 
2.53.0

