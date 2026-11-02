Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633823;
	b=j75PTTCf0Ufrkif8aItfBsy73NH1ln5eD6pfSlFRq1vS/6jvSSTkvvkXVjW09bZHrpS0
	 q3aPhP4Db9zX+zwEyVxGspqfj2FYFVg0kt39dcDxGbnhoNKHONekFa6TIEkz1tf1ij2XZ
	 wATWyqAGlRC+JrQugEO5TUNHaHUvZg6X9jKnv18MD5ugj8JdtP/floRsBEWBwo3JIVDbv
	 p0t24Q7S9c9/1c4BkFPF5uKgtaj63QFnAKSzNySI5rVEzKMznbIWEcvsu6IuSHjLW80DI
	 AHcnATBxvAjcIpmDEme++XZ1bYJNyx5FggQhRe7QOQsttn1Ok7CY6TnI1tzSICcZdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Vop91WdATuHzNe6oB2d844wTZCMgIxCkWovun1wskQ4=;
	b=IpUqaOH/lNUMmkBsnzCc4WKVMCzWSq5Ls/rZ+kLJbg3zX4A+VV+VIvAbh+CDmIxS08gR
	 nR0G9qC3FHV2NezKTZb50O2gTYRQgwAXJmAGw7bsLYwTAowAE3bUamy5YNXI8zXBvR5go
	 Ck7COPTbJgb0Boue7rig8oFIp6ZGPXnm6KtNz+KP8Mza7QQS0h/V9qAewvPo8MNtxnA6r
	 iFXecQ2YZ0zlSj5BgpQZxiAnTzrFVqk7X+sp5feO3BX+1+CT6oKe6Xc3MAjMeSaIfxqL/
	 jyWAGy228jhPR+g3yCM8Z6faUbs60brZm6AAHAjLlaZ3dROq/ug0bJRRyQVab7KN6Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJYtKJTA;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3E360A6D37
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC3E360A6D37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJYtKJTA
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab2395f104so2845395a91.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633822; x=1794238622; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vop91WdATuHzNe6oB2d844wTZCMgIxCkWovun1wskQ4=;
        b=kJYtKJTAckpRc7FocLjk8QHxqgeRut7GlcgHqn3lvkwOku+d00iTncufBRhDqK7cUu
         Mcq4Xt3g9NbGfGfJje8UKhnS90LMyxht5vVRPzqF3rEocIRWDMOv4C84ZM73yTUK4use
         RRMkPWvjSma0znzU9pQHgP7SMFfa5iW3XBrdghIq6L+QWZiZTQv7F1bv8oHjnv23xfh0
         nsJZGeYvE0wDVyc8hu/F/kZ/PxF0IWtNW2UXzntNLX5ObHwlISWiEtG85qPzxqinfjAh
         XuS3VIt7XQVphq8yJGdlJEJhNohm/dGYOp7kt1Wd3wVvYMtPsn8j68/VqF+9YxZyxUNU
         3J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633822; x=1794238622;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vop91WdATuHzNe6oB2d844wTZCMgIxCkWovun1wskQ4=;
        b=Ng1opqGlEM8fdwp5ufC5v/5NyzryN/uHnEhl9TN6iKOYzLjC05hz7BdWRVtEpRs+7M
         BK9iDdeaqJZdjoWAnFg6t+QwevuPK47ndL3rfRkQRhZ6P9Kkh/jUdqXUV+5cMuWjWwVu
         YlC2xMNdRzEdCCehqcAW+Gk2cdI0G8eszsH20a+zvXZzkp79IK6GCH+mnEdriyGRT4Gj
         gukogsPHDNCxWljNga3puSIfIuiWzka70et63WqAmm2o81rtUqqG+c8ZUm6hyTCVnFxu
         TZF8JFhLIefoQKBSLD1f3bElIjkwCDAOpzVoCd+RVLYi5YWUVYiJ4MiNHuhQYfTzc3lS
         B1Dw==
X-Forwarded-Encrypted: i=1; AKwUvBwocw98v8sm+lmeZCwGCeUnny0jVeir366lMB32gRLnZ/iR3i1P4SNtdUcfXc4n12E90nE=@vger.kernel.org
X-Gm-Message-State: APuU4Z86qjl4ficQYxIy3yMNuT8Lhj37Y+ErAIcNal1blTxWEa5pWZN3
	1cn9leNdVoLV+7XiSg3CpZFeCt/loTwyIJY/pVoz4s2YfXR9W7zqUUY3Tu8UrGFAyZTGJ2Uc5Mc
	uosQrn/g1rQ==
X-Received: from pgr20.prod.google.com ([2002:a63:1154:0:b0:cd8:c6e9:7c0a])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a4d:b0:3ac:9e5e:d19c
 with SMTP id 98e67ed59e1d1-3ae897ccc1emr8773759a91.17.1793633822052; Mon, 02
 Nov 2026 07:37:02 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:31 -0800
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
Message-ID: <20261102153656.1431701-3-vipinsh@google.com>
Subject: [PATCH v6 02/27] vfio: Export various helpers from VFIO
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

The upcoming VFIO live update feature needs to access various helper
functions for its logic which are not exported by default.

Export vfio_device_from_file() for other modules to use it, and make
vfio_pci_ops non-static so it can be accessed within the vfio-pci
module. Remove static from their declarations and add them in
include/linux/vfio.h and drivers/vfio/pci/vfio_pci_priv.h header files.

No functional change intended.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci.c      | 2 +-
 drivers/vfio/pci/vfio_pci_priv.h | 2 ++
 drivers/vfio/vfio_main.c         | 3 ++-
 include/linux/vfio.h             | 1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..2ec600768007 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -146,7 +146,7 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 	return vfio_pci_core_init_dev(core_vdev);
 }
 
-static const struct vfio_device_ops vfio_pci_ops = {
+const struct vfio_device_ops vfio_pci_ops = {
 	.name		= "vfio-pci",
 	.init		= vfio_pci_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..1634135de3f8 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -11,6 +11,8 @@
 /* Cap maximum number of ioeventfds per device (arbitrary) */
 #define VFIO_PCI_IOEVENTFD_MAX		1000
 
+extern const struct vfio_device_ops vfio_pci_ops;
+
 struct vfio_pci_ioeventfd {
 	struct list_head	next;
 	struct vfio_pci_core_device	*vdev;
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..73a5c4f3751c 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1497,7 +1497,7 @@ const struct file_operations vfio_device_fops = {
 #endif
 };
 
-static struct vfio_device *vfio_device_from_file(struct file *file)
+struct vfio_device *vfio_device_from_file(struct file *file)
 {
 	struct vfio_device_file *df = file->private_data;
 
@@ -1505,6 +1505,7 @@ static struct vfio_device *vfio_device_from_file(struct file *file)
 		return NULL;
 	return df->device;
 }
+EXPORT_SYMBOL_GPL(vfio_device_from_file);
 
 /**
  * vfio_file_is_valid - True if the file is valid vfio file
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 45f08986359e..de3fa6e6bf2a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -379,6 +379,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
+struct vfio_device *vfio_device_from_file(struct file *file);
 
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
-- 
2.56.0.317.g454f8302e1-goog

