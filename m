Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB8E3F107A
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 10:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790592055; cv=none; b=l2N7tdex10zy3sEswvQxSNuX9UmDsQle7B6cMWtFtXOjxehJfPzLW6mMPo53vFfY6GpMGzBv1tYiAZWijhmfXQDqy1EBCtFkx99+dNLFAoi0vIaybOFAIKdoGWIIikxi+oyzt+WSYkBEc58s3SR9AX36pvd/MjdiJRITUavINtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790592055; c=relaxed/simple;
	bh=ykFmDikwhqcDts+QTNxM0K3LJFk5krjx6J2oB+7dAdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gukuQT0DOr7Qx20XLwYW8Dv0yL4E3gveJFq1SURGETg71K1jB7ErJ09/T3u74xyeOjupC2gvM5OX4LgOfsVHjDmZx6dXDVCFgIdxv+nqslOiTidUa8XsWzelC8Y05htCeUI9RqoXZldp+DWsgQEO395thzap3Q/MnJ0+SOgKk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMOzVKIA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMOzVKIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790592052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hc1EwtbYahY9c2Cug+ApRwdHvpNuhx3vsayoTvVcpxs=;
	b=cMOzVKIAW/etcoOmccgCgWx+V/NJYIMXm/1N/wfSZZ71ma8HIAfC/28v8wsHJyORtYDk1T
	alTbuy/0z0APFAsQMohpAQC9QekU3+WkS3t69TLFelqYcqmqNmKBTGCjhJx4/0KbO0+lRH
	wLUd0gw0RuybZdZGzKZLC7LiXIdKZIs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-KYvgagZXNbqDk5ZCTUiCPg-1; Mon,
 28 Sep 2026 06:40:47 -0400
X-MC-Unique: KYvgagZXNbqDk5ZCTUiCPg-1
X-Mimecast-MFC-AGG-ID: KYvgagZXNbqDk5ZCTUiCPg_1790592045
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E990195D021;
	Mon, 28 Sep 2026 10:40:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8576F30000E4;
	Mon, 28 Sep 2026 10:40:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 0BB6421E6A04; Mon, 28 Sep 2026 12:40:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
  Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 31/55] accel/tcg: move memory helpers out of
 tcg-runtime.h
In-Reply-To: <20260926070057.1234-32-luoyonggang@gmail.com> (Yonggang Luo's
	message of "Sat, 26 Sep 2026 15:00:30 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
	<20260926070057.1234-32-luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 12:40:41 +0200
Message-ID: <87cxtxhd5i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Yonggang Luo <luoyonggang@gmail.com> writes:

> memset, ld_i128, and st_i128 are declared in ldst_common.h, and
> ldst_common.c.inc emits their helper info. Atomic helpers move to
> atomic_common.h, with info records emitted from atomic_common.c.inc.
> tcg-runtime.h keeps the integer helpers implemented in tcg-runtime.c.
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

Another compilation failure:

    cc -m64  -o tests/unit/test-tcg-call-tl libevent-loop-base.a.p/event-lo=
op-base.c.o libqom.a.p/qom_container.c.o libqom.a.p/qom_object.c.o libqom.a=
.p/qom_object_interfaces.c.o libqom.a.p/qom_qom-qobject.c.o libqom.a.p/qom_=
compat-properties.c.o libqom.a.p/target-info.c.o libqom.a.p/target-kconfig.=
c.o libsystem.a.p/accel_tcg_tcg-runtime.c.o libsystem.a.p/tcg_optimize.c.o =
libsystem.a.p/tcg_region.c.o libsystem.a.p/tcg_tcg.c.o libsystem.a.p/tcg_tc=
g-common.c.o libsystem.a.p/tcg_tcg-op.c.o libsystem.a.p/tcg_tcg-op-vec.c.o =
libsystem.a.p/tcg_perf.c.o tests/unit/test-tcg-call-tl.p/test-tcg-call-tl.c=
.o tests/unit/test-tcg-call-tl.p/test-tcg-call-tl-stubs.c.o tests/unit/test=
-tcg-call-tl.p/.._.._page-vary-common.c.o -Wl,--as-needed -Wl,--no-undefine=
d -pie -fstack-protector-strong -Wl,-z,relro -Wl,-z,now -Wl,--start-group l=
ibqemuutil.a subprojects/libvhost-user/libvhost-user-glib.a subprojects/lib=
vhost-user/libvhost-user.a -lnuma /usr/lib64/liburing.so /usr/lib64/libgio-=
2.0.so /usr/lib64/libgobject-2.0.so /usr/lib64/libglib-2.0.so /usr/lib64/li=
bgmodule-2.0.so -pthread /usr/lib64/libgnutls.so -lm /usr/lib64/libpixman-1=
.so /usr/lib64/libepoxy.so -Wl,--end-group
    /usr/bin/ld: libsystem.a.p/tcg_perf.c.o: in function `perf_report_code':
    /work/armbru/qemu/bld/../tcg/perf.c:328:(.text+0x5e9): undefined refere=
nce to `debuginfo_lock'
    /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:341:(.text+0x66f): und=
efined reference to `debuginfo_query'
    /usr/bin/ld: /work/armbru/qemu/bld/../tcg/perf.c:361:(.text+0xa91): und=
efined reference to `debuginfo_unlock'
    collect2: error: ld returned 1 exit status

