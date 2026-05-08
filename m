Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E65A3F7894
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692426; cv=none; b=XlwiBfORdnFJ/n53FNKP30eB2Hk61ZhULM9r/NwJlJRBPwLsMCL9oPBS9AWeiDSEmBkdhjihqcKVyv3hFFkOX2xz85fM/q8Xu9oopkHoy7CPdUIEf22+bidqSBQTRiOZ9WM8u0Xggi96qqZEPAaTQ0cC68Sv6xaMoIvdpSsJL8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692426; c=relaxed/simple;
	bh=DMe52R6JvxCU9C8ejt5UwolNnHN5rL7a7lzgbKARCgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:content-type; b=VpkSrlprYKQZNsOz3pbflM3z/+wNyVOMW5OLwKMkX3dbwaguGqQDy4XKrt5Bqpj1w24KUNvyem17e6g1ReDrb8B/FwdTiZMPIT8KB0UCX1yR4L2msIiePN41MH3tn0g/a83hm9FtiR5r7o8tpWWW6wKur488kpvsnDY6NMW382A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fW61vlIo; dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtLLNMVS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fW61vlIo";
	dkim=permerror (0-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtLLNMVS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781692424;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=faYuc/QeEl0YbC01pJpvOLkLT9wo1bZfE99WPNpN2O8=;
	b=fW61vlIofiiQZh1Lj1eg58V9ZsFzeS9lSYE3hkwVusuyE7GXY1p5TVCRxaJuLrR3ab7bK+
	FS7XT4SLaC4Ct812do8DX3n9k8wwo0QsORVxBB2zl1lyj/gAQMSMqfJg5Q8/awnIj6eIll
	xIQsRYt/GinyIffv7apI/h2K9gZWP5U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-HyHb3tbzME-CZ2nNUFYf6g-1; Wed, 17 Jun 2026 06:33:42 -0400
X-MC-Unique: HyHb3tbzME-CZ2nNUFYf6g-1
X-Mimecast-MFC-AGG-ID: HyHb3tbzME-CZ2nNUFYf6g_1781692422
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490b2f22ea2so48528415e9.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 03:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692422; x=1782297222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:delivered-to
         :delivered-to:resent-to:resent-message-id:resent-date:resent-from
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faYuc/QeEl0YbC01pJpvOLkLT9wo1bZfE99WPNpN2O8=;
        b=TsxH1hjCnQqt6067T0e8/LODLqP0roKdbaE+E4PCX0ipXU5hFiKoFexvtbaMqlYV8c
         cb0MNqSJ07lX43RsZm5Gtug45RyPqqyXpfUf6w6b/OyGSp9kkpFSq9IJG6UjvOI8MkGJ
         WdkXY8qSTzwFQenHmixdPb7y2xaWHtrSkWyR05d0RdkrqgtBsg/mQ0p2xCnNF7X/IMP0
         yvimsrrRt1LkEzKa+K7xPmJw1+E+u0+aifvKr09krU1rxmXAnE4nJHCqBlXSxt8kbW0a
         xOU8jZmVrez8m+9y0yvlGbpuBIJQ0FwGRUaGp8q4Z68tt5fc5ZveiGpvsy6xmlpjeJka
         ykPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Jis9Vx9fXNCjoU45j6zf9IH3feLrOYqJqILCNYcLMIP45nekc5zAiwSa84sh+nIlIe8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUWFH5DnBNHHQSK9FaVqJWfOk76uE7+1x62KD64+NNP4S9oWD
	5Z/8VDIJjkwI1fvSloZG1UWXq4KfELxIQhgRF92sk1cXGiBowigds043XnClCDs9Hi3wgcIANbP
	YvHvmWGx2n5IEqerFattL+81Sv9AFTAnbt/46rQk0pLHsTjqW7Xs4OOJ5PfqDZuQR3QCGX42PBS
	U0qsKTYZP5ybTSmKSZ8n08VF5e4V3BI+0=
X-Gm-Gg: Acq92OGuHP42/uGgZnB67tGygE3t6z1I86s4oNhfSPvqRgFq1l5aOU7vTdAOQR00vNF
	weiI0nfGvLivRFRF/vHaVu6gPli4dH+m+uBzRGsQ67HYB27oLyxxFvZ1kj2TCwbAvlu8uz5GiVX
	nV2trGEEgOUHs+1imvSYMjBxjaOpUY3zT9dCF8bDHo4qgTL+bGvVfmyJOl4YNWfnOyL02j3lSSV
	Db+RBe+Ul8kUchYx0tfrwRlwG2o+5tsDElnjghaEYR+Q0HDdpt9E1ZxpSKg4ddYIZyp4EfwPEJA
	dyedHe2fEbRQuuN748ZR5FJJf/dRRWQ1ORpXzcVDQ4rCpslMsW+CPm+S2jsCEBPhFwPJdi15K0u
	+ta5ySOxgLTPRpAKN6V3jTFDPwcrUDRBj
X-Received: by 2002:a05:600c:3b91:b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-492333df08emr65435745e9.34.1781692421488;
        Wed, 17 Jun 2026 03:33:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3b91:b0:490:c2a3:abae with SMTP id 5b1f17b1804b1-492333df08emr65434995e9.34.1781692420827;
        Wed, 17 Jun 2026 03:33:40 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa47ce3sm170652595e9.6.2026.06.17.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:33:39 -0700 (PDT)
Authentication-Results: relay.mimecast.com; dkim=pass header.d=gmail.com
 header.s=20251104 header.b=UtLLNMVS; dmarc=pass (policy=none)
 header.from=gmail.com; spf=pass (relay.mimecast.com: domain of
 q.h.hack.winter@gmail.com designates 209.85.216.53 as permitted sender)
 smtp.mailfrom=q.h.hack.winter@gmail.com
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: Qihang Tang <mst@redhat.com>
X-Google-Original-From: Qihang Tang <q.h.hack.winter@gmail.com>
Resent-From: "Michael S. Tsirkin" <mst@redhat.com>
Resent-Date: Wed, 17 Jun 2026 06:33:36 -0400
Resent-Message-ID: <ajJ4AKoBZb1hhWge@redhat.com>
Resent-To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Received: from imap.gmail.com [64.233.184.108]
	by tuck.redhat.com with IMAP (fetchmail-6.5.7 polling redhat account mtsirkin@redhat.com folder INBOX)
	for <mst@localhost> (single-drop); Fri, 08 May 2026 05:47:20 -0400 (EDT)
Received: by 2002:a05:7108:3655:b0:569:1bde:8a97 with SMTP id e21csp103817gdd;
 Fri, 8 May 2026 02:47:16 -0700 (PDT)
X-Forwarded-Encrypted: i=3;
 AFNElJ8454LKWJetXLWElUvqNM3moRh9cWz5Mhsr7HgJev4bQUcdv3Atb2yLXcN2EFKxxeIxQePmUu2a2Q==@gapps.redhat.com
X-Received: by 2002:a05:620a:7017:b0:8f8:cdd0:df80 with SMTP id
 af79cd13be357-904d70c2e1amr1667474285a.59.1778233636600; Fri, 08 May 2026
 02:47:16 -0700 (PDT)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com. [170.10.128.131]) by mx.google.com
 with ESMTPS id af79cd13be357-8fc2d3e0f80si2358232585a.357.2026.05.08.02.47.16
 for <mtsirkin@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Fri, 08 May 2026 02:47:16 -0700 (PDT)
Received-SPF: pass (google.com: domain of q.h.hack.winter@gmail.com designates
 209.85.216.53 as permitted sender) client-ip=209.85.216.53;
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-j0IcothIP7-90A6AKWmLUg-1; Fri,
 08 May 2026 05:47:15 -0400
X-MC-Unique: j0IcothIP7-90A6AKWmLUg-1
X-Mimecast-MFC-AGG-ID: j0IcothIP7-90A6AKWmLUg_1778233634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 EE7BC195608A for <mtsirkin@gapps.redhat.com>; Fri,  8 May 2026 09:47:13 +0000
 (UTC)
Received: by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 id E8CA73002D2F; Fri,  8 May 2026 09:47:13 +0000 (UTC)
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.33]) by
 mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E56F0300019F for <mst@redhat.com>; Fri,  8 May 2026 09:47:13 +0000 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com [170.10.128.131]) (using TLSv1.3
 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 74E1E195608E for <mst@redhat.com>; Fri,  8 May 2026 09:47:13 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-bcurhbVkODi0E_yqm7g7Gw-1; Fri, 08 May 2026 05:47:10 -0400
X-MC-Unique: bcurhbVkODi0E_yqm7g7Gw-1
X-Mimecast-MFC-AGG-ID: bcurhbVkODi0E_yqm7g7Gw_1778233630
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-365f4329725so216652a91.2 for <mst@redhat.com>; Fri, 08 May 2026
 02:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20251104;
 t=1778233629; x=1778838429; darn=redhat.com;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to; bh=faYuc/QeEl0YbC01pJpvOLkLT9wo1bZfE99WPNpN2O8=;
 b=UtLLNMVSc1cpXh7KkJL9s/kGcmD4aLSV8GnBPNbHJxwMsNJZ5cczC6kM+iy+GO6MGu
 4XOsA+7impQ093fy8qzxNHaeveYdpWcfD4CcEgheA+r5COr5jfxbiODBAK/NTYqwUENR
 6ofjvztFj12kQBIaqkva7gLjDje7p9NUzxqVAWqQ79v8cWXhBWt9RWo6HtbmE09iiSFX
 tPyemBj4uxlVk44c5TatG+gFTVYcBbkEB/u3UIDpe5zqWXYVB/TVnUVWrTMTVJGpr0oB
 IZvkntmhbeqotlJNlPpI8HBlI1m5vfeWcmpmRstYA88XbkvR4Hm3ESzyHFcdAZjwk4F2 fjPQ==
X-Received: by 2002:a17:90b:2249:b0:35f:be11:b3ec with SMTP id
 98e67ed59e1d1-365adbec13emr6632924a91.7.1778233629305; Fri, 08 May 2026
 02:47:09 -0700 (PDT)
Received: from localhost.localdomain
 ([240e:47c:d8c8:14dc:ad01:83b5:f2d1:22b3]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36648f21994sm1044679a91.2.2026.05.08.02.47.05 (version=TLS1_3
 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256); Fri, 08 May 2026 02:47:08
 -0700 (PDT)
To: mst@redhat.com
Cc: jasowang@redhat.com, w@1wt.eu, eperezma@redhat.com, Qihang Tang <q.h.hack.winter@gmail.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v3] vduse: hold vduse_lock across IDR lookup in open path
Date: Fri,  8 May 2026 17:46:59 +0800
Message-Id: <20260508094659.94647-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260418211354.3698-1-q.h.hack.winter@gmail.com>
References: <20260418211354.3698-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: qD_m35z3Mosc3SMn6rdj5ve91VDn0YKgHX5fEaounjY_1778233630
X-Mimecast-Impersonation-Protect: Policy=DMARC Check - CHG0118091;Similar
 Internal Domain=false;Similar Monitored External Domain=false;Custom External
 Domain=false;Mimecast External Domain=false;Newly Observed
 Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to
 Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat
 Dictionary=false;Custom Threat Dictionary=false
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Label: linux

vduse_dev_open() looks up struct vduse_dev through the IDR and then
acquires dev->lock only after vduse_lock has been dropped.

This leaves a window where a concurrent VDUSE_DESTROY_DEV can remove the
same object from the IDR and free it before the open path locks the
device, leading to a use-after-free.

Close this race by keeping vduse_lock held until dev->lock has been
acquired in the open path, matching the lock ordering already used by
the destroy path.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
v2 -> v3:
- keep vduse_lock held until after dropping dev->lock
in vduse_dev_open()
- add changelog requested in review

v1 -> v2:
- add Fixes tag
- remove helper and inline the locking in
vduse_dev_open()

 drivers/vdpa/vdpa_user/vduse_dev.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 6202f6902fcd..d5c34260ed68 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1637,26 +1637,18 @@ static int vduse_dev_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static struct vduse_dev *vduse_dev_get_from_minor(int minor)
+static int vduse_dev_open(struct inode *inode, struct file *file)
 {
+	int ret = -EBUSY;
 	struct vduse_dev *dev;
 
 	mutex_lock(&vduse_lock);
-	dev = idr_find(&vduse_idr, minor);
-	mutex_unlock(&vduse_lock);
-
-	return dev;
-}
-
-static int vduse_dev_open(struct inode *inode, struct file *file)
-{
-	int ret;
-	struct vduse_dev *dev = vduse_dev_get_from_minor(iminor(inode));
-
-	if (!dev)
+	dev = idr_find(&vduse_idr, iminor(inode));
+	if (!dev) {
+		mutex_unlock(&vduse_lock);
 		return -ENODEV;
+	}
 
-	ret = -EBUSY;
 	mutex_lock(&dev->lock);
 	if (dev->connected)
 		goto unlock;
@@ -1666,6 +1658,7 @@ static int vduse_dev_open(struct inode *inode, struct file *file)
 	file->private_data = dev;
 unlock:
 	mutex_unlock(&dev->lock);
+	mutex_unlock(&vduse_lock);
 
 	return ret;
 }
-- 
2.39.5 (Apple Git-154)

