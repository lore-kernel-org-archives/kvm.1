Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252960;
	b=FFsbX+TbuPDWAjyg6cHAEIkfIXkJ1K3klyBEJDBrYCfHfVcLggjVuvHV5slU+T1z9y7p
	 KvN5qwpTx9TV+tWm9cPPTVvNNNLyYAPIeTNqhphJM1z/hvj/+xaYve7PU/3BGDsGpxJER
	 2vT3TA1e6c6/eIUC9NiIW9zGd+eFb55o2LsvxTthnsZE8glRKmkD0PMqz0MTFYNy5iDlA
	 ACJ1Pyx42E5AqqqGDh1Vba23J7FuqTj94NYlZnMDIpe4szEEaeYlJgHA9uWMAEmZsDBTG
	 /qBqUtHCUx2UrusQDVy0dRYO7KFNiJp5hTtYl/oCxSxDoAl5eRSEhL2Odb3vk31fN2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252960;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:User-Agent:
	 X-Scanned-By;
	bh=/IUGY57JmXUHFBmsIw0p6PVZHU3BQWZLugsfrHWhKIE=;
	b=pYIPzYUOj/LqFN5tDbHmZbP/AtRdGIvCMNLqjg431p+CDJlMxa5KpHXlDrSCnS9CqsW9
	 ZippIP7mks71dm2W8lD7c+vyJ7Wyn6+Fe6dNA6VlNyvZS4PeynhKQ+60ha5db3ujScxHw
	 8JOuJ+3K0iQebVIjEFzWTF+b0PestrxmVXTxCQXfE4kMOVGrpSpObyyLHrDVdZAcXBvRq
	 L+tI2XO2cilu3XwSM07QZB/bhuvECXDye3zE3awMi7ETbcJP/6tDkG2I6ClHmV+uSkcp7
	 FC5IKPcqZUARNUXwKeiFs8gisQgAUPrqWNQ7HY//SlXQ0zgPC17rfKn4DZFAhVFYxYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6mdpF0j;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E92606A326
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 19:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4E92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L6mdpF0j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794252958;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IUGY57JmXUHFBmsIw0p6PVZHU3BQWZLugsfrHWhKIE=;
	b=L6mdpF0jZ62+IH2B8e65i726/PzMpoUAuj6PosUrqeMTa4x5aWix7IL3NNqtgXuPbCrZEn
	Ub+H6gdfjV3NY66wcEwEI4XNm+EXUJWwGqZvEzqYZMXsTftNMEOPpsQfYLbGjfZOS7Jo4h
	VczMz4aXfjVRzlRIqTtk5rr0qki6vDg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130--u-mp0MpOESJSPVm5eavbg-1; Mon,
 09 Nov 2026 14:35:55 -0500
X-MC-Unique: -u-mp0MpOESJSPVm5eavbg-1
X-Mimecast-MFC-AGG-ID: -u-mp0MpOESJSPVm5eavbg_1794252953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18E191956050;
	Mon,  9 Nov 2026 19:35:53 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2FAC1800480;
	Mon,  9 Nov 2026 19:35:48 +0000 (UTC)
Date: Mon, 9 Nov 2026 19:35:45 +0000
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
Subject: Re: [PATCH 6/7] debug/mem: name qemu_anon_ram_alloc/qemu_ram_mmap
 pages
Message-ID: <avIgkZcb8_rDyNdU@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
 <20261109185907.3220584-7-jsnow@redhat.com>
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
In-Reply-To: <20261109185907.3220584-7-jsnow@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Nov 09, 2026 at 01:59:06PM -0500, John Snow wrote:
> This patch adds a nickname parameter to qemu_anon_ram_alloc, which
> passes it to qemu_ram_mmap, which passes it in turn to mmap_activate,
> where it is used to name the region being allocated.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/mmap-alloc.h  |  3 ++-
>  include/qemu/osdep.h       |  2 +-
>  hw/display/virtio-gpu-gl.c |  2 +-
>  migration/ram.c            |  3 ++-
>  system/physmem.c           |  7 +++++--
>  target/i386/kvm/tdx.c      |  3 ++-
>  util/mmap-alloc.c          | 10 +++++++---
>  util/oslib-posix.c         |  4 ++--
>  util/oslib-win32.c         |  2 +-
>  9 files changed, 23 insertions(+), 13 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

