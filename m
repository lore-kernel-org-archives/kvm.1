Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650540A950
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342452; cv=none; b=FC8Vin3xnCOHem7WgvWs1fK2KglhExvwjfIs2J08IwcbFC6zYU5lx5kkQyLYTLPC0fTqS82ifk/mwO/92jkwjzlsthK/Oz96mGCXkxHP2+9MOFe/BrUZz6iSX6j9sflXCKXatvisvtWtxqaDQYFYcEckXSD/0k7ZMqEp6+eQetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342452; c=relaxed/simple;
	bh=1bgyDeU7x52yJFu8RjfDCvFh8ya6pUiQ0StZ7Qnbh2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DVdDYoBqIIu99b6VHdHGbyeioLen/2DA41TM/9zffdaZrd5gBjMMIeAPfN54AZdN/w/JknD95vM7jPK771IxE6QlizYjOm1UNXJhCSQLQOjXa3vGMto5fSLKnYhoD7JN2zAelTK76PejBGpAjdIjlHarg5nO0j/BaKgi51nxGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMVMhpVU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMVMhpVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783342450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q23b86ptzOLnqqhghvGfMuQR4jZfV1R+cfGj5j1FRlk=;
	b=WMVMhpVUMU7CigR5lFrIWswQQsVcLt0JmD/ua22mdlZx/u4a/QGp3vmhARWteV4JJgzpJi
	jP3zOZ9GYOS7CCx83f76DnaWXvbdxAe1gP4Zd6ZVIrT916aP2HU5LZRIxIcp5qJj2z+HuL
	tSETV9MlQM8J55UEUlwmifpd1A6tBDE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-6tFSBzOdMyCzMG-UtvgE9A-1; Mon,
 06 Jul 2026 08:54:07 -0400
X-MC-Unique: 6tFSBzOdMyCzMG-UtvgE9A-1
X-Mimecast-MFC-AGG-ID: 6tFSBzOdMyCzMG-UtvgE9A_1783342446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D07251955F20;
	Mon,  6 Jul 2026 12:54:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDDCD1956088;
	Mon,  6 Jul 2026 12:54:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/5] Various UI/security-related fixes
Date: Mon, 06 Jul 2026 16:53:47 +0400
Message-Id: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMz3bTMCt3k5EQTM6NUY1OLZEsloMqColSgMNiU6FgIv7g0KSs1uQS
 kVam2FgC3rv+uZwAAAA==
X-Change-ID: 20260706-fix-cca462e358c9
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=776;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1bgyDeU7x52yJFu8RjfDCvFh8ya6pUiQ0StZ7Qnbh2w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnI+R793oxQmkqEv3AAWJL7oo78LTjmeXjQ
 wDnZS+5uCeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5adoD/oDyi1zAfh2tz2BcCCAMbxmpq8JUvEH7VHBKp1tTUmuO3v4j3Ty+65m76DWtpBjuoYl6ZN
 MalT3PdP8UpXnQT5regjZByap+dqKMzBVltP54jKRs+/wX+bFVSa0KX6151NoNnbSOlp9b40YI5
 wv5Kql8ZTfdGNNkWEpLYVMWelGE3eW2/Q3V4RjIQATMghAyxA2lbgpEFMuG5lPeVIduK5bUmGN/
 FlJ39CVF8fvJhhANWO9CzUlKFeccfQTxrdxJ+2+h9XJeR9NvOcKW6RoWXDa3JN6c2jE4Fyw7LbZ
 CDqgBp8i071QgnfcOBL7IjChUW+yDlPziN0EjkXNWldLtl9MWPYyZYY5nIzWZ9/TceNk4nLthBA
 8FGGxZ5rLlXBBrYqe1aMAqwvQD+NuKPf+8b31FqDm0S56WVE05765OhWx6sbztCarRF0QcHcwlR
 nj5u0wIfsBJJq1LMjcq5Ql+xhgCtcaEQAq+ptPKsIk+ZwglBGdVd6lImhJLjSRkx8lh2vH/12Vj
 jt1SifEWIbS6G0OP4Yey+ax041F4bq9sZDOb9tIIxdG75spzADaIKPONpddhS3pwkYvG0wZXZ8f
 dy2/b7xmeCN5HbjX5dSrwJFHK+imCtr1cy+bmXzvP5av4yLQIdORjRFr0pUHZDlYLFHMwn+5pEe
 P/9sywkkMAotT7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (5):
      i386/tdx: fix uninitialized variable warning in tdx_check_features
      ui/vnc: fix OOB write in vnc_refresh_lossy_rect
      ui/vnc: validate color shifts in SetPixelFormat
      ui/vnc: use RFB wire types for client message handlers
      ui/input-barrier: fix off-by-one in keycode bounds check

 target/i386/kvm/tdx.c |  2 +-
 ui/input-barrier.c    |  2 +-
 ui/vnc.c              | 56 ++++++++++++++++++++++++++++++---------------------
 3 files changed, 35 insertions(+), 25 deletions(-)
---
base-commit: 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf
change-id: 20260706-fix-cca462e358c9

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>

