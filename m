Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2CC22A7F6
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787704787; cv=none; b=fyYAGQ9rnoX4kH0y2yQ8N0h/+Rre0vIGOnJkXFFFfOr3gfQ8960F4tF5sNRIa3yQGgaM4w8fEqQ/RbUwtrfifiJ4fo9LGictuV0nyHM4UAS6kMcie6vvDLN+JJ8ohq5bprwJYU+O3v8+B/CafJVLq+GDnKvO/0LJwls3pVrVpuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787704787; c=relaxed/simple;
	bh=kHJYeCK03N4sVT6BcZHnRJF/EyIgOKmsMbTVuSX3Q8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Huxy4GXWdRy6uMjLBySzBxUSTlodoxTonkrxdEnAfOf+Qa6WQffp0+QHUzRY1qse63eIi4LKV91mJOyvy5y1tOpEzq/LZqt50F/MJwBl2TpSQL6D1DtuTyl2xTiqe9D/wPri0IdER6aB7aWQ6W0DQGzInyeEN9q8vOCqsC/4mNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAg6+SaJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAg6+SaJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e507b079dso389384b3a.0
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787704785; x=1788309585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oi+0Ngf9vOWuRTniUDFfPIIsu68mB10Me8n+jj7RJuY=;
        b=PAg6+SaJ4Liidwc7SmjxZp3Kf8OjYFAbuBavHFf0V7Sgt5OJHJuiphq7MXdjgmx2dA
         mvGbf85RRMdmrld1DgR9Ylpauu5KqWOb/59n4I6bCIc03iiabyRyUojuQAUb04Y+C03y
         CQjnr2I5qyrJbuZK93BAQbsfJ8MxQtJ9NOsHDPyAhr6UGb+g89fNIaKjDiKggpU35pxW
         KxBNKVY2w6eJo7C3lxKcMqCBmTElg8ejyUKgfD9TeGoB3h1wW891JiNVOX6/nIuH3ypN
         BZOicR21kx1GrCWi1Q1FirIPbcwtWZkRUvI8ktZ4CM6ZcMWS0VWd8NAMHSEWi7hvOrer
         sNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787704785; x=1788309585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oi+0Ngf9vOWuRTniUDFfPIIsu68mB10Me8n+jj7RJuY=;
        b=oxCapDaDabdE7ePJW+BFgZ+rxnvdY5zPuT7nZiTpdAyuK/lQyKPBPkVNyy31g24qvZ
         KwjV1f2sezZqqKhXW9dfopkggjULjoGZ9bcXdL42cmgtwxSeHnPGlJ+sLD2Y7iiDzZa3
         L+G/evIFE5kfqFKYyQfHGMzA+OT1nkyiJ0EjqYaJnvftmQK3G9dHXbN8UI4l24jyufA/
         NnHxEMzecM3eWJ86ZzCD3TFGnNc22oEEQUDQHqZtgXTIi/zODydrMZo4Ag+XJk6Oa3ca
         qJsQprNQUWPcJ9l2LbGQNlsAlt0kpMgyKj6WpgKoOESJ722X8HmW77o4VoYf+9edxfOX
         /Wdw==
X-Forwarded-Encrypted: i=1; AHgh+RrRZpURl3CV9trT/Z3ufZXEyB4slLIkAFym5K6qyXkyQxKtkgV8KlFPbXfBva5nlqgEfSc=@vger.kernel.org
X-Gm-Message-State: AFuF++kOa7Uksu6xHouqTnNatpJUCF/mDjbI5GS5wN3pW0sgbwCqH+XA
	WhzM7aAxqoLkxH4N8NsqYeUHMjpb9TG/EQEZ/qDqFcF+5neXOo9jVxsA
X-Gm-Gg: AR+sD12peaDzFIDGNZhRsPrel3R9UcdoLGc1f+IdJL/NxFbNqbEXHmmvxL+Fbr3pKOS
	zyQWj2C5XP1H96s7en98t1Tlrd77mgOSiNRJWXiQT3980mNVgfdQxiiHTswyj9UH6tEMfBqmdl6
	RfSYzmWGWEkYU0m/5iJmrUEzemh6ZNK69qCSEYeRhIfJ8DbaDxQs5zfTDunN6Js6qDRU9BJQpnx
	+Vb8Gan49A1BSt6ZpXBFOzb+4xLEFb0LZBY1Tk81RMZ16obKcZlAcHpVbAq8NGdfsxZ5P4Zg+J+
	EAldyHaiK6oSxonud+8bbRWUNdRpqJVI/4ndUA2hk4jEsGubxzW7GzWbYV/zhSol5Nzj2YpEsOl
	z5oEZ9BKPG8biewgLVy1DslcWFXIMgkMp4DnCFI91V9h4T6diOWA5UQ7coAcO+4oLL/1/OoASQm
	u+wLxQtTTaYC7luq0z7wRgUcEIMT2YF26tcxvo1Wu7xuISW8x7NyryBYtFlHLsG/LZMOnXOUs0
X-Received: by 2002:a05:6a00:6c83:b0:845:e7ee:eae7 with SMTP id d2e1a72fcca58-853720ab337mr5049138b3a.5.1787704784879;
        Tue, 25 Aug 2026 17:39:44 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535cdc038dsm339377b3a.38.2026.08.25.17.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 17:39:44 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] vsock: validate packet sources after bound lookup fallback
Date: Wed, 26 Aug 2026 09:39:26 +0900
Message-ID: <20260826003929.966160-1-4ncienth@gmail.com>
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

V4 preserves VMCI's existing RST behavior when source validation fails.
The reset is addressed from the received packet so that a bound but
non-listening or concurrently closed socket still notifies the sender,
without directing the reset to a connected socket's stored peer.

The v3 regression was reproduced in three x86_64 KASAN boots: a REQUEST to
a bound but non-listening socket returned VMCI_ERROR_NO_ACCESS but no RST
arrived within one second. With v4, the sending context received the
expected RST in all three boots. The original VMCI source-validation oracle
also passed in three v4 boots: a matched RST reset the pending socket while
a mismatched-context RST left it pending. No KASAN report occurred.

Patch 1 is unchanged from v3 (identical stable patch-id) and carries
Bobby's Reviewed-by for that revision. Its v3 validation covered the
cross-UID injection oracle, local CID aliases, selected VSOCK selftests,
and W=1 changed-object builds under allmodconfig and allyesconfig.

The current-tree guest-CID vhost probe could not be rerun because the test
user lacks access to /dev/vhost-vsock.

---
Changes in v4:
- Preserve RST replies when VMCI source validation rejects a packet.
- Address those replies from the received packet rather than the socket's
  stored peer.
- Add a bound-but-not-listening VMCI regression oracle.
- Rebase to the current net tree.

Changes in v3:
- Move transport and source validation into vsock_check_source().
- Trust the internally generated source CID for the local transport.
- Add VMCI validation in the bottom-half and workqueue receive paths.
- Send the related virtio and VMCI fixes in one series.
- Do not carry Bobby's v2 Reviewed-by because the helper and loopback logic
  changed; renewed review is requested.

v3:
https://lore.kernel.org/r/20260823175858.351431-1-4ncienth@gmail.com
v2:
https://lore.kernel.org/r/20260820001517.2148196-1-4ncienth@gmail.com
v1:
https://lore.kernel.org/r/20260813121236.2328599-1-4ncienth@gmail.com

Daehyeon Ko (2):
  vsock/virtio: validate packet source for connected sockets
  vsock/vmci: validate packet source for connected sockets

 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 32 +++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  3 ++-
 net/vmw_vsock/vmci_transport.c          | 34 ++++++++++++++++++++-----
 4 files changed, 65 insertions(+), 7 deletions(-)


base-commit: dc4b95b8fee95113587e93ca116356032d271371
