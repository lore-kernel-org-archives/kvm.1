Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF882E8DEB
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578288; cv=none; b=CM4d8A54CIMqSgVBCo6ZN9s2nhayy/c4UmX5li5lBeDB8Db+qc8l9MukNdrHPQt1KGox1jBxZb0YQHA5MuwWMJQtzlpIAb56zP43EE1JJEbuPK4pFspGNvBfL8inek15sfE8j2yPBXfVcdmzaocBBFMhkMCKVd8QmiLmNK1D/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578288; c=relaxed/simple;
	bh=KJJSiO+13OolzqBqoIW8d9MKgfsCRMszHS43QnhPYGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QidWsWL5X9LmjBFkTEkUtHFTSImV1346nPVy4it5lR4Y8SnZUtebVWm+gVpCuECToqOmsRrFQXi2WNGIMMlLfwgsSZYSgTyOEHqOgFH8W0CSmHJVw4WfNH8/aoy0Le7LZfNMDKzVGQFVJZ2JCaaNxxVT1zVCxEScpKz4y9UbUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YelBjfik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YelBjfik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787578282;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XsWBXPS/V2WZm3P1W2Es0QTI78TJXsGrW3XAaRNazE=;
	b=YelBjfikyQafijcA6ryb8vNEybNKQjDRWiep0xCHqKnj1p0eMAUKXUBjs35g8q1vMZta7K
	vp44TJcVoNB1/FjiKeKELS0ySAed6w13lyQc8m/ai1Pqf3B1ea0sGWBsNslXsg/RPAb/1T
	/44p3YsenSAKYha77vu05C5FQ7kOPho=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-dWc6ihGGPXO-XUSR3P0thw-1; Mon,
 24 Aug 2026 09:31:18 -0400
X-MC-Unique: dWc6ihGGPXO-XUSR3P0thw-1
X-Mimecast-MFC-AGG-ID: dWc6ihGGPXO-XUSR3P0thw_1787578269
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C3DF195FD03;
	Mon, 24 Aug 2026 13:31:08 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26F5C18005BB;
	Mon, 24 Aug 2026 13:30:53 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:30:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
	Markus Armbruster <armbru@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ani Sinha <anisinha@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Cornelia Huck <cohuck@redhat.com>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Hyman Huang <infra.ai.cloud@bitdeer.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Stefan Berger <stefanb@linux.vnet.ibm.com>,
	Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Chinmay Rath <rathc@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu@processmission.com>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
	kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
	qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 31/49] monitor: change HMPCommand cmd to take
 MonitorHMP
Message-ID: <aoxHi-PfII_4Dh5-@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-31-e53fc35bc550@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816-qemu-no-hmp-v3-31-e53fc35bc550@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Aug 16, 2026 at 11:12:58PM +0400, Marc-André Lureau wrote:
> HMP commands are specific to the HMP monitor, so make the cmd function
> pointer in HMPCommand take MonitorHMP * instead of Monitor *. This
> strengthens type safety and makes the HMP-specific nature of these
> handlers explicit.
> 
> Handler functions are renamed to take MonitorHMP *hmp, with a local
> Monitor *mon = MONITOR(hmp) added where the body needs the base type.
> Following patches will drop it, since most functions are HMP specific.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio-hmp-cmds.c          |   8 +-
>  backends/cryptodev-hmp-cmds.c   |   3 +-
>  block/monitor/block-hmp-cmds.c  |  78 +++++++----
>  chardev/char-hmp-cmds.c         |  21 ++-
>  dump/dump-hmp-cmds.c            |   6 +-
>  hw/core/machine-hmp-cmds.c      |  49 ++++---
>  hw/i386/kvm/xen-stubs.c         |   6 +-
>  hw/i386/kvm/xen_evtchn.c        |   6 +-
>  hw/i386/sgx-hmp-stub.c          |   3 +-
>  hw/i386/sgx.c                   |   3 +-
>  hw/misc/mos6522-stub.c          |   3 +-
>  hw/misc/mos6522.c               |   3 +-
>  hw/net/rocker/rocker-hmp-cmds.c |  12 +-
>  hw/pci/pci-hmp-cmds.c           |   6 +-
>  hw/pci/pci-stub.c               |   5 +-
>  hw/s390x/s390-skeys.c           |   5 +-
>  hw/s390x/s390-stattrib.c        |   6 +-
>  hw/uefi/ovmf-log.c              |   3 +-
>  hw/usb/host-libusb.c            |   3 +-
>  hw/virtio/virtio-hmp-cmds.c     |  15 +-
>  include/block/block-hmp-cmds.h  |  55 ++++----
>  include/hw/usb/usb.h            |   3 +-
>  include/monitor/hmp.h           | 294 ++++++++++++++++++++--------------------
>  include/monitor/qdev.h          |   5 +-
>  include/net/net.h               |   5 +-
>  include/net/slirp.h             |   8 +-
>  migration/dirtyrate.c           |   6 +-
>  migration/migration-hmp-cmds.c  |  48 ++++---
>  monitor/hmp-cmds.c              |  96 ++++++++-----
>  monitor/hmp.c                   |  17 ++-
>  monitor/monitor-internal.h      |   2 +-
>  net/net-hmp-cmds.c              |  14 +-
>  net/slirp.c                     |   9 +-
>  qom/qom-hmp-cmds.c              |  18 ++-
>  replay/replay-debugging.c       |   9 +-
>  replay/stubs-system.c           |   8 +-
>  stats/stats-hmp-cmds.c          |   3 +-
>  stubs/hmp-cmd-info_sev.c        |   3 +-
>  system/dirtylimit-hmp-cmds.c    |   9 +-
>  system/qdev-monitor.c           |  11 +-
>  system/runstate-hmp-cmds.c      |   9 +-
>  system/tpm-hmp-cmds.c           |   3 +-
>  target/i386/cpu-apic.c          |   3 +-
>  target/i386/monitor.c           |   9 +-
>  target/i386/sev.c               |   3 +-
>  target/m68k/monitor.c           |   3 +-
>  target/ppc/monitor.c            |   3 +-
>  target/riscv/monitor.c          |   3 +-
>  target/sh4/monitor.c            |   3 +-
>  target/sparc/monitor.c          |   3 +-
>  target/xtensa/monitor.c         |   3 +-
>  trace/trace-hmp-cmds.c          |   8 +-
>  ui/ui-hmp-cmds.c                |  31 +++--
>  53 files changed, 561 insertions(+), 390 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

