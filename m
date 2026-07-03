Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F435675C;
	Fri,  3 Jul 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056213; cv=none; b=mebwN8RU9txU1z/+mL3tUuKN312r+SxjAxR859SIAPeAMmNP0c3QuYxtl9i0LsOrainvoEQlTbYNm78VOA0ZDgV0JOEuY5aWGgKvRgSvc3uoFbGnhmJKTl/5BJseq121KhU5DRlB3D758Kz1UkBqdcHwES/ogw+EX6pcvkDbhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056213; c=relaxed/simple;
	bh=Vv3pUHunatuIlFi+mPBDZxRdUfxT6q4pEQh1tsUM+Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpcGnmsgRR6u+vsyKsvFehhurmmMKVX2LH7C9FrtKweMANn9xyI6rMbcPgNMJzjP842+qhcs335Y++ODl4fkG/DTJ1PvlVySmJGMeLaVCfLN8jXEh5zce4w5LtEzCl2bNALx+viAqCt1JRenwKsHjeSbe89Jum2uuYh1RnRjbu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=gEgffcsn reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="gEgffcsn"
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6635LT8S018373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 14:21:45 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=WU1hr20De0lfszJxA0uPYsBXpl0cfWRc8y3s2m5DLyo=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-Id:To:Subject:Date;
        s=rs20250326; t=1783056105; v=1;
        b=gEgffcsnVdi4RhMOLhBBOniG1feoYZwJT9L5utV6OW+IZhP80LZjkYDeME0aTo3l
         1W16YXUzbn5FUpKcST6EH+3m8+bykMSx5KwFS4+QPzJyIng2Szk/RVurI+V/lIC5
         qkyvSM6hexvMZdwVTbBuiqurNIwrIhX2Srp8j0je94K3O/xub+Bl4hxOpPHfEYSM
         1T/pl6z1nUPTVms6uMYKRsADoT7HwDZyomv04fuCLCZjUbeK/tj5Uv8mhZyXDeGn
         9Bq3BUNw6y9YyrczlqYF/RZWSQayNsUBMdD1hXSff9mmKwL4gso7ZztRW9IW3mux
         skjYUOGS72p628LwPYl1kw==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 03 Jul 2026 14:19:21 +0900
Subject: [PATCH v2 5/7] system/physmem: Notify RAMBlock migratable and
 idstr changes
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-ram-v2-5-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260703-ram-v2-0-7f07fc06fba9@rsg.ci.i.u-tokyo.ac.jp>
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
        kvm@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu.zevorn@gmail.com>, linux-edac@vger.kernel.org,
        qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
        Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-925f5
X-Developer-Signature: v=1; a=openpgp-sha256; l=4261;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=Vv3pUHunatuIlFi+mPBDZxRdUfxT6q4pEQh1tsUM+Qo=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5a726ND9w/dXfQpO81K6NZK4facBVzav74u1818Y1XX4
 lIfGVLQUcrCIMbFICumyJJStJtbI7r2U2FCfAvMHFYmkCEMXJwCMBEnDYb/6fOf2K58tvDttid3
 V5/6czJNMrJ+bnzsu6Kt7qe/pNmc+MTI8OLW3dSjm0Qmrrf/suSZ5XzV5Uv2CSTeWhm8qPuW4OU
 dL5kB
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
index 1427949b72cd..e8ec6a152af4 100644
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

