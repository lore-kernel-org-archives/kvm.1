Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701868;
	b=wR1DhJ8VP8AHu18IEAufP9F7FFctY6rGUse/zaxi6MJFzObAU04h4hWmI0PFbQu3dTYB
	 +SrjZ2J3yIr8s2S1RpTOHdx8tWvMYPQrSGEkBn7Ax87rbz4sFmpohQrrwk33PtBQB3bYa
	 Pnxu+ZL5bvAiHjRv3pVEc6ak9hhSpSvH7yTqiCODQFoxg/konU399txtWfO7yy0G71cko
	 ycyeoSSKT3jbL5f3I1a4ldVnXzcj7bhtmAQO8oB+XrANRGydTfofvyp6xvGFspf8QpFUs
	 ESCnyBO/49tly6aTUCGM7+3kt/l2n4pADI4Z2E23lx6kxYuFf2LvNqucZuJufrQsDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701868;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=d0MllfycnKETQqVutN0dAB5WmCHzfWYy3+PwmH6ryRA=;
	b=WJW1hEoeDdA744951QGrnbjyNSqyfaltZ4z0NfBowvyzexEJupedIqARugvbDMQblLny
	 dGUNjdf6sQ8CQHIMMPPH17IQPACGuSQQ3hceu8ZPv3QlYBFg+nsd1KjOV1cBWGe7qR244
	 4p9tDhSz84y3L+QpvO4H+wcYTg74elrtTiVyniOFA8D4R2ovtxqkSbPi5ayxI/rPR5hVM
	 8/0JPNIPcPtcRMLD1DH3/aQHHDF9Q8G3efcmL91dMj0rdw8u4cEjKxnrS57e684Y6RNoe
	 iO2iw/pyzZmUPrfdJ1HFyr55N6RdIzQOkphAnLUr7iVzIh2nDQvBpj6iouCenzEfAWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT77FbF0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37977606A31B
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bT77FbF0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB1C1F01828;
	Thu, 22 Oct 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792701867;
	bh=d0MllfycnKETQqVutN0dAB5WmCHzfWYy3+PwmH6ryRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bT77FbF0GyCxfWDzE/EVNnTNm+wy4EUlKPFC+h9J8m7ihvnbB+i7qZOiv9yVZ8VmN
	 N3x3Q4aFwljcm/8hefpS+BrXGQV2ZCOHNUzfdo+nRCwRd8LzJMPGcTBT77mPYjO0JF
	 6zLsiQ4nRKiV5dSpYqlycDAANNp3MB3zZ9PdXakgbb0kHZN54PZ6NUnbrm5nCowYL0
	 E+FPK+evGv+oR7NkoZY9gg0SZ+r7W5s+zcOuAiOf/DKQR+/9u2Eo2Mw2uryX7cSJqg
	 +PldxJEgJrvG8qhVQz4WAiQqwv6dLYzT78wQUkcYqg8nvCvRpCUbP6f1ulIVUktO1p
	 FAX+x1GBKjncg==
From: Yosry Ahmed <yosry@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Andrew Jones <andrew.jones@linux.dev>
Cc: Greg Thelen <gthelen@google.com>,
	kvm@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [kvm-unit-tests PATCH 1/2] chr-testdev: Remove unused in_vq
Date: Thu, 22 Oct 2026 20:44:12 +0000
Message-ID: <20261022204413.856786-2-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261022204413.856786-1-yosry@kernel.org>
References: <20261022204413.856786-1-yosry@kernel.org>
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

in_vq is assigned in chr_testdev_init() from vqs[0], but kvm-unit-tests
only writes to the character device via out_vq and never consumes input
from the host. Clang 24 warns on this with -Wunused-but-set-global:

  lib/chr-testdev.c:15:26: error: variable 'in_vq' set but not used
  [-Werror,-Wunused-but-set-global]

Remove the unused variable.

Fixes: b412ad0d39a1 ("Introduce chr-testdev")
Co-developed-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 lib/chr-testdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/chr-testdev.c b/lib/chr-testdev.c
index b3c641a833feb..c23fd92a46308 100644
--- a/lib/chr-testdev.c
+++ b/lib/chr-testdev.c
@@ -12,7 +12,7 @@
 #define TESTDEV_NAME "chr-testdev"
 
 static struct virtio_device *vcon;
-static struct virtqueue *in_vq, *out_vq;
+static struct virtqueue *out_vq;
 static struct spinlock lock;
 
 static void __testdev_send(char *buf, unsigned int len)
@@ -65,6 +65,5 @@ void chr_testdev_init(void)
 		return;
 	}
 
-	in_vq = vqs[0];
 	out_vq = vqs[1];
 }
-- 
2.56.0.257.gf7497c7d27-goog

