Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1AB3B71C5
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737334; cv=pass; b=i5KGMDxpMRe+/yrH03LdnjOAviQHpEJZcYaygfmQUR+9IXa6k2ouocE1AIVlR9/t0t9J1vhegyCPMQ44eJXlONS2KiXwJ2zTdyd28AAR9n0jp+uxIzsYCCB0RFgLSm0fy+DOqve42itz1BXqEPd08oL+zm2qgeUM5Q5K5y2sFCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737334; c=relaxed/simple;
	bh=674ySK+7H6XTQEQX5SyulkShdiDdn83V6WJVrTzR1ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsiv+ncZIXmo9MJ7fo4pC0ec2VAwHT+VH1Ij04XDVABGLdoZg31zLTylcSjaHSkrK4kNFWw2qJOVW4RaTZ0PkzS54KI10Zkt7A7QBd/tSgv0+hcqK8TkE6l3M3T+WFYuuQQ/C6XtGkBVJW/WdrDb7xBdBdgZ/YJJhd3wyqvcWMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYlNoq/P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlWaXSMW; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYlNoq/P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlWaXSMW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787737330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
	b=YYlNoq/PRyzRWXxZHHOKuPVSQn/vlu1u/jeWqvf7wqCeqBJgduwRQ/HI07+kut/XbmIVba
	iYDSXSWKc72Fmlx79/JiypL4AO7VsNYosT3q5PpxDaiqMyDyaXLnejFd6Qm6yvAFJ1TogS
	fjEiCVZIMy1pgItGOS6268L5A6G8wlA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-RHyQZP5YMNOt95FHUdEFTg-1; Wed, 26 Aug 2026 05:42:09 -0400
X-MC-Unique: RHyQZP5YMNOt95FHUdEFTg-1
X-Mimecast-MFC-AGG-ID: RHyQZP5YMNOt95FHUdEFTg_1787737328
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c89704da8c7so1360661a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 02:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787737328; cv=none;
        d=google.com; s=arc-20260327;
        b=HEuV4PKOPtEi1JvKC45TlO6dg0d0jbOH46DyFPTwXEYBsOOisFfFiLEEO3/wNhPfVX
         EQxwB8G5lNcdtrUtFBaHWmPOAW6OMJDgFoKHuBabiLAbIFt+zcumwMlrxf55thE/QfGi
         ajspIA12zu1rdGVhooFeAOTiarVc8jwX3ed96lZXY8kj3gq+PtmiT+HvNEOKOP7236KO
         +/qzzmwzlXggr41xuyHYsZjTOwPoQJoL+00ThcvwEZ3bQnnnZafHppzpMDWDeEy3VkBO
         Yypw4HGW6OmlyGldyMYpb6lcpZwUDjJo6kiRbWVAP1cRuFc2QD1LU37nuQCNP+K79hrS
         aYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
        fh=tZ9fCvCWiuaUM6xMog6g7m8crwkzUegmHCaZVB0dPTc=;
        b=R9urSBWlz3iX2lEylrLnnHkZSdPPAR956zNNc067LxrouEU7di/fv39x5mJKcUXZZU
         3hWqA7Uwtq8Zl6ajMgaBJMYFNBhiU5BCoR6wq2H8mbY2gBFWclApHifKpyTkM5WbTkA/
         H6XAhqoy7bZxinq7EMSQwcBjrasLPw7/3zfL+FAfi0osKgHXJNST1mwdEqZsXL9owVQc
         hrM0pNXvJ19uw6m3Qtee0RKlidGfZs9jv2E9zfdBibFncL5RepzsbBp5nzg6zPgsQl86
         MVc+naVgw1jHsDXircbF3eF7eNHXqqfQOLIQaZ+X7lmj6levnfb5fK82+Yp02uplaMS6
         QlTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787737328; x=1788342128; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
        b=MlWaXSMWDPmOuUqtx8FxwxSAmBzzh23gxHjpC19fr7wBaX2CkaXHVaqwBlD8Qxhg70
         Sw/kAJCUcgsZpPOo48bGo7nNYjdi+8LmF6c2apqtRox1dRSfJWxnhkKiV79T85guN5Uq
         dgTjOhGI/Dg/deNGO6pEQMQlWrFXdMfUbSjN1USovxtQZslw2obZIcZlabAWRnyd2BLz
         ItDxEzAFtqkj+CBzO8ig8bFkvd/584uq523UJBbUz8W0cVS9maTdWD8NwqCxZU9L48+B
         W/YRtj2hpdLSHCkSabfhHs2wWsImkCmJo0tlLyC5PQM1DQ+xq0/6ZyVlMhfpngXLxih+
         rsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737328; x=1788342128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSRhiRnZLNoz4j1O+xumJH2wghFBy7JpPCbRlPFYp/4=;
        b=EFDgJmEsSmbwGPmByyHkEUq2boep4G5LdII3IMXC7cdKjjItu/ShaUkMDQRhGBA0+i
         oL8Ah+Tc682MTPX4MztYD9KPQabmVWcfkacDo/StLkAFN9cA4LPbNQda70H4NdkoVuGQ
         O1Wyb7YhCycgcEZyhW3ku5nVdxjjpLLzYM1C7h4jb03+Hz+/ZZp3rZ3ckBUtKIaomj0J
         Mq/z1x4P7467XCJvdoSgR2aZ3jx9Fi5d1YdDR0loJbDwsz1AxISyKb5/8wvVtfrGCUYH
         J7Hpu4BmFiG7DaA8/8R5wxl0xQqFUCW+ylM8yA7bAdDHOAizxuJca8C8tQ+P42MOfpYl
         LsIg==
X-Forwarded-Encrypted: i=1; AHgh+RqWuBpLygh0TH9EIAcdVbGsAfRlPbzcYrVfYYBs8kq6YlYriDjUTmAeKsOoz3s+x5QHRr8=@vger.kernel.org
X-Gm-Message-State: AFuF++lhsIvweSSMhpUVPriVPB/1bQGzrZso8XBDKsRb1KppLzSmEsi+
	D3KWCOvHVi9NzPVLQtumLyW91dmse5VrL26HLC4CNIjW/o2YC3dzVdZNJl/53b3dv2nwe4oR+Wu
	Y69IV4jpyjifg64pdwKyadzkL19EeS3D/0BVkrZRXyy8FTFp0/f2k1Mv5aJr9FQUr330Kw3irdu
	wDVcadOGB3Uk7W5NJwWkyk5XG7MSPo
X-Gm-Gg: AR+sD13k/TqQvwZPSlMh+69ojD0NnFIC4SWiXvNgw8G0kpVyNeov4ZelKHF8h/Kph13
	YaPceLJMCUQFEg5Udlls/qFtMi5C4AgS4wVegW+cu8SLfvLa2Aw+i3eeYAogchRBoB++fkeNI32
	HnlgtrCyJQYKfGlwFJSGqh4ANpMspORpwJtO+cIUqggoeUGd6hQh/XS9kEmOD+iW/eCEfWbCkGY
	EEo8yzc6MXaLSgmQq8rto7As0rkr6I7TAgvy3E077ZNIwpUhmfTNnXMnfctSBGzhD+oUiWuDdC9
	0Q==
X-Received: by 2002:a05:6a20:2584:b0:3cc:8344:1213 with SMTP id adf61e73a8af0-3cf83531791mr9386612637.8.1787737328140;
        Wed, 26 Aug 2026 02:42:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:2584:b0:3cc:8344:1213 with SMTP id
 adf61e73a8af0-3cf83531791mr9386473637.8.1787737327525; Wed, 26 Aug 2026
 02:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com> <ao6pyiBkHZJz_9JR@redhat.com>
In-Reply-To: <ao6pyiBkHZJz_9JR@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 13:41:55 +0400
X-Gm-Features: AcwNN1UW47qL6Xcco1r65R6n9lM9Iv0EQgjkA8oE2IKKhKY4fAQjALpMF87caYU
Message-ID: <CAMxuvaz+85Pw=sZG2jXL5jJ_2=kkR5_P69-AZ6bzhVbGTA+5Xg@mail.gmail.com>
Subject: Re: [PATCH v4 36/49] monitor: tighten monitor_printf*()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	"Gonglei (Arei)" <arei.gonglei@huawei.com>, zhenwei pi <zhenwei.pi@linux.dev>, 
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Ani Sinha <anisinha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
	Brian Cain <brian.cain@oss.qualcomm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Paul Durrant <paul@xen.org>, Richard Henderson <richard.henderson@linaro.org>, 
	Marcelo Tosatti <mtosatti@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
	Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Cornelia Huck <cohuck@redhat.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Anthony PERARD <anthony@xenproject.org>, 
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Hyman Huang <infra.ai.cloud@bitdeer.com>, 
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
	Samuel Thibault <samuel.thibault@ens-lyon.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
	Harsh Prateek Bora <harshpb@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Chao Liu <chao.liu@processmission.com>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
	Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, kvm@vger.kernel.org, 
	qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org, 
	qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Aug 26, 2026 at 12:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Tue, Aug 25, 2026 at 11:09:43PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> > monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> > the first parameter from Monitor * to MonitorHMP * to enforce type
> > safety. The implementation is also simplified: monitor_hmp_vprintf now
> > directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> > dispatch via moncls->vprintf.
> >
> > The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> > cast, they are fixed in the following commits.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  audio/audio-hmp-cmds.c                  |   6 +-
> >  backends/cryptodev-hmp-cmds.c           |   9 +-
> >  block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
> >  chardev/char-hmp-cmds.c                 |  12 +-
> >  disas/disas-mon.c                       |  10 +-
> >  docs/devel/style.rst                    |   2 +-
> >  docs/devel/writing-monitor-commands.rst |   8 +-
> >  dump/dump-hmp-cmds.c                    |   5 +-
> >  hw/char/virtio-serial-bus.c             |  10 +-
> >  hw/core/machine-hmp-cmds.c              | 213 +++++++++++-----------
> >  hw/core/sysbus.c                        |   5 +-
> >  hw/hexagon/hexagon_tlb.c                |  44 ++---
> >  hw/i386/kvm/xen-stubs.c                 |   6 +-
> >  hw/i386/kvm/xen_evtchn.c                |  21 +--
> >  hw/i386/sgx-hmp-stub.c                  |   3 +-
> >  hw/i386/sgx.c                           |  29 ++-
> >  hw/misc/auxbus.c                        |   9 +-
> >  hw/misc/mos6522-stub.c                  |   3 +-
> >  hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++--------
> >  hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
> >  hw/pci/pci-stub.c                       |   3 +-
> >  hw/s390x/s390-skeys.c                   |   9 +-
> >  hw/s390x/s390-stattrib.c                |  20 +--
> >  hw/uefi/ovmf-log.c                      |   5 +-
> >  hw/usb/bus.c                            |  11 +-
> >  hw/usb/host-libusb.c                    |  21 ++-
> >  hw/virtio/virtio-hmp-cmds.c             | 297 ++++++++++++++++--------=
-------
> >  hw/xen/xen-bus.c                        |   5 +-
> >  include/disas/disas.h                   |   4 +-
> >  include/monitor/hmp.h                   |  12 +-
> >  migration/dirtyrate.c                   |  46 +++--
> >  migration/migration-hmp-cmds.c          | 301 ++++++++++++++++--------=
--------
> >  monitor/hmp-cmds.c                      | 141 +++++++--------
> >  monitor/hmp.c                           | 143 +++++++--------
> >  monitor/monitor-internal.h              |   6 -
> >  monitor/monitor.c                       |  33 ++--
> >  net/net-hmp-cmds.c                      |  31 ++--
> >  net/slirp.c                             |  31 ++--
> >  qom/qom-hmp-cmds.c                      |  27 ++-
> >  replay/replay-debugging.c               |   5 +-
> >  stats/stats-hmp-cmds.c                  |  57 +++---
> >  stubs/hmp-cmd-info_sev.c                |   3 +-
> >  stubs/monitor-core.c                    |   2 +-
> >  system/dirtylimit-hmp-cmds.c            |  10 +-
> >  system/qdev-monitor.c                   |  19 +-
> >  system/runstate-hmp-cmds.c              |  16 +-
> >  system/tpm-hmp-cmds.c                   |  29 ++-
> >  target/i386/cpu-apic.c                  |   3 +-
> >  target/i386/monitor.c                   | 152 ++++++++--------
> >  target/i386/sev.c                       |  35 ++--
> >  target/m68k/monitor.c                   |   3 +-
> >  target/ppc/monitor.c                    |   3 +-
> >  target/riscv/monitor.c                  |  55 +++---
> >  target/sh4/monitor.c                    |  29 ++-
> >  target/sparc/monitor.c                  |   3 +-
> >  target/xtensa/monitor.c                 |   3 +-
> >  tests/unit/test-util-sockets.c          |   2 +-
> >  tools/qemu-vnc/clipboard.c              |   4 +-
> >  tools/qemu-vnc/stubs.c                  |   2 +-
> >  trace/trace-hmp-cmds.c                  |  12 +-
> >  ui/ui-hmp-cmds.c                        | 115 ++++++------
> >  util/error-report.c                     |   2 +-
> >  util/qemu-print.c                       |  11 +-
> >  63 files changed, 1219 insertions(+), 1327 deletions(-)
>
>
>
>
> > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > index 5d4143d425a1..5938f2b6c338 100644
> > --- a/util/qemu-print.c
> > +++ b/util/qemu-print.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "monitor/monitor.h"
> >  #include "monitor/hmp.h"
> > +#include "qom/object.h"
> >  #include "qemu/qemu-print.h"
> >
> >  /*
> > @@ -23,8 +24,13 @@
> >  int qemu_vprintf(const char *fmt, va_list ap)
> >  {
> >      Monitor *cur_mon =3D monitor_cur();
> > +
> > +    /* for all monitors: QMP & HMP */
> >      if (cur_mon) {
> > -        return monitor_vprintf(cur_mon, fmt, ap);
> > +        /* don't use monitor_cur_hmp(), to avoid a second lookup */
> > +        MonitorHMP *hmp =3D (MonitorHMP *)
> > +            object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP);
> > +        return monitor_hmp_vprintf(hmp, fmt, ap);
>
> This isn't the same semantics AFAICT.
>
> Original code, if monitor_cur() =3D=3D QMP, we call monitor_vprintf()
> which will return -1.
>
> New code, if monitor_cur() =3D=3D QMP, we will get a NULL back from
> object_dynamic_cast which we then pass into monitor_hmp_vprintf
> which will then crash on monitor_puts() IIUC.

monitor_hmp_vprintf() has an early return, if given NULL monitor, it return=
s -1.

>
> >      }
> >      return vprintf(fmt, ap);
> >  }
> > @@ -55,7 +61,8 @@ int qemu_printf(const char *fmt, ...)
> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >  {
> >      if (!stream) {
> > -        return monitor_vprintf(monitor_cur(), fmt, ap);
> > +        MonitorHMP *hmp =3D monitor_cur_hmp();
> > +        return monitor_hmp_vprintf(hmp, fmt, ap);
>
> Same, this should crash on QMP now IIUC.
>
> >      }
> >      return vfprintf(stream, fmt, ap);
> >  }
> >
> > --
> > 2.55.0.543.g5ebe2ebe4ea8
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

