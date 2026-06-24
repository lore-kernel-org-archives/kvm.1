Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44644175A87
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782298067; cv=none; b=Wo/6TKbMY1i4WcVTRDSzCF85niF+kpMuOfY9tGasRDIXrxa55jbgSL3GGiTZpJmGyhvIOxL486SioYOr5N2RN0YzjMSPAoWyjQlOT1GcnnxplKUQXcGRb8th4EdGpELHSUZo6tOsK5qh51aqEGOxDd8GXuuo2iP6XYp7twya/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782298067; c=relaxed/simple;
	bh=5ga6Bg6Ft0CilD/kybwELS3njlqTEQrmbI9iTWkhhdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6xsHBL3hO25yY+0rxl7Kr5cAlAmPDvYdS9KQ9Z+f6zsjKBdE9o4rq+aIs6MW2o0SfNnpP8U45wwZtkYqYVFWus/OUtij7Ex7u3N0SmycuR/G1IgVJIU3ylcPRnVAn4NHi19v2TgMCCUo06I7wBLu2omiWXFX3G9s0rf/1B89Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hV7hoJW4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hV7hoJW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782298065;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=N8IrcjKVSGRrrQkxP5YIgWZCLBm8ejeVytx94BD743I=;
	b=hV7hoJW4b1QyYkY4mVHJjbNCJ3TvOIb+kUKun2p3N2JM9vJYGJ2o2dXamcUY0cIsx+EYWG
	FuuNJ+KpHxAkC0J0KykndwuTlyVqJIBdCK8ZsykOxMz5s2UYtxsBtMmtzj2vqlfV0cdVlF
	MbQ2LwfUIrseN7qVgiqzJOuu9dmmqT8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-Pa9kjjP7OOaViw0Uj39CTg-1; Wed,
 24 Jun 2026 06:47:39 -0400
X-MC-Unique: Pa9kjjP7OOaViw0Uj39CTg-1
X-Mimecast-MFC-AGG-ID: Pa9kjjP7OOaViw0Uj39CTg_1782298057
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7E1C18052EA;
	Wed, 24 Jun 2026 10:47:36 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.57])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F2B5180049F;
	Wed, 24 Jun 2026 10:47:29 +0000 (UTC)
Date: Wed, 24 Jun 2026 11:47:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
	Laurent Vivier <lvivier@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
	Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 8/8] MAINTAINERS: Add self as maintainer for PowerNV
Message-ID: <aju1vc-yqJoaK7CO@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-9-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623141933.577981-9-adityag@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Jun 23, 2026 at 07:49:33PM +0530, Aditya Gupta wrote:
> Add myself as maintainer for PowerNV machine, and remove the
> reviewer entry
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f63..67f65bff3913 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1646,7 +1646,8 @@ F: tests/functional/ppc64/test_tuxrun.py
>  
>  PowerNV (Non-Virtualized)
>  M: Nicholas Piggin <npiggin@gmail.com>
> -R: Aditya Gupta <adityag@linux.ibm.com>
> +M: Aditya Gupta <adityag@linux.ibm.com>
> +G: @adi-g15-ibm

Please drop the G: line, as I'm changing the approach for recording
this info to be more automatic.

>  R: Glenn Miles <milesg@linux.ibm.com>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
> -- 
> 2.54.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

