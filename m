Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAC118A6D4
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749488; cv=pass; b=k/6zqqNtCb0KCxjrPGgcDMAUS4ffIaVzzloARCWIWh9AhqROT+EiikE14b79wAYFgQpOORWIyrnytBInEkE26ltJUVG85yM3twMBVTM4fnXZb6rvfGzqvk4OJTwrDDedpxWB8ths3AAuFMw5XMZqYIumrZCBgZKLS4rT+azNaKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749488; c=relaxed/simple;
	bh=gVs9TltlfvlbPS6pchAruXLjHIcKiTDXXea0mfzMVtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeKJfMOtd3vSpkKUULwNrC0SI1H6+vaIE9LJT6ympfzmUMYKeAiuJVyRpaI27j5nNPTHezcdrOtRIvNn1UTwrtYpEcsATAdJFsfq8sWzRIg6kTC9PWBMkZ563w1zT827obK2Uf4+9r17RHmFNlXX6flE/74hBtVo2Y6J88MmKZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihr15zUN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebOKpLiH; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihr15zUN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebOKpLiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787749485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
	b=ihr15zUNgaSC9TFWJwRU0O5UOowXV9ocgUP77rN8cJYcuIW0MwT/HiE3V9o/6YFKUXaqgB
	ICVJedB9sHi//OSJr+Sxg0sfO/A4YztNQDe1BmqF4mu5aG7bA8y8MPH7P8/yfJJ8vJY/iw
	4V5Xmr1XBVJrQYJo7O8hi1CdE03nqaU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-872CFat1Mfip0K0DKN4Mhw-1; Wed, 26 Aug 2026 09:04:44 -0400
X-MC-Unique: 872CFat1Mfip0K0DKN4Mhw-1
X-Mimecast-MFC-AGG-ID: 872CFat1Mfip0K0DKN4Mhw_1787749483
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7354dso1432806a91.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 06:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787749483; cv=none;
        d=google.com; s=arc-20260327;
        b=N8Skjrp0wNxk2d1pKbSymM413RJeX8D7CXii66i7DjGeIJnG0uIufgT03Zn5tO0huQ
         Jr61C1EM3/bRii77KNvXLj5f7YctcUf7p0/F6k2Xdqut6R1IOl0dzyE4r3apX998fiW1
         l0U4D9FNAi1tmKfGfk5cIz13Mbad+cjhGAT7A5Smg0i7ZS6jWZ6br4qZ6GSrSWVihNN9
         MDxietU0X1dgSfuU5ElOID8HHiKFO8AgyGfGJTloQUsTs22Teui36jbhHBpwDUfdbxph
         vpIp+yXgJCUAPsM8Cc+c4GYZy1Xn6xkcDnOV2T1+cRXmXMi3hrOInmJ+PhEt1fEzkomK
         tOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
        fh=LkIH/Il91EIW/WlxzbXdp8qvNNb8q6VAJzxTQYw7jbg=;
        b=FttSXITqblVDX/xHwaNeJddvLt+Vs/FZvzdQ/ST40jZNzaKSVjauRYr2G+tQjnLqHM
         3fki0R87C6gAvU7zsoyH1Qet5adtQoGbwDW8O4p4PT4HZNvgNdtttgTky3SaM/lBl4FP
         l/+tbP+j2WZQrG4tYJxPNKdqGc5ZR0MdqNrVbJmR0lM14GG4cJEK75vmLrF8pkEBFoLb
         nAgiu0SyIZGhoLLOW62uMLOEcN0LmJCM9Pco9SA5tacqC4EbhdOGtNP8m2FGpvFGap1h
         8Mr08te/5gwi85wt7g3iGVfbK5Fx+Hpd9ClH6i2WSshjKqSLxw8n2X/th9fgFbD0Z1X7
         +gkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787749483; x=1788354283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
        b=ebOKpLiHQXe9ZBNZMeRKFHGzbhTTSyGfDjABECtmEG34rrYEMrmU/AdkXUfniihYdA
         735pyXpQsERXFJTcUAy12HPFyKMyC9Lx71GEEXQoNnearYa/5zukK5drsIN0QaFvQLp7
         hkT8Vi9OSNXJYH8vuiVLoF1xZup7i7ELEhsmDnjv04NaEPIj0yRtIhLWCvUDXhooFPqR
         xCm8/WYfbndnEVh6288DFMX2aLY6J/H54ERIjbdXYdSFYuA17hOAl3kBnuNPdXQcbzyG
         +3V0YT1UZZUOgg/y2Fy+EyC+yygou2N3CM1jvevUD5XhU5xUei0ZYWtFcWu+Rp4b7Qjo
         sfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749483; x=1788354283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oYVc9rcGEnzzR41SIfmJfIkt0WWDTdKBFsBRE9m9Ol0=;
        b=ffr6m4V85E1DmTnDvXoVYzG4mm/L4XKw1mekBCCqjX0wqQRowmqNVOHR2eG8JPQ54o
         1DBfThvUJvb9o9YSK/Lj7HRmJmsr1u/kJYZbA+CZFR+S+tGDSb6Z+eEz9p3UlzruRKHQ
         xEPzv7JkzkYIQnn4dX6UTOtrBd9qy4mifNcfH8kK/06eLXwXqiYd0TwT0IK9dFd4kkBC
         R551Fo/BOxWeVsKEdng1qVbIqUhVIKZWiZ4j/oP+y0OptzmxiTMOXIKOBB7lwd0T775H
         aAnIT2RlPcqnYxHIHYrptTLC6MAlZ71Mz3QtH0GTVhkI4CsunsWQdOyvsTUoeEWbUsQ6
         iGMw==
X-Forwarded-Encrypted: i=1; AHgh+Rp6P2X0WBnuUwGPpbgqFuWG7/mmYrZmxDt2SMswJ67SSij2uzCdXPk4qQWzUC38t9dM5c8=@vger.kernel.org
X-Gm-Message-State: AFuF++noy4MN1CLQ+JU5wm1Y72n5kAiSm6+xHztxHSCyISZ8GeU0HKnI
	4N0+37NU1Nf6aUQQwT2TKOE9zYYeAz/+1N/Mc1SkBk4OLolAOxebUs7dysT0HpFYtjNX6QZVvAI
	gSyk87ssdQ5LQ70L9kkMZHEmHsp7KaCuLtpYIMLcHd+UwD3d0gnZLE/JFuBGYoQ0aGLDdwUxUql
	8inL12ncuiPWygwB7MwyTCFwdV6bBg
X-Gm-Gg: AR+sD10Kj5GRZvurwm9iABkxxRjaxyHVw5lITQx+ZnxGz6kMrKIqE8TDt7nmCrB26RI
	SoKX2aEFV3+ZhDdi2964ycYJSRNjBP+iERZojXrlReZQtiixISSPxtk+ld2k8tge/YG+rXcGNPr
	pBb6AWerGfPqi0Lu/GwUbkdLihsS6Kodpj0jv7wa2g2br5M3xdext2dPI4QeV1jmKJnayI4Iur+
	ydztwWr7kzhVtg98ytnzSt25INpYR1uNwm0cHFyhtl2fP3G+DRGM4rjtxojfePZM+cPUsyxKGS5
	6A==
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id 98e67ed59e1d1-3966d9e5ecfmr14606896a91.15.1787749482476;
        Wed, 26 Aug 2026 06:04:42 -0700 (PDT)
X-Received: by 2002:a17:90b:5107:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-3966d9e5ecfmr14606542a91.15.1787749481523; Wed, 26 Aug 2026
 06:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com> <ao6pyiBkHZJz_9JR@redhat.com>
 <CAMxuvaz+85Pw=sZG2jXL5jJ_2=kkR5_P69-AZ6bzhVbGTA+5Xg@mail.gmail.com> <ao65_XCKmkpm9s2F@redhat.com>
In-Reply-To: <ao65_XCKmkpm9s2F@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 17:04:29 +0400
X-Gm-Features: AcwNN1UokCmDa7kHDxB9ZTq3xrLUmyLSJ7h0c4jfatvRCC3sSrStOXkF7y4zowA
Message-ID: <CAMxuvayGzQtu1COC5G1D+CKZuXmhCeDV5fZMvYtiK95eMh+i3A@mail.gmail.com>
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

On Wed, Aug 26, 2026 at 2:04=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Aug 26, 2026 at 01:41:55PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Aug 26, 2026 at 12:54=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> > >
> > > On Tue, Aug 25, 2026 at 11:09:43PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> > > > monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changi=
ng
> > > > the first parameter from Monitor * to MonitorHMP * to enforce type
> > > > safety. The implementation is also simplified: monitor_hmp_vprintf =
now
> > > > directly calls g_strdup_vprintf + monitor_puts, removing the virtua=
l
> > > > dispatch via moncls->vprintf.
> > > >
> > > > The dev_print() callbacks are temporarily using the MONITOR_HMP(mon=
)
> > > > cast, they are fixed in the following commits.
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  audio/audio-hmp-cmds.c                  |   6 +-
> > > >  backends/cryptodev-hmp-cmds.c           |   9 +-
> > > >  block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
> > > >  chardev/char-hmp-cmds.c                 |  12 +-
> > > >  disas/disas-mon.c                       |  10 +-
> > > >  docs/devel/style.rst                    |   2 +-
> > > >  docs/devel/writing-monitor-commands.rst |   8 +-
> > > >  dump/dump-hmp-cmds.c                    |   5 +-
> > > >  hw/char/virtio-serial-bus.c             |  10 +-
> > > >  hw/core/machine-hmp-cmds.c              | 213 +++++++++++---------=
--
> > > >  hw/core/sysbus.c                        |   5 +-
> > > >  hw/hexagon/hexagon_tlb.c                |  44 ++---
> > > >  hw/i386/kvm/xen-stubs.c                 |   6 +-
> > > >  hw/i386/kvm/xen_evtchn.c                |  21 +--
> > > >  hw/i386/sgx-hmp-stub.c                  |   3 +-
> > > >  hw/i386/sgx.c                           |  29 ++-
> > > >  hw/misc/auxbus.c                        |   9 +-
> > > >  hw/misc/mos6522-stub.c                  |   3 +-
> > > >  hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++--------
> > > >  hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
> > > >  hw/pci/pci-stub.c                       |   3 +-
> > > >  hw/s390x/s390-skeys.c                   |   9 +-
> > > >  hw/s390x/s390-stattrib.c                |  20 +--
> > > >  hw/uefi/ovmf-log.c                      |   5 +-
> > > >  hw/usb/bus.c                            |  11 +-
> > > >  hw/usb/host-libusb.c                    |  21 ++-
> > > >  hw/virtio/virtio-hmp-cmds.c             | 297 ++++++++++++++++----=
-----------
> > > >  hw/xen/xen-bus.c                        |   5 +-
> > > >  include/disas/disas.h                   |   4 +-
> > > >  include/monitor/hmp.h                   |  12 +-
> > > >  migration/dirtyrate.c                   |  46 +++--
> > > >  migration/migration-hmp-cmds.c          | 301 ++++++++++++++++----=
------------
> > > >  monitor/hmp-cmds.c                      | 141 +++++++--------
> > > >  monitor/hmp.c                           | 143 +++++++--------
> > > >  monitor/monitor-internal.h              |   6 -
> > > >  monitor/monitor.c                       |  33 ++--
> > > >  net/net-hmp-cmds.c                      |  31 ++--
> > > >  net/slirp.c                             |  31 ++--
> > > >  qom/qom-hmp-cmds.c                      |  27 ++-
> > > >  replay/replay-debugging.c               |   5 +-
> > > >  stats/stats-hmp-cmds.c                  |  57 +++---
> > > >  stubs/hmp-cmd-info_sev.c                |   3 +-
> > > >  stubs/monitor-core.c                    |   2 +-
> > > >  system/dirtylimit-hmp-cmds.c            |  10 +-
> > > >  system/qdev-monitor.c                   |  19 +-
> > > >  system/runstate-hmp-cmds.c              |  16 +-
> > > >  system/tpm-hmp-cmds.c                   |  29 ++-
> > > >  target/i386/cpu-apic.c                  |   3 +-
> > > >  target/i386/monitor.c                   | 152 ++++++++--------
> > > >  target/i386/sev.c                       |  35 ++--
> > > >  target/m68k/monitor.c                   |   3 +-
> > > >  target/ppc/monitor.c                    |   3 +-
> > > >  target/riscv/monitor.c                  |  55 +++---
> > > >  target/sh4/monitor.c                    |  29 ++-
> > > >  target/sparc/monitor.c                  |   3 +-
> > > >  target/xtensa/monitor.c                 |   3 +-
> > > >  tests/unit/test-util-sockets.c          |   2 +-
> > > >  tools/qemu-vnc/clipboard.c              |   4 +-
> > > >  tools/qemu-vnc/stubs.c                  |   2 +-
> > > >  trace/trace-hmp-cmds.c                  |  12 +-
> > > >  ui/ui-hmp-cmds.c                        | 115 ++++++------
> > > >  util/error-report.c                     |   2 +-
> > > >  util/qemu-print.c                       |  11 +-
> > > >  63 files changed, 1219 insertions(+), 1327 deletions(-)
> > >
> > >
> > >
> > >
> > > > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > > > index 5d4143d425a1..5938f2b6c338 100644
> > > > --- a/util/qemu-print.c
> > > > +++ b/util/qemu-print.c
> > > > @@ -13,6 +13,7 @@
> > > >  #include "qemu/osdep.h"
> > > >  #include "monitor/monitor.h"
> > > >  #include "monitor/hmp.h"
> > > > +#include "qom/object.h"
> > > >  #include "qemu/qemu-print.h"
> > > >
> > > >  /*
> > > > @@ -23,8 +24,13 @@
> > > >  int qemu_vprintf(const char *fmt, va_list ap)
> > > >  {
> > > >      Monitor *cur_mon =3D monitor_cur();
> > > > +
> > > > +    /* for all monitors: QMP & HMP */
> > > >      if (cur_mon) {
> > > > -        return monitor_vprintf(cur_mon, fmt, ap);
> > > > +        /* don't use monitor_cur_hmp(), to avoid a second lookup *=
/
> > > > +        MonitorHMP *hmp =3D (MonitorHMP *)
> > > > +            object_dynamic_cast(OBJECT(cur_mon), TYPE_MONITOR_HMP)=
;
> > > > +        return monitor_hmp_vprintf(hmp, fmt, ap);
> > >
> > > This isn't the same semantics AFAICT.
> > >
> > > Original code, if monitor_cur() =3D=3D QMP, we call monitor_vprintf()
> > > which will return -1.
> > >
> > > New code, if monitor_cur() =3D=3D QMP, we will get a NULL back from
> > > object_dynamic_cast which we then pass into monitor_hmp_vprintf
> > > which will then crash on monitor_puts() IIUC.
> >
> > monitor_hmp_vprintf() has an early return, if given NULL monitor, it re=
turns -1.
>
> Hmm, I feel like we should be dealing with NULL in this method, as it
> is surprising to be calling a monitor_hmp_XXX method in scenario where
> QMP is a (theoretical) possibility.

"hmp" would be NULL in that case, but I agree it's a bit confusing.

I would go as far and make hmp required for the call, but I can't
review all the code paths to monitor_hmp_(v)printf()
I'll add an early return in qemu-print.c

>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>

