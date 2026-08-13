Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF33AAF78
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623174; cv=none; b=NIhCSe3vQETaXYxXPTNd6WxQVDfl0+fIrKKmFVA4eDJzeBDP/JXNVogWLxzTXr6fBfTMDLFw5HwM9hN/Xcupukq2gR9espU7PbZeiI8MISx84ixK96Cunq32f39QgB8HHNQbe4p+j819MeZx4LBpmzMKdc3gwmYekY5gPvQ1Iv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623174; c=relaxed/simple;
	bh=/17flycYSc19MMlgQ2UNX8D5txCWeH/AzDfCPa7n4L8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DJsqxuttBQhK9VXS1BGMm1SfUZz0+lti1ABjHcIhmSwbVf7xaUeU1nUEPcdncvDn42vhMwpdN3HQBaU5jrcZCSDm3abrUFl5RlLtWBOBLauIgDDYW57sU6iBk66BLx/JpzalpEji/jIHVnUt2NH/QuK+JHc9JktJ8wfgbjZf3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oFIUTMOR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFIUTMOR"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceab75934dso8130335ad.2
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786623172; x=1787227972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7D5ColudFir3efNk2jSAtS6dOixRUPB2JAx0kV9F6Y=;
        b=oFIUTMORwgOEieNGXp2MtRKZf1gdtvqY6OpjO5d/YUXOirjCGApqU+liN7/7UCL8yY
         xQ02uHRCFTif20wkEjf8/I47eR9e0km8xgR37h+wd144r0Z3h2O2GDXdTnh+QrFbXvZ+
         xTD7fA6O/Pc0AqkjYuSNa6xEySdjzDDNDa7qP5DgOgGvS+dBlrdgcWBHGgfVkk+ZuMuy
         KXQ68IKI7TV36Tpt+FSNfPGWtrb+ZvdC15u91Ga27otBvW16eChB8fE2P3NsF3F9t8qf
         XYNDat4wJ/Imi9DiWPx/DN0OcdbVjXORttG9AGZEzqQMMu/HqgTrXRpGkNVVmHW+GuBO
         5XdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786623172; x=1787227972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7D5ColudFir3efNk2jSAtS6dOixRUPB2JAx0kV9F6Y=;
        b=M1WVozm6oXroA4d3U7TPEC0Ze6oUtZBteKYvVBhq0e2zNc+hx/o5fPr65JAI+I7+NM
         e2nTkv3tjKO8OPS/IEqi29+R/iZovvfJil3xMCCWFJkfgAGU5bhak9c4EVDkFTzgwOwL
         RBhMpUgITOCngjvpzMH1EMTaMzZb979t1D5NnZbmCCBuCVq7Q8DXnGyK0Ohpv6Dyxx2r
         OWqBC6sy0TiGZWD0oPtqiuFFQioURTwWjoulhOFU27rxMQnX5i0dwj9O/bPi83VIwIbY
         MzgSnOWqDEuF+DOFZepf3mDOrvuKkwWomXBpYbK3lIYqxfiYi5rrFCOAmn0KAyxUq213
         3ZIg==
X-Forwarded-Encrypted: i=1; AHgh+RpS06XaySZ/Uw7zuMjJNNYlBDVjRDjhaP2bUObg0eFZPPLqt+vKfjsLjN7eVW7uuOQj71c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMtdN74wWrPOCnaVO45vCha5SmbXnKXGaZd/G77JlUJUWMM6L
	th0sY3SrnvvWpyV166FPenpDyTRPfzK7DD9Nb3HkFQc5JraiMG/EQbIt
X-Gm-Gg: AR+sD12d11WjUneVX5dFddt2IXPa6w3zg2BXikfqyEy2Vf8Idw2nXRBgs68v5qoXMna
	kf5dYGRDKc5zg9hmW7FB4/LhJeiKLOVNQuKblNYOc2q81S3c/zP4fVEa5PhDW2j46MNTqSceT7z
	mEK7kQ3Q8K0pu43FCTwKKB9t5CN6uY1E0hDTOBlZ2Zv4G9fp5bNJJHXOL+iRgLr701Ulf3mbqFK
	/qzoYDmL2I+76VLO/N3oi2vbTtfl/g74EmtUTxnSytToIFQuLQQdeLyoHZ1JfmeIRHGSfhGIa+5
	A9J02nK7wXbyZnFgRZhy9b2C6lPgT/C9KegU4uWLDQ+9D2V/TX9PoWYScjWrzFXMHGxUk3Wm5Vw
	OkVvXeH+IWlefW7MGUe3CxdV6rkekL6rLudWiB7TZ8Pk0hv/yOkvWrfEV4E6mJ1KMOh5sMWm+Po
	JejMo1RQsV0iiN7DnTXFmWI+9NsSK7cgab26uoM+uqwrh7Xm/HXsG6P8z/d2W+lB8nHtZ7cbpz
X-Received: by 2002:a17:90b:53cb:b0:381:1c96:829b with SMTP id 98e67ed59e1d1-3931e0241cemr6853696a91.3.1786623171943;
        Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931d872ec5sm1069999a91.0.2026.08.13.05.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:12:51 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] vsock/virtio: validate packet source for connected sockets
Date: Thu, 13 Aug 2026 21:12:36 +0900
Message-ID: <20260813121236.2328599-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_transport_recv_pkt() first looks up a socket using the full source
and destination tuple.  If that misses, it falls back to a bound-socket
lookup using only the destination address.  The fallback is needed for
listening and connecting sockets, but it can also select an established
socket that remains in the bound table.

As a result, a packet from an unrelated source can be dispatched to a
non-listening socket.  In TCP_SYN_SENT, a source-blind RESPONSE marks the
selected socket established while retaining its original remote address.
Subsequent RW packets can likewise be delivered through the
destination-only fallback.

This was reproduced with two capless processes under different UIDs.  The
attacker discovered the victim tuple through unprivileged AF_VSOCK
sock_diag and injected a chosen 16-byte payload into the victim established
loopback socket.  The legitimate peer received none of those bytes.

After taking the socket lock, verify that packets for non-listening sockets
come from the peer stored in remote_addr.  Listening sockets continue to
accept packets from any source.

Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8becad812..f73e0406a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1822,11 +1822,15 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	lock_sock(sk);
 
-	/* Check if sk has been closed or assigned to another transport before
-	 * lock_sock (note: listener sockets are not assigned to any transport)
+	/* Check if sk has been closed, assigned to another transport, or if the
+	 * packet is from a different peer than the one connected to sk.  These
+	 * properties could have changed before lock_sock.  Listener sockets are
+	 * not assigned to any transport and accept packets from any peer.
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     (vsk->transport != &t->transport ||
+	      !vsock_addr_equals_addr(&src, &vsk->remote_addr)))) {
 		(void)virtio_transport_reset_no_sock(t, skb, net);
 		release_sock(sk);
 		sock_put(sk);

base-commit: 9006c116dd111d457bf5d074990210f70a4ad2c8
-- 
2.54.0

