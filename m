Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD653E7BAA
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933226; cv=none; b=JWTXv+YcV4JZ/IV4h/vIc42vXDMsQmGDg3JoaAI1UcJNIHURu6n8IPfNaiffNAiA7OUREoubr5E9GB7KXgd7Gy+eBHFHLsfb0KAgW25aYHrGR/2u2TrzIZUNRKN2TS8/OBNt2s8e9wol6CNKhJXLorCYZTwDSdSaYBHnaeg7M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933226; c=relaxed/simple;
	bh=zm3tAB/r+pUyUEeY15vvxC3Q1bxcEk5XPR5ggKaT7t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB7WBophyO3/I8I4Ae/kxIrzo7EFcbA9mUocKzj8nDE1NaR+FcKdJe/sGWJwJHwZFhtsjrPQNJvAE+w5pJcWES19VZmjN8Ji+P3zY6Fhk0trqzVFtFm5IcS+zZhKGe6UjSy9OJMLriH2B+V8EjNTiSpE9TNuSd90OA1pk5RqjuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsAJGb2/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsAJGb2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780933224;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ojAXK1QVYXmOIiQXhBpS8DoBmVZqCzVm4Y03iZQHggM=;
	b=LsAJGb2/wxf0Z9RII97g3To4qP7clqCxy3S05hd7MpU7QQ+YYbflOcZpit6InqxymVhecM
	UqHLE0PhxZMoY1n0J0jn108QSvchTOhxmG+JUMqs1QufM9uVgMOLDXsACNEfI/u3ATRiCG
	g86soFHfSA9rqw2uc0Jxar6I/v5szVE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-5qYlzUWKNje-CfgPR6Ok0A-1; Mon,
 08 Jun 2026 11:40:22 -0400
X-MC-Unique: 5qYlzUWKNje-CfgPR6Ok0A-1
X-Mimecast-MFC-AGG-ID: 5qYlzUWKNje-CfgPR6Ok0A_1780933221
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FF791956053;
	Mon,  8 Jun 2026 15:40:20 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DA141954102;
	Mon,  8 Jun 2026 15:40:15 +0000 (UTC)
Date: Mon, 8 Jun 2026 16:40:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
	marcel.apfelbaum@gmail.com, zhao1.liu@intel.com, mst@redhat.com,
	cohuck@redhat.com, mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
	kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: Re: [RFC PATCH 00/10] QEMU Support for KVM Planes
Message-ID: <aibiXAlJtbZdGdHl@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jun 08, 2026 at 05:20:59PM +0200, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Hi,
> 
> here are the required QEMU changes to make use of the KVM Planes
> interface posted here[1].
> 
> The patches are based on QEMU v11.0.0 and can be used to launch an AMD
> SEV-SNP VM with COCONUT-SVSM + a Linux guest.
> 
> To make this work a change to the QEMU command line is required to
> tell QEMU which plane to target external IRQs to. this is done with
> the new device-plane property to the machine specification, e.g:
> 
> $ qemu-system-x86_64 \
>   -enable-kvm \
>   -cpu EPYC-v4 \
>   -machine q35,confidential-guest-support=sev0,memory-backend=ram1,igvm-cfg=igvm0,kernel-irqchip=split,device-plane=2 \
>   -object memory-backend-memfd,id=ram1,size=32G,share=true \
>   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1 \
>   -object igvm-cfg,id=igvm0,file=$IGVM_FILE \
>   ...

How are device-plane values intended to be chosen by the user ?

Is "2" a value that can/should always be used, or is there a dependency
on the igvm file, or somethihng else ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

