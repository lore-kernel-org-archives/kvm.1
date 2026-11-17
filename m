Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965915;
	b=ZmuFK9i3IKIkZ/1OundkSXApoAcKhsm+Ix1YeCzhxhF4VdC7Q0w+/2u2MfvzXELKwYl9
	 AAsboqR9Z1zy4OdsePGuZddz+ovBpbgt93GwPiwL2fuM9aiftV968JeJRUQsam6yKrUIh
	 9Ul0lBa3H2fmfgHgN6qjM9KzjSAKkKMyvKvez+7jLp9TcI/xX6261d4WYb4xIrec48yOf
	 6gd/ZJ2LHKzDRR06L/m8x7sEzjZjLCAdVdEocLUIGdS4o9P+4ysMQKQ2zngfp4yr+eo47
	 DSmr4HOun7v43xud3nJ7O8GYDtfkpm15yBGytWeM38Var0UdmxEL8ows0VEUCZLOF7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X4FNYHTT1LKVhYoSP9CXX5H2kEYFt4XaTxI0OzwyTm8=;
	b=XOHbAcl7VHOo3L5XCSuo1CqFAkTSBaWD311lDLVMo2AD0TATVcxBVEpM0/x3DXURWDmp
	 A6Xuox0+KakzHE628svaLwILMhQA5NqJeIlFs1IomOtfhGOUg+WV8Ua0hwfi9aJ+dIEfG
	 1i9iBgbe/R6phNQbCINSuvbZxr4I0eiqb2PqwA97FFh9BqW0MralOmlYeaAXf7t1k3Vh1
	 1kXFX/A+LmJf0l09fc/ixYDwdwxf0Hte48IsYMSNWZfG+e89HgfjBL3c6TXrzF5zGrWbN
	 jFkUkBW45GZsT8/IlP4eMG+fKn8HfjkhTHEwxNBc8/W8LsWc0XXW236LmNkuGFsoW9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CDjRkcYt;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A9606A330
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 01:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A46A9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CDjRkcYt
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-14394530ec6so749610c88.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 17:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965914; x=1795570714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4FNYHTT1LKVhYoSP9CXX5H2kEYFt4XaTxI0OzwyTm8=;
        b=CDjRkcYtnqM/n2li4FgiBYKjz6es1d5tWqHyQ28xR58K9oi3aeS0XCGDqydk+h2ZJl
         IQb1uBeu24QApSjibR9lY0a8mW7UxMJsW/TXO0p3teEtfhA1zaDRF68xSPRmtrj+wTpH
         CVLnXd4eOidWoektD9wy/NbExdwUonqzj/GQ7MqxsS26Y6JJQKmCIP05askktb0gJEka
         0QLamCOoQgCJc3SxskW+Qodx98yEZBJ/bxnRhaoF1pOc2o9Uiv9Ik6dFPYzfrDJNI0XK
         fhDH0XxXc9MjqALTP1QZefQld/RQ5+xI+aXnaNVNUU1SkUOVO6CzhUtnBMmepSI4IEtK
         8TVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965914; x=1795570714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4FNYHTT1LKVhYoSP9CXX5H2kEYFt4XaTxI0OzwyTm8=;
        b=vfu5BPnrBxAlaZq82nFT9ldfb43wufdJqIyaUhA0fKmaWSgZfIV8sT9yi9uS6gWkOK
         Y+EhgO+I/ndFzOiA0LVw2Elp88uMuknX0qFf472FGrT6kcHNouOx0Id33DgnG/UWfiE4
         NgA5qx49IWU1MiBEiYnZCLtlWASEl0QB5Y/sFDl+BagKErEoGRtL5pSwf7ddwZq3CvlJ
         6POTci5hJoGkmLvaRZzQ6xZwc7jXXnJX3Ii+8nVTOcfuThDEx0GLT52YMrEwRLG0iUSM
         z8zkZPysk6iu+E1TbRqv+AJybw3uAQE6Jjt7PPMaURwFXeSQPLsvrAJHNc3Xql8CApUs
         bLvA==
X-Forwarded-Encrypted: i=1; AL+hErHEnt6W1O9gy+LobooCE8dN28c9nnnY21FMigiw4ffm7/jWTamVpB7utNYOFfpsLr0iejA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9igiT4lpH1rKOIjtYkrwtO8RI6yT5Op7K/kGkFufkrCrAY388t
	nxX4Mk2g82u98bdRLOc+DnVShE11PfR/4QH2wgVcrfhKcgLGIFm4468t
X-Gm-Gg: AYBFou2FntgxiVvSH/8JJXDRn1rsg/0nLLM+h426FWSQLFPTfJa+l+Ybidhbg7anII7
	nMfMXDJgYVKxxrFniU77XsCnUoZ4ZRXQFh/hEU7N2QDbPfdJW+K2JRzj9/9hw1/ok3xBs7BKRq5
	Y/lZwL3Xa3uafFC4ywD1EDbMHphRANM8ZXsSZWmS82ZrQtukRPi8JgyOSFXtXUqnQta402rJvnj
	xg1krQXUHu3UF3dnbXZH92jBr0L8z700zrevykk64GjpPyI0wAoDsvDtczpF58dHtxPdNFILSPM
	9meyKPK9Pygw0Eso9VGD3rI1W+P3bNxIl0NqW2YosjWroLCA3Zprwk6umG/zJpBxULEci8qBAlR
	ryijj/+k59ck9p/umhT4bhBfSbZ+NlTObhwir5JztAPM0dkEZL3bCsD2o/emqdad+GqQFz4GIB1
	e+8H/XDbQAv6zcuqeeI3TnIEyjWkil9WDoPnL6hG8pQIyU5AtJ7rVE3qnY4/0QKrHDZZedtjUov
	cey1naXDXTKRbD6HBe+8q8vd5j9a5ND0Y+LTk8uUoyshiKAreyR6CV2tcnlBDTfu0uswTitOXzS
	9fR+ctkcFZwuJfcU2lfZjjhg49cUNA==
X-Received: by 2002:a05:7022:170c:b0:1b5:3819:f8a with SMTP id a92af1059eb24-1b543bff8bdmr1034444c88.38.1794965913693;
        Tue, 17 Nov 2026 17:38:33 -0800 (PST)
Received: from phi.nguyendp ([116.86.30.120])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447c5b02sm1909602c88.6.2026.11.17.17.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 17:38:33 -0800 (PST)
From: Nguyen Dinh Phi <phind.uet@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Asias He <asias@redhat.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost/vsock: annotate lockless accesses to guest_cid
Date: Wed, 18 Nov 2026 00:48:43 +0800
Message-ID: <20261117164916.2332953-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_vsock.guest_cid is written by vhost_vsock_set_cid() under
vhost_vsock_mutex, but It is also read without that mutex in
vhost_vsock_handle_tx_kick(), and vhost_vsock_get().

KCSAN will report data-race if we issue VHOST_VSOCK_SET_GUEST_CID
ioctl while the device has TX traffic. For example:

 write to 0xffff88810f1596ac of 4 bytes by task 7914 on cpu 1:
   vhost_vsock_dev_ioctl+0x25f/0x720
   __x64_sys_ioctl+0xc2/0x110
   x64_sys_call+0x299/0x20a0
   do_syscall_64+0xc9/0x510
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

  read to 0xffff88810f1596ac of 4 bytes by task 7910 on cpu 3:
   vhost_vsock_handle_tx_kick+0x41b/0x740
   vhost_run_work_list+0x97/0xc0
   vhost_task_fn+0x98/0x1f0
   ret_from_fork+0x2e2/0x3c0
   ret_from_fork_asm+0x1a/0x30

  value changed: 0x0000004d -> 0x00000032

Both readers load the CID once and works correctly with either the
old or the new value.

Mark the store with WRITE_ONCE() and the two lockless loads with
READ_ONCE(), so KCSAN knows the race is intentional.

Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 drivers/vhost/vsock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 88a310390eb0..f26c59013075 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -78,7 +78,7 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net)
 
 	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid,
 				   lockdep_is_held(&vhost_vsock_mutex)) {
-		u32 other_cid = vsock->guest_cid;
+		u32 other_cid = READ_ONCE(vsock->guest_cid);
 
 		/* Skip instances that have no CID yet */
 		if (other_cid == 0)
@@ -572,7 +572,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 		hdr = virtio_vsock_hdr(skb);
 
 		/* Only accept correctly addressed packets */
-		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
+		if (le64_to_cpu(hdr->src_cid) == READ_ONCE(vsock->guest_cid) &&
 		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
 			virtio_transport_recv_pkt(&vhost_transport, skb,
@@ -859,7 +859,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 	if (vsock->guest_cid)
 		hash_del_rcu(&vsock->hash);
 
-	vsock->guest_cid = guest_cid;
+	WRITE_ONCE(vsock->guest_cid, guest_cid);
 	hash_add_rcu(vhost_vsock_hash, &vsock->hash, vsock->guest_cid);
 	mutex_unlock(&vhost_vsock_mutex);
 
-- 
2.53.0

