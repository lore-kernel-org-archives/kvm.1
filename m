Received: from outbound.baidu.com (mx21.baidu.com [220.181.3.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3BE3AA4E7;
	Wed, 22 Apr 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776845739; cv=none; b=kTK8W//EW4dWQ+f5JXJ/2jZVgjbja5Z+GkaHNHMZ7N0DbvfgyzKsY+B5WujDGWV/o8CG8xWsb91xUZr94XGfy246Ipbfs0jjhqWWeeEarqycJXUrJp3UXU/dqrPAyD2OehWywhEYbV1MgMR3BrIc0qzA6ODLs92OGOt2so+FtDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776845739; c=relaxed/simple;
	bh=plKUIgB6l2Ed6G5qzisz7CpFSJI2/nUpVobYu+qQ6hU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AiqX+Rbv30iJA0IAkjyvOsrXyYE7OPH9odwBuUBBOsisPyAazUfwW0a0FP05ld6rBdO7VKawMSfnDxRAtveRbVZikh0xTSn2fjHPJAJkmxTRMfxdd7HISeguX0yzoPOt86YCrzBtytopYrwlTDWY64HkAZFAcXg2utaALoI8TnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=f1SckEzd; arc=none smtp.client-ip=220.181.3.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="f1SckEzd"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin
 Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Alistair Popple <apopple@nvidia.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] vfio/pci: Allow disabling idle D3 on a per-device basis
Date: Wed, 22 Apr 2026 04:13:07 -0400
Message-ID: <20260422081307.2550-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1776845597;
	bh=g98MrTgAgCtfmDKyc/pMIFXEUb37beyhxWf3/naYnwg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=f1SckEzdstsX6jYn2EsH5XLiIM3k9SZsh2aytOamqT662MT/ibdqsiE9zvc1VKctF
	 Bn66BQvWarul+50JwcEN/0pKTz50N8/hhs+tjvurqYLXqy4FUdmK8CUgOrJeYZtkGI
	 cZk+26zQd6UBYXA+BxN+Se6PW6vDYItb88lLLVJ4GcTBn3w2jzmo2WgMVUzwXUAMQt
	 42vw8OI95oCTTT/ZSrhs1tBiUPgWnJmCrsnlxBrvC9Nqnwxlmln/yxYNl3R8bIQPld
	 pVP7pdzQcUIgHnp3q6mjRr8TRI7iVnc/SesY7gbw9Y+Q2WymlyT/ryf1H+hlHhxjV9
	 jwYbL122TBJiQ==

From: Li RongQing <lirongqing@baidu.com>

The disable_idle_d3 module parameter currently toggles idle D3 power
management for all devices handled by vfio-pci. This is too coarse for
environments where only specific devices (e.g., certain GPUs or NICs)
have issues with D3 state transition.

For example, some PCIe devices exhibit hardware bugs or firmware issues
when entering or exiting D3 state. These devices may experience PCIe link
speed degradation after transitioning out of D3, reducing from Gen4/Gen5
to lower speeds, which can significantly impact I/O bandwidth. In such
cases, only these problematic devices need to have idle D3 disabled,
rather than all devices globally.

Introduce a new module parameter 'disable_idle_d3_ids' to allow users to
specify a list of vendor:device IDs that should have idle D3 disabled.

To support this, add a 'disable_idle_d3' flag to struct
vfio_pci_core_device. This flag is initialized during device probe
based on both the global 'disable_idle_d3' parameter and the new
'disable_idle_d3_ids' list. All runtime PM decisions are then shifted
to use this per-device flag.

In vfio_pci_dev_set_try_reset(), update the logic to iterate through
all devices in the dev_set and respect their individual D3 settings
when performing a bus reset.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/vfio/pci/vfio_pci.c      |   7 ++-
 drivers/vfio/pci/vfio_pci_core.c | 109 +++++++++++++++++++++++++++++++++++----
 include/linux/vfio_pci_core.h    |   3 +-
 3 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 0c771064c..fd55776 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -60,6 +60,10 @@ static bool disable_denylist;
 module_param(disable_denylist, bool, 0444);
 MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
 
+static char disable_idle_d3_ids[1024];
+module_param_string(disable_idle_d3_ids, disable_idle_d3_ids, sizeof(disable_idle_d3_ids), 0444);
+MODULE_PARM_DESC(disable_idle_d3_ids, "Comma-separated list of vendor:device IDs to disable idle D3");
+
 static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
 {
 	switch (pdev->vendor) {
@@ -262,7 +266,8 @@ static int __init vfio_pci_init(void)
 	is_disable_vga = disable_vga;
 #endif
 
-	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3);
+	vfio_pci_core_set_params(nointxmask, is_disable_vga, disable_idle_d3,
+			disable_idle_d3_ids);
 
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ad52abc..ac037a7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -42,6 +42,73 @@ static bool nointxmask;
 static bool disable_vga;
 static bool disable_idle_d3;
 
+struct vfio_pci_d3_info {
+	struct list_head list;
+	unsigned int vendor;
+	unsigned int device;
+};
+
+/*
+ * disable_idle_d3_list is built in vfio_pci_core_set_params() before
+ * pci_register_driver(), and is read-only after that, so no locking is
+ * needed. It is freed in vfio_pci_core_cleanup() after
+ * pci_unregister_driver() completes.
+ */
+static LIST_HEAD(disable_idle_d3_list);
+
+static void vfio_pci_parse_d3_ids(const char *disable_idle_d3_ids)
+{
+	char *tmp, *p, *id_str;
+
+	if (*disable_idle_d3_ids == '\0')
+		return;
+
+	tmp = kstrdup(disable_idle_d3_ids, GFP_KERNEL);
+	if (!tmp)
+		return;
+
+	p = tmp;
+	while ((id_str = strsep(&p, ","))) {
+		unsigned int v, d;
+		struct vfio_pci_d3_info *info;
+
+		if (*id_str == '\0')
+			continue;
+
+		if (sscanf(id_str, "%x:%x", &v, &d) == 2) {
+			info = kzalloc_obj(*info, GFP_KERNEL);
+			if (!info)
+				break;
+			info->vendor = v;
+			info->device = d;
+			list_add_tail(&info->list, &disable_idle_d3_list);
+		} else
+			pr_warn("vfio-pci: invalid ids '%s'\n", id_str);
+	}
+	kfree(tmp);
+}
+
+static void vfio_pci_free_d3_ids(void)
+{
+	struct vfio_pci_d3_info *info, *next;
+
+	list_for_each_entry_safe(info, next, &disable_idle_d3_list, list) {
+		list_del(&info->list);
+		kfree(info);
+	}
+}
+
+static bool vfio_pci_dev_in_d3_list(struct pci_dev *pdev)
+{
+	struct vfio_pci_d3_info *info;
+
+	list_for_each_entry(info, &disable_idle_d3_list, list) {
+		if (pdev->vendor == info->vendor && pdev->device == info->device)
+			return true;
+	}
+	return false;
+}
+
 static void vfio_pci_eventfd_rcu_free(struct rcu_head *rcu)
 {
 	struct vfio_pci_eventfd *eventfd =
@@ -501,7 +568,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	u16 cmd;
 	u8 msix_pos;
 
-	if (!disable_idle_d3) {
+	if (!vdev->disable_idle_d3) {
 		ret = pm_runtime_resume_and_get(&pdev->dev);
 		if (ret < 0)
 			return ret;
@@ -579,7 +646,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 out_disable_device:
 	pci_disable_device(pdev);
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 	return ret;
 }
@@ -715,7 +782,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
 
 	/* Put the pm-runtime usage counter acquired during enable */
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(&pdev->dev);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
@@ -2107,6 +2174,9 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
+	vdev->disable_idle_d3 = disable_idle_d3 ||
+			vfio_pci_dev_in_d3_list(vdev->pdev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2202,7 +2272,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 
 	dev->driver->pm = &vfio_pci_core_pm_ops;
 	pm_runtime_allow(dev);
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_put(dev);
 
 	ret = vfio_register_group_dev(&vdev->vdev);
@@ -2211,7 +2281,7 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	return 0;
 
 out_power:
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(dev);
 
 	pm_runtime_forbid(dev);
@@ -2230,7 +2300,7 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
 	vfio_pci_vf_uninit(vdev);
 	vfio_pci_vga_uninit(vdev);
 
-	if (!disable_idle_d3)
+	if (!vdev->disable_idle_d3)
 		pm_runtime_get_noresume(&vdev->pdev->dev);
 
 	pm_runtime_forbid(&vdev->pdev->dev);
@@ -2541,6 +2611,7 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	struct vfio_pci_core_device *cur;
 	struct pci_dev *pdev;
 	bool reset_done = false;
+	int ret;
 
 	if (!vfio_pci_dev_set_needs_reset(dev_set))
 		return;
@@ -2554,8 +2625,16 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	 * state. Increment the usage count for all the devices in the dev_set
 	 * before reset and decrement the same after reset.
 	 */
-	if (!disable_idle_d3 && vfio_pci_dev_set_pm_runtime_get(dev_set))
-		return;
+	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
+		if (!cur->disable_idle_d3) {
+			ret = pm_runtime_resume_and_get(&cur->pdev->dev);
+			if (ret < 0) {
+				pci_warn(cur->pdev,
+					"failed to resume device for bus reset, ret=%d\n", ret);
+				goto out;
+			}
+		}
+	}
 
 	if (!pci_reset_bus(pdev))
 		reset_done = true;
@@ -2564,23 +2643,33 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 		if (reset_done)
 			cur->needs_reset = false;
 
-		if (!disable_idle_d3)
+		if (!cur->disable_idle_d3)
+			pm_runtime_put(&cur->pdev->dev);
+	}
+	return;
+
+out:
+	list_for_each_entry_continue_reverse(cur, &dev_set->device_list, vdev.dev_set_list) {
+		if (!cur->disable_idle_d3)
 			pm_runtime_put(&cur->pdev->dev);
 	}
 }
 
 void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3)
+			      bool is_disable_idle_d3, const char *ids)
 {
 	nointxmask = is_nointxmask;
 	disable_vga = is_disable_vga;
 	disable_idle_d3 = is_disable_idle_d3;
+	vfio_pci_free_d3_ids();
+	vfio_pci_parse_d3_ids(ids);
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_set_params);
 
 static void vfio_pci_core_cleanup(void)
 {
 	vfio_pci_uninit_perm_bits();
+	vfio_pci_free_d3_ids();
 }
 
 static int __init vfio_pci_core_init(void)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba74..2062543 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -127,6 +127,7 @@ struct vfio_pci_core_device {
 	bool			needs_pm_restore:1;
 	bool			pm_intx_masked:1;
 	bool			pm_runtime_engaged:1;
+	bool			disable_idle_d3:1;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
@@ -157,7 +158,7 @@ int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      const struct vfio_pci_regops *ops,
 				      size_t size, u32 flags, void *data);
 void vfio_pci_core_set_params(bool nointxmask, bool is_disable_vga,
-			      bool is_disable_idle_d3);
+			      bool is_disable_idle_d3, const char *ids);
 void vfio_pci_core_close_device(struct vfio_device *core_vdev);
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev);
 void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
-- 
2.9.4

