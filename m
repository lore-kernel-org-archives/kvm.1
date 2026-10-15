Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB44AA014
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050642; cv=none; b=ODb0DJxSNt+mH0R/aWLeP2MvFmFMzKUSRoD/ChVwvJfmK3tzZRlODE4pDGT1ykZyIvWZQKSF5HPg8A2kezn+c80xd/UQQcTx++UUCCrhM1pHcpEA4Gkez9nmTN51jQgfZ5h0UoLGXDS93EI9mNmowQw7ykS+6M09PtH9mv7eoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050642; c=relaxed/simple;
	bh=W8wHhgQ8HWC10azEaJHfaoYeToodRXXmqTiP+TUjQdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbguQR2F1VqdN/zRRUxEp2tG1w44dcAOgpE8XiixlFoHkZwfGXXDi71gitPqx2pOtcCN+KmspV4j/owiCxMsqfh7thWo3hiQOW43pgf4O3r1DY5+FohZyeJo+vemE5EBaX0iR98qKQKvQe8/lZ4DYqIJtPvsGCa4m44tqosHvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NuZkxfjU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuZkxfjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792050638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PghfsML8jnTYv8DI8s+0u/GZvRWVKuvCysJxTa3iKq4=;
	b=NuZkxfjUaUJckhh+/yzLB9uk/YGuXh9s8Jq9kqSSYmHkkP2t4WpoIK4CnqnrV873qbRqDb
	CiU1OmMil7nXNGIbddcLAG633+JirzHSkYo6tqFKj8tKrPKe+nnFUPqSf/SmtIynub1cVE
	irJtmTJEkZDXqADxYqJG7ehSJu+eGFw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-NnnXRRW4P4Cm88uauV-l-g-1; Thu,
 15 Oct 2026 07:50:36 +0000
X-MC-Unique: NnnXRRW4P4Cm88uauV-l-g-1
X-Mimecast-MFC-AGG-ID: NnnXRRW4P4Cm88uauV-l-g_1792050636
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F3D1944B19;
	Thu, 15 Oct 2026 07:50:35 +0000 (UTC)
Received: from nucbdw.ghoffman.csb.home.kraxel.org (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 585361956087;
	Thu, 15 Oct 2026 07:50:35 +0000 (UTC)
Received: by nucbdw.ghoffman.csb.home.kraxel.org (Postfix, from userid 11758)
	id 3B8E340785FB; Thu, 15 Oct 2026 09:50:33 +0200 (CEST)
Date: Thu, 15 Oct 2026 09:50:32 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
	Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
	"Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before
 launch
Message-ID: <atCFVaKiSIvz9uVS@nucbdw.ghoffman.csb.home.kraxel.org>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
 <as-gUPOHujXsPiWV@leonardi-redhat>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-gUPOHujXsPiWV@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

  Hi,

> gentle ping :)

Any update for the igvm command line patch which needs a doc update?
My plan is to bundle them all in one PR.

take care,
  Gerd

