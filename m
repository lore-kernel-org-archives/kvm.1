Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD03C07A
	for <kvm@vger.kernel.org>; Thu, 20 Aug 2026 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184964; cv=none; b=uxXtUPQ1QhIafGvid32SqZVNKkh0l8X6ZE8ofRl4xw5vxS9cjWK5T0MDPUcUwXek6fQfOLR/SU+XUkqSypajF7oQ7lwZjYeVYE6f9UhGzLyEINoK7wg5zxh5nt9S9U3tWZiaEZ/WT3IPdOgQNi5VSsPNalWwA2RAvWptwP3yn/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184964; c=relaxed/simple;
	bh=E3uXNxxcgOKr8O+Ol4NWRlQkVgWbAHK9PUoEMPh9nH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ps+SptDU4JuY0ARr9WYLvn2i/3kVMQ4n0VbKjufJSzBZr4vMt7aeEyi4wwQs/2Lb0uup/CRPHrAs5z5RvS7OTNN+Je+y371A7LgJzUCHaSvBoZkiDk3mJvHgESxrB/+VS6jsVvlWIWuwn5pQwGnNZ/JXdJRMEKktNrxOL93QYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKyZU/gN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKyZU/gN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccf2360620so12223805ad.3
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787184963; x=1787789763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jslw2VH1wX/f/fbPJ3JCQynMI1RaFB5i5SOhQ447iqQ=;
        b=cKyZU/gNSkquZN/XuWP3YfkZb7NUecyEf/pYoPxUfrpwlSxFjXLrUvu5jZJtpACbZK
         sfkg6SNFQQmd2a59ZrGr2hhCdL3oiMinEDNqaL38X5IMezpn0WYZ25lTJtMmVwRVyHi2
         IHkx8KxPetpn+zjS96i6FVtRX8k3pK6trkI3GCMdj6Wg3gg6BQx5OFd/YTK1Csj1YgLl
         tBW/fvIP9XR7J0VK6wMcLw4nPXkI0KmMD2fOReevNRXXEQ8WWPQFkCsSz5QDU00bKL5j
         PrdKRjvdI2tEh+POXAUN2RZF3wPytgZfWI/2lKelpxdavFE2EPOcC99qo3vmLTFMKnlT
         e29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787184963; x=1787789763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jslw2VH1wX/f/fbPJ3JCQynMI1RaFB5i5SOhQ447iqQ=;
        b=fQGxXdhcCUzQgffxhDpO4ZdAKH+YuBhLcNv9hcIvfJ+saaS6CK1hQ1Norpnuohx+oM
         MUZl87IlGuq0Dagiji2XiluqwHzpqKfvaRTLIkyYJFRtGN1h8yBcPtYZguoKJlXBySGy
         gwzDIiDGHWPFZQT41cO0wVGC4jYq4/6nLFBt4j0CAy3mYJMFxkcPZAGbMCFhQZlzbPmD
         kY/LC/kdO0WNc1whyqHZUmk4f9NDwvTnc7QAZ3PADvr93CqlHIZJvNyrkbdcLY6eZpw2
         B4g8EfsseFv67Kmqy90HIlYt2egPqqRzqthcqCN+9nIaxNxy7eJBOg8U6lz4QzuAN+jX
         WpHA==
X-Forwarded-Encrypted: i=1; AHgh+RrQqJqe/fxgUHJxfulm4NTH/i7Ws1VZIqNrSPcj5E5HShjQnGWWzBO65jhA6q52yHyjo6U=@vger.kernel.org
X-Gm-Message-State: AFuF++ks2Gd/+pV+vfz+PLAQchHNfbB8BkJ5hGYl3AmDeUiwmkObQfXY
	7X3XMOuysZO4lRw7FHfZwXdDR90ynpn8k9anG0/rcyolz6ZenyssGUk4Ww303ZHE
X-Gm-Gg: AR+sD106J+s9SDYnlcBRgI+ird7OYhGL5suAkEZahXYXXyjrjGxYTM5UIug35ksx+E2
	t5k2VsTVk4u7f66zQddyN5wSk3t0dgPozIeEEtenke+EFwzdogWB8WOh3geLqxj5nkzp09Sr9RS
	xQQBOXXrOf6Y6yIZ10clVvVbuQ1NQ9FILwfzXAp28gx+iTbR4qisPD3XvhdncejC6o2wrqEM741
	EX/hEfjcdFqo90aoZOLAToH1lJtBMRkFNn0HF+TRWmU74Z/kD0MxJYa086Fwn8uqoxGpaOayeng
	7baF0845xAWMgFvzHSY/ZW6tPd1a1e7h/twQmZ+1D1qFIVZbAnKLlJa2m5pznrgnNSurllkACWB
	KMfSZZdx8Wr4zQTZ8ZkSCoYAzO38CfpyiO4IJrx97DaKw6aVU9cqjP1dFO8HCmhEdfveywTOWBS
	5XWstgHZJ6qDUk7zDcS1V2K0EYmnl+OuQ3H1iABQTwSt4YNC+DmkVyacQdszFIJhbiOawZ/moG
X-Received: by 2002:a17:903:1ae6:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d60185bde4mr163961655ad.9.1787184962718;
        Wed, 19 Aug 2026 17:16:02 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3cf1e3sm197075ad.72.2026.08.19.17.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 17:16:02 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH net v2] vsock/virtio: validate packet source for connected sockets
Date: Thu, 20 Aug 2026 09:15:17 +0900
Message-ID: <20260820001517.2148196-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() looks up sockets first by the full source and
destination tuple, then by destination only in the bound table.  The
fallback is needed for listening and connecting sockets, but sockets remain
in the bound table after connect(), so it can also return a non-listening
socket.

The fallback does not validate the source address.  In TCP_SYN_SENT, a
RESPONSE from an unrelated source can transition the victim socket to
TCP_ESTABLISHED while its stored remote address remains unchanged.
Subsequent RW packets from that source are delivered through the same
destination-only fallback.

This was reproduced with capability-empty processes under different UIDs.
The attacker discovered the target tuple through unprivileged AF_VSOCK
sock_diag and caused the victim socket to read 16 attacker-chosen bytes;
the intended peer-side socket read 0 of those 16 bytes.

After lock_sock(), reject packets for non-listening sockets unless their
source port matches the stored remote port.  Require the CID to match too,
except that the loopback transport uses VMADDR_CID_LOCAL as the packet
source for connections addressed through its valid CID aliases.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Closes: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Preserve valid loopback CID aliases by matching the source port and
  accepting VMADDR_CID_LOCAL only for the loopback transport.
- Rewrite the commit message and receive-path comment for clarity.

v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/

 net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8becad812..d8990f5f6 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1764,6 +1764,21 @@ static bool virtio_transport_valid_type(u16 type)
 	       (type == VIRTIO_VSOCK_TYPE_SEQPACKET);
 }
 
+static bool virtio_transport_source_matches(const struct virtio_transport *t,
+					    const struct sockaddr_vm *src,
+					    const struct sockaddr_vm *remote)
+{
+	if (src->svm_port != remote->svm_port)
+		return false;
+
+	if (src->svm_cid == remote->svm_cid)
+		return true;
+
+	/* The loopback transport represents its peer as VMADDR_CID_LOCAL. */
+	return t->transport.get_local_cid() == VMADDR_CID_LOCAL &&
+	       src->svm_cid == VMADDR_CID_LOCAL;
+}
+
 /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->mutex
  * lock.
  */
@@ -1823,10 +1838,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	lock_sock(sk);
 
 	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	 * lock_sock (note: listener sockets are not assigned to any transport).
+	 * The bound-table fallback matches only the destination, so reject packets
+	 * from a peer other than the one stored in the socket.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     (vsk->transport != &t->transport ||
+	      !virtio_transport_source_matches(t, &src,
+					       &vsk->remote_addr)))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
-- 
2.54.0
