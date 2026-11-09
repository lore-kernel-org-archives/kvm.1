Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250758;
	b=ZQIdc2xG2NCbgPUi3HoA+ChUwSnfHPhYy2CrpxkVzaW/4xv6HGC+kE06T/aKy461I0BJ
	 vTIGaCPcNWQD/sH+JLz3Fwmz4sw2kS2+pZjei8o4PwfdY8TPd0pbYm0spZhSqWvMsxa3J
	 yDcFFG7vklNqMRkYXWjn493GSAr61uYtUc+gMC3Vnqp0HzFEnGoOwCk6El5iUIFJ1jzRd
	 MWys/3jYh28nOGdF4bYrPxLnQv/b1pDMJvc9FyTE11FJYylhCL6ISR+okxCV+zuL9/jP1
	 tTz9DMQc5R67gY/MoMkjqswc3nrYTLPN7Aj0dO5rD5iFLgGjs0sqkA6WyUWU1+RXfcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250758;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=vEkUBviGIGN/LAuBviM/0RLn9PfC+r83xbG4+hZ8/Kc=;
	b=3YV/TcXZ0iPOXaC1uJhjscZPvexAtjF6AiX/4lOanEp3FyIpcWE5sxnc1Vudm0tIFCeJ
	 TcXN4xYNnucQjBv8/7Rm7Dq90tzGpAZOv3r8mFtAuHI+XXt3LqwpN05Q7lkHKGsjHW49w
	 82B3W/kC90HSi0c6PdLVmZUgEe0vNmllj+0OOwsnfNK3F1N+eQP/SyFSmiXLvGmSwMdG3
	 Pj14p9733mhYhc6vxkaFXK7GI8u9LvrkfCwbCJT3ACQPQa1ISwXFKWWpa8+zuTdBIkIpC
	 /FMkTBuw+qMU4fDCLOiTyUjmV5E7vW0582sT5WXLSOFtf3Hka4+h2pWbGCMfHuVlLDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hXVZbbYA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E07606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 18:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28E07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hXVZbbYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794250757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vEkUBviGIGN/LAuBviM/0RLn9PfC+r83xbG4+hZ8/Kc=;
	b=hXVZbbYAZL98Odp3Q85rrHGPfJKpTUnbjVU1AqyKrKjMbkYcNkdWNpr159HX1O5JZnskqv
	TpgpC3MK3VozkBJ1ZqBpVaWixPcucAoAk3uCN4ZkFCnN4nPRRPS36DZ9i2grvus0qSrODo
	KAF9UI7YxrvcUEHHcOrwle+MMVUgWSA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-CYWXylg7PN24OdqWNEGEtw-1; Mon,
 09 Nov 2026 13:59:15 -0500
X-MC-Unique: CYWXylg7PN24OdqWNEGEtw-1
X-Mimecast-MFC-AGG-ID: CYWXylg7PN24OdqWNEGEtw_1794250754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C02C51955EB1;
	Mon,  9 Nov 2026 18:59:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E0131956087;
	Mon,  9 Nov 2026 18:59:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alistair Francis <alistair.francis@wdc.com>,
	Stefan Weil <sw@weilnetz.de>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 0/7] debug: add PR_SET_VMA_ANON_NAME support
Date: Mon,  9 Nov 2026 13:59:00 -0500
Message-ID: <20261109185907.3220584-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add PR_SET_VMA_ANON_NAME support to name mmap'd regions of=0D
memory. This is only supported on Linux >=3D 5.17, but allows QEMU to=0D
communicate names for each VMA segment to linux, where they are=0D
visible in /proc/$pid/[s]maps and utilities like pmap.=0D
=0D
John Snow (7):=0D
  debug/mem: add utility to name anonymous memory mappings=0D
  debug/mem: add tracing to qemu_vname_vma()=0D
  debug/mem: name <reserved> regions in mmap-alloc=0D
  debug/mem: name pthreads=0D
  debug/mem: name coroutine stacks=0D
  debug/mem: name qemu_anon_ram_alloc/qemu_ram_mmap pages=0D
  debug/mem: HACK add qemu_name_buffer=0D
=0D
 meson.build                |  8 ++++=0D
 include/qemu/bitmap.h      |  6 +++=0D
 include/qemu/mmap-alloc.h  |  3 +-=0D
 include/qemu/mmap-vma.h    | 21 +++++++++=0D
 include/qemu/osdep.h       |  2 +-=0D
 hw/core/loader.c           |  3 ++=0D
 hw/display/virtio-gpu-gl.c |  2 +-=0D
 hw/i386/x86-common.c       |  3 ++=0D
 migration/ram.c            |  3 +-=0D
 system/device_tree.c       |  2 +=0D
 system/physmem.c           | 15 ++++--=0D
 target/i386/kvm/tdx.c      |  3 +-=0D
 util/mmap-alloc.c          | 17 +++++--=0D
 util/mmap-vma.c            | 94 ++++++++++++++++++++++++++++++++++++++=0D
 util/oslib-posix.c         |  7 ++-=0D
 util/oslib-win32.c         |  2 +-=0D
 util/qemu-thread-posix.c   | 34 ++++++++++++++=0D
 util/meson.build           |  1 +=0D
 util/trace-events          |  3 ++=0D
 19 files changed, 213 insertions(+), 16 deletions(-)=0D
 create mode 100644 include/qemu/mmap-vma.h=0D
 create mode 100644 util/mmap-vma.c=0D
=0D
-- =0D
2.56.0=0D
=0D

