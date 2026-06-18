Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290F2FA0DF
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781813523; cv=pass; b=dZkWEuwg/MVPkQTiquVVtiX9NV+GaQbWtwCvkMITrLN0Cl3TUobYtLvh4Qvt3UaDNnAuPC1/qZkw+yieQHVsfs0KB7pJqVpVbxFfPa6vT/sFgcYhIfnCwBpFyVNnsEStEVn6+SzIN6RRpZK6DFTwjm6WmoSaMFbdL5x0lRQyHpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781813523; c=relaxed/simple;
	bh=MOnpWS2oaTCXhgYkDQHH246CQWEaG8Zx8s1ffl6k9pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apovobiaLxId3f4J9e2uIX4kR/rEWB/+MW1FQ8JHy6LcV8FWoW5rpHRXEBQX/4RVv2kiAeUBl9pMho5YgkiD85FgmvOUmn+Zk+sSq00+AH/QLdVm7Ahlil9ZjJRfO5kSM4XI/YmQGHH4sHEFYiJBE5YAUT0LK/qMx4r08sP6D8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImFrUnPd; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImFrUnPd"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bcdf8232fso3345653eec.0
        for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 13:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781813521; cv=none;
        d=google.com; s=arc-20240605;
        b=Im57WleBws5CMitcLyM7P4Dvna8tWLlTmC7AsZ0ylPtQScz1/XNZGk8FuK2Bc1qiym
         fNSRFRgKbgfGfWQTyYCVuwain4sioqYvpkYzsdwQLpttMv9E2GO72lT1mXrhOiMq4UB4
         2KdlXUl3+oc4p4/snFyCo/6Wml9KquhDcL9hmZuN0OtzFvzAk8WTD+ravVUN0sigjsI6
         MReKUQbgtr/b9uBG2Q6xXku7G+7PCKV0oqExETzt1uvuNdAA5f7GbAgdAFT+b29zgEuH
         JNdVMVdA4I1yzsN8ID1fGPUhTR4OVhl5Me5SEnqPwD8zR0n0hov8fLcnJ5fhwxsDaQF3
         /w2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5kYopXboz5kqOzIBlpvq52lfuCitZ+UkaPqUgkNm8aw=;
        fh=saWJfSSxTXdRQOkTAyrzLmMQjIl0bvSASuGEoQG5BQM=;
        b=GmgOTL/M2ttMZaORv40BQ3S5xB00yI1HEt9go1xEcTpgaBmb3UPxnbTrMuhfNsoJ0+
         pcx8LiLO/qKMv/d1U7KhsOqAdEO3/oYslb6Sei59H/zzI9ecKm1HiAs2hkiGlpEIfYKN
         evGXYJ3kJYXXCdREas9iTam7nVP+DQvB79NKAR4D86kqFdiNn6rVPJ/DVbV4XKyykwGC
         CpoggFh5KudyvpCZc3BE6DNVux1P37AG/bM+i2xVL5EiHHhhPuAs4AZNs4KJVnrzWP0m
         ran7egzA5YPCrPCDTHWVZVaWTq4MV1hW4LkgN+IW8xdRKPHI0kvtYp4Gcw8cllEEoHEx
         vNzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781813521; x=1782418321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kYopXboz5kqOzIBlpvq52lfuCitZ+UkaPqUgkNm8aw=;
        b=ImFrUnPdh8L2OQ+vEgoNy5cnoVncVY2LHORljh4cK4NUByn5D+cy0elzKlXWPb7RIY
         JRl8Dcqgxm6JPwCiE1t3ZqxSf1/mtUOoBBkELp2xbPVr9tc02ZZId+zwQ6FnPQM31PK7
         t+60J7fTKJQsZFdhd89AhhnmEwQz3GZFRfmumjgMhr1t/vjBXHlxZcLEKPaF2CqEmSK0
         t74cB8Q7Q3pfJp54YxpfCjBWf839hCtChboZw72clCG3dCgd3klDRZv7xFsnyNllha1J
         J22zzXAZkxsm1pZmkV1ebhnkBLHHDODLDwb6kzA5x0cCbOCHBgclJqAVM7xT56xzb+TD
         1V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781813521; x=1782418321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kYopXboz5kqOzIBlpvq52lfuCitZ+UkaPqUgkNm8aw=;
        b=dwRuVDkihlvzZgg+SmjOC5NqBqW25dN7ON+RQqxQ1nshIR6rK1BDnsMrH2tzkS+9z+
         HWuWtaLM53kwQIkY1NFqv1O4PHpJS3ui21qqp5eTwIw4Z7AP/op4VdGBEltmoTKdx0t1
         BLJmsyyzaILvcBbM72S6xNfDle+vOzwLqsmyDUHP2gfmBMsT128lARbFHDDXJzpWFEOR
         02qOTGB0YWK8EFpvvajwWb6D17eIH1c0fQNsdatu7rYHVehA1IRaK1aLDSFgVA14SadZ
         jbJvGtyQbsJq8MDygVt89RvXm4abUvphwhaTMqZyurrDSKhS0v6B2IasLPZtPpRTJNPM
         3/Qg==
X-Forwarded-Encrypted: i=1; AFNElJ+1e2okNPD9O+xJSaplcRxWyKjH0U7xTn+WWwr0lo0HhtJaAlbMK18+EPFwTGKnsdx1pdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsmnFp/jVGTKal7hBdHk3jfa3BHVUhVcW2ppFnY/TAggBXTQ/
	qzcV6bta2cv1uKTSSKoGlrqM0GBb6O5ZFM+BEeDEx+IrFS0M37yGIpbCKzDGOgkSYFVygLozluG
	sT4S2OU9nODOAbJOFLcF1ilFELjkR2pw=
X-Gm-Gg: AfdE7cnkmZaxk4013QeeKGsLe2Ez3BRqos2tu0LIe6hPuL6fyqtLwYMzjt23L7HzZ6+
	ZVcr6z/jUnS6zwaYIfipf9XDB4iSb1UPezRFqI6TkwJfP59siobutM/SP1/x2ZbzVGY3AFtULdZ
	6mPrr8Q7ILJ22Bg8P+lWnguzQU8hmUaG2gc21I3ql07ood4r5OBzrcyoSVgvsA6SV7r1UrhlH9T
	gq/BBcYICLZ2HEJY3Gx2plPhSIOZFEsONJFz31m3VwC1rcRBZskdSObeQICBxzgKkDwU4rp229h
	CUVOfj9fl6zPfi/TKSPf8E4lXjM+
X-Received: by 2002:a05:7301:678c:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30c06bfca99mr761091eec.0.1781813520818; Thu, 18 Jun 2026
 13:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
In-Reply-To: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Jun 2026 00:11:48 +0400
X-Gm-Features: AVVi8CegESbR6ZUD8SxLZ5ge_fQXIzH6szCQH4muF2WdxFR38w89t5-t2aW9E34
Message-ID: <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
	"Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, Fabiano Rosas <farosas@suse.de>, 
	Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	"Dr. David Alan Gilbert" <dave@treblig.org>, Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>, 
	Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 4, 2026 at 5:46=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> This is an attempt to fix the incompatibility of virtio-mem with confiden=
tial
> VMs. The solution implements what was discussed earlier with D. Hildenbra=
nd:
> https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.1865=
7-5-chenyi.qiang@intel.com/#3502238
>
> The first patches are misc cleanups. Then some code refactoring to have s=
plit a
> manager/source. And finally, the manager learns to deal with multiple sou=
rces.
>
> This has been tested together with the Linux kernel series from
> Zhenzhong Duan [1] for TDX guests.
>
> (help fix https://issues.redhat.com/browse/RHEL-131968)

Can the patch 1-11 be queued or are we missing something?
(RFC patch 12 can be dropped for now)

thanks

>
> v5:
> - explain why InterfaceClass in rust binding is not needed after
>   moving RamDiscardSource
> - drop extraneous added blank line
> - replaced a runtime "if (has_rdm)"" with an assert()
> - dropped "RFC: hw/virtio: start virtio-mem guest_memfd regions as
>   shared", in favour of start-private memory approach from "[RFC PATCH
>   0/6] Support virtio-mem memory hotplug in TDX guests" [1]
> - demote "monitor: add 'info ramblock-attributes'" as RFC
> - rebased and collected trailers
>
> v4:
>  - added "system/physmem: make ram_block_discard_range() handle guest_mem=
fd"
>  - added "monitor: add 'info ramblock-attributes' command"
>  - added "RFC: hw/virtio: start virtio-mem guest_memfd regions as shared"
>  - skip calling source in notify_populate (it may not have updated its
>    internal state)
>  - rebased, collected trailer tags
>
> v3: issues found by C=C3=A9dric
>  - fix assertion error on shutdown, due to rcu-defer cleanup
>  - fix API doc warnings
>
> v2:
>  - drop replay_{populated,discarded} from source, suggested by Peter Xu
>  - add extra manager cleanup
>  - add r-b tags for preliminary patches
>
> - Link to v4: https://lore.kernel.org/qemu-devel/20260504-rdm5-v4-0-bdf61=
e57c1e1@redhat.com
>
> [1]: https://lore.kernel.org/lkml/20260604093551.1511079-1-zhenzhong.duan=
@intel.com/
>
> ---
> Marc-Andr=C3=A9 Lureau (12):
>       system/memory: split RamDiscardManager into source and manager
>       system/memory: move RamDiscardManager to separate compilation unit
>       system/memory: constify section arguments
>       system/ram-discard-manager: implement replay via is_populated itera=
tion
>       virtio-mem: remove replay_populated/replay_discarded implementation
>       system/ram-discard-manager: drop replay from source interface
>       system/memory: implement RamDiscardManager multi-source aggregation
>       system/physmem: destroy ram block attributes before RCU-deferred re=
claim
>       system/memory: add RamDiscardManager reference counting and cleanup
>       tests: add unit tests for RamDiscardManager multi-source aggregatio=
n
>       system/physmem: make ram_block_discard_range() handle guest_memfd
>       RFC: monitor: add 'info ramblock-attributes' command
>
>  MAINTAINERS                                 |    4 +
>  qapi/machine.json                           |   56 ++
>  include/hw/vfio/vfio-container.h            |    2 +-
>  include/hw/vfio/vfio-cpr.h                  |    2 +-
>  include/hw/virtio/virtio-mem.h              |    3 -
>  include/monitor/hmp.h                       |    1 +
>  include/system/memory.h                     |  279 +-----
>  include/system/ram-discard-manager.h        |  358 ++++++++
>  include/system/ramblock.h                   |    5 +-
>  accel/kvm/kvm-all.c                         |    2 +-
>  hw/core/machine-hmp-cmds.c                  |   32 +
>  hw/vfio/cpr-legacy.c                        |    4 +-
>  hw/vfio/listener.c                          |   10 +-
>  hw/virtio/virtio-mem.c                      |  259 +-----
>  migration/ram.c                             |    6 +-
>  system/memory.c                             |   88 +-
>  system/memory_mapping.c                     |    4 +-
>  system/physmem.c                            |   27 +-
>  system/ram-block-attributes.c               |  328 +++----
>  system/ram-discard-manager.c                |  612 +++++++++++++
>  target/i386/kvm/tdx.c                       |    2 +-
>  tests/unit/test-ram-discard-manager-stubs.c |   48 ++
>  tests/unit/test-ram-discard-manager.c       | 1235 +++++++++++++++++++++=
++++++
>  hmp-commands-info.hx                        |   13 +
>  rust/bindings/system-sys/lib.rs             |    2 +-
>  system/meson.build                          |    1 +
>  system/trace-events                         |    2 +-
>  tests/unit/meson.build                      |    8 +-
>  28 files changed, 2569 insertions(+), 824 deletions(-)
> ---
> base-commit: 405c32d2b18a683ba36301351af75125d9afda08
> change-id: 20260414-rdm5-b6df2366d603
>
> Best regards,
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>
