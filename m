Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792752043;
	b=44TJM/qbSyOb+V/w5sC8E/jt1wL+sLZnV0mVbxx4OuMyWIn8h6h/NdlUUW77bS9tDmp/
	 082w+OIlymo0EU6lxV/eqi5PNDxF8oSV8sbdIba2WiEPS8ijsQq/HXX05CdpCgTCWo4zE
	 Fp5nYsRgC9Top27VM+TrtaHLke24+4JESbkzYxp91Q1qnje4lV1db8rbstFUvCkcg4OJP
	 ZuIzcnp8PJKBb+Q6n8r2Sl4ET699IiAsLwkyfKZBl4CYW4OywrjuybeVL4w4m1vvny7A1
	 vZGbbYo7hKkNUMa2qOOl5HQ/SgB7OdV+/oTYSz9oWyM2tUBA5okD2yzlsfXsC4ARNcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792752043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
	b=txhWlZToTOLXUws5NF7SlN9llsQWI9JUdr3aG8Kzgv0oG9d6NJTVmdZWdTUZwk7u0YJz
	 2kqbGhlxih4U6AeErhmYIBbtImQ9WohroGrYX8GncB/D99gcLf9RX4H5W1KE3v2sIp3hO
	 L/sGyXZx39Q7vETPdjmYaLhtbikyld60a/vs+tYMZKQE0jZd2Rq312NVfGqU1Tp0OMNGU
	 tAjHkaXMvv2x1z4ZJIamvjJQa9VFuBTAi5Eyi2D4NPEJT9kmpY9BASv+Ksba23D8XnByL
	 scZkWolQX81pqZuzX4sPbtX09qo3+0kBt81Y8C2CgA1jfk+mFry+BEAXyfXDJkOVAGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6s2C5Vu;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC719606A320
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 10:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC719606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N6s2C5Vu
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc502d509c0so268785a12.2
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792752042; x=1793356842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
        b=N6s2C5VuIa6TtEuPqdllmx/G8ra3m0faGDWBnZw+fj5k3NmLUHlKGpmIL+QIo5BHXN
         kgokd0TzFnYZ2jnTj+4ee1OPSRoEpOIiiz7VgqNG6pg1z90cMaU8QaNEe2IIwIVV1RCp
         z4kvIUFCc++Aq1QYnEDvIVpNJHdygjE5QS9f8yzm0K1t4p9XrMvZuVVw/VVKBQgMoQB7
         nBBaxWeuG0wMQyw1hROWVHjQf+SLTD1wL4GD4+GqNRrpG39oxp73f3XCVrN1hQYhP7Jv
         5K0x/GIBnJDf11j10qYrzExDKCYROoLMtUakyXZBsr3Z7sIZby6j3p2zOaQ+NqZq0n0H
         gXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792752042; x=1793356842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3fn/qeSOMh17ArAGKi+SkWfmCErKg3ju5QLNHCwzqmI=;
        b=JbpxEmKU+T6/Q1HHNowvXC6cEPE0MmUhpRLiUe2X7V5hMrPFcpXukJxRMKIqJgAJPp
         sGO+yndauULAQxpKGVmO3DrcuRAbgkZ/BlZ45dn0+LuSGsY6pV3BE3rRqKUSasyXjrVi
         IcseW58/GLZ+6AofSzBG17qgLwq3wTYaKYiLxehWwJgxqSF0rpfmg5GUp9o7iM35o6A5
         a4ggksCK5Zc/xp8Gkxu4PWYeJIOpSgEQKI0ZdFh+J/4m2kx/1SBAb/t0kpfiXrcnWHtY
         a7pVnc7BqE/Zj9mUkcyvEPCYkRItAL4lh5oOOzuytfjuOHrYXu/NwhM+3+dasTMyZFgI
         PrMQ==
X-Forwarded-Encrypted: i=1; AKwUvByFI9WcJ2pJyC2FoO3ICreALCJPXm2t86jPNb80NfeOJcwoAMbLQYxqORZP8m+jFgyghUw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWOOKNYgEK/hYpAFxcI1fUetvJM+ssHIvy01AShzUzSP138x8u
	LflgOg4hZ3NkDxewK03u50+Wi+u8OOiU3/Qlf+X6wiTYefkqL8cnl8af
X-Gm-Gg: AYBFou04EVoY5T9t0/ysa0NOXHNj/LLW7HD/Ebo44LBoiDL8TnNwMSf810IXqB0rmjS
	163eu0jK9Rwu8GOS3VNX3oRZhiYrCtpOOTz3w1vFoLEiRUV7qDI7Kr/D2GhyJxZ3TQgqUabI5RK
	zJKA/h+S8UD6h0PWGQJQ2HzsZDuAY0yPyUbqOdzR/fzMHgX+0K7kKHuLBJA+GNQi7gJXUW/DkGD
	pKmd7Xz+SJtSIdemj4bFH3WfORGkEcudNhFVEIGYoW6tTvy0qm6wrAW3X7DLgi21QVmrW2njdDC
	idF1oP2NCx669eQR8LqKzsQ/AtsTBx3yUBXKwIxCxKH/WFrdyyvF93ZhD3wX6bc+66A0tfKxFJ4
	YpUoGJqHjXXeyzDFra9khGQJCIWuF+SyrhJ+WMyCIakBpryvc65lvscBT6B2BVG+evmkx/ZRf0J
	OfgDE7kuIMNQTgsQNxKhGt2udycE7jAyZpfsE9/Tol/FoUW2lbWPVlEkcpbGnuplgyc7MMsjoYv
	Mgq9ZlXNG1wi4xLZRrZu14v85PBXhowpRMNi4Ns29CwiNiXhOTNfMuLSA==
X-Received: by 2002:a17:90b:2543:b0:3ac:b08a:ed2c with SMTP id 98e67ed59e1d1-3adce08327fmr1475446a91.40.1792752041791;
        Fri, 23 Oct 2026 03:40:41 -0700 (PDT)
Received: from gmail.com ([185.220.236.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb1b133dsm3300636a91.7.2026.10.23.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:40:41 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: fix page reference leak in misaligned I/O fallback
Date: Fri, 23 Oct 2026 18:40:35 +0800
Message-Id: <20261023104035.6686-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
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

iov_iter_get_pages2() returns a byte count that excludes the offset into
the first page, but also returns a reference to that page in pages[].

On the misaligned-I/O fallback, vhost_scsi_revert_map_iov_to_sgl() puts
pages already added to the SG list. The cleanup loop starts at
pages[npages], but accounts for its first page as PAGE_SIZE bytes
rather than PAGE_SIZE - offset. If the remaining data starts at a
non-zero offset, it can finish one page early and leave a page reference
behind.

Use PAGE_SIZE - offset for the first remaining page and clear offset for
later pages, as in the mapping loop. Without this, each affected request
leaks one page reference.

Fixes: bca939d5bcd0 ("vhost-scsi: Dynamically allocate scatterlists")
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Testing:

- Four fileio vhost-scsi test instances repeatedly issued affected writes
  using recycled backing pages. After about 1.33 million requests,
  MemAvailable fell from 5.3 GB to 13 MB and swap was nearly exhausted.

The affected fallback is reachable from guest-issued virtio-scsi I/O.

 drivers/vhost/scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 4f8c0260bc9e..b0a536fbc69a 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -883,11 +883,16 @@ vhost_scsi_map_to_sgl(struct vhost_scsi_cmd *cmd,
 	vhost_scsi_revert_map_iov_to_sgl(iter, *sgl, sg);
 
 	iov_iter_revert(iter, bytes);
+	/*
+	 * pages[npages] is the first page not added to the SG list.
+	 * The remaining data starts at offset in that page.
+	 */
 	while (bytes) {
-		n = min_t(unsigned int, PAGE_SIZE, bytes);
+		n = min_t(unsigned int, PAGE_SIZE - offset, bytes);
 
 		put_page(pages[npages++]);
 		bytes -= n;
+		offset = 0;
 	}
 
 	return -EINVAL;
-- 
2.34.1
