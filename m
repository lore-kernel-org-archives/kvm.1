Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094453AAF42
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 05:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785388342; cv=none; b=XpVce3/pdFxKdE6DVDFo499Nd8MswR9YLYUSJ1MrnOGNQERNstt+5ky4dgu4N1uQDxjqQoYuUEFdVC+tvgs5FfNDIwMjOe8YgAU61/W4OCdnKiN+C8D+MUGElJXmcwgjwR2qk2Vsk4tTDidOqsecj8M8jst65yRmkLC/A/SfKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785388342; c=relaxed/simple;
	bh=uLkTZ9LRMqNcz43KTjDdnCYMF+FfxoFiF+mcqAsvx7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LimRDVvtYLGHLDpRv9XjYD/+4kok4sSKsUFxKOB1POAQbnqu3e6VMCYOIpos1fmjqYndKCRVigTEiK+z1iYr60ipfOc6ryQiOxBQ46PI/TfGCs09TPCgMwifv5GclyCVIuC8psM3ZZgcvhNHpqnRp8t7uLChqYZ7Z/KmbxY3KXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jnVuQ+F1; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jnVuQ+F1"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1785388339; x=1816924339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uLkTZ9LRMqNcz43KTjDdnCYMF+FfxoFiF+mcqAsvx7g=;
  b=jnVuQ+F1jHLUtLWllCR/AUOWhCq+v2M5wWhW1jGj9vYXGlteGIBUpwXt
   lX6UaNVqlkHD24tjaH1iogUuf5aiTBeQSsB5IrxN3RwsYQUl3JLgVE36B
   /dHkuoH+zZjasb+ONQFHEvRkSzeR5WQX/y6HJFgBQizr/Ckz+I/rtO8bZ
   l5qY/3veDGREiY6qlc1CCtXphXobmiuwjhP8AAZ8Le0yZSv3HdBCuO5Jf
   Gv2nwqLhlKWb3xgVvOT2niRzstiLkXv2wLeekS6nTDIxaAGHCBib44oQR
   d5xPTiNUBPVw/QLHMIerXvVBNU/ar5lmHk9+ugbwWWqmnWR0dmblobOoM
   w==;
X-CSE-ConnectionGUID: RAAwftzoRBCgCHHxdvabGg==
X-CSE-MsgGUID: rdHRYsN+RkKDDZGzHfiULw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="227969845"
X-IronPort-AV: E=Sophos;i="6.25,193,1779116400"; 
   d="scan'208";a="227969845"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 14:12:11 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 5AC1942A30A
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 05:12:11 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 04C331892C61
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 05:12:11 +0000 (UTC)
Received: from FCCLS0092175.localdomain (unknown [10.8.194.125])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with SMTP id 9D0121400088;
	Thu, 30 Jul 2026 05:12:05 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:11:57 +0900
From: Kohei Enju <enju.kohei@fujitsu.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com, kchamart@redhat.com, 
	pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com, 
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, 
	lorenzo.pieralisi@linaro.org, gshan@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
	kvm@vger.kernel.org
Subject: Re: [RFC v2 00/24] Add Realm support to QEMU-VMM
Message-ID: <amrYWWyWlhnN2Fll@FCCLS0092175.localdomain>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>

On 07/28 13:26, Mathieu Poirier wrote:
> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME capable host using the following command line:
> 
> qemu-system-aarch64 \
>  -M confidential-guest-support=rme0 -object rme-guest,id=rme0 \
>  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> 
> It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> back.  It is compatible with Steven Price's v14 revision [1] of his work adding
> CCA support to KVM.
> 
> * We are currently working on rebasing the work to v15.
> 
> It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> here [2], along with the TF-A [3], RMM [4] and Linux kernel [5] for the SBSA
> machine (compatible with Steven's v14 patchset).
> 
> Instructions to compile and run the entire stack can be found here [6].
> 
> Device Assignment is not included.
> 
> Thanks,
> Mathieu

Hi Mathieu, thank you for your work on upstreaming CCA support. I've
tested this series in QEMU-TCG(x-rme=on) environments and confirmed
that the basic functionality works well.

I have a question about a QMP command for querying CCA capabilities.

Jean's tree contains the following commit adding such a QMP command. Was
this functionality intentionally omitted from this series?
https://git.codelinaro.org/linaro/dcap/qemu/-/commit/41f7852cc8590a38c47299a35a7238da09ff9a12

We are interested in adding this functionality because we are also
planning to upstream CCA support for libvirt, which will need a QMP
interface to query the CCA capabilities exposed by QEMU.

Since the Linux kernel dropped some configuration parameters such as the
hash algorithm, I need to rework the implementation of that QMP command
a bit. If it's okay with you, I'd be happy to send out the reworked
patch based on this series.

Thanks,
Kohei

> 
> [1]. https://lore.kernel.org/kvm/20260513131757.116630-1-steven.price@arm.com/T/#m06dd14216aaf76acab65b0a76fb84653141ea64f
> [2]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v2?ref_type=heads
> [3]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> [4]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v14?ref_type=heads
> [5]. https://gitlab.com/Linaro/cca-public/linux/-/tree/upstream-v2?ref_type=heads 
> [6]. https://gitlab.com/Linaro/cca-public/build-instructions
> 
> RFC v1:
> https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> 
> Changes for V2:
> - Fixed linux headers to include correct bit shift for Realm VM (Gavin).
> - Removed obsolete rme-guest options (Markus).
> - Set ConfidentialGuestSupportClass::kvm_init() to kvm_arm_rme_init() (Gavin).
> - Got rid of kvm_arm_rme_vm_type() (Gavin).
> - Used kvm_vm_check_extension() instead of kvm_check_extension() to avoid
>   error message when starting a Realm (Gavin).
> - Removed obsolete kvm_arm_rme_init_guest_ram() (Gavin).
> - Collected A-B and R-B.
