Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE6372EFB
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485572; cv=none; b=t4eN39Jg+QICug4x1PIhzxpwIlbWFFsN0mOBLxY2e9QKeRRNiOslh0jva6xxDAymPbRgTIUtuupYHIXSkBSHukacZ2JoLN2X+s0i1O7RM/3bKphdQ5XYjBYGn8SKSYVsDw044z7l8OCychHjli7cZGaaLW/IeHKNU3MgvHasQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485572; c=relaxed/simple;
	bh=sHXXWB845WPJrLPTFNR9NBA/keVU8uPgecXDOhnmfYQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qzb1vc/3s7Rnl633iKwPe7qzCqiCOIU/lEMSmpsWa6qLRRpKZ+Bb9KNtQVUPJbQoFeD6RRAuxt3Kz8P9WZlxHzxXFz3Xx5dHUgKj0sHgG1Mlqxvmj8vCN7KqVrYEJupKajcsTukLHeVcz9bRwS+rgLEfiCCQ4Mt13DMHijOqcvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NBtpc7SP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBtpc7SP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783485569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w4Ekd46QPzIIZodlDRUKm1+Yz6/Ujq9Nl3yMYyC6IOI=;
	b=NBtpc7SPiXzKBcHwXo5EzTUbK0H4uksG7ZC0lgGsnM5sgHA/wmQ7bLGhj4nbl+feBtbfPE
	UpjUQ2/9kAax+P4Nh/4LvRc/TzQZE8cZHOsJNJBg57PAPyKi5SGxVGndrZEyHcfOMJX+4p
	vipUSvcUkjl0+Vn+O4jLB1m+Je++Avg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-GDibruOIOk-YrioHuoovwA-1; Wed,
 08 Jul 2026 00:39:26 -0400
X-MC-Unique: GDibruOIOk-YrioHuoovwA-1
X-Mimecast-MFC-AGG-ID: GDibruOIOk-YrioHuoovwA_1783485565
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5CEB195604C;
	Wed,  8 Jul 2026 04:39:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D06C1800370;
	Wed,  8 Jul 2026 04:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2131121E6920; Wed, 08 Jul 2026 06:39:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: berrange@redhat.com,  kchamart@redhat.com,
  pierrick.bouvier@oss.qualcomm.com,  peter.maydell@linaro.org,
  mst@redhat.com,  cohuck@redhat.com,  pbonzini@redhat.com,
  eblake@redhat.com,  armbru@redhat.com,  jpb@kernel.org,
  lorenzo.pieralisi@linaro.org,  qemu-devel@nongnu.org,
  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [RFC v1 03/25] target/arm: Add confidential guest support
In-Reply-To: <20260707224306.1202330-4-mathieu.poirier@linaro.org> (Mathieu
	Poirier's message of "Tue, 7 Jul 2026 16:42:44 -0600")
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
	<20260707224306.1202330-4-mathieu.poirier@linaro.org>
Date: Wed, 08 Jul 2026 06:39:22 +0200
Message-ID: <87bjcim6x1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>
> Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> support the Arm Realm Management Extension (RME). It is instantiated by
> passing on the command-line:
>
>   -M virt,confidential-guest-support=<id>
>   -object rme-guest,id=<id>[,options...]
>
> This is only the skeleton. Support will be added in following patches.

Which of the patches add options?

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

