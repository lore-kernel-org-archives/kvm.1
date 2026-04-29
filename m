Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56003381AF1
	for <kvm@vger.kernel.org>; Wed, 29 Apr 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487362; cv=none; b=PvY+VFNdAQydMpFUx9k9k7xuiUevgO0CZ7bFdYbY8Xe+3NDyvx0bNO7sD3WEsUIjF/nvNCsEkKHaFhSJSfVg8Dhcj9jWeVStRHl6R81w+9jyBrf3F3TKhvRBqis135U6lRdaRohfmpVuFhJ2vyQ1Nr9Hdyv6tmsbNcoIt4OuxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487362; c=relaxed/simple;
	bh=NJ/j04s1rnohmI521dJE8hYlpvoq+IxjH+QPvjM+bf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDsUa8l7LJw/gQx/ZE0g7QH+eNNHNLXKM1bAfcQH//6py13SVw1V334zV1KPRbt/+nKNktsuiXJ8l1b83fjhlvEzaU3ocwgUim1KFAe+tTDTYyjP5hqpXMU+8lCr6SXjhL1u7M51TXEux05OtBn//cni4KQt17jqeUvLtq+E95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xb+VmQS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P6V2HuR7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xb+VmQS+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P6V2HuR7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xb+VmQS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P6V2HuR7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xb+VmQS+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P6V2HuR7"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C25A5BD5F;
	Wed, 29 Apr 2026 18:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777487358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bH2oZj6mKretfJN8YgtyqtQ9iLlYWWrMPsMMv4QcbEg=;
	b=Xb+VmQS+VCDdIOgKQNikk3gNGoEyh4J9Be+4DBn+Kfs1u8jHt2Cx14H5GIpolbX758nRYG
	5ck0r3biY6kSfHEqo9XcvBtIbTVKet2a7K3X14kY7iGfARikn8kXFNB5d0ZHzpDEbfb0zd
	Pi0oDFNEJWAh0Y0/4cSRyXsIVrl9hHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777487358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bH2oZj6mKretfJN8YgtyqtQ9iLlYWWrMPsMMv4QcbEg=;
	b=P6V2HuR77N8yDG27TbU88HgDeuqsX/SFwdcJSOD5+2w7oJ1wpoBQcjHEA+rIo6NPteqfDm
	OizqACXRIcyH7dDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Xb+VmQS+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P6V2HuR7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777487358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bH2oZj6mKretfJN8YgtyqtQ9iLlYWWrMPsMMv4QcbEg=;
	b=Xb+VmQS+VCDdIOgKQNikk3gNGoEyh4J9Be+4DBn+Kfs1u8jHt2Cx14H5GIpolbX758nRYG
	5ck0r3biY6kSfHEqo9XcvBtIbTVKet2a7K3X14kY7iGfARikn8kXFNB5d0ZHzpDEbfb0zd
	Pi0oDFNEJWAh0Y0/4cSRyXsIVrl9hHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777487358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bH2oZj6mKretfJN8YgtyqtQ9iLlYWWrMPsMMv4QcbEg=;
	b=P6V2HuR77N8yDG27TbU88HgDeuqsX/SFwdcJSOD5+2w7oJ1wpoBQcjHEA+rIo6NPteqfDm
	OizqACXRIcyH7dDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7F3C593B0;
	Wed, 29 Apr 2026 18:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2nShNf1N8mlOVgAAD6G6ig
	(envelope-from <clopez@suse.de>); Wed, 29 Apr 2026 18:29:17 +0000
From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>
To: kvm@vger.kernel.org,
	alex@shazbot.org
Cc: joonas.kylmala@netum.fi,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] vfio/pci: Fix double-put during dma-buf cleanup
Date: Wed, 29 Apr 2026 20:27:36 +0200
Message-ID: <20260429182736.409323-2-clopez@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 6C25A5BD5F
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 

When a dmabuf is created for a VFIO PCI device BAR, it is added
to the device's list of dmabufs. If PCI memory access is disabled,
vfio_pci_dma_buf_move() is called to revoke the dma-buf, dropping a
reference via kref_put(), and setting its revoked field to true.

Currently, vfio_pci_dma_buf_cleanup() does not check if the buffer
was already revoked, calling kref_put() on all dmabufs for the device,
potentially leading to a refcount underflow and use-after-free, as
reported by Joonas Kylmälä.

Check priv->revoked before calling kref_put() to avoid underflowing the
reference count.

[  216.397532] ------------[ cut here ]------------
[  216.397540] refcount_t: underflow; use-after-free.
[  216.397542] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#5: python3/3269
[ ... ]
[  216.397851] RIP: 0010:refcount_warn_saturate+0x59/0x90
[  216.397859] Code: 44 48 8d 3d 09 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 08 bc 35 01 67 48 0f b9 3a c3 cc cc cc cc 48 8d 3d 07 bc 35 01 <67> 48 0f b9 3a e9 4d b4 70 00 48 8d 3d 06 bc 35 01 67 48 0f b9 3a
[  216.397862] RSP: 0018:ffffd05f83a03c60 EFLAGS: 00010246
[  216.397867] RAX: 0000000000000000 RBX: ffff8db0425a49c0 RCX: 0000000000000000
[  216.397871] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffb0364910
[  216.397873] RBP: ffff8dafc9fc0550 R08: ffff8dafca8f90a8 R09: 0000000000000000
[  216.397876] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8dafc9fc0000
[  216.397878] R13: ffff8dafc9fc0560 R14: 7fffffffffffffff R15: ffff8db0425a4980
[  216.397882] FS:  00007fc096c06780(0000) GS:ffff8db74ea75000(0000) knlGS:0000000000000000
[  216.397886] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  216.397889] CR2: 00007fc096932010 CR3: 000000014040b005 CR4: 0000000000f72ef0
[  216.397892] PKRU: 55555554
[  216.397894] Call Trace:
[  216.397898]  <TASK>
[  216.397904]  vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
[  216.397923]  vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
[  216.397935]  vfio_df_close+0x4c/0x80 [vfio]
[  216.397946]  vfio_df_group_close+0x36/0x80 [vfio]
[  216.397956]  vfio_device_fops_release+0x21/0x40 [vfio]
[  216.397965]  __fput+0xe6/0x2b0
[  216.397972]  __x64_sys_close+0x3d/0x80
[  216.397979]  do_syscall_64+0xea/0x15d0
[  216.397988]  ? ksys_write+0x6b/0xe0
[  216.397996]  ? __x64_sys_pread64+0x91/0xc0
[  216.398003]  ? do_syscall_64+0x128/0x15d0
[  216.398010]  ? do_syscall_64+0x128/0x15d0
[  216.398017]  ? ksys_write+0x6b/0xe0
[  216.398023]  ? do_syscall_64+0x128/0x15d0
[  216.398029]  ? __x64_sys_ioctl+0x96/0xe0
[  216.398036]  ? do_syscall_64+0x128/0x15d0
[  216.398042]  ? do_syscall_64+0x9f/0x15d0
[  216.398048]  ? clear_bhb_loop+0x30/0x80
[  216.398054]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  216.398059] RIP: 0033:0x7fc096c9a687
[  216.398063] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  216.398067] RSP: 002b:00007ffe422781f0 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[  216.398071] RAX: ffffffffffffffda RBX: 00007fc096c06780 RCX: 00007fc096c9a687
[  216.398074] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
[  216.398076] RBP: 0000000000a83590 R08: 0000000000000000 R09: 0000000000000000
[  216.398079] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fc096f43160
[  216.398081] R13: 0000000000000135 R14: 0000000000a83590 R15: 00007fc096f43168
[  216.398087]  </TASK>
[  216.398089] ---[ end trace 0000000000000000 ]---

Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
Closes: https://lore.kernel.org/kvm/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
Reported-by: Joonas Kylmälä <joonas.kylmala@netum.fi>
Assisted-by: Gemini:gemini-3.1-flash-lite-preview
Signed-off-by: Carlos López <clopez@suse.de>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index f87fd32e4a01..deb9c351c4a6 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -389,14 +389,20 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 		dma_resv_lock(priv->dmabuf->resv, NULL);
 		list_del_init(&priv->dmabufs_elm);
 		priv->vdev = NULL;
-		priv->revoked = true;
-		dma_buf_invalidate_mappings(priv->dmabuf);
-		dma_resv_wait_timeout(priv->dmabuf->resv,
-				      DMA_RESV_USAGE_BOOKKEEP, false,
-				      MAX_SCHEDULE_TIMEOUT);
-		dma_resv_unlock(priv->dmabuf->resv);
-		kref_put(&priv->kref, vfio_pci_dma_buf_done);
-		wait_for_completion(&priv->comp);
+
+		if (!priv->revoked) {
+			priv->revoked = true;
+			dma_buf_invalidate_mappings(priv->dmabuf);
+			dma_resv_wait_timeout(priv->dmabuf->resv,
+					      DMA_RESV_USAGE_BOOKKEEP, false,
+					      MAX_SCHEDULE_TIMEOUT);
+			dma_resv_unlock(priv->dmabuf->resv);
+			kref_put(&priv->kref, vfio_pci_dma_buf_done);
+			wait_for_completion(&priv->comp);
+		} else {
+			dma_resv_unlock(priv->dmabuf->resv);
+		}
+
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
-- 
2.51.0

