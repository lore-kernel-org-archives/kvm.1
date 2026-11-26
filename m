Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689013;
	b=mGlctIeXnMNvx21jDYCAGLkVdCM0Y0EJBFR44XWmJgiiAwshSaPITG/0ZS57w4B8qOKl
	 Xy2ocrpwWtiFlNxd2l4oxGwqOqPLNkecvx9vMFEmn0m77JW+jJUeFNd+m8mKjlNavhY4u
	 Pc3kPcf9GhB79lQ5GNbqqTpC/lTyWzIslgzso8nnzp1lD0K7YljlyNGcbiH7hUv+kLADz
	 hhoVOJFP4XgdD/CllpHii+NK2wv2BLdbkZzj0m6LvqXPwllLlcjjl2f/e+91AwX+l+9pl
	 7PVJAD66qpog22v+CtdC2vyY0hvcufZXz78EjLKRgYqzdgGtGGq9mTxyGGI13F6uzpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689013;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=Mazobz9xvO9xEkTL+yLqiw6ncyyEsYK7gBPAnSMpD9c=;
	b=EU5oQaWa3/zvNzILFXRIZHvrW/kHbKzBp3cIFfXEkCoaImNrVN3999G+jVcRYIez2bTR
	 fKxPucybCtFCZp7y1GJ9wRNztab4sEAjquTicdzLkPAnt/o+UOXocSMXYII/xSg99rSTz
	 XS3hmaIAOE4osqCN7Q0aPTUlVFAxfjY66s+eaNrUcUM818pVQbk2s2ytvwrxY/y4rpi0i
	 U3v0/uccRkyvItqHX1pQXC1mkpzQ0tLvX8Pix3ykShWLhrDTr2VPv3KzAu8TmLz7OA89v
	 ahspjbWdQ+wA48UhFpXD3d0roT1BME/uM2IZwCaOzPq9GJeDSxc8bcmciAIUWpLMx/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcUVkIxw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3F7606A6B7
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A3F7606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcUVkIxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mazobz9xvO9xEkTL+yLqiw6ncyyEsYK7gBPAnSMpD9c=;
	b=hcUVkIxwr1hU8vEfxIfKTOQtl2NySxBC0i2khKPsH8B4u9aFDEIrC2V1eYoHIlTWGinltU
	6SIxcv7Gmll/uNBJuDKu9he0AtqdQjsCoghPyAIxuDQH4O9JOPZxzkVEKH1qcIJZbZRDIU
	DCTMFlTF3joX5vlyiCz7YlWYB+ZRk9U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-TVLj8ZmMPjuGIs25KpxdDA-1; Thu,
 26 Nov 2026 10:30:06 +0000
X-MC-Unique: TVLj8ZmMPjuGIs25KpxdDA-1
X-Mimecast-MFC-AGG-ID: TVLj8ZmMPjuGIs25KpxdDA_1795689006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AED5D1955F73;
	Thu, 26 Nov 2026 10:30:05 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 802D81956086;
	Thu, 26 Nov 2026 10:30:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 0/6] Test runner TLC
Date: Thu, 26 Nov 2026 11:29:56 +0100
Message-ID: <20261126103002.2145135-1-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some cleanups of the test runner, dropping some fat and preparing
for future reorganization of its functionality.  In particular I
would like to introduce a better waiver mechanism that does not
require changes to the tests.

Patches 1-2 remove the errata mechanism, as it has seen little use
and kernel version checks *in the test* are not a good way to decide
whether a test result should be waived.  While the original purpose
was to block tests that are unsafe and could cause the host to hang,
unsafe tests arguably shouldn't exist at all...

Patches 3-5 cut some of the environment functionality, specifically
not passing anymore host information to the test as they were not
read by any test.

Patch 6 finally makes unittests.cfg parsable by standard .ini syntax
parsers, such as Python's configparser.

Paolo

Paolo Bonzini (6):
  arm: remove usage of the errata mechanism
  remove errata mechanism
  omit "#" from printed command line if INITRD is empty
  do not pass information about kernel, QEMU or target via environment
  drop --enable/--disable-default-environ
  switch unittests.cfg parsing to be ConfigParser-compatible

 README.md               |  44 +------
 arm/debug.c             |   1 -
 arm/gic.c               |  10 --
 arm/pmu.c               |   8 +-
 arm/psci.c              |   9 +-
 arm/timer.c             |   5 +-
 configure               |  26 ----
 errata.txt              |   9 --
 lib/errata.h            |  58 ---------
 run_tests.sh            |   4 +-
 s390x/unittests.cfg     | 257 ++++++++++++++++++++--------------------
 scripts/arch-run.bash   | 131 +-------------------
 scripts/common.bash     |  85 ++++++++-----
 scripts/mkstandalone.sh |  11 --
 14 files changed, 198 insertions(+), 460 deletions(-)
 delete mode 100644 errata.txt
 delete mode 100644 lib/errata.h

-- 
2.56.1

