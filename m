Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EA3CF056
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265785; cv=none; b=jwfZPsrC7eMFynLuU1NGsBPampQ+AjG3UwZ0oV5vb94us0Eaw+IWSgHfIWCRlBxE6n2H1k7ZOgud5+fvGv5sG4qJquSP3cz/Hgqb0kRHy4ufjbLaOOLnqxyUkYd08cYtPXIwt+4BPVgGDzwg9lmKH5wM/5Gxg9IAyZBwknWuAMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265785; c=relaxed/simple;
	bh=B5WKSuazSjYIg6pXvSVj3VKZEuyDVABRTNFWpy0TJsY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i4wiM36Gr8mUeC2tdEqnCTWxl73x0hmRfkPRVolJg7kB1+gN8JCnKpzzOR6hzHqiQ39/+5cwCP81Sq0UnpsKUadIE1dGJ9WIaVbqQNAkKXZuoA5pYcu/Zfhv4nzEXHD57NFKsV+9KIYeMXeY64vPU7UbnZ45f6E47r9YQKN2LeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrGg9Jb+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ss/WZkPg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrGg9Jb+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ss/WZkPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776265783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
	b=QrGg9Jb+XofV/2WXVRRL3Uvjf2ZVn0c+vg4Ii8C39aule0y3je859puq4xgfucnx2mr8CN
	gcvLmHBqS2JoZXKfGqHwi5RwTQet45iRagYdakPToV4G2giRC+dsuB6sNWOPVWVlr65NNN
	nj4WsiLGqnrBmrrWOqq22FvL/qTA5u4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-wnX1naHTOj29UdPOgxlk6w-1; Wed, 15 Apr 2026 11:09:41 -0400
X-MC-Unique: wnX1naHTOj29UdPOgxlk6w-1
X-Mimecast-MFC-AGG-ID: wnX1naHTOj29UdPOgxlk6w_1776265780
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so7329474f8f.0
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776265780; x=1776870580; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
        b=ss/WZkPgQ00Ewmq6HAhvkQILiKp7EPKVX4vuMuE7LLDAqjLS4ty2/IsfHFhn+QgxZO
         aY25rMpvw+ywop6bwIaIMHc7NNllpHqL21tKsVugMgyqOgp4kUGUfaxWWMatbGaXTRX1
         Y9LCwOHOdtqWaJvqyE/fB5oSYNQaFbcYeaidBgmSOcrq/LVVmdbeNulE36gJMzuFIkwY
         IQMQI71diKi5c8WMj7lt8HsrSZLy5byx0UMMI31fUMk/oojTBxQvgV7MNojBhXMOjvjq
         w6sWVSmt0INE98V8XDNETWSLt6B7r8IZYUrYBPg7kjRrtkFpfy10GuYE9DvC5Or3WhvH
         pYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776265780; x=1776870580;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFZ1c4j1EFVbHkK0HGQBwId3xqOOHFTPClHfmjw9dVA=;
        b=qYPpfmvAGda70f6hWsZEarOw4DEbTm9sSXnqaCl1t27+teCqOfx9fO+2DHaCs+jvDe
         dYkuv10znZm7Ed58b1TlaAb6arLfnea7wuYymO+9lydk2w4iDxFh4+uekBfGXBHcgzS8
         as5khAnQPS509bsuLH1WpsXlw5AB+WxxJZYulrud3KxZ5JuktWjyD/56mIZjZqsOYted
         aYtcKYxFoIXVftcK0sTQh6FKxN7RHL2dGXrsSZcT4jRP0yTq4WLbE4E1gcHwTz5jGZBn
         FBm+6MFwnqPelxrthLoruklPiCy6qppyRJOGVUp9xbqfHNd8HvUNdJ4AQ9uLNTIuTIuN
         TDgw==
X-Gm-Message-State: AOJu0Yye3VCzSWaoChJRJb42SQbLyI9uLDJE/DTnc0E9aquUDCfz2jL/
	TxN26JHSUmeETAbk52Q526Px/miMS9eY4r1XHEW/9lqAt6UEBgukxvsb8MHPyfb2MzQJKglKXDe
	srSXGfs8C3A1A95s2JUxgc8ZmBOKtO8VUV+t4bTeqsyVVQ487hfRnqw==
X-Gm-Gg: AeBDieuRcuKtM8ypzfyheOTOkv+1HmeOW3lfP5KbyLIFXU1yiET8O2ilEBDS3vFJtoY
	pJm/7efJ26Q3pdZDZIlzc/6Sjr40lM307/nfnbIGilmBWAFiLcwm5oLsfdwiLh6ILUbrBovGGSd
	hqzj7MNu+XsfFfcHvfrmXdI7Fnz1vsz03BO0EP2ghl612x5yIWcjfZnWQwK0opheyq3nyrsB5or
	48iUyPxigBC+btfm0z9rbgSd86vFV2DwSS6CXhOhOd1BoyrVXLJAntI+Rr7WVyPu1k+Mq3REUwy
	yQkEnAEb4O1NY8PF+HGc+J8nEA94+QySRlktpOvxW/elnktG6HbGjZqfItgSjm/rgu5EOoUVHTI
	gA1+jV4kiGAFQ1kZtYY25J2zuLqbmGZdAhGJjTE3uUST+htSuEpncN3VGPBe3
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d642cd287mr33797807f8f.37.1776265780088;
        Wed, 15 Apr 2026 08:09:40 -0700 (PDT)
X-Received: by 2002:a05:6000:1a8d:b0:43b:3d4f:e17a with SMTP id ffacd0b85a97d-43d642cd287mr33797739f8f.37.1776265779553;
        Wed, 15 Apr 2026 08:09:39 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead35bf1esm5907557f8f.16.2026.04.15.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:09:38 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v4 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Wed, 15 Apr 2026 17:09:27 +0200
Message-Id: <20260415-fix_peek-v4-0-8207e872759e@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM3QrCIBiA4VsZHmf413QddR8R4fSzSbQNHVKM3
 XsiQUaH38/zrihC8BDRsVlRgOSjn8Y8iF2DzKDHG2Bv84wYYS0RhGLnn9cZ4I5bxWWvuGg74Ci
 /zwHyraTOaIQFXfJy8HGZwqvkEy2nT4l9S4ligrVlUjgDTsr+FMAOetmb6VEqidVSVpJlyYAdF
 LVG9dL8SV5JKirJswRpNWgrOqf4j9y27Q3PqHqgGgEAAA==
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test and fixes a
problem in existing tests.
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

For disclosure: this bug was found initially by claude opus 4.6, I then analyzed
it and worked on the fix and the test.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v4:
- Picked up RoB
- Increased sleep time from 10 us to 10 ms
- Minor changes to commit messages and comments as suggested by Stefano.
- Link to v3: https://lore.kernel.org/r/20260414-fix_peek-v3-0-e7daead49f83@redhat.com

Changes in v3:
- Addressed reviwers omment
    - Dropped test client, reusing the one already existing
    - Minor changes: added comment, improved commit messages
    - Rebased to latest net-next
- Link to v2: https://lore.kernel.org/r/20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com

Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: fix MSG_PEEK handling in recv_buf()
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++--
 tools/testing/vsock/util.c              | 15 ++++++++++
 tools/testing/vsock/vsock_test.c        | 50 +++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: 35c2c39832e569449b9192fa1afbbc4c66227af7
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

