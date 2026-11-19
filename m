Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046519;
	b=gJou+1u65sMJMr6wa3FfHjGh8P4YANo2y0pXbMKK+X6tASH2v5W6U8ZfqxRQ2fJ7mexk
	 CHVkRXbDvkFAmzVBpUaadg2bYYNa1939sPkGhVhLZr+ZFzZ+V9q+HuJHg6Y/mdj8WLT+a
	 nONuZnDEf1Nj8W3VV7X0d5Ahda3zhN47XbMcwyVp7R+6qTZubXYywU+j0nTzbDd9JM8Rw
	 CagSdNNEKM9az/iPS4c6oXYsVGje+wl3zWRXpncHlEVUq3/fZYEMvvLB/7prssUBvcxD3
	 EDx0Uh19rAynm1gi9xvhnJC77Oyhj0sx9KmyPGo3O5p4YY8vPEFTU17BBkQuxf0GTVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=41FntGxP/JrSQUL3JU9Vl/TX8BufIuwpx4VCpW10ByM=;
	b=z5eejyWCcdhyT0GVbQkPnB90KcY/udhryDf/AGSIFzw6OYbbl0U1h/fJa3ouvAnLGPRi
	 x/f4RDoQfdcok+xqtGxUMEH+wCECyNOrYKmfxV7OlYFIC5PlJT4KixyIA6DlaTQWTW+DR
	 D1j2jvw2vAPHEBnugQxOuDOumdhrO8vlrFlXK5o9hZMIGalaYqgxUFkvuEgBXrNaYfPEs
	 zS28qAvDcptCUcHbguw3uRa0aWtbOVS80dZsXctAgJ1JTnl4Ap0w4ptoZsWrq2UdNN/N+
	 T/8jTlsWhbIkrqbo6bJ83Lr5J9uOeGHwj8acXAQE9nSxha0MdgXfz2wieREu7crzVjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AehvaMbj;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A75606A33D
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A75606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AehvaMbj
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-8615bdcc5cfso1786483a34.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046517; x=1795651317; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=41FntGxP/JrSQUL3JU9Vl/TX8BufIuwpx4VCpW10ByM=;
        b=AehvaMbj1k9TBvJJ1jyf5MdUL6JKJ5hLpUxINJVb0vwuDtavVmkYzsoNnbzoOIS333
         wvS/elj55DI0lBEdV1F0nu3X40NyuNZokt2o0V+JZvznUsP2e8gp+SFdVZEiCgANXZfC
         1iDhaQrKz0Q2qOMJ1ayB9jrIkxUjyYI6VOg9iXiVHHpTpM7FUFA15aPNpJv7r8xWqOMr
         MMM1b9nlh5EU+75pPoHxv0VbZEGQWxIkaMRSUiVo1L4dC/efrkblHg1lyPIhVUygXGLM
         9JSkcIjxT6BtaTfeoNd3zUuKIlCO6uI/UEee2kl5oN0GQzIhi6tWyqknPL4oyKgXiwgm
         mSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046517; x=1795651317;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=41FntGxP/JrSQUL3JU9Vl/TX8BufIuwpx4VCpW10ByM=;
        b=DYn5s0EAJZkKIxBMrOVJgGewjjiuHS14QzEkHDN+GZb3LTnFcNj3Y/HHjUhqtkVFJ0
         P0MCiXjSg861PDjzFx7Ej70R9fMV0/iJth3MSDaZ8D2O/4XJrHpKtjqyw2stx36N3SDt
         q36mYUnCzN/yOXciXSjUBd6XYW5Zmys0lQ86+2c8SNWyQHKuGanenBVw2VxJnMRBnj69
         84dZyrTCwWkGKZmViXUImJWb5/UJW+qZIoYNtF0Kb0ObmMY32nYZGb03FS2J8b2SVUHL
         KNPpd2zT3n1VpOeFjvDO1tbx7iqTivk1k2ZYy5SdnWMleDGT+2FrsaoRqcSW3EwBi5fx
         9mlQ==
X-Gm-Message-State: APuU4Z8noutttOz0hgVWgVQj3ZXA5ztxDYZE+1QdT0lrnP0sCsq4EvPE
	Md6GTtrZOwagtK2x5FgM8GmaKEg2PPKhWv0WiZ5NAHF1b6ITmHAJq1c0FJ/dVUxFphwiuMm+ilg
	AY8ra20M3c44dsG6zc7g+LNFvzS46De1eKTHsBPGY/LjYMZ/X7CoJX8JzMjID5hzaycNqKXDO5s
	Cm6OJuz+PmzwhWbmLlGv0e2Na515GyIYvR+rAWa2wZOG0=
X-Received: from ilsl18.prod.google.com ([2002:a05:6e02:5d2:b0:53d:4922:80ea])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:87d1:b0:571:9bab:e8b7 with SMTP id 5614622812f47-5773ace5fb8mr5271853b6e.0.1795046516811;
 Wed, 18 Nov 2026 16:01:56 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:43 +0000
In-Reply-To: <20261119000151.442543-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119000151.442543-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-2-dmatlack@google.com>
Subject: [PATCH v2 1/8] vfio/pci: Hold memory_lock for all calls to vfio_pci_set_power_state()
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Hold vdev->memory_lock for write when calling vfio_pci_set_power_state()
from vfio_pci_core_disable() and vfio_pci_core_register_device(), and
assert that the lock is held for all power state transitions, not just
transitions out of D0.

vfio_pci_core_disable() calls vfio_pci_set_power_state(vdev, PCI_D0)
without holding memory_lock, which allows it to race with
vfio_pci_core_sriov_configure() when userspace writes to sriov_numvfs
while the device is being closed. If the user left the device in D3hot
via a config space write, both threads can transition the device from
D3hot to D0 concurrently. Since a config space write does not change
the runtime PM status, the device stays RPM_ACTIVE, pm_runtime_resume()
in the close path is a no-op, and vfio_pci_set_power_state() performs
the D3hot->D0 transition.

For devices with vdev->needs_pm_restore set (NoSoftRst-), this can
result in:

 - vfio_pci_core_disable() restoring the PF's BARs after
   vfio_pci_core_sriov_configure() has enabled VFs, since the D3hot->D0
   transition sleeps before restoring device state. This reproduces
   reliably with vfio_pci_power_state_test and triggers the following
   warning:

     vfio-pci 0000:01:00.0: can't update enabled VF BAR0 [mem 0xe0200000000-0xe020001ffff 64bit pref]
     WARNING: drivers/pci/iov.c:1062 at pci_iov_update_resource+0x170/0x3b0
     Call Trace:
      pci_update_resource+0x1a3/0x5b0
      __pci_set_power_state+0x597/0xb90
      vfio_pci_core_disable+0x13b/0x1180
      vfio_pci_core_close_device+0x144/0x260
      vfio_df_close+0xf2/0x210
      vfio_df_unbind_iommufd+0x89/0x140
      vfio_device_fops_release+0x85/0xf0
      __fput+0x2d6/0x720
      fput_close_sync+0xe8/0x180
      __x64_sys_close+0x7f/0xc0
      do_syscall_64+0xbc/0x320
      entry_SYSCALL_64_after_hwframe+0x76/0x7e

 - Both threads observing pdev->current_state >= PCI_D3hot and calling
   pci_load_and_free_saved_state(pdev, &vdev->pm_save) concurrently,
   resulting in a double-free of vdev->pm_save.

vfio_pci_core_register_device() cannot race with other callers since
the device is not yet registered and device_lock is held across probe,
but take the lock there as well so that the lockdep assertion can be
made unconditional and catch any future unlocked callers.

Taking memory_lock in these paths does not introduce any new lock
dependencies. vfio_pci_core_disable() already acquires memory_lock
under dev_set->lock via vfio_pci_runtime_pm_exit(), and
vfio_pci_core_register_device(), like vfio_pci_core_sriov_configure(),
runs under device_lock, which is already taken before memory_lock.

Fixes: f4162eb1e2fc ("vfio/pci: Change the PF power state to D0 before enabling VFs")
Cc: stable@vger.kernel.org
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index fcbb2da860e2..4289ec9bc32f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -325,12 +325,12 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	bool needs_restore = false, needs_save = false;
 	int ret;
 
+	/* Serialize power state changes and accesses to vdev->pm_save. */
+	lockdep_assert_held_write(&vdev->memory_lock);
+
 	/* Prevent changing power state for PFs with VFs enabled */
-	if (state > PCI_D0) {
-		lockdep_assert_held_write(&vdev->memory_lock);
-		if (vdev->sriov_active)
-			return -EBUSY;
-	}
+	if (state > PCI_D0 && vdev->sriov_active)
+		return -EBUSY;
 
 	if (vdev->needs_pm_restore) {
 		if (pdev->current_state < PCI_D3hot && state >= PCI_D3hot) {
@@ -699,7 +699,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	 * reset without restoring the original state (saved locally in
 	 * 'vdev->pm_save').
 	 */
+	down_write(&vdev->memory_lock);
 	vfio_pci_set_power_state(vdev, PCI_D0);
+	up_write(&vdev->memory_lock);
 
 	/* Stop the device from further DMA */
 	pci_clear_master(pdev);
@@ -2273,7 +2275,9 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
 	 * be able to get to D3.  Therefore first do a D0 transition
 	 * before enabling runtime PM.
 	 */
+	down_write(&vdev->memory_lock);
 	vfio_pci_set_power_state(vdev, PCI_D0);
+	up_write(&vdev->memory_lock);
 
 	pm_runtime_allow(dev);
 	if (!vdev->disable_idle_d3)
-- 
2.56.1.708.g77570a6a1d-goog

