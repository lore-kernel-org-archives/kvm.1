Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689032;
	b=kOTuFqO8IBTMkj1Lj3LW2YXY2ghZysT7J+imrfJGx5FtG47aHQ9l07CQlD+YqWluCZhP
	 jc5eUCSoATS6KRxJfZqmJ8Yys/OrMxaO2JItcuTS2+ZPRoTW+/UxEbTgl5Ae1Rzf14qWn
	 j0hMcewXc8IKvufSW6DAIO9IY/T6x02bmDpJSRvoKVDjXTrLOHL68abZwaKsGG4CbohcP
	 Kd9Z52Is+ocbWjGNo97mYCKhnv4NQbsttH8xM/ouv3cRCsKD4x9+y1k/MMoAnirA+knfO
	 v7cI4GfL/z6KDMzjRaZmk3VsHyqWwp8UOjp1gOFK2ZiYReksY9RZSBRqN1c+761OqNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689032;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=aSUqvLhk4o0M9a4/p1bPoGZrnOFXo4D7rr9orwKFjyI=;
	b=1XLB6sOk4sUg8MCsj7zu0oDcRBRT1aD2WgG68ZugONiXKTu5hDpPCMPdqOCoUX2uP3im
	 0iKUIuO3GbnnbaET//pQN8wR5GTiwEkC/0guENNXa3OLCOgIvkxppMT8bSiQlG92VQ1zG
	 5ifx5aoxs+70RSmuIizOQJL17+t4jbJihNpNe+jGKq+svC71JSArsCyGX1yvOO+TiTW+O
	 f9jxlJ2+5CSwH80bR/CxUyeN9baTA683TmLIG/moY3cwudxsBxDRDpiwjOHmoXRRoVm3e
	 A4fs8vloNcNRLHG+LDaUnLhRoEbBv+hx6xQ63vzKDyzRXds3NJZz/8fxc+aowjltx4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=erXL73fA;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B710606A69A
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 10:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B710606A69A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=erXL73fA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795689020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSUqvLhk4o0M9a4/p1bPoGZrnOFXo4D7rr9orwKFjyI=;
	b=erXL73fAJK3+8ZyX7Euy5NgHtct5kVbnE0aw0DnRxSFuEvqypALK/bfkmdfxTfut7549L7
	dpv6ykiCd5I3RNqypNRglq3Aii14KSfJFmciq8hGVBCIiDIzuxCacOe2oqyOjd/PjTzzJO
	CdyJoyu9xgSJyvRAD4pANaqQozFEcNY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-ayYxingxODC3tpmwtPspGw-1; Thu,
 26 Nov 2026 10:30:16 +0000
X-MC-Unique: ayYxingxODC3tpmwtPspGw-1
X-Mimecast-MFC-AGG-ID: ayYxingxODC3tpmwtPspGw_1795689015
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54DCA1944B19;
	Thu, 26 Nov 2026 10:30:15 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BC851956086;
	Thu, 26 Nov 2026 10:30:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: thuth@redhat.com,
	andrew.jones@linux.dev
Subject: [PATCH kvm-unit-tests 6/6] switch unittests.cfg parsing to be ConfigParser-compatible
Date: Thu, 26 Nov 2026 11:30:02 +0100
Message-ID: <20261126103002.2145135-7-pbonzini@redhat.com>
In-Reply-To: <20261126103002.2145135-1-pbonzini@redhat.com>
References: <20261126103002.2145135-1-pbonzini@redhat.com>
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

Replace the """...""" syntax for multiline strings with
continuation by indentation; this is similar to other .ini-style
parsers like the Python ConfigParser.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 s390x/unittests.cfg | 257 ++++++++++++++++++++++----------------------
 scripts/common.bash |  85 ++++++++++-----
 2 files changed, 184 insertions(+), 158 deletions(-)

diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index 64bc998d..228bdbee 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -253,135 +253,134 @@ qemu_params = -cpu max,ctop=on -smp sockets=31,cores=8,maxcpus=248
 [topology-3]
 file = topology.elf
 test_args = '-drawers 2 -books 2 -sockets 2 -cores 16'
-qemu_params = """-cpu max,ctop=on -smp cpus=1,drawers=2,books=2,sockets=2,cores=16,maxcpus=128 \
--device max-s390x-cpu,core-id=31,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=11,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=95,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=73,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=78,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=13,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=40,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=101,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=29,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=56,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=92,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=30,drawer-id=0,book-id=0,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=118,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=71,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=93,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=16,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=5,drawer-id=0,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=42,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=98,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=44,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=23,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=65,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=102,drawer-id=0,book-id=0,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=57,drawer-id=0,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=125,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=127,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=82,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=14,drawer-id=0,book-id=0,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=91,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=12,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=8,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=112,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=109,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=19,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=96,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=67,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=80,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=108,drawer-id=0,book-id=1,socket-id=0,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=34,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=18,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=39,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=53,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=46,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=3,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=76,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=15,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=7,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=81,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=1,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=113,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=38,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=90,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=117,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=62,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=85,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=49,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=24,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=107,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=103,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=33,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=51,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=21,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=72,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=63,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=105,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=74,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=50,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=60,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=22,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=43,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=48,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=35,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=58,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=106,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=123,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=122,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=9,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=10,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=25,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=116,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=26,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=17,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=20,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=59,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=54,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=70,drawer-id=1,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=88,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=6,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=52,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=55,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=124,drawer-id=1,book-id=0,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=61,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=84,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=68,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=86,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=4,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=75,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=115,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=28,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=120,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=41,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=87,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=119,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=114,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=104,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=27,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=121,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=126,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=37,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=32,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=94,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=110,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=77,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=36,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=66,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=83,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=47,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=99,drawer-id=1,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=79,drawer-id=1,book-id=1,socket-id=1,entitlement=low,dedicated=false \
--device max-s390x-cpu,core-id=100,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
--device max-s390x-cpu,core-id=89,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=false \
--device max-s390x-cpu,core-id=2,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=45,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=69,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=64,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=97,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true \
--device max-s390x-cpu,core-id=111,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false \
-"""
+qemu_params = -cpu max,ctop=on -smp cpus=1,drawers=2,books=2,sockets=2,cores=16,maxcpus=128
+	-device max-s390x-cpu,core-id=31,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=11,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=95,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=73,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=78,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=13,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=40,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=101,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=29,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=56,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=92,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=30,drawer-id=0,book-id=0,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=118,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=71,drawer-id=0,book-id=0,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=93,drawer-id=0,book-id=0,socket-id=0,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=16,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=5,drawer-id=0,book-id=0,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=42,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=98,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=44,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=23,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=65,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=102,drawer-id=0,book-id=0,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=57,drawer-id=0,book-id=0,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=125,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=127,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=82,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=14,drawer-id=0,book-id=0,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=91,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=12,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=8,drawer-id=0,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=112,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=109,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=19,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=96,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=67,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=80,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=108,drawer-id=0,book-id=1,socket-id=0,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=34,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=18,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=39,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=53,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=46,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=3,drawer-id=0,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=76,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=15,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=7,drawer-id=0,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=81,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=1,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=113,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=38,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=90,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=117,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=62,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=85,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=49,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=24,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=107,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=103,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=33,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=51,drawer-id=0,book-id=1,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=21,drawer-id=0,book-id=1,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=72,drawer-id=0,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=63,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=105,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=74,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=50,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=60,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=22,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=43,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=48,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=35,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=58,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=106,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=123,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=122,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=9,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=10,drawer-id=1,book-id=0,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=25,drawer-id=1,book-id=0,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=116,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=26,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=17,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=20,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=59,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=54,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=70,drawer-id=1,book-id=0,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=88,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=6,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=52,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=55,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=124,drawer-id=1,book-id=0,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=61,drawer-id=1,book-id=0,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=84,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=68,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=86,drawer-id=1,book-id=0,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=4,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=75,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=115,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=28,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=120,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=41,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=87,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=119,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=114,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=104,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=27,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=121,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=126,drawer-id=1,book-id=1,socket-id=0,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=37,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=32,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=94,drawer-id=1,book-id=1,socket-id=0,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=110,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=77,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=36,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=66,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=83,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=47,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=99,drawer-id=1,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=79,drawer-id=1,book-id=1,socket-id=1,entitlement=low,dedicated=false
+	-device max-s390x-cpu,core-id=100,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false
+	-device max-s390x-cpu,core-id=89,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=false
+	-device max-s390x-cpu,core-id=2,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=45,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=69,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=64,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=97,drawer-id=1,book-id=1,socket-id=1,entitlement=high,dedicated=true
+	-device max-s390x-cpu,core-id=111,drawer-id=1,book-id=1,socket-id=1,entitlement=medium,dedicated=false
 
 [sie-dat]
 file = sie-dat.elf
diff --git a/scripts/common.bash b/scripts/common.bash
index 41310701..47c45660 100644
--- a/scripts/common.bash
+++ b/scripts/common.bash
@@ -18,13 +18,35 @@ function for_each_unittest()
 	local timeout
 	local disabled_if
 	local rematch
+	local raw
+	local current
+	local value
 
 	# shellcheck disable=SC2155
 	local params_name=$(vmm_unittest_params_name)
 
 	exec {fd}<"$unittests"
 
-	while read -r -u $fd line; do
+	while IFS= read -r -u $fd raw; do
+		read -r line <<<"$raw"
+		# parse in the same order as the Python configparser: detect comments
+		# and blanks first, then continuation by indentation, then section
+		# headers, then individual keys.
+		case "$line" in
+		"" | \#*)
+			current=""
+			continue
+			;;
+		esac
+
+		case "$raw" in
+		[[:blank:]]*)
+			# Append continuation lines to the previous key, joined by a space.
+			[ -n "$current" ] && eval "$current=\"\$$current \$line\""
+			continue
+			;;
+		esac
+
 		if [[ "$line" =~ ^\[(.*)\]$ ]]; then
 			rematch=${BASH_REMATCH[1]}
 			if [ -n "${testname}" ]; then
@@ -46,45 +68,50 @@ function for_each_unittest()
 			accel=""
 			timeout=""
 			disabled_if=""
-		elif [[ $line =~ ^file\ *=\ *(.*)$ ]]; then
-			kernel=$TEST_DIR/${BASH_REMATCH[1]}
+			continue
+		fi
+
+		# value *is* used below via eval
+		# shellcheck disable=SC2034
+		if [[ $line =~ ^file\ *=\ *(.*)$ ]]; then
+			current=kernel
+			value=$TEST_DIR/${BASH_REMATCH[1]}
 		elif [[ $line =~ ^smp\ *=\ *(.*)$ ]]; then
-			smp="$(vmm_optname_nr_cpus) ${BASH_REMATCH[1]}"
+			current=smp
+			value="$(vmm_optname_nr_cpus) ${BASH_REMATCH[1]}"
 		elif [[ $line =~ ^test_args\ *=\ *(.*)$ ]]; then
-			test_args="$(vmm_optname_args) ${BASH_REMATCH[1]}"
-		elif [[ $line =~ ^($params_name)\ *=\ *'"""'(.*)$ ]]; then
-			opts="$(vmm_default_opts) ${BASH_REMATCH[2]}$'\n'"
-			while read -r -u $fd; do
-				#escape backslash newline, but not double backslash
-				if [[ $opts =~ [^\\]*(\\*)$'\n'$ ]]; then
-					if (( ${#BASH_REMATCH[1]} % 2 == 1 )); then
-						opts=${opts%\\$'\n'}
-					fi
-				fi
-				if [[ "$REPLY" =~ ^(.*)'"""'[:blank:]*$ ]]; then
-					opts+=${BASH_REMATCH[1]}
-					break
-				else
-					opts+=$REPLY$'\n'
-				fi
-			done
+			current=test_args
+			value="$(vmm_optname_args) ${BASH_REMATCH[1]}"
 		elif [[ $line =~ ^($params_name)\ *=\ *(.*)$ ]]; then
-			opts="$(vmm_default_opts) ${BASH_REMATCH[2]}"
+			current=opts
+			value="$(vmm_default_opts) ${BASH_REMATCH[2]}"
 		elif [[ $line =~ ^groups\ *=\ *(.*)$ ]]; then
-			groups=${BASH_REMATCH[1]}
+			current=groups
+			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^arch\ *=\ *(.*)$ ]]; then
-			arch=${BASH_REMATCH[1]}
+			current=arch
+			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^machine\ *=\ *(.*)$ ]]; then
-			machine=${BASH_REMATCH[1]}
+			current=machine
+			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^check\ *=\ *(.*)$ ]]; then
-			check=${BASH_REMATCH[1]}
+			current=check
+			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^disabled_if\ *=\ *(.*)$ ]]; then
-			disabled_if=${BASH_REMATCH[1]}
+			current=disabled_if
+			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^accel\ *=\ *(.*)$ ]]; then
-			accel=${BASH_REMATCH[1]}
+			current=accel
+			value=${BASH_REMATCH[1]}
 		elif [[ $line =~ ^timeout\ *=\ *(.*)$ ]]; then
-			timeout=${BASH_REMATCH[1]}
+			current=timeout
+			value=${BASH_REMATCH[1]}
+		else
+			# ignore
+			current=""
+			continue
 		fi
+		[ -n "$current" ] && eval "$current=\$value"
 	done
 	if [ -n "${testname}" ]; then
 		$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
-- 
2.56.1

