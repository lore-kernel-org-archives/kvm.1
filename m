Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301638;
	b=ECN3JBIOEkIg06Q34mwWrF60pLucEjecCx6532EFcohuKg4UpAEHi6ZBgO9Y3iUfAvLX
	 DErEVupizXqOoJElzD1/Ru1S8aLUgymZzrQse6gbcSrxfriHvvC8fOBQxXO/mAkRyAe1H
	 TNliYNWGGjFWt4YJqb4qGasq2dvdofbn9OUiyM6x2K8cdGT4ZHtbvDeHh3I7g9OM+f+qX
	 rDnShDs2uCvZcsdhwrbvbQndsekKp/8htSu+whBJv22v4RM3b0ohKKw2G+whZd7deHKVd
	 P98HZOgwMZojN6JlAjrgCBXq561onB/5BIlP4D0tdIDnVutZMhfaeh013jiwaxurt+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6VUj5I95g/DnmFhalu50syOf9VCbIVGKu2KqtebqEpM=;
	b=uAIqPpnCjE26pIfjCGlHdp8S5K6CDtZM7Jqn2fzwRejreGByPNgWbhyN7swC7lRtcte6
	 NwKgyIQhtRW+NtW764QyLOE7Kz0ceBInxk21wglOYsPcpWkiwOO4AzEt9zrR/kUovwLnB
	 3NzRIOA0mMmXPDaSps9GcJduys0RamQ8HP4g2yHaVlXk0MS45SUrkFfQFH5e5G82I936v
	 9Asbr/jMxImGgSIr3QRETR4991LvQjFRGmMTKwDwsWY9QttVhnL0h2X50OqDtyQM7nvQU
	 +Paj3V6f42y/TfgEfJXW4Kc/bGYATgdAoHRLXBK8nXi8mZ4Q1Kl2s8usKvUShyn0Akw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yItuUYyR;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CADC606A324
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 19:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CADC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yItuUYyR
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-677bc4704cbso2644130d50.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793301637; x=1793906437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VUj5I95g/DnmFhalu50syOf9VCbIVGKu2KqtebqEpM=;
        b=yItuUYyRL0uSigkf9uWU/pnnQytcz9WrM6TwWB2wZBWfD8R/icWviMFJc0wiZAhV7o
         Dxsy1NSkMtErdjj7kWtdY8L9DT4z0V2LRqNBz0ZynonuwFlFKyc4C/YpV4QdTpHWNsCq
         oxs9r7TpX2STl4aSXv0OCwUAJnQcZgggwSsea6KozBhA8XkvjGQtHWP2Kn9HEhxcG95B
         C7/aagbM/xp16A7iju4s+kbuv58TU14ekFxzF8j1kOinfJ7YAR/wiYxc3JsF0Nem299H
         KDPOxQpgB7GVI4XmDgwDPCNDweqsObXWY6NSbDiqsiRVIyBHgTTD79m1nRDFhC631g30
         v/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793301637; x=1793906437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VUj5I95g/DnmFhalu50syOf9VCbIVGKu2KqtebqEpM=;
        b=D4JcxF4rMPot8UUigxRzFDigraH66I7Xy/H3ihOLNfsv+Io7C4HpMzbzyqGneLrp9U
         en8tY8ohk4MNbPVfc/xMIarZaHSBOjqMjrS2a5s4IeXptmMKCCN4VgoxuJ7n2t2aEm1Q
         3L8kAyTbdXspDNLmc+DLWv9XmCywi/ZL0Gr8wf4OFQ1mmnbFMW1SnYZ5eT7yAI9RY8PH
         v4DCRLJekOkyqddejLMN4XpuirEHry9hpVxf7o2RM6ipgc7BN/TlkeRfcaDC4vLR3QZR
         FkqBOmBxwnPymyXVUUc+cHoxbuWXjxYOOITrCfupTNtp/TR00lBZcYNNLC789kYvBNk6
         2p0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzN2uaGTpuUo7isGSCyCBusDUb6fdR1ogO0YcBZNOhCCbAX/xJ3zjQEmnLU43yB20139Dc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJZMQYLsEPDTeSkmIZ4SbprgN3JCjUYCMgUCD2QP3RTS0sVyfM7
	0f4A9AEjUTBpFroQ0rdbkwmDJryhhjh69UibbACKt0ZukR178vYtO8mm
X-Gm-Gg: AYBFou2ZtPeKhqsws0txARw9Nv9urPNocVyolIJH+olel7BPLYn9el4GMsHiU0rg6Kp
	XsjpE4d6qYqp9vjmc+OlKzIbBuduNs2LNjYG60uBif81HOjiEhiKDDYuZ6tLfYNfYyAL8Y1YMD3
	pHBjKy/NTgnbPPFiRg9GGhfXTDpZZvCbJeDTXGDVYuHZvEHzlWX1aIScbsrhCS2SENyjiKp2f8K
	thdrllAsOplfiOmJ8YOuoR+b6Pn23riyOL4iryzl6/Le/Az8K5O4z0O60QBvMvrgvuTMYzUjV8Q
	kXOPKHUTpZKhRmwtN99ZxeC16HeV9gSOWqFBcBbBqBWXd8wo8uHQKKW8KFIZexBOns0so/Vdhal
	IWPJByNC6hI4NaaiZG1I0B44mxzrKxySWAN9wfXZEqkz7kyi7QAghMOIPZvzBv2iSaOJaLlk57C
	NngDcLKjuEzB1Ksx8yR10T0KBzXvxz5LHXodxNiPcymwARNblAndbi0SVI8OtUWzpjzJAm4Ckl8
	IXao/9xdslGpAYNYqlh73uuN6KTLAja/kOViPTDQ9CuDLz/Y4mCfKnrghJgU9SE1g26frWOZkCU
	sOxAiWn5LgOsOBYEt+VNA/ZpzyYM
X-Received: by 2002:a05:690e:205e:b0:67a:56ce:ac2d with SMTP id 956f58d0204a3-67ba4c882f3mr52677d50.3.1793301637481;
        Thu, 29 Oct 2026 12:20:37 -0700 (PDT)
Received: from gmail.com ([2a03:2880:1fff:4b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67ba335ad79sm175635d50.0.2026.10.29.12.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 12:20:37 -0700 (PDT)
From: Matthew Wood <thepacketgeek@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
Subject: [PATCH v2 1/5] PCI: Add disconnected device checks to user config reads
Date: Thu, 29 Oct 2026 12:20:25 -0700
Message-ID: <20261029192032.1325629-2-thepacketgeek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029192032.1325629-1-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
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

Since commit 4b1038834739 ("PCI: Don't attempt config access to
disconnected devices") the kernel config read accessors skip devices
marked disconnected, returning PCIBIOS_DEVICE_NOT_FOUND and ~0 data.
The user config read accessors still issue the read, and if the host
bridge completes it with ~0 data and no error, they report success.

Check pci_dev_is_disconnected() in pci_user_read_config_*() as well,
failing with -ENODEV and ~0 data. Do the check after waiting for any
pci_cfg_access_lock() holder so a reader blocked behind a reset also
sees a device that was disconnected while it waited.

This prepares for converting sysfs attributes from the kernel
accessors to the user accessors so they keep skipping disconnected
devices.

On a disconnected device, existing callers of the user read accessors
now behave as follows:

  - The sysfs "config" file and /proc/bus/pci ignore the return value
    and return the same ~0 data as before
  - pciconfig_read() fails with -EIO
  - VPD reads and VFIO config reads fail with -ENODEV instead of
    returning ~0 data
  - VPD writes fail with -ENODEV instead of timing out with a
    "firmware bug" warning
  - VFIO writes to PCI_COMMAND fail with -ENODEV, since VFIO reads the
    current value first

Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>
Tested-by: Nikita Vetoshkin <nikita.vetoshkin@gmail.com>
---
 drivers/pci/access.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..18a206bb2a94 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -237,8 +237,11 @@ int pci_user_read_config_##size						\
 	raw_spin_lock_irq(&pci_lock);					\
 	if (unlikely(dev->block_cfg_access))				\
 		pci_wait_cfg(dev);					\
-	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
-				  pos, sizeof(type), &data);		\
+	if (pci_dev_is_disconnected(dev))				\
+		ret = PCIBIOS_DEVICE_NOT_FOUND;				\
+	else								\
+		ret = dev->bus->ops->read(dev->bus, dev->devfn,		\
+					  pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);					\
 	if (ret)							\
 		PCI_SET_ERROR_RESPONSE(val);				\
-- 
2.53.0-Meta

