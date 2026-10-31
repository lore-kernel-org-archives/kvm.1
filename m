Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793411334;
	b=BNE2UU3bfYCiFbtyeRzcv6PF5o6P6YWlHzW05JnsNsNFhBtZApOzCti3cu2DljMYdaDi
	 +a1TQrSswT0BR0RocyMZrPLxCtnfLugFuqLlDeuA1Bk+CEaV2vi8QtefP+ieKsIguMHqM
	 xLPQhNKL6T/iH39HmGxhRtJeuZDuFzsDhEiOxlZGzqRFjHgI07G1QiGdFXaBaSm8mT1dV
	 SzY/iFwmoQYaK9frpPxckDIF47RCqLKm2x0o+RBb6VQDCcbr9GgjX9kvKQkuRvMmR++Wu
	 R6sJ3ua7C2adjShd/sRIlsflKRH+C7YWtHTWZwYAk7zGkL+JWgCiZ33rwoDC6aPF0Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793411334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DDNUkdp/AZl9JhN6WFKJZe6JzjdwBOldOY8jhM6xHPs=;
	b=QecIL8vfm8s3D+pQSbQOmKz59dyY+SUqTFwW69QUn81opAyrr6GR6IByVb/kdg+7CNsM
	 2bU8rCvO5keS3vY99Z3iBp+ZPm+6FZGWWU2TBrwQMNRSSABEgNy2ZV0cSVyJEHpsz5VIp
	 4rw9L/S71zmxazsSCQDXiPgixd+JLGRx3gjxKL/wYByFPBbSb+5Caw/n5meQD5wEdKOKq
	 iEwVQZi9/j3l9qUTL+k7b5nyBOMkbeP3NU3rJvvoAOzb0SipLozYaBX7Z6ZIJ6E3NEMdl
	 hJAd4Bhum8frYz3bmatl3inNR0wZumONPu6n0dNbloMN9bPNIlFPHfPMkowaR7tKHAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IxhMzQrp;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49F6606A31C
	for <kvm@vger.kernel.org>; Sat, 31 Oct 2026 01:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IxhMzQrp
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2eb0a52d605so26815ad.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793411333; x=1794016133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DDNUkdp/AZl9JhN6WFKJZe6JzjdwBOldOY8jhM6xHPs=;
        b=IxhMzQrpAMb8PtplimjtjnlP2ShmsdO18mqw/JCLA0dTwtuOwmQCeYsvCdggZZsGPh
         Lol1U5Yye/9loC9UodFkk6ArrONa3J4lx55uwV5NjXynTI9uAs7Xc8gxmhrA6AMLMJDi
         tl78OQuFfnM2q24NwsKL5+BldSaX7+2OQiHTbJGLTmQ5JT2M+fgtRj35w5lSLR8/XUN4
         O2sIGccIP8i9bEyVX8ldQyoZQdnRi2zhEaXYZQWgxO8di+SkqCZ4O+hLmMKTRfJ5k4Yw
         wFoa9JW3PXRsGQP6DfxHr+Jlkx9wfkhqxkWWKgvcza0r4b/PkSuyPO9R26cTnVVmsYn6
         Evrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793411333; x=1794016133;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDNUkdp/AZl9JhN6WFKJZe6JzjdwBOldOY8jhM6xHPs=;
        b=qh0xypZQh8uhJqSj9Csp6qcP6UNgnroGcY5wogD6BJe16XEtnszQECxHP28BrBsV1C
         rJ1EID5Q/QRUN8B2/ap6Ol0oR7FxXbE6Wxtglkqi8rinX4AYe6BqWzY0J7vKoOA5TjJa
         IS7d+MMVM56aRQVlgj8+aRdwa4p+8FZDyNbt6RDrVyoLWH84rmD/0vtre7ryhL7hTs2p
         DF3qn3HCbyrvJynz0ZafbX2R/e4YYw9FaShXi7vjgE5aO7RIBrtiIQWGnkztRPCDtEul
         WAzyaoShvm9JwCYriohbNXWhgJW4XdIV8syFc/LNqNGwkHNQv7SDyfEQv3FxQ1kq6Kop
         BmYg==
X-Forwarded-Encrypted: i=1; AKwUvBw7M5y5vaszLKTFfDdo38hKoneFI2BftkjS/CwmHmQWBrrlGTMWvGux3kQuvfqNpXHIu60=@vger.kernel.org
X-Gm-Message-State: AFq9FYK+wnletHVX2CKb7Afj9iChvXHC50YiRubeoEbsdjvhSOKJa42u
	/Md48zrqrQgg6cdP/cdR3uB5K8Bc06tbDV5i7R/ZWjArBQYeZxn5MQNc0VbJVZMr/34Gluf/ei7
	6Zag7c/B0
X-Gm-Gg: AYBFou2E8ev+lxrbH+OuWtRkzVR2X4lhggU7oQ3+fE0FbsmF2Drr4TX9OsSsOmK5nq0
	e3se7NGgcDW7lyElIddgt+nf3kI8ozRAWWZSQ1Ztvb6g4jAGyIwon0zz0l6Yeszw1BbANO4EHwo
	Aw2DiMSGtvBsRHyiPtQA3h3McMS43zkEmWkoMo93MfhilNUka7PabqBnDHuXbwk6P2Zcobv3y/G
	XhOHYhqZ4wEwZHy2n8xkWB3vBttXRuqjJ9gAnuzMaz9mkgSFnGFjUHMxWnmQRaulkOCp3XBOUpJ
	WDvReqS2OdQYyTkbd4yutHxLDnZe5QdYSGg6UC7vLQQ8uG5LOhSxf9zT2x/hBou40bUD9NP0yao
	fnE/4gklxjxR1FPi/fu7zBrB7n3uphV6lTSNi7oRijHY0ZN+ogPd9FfH3wdgp5Ixin7MSBiVzd+
	f0IymhrvwjiSD6opu0c7yjqF2GpSSDgunYlZJgJ3S6oTmmOFnCXkQBgtFOgdt/Y3fTCL+4NM0ZY
	W0G4B317R6SVEOmDqDZvj8fK+2OarckNXfnMY1S4AIs9//VnktF/mWppKSD/FtLADa6VcWuaiD5
	QuDdlOTMZP+FHt0GyEKh6mJz9LlCux1EWsiEsytD0QzbWtXfOrzSDdt4wt6AgydmgUzavz2wyXu
	h3twXTMpeu3tbPnFE0Tk/gg==
X-Received: by 2002:a17:903:1a2b:b0:2ea:7180:3abf with SMTP id d9443c01a7336-2eb019a757fmr21235195ad.15.1793411332583;
        Fri, 30 Oct 2026 18:48:52 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada6c2c28sm444881b3a.43.2026.10.30.18.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 18:48:50 -0700 (PDT)
Date: Sat, 31 Oct 2026 01:48:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	YiFei Zhu <zhuyifei@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 14/18] iommufd: Implement ioctl to mark HWPT for
 preservation
Message-ID: <auVIrh3NVgcYEOIx@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-15-skhawaja@google.com>
 <887b7c7e-38b8-4798-84a5-bf96bc13ef04@linux.intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <887b7c7e-38b8-4798-84a5-bf96bc13ef04@linux.intel.com>

On Fri, Oct 30, 2026 at 03:20:02PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>From: YiFei Zhu <zhuyifei@google.com>
>>
>>Userspace provides a token to mark the HWPT for preservation. Note that
>>this token is not the LUO token that is used to preserve the iommufd.
>>Once all the required HWPT are marked for preservation, the user can
>>preserve the iommufd into LUO. The iommufd will preserve the HWPTs that
>>are marked for preservation.
>>
>>The marked HWPTs are tracked using a new XArray mark protected by a new
>>liveupdate mutex. This mutex will also be used during iommufd
>>preservation to protect against any race with the mark preserve ioctl.
>>
>>The HWPT token will be used during restore to identify this HWPT. The
>>restoration logic is not implemented and will be added later.
>>
>>Reviewed-by: Pranjal Shrivastava <praan@google.com>
>>Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                             |  1 +
>>  drivers/iommu/iommufd/Makefile          |  1 +
>>  drivers/iommu/iommufd/iommufd_private.h | 17 ++++++
>>  drivers/iommu/iommufd/liveupdate.c      | 72 +++++++++++++++++++++++++
>>  drivers/iommu/iommufd/main.c            |  9 ++++
>>  include/uapi/linux/iommufd.h            | 27 ++++++++++
>>  6 files changed, 127 insertions(+)
>>  create mode 100644 drivers/iommu/iommufd/liveupdate.c
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 15e1da41b0cc..78af4e3dc106 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -13738,6 +13738,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
>>  R:	Pranjal Shrivastava <praan@google.com>
>>  L:	iommu@lists.linux.dev
>>  S:	Maintained
>>+F:	drivers/iommu/iommufd/liveupdate.c
>>  F:	drivers/iommu/liveupdate.c
>>  F:	include/linux/iommu-liveupdate.h
>>  F:	include/linux/kho/abi/iommu.h
>>diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
>>index 67207914bb6e..cfd5b4b14ccb 100644
>>--- a/drivers/iommu/iommufd/Makefile
>>+++ b/drivers/iommu/iommufd/Makefile
>>@@ -12,6 +12,7 @@ iommufd-y := \
>>  iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
>>  iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>>+iommufd-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
>>  obj-$(CONFIG_IOMMUFD) += iommufd.o
>>  obj-$(CONFIG_IOMMUFD_DRIVER) += iova_bitmap.o
>>diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>>index eb2e85b27e42..a33b32708afa 100644
>>--- a/drivers/iommu/iommufd/iommufd_private.h
>>+++ b/drivers/iommu/iommufd/iommufd_private.h
>>@@ -44,6 +44,11 @@ struct iommufd_ctx {
>>  	struct file *file;
>>  	struct xarray objects;
>>  	struct xarray groups;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+#define IOMMUFD_OBJ_LIVEUPDATE_MARK XA_MARK_1
>>+	/* @liveupdate_mutex: Protects the preservation of HWPTs. */
>>+	struct mutex liveupdate_mutex;
>>+#endif
>>  	wait_queue_head_t destroy_wait;
>>  	struct rw_semaphore ioas_creation_lock;
>>  	struct maple_tree mt_mmap;
>>@@ -392,6 +397,9 @@ struct iommufd_hwpt_paging {
>>  	bool auto_domain : 1;
>>  	bool enforce_cache_coherency : 1;
>>  	bool nest_parent : 1;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	u64 liveupdate_token;
>>+#endif
>>  	/* Head at iommufd_ioas::hwpt_list */
>>  	struct list_head hwpt_item;
>>  	struct iommufd_sw_msi_maps present_sw_msi;
>>@@ -729,6 +737,15 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
>>  int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>>  void iommufd_hw_queue_destroy(struct iommufd_object *obj);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd);
>>+#else
>>+static inline int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>>+{
>>+	return -ENOTTY;
>>+}
>>+#endif
>>+
>>  #ifdef CONFIG_IOMMUFD_TEST
>>  int iommufd_test(struct iommufd_ucmd *ucmd);
>>  void iommufd_selftest_destroy(struct iommufd_object *obj);
>>diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
>>new file mode 100644
>>index 000000000000..5fb491ff3a3d
>>--- /dev/null
>>+++ b/drivers/iommu/iommufd/liveupdate.c
>>@@ -0,0 +1,72 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+
>>+/*
>>+ * Copyright (C) 2026, Google LLC
>>+ * Author: Samiullah Khawaja <skhawaja@google.com>
>>+ */
>>+
>>+#define pr_fmt(fmt) "iommufd: " fmt
>>+
>>+#include <linux/file.h>
>>+#include <linux/iommufd.h>
>>+#include <linux/liveupdate.h>
>>+
>>+#include "iommufd_private.h"
>>+
>>+int iommufd_hwpt_liveupdate_mark_preserve(struct iommufd_ucmd *ucmd)
>>+{
>>+	struct iommu_hwpt_liveupdate_mark_preserve *cmd = ucmd->cmd;
>>+	struct iommufd_ctx *ictx = ucmd->ictx;
>>+	struct iommufd_hwpt_paging *hwpt;
>>+	struct iommufd_object *obj;
>>+	unsigned long index;
>>+	bool marked = false;
>>+	int rc = 0;
>>+
>>+	hwpt = iommufd_get_hwpt_paging(ucmd, cmd->hwpt_id);
>>+	if (IS_ERR(hwpt))
>>+		return PTR_ERR(hwpt);
>>+
>>+	mutex_lock(&ictx->liveupdate_mutex);
>>+
>>+	xa_lock(&ictx->objects);
>>+
>>+	/* PRI use cases are not supported. */
>>+	if (hwpt->common.fault) {
>>+		rc = -EOPNOTSUPP;
>>+		goto out_unlock;
>>+	}
>>+
>>+	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
>>+		struct iommufd_hwpt_paging *hwpt_marked;
>>+
>>+		if (WARN_ON_ONCE(obj->type != IOMMUFD_OBJ_HWPT_PAGING))
>>+			continue;
>>+
>>+		hwpt_marked = to_hwpt_paging(container_of(obj, struct iommufd_hw_pagetable, obj));
>>+
>>+		if (hwpt_marked == hwpt)
>>+			marked = true;
>>+
>>+		if (hwpt_marked->liveupdate_token == cmd->hwpt_token) {
>>+			if (hwpt_marked == hwpt)
>>+				goto out_unlock;
>>+
>>+			rc = -EADDRINUSE;
>>+			goto out_unlock;
>>+		}
>>+	}
>>+
>>+	__xa_set_mark(&ictx->objects, hwpt->common.obj.id, IOMMUFD_OBJ_LIVEUPDATE_MARK);
>>+
>>+	if (marked)
>>+		pr_warn_ratelimited("Overwriting HWPT liveupdate token from: %llu to %llu\n",
>>+				    hwpt->liveupdate_token, cmd->hwpt_token);
>>+	hwpt->liveupdate_token = cmd->hwpt_token;
>>+
>>+out_unlock:
>>+	xa_unlock(&ictx->objects);
>>+	mutex_unlock(&ictx->liveupdate_mutex);
>>+	iommufd_put_object(ictx, &hwpt->common.obj);
>>+	return rc;
>>+}
>>diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
>>index 9a921b153162..fe8610fd58e3 100644
>>--- a/drivers/iommu/iommufd/main.c
>>+++ b/drivers/iommu/iommufd/main.c
>>@@ -333,6 +333,9 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>>  	init_rwsem(&ictx->ioas_creation_lock);
>>  	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
>>  	xa_init(&ictx->groups);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	mutex_init(&ictx->liveupdate_mutex);
>>+#endif
>>  	ictx->file = filp;
>>  	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
>>  	init_waitqueue_head(&ictx->destroy_wait);
>>@@ -395,6 +398,9 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
>>  	 * iommufd_object_tombstone_user()
>>  	 */
>>  	xa_destroy(&ictx->objects);
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	mutex_destroy(&ictx->liveupdate_mutex);
>>+#endif
>>  	WARN_ON(!xa_empty(&ictx->groups));
>>@@ -440,6 +446,7 @@ union ucmd_buffer {
>>  	struct iommu_hwpt_alloc hwpt;
>>  	struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap;
>>  	struct iommu_hwpt_invalidate cache;
>>+	struct iommu_hwpt_liveupdate_mark_preserve mark_preserve;
>>  	struct iommu_hwpt_set_dirty_tracking set_dirty_tracking;
>>  	struct iommu_ioas_alloc alloc;
>>  	struct iommu_ioas_allow_iovas allow_iovas;
>>@@ -516,6 +523,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>  		 __reserved),
>>  	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>>  		 struct iommu_viommu_alloc, out_viommu_id),
>>+	IOCTL_OP(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE, iommufd_hwpt_liveupdate_mark_preserve,
>>+		 struct iommu_hwpt_liveupdate_mark_preserve, hwpt_token),
>>  #ifdef CONFIG_IOMMUFD_TEST
>>  	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>>  #endif
>>diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>>index 206fa667c782..93372689afec 100644
>>--- a/include/uapi/linux/iommufd.h
>>+++ b/include/uapi/linux/iommufd.h
>>@@ -58,6 +58,7 @@ enum {
>>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>>  	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
>>  	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
>>+	IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE = 0x96,
>>  };
>>  /**
>>@@ -1390,4 +1391,30 @@ struct iommu_hw_queue_alloc {
>>  	__aligned_u64 length;
>>  };
>>  #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
>>+
>>+/**
>>+ * struct iommu_hwpt_liveupdate_mark_preserve - ioctl(IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE)
>>+ * @size: sizeof(struct iommu_hwpt_liveupdate_mark_preserve)
>>+ * @hwpt_id: HW pagetable ID to preserve for liveupdate
>>+ * @hwpt_token: Token to identify this hwpt upon restore
>>+ *
>>+ * The target HWPT will be preserved during iommufd preservation.
>>+ * Only file-based memory mappings (e.g. memfd) are supported for HWPTs marked
>>+ * for preservation. Mapping anonymous memory into a preserved HWPT will result
>>+ * in a failure during the preservation phase.
>>+ *
>>+ * The hwpt_token is provided by userspace. If userspace enters a token
>>+ * already in use within this iommufd, -EADDRINUSE is returned from this ioctl.
>>+ *
>>+ * Note: There is no 'unmark' operation, so any HWPTs pooled in userspace that
>>+ * are marked for preservation must be destroyed after use.
>>+ */
>>+struct iommu_hwpt_liveupdate_mark_preserve {
>>+	__u32 size;
>
>Most iommufd commands have a "flags" member here, so that the uAPI
>struct can be extended later. Why is this one different?

Agreed. I will update this.
>
>>+	__u32 hwpt_id;
>>+	__aligned_u64 hwpt_token;
>>+};
>>+#define IOMMU_HWPT_LIVEUPDATE_MARK_PRESERVE \
>>+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_LIVEUPDATE_MARK_PRESERVE)
>>+
>>  #endif
>
>Otherwise, this patch looks good to me,
>
>Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks for the review,
Sami
