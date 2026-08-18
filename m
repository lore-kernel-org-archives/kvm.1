Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C1282F36
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051321; cv=pass; b=H6g4pjUyctzw8p8aKV82rcxKj3a0LDJOsHx6Mpeif4DD2rl6Uc7xP0BlyVGBRnH315spMrrrDAnn6+RBKjxmwWnsOYOcmevpztmgwukBkmGv1Nmhj6gXzm21zdKCV6oabxmNSAFwqnONesLBj+uu0TfUnyZglfC8wvPqkKnnzXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051321; c=relaxed/simple;
	bh=4viULYK9ISV3X3SGFs5KlxbLfvgF7cUDdXdoRuYAG1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVyLAFNofgZmZdMjIXn3e8MrWWo5mhCYCPbPyl1PwrWbU5fTjdNVgmfcWjy7PsperoFTKFUR9cikw8/YOZZp6WoFvcaxw192RW31OT9XEavzIkKs85WFit4oF46OzPPSqY6EDW8Xnt1Kmjj2uZF2JK2qMFBS8KSz5SnjOdieuaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cj8sarSL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=njtrrJ1l; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cj8sarSL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="njtrrJ1l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787051318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
	b=Cj8sarSLp14thCcpDqj/yO/kutr3vKuFSEd9FdXEn/YURiri0DXrKsX03ZOQOJckAvmt+E
	fzlyoSP9oxyMn9F6KjWiLEyc/chkRdOABVJi/dDPQVfl0rcspOu4IycPni4iOwXpEFNbyw
	/cIuDkTdZrBbvWF5ayk+lN1jKHZ+2Lo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-sY5VsPxNMXWG3j4d6kPEQw-1; Tue, 18 Aug 2026 07:08:36 -0400
X-MC-Unique: sY5VsPxNMXWG3j4d6kPEQw-1
X-Mimecast-MFC-AGG-ID: sY5VsPxNMXWG3j4d6kPEQw_1787051316
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so3182589f8f.0
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 04:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787051315; cv=none;
        d=google.com; s=arc-20260327;
        b=al9PzXzGNepQ2Ci9mHJUHcXDSPrfj2Lu4/B/oEIVsRiyNe3+I6+5Y1n8JBP/DeOqFk
         kYYdeDjr6N40364kuBwP+2rWKhKkbFuUmCevObkH123wPAsUYB0YuDVxZF+N6osVI8VH
         /9hLf23eJPigrtl/nldbcgrjqTVbnR1ZH/SPFr+a3cF3I1hu+/bC5oUAWo3R2nP6+eNA
         2oZHhL40BYBQuzbMZ1bswfrH1M7REr9scN9HRr/Wj8QdKKMNCH460GoN+XdEG74u1coh
         335a6BWl7nI1WDPAp6nEX0UirglfJpiuC65lETPYqEKoOYomVKuA1vCLN4YpXvjUA/j0
         iZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
        fh=RpXSJUOw8UnvHUifrCymw4kY6aZc0jT29GGNCD/jdhA=;
        b=eK+uorPP/0jKmBmuBEjdz3k2B3plbyk+rpqBXQKwfh7gciBVyT9mWWTpIrNS6iam7z
         khg9irMManNHb8VbVl/XbaKyVf1l2WNt6yiueZ8eu1gGO8JHDZTS99L/2kdFdvyY1+eW
         wq8q4eCJSLaM9rY0Akc2B+EQ//4lttDSYSVSBihqqpY5xE2PXFaBcRQJZrn2OOqUfS3h
         IoRENeHGH6fW+97q4jzO6yykkhUpNCHpvYNaiINFteV9J08r2SObT+WsFNbfnJ+Pz3pb
         ZbQUiWVlC3xApcM7J9WsmRmvOsKxIfBlmxbhyosuJMK94D6RFjA6JEjj/V/71coE0Z7d
         noBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787051315; x=1787656115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
        b=njtrrJ1lQ2HZV8eKhZIfdfOMU2hucSWZIiAeKrWDsm9yOAmy3ye1JY0aIFkf/gHa38
         ZQdgxAlkwUisZjALMhrP69f57Jt1IL+cFcwFfni1XyqM9OVfutrD2Q+VdvyREwyRJ5RW
         ODIvfSPz63NUAH+PTsOqtIh13gVRUolcPeTosuWT0pq8vekKo2hKYEcffYp6mb/ccSPf
         WEJzxVeLc6U9F1hDIsjWmqMNerA8kBYv90t2g9MBc9N3F7y6FFdAlsB+6FGFj7ekL1sM
         Bkmyg7mzLj953tiswxo8R2fPjA+DC4Kq6aSlk6UXv/qi7aHuK1/IMBVsQWKGDrvqIDlO
         AW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787051315; x=1787656115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHGG8oTIYJ9zWDoJOIGGBbWORkhUXayvRVhmaVsXNLw=;
        b=PnTmNLQ+PJNfEOulx7nEDC7J5ZForehU4jU6V3VTjNfGV0+0OpUJIRw1CYSK5qNYhe
         Ikfm6SDuthLs1GYQxzuqYXfCgn7XYmqxisWZ0kRF4IuE/x+Kxh4MZjZ8vEcLhS4oZ3Wm
         fzIS9MyH1hTHlt46g00HyiekRY80k0kFwSCKqhOmLkQowMdbkely3L3cuaWUyooJlHpM
         XEK8MiMZ6Yh5l2L7tyiks0d34UDtL1Qhqj8ocrnPk829XUTcUmpUWgkxjbDUkcojvlkJ
         nCBAfDiXlzicObd2iIfByaFHZbgQNvEDtaTUhaLaULFcVOfrF5nu4GallUMsHqelrkUd
         iTMA==
X-Gm-Message-State: AOJu0Yy9ZlMF3anD/n6kPBvW0QwIqzC+ImHaEzIGhGB0fKxsLl4LRGK2
	AQ2/p6pYHDjL1iiPPvHltGK6C9xcmy7aHrCLbl9AcRyT3qsxl8VCHi/FJrnZeRa9B9og5FhxK1Q
	pKIdB7bHhvotImXHSn35Xsc2+FYAW4uYs4gBqweaeZgvYptN4X0utKUXYY3JHMsmBc0LISXm1Qy
	yA5510X45GsFS3Rl4Bi20EKO7638WU
X-Gm-Gg: AR+sD12Bp0w2FLGNZSHh+ys8ZXCdOybcQsVu5AZFdwPLy5xV8fXPD5Fa+pKDqa5igas
	wBYFVZ9sTk5Y/FRqLMuzpbycj6ODXs0hCxMFIlZpRLORAAyQ1Wmho43U9SNC5uDNDjbuLbaq8BV
	grXBqBgiBVHjuZN4ZHHYHVC/TFabFmahA9j8CXCAi1gQw0xT6IcdJg06TzUCJAO6/S1c5NcUwAy
	HhbKwz+HE+8c2Mb49D8OL7BrmL6iRU5Umika8lW1Soz5m06sEFdae+9KuM=
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id 5b1f17b1804b1-49987971986mr470732425e9.10.1787051315298;
        Tue, 18 Aug 2026 04:08:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-49987971986mr470731715e9.10.1787051314884; Tue, 18 Aug 2026
 04:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814075049.223793-1-borntraeger@linux.ibm.com>
In-Reply-To: <20260814075049.223793-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 13:08:23 +0200
X-Gm-Features: AcwNN1VqT9BPc_oMjQ5yGwpZ-4wjOVBs2OoiaEOqIU4aOI7_4ztG1OMv3qk04ck
Message-ID: <CABgObfYx5gY1ZZjuc1OV8eAT1bZajv9vBwODveyNyOHn8nOs5Q@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: s390: Features and Fixes for 7.3
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Anthony Krowiak <akrowiak@linux.ibm.com>, Ciunas Bennett <ciunas@linux.ibm.com>, 
	Christoph Schlameuss <schlameuss@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Douglas Freimuth <freimuth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:51=E2=80=AFAM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> large chunk of s390 fixes and feature without patches as reply due to
> the large number. Series is on top of v7.2-rc2 but I merged
> kvms390/master to pick up additional fixes that came too late for 7.2.
> Of course also other patches/fixes directly on top. This automatically
> contains all the previous s390 fixes for 7.2, but this will reduce merge
> conflict potentials, so I see it rather on the plus side.
> I made the pull request statistics on top of rc7.
>
> sashiko reviews for the patches
> 1. Fixes for vfio-ap
> https://sashiko.dev/#/patchset/20260812200240.818004-1-akrowiak%40linux.i=
bm.com  without patch9
> https://sashiko.dev/#/patchset/20260806173435.105044-1-akrowiak%40linux.i=
bm.com
> 2. Fixes from Claudio
> https://sashiko.dev/#/patchset/20260812104436.109741-1-imbrenda%40linux.i=
bm.com without patches 4 and 9
> 3. vsie Fixes from Christoph
> https://sashiko.dev/#/patchset/20260807-vsie-cleanup-202607-v1-0-b18659b5=
5e3d%40linux.ibm.com
> 4. diag 9c tracing from Ciunas
> https://sashiko.dev/#/patchset/20260724103959.14861-1-ciunas%40linux.ibm.=
com
> 5. enable CONTEXT_ANALYSIS for cio and virtio from Heiko
> https://sashiko.dev/#/patchset/20260806153849.2622576-1-hca%40linux.ibm.c=
om
> 6. move KVM code to prepare for additional arm64 support
> https://sashiko.dev/#/patchset/20260812153631.3376090-1-seiden%40linux.ib=
m.com (patches12-21 only)
> 7. AI triggered fixes all over by me
> https://sashiko.dev/#/patchset/20260811153738.206885-1-borntraeger%40linu=
x.ibm.com
> https://sashiko.dev/#/patchset/20260805110455.7200-1-borntraeger%40linux.=
ibm.com
>
> --
> 2.53.0
>
> The following changes since commit feadc5e84dcb53422a437556c35af9efd9826f=
d5:
>
>   KVM: s390: Fix cleanup in kvm_s390_pv_create_cpu() (2026-08-03 17:09:46=
 +0200)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-7.3-1
>
> for you to fetch changes up to dd6f4ef6f8a37412909ad787c837332fb070159c:
>
>   s390/vfio-ap: Fix NULL deref in status_show() during queue probe (2026-=
08-13 16:04:33 +0200)
>
> ----------------------------------------------------------------
> KVM: s390: Features and Fixes for 7.3
>
> - merged kvms390/master to pick up additional fixes that came too late
>   for 7.2
> - Fixes for vfio-ap
> - Fixes for the gmap rework
> - Fixes for vsie
> - AI triggered fixes all over
> - diag9c tracing
> - code move preparation for the additional arm64 support
> - enable CONTEXT_ANALYSIS
> - update to vfio maintainer file location

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Anthony Krowiak (9):
>       s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_=
set_kvm()
>       s390/vfio-ap: Fix stale do_remove flag across iterations in vfio_ap=
_mdev_cfg_remove
>       s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for=
 NULL
>       s390/vfio-ap: Fix missing lock required to access list of ap_matrix=
_mdev objects
>       s390/vfio-ap: Fix required lock not held during update of ap_matrix=
_mdev object
>       s390/vfio-ap: Fix control domain removal in vfio_ap_mdev_cfg_remove
>       s390/vfio-ap: fix potential use of uninitialized apm_filtered bitma=
p
>       s390/vfio-ap: Fix hot-unplug skipped when last AP adapter or domain=
 removed
>       s390/vfio-ap: Fix NULL deref in status_show() during queue probe
>
> Christian Borntraeger (15):
>       KVM: s390: move some facilities from FACILITIES_KVM_CPUMODEL to FAC=
ILITIES_KVM
>       KVM: s390: Remove user triggerable WARN_ON
>       KVM: s390: Zero initialize data structures for inject_pfault_token
>       KVM: s390: Zero initialize irq in reinject_machine_check
>       KVM: s390: Fix memory leak in guest debug handling
>       KVM: s390: Fix old_data leak in guest debug error path
>       KVM: s390: Take srcu when importing watchpoint data
>       KVM: s390: Free guest debug data on vcpu destroy
>       KVM: s390: Fix length check __import_wp_info()
>       KVM: s390: Fix memory corruption by not reinjecting CK machine chec=
ks
>       KVM: s390: keyop: use mmu_lock to read gmap->asce
>       KVM: s390: vsie: zero stale crypto bits
>       KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
>       KVM: s390: Restore sigset on error path
>       Merge remote-tracking branch 'kvms390/master' into 'kvms390/next'
>
> Christoph Schlameuss (6):
>       KVM: s390: Remove double 64bscao feature check
>       KVM: s390: vsie: Remove duplicate assertion
>       KVM: s390: vsie: Convert shift to phys_to_pfn()
>       KVM: s390: vsie: Assert mcck_info offset in vsie_page
>       KVM: s390: vsie: Assert crycb alignment in vsie_page
>       KVM: s390: vsie: Create constant SCB_ALIGNMENT_SHIFT
>
> Ciunas Bennett (2):
>       KVM: s390: Refactor __diag_time_slice_end_directed for single exit =
point
>       KVM: s390: Add tracepoint for DIAG 9c directed yield operations
>
> Claudio Imbrenda (7):
>       KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key=
()
>       KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()
>       KVM: s390: Fix get_all_floating_irqs()
>       KVM: s390: Fix pgste_get_trylock_multiple()
>       KVM: s390: Fix IRQ injection with SIGP Stop and Store Status
>       KVM: s390: Fix kvm_s390_clear_pv_state()
>       KVM: s390: Fix potential tiny kernel stack leak
>
> Heiko Carstens (4):
>       MAINTAINERS: Update s390 specific vfio sections
>       s390/vfio_ccw: Add __must_hold() attribute to vfio_ccw_sch_quiesce(=
)
>       s390/cio: Enable CONTEXT_ANALYSIS
>       s390/virtio: Enable CONTEXT_ANALYSIS
>
> Steffen Eiden (10):
>       KVM: s390: Extract gmap tracing to a separate header
>       KVM: s390: Prepare include guards for a new location
>       KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
>       KVM: s390: Move kvm_host definitions to kvm_host_s390
>       KVM: s390: Move s390 kvm code into a subdirectory
>       KVM: s390: Move PGM code definitions to asm/kvm_host.h
>       KVM: s390: Prepare gmap for a second KVM implementation
>       KVM: s390: gmap: Make storage keys optional
>       KVM: s390: gmap: Make CMMA optional
>       KVM: s390: gmap: Make prefix handling optional
>
>  MAINTAINERS                                 |   8 +-
>  arch/s390/include/asm/kvm_host.h            | 723 +---------------------=
-----
>  arch/s390/include/asm/kvm_host_s390.h       | 729 ++++++++++++++++++++++=
++++++
>  arch/s390/include/asm/kvm_host_s390_types.h | 349 +++++++++++++
>  arch/s390/include/asm/kvm_host_types.h      | 347 +------------
>  arch/s390/include/asm/nmi.h                 |   3 +
>  arch/s390/kernel/nmi.c                      |   5 +-
>  arch/s390/kvm/Makefile                      |  11 +-
>  arch/s390/kvm/gmap/Makefile                 |   5 +
>  arch/s390/kvm/{ =3D> gmap}/dat.c              |  17 +-
>  arch/s390/kvm/{ =3D> gmap}/dat.h              |  21 +-
>  arch/s390/kvm/{ =3D> gmap}/faultin.c          |   3 +-
>  arch/s390/kvm/{ =3D> gmap}/faultin.h          |   6 +-
>  arch/s390/kvm/{ =3D> gmap}/gmap.c             |  19 +-
>  arch/s390/kvm/{ =3D> gmap}/gmap.h             |  25 +-
>  arch/s390/kvm/gmap/kvm_mmu.c                | 133 +++++
>  arch/s390/kvm/gmap/kvm_mmu.h                |  18 +
>  arch/s390/kvm/gmap/trace_gmap.h             |  47 ++
>  arch/s390/kvm/s390/Makefile                 |  14 +
>  arch/s390/kvm/{ =3D> s390}/diag.c             |  21 +-
>  arch/s390/kvm/{ =3D> s390}/gaccess.c          |   2 +-
>  arch/s390/kvm/{ =3D> s390}/gaccess.h          |   2 +-
>  arch/s390/kvm/{ =3D> s390}/guestdbg.c         |  11 +-
>  arch/s390/kvm/{ =3D> s390}/intercept.c        |   2 +-
>  arch/s390/kvm/{ =3D> s390}/interrupt.c        | 109 +++--
>  arch/s390/kvm/{ =3D> s390}/pci.c              |   2 +-
>  arch/s390/kvm/{ =3D> s390}/pci.h              |   0
>  arch/s390/kvm/{ =3D> s390}/priv.c             |   2 +-
>  arch/s390/kvm/{ =3D> s390}/pv.c               |   6 +-
>  arch/s390/kvm/{kvm-s390.c =3D> s390/s390.c}   | 159 ++----
>  arch/s390/kvm/{kvm-s390.h =3D> s390/s390.h}   |  10 +-
>  arch/s390/kvm/{ =3D> s390}/sigp.c             |   2 +-
>  arch/s390/kvm/{ =3D> s390}/trace-s390.h       |   0
>  arch/s390/kvm/{ =3D> s390}/trace.h            |  40 +-
>  arch/s390/kvm/{ =3D> s390}/vsie.c             |  22 +-
>  arch/s390/tools/gen_facilities.c            |  14 +-
>  drivers/s390/cio/Makefile                   |   2 +
>  drivers/s390/cio/vfio_ccw_drv.c             |   1 +
>  drivers/s390/cio/vfio_ccw_private.h         |   3 +-
>  drivers/s390/crypto/vfio_ap_ops.c           | 203 +++++---
>  drivers/s390/virtio/Makefile                |   2 +
>  41 files changed, 1703 insertions(+), 1395 deletions(-)
>  create mode 100644 arch/s390/include/asm/kvm_host_s390.h
>  create mode 100644 arch/s390/include/asm/kvm_host_s390_types.h
>  create mode 100644 arch/s390/kvm/gmap/Makefile
>  rename arch/s390/kvm/{ =3D> gmap}/dat.c (99%)
>  rename arch/s390/kvm/{ =3D> gmap}/dat.h (98%)
>  rename arch/s390/kvm/{ =3D> gmap}/faultin.c (98%)
>  rename arch/s390/kvm/{ =3D> gmap}/faultin.h (96%)
>  rename arch/s390/kvm/{ =3D> gmap}/gmap.c (99%)
>  rename arch/s390/kvm/{ =3D> gmap}/gmap.h (96%)
>  create mode 100644 arch/s390/kvm/gmap/kvm_mmu.c
>  create mode 100644 arch/s390/kvm/gmap/kvm_mmu.h
>  create mode 100644 arch/s390/kvm/gmap/trace_gmap.h
>  create mode 100644 arch/s390/kvm/s390/Makefile
>  rename arch/s390/kvm/{ =3D> s390}/diag.c (96%)
>  rename arch/s390/kvm/{ =3D> s390}/gaccess.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/gaccess.h (99%)
>  rename arch/s390/kvm/{ =3D> s390}/guestdbg.c (98%)
>  rename arch/s390/kvm/{ =3D> s390}/intercept.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/interrupt.c (98%)
>  rename arch/s390/kvm/{ =3D> s390}/pci.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/pci.h (100%)
>  rename arch/s390/kvm/{ =3D> s390}/priv.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/pv.c (99%)
>  rename arch/s390/kvm/{kvm-s390.c =3D> s390/s390.c} (97%)
>  rename arch/s390/kvm/{kvm-s390.h =3D> s390/s390.h} (98%)
>  rename arch/s390/kvm/{ =3D> s390}/sigp.c (99%)
>  rename arch/s390/kvm/{ =3D> s390}/trace-s390.h (100%)
>  rename arch/s390/kvm/{ =3D> s390}/trace.h (95%)
>  rename arch/s390/kvm/{ =3D> s390}/vsie.c (98%)
>

