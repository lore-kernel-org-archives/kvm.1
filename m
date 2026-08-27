Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFBE44BC94
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835399; cv=none; b=RudZwIiChmRlWjys/3dkhBpo3vPGCHI3WEfN4i1Z6JmpprvgKL2X19PIHDjSxdWbEraXiejBfw+zLU2bM61IxB4XulJGOrvrI1Y+2VPnN6NHXxP5hmRl0J7b5XveIaQW0lqcoztFLUh5dT4jtpecQQSeUeJlAeCsomTvT6n+WVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835399; c=relaxed/simple;
	bh=3w9kHwZpHqArYaNgcTmx7Sfp1JDCZZc50UYoEtZC50c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+PQYIruz6LOzx0YBTy0hRwg6MdHys4W+ekHuK6Gy1AKZPQ1dphBMS83vL3s3tye4R0RwX8NOuHABfNIL9S8n7ygOyiUhUd8LBfmfZYHXci+Hm7BhOWJzdLPUD7Rt6EOkjjiXxnF7O17HRVVRedm192Yj3PbPonQHag+2pLxyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f34A1TmS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f34A1TmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787835367;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=54KayOJzLDH0Va2lz6kNgaPxDQZ+bDW52CI0gZFnU7c=;
	b=f34A1TmSBLkxeiFBm7GeUCKAE0W00Rcr6YzLiCiNgsgk4vGaF3fIFZ1b9nE+cvRN3JaONO
	C1NwaL9kRKP4rZZo3QuWc6Ipi0Ul9T04zxb/63NcF2+THgHQM/cHaPrypcR26Zt6+qyXME
	XerkP4Y9UmDDgzuUEVaYIcvS287Bbus=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-agKZOUFPPv6q_Vq8uTpk-w-1; Thu,
 27 Aug 2026 08:56:04 -0400
X-MC-Unique: agKZOUFPPv6q_Vq8uTpk-w-1
X-Mimecast-MFC-AGG-ID: agKZOUFPPv6q_Vq8uTpk-w_1787835363
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E56CF180AEDF;
	Thu, 27 Aug 2026 12:56:02 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 669ED434;
	Thu, 27 Aug 2026 12:55:59 +0000 (UTC)
Date: Thu, 27 Aug 2026 13:55:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
	pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
	lorenzo.pieralisi@linaro.org, gshan@redhat.com,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC v2 18/24] hw/arm/virt: Disable DTB randomness for
 confidential VMs
Message-ID: <apAz3Ck1ybM9XntA@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
 <20260728192630.240375-19-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728192630.240375-19-mathieu.poirier@linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Tue, Jul 28, 2026 at 01:26:24PM -0600, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The dtb-randomness feature, which adds random seeds to the DTB, isn't
> really compatible with confidential VMs since it randomizes the Realm
> Initial Measurement. Enabling it is not an error, but it prevents
> attestation. It also isn't useful to a Realm, which doesn't trust host
> input.
> 
> Currently the feature is automatically enabled, unless the user disables
> it on the command-line. Change it to OnOffAuto, and automatically
> disable it for confidential VMs, unless the user explicitly enables it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  docs/system/arm/virt.rst |  9 +++++----
>  hw/arm/virt.c            | 41 +++++++++++++++++++++++++---------------
>  include/hw/arm/virt.h    |  2 +-
>  3 files changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
> index 5f6dd1797862..9882b842ddd5 100644
> --- a/docs/system/arm/virt.rst
> +++ b/docs/system/arm/virt.rst
> @@ -238,10 +238,11 @@ dtb-randomness
>    rng-seed and kaslr-seed nodes (in both "/chosen" and
>    "/secure-chosen") to use for features like the random number
>    generator and address space randomisation. The default is
> -  ``on``. You will want to disable it if your trusted boot chain
> -  will verify the DTB it is passed, since this option causes the
> -  DTB to be non-deterministic. It would be the responsibility of
> -  the firmware to come up with a seed and pass it on if it wants to.
> +  ``off`` for confidential VMs, and ``on`` otherwise. You will want
> +  to disable it if your trusted boot chain will verify the DTB it is
> +  passed, since this option causes the DTB to be non-deterministic.
> +  It would be the responsibility of the firmware to come up with a
> +  seed and pass it on if it wants to.
>  
>  dtb-kaslr-seed
>    A deprecated synonym for dtb-randomness.
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index fa6cd62a335c..65ed8573f8b1 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -401,6 +401,7 @@ static int gic_fdt_irq_type_spi(const VirtMachineState *vms)
>  
>  static void create_fdt(VirtMachineState *vms)
>  {
> +    bool dtb_randomness = true;
>      MachineState *ms = MACHINE(vms);
>      int nb_numa_nodes = ms->numa_state->num_nodes;
>      void *fdt = create_device_tree(&vms->fdt_size);
> @@ -410,6 +411,16 @@ static void create_fdt(VirtMachineState *vms)
>          exit(1);
>      }
>  
> +    /*
> +     * Including random data in the DTB causes random intial measurement on CCA,
> +     * so disable it for confidential VMs.
> +     */
> +    if (vms->dtb_randomness == ON_OFF_AUTO_OFF ||
> +        (vms->dtb_randomness == ON_OFF_AUTO_AUTO &&
> +         virt_machine_is_confidential(vms))) {
> +        dtb_randomness = false;
> +    }

Is there any valid use case for ON_OFF_AUTO_ON with RME ?

It feels like a miscnofiguration that ought to result in a fatal
error message, rather than booting with a VM config that cannot
be verified due to random measurement

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

