Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB0471CFA
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268825; cv=none; b=N/BCB8UkVzPWBGPuvdu7Sh7s88nccvVd5cwNNv8y/4hcLH6GcP9NmbbQeG+XW9XrLElNGngCzA99cUnYBan0QMjKOWarsOLY/sm9l2PFMcLR3REu9QqbXFxAcbK/B0lu39LP8DhpezQuMFaPoqOJ8/UzK1oGUhOnukp0D361LSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268825; c=relaxed/simple;
	bh=PX3C104VdGlAaeDXmNxMdkdmwic9JMJf3Tx127kYd2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DMUDGWA3T51XaaI/W6xF3zkoHfWQZ+MNbZHRSzJVIf9COwAqEsNIGdh/054yfCxsYUPvCCu71Ipsp1l3f1ToS48+O29FFJgEx7MhFtosQmxzh6sWA3Em+m1kQw8btKIbZ/mbuI7qIJMyRP923PvTKCM2vFJksOOAlv143CiH1Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/VfdNHQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/VfdNHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788268822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26+D5MXwwk02WY5U6zB7de1//ugPlUVFcs7ZCwHdu5U=;
	b=b/VfdNHQuLGp9cXuY0Rrl0jGrFXR/608y75AhfDSVLTTKQ+SrVF5cHBRWQlgMd36CO+TRV
	I6gmmXbIR3hrF4eop07GyMOK1oIKilLHBOg89p3D0ECwalKdPNBCRQP4z34DBlpk2ajqjC
	qidyoO7lylcVWcdfv07btg6Vdg/KcvA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-MqMluuANOPWxR5y1MXAcqQ-1; Tue,
 01 Sept 2026 09:20:19 -0400
X-MC-Unique: MqMluuANOPWxR5y1MXAcqQ-1
X-Mimecast-MFC-AGG-ID: MqMluuANOPWxR5y1MXAcqQ_1788268817
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26AB61921EEE;
	Tue,  1 Sep 2026 13:20:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 528EE1955F2D;
	Tue,  1 Sep 2026 13:20:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id A55C321E682B; Tue, 01 Sep 2026 15:20:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com,  kchamart@redhat.com,
  pierrick.bouvier@oss.qualcomm.com,  peter.maydell@linaro.org,
  mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
  eblake@redhat.com,  lorenzo.pieralisi@linaro.org,  gshan@redhat.com,
  enju.kohei@fujitsu.com,  qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
  kvm@vger.kernel.org
Subject: Re: [RFC v3 00/24] Add Realm support to QEMU-VMM
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org> (Mathieu
	Poirier's message of "Tue, 25 Aug 2026 16:00:37 -0600")
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Date: Tue, 01 Sep 2026 15:20:13 +0200
Message-ID: <87wlt55cs2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> This patchset provides minimal functionality to start a Realm VM
> from an Arm RME capable host using the following command line:
>
> qemu-system-aarch64 \
>  -M confidential-guest-support=rme0,memory-backend=ram0 \
>  -object rme-guest,id=rme0,convert-in-place=on \
>  -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
>  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
>
> It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> CCA support to KVM.
>
> This revision is based on Michael Roth's work on guest memfd in-place memory
> conversion [2] and as such, the QEMU baseline is different from 'master'.  Other

Use

    Based-on: <20260528000416.8161-1-michael.roth@amd.com>

to document your base.  This stands out to humans, and is readable by
machines.  Next time :)

> than modifications to use in-place memory conversion from Lorenzo Pieralisi that
> were integrated to patches 04, 08-11, it is identical to V2.   
>
> It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> here [3],

Michael's series doesn't apply on master anymore, so I fetched this
branch.  It's based on master as of *May*.  This won't do.  Please rebase.

>           along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> with Steven's v16 patchset).  The Repository for the kernel [6] is available
> from Arm.
>
> Instructions to compile and run the entire stack can be found here [7].
>
> Device Assignment is not included.
>
> Thanks,
> Mathieu
>
> [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3?ref_type=heads
> [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> [6]. https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16?ref_type=heads
> [7]. https://gitlab.com/Linaro/cca-public/build-instructions
>
> RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
> RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html

