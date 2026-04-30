Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F750406297
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558546; cv=none; b=ICc5Ug83PDZcxHQalAPAsWOtQDXiNX9aRSq7vSJbvM3Xm9H8pSMWt4yNM0W2K2Y43ZOuStqAealgnx6er33PT0whWmtnEOSjxbIDsJgKcrAT2Fp48Y1HyWfyeGQ2/SGBt47ea3aJb+ihhWpYcmoTl+V5XNsoXZThvV/ZJBPvPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558546; c=relaxed/simple;
	bh=NUgw9VtHhOH1SDxH2pZXbRmyq38I9DnKn/coZE2Y2ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GJGH/jsqUpo+QsOv8X7adnq5wUQ9fZVCURNMtiOAk+ZlvK/krqvBmGwzm+NWlLO8b++rfwHojcC7okjBg0K83bR+8jOHkF/Z4TdlgxYf2wy4ZMDef38YkIP5xj+X3bsTbt1x2w5Hjml9oXeF4GqsVYFehAxo186jwWxZ6b4U+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0y2IHH1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0y2IHH1"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891ad5c074so113165e9.0
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777558541; x=1778163341; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi8NDKusFCMVruLpinmrdqk1EXLTyT/eTQZyAXfJaw0=;
        b=F0y2IHH1/8mNd+6AXEKvWhxp8R2WdiSyu+paRogKzMLLbqOdLWVGXgbzApHXxmgfgN
         l2DBmwm7j7J5K50yzVDKFyfXWmrtfXLKzFlbLmOpp35eW8zn93818dCNBK09Q9whAZ8C
         tRVOEBvtrnBbW0MUboOcdx4e1/nI+JjZbxXqLfhSfEyT+ycUcyGvbyoRvCaRh0w0I68p
         eSoSNpxKFxFhWbjo8EdW4LhBsgi7whfgr3xwb1eK36QzNNLEyJRs2oSG5U3vaRmADBsE
         YQVGg7ijnIK63xlUekX3GthQeSfu+rFNDHABIdm/20hZNKRGVeSHbP53vUxLlw5vvROd
         lP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558541; x=1778163341;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi8NDKusFCMVruLpinmrdqk1EXLTyT/eTQZyAXfJaw0=;
        b=POXlGic3v5MIPU+AcQX5rURTP6uoP+76VBJztIyqzOEbKZNZg2ecuN4kEm/g3tVETc
         Mc2422Yeeap53xmJdZY1OZ7Io0T4cyS0ODEyVG+WJ/8+s4E0iMYeM5xwYpWmdBt534Pf
         8/olzbT0FqfX9+HAr+Vx8M229Xk/Kfu6x0H3E0dzdfLHmbUbHFKx+21K227G01PhcQKR
         9Tu2RgAQlyHwi1cTL9lipCunT52yhd7/jWS7JmWka94/Njo9xiUhj0fwasgKuB4DJkeL
         P4GvabULGeo6D5Z/8t0Xa577Qwrq543togTKP7vQz+YrvnwAQoRNSdD4fVrxIQ71JZyt
         ejLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dLdHyOeQJom7lr/qJ8q8IDHV+UkWXv1h8dCpOKNmOt/DpIkUE3txi1ZSNVaV9x2Btkx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPGdrvorpvUb8+BNimVgGYcm6vfwV51+anxkfWP8xz5fsTgnN
	A7AzCrUPkdMr0TH6ol9Cg/qH7rxReEjru0WeZVtUuH8W9bNDK6s8WwE0As9L+zBWMQ==
X-Gm-Gg: AeBDieuMz5rwMKPPq1x+nNf5gy7ar2TrjLx6XPieZXE+DVR7rJXxo4DPYee6UVmQE9L
	6NzOwIR7Ca3oNyGqd+btAL9JTdt7a/TSrehvBCLxfuqG5bsJxhbS7cMJRDsan8FfxCpfIULEhMz
	5cxskKnBSEhdHxt16ZKyt9zaxvFeMiVEXe4mS0JVJLiYGo+M7jNhnq2sCb1/IZprkRZ41Ue6p7+
	TgJNqf6Kj1QJ1d9+KnDgsTgZQLIiYTOnkJ+VVIH1DUOjKCIcMM20U4oUjYLWxGjmmx62z0mds9v
	4DA6rRkAAG7Jr1ae5OGLm1k+WdyBh2b4awNhh06/VSw+nHGSpNnrVvsBVmWwB4r2EsyJhap0RKU
	yvpZAiNCLlYIMMdh+9PhZA/I64I8R69UYOkSF9e/HeROjmOd3+L2hgmhDE4xxzoYktqIfh9d5Ju
	9SAcgno6OBR976M7uK3yYmIHaCEQ2jH9pCtW2trut9uCKleivtgyZkxILwHW8MbWQpG7Xuq2CNV
	hRkkDmZZw==
X-Received: by 2002:a05:600c:8a17:10b0:48a:6321:87f7 with SMTP id 5b1f17b1804b1-48a83089695mr956005e9.8.1777558540959;
        Thu, 30 Apr 2026 07:15:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:353:619f:ca87:2581])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b9313c9sm44276955e9.11.2026.04.30.07.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:15:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 16:15:33 +0200
Subject: [PATCH] kcov: refactor common handle ID into kcov_common_handle_id
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
X-B4-Tracking: v=1; b=H4sIAAVk82kC/x3MTQqEMAxA4atI1gZq/Ru9irjQGjWMNtKKDIh3n
 +Dywce7IVJgitAmNwS6OLJ4jSxNwK2DXwh50gZrbGWK3ODXyYWB5sGdEtDJvotHldNGaMus/hR
 NOVoaQQ+HOv69965/nj/4b+jTbQAAAA==
X-Change-ID: 20260430-kcov-refactor-common-handle-25178495b2eb
To: Dmitry Vyukov <dvyukov@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, 
 Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777558537; l=7319;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=NUgw9VtHhOH1SDxH2pZXbRmyq38I9DnKn/coZE2Y2ro=;
 b=w1wS50tB8THjaYvysUQGGWgnG9EF+LO73Pv68csEK5kfA8uYeJKksc86HaweNr0lcBbvU9z+c
 08zCfmGaVt/BP/BZ2F0vI+j8BtWW7AcZMbnkIlArjRuP127cTiY62qM
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Store common handle IDs in "struct kcov_common_handle_id", which consumes
no space in non-KCOV builds.
This cleanup removes #ifdef boilerplate code from subsystems that
integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
diffstat).
This should also make it easier to add KCOV remote coverage to more
subsystems in the future.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/usb/usbip/usbip_common.h | 29 +----------------------------
 drivers/usb/usbip/vhci_rx.c      |  4 ++--
 drivers/usb/usbip/vhci_sysfs.c   |  2 +-
 drivers/vhost/vhost.h            |  2 +-
 include/linux/kcov.h             | 12 ++++++------
 include/linux/skbuff.h           | 14 +++-----------
 include/linux/types.h            |  6 ++++++
 kernel/kcov.c                    |  6 +++---
 8 files changed, 23 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 282efca64a01..be4c5e65a7f8 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -282,9 +282,7 @@ struct usbip_device {
 		void (*unusable)(struct usbip_device *);
 	} eh_ops;
 
-#ifdef CONFIG_KCOV
-	u64 kcov_handle;
-#endif
+	struct kcov_common_handle_id kcov_handle;
 };
 
 #define kthread_get_run(threadfn, data, namefmt, ...)			   \
@@ -339,29 +337,4 @@ static inline int interface_to_devnum(struct usb_interface *interface)
 	return udev->devnum;
 }
 
-#ifdef CONFIG_KCOV
-
-static inline void usbip_kcov_handle_init(struct usbip_device *ud)
-{
-	ud->kcov_handle = kcov_common_handle();
-}
-
-static inline void usbip_kcov_remote_start(struct usbip_device *ud)
-{
-	kcov_remote_start_common(ud->kcov_handle);
-}
-
-static inline void usbip_kcov_remote_stop(void)
-{
-	kcov_remote_stop();
-}
-
-#else /* CONFIG_KCOV */
-
-static inline void usbip_kcov_handle_init(struct usbip_device *ud) { }
-static inline void usbip_kcov_remote_start(struct usbip_device *ud) { }
-static inline void usbip_kcov_remote_stop(void) { }
-
-#endif /* CONFIG_KCOV */
-
 #endif /* __USBIP_COMMON_H */
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index a75f4a898a41..a678e7c89837 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -261,9 +261,9 @@ int vhci_rx_loop(void *data)
 		if (usbip_event_happened(ud))
 			break;
 
-		usbip_kcov_remote_start(ud);
+		kcov_remote_start_common(ud->kcov_handle);
 		vhci_rx_pdu(ud);
-		usbip_kcov_remote_stop();
+		kcov_remote_stop();
 	}
 
 	return 0;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 5bc8c47788d4..b98d14c43d13 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -425,7 +425,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	vdev->ud.tcp_rx     = tcp_rx;
 	vdev->ud.tcp_tx     = tcp_tx;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
-	usbip_kcov_handle_init(&vdev->ud);
+	vdev->ud.kcov_handle = kcov_common_handle();
 
 	spin_unlock(&vdev->ud.lock);
 	spin_unlock_irqrestore(&vhci->lock, flags);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 4fe99765c5c7..0192ade6e749 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,7 +44,7 @@ struct vhost_worker {
 	/* Used to serialize device wide flushing with worker swapping. */
 	struct mutex		mutex;
 	struct llist_head	work_list;
-	u64			kcov_handle;
+	struct kcov_common_handle_id kcov_handle;
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 0143358874b0..cdb72b3859d8 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -43,11 +43,11 @@ do {						\
 /* See Documentation/dev-tools/kcov.rst for usage details. */
 void kcov_remote_start(u64 handle);
 void kcov_remote_stop(void);
-u64 kcov_common_handle(void);
+struct kcov_common_handle_id kcov_common_handle(void);
 
-static inline void kcov_remote_start_common(u64 id)
+static inline void kcov_remote_start_common(struct kcov_common_handle_id id)
 {
-	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
+	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id.val));
 }
 
 static inline void kcov_remote_start_usb(u64 id)
@@ -99,11 +99,11 @@ static inline void kcov_prepare_switch(struct task_struct *t) {}
 static inline void kcov_finish_switch(struct task_struct *t) {}
 static inline void kcov_remote_start(u64 handle) {}
 static inline void kcov_remote_stop(void) {}
-static inline u64 kcov_common_handle(void)
+static inline struct kcov_common_handle_id kcov_common_handle(void)
 {
-	return 0;
+	return (struct kcov_common_handle_id){};
 }
-static inline void kcov_remote_start_common(u64 id) {}
+static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
 static inline void kcov_remote_start_usb_softirq(u64 id) {}
 static inline void kcov_remote_stop_softirq(void) {}
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..a3fe418f7ced 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1082,9 +1082,7 @@ struct sk_buff {
 	__u16			network_header;
 	__u16			mac_header;
 
-#ifdef CONFIG_KCOV
-	u64			kcov_handle;
-#endif
+	struct kcov_common_handle_id kcov_handle;
 
 	); /* end headers group */
 
@@ -5437,20 +5435,14 @@ static inline void skb_reset_csum_not_inet(struct sk_buff *skb)
 }
 
 static inline void skb_set_kcov_handle(struct sk_buff *skb,
-				       const u64 kcov_handle)
+				       struct kcov_common_handle_id kcov_handle)
 {
-#ifdef CONFIG_KCOV
 	skb->kcov_handle = kcov_handle;
-#endif
 }
 
-static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
+static inline struct kcov_common_handle_id skb_get_kcov_handle(struct sk_buff *skb)
 {
-#ifdef CONFIG_KCOV
 	return skb->kcov_handle;
-#else
-	return 0;
-#endif
 }
 
 static inline void skb_mark_for_recycle(struct sk_buff *skb)
diff --git a/include/linux/types.h b/include/linux/types.h
index 608050dbca6a..93166b0b0617 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -224,6 +224,12 @@ struct ustat {
 	char			f_fpack[6];
 };
 
+struct kcov_common_handle_id {
+#ifdef CONFIG_KCOV
+	u64 val;
+#endif
+};
+
 /**
  * struct callback_head - callback structure for use with RCU and task_work
  * @next: next update requests in a list
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 0b369e88c7c9..a43e33a28adb 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -1083,11 +1083,11 @@ void kcov_remote_stop(void)
 EXPORT_SYMBOL(kcov_remote_stop);
 
 /* See the comment before kcov_remote_start() for usage details. */
-u64 kcov_common_handle(void)
+struct kcov_common_handle_id kcov_common_handle(void)
 {
 	if (!in_task())
-		return 0;
-	return current->kcov_handle;
+		return (struct kcov_common_handle_id){ .val = 0 };
+	return (struct kcov_common_handle_id){ .val = current->kcov_handle };
 }
 EXPORT_SYMBOL(kcov_common_handle);
 

---
base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
change-id: 20260430-kcov-refactor-common-handle-25178495b2eb

--  
Jann Horn <jannh@google.com>

