Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A69C3AD50B
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148922; cv=none; b=dtVKrXs1mt4R02Ewex88o/BLvaxgn7rcUXqMqYRpK+zigCGEDGVOJQPoYCA38e46r5EqvyvI+L3ItkiR1p52gISdt4PZnwWFxxputVI+C/1055VyAHxaUylBoFtbYkEIMW9cbPSXkPxanDw/1rwU9WA2ceDQpykVL1ioI71A5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148922; c=relaxed/simple;
	bh=+yBCwEuTvh35Qxah/TMEjeYvqKjHdbPLwCvuf1d16hg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=k/BA6q/wWbsiQ+UCazLBLmETzydA5xJGq05V8f/SD/ebpnl55dlDbxA9dsESZZTYSmCQDG6FnkUPk0o+CitALnlwSzY0/HZLZ9G///tVRkRTr1yY3lWsit0nNgg3MbtogUl4yUt8VXEwAXH5JqlW/9X9+XoqUUh/gT9jGjLOlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ittEIpdg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ittEIpdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773148920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LN/hDjBsAiB7kLgPSxgvMZ8NlpqRLqqNGXkxBBcxVt0=;
	b=ittEIpdgglAaT19HQAiCQzVg0AP4cd2S7scOTJMVeFVYh5DnANx1+Akkr64+GHmMlKLM5v
	1v9o59rRlSE5fohvhg7iwYZOcH+bhYKbOD7CFY6NS2m4Lg5L5eqY1ITuuqU4mrNVtDSu8N
	aVJy26z3RpvqjqLZyCmJ3xhL6j49u/U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-qT8FwWBhONmrWnmDz2Uf5Q-1; Tue,
 10 Mar 2026 09:21:58 -0400
X-MC-Unique: qT8FwWBhONmrWnmDz2Uf5Q-1
X-Mimecast-MFC-AGG-ID: qT8FwWBhONmrWnmDz2Uf5Q_1773148917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91A1419560AE;
	Tue, 10 Mar 2026 13:21:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.225.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F7203000223;
	Tue, 10 Mar 2026 13:21:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id CBAA518003BD; Tue, 10 Mar 2026 14:21:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Kashyap Chamarthy <kchamart@redhat.com>
Subject: [PULL 0/3] Firmware 20260310 patches
Date: Tue, 10 Mar 2026 14:21:51 +0100
Message-ID: <20260310132154.2783257-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:

  Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260310-pull-request

for you to fetch changes up to 470ccb470b33bedede0100fdb703228a3f2683a5:

  i386/sev/igvm: do not reset guest policy if IGVM does not set it (2026-03-10 14:20:41 +0100)

----------------------------------------------------------------
- firmware.json spec update for svsm.
- igvm bugfixes.

----------------------------------------------------------------

Ani Sinha (1):
  i386/sev/igvm: do not reset guest policy if IGVM does not set it

Luigi Leonardi (1):
  igvm: fix build when igvm is not installed in a well known path

Oliver Steffen (1):
  docs/interop: Add AMD SEV-SNP SVSM interface to firmware.json

 include/qemu/typedefs.h        |  1 +
 include/system/igvm-internal.h |  9 ++-------
 include/system/igvm.h          |  5 +++++
 stubs/igvm.c                   |  1 -
 target/i386/sev.c              | 12 ++++++++++--
 docs/interop/firmware.json     |  4 +++-
 6 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.53.0

