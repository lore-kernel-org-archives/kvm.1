Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91872374E7F
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069632; cv=none; b=CER61kacaKcvgQBnrk0y0Qf8HYP/CLn9IvaWr0Q5GGKFGzFoAnNMruhECtP8EOM+DZIOUhex/+oi4wE70AJBxhQcTQj/v+2gGfjmlcxLkbcyQgfvDm95nbUJ9Ua5+BXYIB1ismDNI3jfHDpMl/b9zKImE74wrsyKu8ZoCFTBu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069632; c=relaxed/simple;
	bh=0sIHYHXmj4kfkFzJUw5iipjWTE9r6gD6R63u5QZ378E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LBCDAQ1uPNvDPbdg++ycQzITydjIinNjMdy2+ZiqNOSwXyzwPs+IlBDY+A7xupYrPhHnjHxVy7TVvYgml+uUOmxvPxO2E17tFOGYXkDWSBJnmnprw9f6d2nyiPj2/m17XCgaUQ1kNYEH2PkeFDCn8VGsOMRcZvEdLGczwTz36UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFxONSwv; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFxONSwv"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca957432c7fso2713254a12.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 19:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786069629; x=1786674429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rt72B6lVkq2wOx7y/7/IbB63EiyH3V4VoZfX5qtaWOk=;
        b=EFxONSwv41DNxoIUBAuQH3qxgcFTC2ucmMRVeMwjw5MtegTuoXDUEr8NCDrND7lgb0
         CElXma4F2GYcUlApwXh5WGdiHXonlq1Pl3d4S9XmN4hvgNUokwgajYibn7lzN4lBLAKB
         tMDYz4rBE8JYflGovSosd1xzptUEr91ejHKCJP4NK0Ib4lop89yLC9zLxRmSa9n8UN9+
         9RPS3So+fwTNOEfWCyPpXAgXEoahbBrSoj3D+BmJwsBXRjod2mZDWyNz5rGic58NGunW
         mmnGgQ90jSgVc/P/F7vH571VlTyBcjciGpZ3s9aXm1H17Exs60R7aRohFRpdpHzlMF/m
         lkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069629; x=1786674429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rt72B6lVkq2wOx7y/7/IbB63EiyH3V4VoZfX5qtaWOk=;
        b=mFTPN+MOuPKfhJXLZjPL7qZifNoThxHHCmcNoDsIgnzBXrFdvrYs+/RDqQM4BKf2jU
         8/lRHYZJR4oXhflBhN0pk/pk0LOu/55Q11LnILenMZeIDsAZh/eyFJwUVyeSIb8/h41J
         sF5Ky1Xv4hYQ+PGzQV5dNGVxaLK4LDGESdUX1CHuindoggSAeF2e1HNvNoD2becL56mp
         AatSBRmBlTPtXqbt9RXc6EIWIN7PIDfZ+IgmAqbbW2Aen1UJwPLz6kix6e7F/UshRDhJ
         9i31eD5c17etxdTh+67lW1R+Jk0xNzvZf5aGy9aWOAfOK1DZq/Ec5MtZwJV3Tk4x9Qmc
         z4KA==
X-Forwarded-Encrypted: i=1; AHgh+RrKgrr2cd0BLUfjHjDzyEneHjLF0nCBvn4WiI2210r5/DxoTQ3irI+8kLh6cyW/Z5/C+Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5KIFvDjym7wCR9Biqc5Z1VA319kz6zSUB1CKxFcnKJcP1dUf
	DJfvHEDuovn+hBOo/pQ0RFSX9ooFjvQSHB6bjD1O50Gne63EmvSQjNJw
X-Gm-Gg: AR+sD10e1mhNSwWJoE4kcTfrF7XqbTc3dXwpEXxgFOeb6DcRaxzhGM3nqe2XkODpq5P
	/BES4H7Qgx+eB8lb564OYTmNTPhuNsumwS7ewD22HQ1FNsyf2xHAtHJ442zgPowtysqGKjeKy/2
	iLWAW9xH8hLxb4KNlf5bEgOuo8eivkC8iYxq6gZJN8mbg7f47a1UtyZu/4Oy8BdctAGrc9SN6JK
	SHAhbQLp2W94APPf3WcS46GrMLTlWbmNlYuI+/T9t3SxPYlx5Bgf3fi8JMuN5HMxsjStAce+q/0
	SUM2OE8qyYdXbY26Q5s3adrMpac7bXyqbyuDfAAX+BPOBpnXn2rU2Ziv+CiL7JlF5iwfPzrFJQw
	ZKtvrXFnB4hwDo6vJrUTrN3n4FJRDH36Tv0z+YvmCYwc5XRlH2R1i4Ocb0cAikYlQYleM2p9Dgo
	DgWZ8KUbm+P4OPrSlgIfMKqb+b8kFpRz7AIw3yR0Wa7LFvXuOYsMNjEuuceVV4b/wf20AuGgrU7
	Cupf/C9gpFMCWPVKtvBlN2El4ubMLXaUo5ALBQRWEznQ2N8c+sqcBo=
X-Received: by 2002:a05:6a21:a04:b0:3bf:9aa9:b2a4 with SMTP id adf61e73a8af0-3cb85ef91f7mr24553793637.20.1786069628776;
        Thu, 06 Aug 2026 19:27:08 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm1843082eec.18.2026.08.06.19.27.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 19:27:08 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] vduse: reject non-coherent iotlb entries in the coherent fault path
Date: Fri,  7 Aug 2026 12:26:57 +1000
Message-ID: <20260807022657.11318-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vduse_domain_get_coherent_page() turns an iotlb entry into a struct page
with pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT) and takes
a reference on it, with no check that map->addr is a physical address.

That assumption only holds for entries created by the domain's own
coherent allocator (vduse_domain_alloc_coherent(), which stores
virt_to_phys()). VDUSE registers its vdpa device with use_va=true, so for
a use_va device vhost_vdpa_va_map() passes a userspace virtual address as
the map address, and vduse_domain_set_map() copies those entries verbatim
into the same domain->iotlb. Both kinds of entry share one tree, and the
mmap fault handler only splits them by iova < bounce_size, so a use_va
entry placed above bounce_size lands in the coherent path.

A userspace daemon can exploit this: bind the device to virtio_vdpa so
the coherent allocator mints an entry whose backing file is the domain's
anon inode, obtain the domain fd with VDUSE_IOTLB_GET_FD2, rebind to
vhost_vdpa without deleting the vdpa device (vdpa_dev_del() only calls
_vdpa_unregister_device(), so the domain and the fd survive), install a
VHOST_IOTLB_UPDATE over the same iova with an arbitrary uaddr, then fault
the domain mapping. The kernel computes pfn = uaddr >> PAGE_SHIFT from
the userspace value and hands the daemon a struct page for a pfn of its
choosing -- an out-of-bounds vmemmap access for a wild value:

  BUG: unable to handle page fault for address: ffffea8000000008
  RIP: vduse_domain_mmap_fault+0x100/0x330

or, for a value that resolves to a valid pfn, a read/write window onto an
arbitrary physical page (confirmed: a write through the domain mapping
lands on a page selected purely by the fabricated pfn).

Coherent entries are always registered with domain->file as their backing
file, while entries installed through a vhost IOTLB message carry the
mapped vma's file (vhost_vdpa_va_map() stores get_file(vma->vm_file)).
Reject any entry whose file is not domain->file before calling
pfn_to_page(); the fault then returns VM_FAULT_SIGBUS. Legitimate coherent
mappings are unaffected.

Fixes: 8c773d53fb7b ("vduse: Implement an MMU-based software IOTLB")
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/vdpa/vdpa_user/iova_domain.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index 4dc76c0..847f010 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -221,6 +221,7 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	u64 start = iova & PAGE_MASK;
 	u64 last = start + PAGE_SIZE - 1;
 	struct vhost_iotlb_map *map;
+	struct vdpa_map_file *map_file;
 	struct page *page = NULL;
 
 	spin_lock(&domain->iotlb_lock);
@@ -228,6 +229,17 @@ vduse_domain_get_coherent_page(struct vduse_iova_domain *domain, u64 iova)
 	if (!map)
 		goto out;
 
+	/*
+	 * Only coherent allocations made by this domain are backed by a real
+	 * struct page here: their map->addr is a physical address and their
+	 * backing file is the domain's own anon inode. Entries installed via a
+	 * vhost IOTLB message on a use_va device instead carry a userspace
+	 * virtual address in map->addr, and must never be fed to pfn_to_page().
+	 */
+	map_file = (struct vdpa_map_file *)map->opaque;
+	if (map_file->file != domain->file)
+		goto out;
+
 	page = pfn_to_page((map->addr + iova - map->start) >> PAGE_SHIFT);
 	get_page(page);
 out:
-- 
2.43.0

