Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C60D30F932
	for <kvm@vger.kernel.org>; Fri,  8 May 2026 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258664; cv=none; b=YiojYUziKx+FgWujrlKiJmXBnJsx/AFWpBXp3EFkVpIbCLlsWdhCqoQ0lXjQWqzI680lY1HX+qoD4HMaKGV6oTS4djAsGw1pN64C7YKLKh14ct/U/aD/E4AQmsyXvtvOhaEMsFTAIsg2NjN1kX4C3ONmFYZ3DQuggkTEPT6mlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258664; c=relaxed/simple;
	bh=GmB8OB8MBui7lDml76JA2BxvhthP+WnYVp2rivY7tPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tK4ln3NTFybrX++4XNRCzwqu9WRUDkPp9Nfkn8A/C/TDji5QF00GwVzWNqTaQDEB4kntBp3cChtJA1fjhmondpDysBcxDfaHtVx9a3IJJQGWKs8r6vv/HTi6P+voGNoCapG+fPOoFt+8SHNnZOsTXRwzFJwmlaNudhUl0t2s51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf8kGTBx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hK7ds4ln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf8kGTBx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK7ds4ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778258662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
	b=Hf8kGTBxSBGAod/OuB2/Yh54v28UunnecbnGj4YWh9nIy3xeTWB6PzI7upuifG9KmtUwXO
	mLp6jm3E4//wwIZmA29cjvhJlcYqClmit9F5IsGOTa8aKs1YAeZYcb9KuafSt++VnPedAs
	Ve49LEPrXYQsM7pV4FTCe8duRMeE0gY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-ftB_aLAxOvq5ixWRPTcqvA-1; Fri, 08 May 2026 12:44:21 -0400
X-MC-Unique: ftB_aLAxOvq5ixWRPTcqvA-1
X-Mimecast-MFC-AGG-ID: ftB_aLAxOvq5ixWRPTcqvA_1778258660
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a1f9601so1693883f8f.0
        for <kvm@vger.kernel.org>; Fri, 08 May 2026 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778258659; x=1778863459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
        b=hK7ds4lnX3OcvmzD2Vkc4iPHJHNCMQ2lktxIgk/GOgqWz5HciWmwyOm+AQc51eWDKe
         20lwObNhGzMoYDD1MrIWfaAkEIwksrFsaRq3LAFAJNUXuef0Ph6P7gie5lM+hGrxDtKc
         z9M8GTicYeVGv2zcy1+Jpc1UGdJXxCSY9axnWEeHqBzVyYete2vccG0o5lsCz45Vuw4U
         T2JU6fnY92nTARSv4KZ6xuWuS/YJIERJNznC9/gl8TBQCUdKfW0jfsSswWlprNxwiJ5t
         h6SuJyEkKhA4AyTK4DpmLkGOk0nbtCu/cGmC7q7WadDlYuf5zAmVShvO6RYjWHpphSDb
         elCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778258659; x=1778863459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRysknO3j16TQFAanFHTedpULbyeYuuxZEHDUwxrXrA=;
        b=CbUX7ZGsbgfGbffQjj39MfiBSqAzyV05VcS+6lTf9dOQd7b9pZd7/nPEYLFkYStbG9
         NyPCCRLESGEqYoRo/uKdz8PPq0WmJ48CwOyeeIYuh8q5h9mr6K8BaAmfE7hsDfdwfVKS
         5U5uoM2qSc6zp35nsKrKYrTnJvQ5AsKq/lT6bnexxy0qtnazsTDEC/+T2rbPY+adaNyB
         VVnk0IvWzKCy6WUrScM8onMOU3xpWzVZEj1R7jxH2Vp7dMAqZXtSM21tvPso1Xf/64Hu
         drQVlgBphIatwP9M66N5IxnTaj1B0hSGWB1wc85UdJfaHWe93fLs1F+agY/HHif/QHAr
         bMWw==
X-Forwarded-Encrypted: i=1; AFNElJ9/UgQ7lpOAlSyZbXQDit2YYGQqbATgjv4bw6L2H7Uszmb/4fhTz7OrMV+qSw8sCGMMm/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzlDC9/znrCwNwdNdWpiskR6OwrSeV90IK+gTo7cqh2UXvYRm
	zmtxnAYojkDEj1f/e7586XJS5b5auFIlZr1FR4KG/xgwnFXo4hU9OVvdFNa9YHLqD6ggj6hQKsL
	xq7Tb+P6H5Vy4PkABdo4r55TtbcvPTEe9U0KWa3IG3GbRSyLaGazlqqa+6XF7iQ==
X-Gm-Gg: Acq92OHDf/gmRaxl+IxRx6+6tg9KyBrp/TVbs2eScgXHQZgG5BwRLTOc0M6DN4Nt+Th
	HHos/9wM9J9PxPaRcoFfzCqRhWlvHjvAhE+zvEkQDG2piOyiPQIWHcRd04oIR6nB47hAglnpT71
	/Vz1SoRH5NolYxXbh1bRE73JyZINp7Nz4mCZHgisfiKDj2s7JSAFE+6fu5DbZOw0FoALWjjh91S
	oCyEutzyEYXmEL10nM92rzQBgRG2LPkEQCZs2TEZaaXD1nWptyi+5gqXgIK+OtnWJyDIsh8/giv
	/7QwVl3GJvsNmTCLSQp+rBWP7hJN5RphF6HT9cIBpsw/THI9myEOa0EkDV7qHht8LNJtXGgr3WE
	qpQQzEnBHKsH9hdINlAYn/cSNCQdIZv4vl6Plp8tqPIv8J92AgFp6GPgOU2awEMuxK324XmU8KE
	u7
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr21832390f8f.27.1778258659240;
        Fri, 08 May 2026 09:44:19 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:43d:7508:c9c9 with SMTP id ffacd0b85a97d-4515c5752d8mr21832302f8f.27.1778258658503;
        Fri, 08 May 2026 09:44:18 -0700 (PDT)
Received: from stex1.redhat.corp (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454916df968sm5477523f8f.25.2026.05.08.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:44:17 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Yiqi Sun <sunyiqixm@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: [PATCH net 1/2] vsock/virtio: fix length and offset in tap skb for split packets
Date: Fri,  8 May 2026 18:44:10 +0200
Message-ID: <20260508164411.261440-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508164411.261440-1-sgarzare@redhat.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

virtio_transport_build_skb() builds a new skb to be delivered to the
vsockmon tap device. To build the new skb, it uses the original skb
data length as payload length, but as the comment notes, the original
packet stored in the skb may have been split in multiple packets, so we
need to use the length in the header, which is correctly updated before
the packet is delivered to the tap, and the offset for the data.

This was also similar to what we did before commit 71dc9ec9ac7d
("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
missed something during the skb conversion.

Also update the comment above, which was left stale by the skb
conversion and still mentioned a buffer pointer that no longer exists.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 9b8014516f4f..a678d5d75704 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	struct sk_buff *skb;
 	size_t payload_len;
 
-	/* A packet could be split to fit the RX buffer, so we can retrieve
-	 * the payload length from the header and the buffer pointer taking
-	 * care of the offset in the original packet.
+	/* A packet could be split to fit the RX buffer, so we use
+	 * the payload length from the header, which has been updated
+	 * by the sender to reflect the fragment size.
 	 */
 	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
 			GFP_ATOMIC);
@@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 
 			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
 		} else {
-			skb_put_data(skb, pkt->data, payload_len);
+			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+				     payload_len);
 		}
 	}
 
-- 
2.54.0

