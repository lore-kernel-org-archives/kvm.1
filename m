Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815A325726
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775117889; cv=none; b=Q2H5MNsUx48wYshY4ntxiQcUip6EIHgAjNeZB725jmMQmBTmb1ust77iDvRk3nN2UkBnTlVCywbR1p79iFZgSwj5FaYxpB2Qua8+7D4jhUnV7y+/6b/NaQ3IKU6C22rsy8G5tXIUk8Ny5vsQsbzOB+hXcBL9LZHvXB/QEfU+3Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775117889; c=relaxed/simple;
	bh=Gv4j5F5kmYPN2toSNOT0NUM+Ds/EorTosVmZDSuDh0M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AERaxQEeAXaPxOuBjt6Stj4F9DhYnaCjDyHbyjKyut1/WdM3MXNv1p/fRX7mqc8UQUzayIXnMJ36JBqannt2rrtUuZqm2xXTBVMv9iEGrqSSzvHZinsU4ixNq0+CtsUeRWeJUwO4L9GUaZOuKKMgb0zN7ScuBX4VlAJ/IyLNdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm7t+OgM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mwLdaXD9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm7t+OgM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mwLdaXD9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775117887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
	b=Dm7t+OgMdQ4Wfg5ug4cdghgZ8DGPzHtltpKN0EhpcO12jf4pb4/nO08+P/4a3aIPDGsb9a
	4pmkz2vTE1Qj4DO/AsorIs+sNbE0YFGts/duPvfbBUeMkF9stlRi0qPwzAJcVODw6CNW4n
	AZ27i2tw+aKj1E43UR4rX2/wWn4hY74=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-7QEux8vVM322oqrcesId8A-1; Thu, 02 Apr 2026 04:18:06 -0400
X-MC-Unique: 7QEux8vVM322oqrcesId8A-1
X-Mimecast-MFC-AGG-ID: 7QEux8vVM322oqrcesId8A_1775117885
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d1bfbd219so847982f8f.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 01:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775117885; x=1775722685; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
        b=mwLdaXD9RtuMrm3fBuz18SWWD+VRrH8bMQdv4h7P2rbIQtrdsZIAmYdEbfA/MEr3HE
         QJ/IWbWCyNsw7QEtg+z3iAKFVAjmAVcPigv9F3iNfnphwaDMi7VfZCKaf1BkQ9Ijk1qt
         9FocxWimnDOUQOzmsh8I+YBHcm4MoTJPQjDNNfbyIIbGgrB7h6F49WPxgDF/5oG22NAf
         bsjRPP+LSu7V6ojEPht5qOIsL7hpiw573xhT6q+7JpEiLL8uy83us9X/lYPQWpIAQh6P
         ql52p20tcJsXe4BF26MnT3WjBNl07oYUPrZQgMBrj8Ng4d/QAqMui/OjXDM03au38p5Q
         isQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775117885; x=1775722685;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6mFCTOwHARpB/AAY05EQ/dyhhMmoktNcIHAMGcB1vg=;
        b=FNbsAxtSQaB0ibmZh7+bWD6xg7tBCWzQjYLfsIERpybkyn/nG9ZtZPeYCBy5q1rQ48
         PgPAueB2L4ZwGYLTwRtWMJs6ZIXh9cZnb7HQkeqhpOoF/mrRpj4FQCciIIDzS9WZSU1O
         fjPyUGkC+FSYXb7it+Ho1wDRAzaC9w9vnLbuFUz6BCnF1oB7Gi7EggezlNGaudqYPjnQ
         PsdWn4MuI3+CFq46NaQa6cTkcWXABR+v1IgWMOCA9rRaQ54vJka9J25HbSJdx8lI1aA1
         aFmiS1Ade94HyZbAWxqPSLy2HTgPnM7G+tVpCrTQN5hQTeMn/BXtCKcG0sxJoHm6IAe9
         TgVw==
X-Gm-Message-State: AOJu0YyfMVYJZI04dPoIct3ubKgp5BY0whl/urmWWYvGDccUUj2Wk6K6
	vPfUnHYGFOpw034NydJk6+AQWoLBecfpTCYQ4igyPkKDBweb2gkZDMitVW8GBJrmuVFplkY2cD5
	OuJP7cNzAXQnMQ+2LdETDtNQKV98awtSRKZSiYUR066iUtFEDTfgGx+a+/CHXVy6W/fuXYbMG7p
	XMGgaJIQzuO1Hp8kWgAG3aN3Il22CCetpxDBeYab7h
X-Gm-Gg: ATEYQzwkssCi5OfRfngOBLOB//yrIrdq4dEVYO4DsdwyhQSDoZJ8nSvu3JB7qi6ufg7
	e2SDnutqHKnQqnSvC6D2zmgSsvva/F6+7llHRFJgrahJ2ziI0nbJ9TG1Ppb2mYbCHaFLwUMqVGK
	9AThQ30oBqjZ0LAKe2Sxj9ySe52qtJgJ43JkFwMfLZVpkXRkU0CAVG6pz6fIit/7qKun7dJx9Pg
	Zhbo3Krb0ojscfzwexDFsYye1kBglsRSeQ4cy9TCv2G71C9szxOZ3oeIs/wSdNcBAUYJ7pC1Mcy
	QT5b3oVWm8JH/BKHc6KEJLEYEJIeHjVIi/X47PaMrynYgjbNy7QV1CHFVgC3fnyADSFJN3O3q7M
	NnanugM+/0smAsUJdMGWIeyu0jMgTuG5OUy+ePlCAuao3t1TjbGLhKYJpaT73
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr110319365e9.3.1775117884633;
        Thu, 02 Apr 2026 01:18:04 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-4888356a036mr110318555e9.3.1775117883944;
        Thu, 02 Apr 2026 01:18:03 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e735532sm214476005e9.0.2026.04.02.01.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 01:18:03 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net 0/2] vsock/virtio: fix MSG_PEEK calculation on bytes to
 copy
Date: Thu, 02 Apr 2026 10:18:00 +0200
Message-Id: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEwND3bTMiviC1NRsXTMLY/MkC2MTM8tUYyWg8oKiVKAc2KhopbzUEqX
 Y2loAioNizF8AAAA=
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
X-Mailer: b4 0.14.2

`virtio_transport_stream_do_peek`, when calculating the number of bytes to copy,
didn't consider the `offset`, caused by partial reads that happend before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commit.

Commit 1 introduces the fix
Commit 2 introduces a test that checks for this bug to avoid future
regressions.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Luigi Leonardi (2):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++-
 tools/testing/vsock/vsock_test.c        | 64 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 3 deletions(-)
---
base-commit: 9147566d801602c9e7fc7f85e989735735bf38ba
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>

