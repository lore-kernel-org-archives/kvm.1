Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633822;
	b=jbnUau1f5yZWURoK77wyxtzIsawoIUBsuURh7rLCSo4Ptz0v8YYVtcdSyMGol13zV/I2
	 VjKokft7fZ4j6F6iwMw7yzMTkstlA9VWx3x2pwd7+ND4x1UrzERLiEcn6hiCbcEKkYj4/
	 omgVTFbMqwUMrI+CMzUy6ci5ZgyUJOePZdsIf+x3D3GxKotHj0Qexa1Oc1ySDS8Iyh+Cy
	 sC7BIxGU8qI+3FTewXW9iarlkL3S5qSybCQLic0J174mzUZ70/neF9fd1YxzGhRUus735
	 IUCqwREt2o4Q3c7arfg6nF3x6in4Q00Ur8ilDX6/AOpgoTLuFqmb88Y+Xy6CXrPnKhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=tWmkkGF65geeupdTZHwmY4vWlAPAJsehULkoIO9Oe60=;
	b=dpnZJUGQn748HicXUSt/zFUJwQLLuYIf3npv6gIOWfAxcEDzHPNMqv+aAMCZf2XiU5+2
	 GKMr+yQRDHS0zosYmWiWNPeZ3/Pmbu8g2TbFCevZKdHnVJjFKWDnjvF5C6ndW2odm4gbi
	 uD88DHwYaTVuW749gH7OUqn6LTDFdphTVcDt0G83kzDlrkTGWtQuSTGdj+o9rSXyRR3U8
	 N6UQppBlgAntZMG2QvxzmkKY2PKDQzFE9rYotf4Ns+TcB1EjVFbMJrhloX4hpxChjj8aD
	 vg+Yhmu45oeP55fyrDKmwpGAFsonVBOXe9baRgvtwUzVozONfwPAphbPDd6LgUwWG8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pgQrCcVC;
	arc=none smtp.remote-ip=209.85.214.198
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F260A6D13
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93F260A6D13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pgQrCcVC
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2eb1f470a57so20749025ad.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633821; x=1794238621; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tWmkkGF65geeupdTZHwmY4vWlAPAJsehULkoIO9Oe60=;
        b=pgQrCcVCuqIfGu07R63VSKMWlEDxs9GdNX2EsULxQcOE0BZzWKZ6GmK5PHNEm0idjx
         2M+oEC12+fRpDn6dRUmPLDEokXLgugMYKTkzHecrwfzNDt78N6oOGHfyGb4cbni5TyCA
         CKpWq9Z6+Yg7kbMc/i4VSaZUB6MBphHA5N3rMG5LNCSBIFSprnPUfDhWO3bANlSrnZvB
         2vzSYlHHzio93GLMzvhk6lTmOP6nAEpTgVSelWNCiw9u+Mv4ai/7dXFu8/G/vJUTY+9R
         LOmW/D6pr0l9LPEot1J2U4tT+Q4UhWkx38EPrhDKsKdzOyianbJUFXKi95rlcLvci+Vh
         3Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633821; x=1794238621;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tWmkkGF65geeupdTZHwmY4vWlAPAJsehULkoIO9Oe60=;
        b=xVf58Y5XTFr+STg3fgTdqX0sxi24ASttrDeTYHOzfWD8drk95O7l3uTxovC102XdnT
         Yy3OyiraeJEjtH3OihWbI5zqMarVdH6weGuGxekO1LdNEPeAp102DcSgyLqSAXZ9sSuw
         JG5XReHsmeL2GDmIKbSpGimr/6LXUsR2H+V3IkrRiQO2AB9NyMwKXnOPVjwW/q7R2GT5
         RETjKs5IKMFjq5OQougYgijCYWOphjxOlCYeSnMWXg8JaaW/NE0rfk7A+m2BKbIuRo1I
         Gtw2vfITVNBLHyod+UTsUr1CytTiwdsah6dTSEIvAMEaTr+flWEmKJbt/EP9xPXrGcwT
         s/6w==
X-Forwarded-Encrypted: i=1; AKwUvByQsbiVV96/bykf87tt6HWVc0TivOBfXR50RxUk8IZGgbSs17EyCXyGf9cKqBcOj9FRboc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+szLk4TjocZLSeJQNsq8ris9+HPFk4bUB+b03wgVn9feCIDD9d
	UJamnCjIP/TgsArO3fl2eJgn7thBod0pT4kr3Km6HoSMIo9Ai4cJNrhY74nTiGmsNyCPS7pdBmh
	Y4J+pUIpQ4g==
X-Received: from plblf11.prod.google.com ([2002:a17:902:fb4b:b0:2ea:7f9c:2ce])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:390c:b0:2ea:778e:8652
 with SMTP id d9443c01a7336-2eb36496179mr99072185ad.14.1793633820958; Mon, 02
 Nov 2026 07:37:00 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:30 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-2-vipinsh@google.com>
Subject: [PATCH v6 01/27] vfio/pci: Factor out the reset logic in VFIO PCI
 device close path
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

vfio_pci_core_disable() is a very long function doing multiple things
like exiting runtime power management, setting device to D0 power,
clearing bus master, clearing irqs, freeing eventfds, releasing device
regions, unmapping PCI bars, and performing device/bus resets.

The upcoming VFIO Liveupdate feature will also need to utilize same
reset logic.

Extract device reset code to a new helper function,
vfio_pci_core_try_reset(), and update vfio_pci_core_disable() to use
this new function.

No functional change intended.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 100 ++++++++++++++++---------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..7b003c3e5a3a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -680,9 +680,60 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_enable);
 
-void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
+static void vfio_pci_core_try_reset(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
 	struct pci_dev *bridge;
+
+	vdev->needs_reset = true;
+
+	/*
+	 * If we have saved state, restore it.  If we can reset the device,
+	 * even better.  Resetting with current state seems better than
+	 * nothing, but saving and restoring current state without reset
+	 * is just busy work.
+	 */
+	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
+		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
+
+		if (!vdev->reset_works)
+			return;
+
+		pci_save_state(pdev);
+	}
+
+	/*
+	 * Disable INTx and MSI, presumably to avoid spurious interrupts
+	 * during reset.  Stolen from pci_reset_function()
+	 */
+	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
+
+	/*
+	 * Try to get the locks ourselves to prevent a deadlock. The
+	 * success of this is dependent on being able to lock the device,
+	 * which is not always possible.
+	 * We can not use the "try" reset interface here, which will
+	 * overwrite the previously restored configuration information.
+	 */
+	if (vdev->reset_works) {
+		bridge = pci_upstream_bridge(pdev);
+		if (bridge && !pci_dev_trylock(bridge))
+			goto out_restore_state;
+		if (pci_dev_trylock(pdev)) {
+			if (!__pci_reset_function_locked(pdev))
+				vdev->needs_reset = false;
+			pci_dev_unlock(pdev);
+		}
+		if (bridge)
+			pci_dev_unlock(bridge);
+	}
+
+out_restore_state:
+	pci_restore_state(pdev);
+}
+
+void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
+{
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
@@ -757,54 +808,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 		kfree(dummy_res);
 	}
 
-	vdev->needs_reset = true;
-
 	vfio_pci_zdev_close_device(vdev);
 
-	/*
-	 * If we have saved state, restore it.  If we can reset the device,
-	 * even better.  Resetting with current state seems better than
-	 * nothing, but saving and restoring current state without reset
-	 * is just busy work.
-	 */
-	if (pci_load_and_free_saved_state(pdev, &vdev->pci_saved_state)) {
-		pci_info(pdev, "%s: Couldn't reload saved state\n", __func__);
-
-		if (!vdev->reset_works)
-			goto out;
-
-		pci_save_state(pdev);
-	}
-
-	/*
-	 * Disable INTx and MSI, presumably to avoid spurious interrupts
-	 * during reset.  Stolen from pci_reset_function()
-	 */
-	pci_write_config_word(pdev, PCI_COMMAND, PCI_COMMAND_INTX_DISABLE);
-
-	/*
-	 * Try to get the locks ourselves to prevent a deadlock. The
-	 * success of this is dependent on being able to lock the device,
-	 * which is not always possible.
-	 * We can not use the "try" reset interface here, which will
-	 * overwrite the previously restored configuration information.
-	 */
-	if (vdev->reset_works) {
-		bridge = pci_upstream_bridge(pdev);
-		if (bridge && !pci_dev_trylock(bridge))
-			goto out_restore_state;
-		if (pci_dev_trylock(pdev)) {
-			if (!__pci_reset_function_locked(pdev))
-				vdev->needs_reset = false;
-			pci_dev_unlock(pdev);
-		}
-		if (bridge)
-			pci_dev_unlock(bridge);
-	}
-
-out_restore_state:
-	pci_restore_state(pdev);
-out:
+	vfio_pci_core_try_reset(vdev);
 	pci_disable_device(pdev);
 
 	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
-- 
2.56.0.317.g454f8302e1-goog

