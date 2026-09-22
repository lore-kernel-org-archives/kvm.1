Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED636A03F
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 01:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039901; cv=none; b=jOnI7/bl+6ZG1hB65yw5d/Q3eJQpFNjT98R1DfYb8OMr7CHg+JkwVe47ImRdLLnKr3OIU8TV7whkyI87nj73FerIbP2nT09hUxVVLhFKPu9I4JEWiTl1YqWg5HjfmtAU3FUSndGl5rVZUy1qDWOYQ9G5evJfNraQR5fkbnY0aSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039901; c=relaxed/simple;
	bh=Acv7MgHBh1jAwi3D+fsQ8X/DzGRU/jGDl+ydMkOn+HM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WKjSrizRC9a+H/qC40XzW/IV2whHObuLZpf2Ou/xtGlBLW/VVGgTfMde9BfbR17teZoK/osdZEzg7JC1poydessvjhHLQPGmZkGUqmVow9mhlqtbQ8esLFxZQeZcMGhH1gqUGIQ6p6Np3U1k074p7kh9u2/ikYxkTRarMjb6g/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuxwre/6; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuxwre/6"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6b1ae6a9960so2598303eaf.0
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790039898; x=1790644698; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nc+AzR6lB3hdwq2cJ+qgIdPQ8/tOa9E8y0imH8XTesg=;
        b=kuxwre/6JCi3a99wDJx6nPkm2c0DntMKfDJ23Xd04QXsrvUU+PcRVTbwkASbCxAZW9
         A5MBT37vz/rmONfovmbIq38oCug4mfZh9efOsIfySu8HZ7w6QZY1eSTgxm1Ch92amJ7x
         CHviWr/dw8NjXIxWS6XcdZd4Of6gcj2E7fwXxuTTxWOtLi/0lDBPZRkpdoxo8TjVKpoM
         qScCTZAeTy6O9+jJDqsBy8niVTdHQ8UeF226L9TR1ZxlNdp1oNP3S1tzceoSnJ7+Bslt
         bL4CbWmtfwnF3Rjq9UyQKVFzW9cbBVqKfiBHHl1Jkl3jFfx96ACv90xP82Crmv7aTgMv
         Am7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790039898; x=1790644698;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nc+AzR6lB3hdwq2cJ+qgIdPQ8/tOa9E8y0imH8XTesg=;
        b=VarwXR+/ke5AcVPJIkmqDmzrhrB8a0A2Jt+V0wmVyjFggvXPoH5lsJWhW09xuYZH5k
         zfdoubKnWRLCTdEViiGbS5viLz/xBM88pWwk+tnhUKAubdNsuxzzRhZIliylqZBXyL95
         wwwznhsTMwONnqLsWdTWjuxxJ6jHAsCxF7oGcM/3S6kfRMH76UFxTR46kP1/clQKBB8o
         2pdv/5oY+AiOjWHEp+os2fAI2ks5zPOvwQWlj/7T1o0Bi0hUae44tS56glDHs2cYrZ7o
         cHz8o4ZRyab0ymMVvLk1ezw3a5OtA2klHIf5/NBwcgnriBtUdreUrCC9jed4qA8MEBvM
         Nmwg==
X-Forwarded-Encrypted: i=1; AKwUvByWJ0Vj/RDlPC3unwVu+P8JE2xGynNgaxQ8JZX26jRiKYkxVqeOwhE5rC6/4qvnk1D+TxE=@vger.kernel.org
X-Gm-Message-State: AFuF++l8JXJ5pwgfXUnKeo7d98gH4OKolpgq5DvOBNs+jK5dSVVT8PLH
	ezbk4Jg8jW5AB3ll2QJIcb8CW7/jAvtViBBtzFQ/wy1SJlyPH/UYZwGc
X-Gm-Gg: AYBFou3u4k2BWQgB1D3UYPwX4L2OZFpvtM5zfAl5YWSCr4srsWWTVjHACbF6fkJR6jf
	P7SOMzuPrxt2yq6xW0VQ2TKWilNKOmCpF/ZUaY7GsVTGB+F9Ojc/dT1tnvq9LZumtNKxxhWf372
	YqCexpSyNJ4c1WJBLsKqfZLe2TmGVPJ9BAscLrnyyhPLBAuwqqpO4sriqE3c9Qdm/2cOYu8GN47
	JhkgchwcQ/FMrYv7SwRQOqv6nFNfFWIN8qbr1m079jHG7t+Sc+m99X21mPQfeQTwZEEqsh4wiAW
	hLYGo96bE7m0hHuLwL3HSXvKaNaCHuYdtxpyQ7ctnIOYG4C/tgaOKA1iz3ngTTFrXQJH5JalzMq
	SuoL4engj1V4zgDls91a4OfIPzcQylFWZCVMIfz46gBPIZYabBp5dxEKRDq4qqXAus5WoB2Yla5
	HXGTvtmCc7orRhCfCz6jwb+IrEM707deN1U+KM3sObRLexGRcpvC4N6+Tyxdyolztu38A=
X-Received: by 2002:a05:6820:61b:b0:6b7:83c5:fe00 with SMTP id 006d021491bc7-6ca9d147147mr11628526eaf.65.1790039897801;
        Mon, 21 Sep 2026 18:18:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d1dbd52475sm117155eaf.1.2026.09.21.18.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:18:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v2 0/6] vsock: assign the guest vsock device to a
 network namespace
Date: Mon, 21 Sep 2026 18:18:03 -0700
Message-Id: <20260921-vsock-guest-ns-v2-0-693bd78fde9e@meta.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEzXsWoC/13NQQqDMBBA0auEWTslidUaV71HcZHqqKGYlEwaL
 OLdC1l2/eH9A5iiI4ZeHBApO3bBQy90JWBcrV8I3QS9AC11K7taYeYwvnD5ECf0jJNs7Xxt1GT
 bG1QC3pFmtxfwAZ4SetoTDJWA1XEK8VtOWZVeUCP1P5oVSjTGNHVXk7Hd875RspcxbDCc5/kDv
 f1HJLUAAAA=
X-Change-ID: 20260831-vsock-guest-ns-d06af451da67
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, sargun@sargun.me, 
 jlinbox@meta.com, Stanislav Fomichev <sdf.kernel@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

vsock network namespaces let a host put each VM in a namespace of its
own. A guest has no equivalent yet. It has a single G2H device that
cannot be assigned to a network namespace.

This series lets a guest move that device into a network namespace. A
new generic netlink family, "vsock", supports the command
VSOCK_CMD_DEV_NETNS_SET which assigns the device to the namespace the
request was sent from. The namespace's existing ns_mode then decides who
may use it: a "global" namespace shares the device with every other
global namespace, and a "local" namespace keeps the host connection to
itself. The device starts out in the initial namespace, so until the
command is issued nothing has moved and no mode has changed. There is no
explicit unassign as assigning the device back to the initial namespace
is equivalent.

The command requires CAP_NET_ADMIN in the initial user namespace, so
that an unprivileged user namespace cannot claim the device.

Connections that can no longer reach the device after a move are reset,
so that a namespace which has lost access cannot keep using a socket it
opened while it still had access. Following netdevs, the device returns
to the initial namespace when the namespace it was moved to is deleted.

Transports opt in through a new netns_assign_allow flag. Only
virtio-vsock sets it here, because it is the only guest transport
that I am able to test against.

Based off of Stefano's original series:
https://lore.kernel.org/all/20200116172428.311437-1-sgarzare@redhat.com/

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/all/20200427142518.uwssa6dtasrp3bfc@steredhat/

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- Replace the IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS ioctl with the "vsock"
  genl family and VSOCK_CMD_DEV_NETNS_SET
- RST the peer from the reset sweep, v1 only set TCP_CLOSE locally, so
  the peer waited on a connection the guest had abandoned (Stefano)
- Drop the vsock_assign_g2h_netns helper patch, the tests use ynl cli.py
- Note why only virtio-vsock opts in (Stefano)
- Add a getter to the uAPI
- Various fixes (see individual patch change list for more details)
- Link to v1: https://lore.kernel.org/r/20260902-vsock-guest-ns-v1-0-9995383e9a8b@meta.com

---
Bobby Eshleman (6):
      vsock: constify the transport in vsock_for_each_connected_socket()
      vsock: rename the vsock pernet operations
      vsock: add a netlink command to assign the g2h device to a netns
      vsock/virtio: support guest device network namespace
      selftests/vsock: test the guest vsock device network namespace
      selftests/vsock: test the netns assign privilege checks

 Documentation/admin-guide/sysctl/net.rst |  23 ++
 Documentation/netlink/specs/vsock.yaml   |  68 +++++
 MAINTAINERS                              |   2 +
 drivers/vhost/vsock.c                    |   6 +-
 include/linux/virtio_vsock.h             |   3 +
 include/net/af_vsock.h                   |  19 +-
 include/uapi/linux/vsock.h               |  28 ++
 net/vmw_vsock/Makefile                   |   2 +-
 net/vmw_vsock/af_vsock.c                 | 374 ++++++++++++++++++++++--
 net/vmw_vsock/virtio_transport.c         |  24 +-
 net/vmw_vsock/virtio_transport_common.c  |  27 +-
 net/vmw_vsock/vsock_nl_gen.c             |  36 +++
 net/vmw_vsock/vsock_nl_gen.h             |  20 ++
 tools/net/ynl/Makefile.deps              |   1 +
 tools/testing/selftests/vsock/config     |   1 +
 tools/testing/selftests/vsock/vmtest.sh  | 473 ++++++++++++++++++++++++++++++-
 16 files changed, 1060 insertions(+), 47 deletions(-)
---
base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
change-id: 20260831-vsock-guest-ns-d06af451da67

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>

