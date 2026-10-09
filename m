Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198438C427
	for <kvm@vger.kernel.org>; Fri,  9 Oct 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791563461; cv=pass; b=PlzauPMDbcNpjsmeYLLjoT2wdti/GtH1eHtIVcrJWTGPx5as7BxGygHP2ClzyvzDCq+oxiMbZlG+WQialqix1sXtgPSzjYq5teO0KmAoCwpuTDulpqvxJPInuyoyKRN0f09XKfgZBERMxkoD+6Nf9rMvt/6Wcf9ROq+iNuhQMWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791563461; c=relaxed/simple;
	bh=oJjbZrkBVJ1PiPFEzs1/91v4GpF38orIAk8N5WksNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ey4DZDImjBjAfVb3dzmjHqSv7ps5zpbHV3Znm/d1Wdk9tXwzSiAyIgWXEchHYznBBNuOzUo3eAPt6+cHvDsDJbJ+brzI5iXj10oSs1JVFxSlJt18fo6Jxdd4wzWzDWei6I9MqCqyTsGZqGFVDxGKnzDODjzGAuJ/5tZmQHLtmnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5OcGEM3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6cxMOzt; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5OcGEM3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6cxMOzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791563458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
	b=K5OcGEM3LPY+AHoH4QSH7+St3AsATRPFeTf3cxMrjlr7Oxlf6Rwk3I98XN8gr8eUMn4akr
	pcTaku2F3242poJ25rbLFVRZOuNKy+A+JLep8o+rmnwtlgmhrwuuhQu1Lb31OGo0PiARDb
	MiTW1ZsanJL2D40/prWDsqkC0cugq6Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-D3XIU1E2PKqWJ86pps7Tmw-1; Fri, 9 Oct 2026 16:30:57 +0000
X-MC-Unique: D3XIU1E2PKqWJ86pps7Tmw-1
X-Mimecast-MFC-AGG-ID: D3XIU1E2PKqWJ86pps7Tmw_1791563456
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c427421f6so4366633f8f.2
        for <kvm@vger.kernel.org>; Fri, 09 Oct 2026 09:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791563456; cv=none;
        d=google.com; s=arc-20260327;
        b=GXpKIH4qp7a0rpxnnoAudfl3PeLocippfJOYu3R+R7NNE2IndT7setfwj9q12kXCuo
         hy+opBulBRludFuKxgLh5hDnXKoCVSO5Nl29kqZ+LWWyh08sg/xp1BWozSa3btO+bf3y
         oFt0yMFX67W3vGT/LyiFA861Bof2OW2p02TCooBcyyog0iJsMKsRlbtBwfgNS+8HVefn
         lamr/7uu/9eH+pM5W0RbMGauDcU615VGS/gHuf4sF70GT129NjXBt88RbEoV1D1whbDw
         29QQoFuuJoFk+fieETGV2ZU6g0WdA9gSro5YtSqIcTN5Wt8LECzKfgMXdwiP3b4oVGH9
         EB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
        fh=wxYUFGyHQr+FyYlGBQPPSwDluiV6Bl/d91x/FSX3JEI=;
        b=bgMdxwewJ0ZlxoXA48D2IUUlKfxa0Zn9tSlcgZrRaEo7mK31bGNMHIfQXW3d+T6cwF
         UapluGgRsSIe4tvi9QMjk++aauIv5MZsqmYdYbrF0awMomPwoJvIOIHIxdLtPGJziaGT
         Oxp13EPPAGWzXgv1swCjrdSlmZENLAzmY6qttgbSH2/ooiW98AB1gv/vCORXE8sN1VXb
         aTcB6ldZFyUdYuxtaFS8KPMHwvvK4XNfkUWuPJgG7i8HrFP+jNRku9AxyuuwePVInOyt
         NdYgyW7LKCLhQ+9HP/Hh5g6iMRTzKkyxn06wqjeQ2dalUKPRYO3/st7pk2RydteICFPg
         EpRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791563456; x=1792168256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
        b=b6cxMOztooTcomgO4+a9cO2hPSW5LgbijG7jmqmCCwIxAbe7wLyBcnikeuKvkg6I53
         OyfZURG2c/8Yv+pPMv2Q9Aryse0yXb2I96M2iiYm/NssMzUigIKfRwrRVwUAfMMxBjQM
         rF5NkJI3152Mdldf7uhdXOCpswcnsWQrDOt5zRwMnQSn6AcETNJnhXvmoRQBSsvTSbtH
         LuMT225Wja8xUXp4lLoGjzp8jw0G3VplarQXLVzlhHLCd9GAycqZCmBRMqtsipOuUSPV
         BP3iUgQVvlmQ0CZVQDUq1f7PWd2lr8ByvCpJS2a6wJIL333l8nBHW39qvGLSarGM/6N/
         0/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791563456; x=1792168256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XFfDLfmlRoV/l/3UJm8VRK6JJEgge8soAKSZV6yT34=;
        b=ZzKokaa1K2ym8L0jRq+8sLbxjgErGN2xaN3pQnJkYhT+MgcxNpb8j8cf9x/1Fnw0JM
         exR6aDOiFUejLBVwprQMOPyW15HAsd1gFtUB3juotPexQxCvT1rcc4B7c2IDESGu8MmN
         Dl0hpWmXhRuLqkV1I2Svfgm5sU1N0zzXV/ozrVgffGBi4pg27+9r9Vp0SXlNtBhjql9I
         lJhTd1e2LDfxHU+QqHfls/Xu6K6jJ96buhkpAdfeldJy/h3Yj+SAehspWbk36CGyexS3
         NMfjx7je0SdeLXCdqt34i9TtBhS0ygQCJKI3UN2ZH1irSULitzqjF1uMiZXsGq3HY4hp
         bQFw==
X-Gm-Message-State: AFq9FYJQuugDy2GKhntsfuVw3yOPyhZazX6OHb+Hqtd/YeAk0JWdsrzw
	iF2QLZgZKIsYu1Ccpq8kGv/6ERy2koiBJB8gfZqR1sd4/+dMsNZsNgkEH8LWZlNuqDz1Wre9+JG
	sCzJ3pFJTFw9ZKxSKuJMQ8HIBqDB+ZHlRCmJ/p9YepK6i5BaLdi0BDLqLRQ5/PbRTbARoewsoBK
	7IVMtekAdhM62LWPnHrh2GLBmNNRSF
X-Gm-Gg: AYBFou0xFO6gmmNoLARc7KNdlo0AcBs/3ZFt0GFVPCAng/RfBC8fF4LyNZH2/PWGT9x
	B+UZFmeea8IYo1kAuCh4kRTZ7n0mWbi7MtpG/Mw8XGvibqOFlWRAf9EFQAYTNXZbBgNmnP2E17V
	+JzTYAyHI4XTEO7rlLcLifU37z4CXbunoUo8pT3vzIW3eFwRmJ/wa5Cn23tilVqXGtP3KxQ1klX
	9s0T51jDlRbqf0jfpidK6zLNxNOVU7L5prK/JwuYWMkt+e1ZyUSs9/Zcqex7A==
X-Received: by 2002:a5d:5f48:0:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-48dba9c8d45mr5019882f8f.25.1791563455646;
        Fri, 09 Oct 2026 09:30:55 -0700 (PDT)
X-Received: by 2002:a5d:5f48:0:b0:487:6f2:1a4c with SMTP id
 ffacd0b85a97d-48dba9c8d45mr5019823f8f.25.1791563455214; Fri, 09 Oct 2026
 09:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009142749.186650-1-borntraeger@linux.ibm.com>
In-Reply-To: <20261009142749.186650-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 9 Oct 2026 18:30:43 +0200
X-Gm-Features: AclHuK83C4CDvo9EtkFIIQksf1QULcxw-SlHfNTwKc0Z9wirBe-7J2xrO1T1MY4
Message-ID: <CABgObfbqh3+ivyY2CXhy+ZWHg40Z9xQZPKys+2+TFsb+x89Q6A@mail.gmail.com>
Subject: Re: [GIT PULL 0/6] KVM/vfio: Use file-based reference counting for KVM
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Christoph Schlameuss <schlameuss@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 4:28=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
>
> Paolo,
>
> The following changes since commit df2908090cda368b01ff43709f51890076c561=
57:
>
>   Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-7.4-1
>
> for you to fetch changes up to c22295d0d75f5590fdde5493cb90e2d50d5f508e:
>
>   KVM: Remove unused file_is_kvm (2026-10-02 10:40:01 +0200)

Pulled, thanks.

Paolo

>
> The tag points to the vfio_file_reference branch of the kvms390 repo
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=
=3Dvfio_file_reference
>
>
>
> ----------------------------------------------------------------
> KVM/vfio: Use file-based reference counting for KVM
>
> This series switches the KVM-VFIO interface and external consumers over t=
o
> standard file-based reference counting, eliminating all external KVM symb=
ol
> exports.
>
> Currently, VFIO integrates with KVM by looking up kvm_get_kvm_safe() and
> kvm_put_kvm() dynamically using symbol_get(), manually tracking module
> reference counts and storing a put_kvm function pointer in struct
> vfio_device.
>
> In the ARM64-on-s390 architecture, a second concurrent KVM module
> (kvm-arm64) is introduced alongside native KVM to host hardware-accelerat=
ed
> ARM64 guests. Having exported global symbols (like kvm_get_kvm/kvm_put_kv=
m)
> creates symbol conflicts and prevents clean coexistence of two KVM module=
s.
>
> Additionally, the file based counting simplifies the code and reuses
> the existing fs refcounting.
>
> Instead of passing raw KVM pointers and managing module symbols manually,=
 the
> interface now passes the underlying VM file descriptor throughout VFIO an=
d
> associated architecture subsystems. To safely extract the KVM instance fr=
om a
> file, an architecture-namespaced helper mechanism is introduced that veri=
fies
> the file belongs to the expected KVM implementation before accessing its
> internal state. A back-pointer from the KVM instance to its associated fi=
le is
> maintained across its lifecycle so subsystems can safely acquire file
> references on demand. Finally, with VFIO, architecture page tracking, and
> device hooks converted to use file references, the remaining KVM referenc=
e-
> counting exports are restricted strictly to internal KVM modules.
>
> ----------------------------------------------------------------
> Steffen Eiden (6):
>       KVM: Introduce file_to_kvm_<arch>() infrastructure
>       KVM: Add file back-pointer to struct kvm
>       KVM: x86: Use file_to_kvm_x86() in SEV
>       KVM/vfio: Use file-based reference counting for KVM
>       KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM module=
s
>       KVM: Remove unused file_is_kvm
>
>  arch/s390/include/asm/kvm_host_s390.h |  4 ++-
>  arch/s390/kvm/s390/pci.c              |  9 ++++--
>  arch/x86/include/asm/kvm_host.h       |  2 ++
>  arch/x86/include/asm/kvm_page_track.h | 10 +++---
>  arch/x86/kvm/Makefile                 |  4 +--
>  arch/x86/kvm/mmu/page_track.c         | 22 +++++++++-----
>  arch/x86/kvm/svm/sev.c                |  8 ++---
>  drivers/s390/crypto/vfio_ap_ops.c     | 20 ++++++++----
>  drivers/vfio/device_cdev.c            |  2 +-
>  drivers/vfio/group.c                  | 13 ++++++--
>  drivers/vfio/vfio.h                   | 14 ++++-----
>  drivers/vfio/vfio_main.c              | 57 +++++++++++------------------=
------
>  include/linux/kvm_host.h              | 19 +++++++++++-
>  include/linux/vfio.h                  |  5 ++-
>  virt/kvm/kvm_main.c                   | 21 +++++++++----
>  virt/kvm/vfio.c                       | 13 +++++---
>  16 files changed, 132 insertions(+), 91 deletions(-)
>

