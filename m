Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0E359A6F
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912374; cv=none; b=YLVUQbw6y7Lnl8Dza2wzosEsOoeiLRrDKHnZcFE3GfFqvHstHLwKZVQPpR846X+llBGKN8AkN3BqbUi/8tpsVPH6k+Lzbh1usiDr1Cox/nczLAXUQHuWE37H9YbgLKcayVWgNSkuXgA+eL23wkPhLzdVnATjctMCPeePbF7H6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912374; c=relaxed/simple;
	bh=7YiIWDJAaoAoBFVGgax3f+J6lE2ynXOEXucv4QR+chA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh40iNDI9i4DC56uKU7poOjlse/Ylbzc2f2g1QHmTD6CtMapeiO6x69fsNkAApX9lxu7A8drNV8qN24cWNzvzdCcMBm/spDRVEBz6ER0YbcBz/o9x2Lc3aodYF3JDdDwrjTKjuOfJY+80ShccriZwWu4hVC+bvFzr60JiOb7t/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bWXYocUR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BKfqH4Kf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bWXYocUR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BKfqH4Kf"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SA7IBt2167554
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 10:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pLeDyIe24xlxelqivhxFI+C08k7EOIn3h4F7ph1yYvc=; b=bWXYocUR7lIQ3ijM
	MkRbBFMz9EUllcmW4xu06IRmgdGKC5WPDsG74Yfsle7hshzSrGIbru6eG/c2bdOa
	k7GiR59KOF19ty/CgkFYqcjtViq7c80KU1mptISveF51cvHLmMyj37kmwu41TcdB
	0bcvMj11qfFQIWNt5vCUpxmsLC+vZ4ZrQKPxq5ZGy74RtJ9NN/0t7nmwVZSyooXn
	Xsnt+m3X69kkVPuxQtlxJ+tyVcVWaNZEZhZdsfIX/kItHCav395xbk9sH+yJ43Bu
	sHZgvy+EPERUNxJ9XrVgIuFQ3fdHHSxuovxrDAoe4kvrflA5BOB6W0fwi3uc40ja
	scE5yQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb6h00h1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 10:19:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c01ff996dso9606751cf.2
        for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787912371; x=1788517171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLeDyIe24xlxelqivhxFI+C08k7EOIn3h4F7ph1yYvc=;
        b=BKfqH4KfmSruEhGNxAgL741LkoLKq3KieAKGlF6Ru+dUaqrhRY04sACycdAH5Vc4yK
         5EvLvGqeo7E/RvaZ70x0TCc7fGg+bLxeYPtdOHyC5z4M1ic7pV2f86a3zpKDpnMZN+MA
         PqR3Knfu25ls1wr+Bhdi4cyP61E+z+xljpRwsuH3uJ3ENoBK7bdqvp1CsCnKGod0axJM
         EJFaDMhVoJk9rKq3S1CUsqro8oZ9pSk/8ZQ1L/FshNQgf9JSWnbgKICCTI0VLcTM8lZr
         GUgTnC0+gsl5cJXueRoRKiSHIIL1aWNKN6ifO/yMssalPguo60WXJ3Brk3WGXg45At1A
         Ws8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787912371; x=1788517171;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLeDyIe24xlxelqivhxFI+C08k7EOIn3h4F7ph1yYvc=;
        b=D/kuAr9ArTbBKvyfcKsfe2OxTP48Mr1Ikx3TBoa5IxBeckwzPQQvUKSLAtnuc489Xm
         TJAqX8AHkXe/YlNWGJxrlHcBjh3cYQcixcm5KdE9Qs61vP4PN+Gq1PCxNnHmssecNWTB
         Ge/5ohJsPgZneH7hFaJ0W4jZmoRrQlo61FXrnmQ4y0t3KNugrc0q+RzS2LSIH7+PpI+9
         eIYFM8Nf4xrvWDH5AU2bf73pszEWjln0z5iackvTFlprad1CmLS8LJeRZSdn8aoVqU6G
         Xd1dhZLSp8H2yE5SMxyaxoAnmt09wRrtS7JKd7+5jnjxKO7DPslApZGrc1MZ3Y9Kc+uV
         NzKA==
X-Forwarded-Encrypted: i=1; AHgh+RpLTQZ07YVu2p5TlPiyVoX4iogSpQn1EkR+330zqvtS7thhPF6jc0bOmAB/Om2VwI9rYx0=@vger.kernel.org
X-Gm-Message-State: AFuF++l9KQwIxgz/IzH81UAns7XDbYfycB6jgOh6FC8l5N/DZH7gCIBK
	oGndJXhzlYDiUeki0uKQlUMIe8AG7zQ5bGyFPQVNjPtNZXHUqM9NCt3YLvDmhfBE61wyamGShKE
	AAFSXlHftF20VaaE2VGV2MGVARcMRhHEUHDiskhJELj3zsxxzrGZb9lI=
X-Gm-Gg: AR+sD12WPAGGx7u10Qk3qU8AN15rQ6rTpv6M/iKiGXLzaephbOe9HJkei02bjW1HC71
	QRXOqnjYszQbN5xlC67FFCjgM0yWBTFLBw0ojPPisD3ChZixEAp2N8/xvDncDkgt5bNDBgtQDxE
	+XzHKO6dgiJ7/CamJU5XUZnRdnodbi1TJyRNu4/OHZUeGbl/9Hn6X0o7LGnsMYvV9EwuaCujnne
	Sx75SeN1YvQlHvPU2iATobJqvSXnSGJendMvJm8VfzoP/nap+OgFob8b7F57Z1YU1qO3OdNpSbu
	Rqa4A3s31GHJq9t9C0NH87GVGASuysJBbZvrhUVRDq2GiaJiIc9U+/roIaJCDaDSyTnEvPp2vLq
	a0PhbXhZ5075MTZ9O7I6n9L7mvRwGiRi9/g==
X-Received: by 2002:ac8:5d13:0:b0:52e:2d4e:8eef with SMTP id d75a77b69052e-52fb93d6dcbmr61126581cf.4.1787912370554;
        Fri, 28 Aug 2026 03:19:30 -0700 (PDT)
X-Received: by 2002:ac8:5d13:0:b0:52e:2d4e:8eef with SMTP id d75a77b69052e-52fb93d6dcbmr61125891cf.4.1787912369979;
        Fri, 28 Aug 2026 03:19:29 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc1076sm39706795e9.3.2026.08.28.03.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 03:19:29 -0700 (PDT)
Message-ID: <deabd371-a764-4556-8f2e-15f0e50649b2@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:19:26 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 36/49] monitor: tighten monitor_printf*()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: dave@treblig.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Gonglei (Arei)"
 <arei.gonglei@huawei.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
        Brian Cain <brian.cain@oss.qualcomm.com>,
        David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Ilya Leoshkevich
 <iii@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Anthony PERARD <anthony@xenproject.org>,
        "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>,
        Fabiano Rosas <farosas@suse.de>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Weiwei Li
 <liwei1518@gmail.com>,
        Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu@processmission.com>,
        Yoshinori Sato <yoshinori.sato@nifty.com>,
        Artyom Tarasenko <atar4qemu@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
        kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
        xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-36-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: B983NYpS9qZCFImiFqjlfuvYW94yfUcr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX6kD50hixstwy
 sbjgZ4m8DnWxWWZMOEEk9NBbMep1Qw8Ceetqhgc+/PPwE78/FojEncbnD9p0rXGaPrTLp6z3pYR
 SwrtKa0sw+yavPjRKAdGF/fP+NhJIlc=
X-Authority-Analysis: v=2.4 cv=KPpqylFo c=1 sm=1 tr=0 ts=6a9160b3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=_7nI1AEwapyDFsg1MK8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: B983NYpS9qZCFImiFqjlfuvYW94yfUcr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4OCBTYWx0ZWRfX9Flvwbl7wtKJ
 6mF57rcRGNuM/C6eOfP5ZXfb4iBJdw37Z6LLKrAmH+Qi0nC6SOOGXvG/7UaT7tzPo22Tw5IeQwO
 JOT1Ntx6/3VovEz2pbmqV1n61dE18JHJ4bq5jhbu8UGjbNkq9mUs3p4XWfpJTECtKIm5YmNfalH
 5KiIAFtIw4/FJTbwWVaBD9qoaVvvUj32PISwiwYWcLp6tOgay2OiqgLVdOzKB98rJscxCpkjMtB
 SerPuuguHkbF8lt6e92awxo4+kC2KEjtuNt7wKyXQ4cCASzAI+hSc/fy+qsftapKQQd3qvKEPVn
 uK3zz/i8WWh2MA3bJ+3y18BnxZ8/0Yiu6+sYOjdVI9s+PkQRl3KJaRNFW0Ree6PKoljSi9VO82o
 1gCfAOgoE7nEn9pzcztA9KdjGMNkGYndmn6TfBazA5Yr3EzlL/ZZwkBB+27PeejBVGs3w00O3WO
 Ja9R5sFlIWbcywglwJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280088

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Rename monitor_printf->monitor_hmp_printf, monitor_vprintf->
> monitor_hmp_vprintf, and monitor_printc->monitor_hmp_printc, changing
> the first parameter from Monitor * to MonitorHMP * to enforce type
> safety. The implementation is also simplified: monitor_hmp_vprintf now
> directly calls g_strdup_vprintf + monitor_puts, removing the virtual
> dispatch via moncls->vprintf.
> 
> The dev_print() callbacks are temporarily using the MONITOR_HMP(mon)
> cast, they are fixed in the following commits.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio-hmp-cmds.c                  |   6 +-
>   backends/cryptodev-hmp-cmds.c           |   9 +-
>   block/monitor/block-hmp-cmds.c          | 170 +++++++++---------
>   chardev/char-hmp-cmds.c                 |  12 +-
>   disas/disas-mon.c                       |  10 +-
>   docs/devel/style.rst                    |   2 +-
>   docs/devel/writing-monitor-commands.rst |   8 +-
>   dump/dump-hmp-cmds.c                    |   5 +-
>   hw/char/virtio-serial-bus.c             |  10 +-
>   hw/core/machine-hmp-cmds.c              | 213 +++++++++++-----------
>   hw/core/sysbus.c                        |   5 +-
>   hw/hexagon/hexagon_tlb.c                |  44 ++---
>   hw/i386/kvm/xen-stubs.c                 |   6 +-
>   hw/i386/kvm/xen_evtchn.c                |  21 +--
>   hw/i386/sgx-hmp-stub.c                  |   3 +-
>   hw/i386/sgx.c                           |  29 ++-
>   hw/misc/auxbus.c                        |   9 +-
>   hw/misc/mos6522-stub.c                  |   3 +-
>   hw/net/rocker/rocker-hmp-cmds.c         | 146 ++++++++--------
>   hw/pci/pci-hmp-cmds.c                   | 114 ++++++------
>   hw/pci/pci-stub.c                       |   3 +-
>   hw/s390x/s390-skeys.c                   |   9 +-
>   hw/s390x/s390-stattrib.c                |  20 +--
>   hw/uefi/ovmf-log.c                      |   5 +-
>   hw/usb/bus.c                            |  11 +-
>   hw/usb/host-libusb.c                    |  21 ++-
>   hw/virtio/virtio-hmp-cmds.c             | 297 ++++++++++++++++---------------
>   hw/xen/xen-bus.c                        |   5 +-
>   include/disas/disas.h                   |   4 +-
>   include/monitor/hmp.h                   |  12 +-
>   migration/dirtyrate.c                   |  46 +++--
>   migration/migration-hmp-cmds.c          | 301 ++++++++++++++++----------------
>   monitor/hmp-cmds.c                      | 141 +++++++--------
>   monitor/hmp.c                           | 143 +++++++--------
>   monitor/monitor-internal.h              |   6 -
>   monitor/monitor.c                       |  33 ++--
>   net/net-hmp-cmds.c                      |  31 ++--
>   net/slirp.c                             |  31 ++--
>   qom/qom-hmp-cmds.c                      |  27 ++-
>   replay/replay-debugging.c               |   5 +-
>   stats/stats-hmp-cmds.c                  |  57 +++---
>   stubs/hmp-cmd-info_sev.c                |   3 +-
>   stubs/monitor-core.c                    |   2 +-
>   system/dirtylimit-hmp-cmds.c            |  10 +-
>   system/qdev-monitor.c                   |  19 +-
>   system/runstate-hmp-cmds.c              |  16 +-
>   system/tpm-hmp-cmds.c                   |  29 ++-
>   target/i386/cpu-apic.c                  |   3 +-
>   target/i386/monitor.c                   | 152 ++++++++--------
>   target/i386/sev.c                       |  35 ++--
>   target/m68k/monitor.c                   |   3 +-
>   target/ppc/monitor.c                    |   3 +-
>   target/riscv/monitor.c                  |  55 +++---
>   target/sh4/monitor.c                    |  29 ++-
>   target/sparc/monitor.c                  |   3 +-
>   target/xtensa/monitor.c                 |   3 +-
>   tests/unit/test-util-sockets.c          |   2 +-
>   tools/qemu-vnc/clipboard.c              |   4 +-
>   tools/qemu-vnc/stubs.c                  |   2 +-
>   trace/trace-hmp-cmds.c                  |  12 +-
>   ui/ui-hmp-cmds.c                        | 115 ++++++------
>   util/error-report.c                     |   2 +-
>   util/qemu-print.c                       |  11 +-
>   63 files changed, 1219 insertions(+), 1327 deletions(-)

Painful.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
