Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073B22173D
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619061; cv=none; b=WLHKWwdbT0ECnHW9nt8T0Hps61vmEDBhvIedlitLBvqTgjaECRQiAxDyVPIISKCD6iHpm+UrJxBhqfLv+i/UA8rOM2BiVy56fEPdq305vyGXpBNoWnh78svht73Rkri9L+gK+/6F83fEH8MlIpx6KN9PprhGYFumikoF+8PUYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619061; c=relaxed/simple;
	bh=KVfKqju3fWJ4QnHhgMWBtnmH5PrPvAK3hvaGfeBt9lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CLgJUxFNRNcWAdWjuewPMzTNaB2eI7kMnDzMxAcvyVmC3qNIEM23NV5pHDKfQoFFXWpIckQh01ol0IotlKlaB6iH6ZfEcYWk5QIGgag4BhZJqBob8IGmdHsPApzFVF203VAISfpWH+yrCDv4Nc8cP0TkDTljQOzkEb+kppAlH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Prtdqtal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Prtdqtal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774619059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XAV0D7HY/jIQN3ktUQpKSm/qYS5OD62NK49YaY8qs5w=;
	b=PrtdqtalObPfjXusX9xl6fy9mfzUPoIfYRNJNRPkVDmryaCirMfXAbm/o6m4g8bUswpFm1
	B/zY/XEU3Az1DURB377RnqmV7OBSbvUnHEfO179UJHnCJCjgGzHxXFDZ3VfhBeDHlN8D0s
	3djMsievNn6iVJVQSODXSKHz6d7pK6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-l3b1Ow2dOZSVVCQGMlUYow-1; Fri,
 27 Mar 2026 09:44:15 -0400
X-MC-Unique: l3b1Ow2dOZSVVCQGMlUYow-1
X-Mimecast-MFC-AGG-ID: l3b1Ow2dOZSVVCQGMlUYow_1774619053
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 082B0195608E;
	Fri, 27 Mar 2026 13:44:12 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D6521800671;
	Fri, 27 Mar 2026 13:44:04 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org,
	kvm@vger.kernel.org,
	qemu-riscv@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Peter Maydell <peter.maydell@linaro.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 00/15] Misc changes to allow building with Windows Clang
Date: Fri, 27 Mar 2026 15:43:46 +0200
Message-ID: <20260327134401.270186-1-kkostiuk@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

v2 -> v1:
 - Added additional commits to remove strcasecmp/strncasecmp usage in
   favor of g_ascii_strcasecmp/g_ascii_strncasecmp
 - Don't remove dirent.h from util/drm.c since it's used there
 - Updated commit messages with more explanation

v1: https://patchew.org/QEMU/20260326160033.68318-1-kkostiuk@redhat.com/

Kostiantyn Kostiuk (14):
  meson: Use stddef.h instead of unistd.h
  qom: Use g_ascii_strcasecmp instead of strcasecmp
  block: Use glib2 instead of strcasecmp/strncasecmp
  io: Use glib2 instead of strcasecmp/strncasecmp
  hw/arm: Use glib2 instead of strcasecmp/strncasecmp
  target/sparc: Use glib2 instead of strcasecmp/strncasecmp
  target/riscv: Use glib2 instead of strcasecmp/strncasecmp
  target/ppc: Use glib2 instead of strcasecmp/strncasecmp
  target/xtensa: Use glib2 instead of strcasecmp/strncasecmp
  hw/ppc: Use glib2 instead of strcasecmp/strncasecmp
  osdep: Remove unused strings.h
  util: Remove unused dirent.h
  util: Remove unused sys/param.h
  meson: Don't require nm for non-modular builds

Paolo Bonzini (1):
  storage-daemon: use same link arguments as other tools

 block/curl.c               |  4 ++--
 hw/arm/xilinx_zynq.c       |  8 ++++----
 hw/ppc/spapr_caps.c        |  2 +-
 include/qemu/osdep.h       |  1 -
 io/channel-websock.c       |  4 ++--
 meson.build                | 35 +++++++++++++++++++----------------
 qom/object.c               |  4 ++--
 storage-daemon/meson.build | 16 ++++++++--------
 target/ppc/kvm.c           |  2 +-
 target/riscv/monitor.c     |  4 ++--
 target/sparc/cpu.c         |  8 ++++----
 target/xtensa/xtensa-isa.c |  4 ++--
 util/path.c                |  2 --
 13 files changed, 47 insertions(+), 47 deletions(-)

--
2.52.0

