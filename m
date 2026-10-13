Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81FB513568
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898814; cv=none; b=BKCMkgPukLBKHjIMeZxsFMd/NT/TGA7OFremAGffwA5omPY5b6y4H4lyNgw6fmPD4sz0vAXNOkVMfKhHbO2elo9tX8cfy94SCalC38vVzq+/YslXleYmlq7jGWlno8IL4/4Eooa5N0Nv2olhLnocwmon99YMZEsYYT/rqIGyW98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898814; c=relaxed/simple;
	bh=8LkmBOWNTfSxL3zUThu0Y6RVC6sE0FPEc4xlEeIWXT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oOxCrtGpIGh3Rq3w6OpjJeYMKDzvtvzb3OEUjITWp4EF5kEpk584exwb2Cy/Vhzzc48jBZcUuF2UekFXWu/fvlXeQ9UGVX4wExwRyEJh2ozpPQM2tpRxAa6BCKUnC9gPjN2mwT8FTEvzxg/i8bW9J7aTUaTsAk1sF+mHT4a+730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zpmeefsc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zpmeefsc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791898811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixuHkfPyJqLvv2sMOAVZvLUfWTeU+sVf2M2BlGZCFt0=;
	b=ZpmeefscnuQ/ZXEzVBDDLp/zW15szuEQpVikSCOGUhaXSo49E3rRq1Wzg2mqwMkQBy4Nqy
	fki7PyukEAn/8Fg85jNGFTfDS92sCfRCPMTb3LQf2q1R81k42zmIfHMd8Sug5bIwmQbLcv
	65Jt9W+K3SDZdADoGM7FUTb0izxWVDo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-vUVFzdz_OquXE0-i1AL2SQ-1; Tue,
 13 Oct 2026 13:40:08 +0000
X-MC-Unique: vUVFzdz_OquXE0-i1AL2SQ-1
X-Mimecast-MFC-AGG-ID: vUVFzdz_OquXE0-i1AL2SQ_1791898807
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10EB71828BB2;
	Tue, 13 Oct 2026 13:40:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC6181800446;
	Tue, 13 Oct 2026 13:40:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 52DD321E6A04; Tue, 13 Oct 2026 15:40:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  David Hildenbrand <david@kernel.org>,  Igor
 Mammedov <imammedo@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Richard Henderson <richard.henderson@linaro.org>,  "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>,  Jason Wang <jasowangio@gmail.com>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  kvm@vger.kernel.org
Subject: Re: [PATCH v5 15/62] qom: convert enum properties to QAPI-aware
 registration
In-Reply-To: <20260911-qom-qapi-v5-15-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 11 Sep 2026 20:34:49 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
	<20260911-qom-qapi-v5-15-7732a55b7760@redhat.com>
Date: Tue, 13 Oct 2026 15:40:04 +0200
Message-ID: <87bj8xyb0r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Convert all callers of object_class_property_add_enum() to use the new
> object_class_property_add_qapi_enum() with the QAPI_ENUM_PROP()
> macro, which provides type information via QAPITypeInfo instead of
> raw lookup tables and string type names.
>
> This enables QMP introspection to report accurate QAPI type names
> for enum properties. Where a separate set_description call was used,
> the description is now embedded in the QAPI_ENUM_PROP initializer.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fails qom-test for me:

    TAP version 14
    # random seed: R02Sae50f1988119a1a5ffa825624a2a4a56
    1..9
    # Start of x86_64 tests
    # Start of qom tests
    # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-13787=
95.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-1378795.qmp,=
id=3Dchar0 -object monitor-qmp,id=3Dqmp0,chardev=3Dchar0 -display none -aud=
io none -run-with exit-with-parent=3Don -machine none -object memory-backen=
d-ram,id=3Dnode0,size=3D65536  -accel qtest
    ok 1 /x86_64/qom/none
    # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-13787=
95.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-1378795.qmp,=
id=3Dchar0 -object monitor-qmp,id=3Dqmp0,chardev=3Dchar0 -display none -aud=
io none -run-with exit-with-parent=3Don -machine pc-i440fx-11.1 -object mem=
ory-backend-ram,id=3Dnode0,size=3D65536  -accel qtest
    qemu-system-x86_64: ../qom/qom-qmp-cmds.c:41: qom_property_info: Assert=
ion `prop->qapi_type->masked_name' failed.
    Broken pipe
    ../tests/qtest/libqtest.c:210: kill_qemu() detected QEMU death from sig=
nal 6 (Aborted) (core dumped)

PATCH 58 seems to fix it.

