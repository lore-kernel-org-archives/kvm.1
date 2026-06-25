Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2D37AA97
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376390; cv=none; b=mGrj4ethh7AaKCGm92o7BKZsxTI40R4PUSmdUjjBQmm1dvztxGPXr4EL1naKElvC3PR59mGilEgZoZgNAfWlF2z2lw12/AURzuW0s4wB8uHhreGU12lG3Cecd6qxYyjJS+PWN1MkmSkD7DvrXcz2jeSQFgF6osDXIj+PQCD5n4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376390; c=relaxed/simple;
	bh=n894yfp2xFYdiYmeDgSEUNXtb5dHmIr68kgfNYG6mLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slpQ1MajWuUneZ17elPGcRTWMDIu/JbQUSdzhUtSxeCVPPxwtMTTd32GSa18AeDrW9tqFJvqFDhejAPy39SdhPN8Ep6fNGvhrKSfqJdBpr1Zh0hnoLKOyiZCUvnuIbOg0xATr4dy5jP0zZaE3/ipZEpQD8Y5XU4jZsWHT9jSbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AbestJ1N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbestJ1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782376388;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQqNoEuB8Z87x4GVApUX90M7TlHPqfzGZvJ9FujVa2A=;
	b=AbestJ1NMEV4mV9e6zgUpWTdEhPzlAxQYJiY6H2xARob4KddOyhj1keFRp+z2sG7pXs0zz
	pxOHFPiNSkVb8ip6i76LCqAuiQqkZfqr1NFFrbu09Mt7hk7+Ks944l3DS/b0WcYX15NhnE
	jHH78S3ASX+5TP3UGzoTeSFuBf+N54k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-MUBvrgN4O2uRE5cgNOqcKg-1; Thu,
 25 Jun 2026 04:33:04 -0400
X-MC-Unique: MUBvrgN4O2uRE5cgNOqcKg-1
X-Mimecast-MFC-AGG-ID: MUBvrgN4O2uRE5cgNOqcKg_1782376382
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 858A1195604A;
	Thu, 25 Jun 2026 08:33:01 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.47])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB5561955F7C;
	Thu, 25 Jun 2026 08:32:54 +0000 (UTC)
Date: Thu, 25 Jun 2026 09:32:51 +0100
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
Subject: Re: [PATCH v2 4/8] tests/functional: Use default powernv machine
 instead of power10
Message-ID: <ajznoPrHDJEtVGCX@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
 <20260624195924.1422821-5-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624195924.1422821-5-adityag@linux.ibm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 25, 2026 at 01:29:20AM +0530, Aditya Gupta wrote:
> The default powernv machine has been recently changed to powernv11,
> though fadump functional test used powernv10
> 
> Change it to use default 'powernv' machine for the tests instead of
> being fixed to powernv10
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  tests/functional/ppc64/test_fadump.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|

