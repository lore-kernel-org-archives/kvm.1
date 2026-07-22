Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEC3191D6
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784679354; cv=none; b=uJDDBo4Ecv9EQ6sBPiGB1kopYN7M0xlK8r6uo3eEkeeetQ7ygVOsmrxnt2h0OUaSwfvwrcTNvs7XKHOUv6bQyXCbfC7002ygBCEYgYS6f8sIUFt1AiWiH2PTIF9iJy3jhisufJOk1hytFhQTfw/8XGalff6/2dq4JfP00yw/Pf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784679354; c=relaxed/simple;
	bh=CyqVWFJKhdjZZeW6oCD79hj9ow+t23S9RMWtKThbXt4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NK8ynAv7dh3O2q7+32OBBGbAueN7IE8Sc5Q8d1RFmKDr7xjFGw8eN/KddldUYuN2TW18xyn191bi5Pgs/cwbVqdZVZNv4ylSG5LVlx2GlBUCXhOJxiwKeCgekzmXbG1fpgXxz7Z/c8T9phDosVWPfnlbR52nE3mZVMfxNm2W/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNZqhKa3; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNZqhKa3"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso3478836a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784679348; x=1785284148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OcSVBvE6dCwYoJRa7BsGgfHeCjoSQwGXcD7G6E4aFuA=;
        b=KNZqhKa3LKcxsZRzKBlboFenzwzkaP/i+p+KY0O0rKfTWMeJsIWPP0ECYk/om74HEl
         ZVFFquBowQ8x6Uv56IgVdD1ptQmgGclYg0rOhFXJPGR/j5te8LVWsTwfqcCguMetI7sQ
         fhCX63oXeUpxLyoGbb+7X0TuQ0wViWaNRmryo+lXYLRCqRdqd4y2jXbxJnuD9Wa1hTeP
         qp77b2HuNvxnMJIAscwTOwPzvy61aBdcxHgB9LBnC1x1mCfAI1b/QhM+JhxgwXAwT7Pu
         4Ua9DLphZGgw+EjPf3GftZrzTQRZ/zoX4qic5pAKO/E0WOObXSbYvbe+PcP1xKxTQYM7
         XWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784679348; x=1785284148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcSVBvE6dCwYoJRa7BsGgfHeCjoSQwGXcD7G6E4aFuA=;
        b=QK7dFVZlEjft8pYNXlLjdPDtucbFNbcsg7FzYLP4LYqRIDlyxrkocWbXpC2YONV3aJ
         YofYU9QVkPw83DJP4yrQJRt/71anGaY/UAPIDkxv82H4E9EWUcf+ipNAE1mdYUiLgV82
         80vKntdOBa9DbZqoFmmYjvI96FloLg82v5IxZkFXSh5pckJTpJ/qCE9OxpJpI/qo6xa2
         ECgc7whFQVY/PiCBzRi7X56WLZnKCu3wEXfRJt4a6eABlxRglBWxfgIkDr1C9yY38l6j
         +9+mitqSiOLRuFPUTYsEvtCN19G+7A6P7zKZetrp8hRy6reBpQgezo86p3JvWjNTtI0a
         yYaw==
X-Forwarded-Encrypted: i=1; AHgh+RoryA/HgcPjP9hc5RmrsBNHZUI84AoKicUEzZF1XH+AU5rKAv10DlQMTEkn2WVjKvvEC/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PHP4cO0s45SxE7+dneAWAdu6J4VqygnQaZ84ZaDqX9SibFyD
	MYx9iuL28uHNTD5Jx5+PsTw1QSABMKfVkvLMiRO9kbkHqiPl2f5163KN5l0KSB+iZ47MrR3NUDk
	+igqjzfo8
X-Received: from pgcv13.prod.google.com ([2002:a05:6a02:530d:b0:c89:7f9:d93a])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9397:b0:3c3:83e8:c211
 with SMTP id adf61e73a8af0-3c3ada1fe89mr22261006637.63.1784679347472; Tue, 21
 Jul 2026 17:15:47 -0700 (PDT)
Date: Wed, 22 Jul 2026 00:15:41 +0000
In-Reply-To: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
X-Developer-Key: i=jrhilke@google.com; a=ed25519; pk=cK+Urrh214DoCHywJiTwhMP+zcs1ofpGrewToO/i/3A=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784679337; l=4509;
 i=jrhilke@google.com; s=20260710; h=from:subject:message-id;
 bh=VGmU399xNoo4pH5/NvUhjWUHFyMHFl2ICfhg1+qYqo8=; b=OAQZ/jJfOS302Re6gqYzhquV0gOAZ495QGOKzVfxJFtjVKDAOXcYRRwC3335kbzrNkPCd9Bp2
 aS+xlYxYnBWAvEy5fPypR6USp6uGOreGqxUDLOUbBLmCD2yVY0Sp9iD
X-Mailer: b4 0.14.3
Message-ID: <20260722-igb_v3_b4-v6-6-0be1d29918d4@google.com>
Subject: [PATCH v6 6/6] vfio: selftests: igb: Recover after DMA-read faults
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Alex Williamson <alex.williamson@nvidia.com>
Content-Type: text/plain; charset="utf-8"

From: Alex Williamson <alex.williamson@nvidia.com>

The mix_and_match test intentionally submits a TX descriptor with an
unmapped source IOVA so that the DMA read fails.  On real 82576
hardware the resulting fault leaves the descriptor engine unable to
service subsequent valid descriptors, so the next memcpy in the same
test iteration times out.

The 82576 datasheet (section 4.2.1.6.1) describes CTRL.RST as the
software mechanism to recover from a hung device.  Empirically
CTRL.RST alone is not sufficient in this state: the visible queue
registers are reinitialized, but the next valid memcpy still posts
descriptors without any TDH/TDT progress in the same process.  A
fresh device open after the failure works, which points to a reset
scope broader than CTRL.RST being required.  The 82576 advertises
PCIe FLR; VFIO_DEVICE_RESET drives FLR and supplies that scope while
preserving the selftest process and its DMA mappings.

Add igb_error_reset_and_reinit() implementing the recovery sequence:
issue VFIO_DEVICE_RESET, re-arm the kernel-side MSI-X trigger against
the still-valid eventfd via vfio_pci_irq_reenable() (this does not
touch the eventfd, which test fixtures may have cached), and
re-program the device via igb_hw_init().  FLR clears EICR and leaves
EIMS=0, so no explicit interrupt mask or cause writes are needed.
igb_hw_init() resets tx_tail/rx_tail to 0 and igb_memcpy_start() zeros
each descriptor before submission, so no ring memset is needed either.

Call this from igb_memcpy_wait() on completion timeout, preceded by a
10 ms delay so that PCIe/IOMMU/AER error handling triggered by the
just-observed DMA fault can release the device lock VFIO_DEVICE_RESET
contends for.  The delay is heuristic and tied to the fault path, so
it lives at the call site rather than inside the reset helper.  The
failed memcpy still returns -ETIMEDOUT; reset recovery only ensures
the next operation starts from a usable device state.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
index 8eaf120330dc..25cac663de1d 100644
--- a/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
+++ b/tools/testing/selftests/vfio/lib/drivers/igb/igb.c
@@ -458,6 +458,28 @@ static void igb_memcpy_start(struct vfio_pci_device *device, iova_t src,
 	igb_write32(igb, E1000_TDT(0), igb->tx_tail);
 }
 
+/*
+ * Reset the device via VFIO_DEVICE_RESET (PCIe FLR on the 82576) and
+ * re-program it.  VFIO_DEVICE_RESET tears down the kernel-side MSI-X
+ * trigger but leaves user-side eventfds intact, so re-arm the trigger
+ * via vfio_pci_irq_reenable() before reprogramming so any caller-cached
+ * eventfd remains valid.
+ *
+ * FLR clears device-side state to power-on reset values (datasheet
+ * 4.2.1.5.1: a PF FLR is "equivalent to a D0->D3->D0 transition"), so
+ * EIMS and EICR come back as 0 from their register-defined initial
+ * values, and igb_hw_init() resets tx_tail/rx_tail to 0.  The next
+ * igb_memcpy_start() will memset each descriptor it touches before
+ * submission, so no explicit IMC/EICR writes or ring memsets are
+ * needed here.
+ */
+static void igb_error_reset_and_reinit(struct vfio_pci_device *device)
+{
+	vfio_pci_device_reset(device);
+	vfio_pci_msix_reenable(device, MSIX_VECTOR, 1);
+	igb_hw_init(device);
+}
+
 static int igb_memcpy_wait(struct vfio_pci_device *device)
 {
 	struct igb *igb = to_igb_state(device);
@@ -500,7 +522,21 @@ static int igb_memcpy_wait(struct vfio_pci_device *device)
 
 	igb_irq_enable(igb);
 
-	return (status & 1) ? 0 : -ETIMEDOUT;
+	if (status & 1)
+		return 0;
+
+	/*
+	 * The descriptor never completed.  On real 82576 hardware this
+	 * typically follows a DMA-read fault from one of the intentional
+	 * unmapped-IOVA tests; the fault leaves the descriptor engine
+	 * unable to service subsequent valid descriptors.  CTRL.RST alone
+	 * reinitializes the queue registers but leaves the engine wedged
+	 * for the current process, so a broader VFIO_DEVICE_RESET (FLR)
+	 * is required.
+	 */
+	igb_error_reset_and_reinit(device);
+
+	return -ETIMEDOUT;
 }
 
 static void igb_send_msi(struct vfio_pci_device *device)

-- 
2.55.0.229.g6434b31f56-goog

