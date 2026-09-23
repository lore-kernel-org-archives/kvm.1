Received: from zero.eik.bme.hu (zero.eik.bme.hu [152.66.115.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA44EDCD3
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.66.115.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166780; cv=none; b=gFax4wW28HU45q459lh9FjYQql2HAxOV6ZlaSI4sg3nlm40ccu7kAIFbRvKqAUedzCc+tZCjuJVlwq38aOYV7E5h3/3nhIRG5x99bXE6Z4X57B1JDwcGxeBEJ5KwuvS3wvYuqXUYzsYI1t2+If3giIdJB2tXNL4bOv/LfriRz/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166780; c=relaxed/simple;
	bh=cVTAwsiZvELhMWf73ZDn7Z+av/PJWg6q6q8wbsMjCZ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hgZkfY1KbEhJZQYVLUY4SoQN6Tu60Jdfi2LSV4gMCUKduAwNTUfTKPP30AwihwX/s/yHehtaeVciLWxqBu+t3eBeZtB/FWt00mG5yBFuUStRb03Ryg1N+G6WOqlYsr/KjVWhUjjetrwTnN4oY1gHka1Xqa8Mz8LIToF2jPIPwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu; spf=pass smtp.mailfrom=eik.bme.hu; arc=none smtp.client-ip=152.66.115.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eik.bme.hu
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 69C04583223;
	Wed, 23 Sep 2026 14:26:58 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LyRLX1niaOFt; Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
	id 576AF5831F1; Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zero.eik.bme.hu (Postfix) with ESMTP id 5492F5831F0;
	Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
Date: Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
    Gerd Hoffmann <kraxel@redhat.com>, 
    Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
    Peter Maydell <peter.maydell@linaro.org>, 
    "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
    Nicholas Piggin <npiggin@gmail.com>, 
    Harsh Prateek Bora <harshpb@linux.ibm.com>, 
    Amit Machhiwal <amachhiw@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
    =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
    Peter Xu <peterx@redhat.com>, 
    =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
    Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Eric Farman <farman@linux.ibm.com>, 
    Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org, 
    kvm@vger.kernel.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH 04/88] qom: auto-terminate interfaces array in
 OBJECT_DEFINE_TYPE macros
In-Reply-To: <20260923-nohmp-v1-4-ebc029d4bd80@redhat.com>
Message-ID: <86b86d86-b2f8-2569-8754-0a229efa9364@eik.bme.hu>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com> <20260923-nohmp-v1-4-ebc029d4bd80@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-633698529-1790166416=:75141"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-633698529-1790166416=:75141
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 Sep 2026, Marc-André Lureau wrote:
> The DO_OBJECT_DEFINE_TYPE_EXTENDED macro requires callers to manually
> append a NULL sentinel to the interfaces list. Forgetting it causes
> out-of-bounds reads during type registration, leading to run-time
> crashes.
>
> Append an empty initializer in the base macro so the sentinel is always
> present, and drop the now-redundant manual terminators from all callers.

This is nice however another similar common list, the TypeInfo.interfaces 
still requires explicit NULL termination and now these are inconsistent 
which can also lead to people get confused where to add NULL element and 
where can it be omitted. Maybe we should consider adding a macro to make 
interface lists that adds the terminating element and use that everywhere 
or just stick to require explicit NULL at the end of interfaces list 
everywhere?

Regards,
BALATON Zoltan
--3866299591-633698529-1790166416=:75141--
