Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6875A1C84DC
	for <kvm@vger.kernel.org>; Sat, 23 May 2026 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512571; cv=none; b=dAIQ8fRm59wYTGWclEV4mfC5oKf3VWopN77qqXh3E7w/HBE8bLk6R96W0hDv/ITXMFM+KkIBX4fYdtueNuS4L0UEogFoPXeAECDjI02gEWUtjV2TZv8ZqQmpuyD6k33aRYGMbnTcxwKrhZTrgWEGGgCr0fnS+b43no0faHT/ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512571; c=relaxed/simple;
	bh=W9ITGv3qxa+WYkFAH41yDgqAQyYvdortQve2uFX62yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEfWYLFrwMFLJlA6/aNTnDwcOIlBBeeQJSzVf00QBWTdM/cNAIiHpcc84NGrh23k6rKYVRnvkXnEYXRYPP0MttTHOluTodh8xRgRcNtAIqOqHUo9voc7ypqRoXgnsRHEakJBFoPdQa+s4B2NSFIJplbKl/fGH7KcLYFGilaJ3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJDQg9/J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJDQg9/J"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba17c8cfacso81924235ad.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 22:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512569; x=1780117369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=leshpFjJpw+iFa3BTxU37ORXazCVi1TrfBnEvsNvsW8=;
        b=YJDQg9/JzFJWM32RnK5Y9NGwKryyiupV/9oed/ENeX9SlLVIMUzjDnu75j+k3LsFiV
         dee1FEtJx75a9VC87lU/4+pprcAREUkeDD73/u5K6az9i+nsyVcYKCWI+bAwfpw9Wdu0
         UfHpy/z2pZPJJsc8UoOSAc4B8t1+I9s9z6KgtuHRirahHFaB4BF3YyrH02tisKPdiE5b
         bCom/j+/DrTZXJlX14HGpbuliSH+0xXKnHCMzpkrw8PdKkaj4An5JlV33Rsy5lkDqFDA
         GhGdVuWaew0/UtSFk9HPg7J54AWTTQpO5lhfgg6QxFMo2+DYCoA0ul1umVqHlbTUpOLf
         OAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512569; x=1780117369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leshpFjJpw+iFa3BTxU37ORXazCVi1TrfBnEvsNvsW8=;
        b=KRwK0XeXrcpilBK1+VAUBTdqBL96e4o9mG0Eog+Hh37/H7j+WVdvd2I2yYGR6ulP7E
         lwhuoK0gqXb8W7zc74K+SNtm5JpBfAnyokEwlFoTalg7f93LS6NBiyCm0F8EX7FJM2w4
         TB6dD1fOApBt/GI8GwKVPOmf6gbxiwIBpbP3rTMhn+GrdAjd1IxxZoTmoxXcnpAyuzFC
         DOoTy2fh5FDsZFNLtwyV+GXva3q7nnf1WlJ8yLFrcwuX/ZEdAZoSA8kuiAoX03/PuX6x
         SYwfb6kjt1QJgpRQS01rRVQT2n7M4p659vDfudWXczzt0uDv+AfYCJqY+8W4fP7FMEVd
         5HbA==
X-Forwarded-Encrypted: i=1; AFNElJ8njrsf/tm0M2ox4ecOom3CuRaIddLr6j0FqzxDBtgLbV5vLiKBL5imHKrY8OBbAEVFsLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXxV7EguggYKQW71UXfHo7jC1wsxbK/i9Iz2XwFICXF62IbiiM
	T5UZpEpGuks1xbcf8s/USlAxltMuwDQFwP3cIKhbm1UmduyelMVLbtTA
X-Gm-Gg: Acq92OHYM/CKEbiJsBUS66PymG1Mxayz/Yhpik10+mzz5yjc+H7NcduGBN0BA1SJo2F
	GEKS3b9uzoIiiIZ5fnuMtFDMzUQ+D08TM3DYAB2QebknJUjdgjf8lxoWZU9aIO/b9UgE4Zj5vJT
	/pf5p3WhRpEws9jgPVVJyucMBN+lb5UxCq9OLl1FPO8q1C0lcRo1BZbKPR96O2P1SozsP7nAKe8
	jOrNU6NCTqPg7rHdB+oMVKj+seYfNWXkIiVkQODrD18/DeXnnwZTGYk9KRN5D4OPYmn0egNJXnk
	A1L86DXyT/Yu5qNWV5D/j/BPnM7uuR8c3iWMis+1ONghrrL9/cMS0+fKlEWz1Z6b2uf8LZBwDfp
	R8ziMSWiAKkwrgwgHRfT/mtC2hESQFOE4gfhozYebHyFqdoVUi2kgBgfQprUbUKzxK2J/g3eRhF
	TfoXeV6/717vtKpiyWWuWEmG+pkKQzvO9w12Ud7R0nyaxuNDtFRAveEWQ=
X-Received: by 2002:a17:903:298b:b0:2bd:2de3:51a4 with SMTP id d9443c01a7336-2beb0604f43mr70763195ad.27.1779512569475;
        Fri, 22 May 2026 22:02:49 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([14.99.167.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb591d102sm32152325ad.81.2026.05.22.22.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:02:49 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] kvm: vfio: Convert kvm_vfio_file_add() to use CLASS(fd) and guard(mutex)
Date: Sat, 23 May 2026 10:32:42 +0530
Message-ID: <20260523050242.41472-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert manual fget/fput call to CLASS(fd, f) and
mutex_lock/unlock to guard(mutex).

This remove the goto based paths both out_unlock and
out_fput.

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 virt/kvm/vfio.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 9f9acb66cc1e..bb3694d9c0c4 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -144,45 +144,36 @@ static int kvm_vfio_file_add(struct kvm_device *dev, unsigned int fd)
 {
 	struct kvm_vfio *kv = dev->private;
 	struct kvm_vfio_file *kvf;
-	struct file *filp;
-	int ret = 0;
+	struct file *file;
+	CLASS(fd, f)(fd);
 
-	filp = fget(fd);
-	if (!filp)
+	if (fd_empty(f))
 		return -EBADF;
 
+	file = fd_file(f);
+
 	/* Ensure the FD is a vfio FD. */
-	if (!kvm_vfio_file_is_valid(filp)) {
-		ret = -EINVAL;
-		goto out_fput;
-	}
+	if (!kvm_vfio_file_is_valid(file))
+		return -EINVAL;
 
-	mutex_lock(&kv->lock);
+	guard(mutex)(&kv->lock);
 
 	list_for_each_entry(kvf, &kv->file_list, node) {
-		if (kvf->file == filp) {
-			ret = -EEXIST;
-			goto out_unlock;
-		}
+		if (kvf->file == file)
+			return -EEXIST;
 	}
 
 	kvf = kzalloc_obj(*kvf, GFP_KERNEL_ACCOUNT);
-	if (!kvf) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!kvf)
+		return -ENOMEM;
 
-	kvf->file = get_file(filp);
+	kvf->file = get_file(file);
 	list_add_tail(&kvf->node, &kv->file_list);
 
 	kvm_vfio_file_set_kvm(kvf->file, dev->kvm);
 	kvm_vfio_update_coherency(dev);
 
-out_unlock:
-	mutex_unlock(&kv->lock);
-out_fput:
-	fput(filp);
-	return ret;
+	return 0;
 }
 
 static int kvm_vfio_file_del(struct kvm_device *dev, unsigned int fd)
-- 
2.43.0

