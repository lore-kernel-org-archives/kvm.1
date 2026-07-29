Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069BD463B82
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 18:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351559; cv=none; b=Ns38A85sIGkGusfLtR4RtEUcExOFcQPBK9qBYkhvrYqvnmrzDnRgur1WJ57aKwPGQOnMS4zej2y7uyOiojBJPg5gjcvaI6xmR8IXSMr8CesYGLBX+iAU3IPf9yd2/QKVw4oQTupQvKkb/8oXiSny+5F1kz7bD1K0542VSc2G5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351559; c=relaxed/simple;
	bh=CnZq6n4lbArF4xO3Li8H/zaf5RFPjl2mChGqONYhzMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFV8N/yo1swsnzNhPTwZlM1rIfCjTslSde18mpQfa+PJLzPIK1Aog0sQlrORx5XIU5w2SyeG6erKErlFM8nE9ziIL48EkVoG1sCm6E2D4y+OHAJd1m5nUw0n/zn6QH46sHVu3YWKNrsrG3iNLsKlfByoW7bzpo6ystDvgWw3Dpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsdNTkqN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsdNTkqN"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8484f229529so1021520b3a.2
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 11:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351557; x=1785956357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=YsdNTkqNnFOiDGdIyz63pba8Agphfc8UwSvUvmyFarnMDoGAVoeiPudmfCdY67MN5k
         5LekO06ixGkBVMX0jpxKZOXBPvI9ts9gCFA/BcQvGFZu/jWWcupeOH+PynOEMKAfJaxb
         23bz7sAcUBC51Sv2GynRcFhqBZKO5X9dJq8OP5ErLFuQ02Vph7sZh+26FzHlBJyTlMZe
         2KdeYzlTG4JlU1UjlrYVGSLWseKwf1CXPHhfr7A3GcdQspIWrqctsvQIZgcY/ECVRcDo
         7lpEi8MvnqR/E3/m7hHm4wYKvHYOF2bobK33BsigqoiHAYPVVTVXZ0wD/F8qaONKHPt4
         GeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351557; x=1785956357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aoqhwluyb9WMKHWbPCTqTwB3rnIRyxwcbgywXIfiH+8=;
        b=OBV0ibLPZg5qeR3xLYPXsgK92AaC4JsUGWgCTpvQExlhRjiXLsocZfVEb057AGmWVy
         EkGvUOso+FTGHvnmheXJiKr6SrSRIZD2IrSRK8M7LKuBBjao/JUlg3CqR2ri/sj9Ivkk
         REPNGFmjVswwrlnS4b4N/gIukAqFjAqMOirs812VqGiQe/Zc8ttbGWKxDaysjiFzFlVK
         A4rVgHLuPpjz7Yi8ZoZ0cl+x6fb/7YueAHVJGCWhBloLw3QdrRVnWSO9Ceeuj2VT3Tbv
         pKiXWlROXKT6Q7dgJcHwftnGDua2DZpick3v37oHuGGSjTdu8sk4a4Myspyjh8CaK0Uo
         CP7w==
X-Forwarded-Encrypted: i=1; AHgh+RpIocMpbOHQc442M0N8KnxzR78wJdZ1HQj9jP+5fj95HhzOWk9z1ln9pt+WhGmOxSiduuw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy453fSF4IINPSxRS4Tp8ISDtlGbOzkBoZ5C103NOGasiwkCY/L
	Eo2zqSbEGhHEWjofD6yTt0BwAM3LU9E+1Vyp3nPORMCykeEzvbWbILIE
X-Gm-Gg: AR+sD11ReBnQ3mCEhCbWiMriPZSmwI/3Ol/BppSBFDTMGELeWzf74Fv5ym0+MWhgmaV
	UGoXl0I+WO2FrPTIB0Xud9WBK5bg792Manrh7Uz2998Y8wpfqC0uy2hFzMbldU4qB+yz0SvnhMm
	XOShkFjO+0UkPIW8SOjsBUcvoi7To1lQ8E+D2E8YOaCSqHz++tD2KcdBJqeQZ58Lc+vxcA9VWpB
	ApeAn4SNZFEfMvGv7e/ZSaWoOJGbM5n3GWDqi4u6grNCWws4GudyWegb9Q6vs9vtEBoR2FW04zk
	+09f4awzKUD7ZpkuBdcvfzXMi/ZbbNsQgdHT3isg1PL7RkjAi5w+w6V8YYxFGdblIL96578jx3M
	7c/PSFmG/pra/AJ47Sm+/u+z4dW/tR5rmP+jWTT78/6DYBucGPoJCKXDOqzfmAWZr8/ilNZskl7
	32dNrqvbnuEP3/1oAzEii3ApkrHiBm0ZN8u1Jr6Hl9e31uDmNsjt3ApqOyjswuI8PbhdNE
X-Received: by 2002:a05:6a00:2d0c:b0:848:732b:6b25 with SMTP id d2e1a72fcca58-84e93445d37mr8060469b3a.63.1785351557221;
        Wed, 29 Jul 2026 11:59:17 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba447107sm1237829a12.21.2026.07.29.11.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:59:16 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: [PATCH v2 2/2] vsock/virtio: avoid refilling the RX queue after teardown
Date: Wed, 29 Jul 2026 11:58:28 -0700
Message-ID: <20260729185831.3247971-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
made the RX worker jump to its common exit when rx_run is clear.  That
exit still refills the RX queue when the buffer count is low, so work
queued across virtio_vsock_vqs_del() can add buffers after the virtqueues
have been deleted.

BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
Read of size 4 by task kworker/0:1
Workqueue: virtio_vsock virtio_transport_rx_work
Call Trace:
 virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
 virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
 virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c:3478)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
...
Freed by task 141:
 kfree (mm/slub.c:6566)
 vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
 vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
 virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
 virtio_device_freeze (drivers/virtio/virtio.c:658)
 virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
 pci_pm_freeze (drivers/pci/pci-driver.c:1098)
 device_suspend (drivers/base/power/main.c:1968)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Jump to a no-refill exit when rx_run is clear, leaving the normal exit
to replenish a running queue.

Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260727035804.1860862-1-bestswngs@gmail.com
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index a8e1dd95ba8c..96c9fe8d357c 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -638,7 +638,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
-		goto out;
+		goto out_nofill;
 
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
@@ -692,6 +692,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 out:
 	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
+out_nofill:
 	mutex_unlock(&vsock->rx_lock);
 }
 
-- 
2.55.0

