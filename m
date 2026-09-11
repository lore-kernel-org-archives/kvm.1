Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B84A207C;
	Fri, 11 Sep 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143927; cv=none; b=C6wP2MWfmjxtUX+FBqZtCb0VE4xvec/kw8DQYuZq3uontF5vHuqQvARg44YEB/GZmVY2atLxgHOfI3vyE6VQ6lEpfJdkZ7t3teIbl3o21qs2dTHm1wHGPovBAFUS8kFkCHgKnF4rsU0E0vLiYh9FpoKL8kJGGGb0sCunFU3RYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143927; c=relaxed/simple;
	bh=dH2vxkA8ROexcqJUqin0UZjkpe5QArUwyspnC45DfCk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aZGjuTBnMLoE4jeYGBmg7DLN0DBDcMrT169S2wMs4GE+LkDW8E7z8wBolI10FIcj1nxktUpmNS+lOX++U5MI4jgL5V998vkN+r18YIhRrgiJ2Q1cjClzwIwp7HxGgW6oOHynJ7QMqauQsd9k9NblBarxqYCThUqHCqvaTcM4aIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=bi9e3STL; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="bi9e3STL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789143925; x=1820679925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OHiuXzBjN7NVw5Fx+fWAkLOTrI+yHcmQX49yhGKwouk=;
  b=bi9e3STLX3pYzdmUhEWXkotONk5igIHp8aBgpXtT8xa+ZfAwmwFO6d+7
   jkPmtWh3/GQ1htMLdSlrpF9E2DCfZXeikzwMqfgw2lL5W9eqr8PoI53Pv
   SMvaxKYO+4yE5pABpY/Up7D04lvbiMY8sOtMXOFBWkkx+yS6cZ99xB861
   W/RPNrfKWg5vDY+SjMNJ4+OwlGOsv4kCcFQTPMEVE5F4rZ2iIloVIes1D
   6/VlV97midLIyjVjd/MKBQ/SHYAegDV/kHWEV8NhgqIAw4nDwIoccc3bc
   JG0uurx/SBzegsZrn7ss8H7sk0LnoloDy7n0v9AZFdIuUoCiS7BVZ9Zfz
   g==;
X-CSE-ConnectionGUID: w8sOyRGkQQOOZgxCqkBJ2Q==
X-CSE-MsgGUID: 7qvE7+0CS5W1Qqm1b5+sGA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28349873"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 16:25:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:28617]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.34:2525] with esmtp (Farcaster)
 id f100d2b3-6611-4aa3-b5ae-9134b6dec9ad; Fri, 11 Sep 2026 16:25:23 +0000 (UTC)
X-Farcaster-Flow-ID: f100d2b3-6611-4aa3-b5ae-9134b6dec9ad
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 16:25:22 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 16:25:21 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Alex Williamson <alex@shazbot.org>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH] vfio: Create the group chardev outside vfio.group_lock
Date: Fri, 11 Sep 2026 18:25:13 +0200
Message-ID: <20260911-vfopt-s4-v1-0-98ba1d2ef7ab@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

VFIO holds the global group_lock while allocating, naming, and
registering each group chardev. cdev_device_add() includes device_add()
and the KOBJ_ADD uevent, so unrelated group creation is serialized.

Allocate and name a candidate without the lock, reserve its IOMMU-group
identity on group_list, then build the chardev unlocked. A contender
waits for an unpublished reservation and then retries the lookup.
Keep removal locked through cdev_device_del() so a lookup miss also
guarantees that the chardev name is free.

Suppress the ADD event until publication so a failed construction emits
no uevents.

The ADD uevent also carries per-event cost (env allocation,
kobject_get_path()) and a netlink broadcast that serializes globally under
uevent_sock_mutex; sending it off the lock keeps that global section from
extending vfio.group_lock hold times.

Under parallel device probing this lock is a top contention source; with
the chardev built outside it, it disappears from the enable window's
contention profile entirely.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
vfio.group_lock is held across cdev_device_add() -- device_add() plus
the KOBJ_ADD uevent -- so one group's chardev creation serializes every
unrelated one under the concurrent bring-up of "PCI/IOV: Initialize
virtual functions in parallel" [1]. The patch reserves the group
identity on group_list first, then builds the chardev outside the lock:
three short uncontended holds replace one long contended one.

Lock statistics and SR-IOV init time for 4x PF (NVMe, 255 VFs each), on
the reproducer from the parallel VF initialization cover letter [1]:

  lock_stat:
  Lock                     wait: Before     After   contentions: Before   After
  iommu_probe_device_lock       9154 ms  12367 ms                   783     990
  &vfio.group_lock              3823 ms      0 ms                   730       0
  &root->kernfs_rwsem           1285 ms   2189 ms                 55459   62799
  gdp_mutex                        6 ms    314 ms                    23     191

  vfio.group_lock acquisitions / avg hold  1020 / 378 us -> 3060 / 11 us

  Removing vfio.group_lock contention lets the released concurrency
  re-queue on iommu, kernfs and gdp_mutex, none of which this patch
  touches; the staged sysfs series [2] absorbs most of the kernfs rise.

  Stage                 SR-IOV init time:
  S0 (baseline)         3027 ms
  S1                     999 ms
  S2                     995 ms
  S3                     991 ms
  S4 (this patch)        943 ms

Reproducer disclaimer:
I lean primarily on lock_stat numbers to defend the improvements. In
the reproducer, the residual iommu_probe_device_lock dominates the
window and masks the later series' wall-time gains; reducing that lock
further is out of scope for this set. On real hardware the five series
together cut SR-IOV initialization by 65% [1].

The lock_stat and timing figures come from the public reproducer. The
full series has also been tested on current datacenter server hardware
with thousands of VFs.


[1] https://lore.kernel.org/r/20260911-vfopt-s1-v1-0-693271dc0226@amazon.de
[2] https://lore.kernel.org/r/20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de

 drivers/vfio/group.c | 192 ++++++++++++++++++++++++++++++-------------
 drivers/vfio/vfio.h  |   9 ++
 2 files changed, 146 insertions(+), 55 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..692381151303 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -537,52 +537,157 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
 	group->cdev.owner = THIS_MODULE;
 
 	refcount_set(&group->drivers, 1);
+	init_completion(&group->publish_done);
 	mutex_init(&group->group_lock);
 	spin_lock_init(&group->kvm_ref_lock);
 	INIT_LIST_HEAD(&group->device_list);
 	mutex_init(&group->device_lock);
 	group->iommu_group = iommu_group;
-	/* put in vfio_group_release() */
+	/* put in vfio_device_remove_group() or vfio_group_discard() */
 	iommu_group_ref_get(iommu_group);
 	group->type = type;
 
 	return group;
 }
 
-static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
-		enum vfio_group_type type)
+/*
+ * Undo vfio_group_alloc() for a never-published group: the teardown tail
+ * of vfio_device_remove_group(), except that unlinking the group from
+ * vfio.group_list is the caller's job, under vfio.group_lock.
+ */
+static void vfio_group_discard(struct vfio_group *group)
+{
+	struct iommu_group *iommu_group;
+
+	/*
+	 * An unpublished group holds only vfio_group_alloc()'s reference.
+	 * On a count mismatch, leak rather than free under the other holder.
+	 */
+	if (WARN_ON(refcount_read(&group->drivers) != 1))
+		return;
+	/* No discard site leaves the group findable, so nothing can inc it. */
+	refcount_set(&group->drivers, 0);
+
+	mutex_lock(&group->group_lock);
+	WARN_ON(!list_empty(&group->device_list));
+	if (group->container)
+		vfio_group_detach_container(group);
+	iommu_group = group->iommu_group;
+	group->iommu_group = NULL;
+	mutex_unlock(&group->group_lock);
+
+	iommu_group_put(iommu_group);
+	put_device(&group->dev);
+}
+
+static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
+{
+	struct vfio_device *device;
+
+	mutex_lock(&group->device_lock);
+	list_for_each_entry(device, &group->device_list, group_next) {
+		if (device->dev == dev) {
+			mutex_unlock(&group->device_lock);
+			return true;
+		}
+	}
+	mutex_unlock(&group->device_lock);
+	return false;
+}
+
+/*
+ * vfio.group_lock is held only to claim the identity: a reserved group is
+ * linked on vfio.group_list before the lock drops, so a lookup miss proves
+ * the chardev name is free and a hit on an unpublished group waits for its
+ * builder.  Allocation, naming, and cdev_device_add() all run unlocked.
+ */
+static struct vfio_group *
+vfio_group_find_or_create(struct device *dev, struct iommu_group *iommu_group,
+			  enum vfio_group_type type)
 {
 	struct vfio_group *group;
-	struct vfio_group *ret;
+	struct vfio_group *new;
 	int err;
 
-	lockdep_assert_held(&vfio.group_lock);
-
-	group = vfio_group_alloc(iommu_group, type);
-	if (IS_ERR(group))
+retry:
+	mutex_lock(&vfio.group_lock);
+	group = vfio_group_find_from_iommu(iommu_group);
+	if (group) {
+		if (!group->published) {
+			/*
+			 * Wait unlocked and look up again -- the builder
+			 * can still fail and unlink the group.  The device
+			 * reference keeps the completion alive.
+			 */
+			get_device(&group->dev);
+			mutex_unlock(&vfio.group_lock);
+			while (!wait_for_completion_timeout(&group->publish_done,
+							    10 * HZ))
+				dev_warn(dev, "waiting for vfio group %s registration\n",
+					 dev_name(&group->dev));
+			put_device(&group->dev);
+			goto retry;
+		}
+		if (WARN_ON(vfio_group_has_device(group, dev)))
+			group = ERR_PTR(-EINVAL);
+		else
+			refcount_inc(&group->drivers);
+		mutex_unlock(&vfio.group_lock);
 		return group;
+	}
+
+	mutex_unlock(&vfio.group_lock);
 
-	err = dev_set_name(&group->dev, "%s%d",
-			   group->type == VFIO_NO_IOMMU ? "noiommu-" : "",
+	new = vfio_group_alloc(iommu_group, type);
+	if (IS_ERR(new))
+		return new;
+	err = dev_set_name(&new->dev, "%s%d",
+			   new->type == VFIO_NO_IOMMU ? "noiommu-" : "",
 			   iommu_group_id(iommu_group));
 	if (err) {
-		ret = ERR_PTR(err);
-		goto err_put;
+		vfio_group_discard(new);
+		return ERR_PTR(err);
 	}
 
-	err = cdev_device_add(&group->cdev, &group->dev);
-	if (err) {
-		ret = ERR_PTR(err);
-		goto err_put;
+	mutex_lock(&vfio.group_lock);
+	if (vfio_group_find_from_iommu(iommu_group)) {
+		/* Lost the race; drop ours and take theirs. */
+		mutex_unlock(&vfio.group_lock);
+		vfio_group_discard(new);
+		goto retry;
 	}
+	list_add(&new->vfio_next, &vfio.group_list);
+	mutex_unlock(&vfio.group_lock);
 
-	list_add(&group->vfio_next, &vfio.group_list);
+	/*
+	 * Hold back device_add()'s KOBJ_ADD until publication; on failure,
+	 * suppression also keeps the device_add() unwind from emitting an
+	 * unmatched KOBJ_REMOVE.
+	 */
+	dev_set_uevent_suppress(&new->dev, true);
+	err = cdev_device_add(&new->cdev, &new->dev);
+	if (err) {
+		mutex_lock(&vfio.group_lock);
+		list_del(&new->vfio_next);
+		mutex_unlock(&vfio.group_lock);
+		complete_all(&new->publish_done);
+		vfio_group_discard(new);
+		return ERR_PTR(err);
+	}
 
-	return group;
+	mutex_lock(&vfio.group_lock);
+	new->published = true;
+	mutex_unlock(&vfio.group_lock);
+	complete_all(&new->publish_done);
 
-err_put:
-	put_device(&group->dev);
-	return ret;
+	/*
+	 * Send the deferred ADD unlocked.  The caller still owns the
+	 * drivers reference, so vfio_device_remove_group() cannot reach
+	 * cdev_device_del() before the ADD is sent.
+	 */
+	dev_set_uevent_suppress(&new->dev, false);
+	kobject_uevent(&new->dev.kobj, KOBJ_ADD);
+	return new;
 }
 
 static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
@@ -603,9 +708,11 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	if (ret)
 		goto out_put_group;
 
-	mutex_lock(&vfio.group_lock);
-	group = vfio_create_group(iommu_group, type);
-	mutex_unlock(&vfio.group_lock);
+	/*
+	 * The iommu_group is fresh and private, so the lookup and builder
+	 * wait are unreachable; the shared helper is used for uniformity.
+	 */
+	group = vfio_group_find_or_create(dev, iommu_group, type);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
 		goto out_remove_device;
@@ -620,21 +727,6 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	return ERR_PTR(ret);
 }
 
-static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
-{
-	struct vfio_device *device;
-
-	mutex_lock(&group->device_lock);
-	list_for_each_entry(device, &group->device_list, group_next) {
-		if (device->dev == dev) {
-			mutex_unlock(&group->device_lock);
-			return true;
-		}
-	}
-	mutex_unlock(&group->device_lock);
-	return false;
-}
-
 static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 {
 	struct iommu_group *iommu_group;
@@ -659,17 +751,7 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 	if (!iommu_group)
 		return ERR_PTR(-EINVAL);
 
-	mutex_lock(&vfio.group_lock);
-	group = vfio_group_find_from_iommu(iommu_group);
-	if (group) {
-		if (WARN_ON(vfio_group_has_device(group, dev)))
-			group = ERR_PTR(-EINVAL);
-		else
-			refcount_inc(&group->drivers);
-	} else {
-		group = vfio_create_group(iommu_group, VFIO_IOMMU);
-	}
-	mutex_unlock(&vfio.group_lock);
+	group = vfio_group_find_or_create(dev, iommu_group, VFIO_IOMMU);
 
 	/* The vfio_group holds a reference to the iommu_group */
 	iommu_group_put(iommu_group);
@@ -702,16 +784,16 @@ void vfio_device_remove_group(struct vfio_device *device)
 	if (group->type == VFIO_NO_IOMMU || group->type == VFIO_EMULATED_IOMMU)
 		iommu_group_remove_device(device->dev);
 
-	/* Pairs with vfio_create_group() / vfio_group_get_from_iommu() */
+	/* Pairs with vfio_group_alloc() / vfio_group_find_or_create() */
 	if (!refcount_dec_and_mutex_lock(&group->drivers, &vfio.group_lock))
 		return;
 	list_del(&group->vfio_next);
 
 	/*
-	 * We could concurrently probe another driver in the group that might
-	 * race vfio_device_remove_group() with vfio_get_group(), so we have to
-	 * ensure that the sysfs is all cleaned up under lock otherwise the
-	 * cdev_device_add() will fail due to the name aready existing.
+	 * We could concurrently probe another driver in the group racing this
+	 * removal with vfio_group_find_or_create().  The sysfs name is all
+	 * cleaned up under the lock, so once a creator's lookup misses, the
+	 * name is guaranteed free.
 	 */
 	cdev_device_del(&group->cdev, &group->dev);
 
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..cfc76e5752dd 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -9,6 +9,7 @@
 #include <linux/file.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/completion.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
 
@@ -83,6 +84,14 @@ struct vfio_group {
 	struct list_head		device_list;
 	struct mutex			device_lock;
 	struct list_head		vfio_next;
+	/*
+	 * Reserved on vfio.group_list while the chardev is built; published
+	 * is set when the build succeeds (failure unlinks the group) and is
+	 * accessed only under vfio.group_lock.  publish_done releases
+	 * callers that found the group mid-build.
+	 */
+	bool				published;
+	struct completion		publish_done;
 #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
 	struct list_head		container_next;
 #endif

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.47.3

