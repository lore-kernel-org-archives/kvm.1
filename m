Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C626E369D4F
	for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787507981; cv=none; b=BUHmmr6HPg7jbW3xdUCjPjee+pfg8g3ZEatTodnEqXh2wYbpB2UMCGev5JZ2boS3MQOWhbW2FoM4TgKDZ3VBPyTDf51K/QjA4XcYt63WR1u51TZluIERUkf6t95ip498JFZnVrlfHX6b3CaCAylzo2nw0guTghpB885jNsDc3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787507981; c=relaxed/simple;
	bh=j+GvspEPFMJKw6+StUj0ft/LLbZU8zbHTx8oX1MMKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVsmuLy/kQmD52TfTKFLK34UssxO/CEVY+HMwK8irvJ8H4rb4ygIZaUDkwSvojXDQqkHzv4dMF1509xH7m30pMkcxUq0dnRdgJCLYm0Jz4uD6KrgWtKfjQoSlpAGSiBsFuIJHQd66xPch/PguLD9bwceT5rS8pRwlzCK6Vzx5Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4oRtADo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4oRtADo"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1665447a91.1
        for <kvm@vger.kernel.org>; Sun, 23 Aug 2026 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787507978; x=1788112778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oSG6MK2qQTE9wpGTHa2F4jMVfX6350zfMS2a14Bvdsw=;
        b=f4oRtADoEr14b5rw/5GmI7QM6w8Gw6/ITb4Jd3bc/sYrjzHflzu55LtZE8O00WFNoF
         NbjGGk/37VnUCCs8SI1FS+5H+YBPL2JzqMFm/oEq1KK/ynyWb6Ji14HVhvazcLThq099
         azdtDa9V/iIp0RZAettYkrXgaZxWgDjXZbUySBLg80vsUNi6KfQsJNHMRUJH7JlOPm94
         8DI/BP/QmAX6e/EBxZmyfsoPgHiCx9fa84mDfPvaABF5Kv/XIaOqvUdQiYpVvneGEXu0
         B20LBI5LmOQ98aEGEvh3l5zQTWlGOY9ojEsxFrym5fPqsqKKZm0GMn7E7i7fmt9EbyuQ
         Bh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787507978; x=1788112778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oSG6MK2qQTE9wpGTHa2F4jMVfX6350zfMS2a14Bvdsw=;
        b=MDvDqKjpYYDOREnOyKpBq3wsNdTZPDQBEFUBmnIKXuZ4zgGztIDtUCVxXa96UX9w/2
         yPon+dZ+5s/jTbJ5ijN0FKsZ/e904CeMb7IYNppW9zDgpw95Zban9krqFb7nfr5F7zQP
         KhgVXefJa911cPFXChcbOQP7Ko83tElS2mj4X/OITaG/yZqkPm5P9sIw2X7mKiiDu9ku
         8KTnoUJsZVBu2tepVABvpEtnlUNtWzolQf1cVHi0FqkhI8bLIeHbHHmn+knQ87VVAj3G
         sGmZTLjaiOh+nKpJ4NmeZvEyZoMrlJiwnxwmFvfUdTgmzzdqe1+RcrLkAquvyQSAfs+i
         KU2w==
X-Forwarded-Encrypted: i=1; AHgh+RrIjRLP0OhVPpke5oqJ6uz5xTMsQ/0Wo/XQ25MNCXNtx8YMkDp8phcbdOeMhM5MXBETX1w=@vger.kernel.org
X-Gm-Message-State: AFuF++lr8oxStBCTsX1IzeJMEGrBCqeo4fDmF6wwFEmzxFBdgZw/2fDu
	yfeF0KENMcXqHttjue9EuqEwvWIlR2F0BJDnaJnsNH+z5nGYSpMPW5l1
X-Gm-Gg: AR+sD13dyXFfgkqGssSXBc/mWihlKLaXfYyDkoIMJs62ScB8hw33hk2QDo2W4dJ8t62
	3xVGC9t4JfYQg7k/VABqLVrXjS7DzXNHUZ05wrvkv0d9atKqR9I26rV2SK7BCrzeahmTeon4d9S
	g4LT+aYTr0Mqj1sHFqN17EosmIL6tmiTAFsWOcRvvfG0c8sIkga64X85dp4YHy0+j6m711U4t5o
	1X7uECvmnEEZKfGtqdjLu8TiaUfY/LdFsghgR9sZV+gqPRn7Z37XnZZYhWZ9dYv+qhaLXKVefJH
	jwxQnN7vVF5Yg8r0kAanBfS2MAkqRQdULwN0bvAgG0hOQRzJM8FV62Hbi4owDAqZMIBgpdZWzHF
	qmtRF/hbB3RGxNT/HX5LURrrRrH9hHPsHtxi/pGXoC8cyMD4xHM30jHZNaDNkVBn9dWsjQl/D+c
	/m0xtI/4X/iKUw1ORh+GMFDYBFWBOZPBvIBE5o41BQuP9x0Uc8kEJEmjb2wkv2+ptIXCv5S3b/
X-Received: by 2002:a17:90b:4a0d:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-395c3376963mr33466205a91.3.1787507977903;
        Sun, 23 Aug 2026 10:59:37 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c8fd34d9sm3722818a91.1.2026.08.23.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:59:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	stefanha@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] vsock: validate packet sources after bound lookup fallback
Date: Mon, 24 Aug 2026 02:58:56 +0900
Message-ID: <20260823175858.351431-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both virtio and VMCI look up connected sockets by the full tuple before
falling back to a destination-only bound lookup. The fallback can select a
non-listening socket without validating the packet source.

V2 covered only the virtio path. Following Stefano's review, this series
moves the source and transport validation into a documented AF_VSOCK helper
and uses it for both virtio and VMCI. The VMCI patch checks both its
bottom-half and deferred workqueue receive paths.

The combined series was tested on x86_64 KASAN kernels. The original
cross-UID virtio injection remained blocked in three boots, CID_LOCAL and
CID_HOST loopback aliases passed, selected VSOCK selftests passed, and VMCI
accepted a matched RST while rejecting a mismatched-context RST in three
boots. All changed objects built without warnings under allmodconfig and
allyesconfig with W=1.

The current-tree guest-CID vhost probe could not be rerun because the test
user lacks access to /dev/vhost-vsock.

Changes in v3:
- Move transport and source validation into vsock_check_source().
- Trust the internally generated source CID for the local transport.
- Add VMCI validation in the bottom-half and workqueue receive paths.
- Send the related virtio and VMCI fixes in one series.
- Do not carry Bobby's v2 Reviewed-by because the helper and loopback logic
  changed; renewed review is requested.

v2: https://lore.kernel.org/netdev/20260820001517.2148196-1-4ncienth@gmail.com/
v1: https://lore.kernel.org/netdev/20260813121236.2328599-1-4ncienth@gmail.com/

Daehyeon Ko (2):
  vsock/virtio: validate packet source for connected sockets
  vsock/vmci: validate packet source for connected sockets

 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 net/vmw_vsock/vmci_transport.c          | 29 +++++++++++++++++-----
 4 files changed, 60 insertions(+), 7 deletions(-)


base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
-- 
2.54.0
