Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847816;
	b=UFsXpjcprbwbD66FAw2UrBXa56ciTC9xlEuKCTvdRT8VQTWM+faYGFEyyynnm7I5tw2U
	 djMBJJXd/YhzvvX7RnAvJfzNPRXOHP0uD/3l4SJW6AuXP3WOFRaiHstMAZA6j/JuY4lTa
	 i+aUyxn33gDd5Quluj3g0mLuI2pXirycCcZpj/qAiGHahD7/nA+t4I9cBFNu58K2CMVL9
	 3NadBEz7fchf8IILTCUREwhZriOo7F5MJWg+ZdGi/EXf4S9cuKQWiqTGs0LTR4iyXHPjt
	 PgQX04C/isaTjiZY/UWcDpzLwTvTpAQgCAcqsv5EHyl9+JV7cEY0nRnSNrswYlYIxUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847816;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By;
	bh=0H7h3dD+FYCquqmvRELFnnaLqe/RA8GxwPB3bX0pxX4=;
	b=MTNts1Tu67GgPawiPYYby9aRGKnqHdyTWuGMGxrldRQE2jm+39Wfjqf+7bZuZx2wtooY
	 01TGH9SN9OTsb8ETQkA/4eIfH1lTsNKbPiI0wr6ZqDODkdM7msl47Ly7naBGNveXYwApz
	 h8DyVzbD5cYl6x+BiPNcVdcowq3hUXfbvOxxhogqVe4EkDwNNiT2DXwn+UtNdrVOp1ffD
	 uLB60DciEzCdermGfBtAHiiGhgKW11PVm99ExUr1mIsmtf0x6xx7l05Kl5Su9GoqcAvvL
	 1M4BXmykGLjdHg9HCc3sLXyS1cszlo4m5VwfU/hLxEc9rgaQ88uW1o1fmz7kBMmqXSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVCjFs3v;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB822606A31C
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 16:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB822606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fVCjFs3v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794847814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0H7h3dD+FYCquqmvRELFnnaLqe/RA8GxwPB3bX0pxX4=;
	b=fVCjFs3vnZyNEi7n7ItZ0OV1whKEpQ9cMPc/ouMUCvBKQbij1Gm9JWxE6HCG2Sz2VeK9ae
	ueVp5we1n5mUiGsk4o0A8kUXmxs1fW6U3RxAMrl4pOfMs1lcd8iXwtaZ+hhMcO8sOddi1U
	qm8Rv7k48sOgxfrUC6hJJyaFvq2PpVs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-XqLVgs7aMNG8__016epJAA-1; Mon,
 16 Nov 2026 11:50:11 -0500
X-MC-Unique: XqLVgs7aMNG8__016epJAA-1
X-Mimecast-MFC-AGG-ID: XqLVgs7aMNG8__016epJAA_1794847809
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CA2019560A2;
	Mon, 16 Nov 2026 16:50:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E593195B3C8;
	Mon, 16 Nov 2026 16:50:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	kvm@vger.kernel.org,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Fabiano Rosas <farosas@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Stefan Weil <sw@weilnetz.de>,
	Peter Xu <peterx@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH v2 0/7] debug: add PR_SET_VMA_ANON_NAME support
Date: Mon, 16 Nov 2026 11:49:55 -0500
Message-ID: <20261116165002.30939-1-jsnow@redhat.com>
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
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add PR_SET_VMA_ANON_NAME support to name mmap'd regions of=0D
memory. This is only supported on Linux >=3D 5.17, but allows QEMU to=0D
communicate names for each VMA segment to linux, where they are=0D
visible in /proc/$pid/[s]maps and utilities like pmap.=0D
=0D
v2:=0D
 - add va_end()=0D
 - fix commit message on 1/7=0D
 - remove redundant call in 4/7=0D
 - remove RFC comment in 5/7=0D
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
 include/qemu/mmap-vma.h    | 21 ++++++++=0D
 include/qemu/osdep.h       |  2 +-=0D
 hw/core/loader.c           |  3 ++=0D
 hw/display/virtio-gpu-gl.c |  2 +-=0D
 hw/i386/x86-common.c       |  3 ++=0D
 migration/ram.c            |  3 +-=0D
 system/device_tree.c       |  2 +=0D
 system/physmem.c           | 15 ++++--=0D
 target/i386/kvm/tdx.c      |  3 +-=0D
 util/mmap-alloc.c          | 17 +++++--=0D
 util/mmap-vma.c            | 98 ++++++++++++++++++++++++++++++++++++++=0D
 util/oslib-posix.c         |  7 ++-=0D
 util/oslib-win32.c         |  2 +-=0D
 util/qemu-thread-posix.c   | 30 ++++++++++++=0D
 util/meson.build           |  1 +=0D
 util/trace-events          |  3 ++=0D
 19 files changed, 213 insertions(+), 16 deletions(-)=0D
 create mode 100644 include/qemu/mmap-vma.h=0D
 create mode 100644 util/mmap-vma.c=0D
=0D
-- =0D
2.56.1=0D
=0D

