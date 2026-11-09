Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252695;
	b=IhZ5HDbhWPEIq0KiraRrqKrQIQV2BoonWOQPUpwaGs+oYpvNGyiZyQ7EGFV/mYKlhEsD
	 3D6ebsyQ/ltbDMlYZkQLVZT6GraDnDpSgE3YL0zaish96h6TccHBoV8UAVnpS5ZpEIOOH
	 gqip2GpoweSuyODpXi2x4Gcx1DEmHOjgdMymJJvxuTA4WgTk87ElHTJRCndnqF4BZ3nK0
	 i01wkhlpRbeWMSfiXtGDcfySq0MLAYpsJUqq3KQnbsWDRPhF59EtNcY/tr0OCa5/eihsn
	 Hxdd9YTtd24vI10shHuIr6sKwB4yZ5gkRRva1svaICDLVGnKSiwzfA7RMT26p9CBvYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252695;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Scanned-By;
	bh=o94N2f3awzwXysc//TFCNPD7MZeyIfg53DxYU/bmF5s=;
	b=mhPKCSYTk4EBjFLqw2pGtCVzDfTt3aGWBtHEYqpk2psw/t7omHZy5xVPLVgc4sYeJjGJ
	 1wfNuWjY61YEXKl8sLBx3aeiqx3th0iLZPiqa4fh6CelPnygiJpvDJjv4XnNYyGsGvPCe
	 37608XdXYEGvRlAuXlX4SXaj+FG9/PSUWdUGIPW6tEIytM1NATFz3ZnqfuOyLmpv+3llO
	 h8OBBlaKY4N31AtBgnNdCKYxBRz9ystg+m5p/fLw0X6MECyHc50kztEK+3VMcswGzxAc6
	 IW8exma8CTRqdxd2OmPP4NqlYxUn6FCycJZc6+z8ISlKgi7JUkGk4/m5FTX4y5lKVpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Csie0thZ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0D1606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD0D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Csie0thZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794252693;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o94N2f3awzwXysc//TFCNPD7MZeyIfg53DxYU/bmF5s=;
	b=Csie0thZQt3icKSFZ81l5JPJL5bhgbaFWOYZd9FA+F/RLzwd9mdg24XavCNKXakv5VVSKM
	K4d2f//JP1gzOgiFMP63fttLk90Y2u5ERVbbTPsEdmWHyA1UnVct9HcDe0DWMJIpJtIQkt
	Mfqdzvri5saKNYwgtRMYiDGeflKoJRI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-93peSO1BM9ykNDxBRjaPdw-1; Mon,
 09 Nov 2026 14:31:31 -0500
X-MC-Unique: 93peSO1BM9ykNDxBRjaPdw-1
X-Mimecast-MFC-AGG-ID: 93peSO1BM9ykNDxBRjaPdw_1794252688
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D84F1800361;
	Mon,  9 Nov 2026 19:31:28 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CF7A180034C;
	Mon,  9 Nov 2026 19:31:23 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:31:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Alistair Francis <alistair.francis@wdc.com>,
	Stefan Weil <sw@weilnetz.de>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Fabiano Rosas <farosas@suse.de>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	Richard Henderson <richard.henderson@linaro.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH 3/7] debug/mem: name <reserved> regions in mmap-alloc
Message-ID: <avIfiBFmKdIZziSY@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
 <20261109185907.3220584-4-jsnow@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109185907.3220584-4-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Nov 09, 2026 at 01:59:03PM -0500, John Snow wrote:
> For mmap memory reserved by QEMU, give it the name "<reserved>". This
> will show up in maps output as "anon: qemu: <reserved>".
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  util/mmap-alloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

