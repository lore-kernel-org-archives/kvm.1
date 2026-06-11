Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE16A3451C6
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162630; cv=none; b=i5YHm8aFpPlzVHkP+Yai/hd/DzJdAOXHgG8AgfWSRN3cCzYtKuUdeZDwcLdIx1WTERufjgjNzZ5PSb/e6O8zGLpdf/P07m8FYhgTHIjsKvZbT7luy2WSqp7RtFWkJUa4pqVkNMlkdQc/BXLQGYkvAVoNGC3ZBYCDPbAplUyB69s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162630; c=relaxed/simple;
	bh=QBBxWW4P2EOIbBSc38NXTlVjZmTEVPegIdLf55t33Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6+AdqLT92Ugd4Zum1JfqNgpDHd1rsoNkH/fWaj8y/4kvP5Y8TovhA9gan/7b2uNS/98GB4adZC9mrzw9t0iaeaX4PTVFOIKw1JMFZl6fogQ3V0PSKE3Q6IaP/bu0fpb7ZCFD1yGmHnX5TL23/cGbiR7bOSbuJASvZHnHvj/76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=abu4GAEI reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="abu4GAEI"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65B6ZnFM023462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 15:35:59 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=aXY+9PaZ9XaHKvBSIeH+b5AgPj/NnaHzLDwsmvH8hlQ=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1781159759; v=1;
        b=abu4GAEI/P1NSGdIuUf+LkZxJ9arCs1yM0WmvQC22lVukFMsafVQiyBskXulpTEa
         QFlcZDFxcxcLBuXmNOqo2ulBDLK9Zop1QUDuKIm+ZDQ3+cpnTBKOtwLi6RLg7PFO
         46vO1YoXM9DePYwhUsZdMFmUB87WBxv3fblz9fiJstitAdb5lr6LBpTGtgpwzk9e
         FnD1lKU9Zd4bRui5tRKhB6km+2fFNZGaiEgTIrl7bvZQ2/FMgziCYDvr9cS5xuxz
         msA2DGW9Si7chAeX3eKHvXpIjzKbJ46q/YigcI2DjnOKOZ5AOAHtjkSFRQagRJ51
         +GeF8IppeFQtrtMu6KA62g==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 11 Jun 2026 15:35:49 +0900
Subject: [PATCH 2/3] system/physmem: Notify RAMBlock migratable and idstr
 changes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ram-v1-2-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
References: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260611-ram-v1-0-a2dacf699718@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Reinoud Zandijk <reinoud@netbsd.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Alex Williamson <alex@shazbot.org>,
        =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
        qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=4261;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=QBBxWW4P2EOIbBSc38NXTlVjZmTEVPegIdLf55t33Pg=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5ZWuE/SPP21AppC647OfWojwvszKfyx32yd33uyFScEF
 XTz6j7qKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmEjYa4b/iXJikZXL8vYxWvQ9
 73hUPLtWf8ISdZ6ZnA38Df0NWlGrGBm2SB7ytVy0e8HWD4+/PitSz5ZfwHeh+UPomqS/1vtm12z
 hAwA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C

The RAM migration code assumes that the set of migratable RAMBlocks and
their idstr values do not change while migration is running. Add
RAMBlockNotifier callbacks for RAM_MIGRATABLE flag and idstr changes so
migration can detect attempts to make such changes at runtime and abort
with a clear error.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/system/ramlist.h |  6 ++++++
 hw/core/numa.c           | 36 ++++++++++++++++++++++++++++++++++++
 system/physmem.c         |  9 +++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/system/ramlist.h b/include/system/ramlist.h
index 32157cc84305..e96de5573eed 100644
--- a/include/system/ramlist.h
+++ b/include/system/ramlist.h
@@ -66,6 +66,9 @@ struct RAMBlockNotifier {
                             void *host, size_t size, size_t max_size);
     void (*ram_block_removed)(RAMBlockNotifier *n, const RAMBlock *rb,
                               void *host, size_t size, size_t max_size);
+    void (*ram_block_set_migratable)(RAMBlockNotifier *n, const RAMBlock *rb);
+    void (*ram_block_unset_migratable)(RAMBlockNotifier *n, const RAMBlock *rb);
+    void (*ram_block_set_idstr)(RAMBlockNotifier *n, const RAMBlock *rb);
     void (*ram_block_resized)(RAMBlockNotifier *n, RAMBlock *rb,
                               size_t new_size);
     QLIST_ENTRY(RAMBlockNotifier) next;
@@ -81,6 +84,9 @@ void ram_block_notify_add(const RAMBlock *rb,
                           void *host, size_t size, size_t max_size);
 void ram_block_notify_remove(const RAMBlock *rb,
                              void *host, size_t size, size_t max_size);
+void ram_block_notify_set_migratable(const RAMBlock *rb);
+void ram_block_notify_unset_migratable(const RAMBlock *rb);
+void ram_block_notify_set_idstr(const RAMBlock *rb);
 void ram_block_notify_resize(RAMBlock *rb, size_t new_size);
 
 GString *ram_block_format(void);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 40acb98bdd0b..0685cd1c6ccc 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -887,6 +887,42 @@ void ram_block_notify_remove(const RAMBlock *rb,
     }
 }
 
+void ram_block_notify_set_migratable(const RAMBlock *rb)
+{
+    RAMBlockNotifier *notifier;
+    RAMBlockNotifier *next;
+
+    QLIST_FOREACH_SAFE(notifier, &ram_list.ramblock_notifiers, next, next) {
+        if (notifier->ram_block_set_migratable) {
+            notifier->ram_block_set_migratable(notifier, rb);
+        }
+    }
+}
+
+void ram_block_notify_unset_migratable(const RAMBlock *rb)
+{
+    RAMBlockNotifier *notifier;
+    RAMBlockNotifier *next;
+
+    QLIST_FOREACH_SAFE(notifier, &ram_list.ramblock_notifiers, next, next) {
+        if (notifier->ram_block_unset_migratable) {
+            notifier->ram_block_unset_migratable(notifier, rb);
+        }
+    }
+}
+
+void ram_block_notify_set_idstr(const RAMBlock *rb)
+{
+    RAMBlockNotifier *notifier;
+    RAMBlockNotifier *next;
+
+    QLIST_FOREACH_SAFE(notifier, &ram_list.ramblock_notifiers, next, next) {
+        if (notifier->ram_block_set_idstr) {
+            notifier->ram_block_set_idstr(notifier, rb);
+        }
+    }
+}
+
 void ram_block_notify_resize(RAMBlock *rb, size_t new_size)
 {
     RAMBlockNotifier *notifier;
diff --git a/system/physmem.c b/system/physmem.c
index 6d00e99270c7..83c9243236a5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1911,11 +1911,17 @@ bool qemu_ram_is_migratable(const RAMBlock *rb)
 
 void qemu_ram_set_migratable(RAMBlock *rb)
 {
+    /* Notify before modifying the ram block. */
+    ram_block_notify_set_migratable(rb);
+
     rb->flags |= RAM_MIGRATABLE;
 }
 
 void qemu_ram_unset_migratable(RAMBlock *rb)
 {
+    /* Notify before modifying the ram block. */
+    ram_block_notify_unset_migratable(rb);
+
     rb->flags &= ~RAM_MIGRATABLE;
 }
 
@@ -1937,6 +1943,9 @@ void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
     assert(new_block);
     assert(!new_block->idstr[0]);
 
+    /* Notify before modifying the ram block. */
+    ram_block_notify_set_idstr(new_block);
+
     if (dev) {
         char *id = qdev_get_dev_path(dev);
         if (id) {

-- 
2.54.0

