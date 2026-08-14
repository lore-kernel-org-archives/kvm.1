Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA15412261
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692556; cv=none; b=HE6t8cmn0k1y8y/FzlXuDdQwsR2NqeCEbhTaEG1V0puGk0Bmkd5D/QJsp4d0PbptYuKedf66jD/qHZ8qd13bwvuQq3x/K9QVxF71AGYXe36BhpOXJThastiNfrhmPECkDJ/PYMF0ZC9iRtM1pyNT23ObawYL+kceicnhsWQzTQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692556; c=relaxed/simple;
	bh=AwI8bMlXLv3wxhinvie/tZxTYnyJT1R3jenyE5i/EFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tocLK9NmTMD59iqVwUZ0nZi2mJksjajmtURPbg2KZs88Tsh6bx/NtS/vbogKUknPVCarFKlu7k9sFPdu6mpdQdbzvWyviI/xkoHhpkzSC/0K6nahA+c53JezxAEjdKpm5BMbr0238MvfCARLjaBMQcL/zeaoP5fIeElZmO+pMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aosRokne; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aosRokne"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e347638adso834738a91.0
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786692550; x=1787297350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQpd4eRSV0dJsL+ykEn9cs9mcA6G8jtpyBsR3LcTcRs=;
        b=aosRokneBbLDZJaXTppHRL0W8ZAlRnBTofddC6iOTonlImsLKtve5NZkxXmztKSvQg
         Fan4sEi4BBSoWE4RwccLcvFhnbuq9wFvxYuKhUDadqRcvuagZw/q6sajePO+YU96aOR1
         VLQ8cPqirSocsBQw5j/dJjbIopCKJzTc9SG02Ftz3UpT11Ldkz+NriGo95QfzrCZABbk
         MQ1P5qNu1TbYQCNj6qy5WmsdIWAS4r6DeDAdcpb+4R4G880iBH7DEVnfuimMadjnyOog
         Kd3bFHGxhC3mA9z8sx/I3YTCSO2QqlpldmOM3VGnbOSce4vZAgCWPv69z8+3gO+gKfbS
         ZT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692550; x=1787297350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQpd4eRSV0dJsL+ykEn9cs9mcA6G8jtpyBsR3LcTcRs=;
        b=gKG7vZtG2oe0pJ6MnD+4TFzHGqixFdsdI8iztkM0YfEmTJZsy0PDnJw0E1m783x27Q
         0Nw/xI9N2nhABsydJqfdsPWzaELkxAUhWf/ZMSGoAhLOBP/yg7YhmOJr4kAHQFuyBGhk
         MhBZMjbQZCWyrKPOI8xwo0BjNHqRjyh2w3uhVe/EBXV7KicmSAfMhX/wktlJi9cRIGLR
         JzAG/aRH0OwlyoQQ9R91cUcjIAIfj1qZPomZVpTLyVxzbrjD2sCWAMdiYyepwKoOcW69
         7xBFmVuj8brb9aed2v24j9eD31fA/n1u9pX+gg6QxBdDk8Q0+QcaGsLON0tAIzGwXi6D
         mVhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoJEAzB5XuUC2jbJGcASe20hw6vsng5c/yd88vieEty2oUC1EzteYAt8nBstODzbS7gU24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw16wUAPBN1RfiueN6i1ygAkD0TfHYKfPF45LTASm/SuDWHr755
	l5HwoNf6ARCKbP6R8aFYaf7o69bh01RfqhHmE31/OTAqcc2wKOy4Gh8d
X-Gm-Gg: AR+sD11bJch054cgVb/NjVGUS/onBommxSpNszvx1zyXxOn3ZDCaIRAm+ZVRLQ2iPb+
	MnuJXfZ0yuUtp/vln1ealrWxh//zl0XBr5qJnePaDN4O2XwPvxoCWEK7MEkk/M/w7J4/MH8aQYH
	zlUwgUEv5hq4ZjcVNGAwm8SsZMH4LRDDABqWUaAVYgkBaNMZavCp+lUJec0IadBZrQMdqxqI4hE
	pcAO0vbtq0m9EUfZpnPE8qOw/HHEfIQbXiw6LBA4pJHWnUQPOpHijWWrG3ertdWseZFWGSji6JX
	0cdIMM2V/FpeaIbRrIFvU0muqpfUVhsqueZvXBGBdroj9evkPFW13Ln9JHqkGyDHcKgmJ+nLspF
	UXOgVTlqAes+M8xTJVIUleDoJU3q8TWtR8nNU6+iOYGckeUb8i2lGzb/zzjzIuL+4E6TVOL0o3L
	HQtx3GuAL8mgeKhcERvDXw0jUxrgj9EvgpsYKQI7DSKJBbHs9WTBZqW95mGKLb3+mG8iiWKGr2T
	6w=
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3933b6e9788mr4544657a91.2.1786692550314;
        Fri, 14 Aug 2026 00:29:10 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb752fd7sm1483477a91.13.2026.08.14.00.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:29:09 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] vhost/vsock: fix device IOTLB feature lifecycle
Date: Fri, 14 Aug 2026 15:29:00 +0800
Message-Id: <20260814072903.124991-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-vsock leaves the device IOTLB attached when userspace clears
VIRTIO_F_ACCESS_PLATFORM. It also replaces an existing IOTLB with an
empty one whenever a later feature update keeps ACCESS_PLATFORM enabled.

Patch 1 adds a common vhost helper that detaches the device IOTLB from
all virtqueues, clears their metadata caches, drops queued IOTLB miss
messages, and frees the old table after all virtqueues have released
their pointers.

Patch 2 uses the helper when vhost-vsock clears ACCESS_PLATFORM. The
acked_features update remains in the vhost-vsock-specific loop.

Patch 3 avoids replacing an existing IOTLB when ACCESS_PLATFORM remains
enabled across a feature update.

Changes since v3:
- move the IOTLB teardown helper from vhost-vsock into common vhost code
- keep acked_features updates in the backend-specific loop
- add the common helper as a separate first patch

Jia Jia (3):
  vhost: add helper to clear device IOTLB
  vhost/vsock: discard IOTLB when ACCESS_PLATFORM is cleared
  vhost/vsock: keep IOTLB across feature updates

 drivers/vhost/vhost.c | 24 ++++++++++++++++++++++++
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  7 ++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.34.1
