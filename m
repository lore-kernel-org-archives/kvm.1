Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203498;
	b=XGtakBfc/f3JYNmZr4beQG9lEyJPlOPKzZYOWTNctMLDD8un3D2gOmYiZMAJvvfxo5u1
	 bnt4fi7A0sHsEyBO8XlAD4aBR+U3VzJsqlRLdn1Zzy0zXzfwaZnIGO8SgBxs3EVauVI2L
	 P+RtTH7ntc7fjK4BkGq/HfAGEZFYUIbipPCNnheK5rx98iRZibBNL2xj1Z5RDszV2si+o
	 H1He+VlV+W/V1Uhj/NmVYsO7f4acacejsNxUuVOTca7SNl0jf/5jBekjOYQMMy8rA7Rwe
	 1lBSSAQjjnSeUZgaepaqJilnXlVW4XdK44rxLFlUBWGFbOFqcD1oHwh3TkvULuOnvdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203498;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=m6090YTazdBX+2fvHS5lDC/8v+j07HK4C6YHhGPDORVYHFhpNAIwJJvWsRbbS7NssHGG
	 FfAgvnrixgKAIEQStP70m0Hwq95IVTeT/T7ua667roo0ZVmmedxXw/0jKqYbBFrQgHDdn
	 bHdj4IKh493d/lK2V3ORstY/yNAvM5JPQVwv9Pb2w/xRIb2rEK2MYw/x7zAQ7+XrWl83G
	 gyIYrBKO9E63xi87aroNIg2dL9g/IYUGFJ05wAadxktJqiRkEZ6ZmUfQ7VwMKzyodnvRW
	 HTvpEkubSNpTImemJAjixR/sZgWfityA9n58swUrETT3atcDZCsLEuy5dDcpBC+Pebw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFDQtIph;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FQm719pg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20F606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F20F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFDQtIph;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FQm719pg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793203496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
	b=CFDQtIphP5shKMswdqNBhqjaLSznuJmmSkblgr+3ZQ8ay65tfzQX861avvQiH+s1hCVzu0
	OQLkFNgKvEz6KKd3RmJAdnCGhFch4aQGEfgTfQxEeHUzCLSTy1vWx07hHG74FcH+9dFyrl
	N80XnpmWKAEeAM3EFn/LFJAUSSPiRRU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-KW_GOBTLN2a_R1S-ZuIiOA-1; Wed, 28 Oct 2026 12:04:55 -0400
X-MC-Unique: KW_GOBTLN2a_R1S-ZuIiOA-1
X-Mimecast-MFC-AGG-ID: KW_GOBTLN2a_R1S-ZuIiOA_1793203494
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c4069f03949so216585966b.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793203494; x=1793808294; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=FQm719pgpZJsJPVOMbeCVPOFeqVtgdSaQLW5q4G1+LouBGH1LcY7GWMtSHET8KPc25
         Y+sb5/01dGAOR1x7QVxz2PcMbyEwhf58dTE1WstxW7n7/lQsNFXP2rM0KQuBuXewsCDp
         Qfs5nrWFKsM7mDh7N/QkijSplTTMXuOyOXfGzCNgQ4imR1o6B/JzpySRainwLccUD7Wv
         TbIFuiRDUep1SmmI+EmeTcwniOM8xSeLhWnHSp4WnttalMp22x90G5cO1Fx5csdh2bOW
         JY3W2Q+zKsxXqVSoZZ3ryIc3/YPDF8tcErp3rH5++QE7SX1gGzf5VjuQFDsiycSNkCn0
         qzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203494; x=1793808294;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2ZmH3Ff94m552shkLKSjdWayOpfJ56slpt73alq9sl8=;
        b=pLci8I85uA9OauAfWMMySeqDWM0g5Lrxr9qIG8+zHBo0Wxweq0w+ifyneZBCAFWGxF
         HhM/Bj52Ar7qmtSmuszBzUGcQHtwdaOknbuGFs3CMvA4eomgqOLgVtnP2uveqmOy7HLK
         f3pU3DHxDPO+Fs5Aa6DmhwCuyIqjGLDpYAfX5RtOMbzW82BFkrWoRI1qvWjItvPFqFVx
         heu3I6Oo/Flhac9zosStWE6RLRgvD3Lnx5vP0ceMEL4fNN58q2CB2USfWcaS+5P/6M9C
         jLNXLVed+0dF5MYj/WezXnWA07T3p34+xYr8tmaUD7veM4CEqWkbcOfsG20Y9suVetNW
         xcvg==
X-Forwarded-Encrypted: i=1; AKwUvByJNiLzXB5YkWf2lC+eMfxe1BDJeDItQ/ov1snpxGEAnjwFpst/bI+ZqETbhT4FLpHGPqg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrAeaXU4R/xH2WPV1xufzBlTIKPwkkwtUWG/7lezjGlrHEFX0q
	1HoAkYaUvGpHaEi2h+HRaqKsecssBW8NeMnuHGYXKtDG16VAeypYTitCM8xDPhKQrrs1ZRctXQR
	0yshH+Y9O6VV48R5GJp2zX6G/yNyL5GVQgoITwyZoPg0gfknDHsAHIw==
X-Gm-Gg: AYBFou0UioHqe4dVhb0A2EPO65w8Hzv9tCjTRx4AHmhUyDGGiYbHxKNe+BtxvWPIdC6
	eRjO+NCWWrh+fjApaeY6dB1ZR7uSVEKIzHpGDNBEP0qUY8PvEdqcgvhBwcSBA3IOlVmkW++M7Gl
	PrMYpdkwS9x7rXflknqvJvi1SV/75HX05cJ3x3pF5P3/3CnQDniwjugy5/74s55LCX+RrddMvd9
	sjbcVwgJZacx7rJ2UvifjStCgKNyTB9z1Olu8bxgrs6qfQ+fvn9ym694JpSNCROvkV7IarUY2/2
	ss8ikkkAMoHe06OmyRlcOSQmC/WGQGW1uXgW/BPhDrdOPJdm1FVrRbA2IMH+XtUL5TwQZaWzmpR
	zLUUAHbmSrf0ugo3k3MsvhPCny1pKsz+mdW2hroBZQ4pq0He7FYqmGSOxrqAf6JLIY0qlRdOECV
	L+REfF/a/kg1o=
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551015066b.24.1793203493719;
        Wed, 28 Oct 2026 09:04:53 -0700 (PDT)
X-Received: by 2002:a17:907:3faa:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c49a742b50cmr551001466b.24.1793203492607;
        Wed, 28 Oct 2026 09:04:52 -0700 (PDT)
Received: from [192.168.0.19] (217.red-88-4-146.dynamicip.rima-tde.net. [88.4.146.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd47basm31898410f8f.32.2026.10.28.09.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:51 -0700 (PDT)
From: Sergio Lopez <slp@redhat.com>
Subject: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
Date: Wed, 28 Oct 2026 17:04:29 +0100
Message-Id: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNz3bLi/ORs3ZT0osRc3eLSgoL8ohJdMwvjRJNUg8TUpFRzJaDOgqL
 UtMwKsKnRSkFuzkqxtbUAP47zmGoAAAA=
X-Change-ID: 20261027-vsock-dgram-support-683a4e0aebe7
To: Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, bpf@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, Sergio Lopez <slp@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196; i=slp@sinrega.org;
 h=from:subject:message-id; bh=IAsDh8eAGF2GwPL8C87LSOoOWcUAY+hEvje7pI2yfrQ=;
 b=owEBbQKS/ZANAwAKAfRpJ40vDAI1AcsmYgBq4h0ayuzqJP9Rcnuf3cdPX7iTWVlDw8ysZGp8Z
 wGNuM7AzKqJAjMEAAEKAB0WIQS+1fz3US2GgJFC6KL0aSeNLwwCNQUCauIdGgAKCRD0aSeNLwwC
 NZFHD/99IaYlGVSilyovjaYh2x2j+28+Keg9pElFi2ecT8gYqUy06MR1kFmZOrZsoqHy7pYwssH
 V4esQeAgESGZQtmvBNjEYuJ+SvP+jxLEqWzkQ7r0RzpIRxnGb+YjcYrTZu4HDNzFxBwL64Wmn02
 8ajh2a9t7wNNH/rvCNCpGt0V3zBKlQTB76xmObSCX5LfXENqL+fkV40PShUObL9gFOh6lwDQbkm
 qaHV0S7DGuhCDKFx+bOHBcI1WPuv+TVqoambXNF/El5GBreBkVoRFTzO4RaSLa2YK4yYsXjGdoN
 T4z1quggOJHvkITVGN/GItwaAFEOf6Bq8jQZ7QjAixm96Pi5OTxx/GeCmlV78mrHFPJe2gvOy/g
 WO+59N02oABNlSNaS8u+RQGwPigjgXYNDrITmaZePAtwTHi19KyDSVtI1RUhuTpM0kax/tdgUaV
 +HtPuC0HnrBXjNsU8UMvsi3soX4qOp3udDj312ClRvwBLneCo83BNxkTIImVlxCYfVCefkaaI22
 pNdV/ATqALFUZ54VVwWAVjzTvFx+1P/2plUbjAvLPEVGAWqFJGfvWF62xj2IsgkQ5AIMMZX8XBR
 /jnziV7xCe4LIWvGgd17vYzux4WMnxHqSRgiv/xLo+Ur85IEENwWIklCMJecGG/MYbEJZzl6omK
 7+lvOZABr5ugX2g==
X-Developer-Key: i=slp@sinrega.org; a=openpgp;
 fpr=BED5FCF7512D86809142E8A2F469278D2F0C0235

This series implements SOCK_DGRAM support for virtio-vsock and
vhost-vsock, allowing applications to exchange connectionless messages
through the existing AF_VSOCK datagram API.

Support is negotiated through VIRTIO_VSOCK_F_DGRAM. Each datagram uses
a single VIRTIO_VSOCK_TYPE_DGRAM packet, supporting payloads from zero
bytes through 64 KiB. Pending sends are bounded by the socket send
buffer rather than peer credits, with queue accounting and poll
readiness reflecting pending output.

Datagrams use destination-based routing across guest-to-host,
host-to-guest and loopback transports while retaining the socket's
transport state. VMCI keeps priority as the dedicated datagram
transport.  Guest RX buffers accommodate complete messages when
datagrams are negotiated, preserving message boundaries.

The patches first expose the core port allocator and add datagram
queue reporting, then implement the common data path, guest and host
feature negotiation, directional routing and RX buffer handling. The
final patch extends vsock_test with local and host/guest datagram
coverage, including peer filtering, route changes, message boundaries
and queue ioctls.  Unsupported cases skip automatically.

Tested using QEMU with a patch that exposed the VIRTIO_VSOCK_F_DGRAM
feature:

https://lists.gnu.org/archive/html/qemu-devel/2026-10/msg08074.html

Code was written and reviewed both manually and assisted by Codex
(GPT-6.1-Sol) and Claude (Opus 4.6).

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
Sergio Lopez (8):
      vsock: expose the core port allocator to transports
      vsock: report datagram receive and send queue state
      vsock/virtio: implement the datagram data path
      vsock/virtio: negotiate datagram support on the guest
      vhost/vsock: negotiate datagram support with guests
      vsock: allow datagrams to use directional transports
      vsock: preserve host-to-guest datagram boundaries
      vsock: add datagram tests to vsock_test

 drivers/vhost/vsock.c                   |  37 +-
 include/linux/virtio_vsock.h            |   6 +
 include/net/af_vsock.h                  |  14 +-
 include/uapi/linux/virtio_vsock.h       |   2 +
 net/vmw_vsock/af_vsock.c                | 206 ++++++--
 net/vmw_vsock/hyperv_transport.c        |   4 +
 net/vmw_vsock/virtio_transport.c        |  71 ++-
 net/vmw_vsock/virtio_transport_common.c | 197 +++++++-
 net/vmw_vsock/vmci_transport.c          |  10 +
 net/vmw_vsock/vsock_bpf.c               |   3 +-
 net/vmw_vsock/vsock_loopback.c          |   1 +
 tools/testing/vsock/Makefile            |   3 +-
 tools/testing/vsock/README              |  23 +-
 tools/testing/vsock/util.c              |  62 +--
 tools/testing/vsock/util.h              |  10 +
 tools/testing/vsock/vsock_test.c        | 154 +++++-
 tools/testing/vsock/vsock_test_dgram.c  | 809 ++++++++++++++++++++++++++++++++
 tools/testing/vsock/vsock_test_dgram.h  |  26 +
 18 files changed, 1545 insertions(+), 93 deletions(-)
---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261027-vsock-dgram-support-683a4e0aebe7

Best regards,
-- 
Sergio Lopez <slp@sinrega.org>

