Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63D380FFB
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425581; cv=none; b=O0qOjyJN6o5R3fR35+kSw0SBL0Vww2XQXJQC+PpyWlsqykWjUB8WKA5bg7pES2qAddZbqGhMSnr3q/ufQj9VqQawqkeowntlhxCx8kxMZCUhpbrKRgXycvYHQBZdNHFOh7QKoNMsL6pfb4vc7SVPpAMI3uJQ5kNDrzDBJzXIqEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425581; c=relaxed/simple;
	bh=9II23brkyyHOrC6Pq++PN5yFMzgt+7LT3JlCNAYeV2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crq+pftomr0XrhiITMx+bdWWFa/55lWG+3aKz35dWxJZCkWyUKXwJ7rPEL+XdHkEWFjgC/rGvc0XnGBgU9wLVO9tu3RPLgRh4UP6gETJRdvWYBybN21yCkULWbPN0BCFM6nNvUkjvbZDkE68CHCR16omRJlPd2QK/LM68FcJHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCPuDC+M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCPuDC+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783425579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuq71xJ5asE4jVwi0HkVMtrKXwv7nVFrDDDac3COY+U=;
	b=aCPuDC+MDnlL0C6rc6/D+xPrP/YDmEDi7zY3dxACQEWXy7Pok5DMfS8DHzT89ZMAQVzpHG
	C6LADXvNsgiChDS35FULKnOclNaNHdZoFJlPjx8V6v77NiI5sXu+tmyFlCpBAMVYvj91a2
	MikrUzPBAQL21ovBMZXrfvMkWtaNJOU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-c9TMWa3MOqqLmxGLhu1iMQ-1; Tue,
 07 Jul 2026 07:59:34 -0400
X-MC-Unique: c9TMWa3MOqqLmxGLhu1iMQ-1
X-Mimecast-MFC-AGG-ID: c9TMWa3MOqqLmxGLhu1iMQ_1783425572
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44CC419540C9;
	Tue,  7 Jul 2026 11:59:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46DEB3691B;
	Tue,  7 Jul 2026 11:59:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, David Hildenbrand
 <david@kernel.org>, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, Christoph Schlameuss
 <schlameuss@linux.ibm.com>, Nina Schoetterl-Glausch
 <oss@nina.schoetterlglausch.eu>
Subject: Re: [PATCH v3 0/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
In-Reply-To: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
User-Agent: Notmuch/0.40 (https://notmuchmail.org)
Date: Tue, 07 Jul 2026 13:59:28 +0200
Message-ID: <875x2rj9i7.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Wed, Jul 01 2026, Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Update the kernel headers to get access to
> KVM_S390_VM_CPU_FEAT_ASTFLEIE2 and allow passing the feature through to
> guest on IBM z16 onwards.
>
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
> Changes in v3:
> - include linux v7.2-rc1 headers
>
> Changes in v2:
> - Isolate the linux-header update into its own commit (thanks Thomas)
> - Correct naming of the feature (thanks Hendrik)
> - Add S390_FEAT_SIE_ASTFLEIE2 to full_GEN16_GA1 only as it depends on
>   SIEF2 (thanks Christian)
>
> ---
> Christoph Schlameuss (2):
>       linux-headers: Update to Linux v7.2-rc1 with KVM_S390_VM_CPU_FEAT_ASTFLEIE2
>       s390x/kvm: Add ASTFLE facility 2 for nested virtualization
>
>  hw/s390x/sclp.c                                 |  2 +
>  include/hw/s390x/sclp.h                         |  4 +-
>  include/standard-headers/drm/drm_fourcc.h       | 54 ++++++++++-------
>  include/standard-headers/linux/ethtool.h        |  3 +
>  include/standard-headers/linux/pci_regs.h       |  2 +
>  include/standard-headers/linux/virtio_can.h     | 78 +++++++++++++++++++++++++
>  include/standard-headers/linux/virtio_console.h |  2 +-
>  include/standard-headers/linux/virtio_gpu.h     |  9 +++
>  linux-headers/asm-s390/kvm.h                    |  1 +
>  linux-headers/asm-x86/kvm.h                     |  2 +
>  linux-headers/linux/iommufd.h                   | 12 ++--
>  linux-headers/linux/kvm.h                       |  1 +
>  target/s390x/cpu_features.c                     |  3 +
>  target/s390x/cpu_features.h                     |  1 +
>  target/s390x/cpu_features_def.h.inc             |  3 +
>  target/s390x/cpu_models.c                       |  2 +
>  target/s390x/gen-features.c                     |  1 +
>  target/s390x/kvm/kvm.c                          |  1 +
>  18 files changed, 153 insertions(+), 28 deletions(-)

Thanks, applied.

