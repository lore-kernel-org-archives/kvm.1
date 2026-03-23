Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBCE2836A0
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278174; cv=none; b=PYFYkPnW6HBXOOnesYhga8GO/UQcQhujIETe0vHiVRPfJNANgbfQxnFUnIfKUCBgxTy91Zes1mRYVdaUIEXRY03zRFRzKWTyfFY2u+bl2hIURB4DDfv3ip0LmOa2YYY25s4SGmUekElzzfIRgIKulziavSmlRNR2cWJ13AlasVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278174; c=relaxed/simple;
	bh=fbpFFZ1jAqKl5CnxO3wYMbG0pFLrg/9a3R4XLct8zUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVGNntD4ClX+edFhHVezF1Gl4nfFABBD6yDXc4RJFfxyNOLLLMzfMmzhx1sSZ6HbbE69F9zU3nVTJQgWdg7kcb8lP2ODvBPJEAbr7E1UKZ5QJXJjT2NQkjozbE3PzTucZsNUSXhyZE/Gh14UfyccvUsBGkwBy7T8Gbdy48niJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84EDF169C;
	Mon, 23 Mar 2026 08:02:46 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA3C3F73B;
	Mon, 23 Mar 2026 08:02:50 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 2/6] disk/core: Do not modify const strings in disk_img_name_parser()
Date: Mon, 23 Mar 2026 15:02:17 +0000
Message-ID: <20260323150221.49256-3-alexandru.elisei@arm.com>
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

@arg is const char *, but disk_img_name_parser() modifies it, which leads
to a compilation error on x86 with gcc 15.2.1:

disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   27 |                 sep = strstr(arg, ":");

Make a copy of @arg and modify it instead, and be very careful to free it
when no longer needed.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

I followed the instruction from Documentation/io-testing, but I couldn't
get a virtio SCSI disk work in a VM, I kept getting this kvmtool error when
the guest tried to use it:

[    0.154837] virtio_scsi virtio1: 1/0/0 default/read/poll queues
[    0.156965] scsi host0: Virtio SCSI HBA
  Fatal: VHOST_SCSI_SET_ENDPOINT failed 19

I did print disk_image_params->{filename,wwpn,readonly,direct} before and
after the patch and they were identical. Also ran valgrind to make sure
there were no leaks, but I didn't cover all the possible execution flows.

Would be really nice if someone with working virtio-scsi could test this :)

 disk/core.c              | 44 +++++++++++++++++++++++++++-------------
 include/kvm/disk-image.h |  6 +++---
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/disk/core.c b/disk/core.c
index 91db277f7846..b232eece9e73 100644
--- a/disk/core.c
+++ b/disk/core.c
@@ -13,35 +13,42 @@ static int disk_image__close(struct disk_image *disk);
 
 int disk_img_name_parser(const struct option *opt, const char *arg, int unset)
 {
-	const char *cur;
-	char *sep;
+	struct disk_image_params *params;
 	struct kvm *kvm = opt->ptr;
+	char *cur, *sep;
 
 	if (kvm->nr_disks >= MAX_DISK_IMAGES)
 		die("Currently only 4 images are supported");
 
-	kvm->cfg.disk_image[kvm->nr_disks].filename = arg;
-	cur = arg;
+	params = &kvm->cfg.disk_image[kvm->nr_disks];
 
 	if (strncmp(arg, "scsi:", 5) == 0) {
-		sep = strstr(arg, ":");
-		kvm->cfg.disk_image[kvm->nr_disks].wwpn = sep + 1;
+		params->wwpn = strdup(strstr(arg, ":") + 1);
+		if (!params->wwpn)
+			die_perror("strdup");
 
 		/* Old invocation had two parameters. Ignore the second one. */
-		sep = strstr(sep + 1, ":");
+		sep = strstr(params->wwpn, ":");
 		if (sep) {
 			*sep = 0;
 			cur = sep + 1;
+		} else {
+			cur = params->wwpn;
 		}
+	} else {
+		params->filename = strdup(arg);
+		if (!params->filename)
+			die_perror("strdup");
+		cur = params->filename;
 	}
 
 	do {
 		sep = strstr(cur, ",");
 		if (sep) {
 			if (strncmp(sep + 1, "ro", 2) == 0)
-				kvm->cfg.disk_image[kvm->nr_disks].readonly = true;
+				params->readonly = true;
 			else if (strncmp(sep + 1, "direct", 6) == 0)
-				kvm->cfg.disk_image[kvm->nr_disks].direct = true;
+				params->direct = true;
 			*sep = 0;
 			cur = sep + 1;
 		}
@@ -145,8 +152,7 @@ static struct disk_image *disk_image__open(const char *filename, bool readonly,
 static struct disk_image **disk_image__open_all(struct kvm *kvm)
 {
 	struct disk_image **disks;
-	const char *filename;
-	const char *wwpn;
+	char *filename, *wwpn;
 	bool readonly;
 	bool direct;
 	void *err;
@@ -189,18 +195,27 @@ static struct disk_image **disk_image__open_all(struct kvm *kvm)
 			goto error;
 		}
 		disks[i]->debug_iodelay = kvm->cfg.debug_iodelay;
+
+		free(params[i].filename);
+		params[i].filename = NULL;
 	}
 
 	return disks;
 error:
 	for (i = 0; i < count; i++) {
-		if (IS_ERR_OR_NULL(disks[i]))
+		free(params[i].filename);
+
+		if (IS_ERR_OR_NULL(disks[i])) {
+			free(params[i].wwpn);
 			continue;
+		}
 
-		if (disks[i]->wwpn)
+		if (disks[i]->wwpn) {
+			free(disks[i]->wwpn);
 			free(disks[i]);
-		else
+		} else {
 			disk_image__close(disks[i]);
+		}
 	}
 	free(disks);
 	return err;
@@ -236,6 +251,7 @@ static int disk_image__close(struct disk_image *disk)
 	if (disk->fd && close(disk->fd) < 0)
 		pr_warning("close() failed");
 
+	free(disk->wwpn);
 	free(disk);
 
 	return 0;
diff --git a/include/kvm/disk-image.h b/include/kvm/disk-image.h
index bf602b582a3b..cbe91b07af0b 100644
--- a/include/kvm/disk-image.h
+++ b/include/kvm/disk-image.h
@@ -47,9 +47,9 @@ struct disk_image_operations {
 };
 
 struct disk_image_params {
-	const char *filename;
+	char *filename;
 	/* wwpn == World Wide Port Number */
-	const char *wwpn;
+	char *wwpn;
 	bool readonly;
 	bool direct;
 };
@@ -69,7 +69,7 @@ struct disk_image {
 	pthread_t			thread;
 	u64				aio_inflight;
 #endif /* CONFIG_HAS_AIO */
-	const char			*wwpn;
+	char				*wwpn;
 	int				debug_iodelay;
 };
 
-- 
2.53.0

